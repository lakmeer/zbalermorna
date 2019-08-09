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

// Global Helpers

var log = console.log.bind(console);

function toArray (list) {
  return Array.prototype.slice.apply(list);
}

function Q (sel, parent) {
  return toArray((parent || document).querySelectorAll(sel));
};

function translate (text) {
  return toArray(text).map(latinToZbalermorna).join('');
}

// Translate test cases into appropriate unicode

Q('[data-zlm-translate]').forEach(function (phrase) {
  phrase.innerHTML = translate(phrase.innerHTML);
  return;

  var output = "";
  var chars  = phrase.innerHTML;
  var mode   = PARSE_MODE_TEXT;

  for (var i = 0, max = chars.length - 1; i < max; i++) {
    var c = chars[i];

    if (c === '<') { mode = PARSE_MODE_TAG; }
    if (c === '>') { mode = PARSE_MODE_TEXT; }

    switch (mode) {
      case PARSE_MODE_TEXT: output += translate(c); break;
      case PARSE_MODE_TAG:  output += c; break;
    }
  }

  phrase.innerHTML = output;
});

const font_selector = document.getElementById('font-selector');
const ime_link = document.getElementById('ime-link');

var ed = lining(document.getElementById("eye-doctor"), {'autoResize': true});

function updateFont(value) {
  for (var i = 0; i < document.getElementsByClassName('reference').length; i++) {
    document.getElementsByClassName('reference')[i].style["font-family"] = value;
  }
  document.fonts.ready.then(function() {
    ed.relining(true);
  });
}
font_selector.addEventListener('change', (event) => {
  window.location.hash = event.target.value;
  ime_link.href = "ime.html" + window.location.hash;
  updateFont(event.target.value);
});


if (window.location.hash) {
  font_selector.value = window.location.hash.substring(1);
  ime_link.href = "ime.html" + window.location.hash;
} else {
  font_selector.value = "zlm-manri";
  window.location.hash = font_selector.value;
  ime_link.href = "ime.html" + window.location.hash;
}

updateFont(font_selector.value);