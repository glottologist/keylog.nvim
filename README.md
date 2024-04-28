<!-- panvimdoc-ignore-start -->

<h1 align="center">
keylog.nvim
</h1>

<p align="center">
<a href="https://github.com/glottologist/keylog.nvim/stargazers">
    <img
      alt="Stargazers"
      src="https://img.shields.io/github/stars/glottologist/keylog.nvim?style=for-the-badge&logo=starship&color=fae3b0&logoColor=d9e0ee&labelColor=282a36"
    />
  </a>
  <a href="https://github.com/glottologist/keylog.nvim/issues">
    <img
      alt="Issues"
      src="https://img.shields.io/github/issues/glottologist/keylog.nvim?style=for-the-badge&logo=gitbook&color=ddb6f2&logoColor=d9e0ee&labelColor=282a36"
    />
  </a>
  <a href="https://github.com/glottologist/keylog.nvim/contributors">
    <img
      alt="Contributors"
      src="https://img.shields.io/github/contributors/glottologist/keylog.nvim?style=for-the-badge&logo=opensourceinitiative&color=abe9b3&logoColor=d9e0ee&labelColor=282a36"
    />
  </a>
</p>

<p align="center">
  <img src="https://github.com/glottologist/keylog.nvim/assets/74842863/117a8d30-64ba-4ca9-8414-5c493cbe8a70" width="700" />
</p>

<!-- panvimdoc-ignore-end -->

## 📃 Introduction

A Neovim plugin for logging keystrokes in order to generate heatmaps

## ⚙️ Features

- Log keystrokes to a keystrokes.log data file

## ⚡ Requirements

- Neovim >= [v0.7.0](https://github.com/neovim/neovim/releases/tag/v0.7.0)

## 📦 Installation

1. Install via your favorite package manager.

```lua
-- lazy.nvim
{
   "glottologist/keylog.nvim",
   opts = {}
},
```

2. Setup the plugin in your `init.lua`. This step is not needed with lazy.nvim if `opts` is set as above.

```lua
require("keylog").setup()
```

## 🚀 Usage

keylog.nvim is enabled by default. You can change its state with the following commands:

- `:Keylog enable` enable keylog.nvim
- `:Keylog disable` disable keylog.nvim
- `:Keylog toggle` toggle keylog.nvim
- `:Keylog clear` clear the keystrokes.log file

Your log file is at `~/.local/share/nvim/keystroke.log`.


## 🦾 Contributing

Please read [CONTRIBUTING.md](https://github.com/glottologist/keylog.nvim/blob/main/CONTRIBUTING.md).
