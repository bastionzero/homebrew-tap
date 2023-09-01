# Bastionzero Tap

## How do I install these formulae?

`brew install bastionzero/tap/<formula>`

Or `brew tap bastionzero/tap` and then `brew install <formula>`.

## Bottle Support Matrix

BastionZero offers the zli in pre-built binaries for the following matrix.

| OS                 | x86                | arm64                |
| ------------------ | ------------------ | -------------------- |
| MacOS 13 Ventura   | :white_check_mark: | :white_check_mark:   |
| MacOS 12 Monterey  | :white_check_mark: | :white_check_mark:   |
| MacOS 11 Big Sur   | :white_check_mark: | :white_check_mark:   |

## Downgrading
BastionZero cannot guarantee compatability when downgrading.

Brew does not support the same kind of versioning in taps as they do in homebrew/core. Because of this, we recommend following the only documented methodology.


1. Create a new local tap
```console
$ brew tap-new $USER/local-zli
```
2. Extract the desired version into the local tap
```console
$ brew extract --version=<version> bastionzero/tap/zli $USER/local-zli
```
3. run brew install@version as usual
```console
$ brew install zli@<version>
```

For more information on what's happening and why to use this method, please see the following tutorials:

https://blog.sandipb.net/2021/09/02/installing-a-specific-version-of-a-homebrew-formula/

https://cmichel.io/how-to-install-an-old-package-version-with-brew/

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
