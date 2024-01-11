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

## Downgrading
BastionZero cannot guarantee compatability when downgrading.

Brew does not support the same kind of versioning in taps as they do in homebrew/core. Because of this, we recommend the following:


1. Create a new local tap
```console
$ brew tap-new $USER/local-zli
```
2. Extract the desired version into the local tap
```console
$ brew extract --version=<version> bastionzero/tap/zli $USER/local-zli
```
3. Run brew install@version
```console
$ brew install zli@<version>
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
