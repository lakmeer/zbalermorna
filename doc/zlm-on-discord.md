# Zbalermorna on Discord

In the future, once ZLM-compatible fonts are more easily distributed/available, it might be desirable to use these fonts on Discord to communicate with other people that have these fonts (hopefully a separate ZLM channel). This is possible with [BeautifulDiscord, a css injector](https://github.com/leovoel/BeautifulDiscord). Once you have it installed and are editing your css file, you can use something like this to make the input area, messages, and code blocks render using ZLM-compatible fonts:

```
input, textarea {
    font-family: "Lato-ZLM";
	font-size: 20px!important;
	line-height: 22px!important;
}

div[class*='markup'] {
    font-family: "Lato-ZLM";
	font-size: 20px!important;
	line-height: 22px!important;
}

code {
	font-family: "Fira Code";
	font-size: 18px!important;
	line-height: 20px!important;
}
```