# Zbalermorna IME for Windows

`zlm.klc` is the source file here, and can be edited with a text editor directly, or with the [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=22339), which is also used to build/export it into the binary files. [.NET v2.0](https://www.microsoft.com/en-us/download/confirmation.aspx?id=6523) is required for this - the link the KLC installer takes you to is wrong for some reason.

Lojban isn't available as a language in the GUI, so it is kept on English-US - there may be a way to get Windows to recognise Lojban and allow this change, but any modifying of the file directly was changed back upon loading the file in the GUI.

The current working directory defaults to your `Documents` folder, but setting it to your `ime/windows` folder will put things in the correct place (which will export to the `ime/windows/zlm`). 

Compiling can only be done if you don't have the layout already installed, so you need to run the setup.exe again to uninstall it, then build and reinstall it again afterwards.