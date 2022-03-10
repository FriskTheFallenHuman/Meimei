/// string_shuffle(string)
// Returns a string with contents shuffled.
var r, i;
r = "";
i = 1;
// for each character in source,
repeat (string_length(argument0)) {
    // insert character at random
    // position into destination string
    r = string_insert(
        string_char_at(argument0, i),
        r, irandom(i));
    i += 1;
}
return r;