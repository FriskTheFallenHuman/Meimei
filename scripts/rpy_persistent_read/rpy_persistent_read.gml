// Copyright (c) 2022 Liu Wenyuan

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// Portions of this code are based on CPython source code.
// Copyright (c) 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,
// 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022 Python Software Foundation;
// All Rights Reserved
// See <https://wiki.python.org/moin/PythonSoftwareFoundationLicenseV2Easy> for license.

// Hacked together DDLC persistent reader (protocol 2)
// by Dobby233Liu
// works as long as DDLC don't update to a new Python version

// Copied from cPickle
// Stripped to Protocol 2, includes subset of opcodes from later protocols
global._pickle_opcodes = {
	MARK            : "(",
	STOP            : ".",
	POP             : "0",
	POP_MARK        : "1",
	DUP             : "2",
	FLOAT           : "F",
	INT             : "I",
	BININT          : "J",
	BININT1         : "K",
	LONG            : "L",
	BININT2         : "M",
	NONE            : "N",
	PERSID          : "P",
	BINPERSID       : "Q",
	REDUCE          : "R",
	STRING          : "S",
	BINSTRING       : "T",
	SHORT_BINSTRING : "U",
	UNICODE         : "V",
	BINUNICODE      : "X",
	APPEND          : "a",
	BUILD           : "b",
	GLOBAL          : "c",
	DICT            : "d",
	EMPTY_DICT      : "}",
	APPENDS         : "e",
	GET             : "g",
	BINGET          : "h",
	INST            : "i",
	LONG_BINGET     : "j",
	LIST            : "l",
	EMPTY_LIST      : "]",
	OBJ             : "o",
	PUT             : "p",
	BINPUT          : "q",
	LONG_BINPUT     : "r",
	SETITEM         : "s",
	TUPLE           : "t",
	EMPTY_TUPLE     : ")",
	SETITEMS        : "u",
	BINFLOAT        : "G",

	// Protocol 2
	PROTO       : "\x80",
	NEWOBJ      : "\x81",
	EXT1        : "\x82",
	EXT2        : "\x83",
	EXT4        : "\x84",
	TUPLE1      : "\x85",
	TUPLE2      : "\x86",
	TUPLE3      : "\x87",
	NEWTRUE     : "\x88",
	NEWFALSE    : "\x89",
	LONG1       : "\x8a",
	LONG4       : "\x8b",

	// Protocol 3
	BINBYTES       : "B",
	SHORT_BINBYTES : "C",

	// Protocol 4
	// 8-bytes not supported by GM rn
	SHORT_BINUNICODE : "\x8c",
	BINUNICODE8      : "\x8d",
	BINBYTES8        : "\x8e",
	EMPTY_SET        : "\x8f",
	ADDITEMS         : "\x90",
	FROZENSET        : "\x91",
	NEWOBJ_EX        : "\x92",
	STACK_GLOBAL     : "\x93",
	MEMOIZE          : "\x94",
	FRAME            : "\x95",

	// Protocol 5
	BYTEARRAY8       : "\x96",
	NEXT_BUFFER      : "\x97",
	READONLY_BUFFER  : "\x98",
}

// From https://forum.yoyogames.com/index.php?threads/endianness-aware-built-in-functions.94360/
function rpyp_pkl_is_native_little_endian() {
	static memoized_value = (function() {
		var buffer = buffer_create(2, buffer_fixed, 1);
		try {
			buffer_write(buffer, buffer_u16, 0x0005);

			var first_byte = buffer_peek(buffer, 0, buffer_u8);
			return first_byte == 0x05;
		} finally {
			buffer_delete(buffer);
		}
	})();
	return memoized_value;
}
// Based on https://forum.yoyogames.com/index.php?threads/reverse-a-string.33407/post-206775
function rpyp_pkl_read_bef64(buf, movecursor = true) {
	var fend, n = 8;
	if rpyp_pkl_is_native_little_endian() {
		var b1 = buffer_create(n + 1, buffer_fixed, 2);
		var b2 = buffer_create(n + 1, buffer_fixed, 2);
		buffer_copy(buf, buffer_tell(buf), n + 1, b1, 0)
		var i = n;
		while (buffer_tell(b1) < n) {
			var c = buffer_read(b1, buffer_u8);
			buffer_poke(b2, --i, buffer_u8, c);
		}
		buffer_seek(b2, buffer_seek_start, 0);
		fend = buffer_read(b2, buffer_f64);
		buffer_delete(b1)
		buffer_delete(b2)
	} else {
		fend = buffer_peek(buf, buffer_tell(buf), buffer_f64)
	}
	if movecursor
		buffer_seek(buf, buffer_seek_relative, n);
	return fend;
}

// escaped strings parsing is currently not supported
function rpyp_pkl_read_binstring(buf, startpoint, len, movecursor = true, escape = false) {
	if len == 0
		return ""
	else if buffer_get_size(buf) < (startpoint + len)
		throw "String length out of bounds";
	var _buf = buffer_create(len, buffer_fixed, 2)
	buffer_copy(buf, startpoint, len, _buf, 0)
	str = buffer_read(_buf, buffer_text)
	buffer_delete(_buf)
	if movecursor
		buffer_seek(buf, buffer_seek_start, startpoint + len)
	return str
}
function rpyp_pkl_read_line(buf, escape = false) {
	var startpoint = buffer_tell(buf)
	var endpoint = startpoint
	while (true) {
		if buffer_get_size(buf) <= buffer_tell(buf) {
			throw "Buffer exhausted while reading a line"
		}
		if buffer_read(buf, buffer_u8) == ord("\n") {
			endpoint = buffer_tell(buf) - 1
			break;
		}
	}
	return rpyp_pkl_read_binstring(buf, startpoint, endpoint - startpoint, false, escape);
}

function rpyp_pkl_from_decl(str, short = false) {
	if string_length(str) <= 0
		throw "Decimal long string too short"
	if string_char_at(str, string_length(str)) == "L"
		str = string_copy(str, 0, string_length(str) - 1)
	if short {
		if str == "00"
			return false
		else if str == "01"
			return true
	}
	// evil
	return round(real(str))
}

function _rpyp_pkl__builtin_object() constructor {
	__module__ = "__builtin__"
	__name__ = "object"
	__bases__ = []
	static __new__ = function () {
		// Waiting for a GM bug to be fixed
		/*var args = [];
		for (var i = 0; i < argument_count; i++)
			array_push(args, argument[i]);
		script_execute_ext(__init__, args);*/
		script_execute(__init__);
		return self;
	}
	static __init__ = function () {}
	static toString = function() {
		return __module__ + "." + __name__
	}
	static __setstate_special_a__ = function (state) {
		var keys = variable_struct_get_names(state);
		for (var i = 0; i < array_length(keys); i++) {
		    self[$ keys[i]] = state[$ keys[i]]
		}
		return self;
	}
	static __setstate__ = function (state) {
		return __setstate_special_a__(state);
	}
};
function _rpyp_pkl__builtin_tuple() : _rpyp_pkl__builtin_object() constructor {
	__module__ = "__builtin__"
	__name__ = "tuple"
	__bases__ = [_rpyp_pkl__builtin_object]
	__content__ = []
	__brackets_l__ = "("
	__brackets_r__ = ")"
	static __get_content__ = function () {
		return __content__
	}
	static __len__ = function () {
		return array_length(__content__)
	}
	static __getitem__ = function (key) {
		return __content__[key];
	}
	static __setitem__ = function (key, value) {
		__content__[key] = value;
	}
	static __delitem__ = function (key) {
		__content__[key] = undefined;
	}
	static __setstate_special__ = function (state) {
		__content__ = state
		return self;
	}
	__setstate__ = undefined
	static toString = function () {
		var str = __brackets_l__ + " ";
		var inside_str = ""
		for (var i = 0; i < array_length(__content__); i++)
			inside_str += string(__content__[i]) + (i == (array_length(__content__) - 1) ? "" : ", ")
		str += inside_str + " " + __brackets_r__
		return str;
	}
};
// bruh
function _rpyp_pkl__builtin_set() : _rpyp_pkl__builtin_tuple() constructor {
	__module__ = "__builtin__"
	__name__ = "set"
	__bases__ = [_rpyp_pkl__builtin_object]
	__brackets_l__ = "set(("
	__brackets_r__ = "))"
	// Waiting for a GM bug to be fixed
	//static __init__ = function() {
	//	for (var i = 0; i < argument_count; i++)
	//		__setitem__(i, argument[i]);
	//}
	static add = function(value) {
		array_push(__content__, value)
	}
	__setstate__ = function (state) {
		for (var i = 0; i < array_length(state); i++)
			array_push(__content__, state[i])
	}
};
function _rpyp_pkl__builtin_frozenset() : _rpyp_pkl__builtin_set() constructor {
	__module__ = "__builtin__"
	__name__ = "frozenset"
	__bases__ = [_rpyp_pkl__builtin_set, _rpyp_pkl__builtin_object]
	__brackets_l__ = "frozenset({"
	__brackets_r__ = "})"
	// Waiting for a GM bug to be fixed
	//static __init__ = function() {
	//	for (var i = 0; i < argument_count; i++)
	//		__setitem__(i, argument[i]);
	//}
	static add = function(value) {
		throw "Modification disallowed"
	}
	static __getitem__ = function (key) {
		throw "Modification disallowed"
	}
	static __setitem__ = function (key, value) {
		throw "Modification disallowed"
	}
	static __delitem__ = function (key) {
		throw "Modification disallowed"
	}
};
function _rpyp_pkl__builtin_list() : _rpyp_pkl__builtin_tuple() constructor {
	__module__ = "__builtin__"
	__name__ = "list"
	__bases__ = [_rpyp_pkl__builtin_object]
	__brackets_l__ = "["
	__brackets_r__ = "]"
	static extend = function (arr) {
		for (var i = 0; i < array_length(arr); i++)
			array_push(__content__, arr[i])
		return self;
	}
};
function _rpyp_pkl__builtin_dict() : _rpyp_pkl__builtin_object() constructor {
	__module__ = "__builtin__"
	__name__ = "dict"
	__bases__ = [_rpyp_pkl__builtin_object]
	__content__ = {}
	__brackets_l__ = "{"
	__brackets_r__ = "}"
	__dict__ = self
	static __get_content__ = function () {
		return __content__
	}
	static __getitem__ = function (key) {
		return __content__[$ key];
	}
	static __setitem__ = function (key, value) {
		__content__[$ key] = value;
	}
	static __delitem__ = function (key) {
		__content__[$ key] = undefined;
	}
	static __len__ = function () {
		return array_length(variable_struct_get_names(state));
	}
	static toString = function () {
		return string(__content__);
	}
	static update = function (dict) {
		var keys = variable_struct_get_names(dict.__content__);
		for (var i = 0; i < array_length(keys); i++) {
		    self[$ keys[i]] = dict.__content__[$ keys[i]]
		}
		return self;
	}
};
function _rpyp_pkl_renpy_persistent_Persistent() : _rpyp_pkl__builtin_object() constructor {
	__module__ = "renpy.persistent"
	__name__ = "Persistent"
	__bases__ = [_rpyp_pkl__builtin_object]
};
function _rpyp_pkl_renpy_preferences_Preferences() : _rpyp_pkl__builtin_object() constructor {
	__module__ = "renpy.preferences"
	__name__ = "Preferences"
	__bases__ = [_rpyp_pkl__builtin_object]
};
function _rpyp_pkl_renpy_python_RevertableDict() : _rpyp_pkl__builtin_dict() constructor {
	__module__ = "renpy.python"
	__name__ = "RevertableDict"
	__bases__ = [_rpyp_pkl__builtin_dict, _rpyp_pkl__builtin_object]
};
function _rpyp_pkl_renpy_python_RevertableList() : _rpyp_pkl__builtin_list() constructor {
	__module__ = "renpy.python"
	__name__ = "RevertableList"
	__bases__ = [_rpyp_pkl__builtin_list, _rpyp_pkl__builtin_object]
};
function _rpyp_pkl_renpy_python_RevertableSet() : _rpyp_pkl__builtin_set() constructor {
	__module__ = "renpy.python"
	__name__ = "RevertableSet"
	__bases__ = [_rpyp_pkl__builtin_set, _rpyp_pkl__builtin_object]
};

// Due of a very weird bug, this is a if-else chain
function rpyp_pkl_get_class(class, name) {
    if (class + "." + name) == "__builtin__.object"
        return new _rpyp_pkl__builtin_object();
    else if (class + "." + name) == "__builtin__.tuple"
        return new _rpyp_pkl__builtin_tuple();
    else if (class + "." + name) == "__builtin__.dict"
        return new _rpyp_pkl__builtin_dict();
    else if (class + "." + name) == "__builtin__.set"
        return new _rpyp_pkl__builtin_set();
    else if (class + "." + name) == "__builtin__.frozenset"
        return new _rpyp_pkl__builtin_frozenset();
    else if (class + "." + name) == "__builtin__.list"
        return new _rpyp_pkl__builtin_list();
    else if (class + "." + name) == "renpy.persistent.Persistent"
        return new _rpyp_pkl_renpy_persistent_Persistent();
    else if (class + "." + name) == "renpy.python.RevertableDict"
        return new _rpyp_pkl_renpy_python_RevertableDict();
    else if (class + "." + name) == "renpy.python.RevertableList"
        return new _rpyp_pkl_renpy_python_RevertableList();
    else if (class + "." + name) == "renpy.python.RevertableSet"
        return new _rpyp_pkl_renpy_python_RevertableSet();
    else if (class + "." + name) == "renpy.preferences.Preferences"
        return new _rpyp_pkl_renpy_preferences_Preferences();

	throw "Unknown class " + class + "." + name;
}

function rpyp_pkl_fakeclass_callnew(class, args) {
	// Waiting for a GM bug to be fixed
	// return script_execute_ext(class.__new__, args);
	return class.__new__()
}
function rpyp_pkl_fakeclass_new(class, args) {
	return rpyp_pkl_fakeclass_callnew(class, args);
}
function rpyp_pkl_fakeclass_isinstance(inst, module, name) {
	return variable_struct_exists(inst, "__module__") && inst.__module__ == module && inst.__name__ == name
}

function rpyp_pkl_pop_mark(metastack) {
	var res = metastack[array_length(metastack) - 1]
	array_pop(metastack)
	return res
}

function rpyp_pkl_to_array(dict) {
	var keys = variable_struct_get_names(dict).__content__;
	var arr = [];
	for (var i = 0; i < array_length(keys); i++) {
		array_push(arr, dict[$ keys[i]])
	}
	return arr
}

function rpyp_pkl_callfunc(callable, args) {
	if is_method(callable) {
		// GM bug
		// return script_execute_ext(callable, args.__content__)
		return callable()
	} else if is_struct(callable) {
		if !variable_struct_exists(callable, "__name__")
			throw "Object is not callable"
		// GM bug
		// return rpyp_pkl_fakeclass_new(callable, args)
		var newobj = rpyp_pkl_fakeclass_callnew(callable, [])
		newobj.__setstate_special__(args)
		return newobj
	} else {
		throw "Object is not callable"
	}
}

function rpy_persistent_read_raw_buffer(buf, find_class=rpyp_pkl_get_class) {
	// prevent strange stuff from happening
	gc_enable(false);
	var pkl_version = 0;
	var memo = []
	var stack = []
	var metastack = []
	var correctly_stopped = false;
	var value = undefined;
	if buffer_get_size(buf) <= 0
		throw "Buffer is empty";
	try {
		while (buffer_get_size(buf) > buffer_tell(buf)) {
			var inst = buffer_read(buf, buffer_u8)
			var inst_str = chr(inst)
			switch inst_str {
				case global._pickle_opcodes.PROTO:
					pkl_version = buffer_read(buf, buffer_u8)
					if (pkl_version > 2)
						throw "Pickle protocol version " + string(pkl_version) + " is not fully supported. For safety reading is terminated.";
					break;
				case global._pickle_opcodes.GLOBAL:
					var origin = rpyp_pkl_read_line(buf)
					var class = rpyp_pkl_read_line(buf)
					array_push(stack, find_class(origin, class))
					break;
				case global._pickle_opcodes.STACK_GLOBAL:
					var origin = stack[array_length(stack) - 2]
					var class = stack[array_length(stack) - 1]
					array_pop(stack)
					array_pop(stack)
					array_push(stack, find_class(origin, class))
					break;
				case global._pickle_opcodes.BINPUT:
					var loc = buffer_read(buf, buffer_u8)
					if (loc < 0)
						throw "Negative BINPUT argument";
					array_set(memo, loc, stack[array_length(stack) - 1])
					break;
				case global._pickle_opcodes.EMPTY_TUPLE:
					array_push(stack, rpyp_pkl_fakeclass_new(find_class("__builtin__", "tuple"), []))
					break;
				case global._pickle_opcodes.NEWOBJ:
					var cls = stack[array_length(stack) - 2]
					var args = stack[array_length(stack) - 1].__content__
					array_pop(stack)
					array_pop(stack)
					array_push(stack, rpyp_pkl_fakeclass_new(cls, args))
					break;
				case global._pickle_opcodes.EMPTY_DICT:
					array_push(stack, rpyp_pkl_fakeclass_new(find_class("__builtin__", "dict"), []))
					break;
				case global._pickle_opcodes.EMPTY_SET:
					array_push(stack, rpyp_pkl_fakeclass_new(find_class("__builtin__", "set"), []))
					break;
				case global._pickle_opcodes.MARK:
					array_push(metastack, stack)
					stack = []
					break;
				case global._pickle_opcodes.BINSTRING:
					var len = buffer_read(buf, buffer_s32);
					var str = rpyp_pkl_read_binstring(buf, buffer_tell(buf), len, true);
					array_push(stack, str)
					break;
				case global._pickle_opcodes.SHORT_BINSTRING:
					var len = buffer_read(buf, buffer_u8);
					var str = rpyp_pkl_read_binstring(buf, buffer_tell(buf), len, true);
					array_push(stack, str)
					break;
				case global._pickle_opcodes.BININT1:
					array_push(stack, buffer_read(buf, buffer_u8))
					break;
				case global._pickle_opcodes.EMPTY_LIST:
					array_push(stack, rpyp_pkl_fakeclass_new(find_class("__builtin__", "list"), []))
					break;
				case global._pickle_opcodes.BINUNICODE:
					var len = buffer_read(buf, buffer_u32);
					var str = rpyp_pkl_read_binstring(buf, buffer_tell(buf), len, true);
					array_push(stack, str)
					break;
				case global._pickle_opcodes.SHORT_BINUNICODE:
					var len = buffer_read(buf, buffer_u8);
					var str = rpyp_pkl_read_binstring(buf, buffer_tell(buf), len, true);
					array_push(stack, str)
					break;
				case global._pickle_opcodes.LONG_BINPUT:
					var loc = buffer_read(buf, buffer_u32)
					if (loc < 0)
						throw "Negative LONG_BINPUT argument";
					array_set(memo, loc, stack[array_length(stack) - 1])
					break;
				case global._pickle_opcodes.APPENDS:
					var contents = stack
					stack = rpyp_pkl_pop_mark(metastack);
					stack[array_length(stack) - 1].extend(contents);
					break;
				case global._pickle_opcodes.TUPLE1:
					// Waiting for a GM bug to be fixed to just supply content as second arg
					var obj = rpyp_pkl_fakeclass_new(find_class("__builtin__", "tuple"), []);
					obj.__content__ = [stack[array_length(stack) - 1]]
					array_pop(stack)
					array_push(stack, obj)
					break;
				case global._pickle_opcodes.REDUCE:
					var args = stack[array_length(stack) - 1];
					array_pop(stack)
					var callable = stack[array_length(stack) - 1];
					stack[array_length(stack) - 1] = rpyp_pkl_callfunc(callable, args)
					break;
				case global._pickle_opcodes.NEWTRUE:
					array_push(stack, true)
					break;
				case global._pickle_opcodes.NEWFALSE:
					array_push(stack, false)
					break;
				case global._pickle_opcodes.BININT:
					array_push(stack, buffer_read(buf, buffer_s32))
					break;
				case global._pickle_opcodes.BININT2:
					array_push(stack, buffer_read(buf, buffer_u16))
					break;
				case global._pickle_opcodes.TUPLE2:
					// Waiting for a GM bug to be fixed to just supply content as second arg
					var obj = rpyp_pkl_fakeclass_new(find_class("__builtin__", "tuple"), []);
					obj.__content__ = [stack[array_length(stack) - 1], stack[array_length(stack) - 2]]
					array_pop(stack)
					array_pop(stack)
					array_push(stack, obj)
					break;
				case global._pickle_opcodes.TUPLE3:
					// Waiting for a GM bug to be fixed to just supply content as second arg
					var obj = rpyp_pkl_fakeclass_new(find_class("__builtin__", "tuple"), []);
					obj.__content__ = [stack[array_length(stack) - 1], stack[array_length(stack) - 2], stack[array_length(stack) - 3]]
					array_pop(stack)
					array_pop(stack)
					array_pop(stack)
					array_push(stack, obj)
					break;
				case global._pickle_opcodes.LONG_BINGET:
					var index = buffer_read(buf, buffer_u32)
					array_push(stack, memo[index])
					break;
				case global._pickle_opcodes.SETITEMS:
					var contents = stack
					stack = rpyp_pkl_pop_mark(metastack);
					var dict = stack[array_length(stack) - 1]
					for (var i = 0; i < array_length(contents); i += 2)
						dict.__setitem__(contents[i], contents[i + 1])
					break;
				case global._pickle_opcodes.ADDITEMS:
					var contents = stack
					stack = rpyp_pkl_pop_mark(metastack);
					var set = stack[array_length(stack) - 1]
					set.__contents__ = contents
					break;
				case global._pickle_opcodes.NONE:
					array_push(stack, undefined);
					break;
				case global._pickle_opcodes.BUILD:
					var state = stack[array_length(stack) - 1];
					array_pop(stack)
					var obj = stack[array_length(stack) - 1];
					if variable_struct_exists(obj, "__setstate__") && obj.__setstate__ != undefined {
						stack[array_length(stack) - 1] = obj.__setstate__(state.__content__)
					} else if variable_struct_exists(obj, "__setstate_special_a__") && obj.__setstate_special_a__ != undefined {
						stack[array_length(stack) - 1] = obj.__setstate_special_a__(state.__content__)
					} else {
						var slotstate = undefined;
						if is_struct(state) && rpyp_pkl_fakeclass_isinstance(state, "__builtin__", "tuple") && state.__len__() == 2 {
							slotstate = state.__content__[1]
							state = state.__content__[0]
						}
						if state != undefined {
							var rstate = state.__content__
							var sitems = variable_struct_get_names(rstate)
							for (var i = 0; i < array_length(sitems); i++) {
								var k = sitems[i]
								var v = rstate[$ k]
								obj.__dict__.__setitem__(k, v)
							}
						}
						if slotstate != undefined {
							var rslotstate = slotstate.__content__
							var ssitems = variable_struct_get_names(rslotstate)
							for (var i = 0; i < array_length(ssitems); i++) {
								var k = ssitems[i]
								var v = rslotstate[$ k]
								obj[$ k] = v
							}
						}
					}
					break;
				case global._pickle_opcodes.BINGET:
					var index = buffer_read(buf, buffer_u8)
					array_push(stack, memo[index])
					break;
				case global._pickle_opcodes.BINFLOAT:
					array_push(stack, rpyp_pkl_read_bef64(buf))
					break;
				case global._pickle_opcodes.STOP:
					var value = stack[array_length(stack) - 1];
					array_pop(stack)
					throw "STOP"
					break;
				case global._pickle_opcodes.EXT1:
				case global._pickle_opcodes.EXT2:
				case global._pickle_opcodes.EXT4:
					throw "Extensions are not supported. Corrupt persistent file?"
					break;
				case global._pickle_opcodes.LONG:
				case global._pickle_opcodes.LONG1:
				case global._pickle_opcodes.LONG4:
					throw "Long numbers are currently not supported. Corrupt persistent file?"
					break;
				case global._pickle_opcodes.POP:
					if array_length(stack) > 0
						array_pop(stack)
					else
						stack = rpyp_pkl_pop_mark(metastack)
					break;
				case global._pickle_opcodes.POP_MARK:
					stack = rpyp_pkl_pop_mark(metastack)
					break;
				case global._pickle_opcodes.DUP:
					array_push(stack, stack[array_length(stack) - 1])
					break;
				case global._pickle_opcodes.FLOAT:
				case global._pickle_opcodes.INT:
					var value = rpyp_pkl_read_line(buf)
					array_push(stack, real(value))
					break;
				case global._pickle_opcodes.PERSID:
				case global._pickle_opcodes.BINPERSID:
					throw "Persistent IDs are not supported. Corrupt persistent file?"
					break;
				case global._pickle_opcodes.STRING:
				case global._pickle_opcodes.UNICODE:
					var value = rpyp_pkl_read_line(buf, true)
					array_push(stack, string_copy(value, 2, string_length(value) - 2))
					break;
				case global._pickle_opcodes.APPEND:
					var value = stack[array_length(stack) - 1]
					array_pop(stack)
					array_push(stack[array_length(stack) - 1], value)
					break;
				case global._pickle_opcodes.DICT:
				    var items = stack
					stack = rpyp_pkl_pop_mark(metastack)
			        var dict = rpyp_pkl_fakeclass_new(find_class("__builtin__", "dict"), [])
					for (var i = 0; i < array_length(items); i += 2)
						dict.__setitem__(items[i], items[i + 1])
			        array_push(stack, dict)
					break;
				case global._pickle_opcodes.GET:
					var index = rpyp_pkl_from_decl(rpyp_pkl_read_line(buf))
					array_push(stack, memo[index])
					break;
				case global._pickle_opcodes.INST:
					var origin = rpyp_pkl_read_line(buf)
					var class = rpyp_pkl_read_line(buf)
					var class_obj = find_class(origin, class)
					var orig_stack = stack
					stack = rpyp_pkl_pop_mark(metastack)
					array_push(stack, rpyp_pkl_fakeclass_new(class_obj, orig_stack))
					break;
				case global._pickle_opcodes.OBJ:
					var args = stack
					stack = rpyp_pkl_pop_mark(metastack)
					var class_obj = stack[0]
					array_delete(stack, 0, 1)
					array_push(stack, rpyp_pkl_fakeclass_new(class_obj, args))
					break;
				case global._pickle_opcodes.LIST:
				    var items = stack
					stack = rpyp_pkl_pop_mark(metastack)
					// GM bug
			        var list = rpyp_pkl_fakeclass_new(find_class("__builtin__", "list"), [])
					list.__setstate_special__(items)
			        array_push(stack, list)
					break;
				case global._pickle_opcodes.PUT:
					var loc = rpyp_pkl_from_decl(rpyp_pkl_read_line(buf))
					array_set(memo, loc, stack[array_length(stack) - 1])
					break;
				case global._pickle_opcodes.SETITEM:
					var value = stack[array_length(stack) - 1]
					array_pop(stack)
					var key = stack[array_length(stack) - 1]
					array_pop(stack)
					var dict = stack[array_length(stack) - 1]
					dict.__setitem__(key, value)
					break;
				case global._pickle_opcodes.TUPLE:
				    var items = stack
					stack = rpyp_pkl_pop_mark(metastack)
					// GM bug
			        var list = rpyp_pkl_fakeclass_new(find_class("__builtin__", "tuple"), [])
					list.__setstate_special__(items)
			        array_push(stack, list)
					break;
				case global._pickle_opcodes.BINUNICODE8:
				case global._pickle_opcodes.BINBYTES8:
				case global._pickle_opcodes.BYTEARRAY8:
					throw "64-bit numbers are currently not supported. Corrupt persistent file?"
					break;
				// no bytes support rn
				case global._pickle_opcodes.BINBYTES:
					var len = buffer_read(buf, buffer_u32);
					var str = rpyp_pkl_read_binstring(buf, buffer_tell(buf), len, true);
					array_push(stack, str)
					break;
				case global._pickle_opcodes.SHORT_BINBYTES:
					var len = buffer_read(buf, buffer_u8);
					var str = rpyp_pkl_read_binstring(buf, buffer_tell(buf), len, true);
					array_push(stack, str)
					break;
				case global._pickle_opcodes.FROZENSET:
				    var items = stack
					stack = rpyp_pkl_pop_mark(metastack)
			        var set = rpyp_pkl_fakeclass_new(find_class("__builtin__", "frozenset"), [])
					set.__contents__ = items
			        array_push(stack, set)
					break;
				case global._pickle_opcodes.NEWOBJ_EX:
					/* var cls = stack[array_length(stack) - 1]
					var args = stack[array_length(stack) - 2].__get_content__()
					var kwargs = rpyp_pkl_to_array(stack[array_length(stack) - 3].__get_content__())
					for (var i = 0; i < array_length(kwargs); i++)
						array_push(args, kwargs[i])
					array_pop(stack)
					array_pop(stack)
					array_pop(stack)
					array_push(stack, rpyp_pkl_fakeclass_callnew(cls, args)) */
					throw "Keyword arguments are currently not supported. Corrupt persistent file?"
					break;
				case global._pickle_opcodes.FRAME:
					throw "Framing is not supported."
					break;
				case global._pickle_opcodes.NEXT_BUFFER:
				case global._pickle_opcodes.READONLY_BUFFER:
					throw "Out-of-band buffers are not supported."
					break;
				case global._pickle_opcodes.MEMOIZE:
					array_push(memo, stack[array_length(stack) - 1])
					break;
				default:
					throw "Unknown opcode " + string(inst);
					break;
			}
		}
	} catch (_e) {
		if is_string(_e) {
			if _e == "STOP" {
				correctly_stopped = true
			} else {
				_e += "\nBuffer read to position " + string(buffer_tell(buf))
				throw _e
			}
		} else {
			var le_stacktrace = "";
			for (var i = 0; i < array_length(_e.stacktrace); i++)
				le_stacktrace += _e.stacktrace[i] + "\n"
			throw _e.message + "\nBuffer read to position " + string(buffer_tell(buf)) + "\n" + le_stacktrace
		}
	} finally {
		gc_enable(true);
	}
	if !correctly_stopped {
		throw "EOF reached while reading buffer, however STOP opcode is not called"
	}
	return value;
}

function rpy_persistent_read_buffer(cmp_buff, find_class=rpyp_pkl_get_class) {
	var pickle_buff = buffer_decompress(cmp_buff)
	try {
		return rpy_persistent_read_raw_buffer(pickle_buff, find_class)
	} finally {
		buffer_delete(pickle_buff)
	}
	return undefined;
}
function rpy_persistent_read(fn, find_class=rpyp_pkl_get_class){
	try {
		var orig_file = buffer_load(fn);
		if !buffer_exists(orig_file)
			throw "Can't load file " + fn;
		var ret = rpy_persistent_read_buffer(orig_file, find_class)
	} finally {
		buffer_delete(orig_file)
	}
	return ret
}
function rpy_persistent_read_uncompressed(fn, find_class=rpyp_pkl_get_class){
	var orig_file = undefined;
	try {
		orig_file = buffer_load(fn);
		if !buffer_exists(orig_file)
			throw "Can't load file " + fn;
		return rpy_persistent_read_raw_buffer(orig_file, find_class)
	} finally {
		if orig_file != undefined
			buffer_delete(orig_file)
	}
	return undefined;
}

function rpy_persistent_convert_from_abstract(obj) {
	var struct = {};
	var keys = variable_struct_get_names(obj);
	for (var i = 0; i < array_length(keys); i++) {
		var key = keys[i]
		var value = obj[$ key]
		if string_copy(key, 0, 2) == "__" && string_copy(key, string_length(key) - 1, 2) == "__"
			continue;
		if is_struct(value) {
			if variable_struct_exists(value, "__content__")
				value = value.__content__
			else
				value = rpy_persistent_convert_from_abstract(value)
		}
		struct[$ key] = value
	}
	return struct;
}