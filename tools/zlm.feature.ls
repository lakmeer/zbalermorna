
#
# Setup
#

# Render glyph names

cons-name = (cons) ->
  if cons is \Q or cons is \W
    \ZLM_SEMIVOWEL_ + cons
  else
    \ZLM_ + cons

vowel-name = (vowel) ->
  \ZLM_DIACRITIC_ + vowel

liga-cvv = (cons, vowel) ->
  if vowel is ''
    \ZLM_ + cons
  else if cons is \DOT
    \ZLM_DOT_ + vowel
  else
    \ZLM_ + cons + vowel

liga-cvvhvv = (a, b) ->
  \ZLM_CAS_ + a + \H + b


# Opentype feature syntax

sub = (...comp, liga) ->
  "sub " + (comp.join ' ') + " by #liga;"

feature = (name, xx) ->
  write 0 "feature #name {"
  xx!
  write 0 "} #name;"
  blank!


# Output helpers

log = console.log.bind console

indent = (n, text) -->
  (" " * n) + text

comment = (n, text) -->
  log indent n, "# #text"

write = log . indent

blank = -> log ""


# Data

CONSN = <[ DOT H P T K F L S C M X B D G V R Z J N Q W ]>
VOWEL = <[ A E I O U Y AI EI OI AU ]>


#
# Generation
#

# Generate class defs
blank!
comment 0, "Class Defs"
write 0 "@vowel     = [ " + (VOWEL.map vowel-name) + " ]"
write 0 "@consonant = [ " + (CONSN.map  cons-name) + " ]"
write 0 "@anything  = [ @vowel @consonant ]"
blank!

# Generate self-dotting vowels
comment 0, "Self-dotting vowels"
feature \rlig, ->
  write 2 "ignore sub @anything @vowel';"
  for vowel in VOWEL
    write 2 sub (vowel-name vowel), (liga-cvv \DOT, vowel)

# Generate CV series
comment 0, "CV Series"
feature \rlig, ->
  for cons in CONSN
    blank!
    comment 2, "#cons Series"
    for vowel in VOWEL
      write 2 sub (cons-name cons), (vowel-name vowel), (liga-cvv cons, vowel)

# Generate CVV'VV series
comment 0, "CVV'VV Series"
feature \rlig, ->
  for vowel-a in VOWEL
    blank!
    comment 2, "#vowel-a Series"
    for vowel-b in VOWEL
      write 2, sub (vowel-name vowel-a), \ZLM_H, (vowel-name vowel-b), (liga-cvvhvv vowel-a, vowel-b)

