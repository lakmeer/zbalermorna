// Public Domain 2016 la kmir, 2019 Jack Humbert
//
// This is free and unencumbered software released into the public domain.

// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// For more information, please refer to <http://unlicense.org>

// Zbalermorna translation

const UNICODE_RANGE_START = 0xE2300;
const UNICODE_FULL_VOWEL_START = 0xE24F1;
const lerfu = ".'ptkflscmxbdgvrzjnqwaeiouy";
const fullVowels = "AEIOUY";

function formatUnicode (point) {
  return String.fromCodePoint(point);
}

function latinToZbalermorna(c) {
  if (c.codePointAt(0) >= 0xe2300) {
    return c;
  }
  if (c == " ")
    return " ";
  if (c == "h" || c == "H")
    c = "'";
  if (c == ",")
    return formatUnicode(0xe230f); // ZLM_SLAKABU
  if (c == "~")
    return formatUnicode(0xe238f); // ZLM_STRETCH
  if (c == "-")
    return formatUnicode(0xe23af); // ZLM_DASH_MEDI (smajibu)
  if (c == "!")
    return formatUnicode(0xe235f); // ZLM_BAHEBU
  // if (c == ":" || c == "\"")
  //   return formatUnicode(0xe24f0)); // these ligatures aren't supported by the font standard yet
  if (c == "1")
    return formatUnicode(0xe231F); // ZLM_TONE_UP
  if (c == "2")
    return formatUnicode(0xe232F); // ZLM_TONE_DOWN
  if (c == "3")
    return formatUnicode(0xe233F); // ZLM_TONE_UP_DOWN
  if (c == "4")
    return formatUnicode(0xe234F); // ZLM_TONE_DOWN_UP
  if (fullVowels.indexOf(c) >= 0)
    return formatUnicode(UNICODE_FULL_VOWEL_START + fullVowels.indexOf(c));
  else if (lerfu.indexOf(c.toLowerCase()) >= 0)
    return formatUnicode(UNICODE_RANGE_START + lerfu.indexOf(c.toLowerCase()) * 16);
  if (c == "\n")
    return "\n";
  if (c == "\t")
    return "\t";
  return "";
}