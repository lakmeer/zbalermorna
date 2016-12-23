
#
# Setup
#

# Generic helpers

log     = console.log.bind console
floor   = Math.floor
hex     = (.to-string 16)
map     = (λ, xs) --> [ λ x for x in xs ]
join    = (.join '')
rnd     = (n) -> floor Math.random! * n
rnd-chr = (n) -> [ rnd 16 for i from 0 til n ] |> map hex |> join
uuid4   = -> "#{ rnd-chr 8 }-#{ rnd-chr 4 }-4#{ rnd-chr 3 }-#{ hex (rnd 16) .&. 0x3 .|. 0x8 }#{ rnd-chr 3 }-#{ rnd-chr 12 }"
datestamp = do (now = new Date) -> "#{ now.get-full-year! }#{ now.get-month! + 1 }#{ now.get-date! }"


# Data

ibus-preamble = ({ name, symbol, author, desc }) -> log """
  SCIM_Generic_Table_Phrase_Library_TEXT
  VERSION_1_0

  BEGIN_DEFINITION
  LICENSE = LGPL
  UUID = #{uuid4!}
  SERIAL_NUMBER = #datestamp
  ICON = zybu.svg
  PAGE_SIZE = 0
  SYMBOL = #symbol
  NAME = #name
  DESCRIPTION = #desc
  LANGUAGES = en_US
  AUTHOR = #author
  STATUS_PROMPT = #symbol
  VALID_INPUT_CHARS = abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,.?!1234567890()":;#/'
  LAYOUT = us
  MAX_KEY_LENGTH = 1
  AUTO_COMMIT = TRUE
  AUTO_SELECT = TRUE
  DEF_FULL_WIDTH_PUNCT = TRUE
  DEF_FULL_WIDTH_LETTER = TRUE
  USER_CAN_DEFINE_PHRASE = FALSE
  PINYIN_MODE = FALSE
  DYNAMIC_ADJUST = FALSE
  END_DEFINITION
"""

table = (λ) ->
  log \BEGIN_TABLE
  λ!
  log \END_TABLE

entry = (input, codepoint) ->
  log input, (String.from-code-point codepoint), \1


# Data

INPUTS  = <[ ' h p t k f l s c m x b d g v r z j n q w a e i o u y ]>
OFFSET  = 0xE2300


# Output

ibus-preamble do
  name: \Zbalermorna
  symbol: \ZLM
  author: "la kmir joi la suzil"
  desc: "Basic input method for Zbalermorna text. Requires ligature support in font engine."

table ->
  for input, ix in INPUTS
    if input is \'
      entry input, OFFSET + 0x10
    else
      entry input, OFFSET + ix * 0x10


