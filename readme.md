
# Zbalermorna Font Development Kit

A collection of tools and processes for using and developing typefaces for
Zbalermorna, an alternative orthography for the constructed language Lojban.

## Project status

###### Done

- Design unicode layout
- Create reference glyphs


###### To Do

- Complete opentype features declaration
- Complete first working ZLM font
- Create ibus config for new unicode range
- Finalise buid process for new ont development
- Port the old ZLM font, now called 'Drakono' to new system
- Create alternate typefaces and add them to this repo


### How to type ZLM text

- Install an IME file and a ZLM font
- Type native ZLM directly into any app or website

**or**

- Clone this repo
- Open `test/index.html` and use the IME emulator
- Copy-paste the generated ZLM text

Soon we will also have an online version of the IME emulator you can use to play
with ZLM text. You'll still need a font to support the generated ZLM text~


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

None so far.


#### IME support roadmap

- `ibus` - just need to convert la suzil's original ibus config to the proper
  range and create a non-ligating version.


### Creating a new Zbalermorna typeface

```
This procedure is still incomplete - build script and feature file have bugs
```

- Install [FontForge](http://fontforge.github.io)
- Launch the Preview page: `gulp preview`
- Clone and rename `src/zlm-manri.sfd` to create your own copy
- Open your new copy using FontForge
- Modify vector shapes for component glyphs; composite glyphs will auto-update
- Self-assembling composites can also be manually overriden with real vectors,
  if your typeface wants to use special forms for certain composites.
- When your `.sfd` file is saved, Gulp will automatically recompile it into a
  TrueType font, and refresh the preview page so you can see how your updates
  effect ligatures and kerning.

