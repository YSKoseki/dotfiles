# dotfiles

## Overview

This repository contains dotfiles and setup scripts for configuring a macOS environment.

## Installation

1. Clone the repository.

```shell
git clone https://github.com/YSKoseki/dotfiles
```

2. Move to the repository directory.

```shell
cd dotfiles
```

3. Set up macOS using the makefile.

You can run all tasks at once:

```shell
make
```
Or run them separately:

```shell
make xcode
make link
make defaults
make brew
make gh
```

4. References

- [Macの環境をdotfilesでセットアップしてみた改](https://zenn.dev/tsukuboshi/articles/6e82aef942d9af)
- [Homebrew を dotfiles で管理する際にやったこと](https://egashira.dev/blog/manage-homebrew-with-dotfiles)
- [初心者向け,PCの環境をdotfilesで一瞬で構築する方法(mac)](https://qiita.com/kez/items/e349a8d025acbcdc3a86)
