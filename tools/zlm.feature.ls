
#
# Setup
#

# Generic helpers

log      = console.log.bind console
join     = (.join '')
spaces   = (.join ' ')
debug    = -> &0 = "---- " + &0; log ...
map      = (λ, xs) --> [ λ x for x in xs ]
filter   = (λ, xs) --> [ x for x in xs when λ x ]
contains = (xs, needle) -> (xs.index-of needle) > -1


# ZLM DSL

glyph = (g) ->
  if SEMIV `contains` g
    \ZLM_SEMIVOWEL_ + g
  else if CONSN `contains` g
    \ZLM_ + g
  else if ALL_VOWELS `contains` g
    \ZLM_DIACRITIC_ + g
  else
    \ZLM_ + g

dot  = (g) -> \ZLM_DOT_ + g
cas  = (before, after) -> \ZLM_CAS_ + join before ++ \H ++ after
list = spaces << map glyph
to-v = (q) -> if q is \Q then \I else if q is \W then \U else \UNKNOWN


# Features DSL

def-class = (name, members) ->
  if typeof members is \string
    log "@#name = [ #members ];"
  else
    log "@#name = [ #{ list members } ];"

comment     = (text) -> log "\n# #text\n"
big-comment = (text) -> log "\n\n#\n# #text\n#\n"
description = (title, λ) -> big-comment title; λ!
section     = (name, λ) -> big-comment name; λ!
feature     = (name, λ) -> comment name; log "feature rlig {"; λ!; log "} rlig;"
sub         = (...parts, lig) -> log "  sub #{ map glyph, parts |> spaces } by #lig;"
sub-tick    = (...parts, lig) -> log "  sub #{ map glyph, parts |> map (+ \') |> spaces } by #lig;"
ignore      = (ctx, ...gs) -> log "  ignore sub #ctx #{ map (+ \'), gs |> spaces  };"


# Data

SEMIV  = <[ Q W ]>
CONSN  = <[ P T K F L S C M X B D G V R Z J N H ]>
VOWELS = <[ A E I O U Y ]>
DIPHTH = <[ AI EI OI AU ]>

ALL_CONSN  = CONSN ++ SEMIV
ALL_VOWELS = VOWELS ++ DIPHTH


description "ZLM OpenType Feature Table Definitions", ->

  def-class \consonant, ALL_CONSN
  def-class \vowel,     ALL_VOWELS
  def-class \anything, "@consonant @vowel"

  section "5-part ligatures", ->
    feature \VV'VV, ->
      ignore \@consonant \@vowel \@vowel \ZLM_H \@vowel \@vowel
      for [ a, b ] in DIPHTH
        for [ c, d ] in DIPHTH
          sub-tick a, b, \H, c, d, cas [ a, b ], [ c, d ]

  section "4-part ligatures", ->
    feature \VV'V, ->
      ignore \@consonant \@vowel \@vowel \ZLM_H \@vowel
      for [ a, b ] in DIPHTH
        for v in VOWELS
          sub-tick a, b, \H, v, cas [ a, b ], [ v ]
    feature \V'VV, ->
      ignore \@consonant \@vowel \ZLM_H \@vowel \@vowel
      for v in VOWELS
        for [ a, b ] in DIPHTH
          sub-tick v, \H, a, b, cas [ v ], [ a, b ]

  section "3-part ligatures", ->
    feature \V'V, ->
      ignore \@consonant \@vowel \ZLM_H \@vowel
      for a in VOWELS
        for b in VOWELS
          sub-tick a, \H, b, cas [ a ], [ b ]
    feature \QVV, ->
      for q in SEMIV
        for [ a, b ] in DIPHTH
          sub-tick q, a, b, glyph q + a + b
    feature \WVV, ->
      ignore \@consonant \@vowel \@vowel \@vowel"
      for q in SEMIV
        for [ a, b ] in DIPHTH
          sub-tick (to-v q), a, b, glyph q + a + b
    feature \CVV, ->
      for c in CONSN
        for [ a, b ] in DIPHTH
          sub c, a, b, glyph c + a + b

  section "2-part ligatures", ->
    feature \QV, ->
      for q in SEMIV
        for v in VOWELS
          sub-tick q, v, glyph q + v
    feature \WV, ->
      ignore \@consonant \@vowel \@vowel
      for q in SEMIV
        for v in VOWELS
          sub-tick (to-v q), v, glyph q + v
    feature \CV, ->
      for c in CONSN
        for v in VOWELS
          sub c, v, glyph c + v
    feature \VV, ->
      for [ a, b ] in DIPHTH
        sub a, b, glyph a + b

  section "Single Substitutions", ->
    feature ".V", ->
      ignore \@anything \@vowel
      for v in ALL_VOWELS
        sub-tick v, dot v


