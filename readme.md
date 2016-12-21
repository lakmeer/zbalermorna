
# Zbalermorna Font Development Kit

A collection of tools and processes for using and developing typefaces for
Zbalermorna, an alternative orthography for the constructed language Lojban.


### How a ZLM font works

Zbalermorna uses special glpyhs which live in the Unicode Supplementary
Special Purpose plane, covering the region from 0xE2320 -> 0xE24FF.

A method of inputting these glyphs requires in IME for your particular
operating system, such as `ibus` or `scim`. This project attempts to provide
configurations for as many IMEs as possible.

Once a IME and an appropriate configuration is loaded, it can be used to type
ZLM glyphs, which a correctly constructed ZLM font will automatically display
as assembled composite glpyhs using OpenType features.


### Currently Supported IMEs

- `ibus`


### Creating a new Zbalermorna typeface

- Install [FontForge](http://fontforge.github.io)
- Launch the Preview page: `gulp preview`
- Clone and rename `src/zlm-manri.sfd` to create your own copy
- Open your new copy using FontForge
- Modify vector shapes for component glyphs; composite glyphs will auto-update
- Self-assembling composites can also be manually overriden with real vectors,
  if your typeface wants to use special forms for certain composites.
- When your `.sfd` file is saved, Gulp will automatically recompile it into a
  TrueType font, and refresh the preview page so you can see how your updates
  effect ligaturing and kerning.

