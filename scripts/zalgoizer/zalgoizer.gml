/*
	This portion of code is based on Lunicode.js

	Copyright (C) 2019 Robert Gerlach

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

function zalgoizer_init()
{
	diacriticsTop = []
	diacriticsMiddle = []
	diacriticsBottom = []

	// Sort diacritics in top, bottom or middle

	for (var i = 768; i <= 789; i++) {
	    array_push(diacriticsTop, chr(i));
	}
        
	for (var i = 790; i <= 819; i++) {
	    if (i != 794 && i != 795) {
	        array_push(diacriticsBottom, chr(i));
	    }
	}
	array_push(diacriticsTop, chr(794));
	array_push(diacriticsTop, chr(795));
        
	for (var i = 820; i <= 824; i++) {
	    array_push(diacriticsMiddle, chr(i));
	}
        
	for (var i = 825; i <= 828; i++) {
	    array_push(diacriticsBottom, chr(i));
	}
        
	for (var i = 829; i <= 836; i++) {
	    array_push(diacriticsTop, chr(i));
	}
	array_push(diacriticsTop, chr(836));
	array_push(diacriticsBottom, chr(837));
	array_push(diacriticsTop, chr(838));
	array_push(diacriticsBottom, chr(839));
	array_push(diacriticsBottom, chr(840));
	array_push(diacriticsBottom, chr(841));
	array_push(diacriticsTop, chr(842));
	array_push(diacriticsTop, chr(843));
	array_push(diacriticsTop, chr(844));
	array_push(diacriticsBottom, chr(845));
	array_push(diacriticsBottom, chr(846));
	// 847 (U+034F) is invisible http://en.wikipedia.org/wiki/Combining_grapheme_joiner
	array_push(diacriticsTop, chr(848));
	array_push(diacriticsTop, chr(849));
	array_push(diacriticsTop, chr(850));
	array_push(diacriticsBottom, chr(851));
	array_push(diacriticsBottom, chr(852));
	array_push(diacriticsBottom, chr(853));
	array_push(diacriticsBottom, chr(854));
	array_push(diacriticsTop, chr(855));
	array_push(diacriticsTop, chr(856));
	array_push(diacriticsBottom, chr(857));
	array_push(diacriticsBottom, chr(858));
	array_push(diacriticsTop, chr(859));
	array_push(diacriticsBottom, chr(860));
	array_push(diacriticsTop, chr(861));
	array_push(diacriticsTop, chr(861));
	array_push(diacriticsBottom, chr(863));
	array_push(diacriticsTop, chr(864));
	array_push(diacriticsTop, chr(865));

	z_top = true
	z_middle = true
	z_bottom = true
	z_maxHeight = 15
	z_randomization = 100
}

function zalgoizer_zalgoize(text)
{
	randomise();

	var newText = "";
	var newChar = "";

	for (var i = 1; i <= string_length(text); i++) {
	    newChar = string_char_at(text, i);

	    if (z_middle) {
	        // Put just one of the middle characters there, or it gets crowded
	        newChar += diacriticsMiddle[irandom(array_length(diacriticsMiddle) - 1)];
	    }
  
	    if (z_top) {
	        // Put up to maxHeight random diacritics on top.
	        // optionally fluctuate the number via the randomization value (0-100%)
	        // randomization 100%: 0 to maxHeight
	        //                30%: 70% of maxHeight to maxHeight
	        //                 x%: 100-x% of maxHeight to maxHeight 
	        var diacriticsTopLength = array_length(diacriticsTop) - 1;
	        for (var count = 0, len = z_maxHeight - random(1) * ((z_randomization / 100) * z_maxHeight); count < len; count++) {
	            newChar += diacriticsTop[irandom(diacriticsTopLength)];
	        }
	    }      

	    if (z_bottom) {
	        var diacriticsBottomLength = array_length(diacriticsBottom) - 1;
	        for (var count = 0, len = z_maxHeight - random(1) * ((z_randomization/100) *z_maxHeight); count < len; count++) {
	            newChar += diacriticsBottom[irandom(diacriticsBottomLength)];
	        }
	    }

	    newText += newChar;
	}

	return newText;
}