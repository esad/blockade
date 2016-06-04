<img src="https://raw.github.com/esad/blockade/master/inaction.gif">

Blockade is a randomized 2-color [turmite](https://en.wikipedia.org/wiki/Turmite) screensaver for OS X ([download](https://github.com/esad/blockade/releases) or [try it in your browser](https://esad.github.io/blockade)).

It's written in [Elm](http://elm-lang.org) with a small native screensaver wrapper that embeds the Elm app in a webview. The whole drawing is actually done via CSS.

## Development Notes

You will need Elm 0.17 platform and Sass to build the web part. Once you have those

    cd html && make

This will build you the new version in `html/build`. The three files from this directory get bundled in the screensaver.

To actually run the screensaver from Xcode, use the approach [outlined here](http://stackoverflow.com/questions/1101926/how-to-debug-a-screensaver-in-os-x/34929093#34929093).

## License

Copyright (c) 2016 Esad Hajdarevic, licensed under the MIT License.
