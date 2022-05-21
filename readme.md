# NVIM Config
## aadriance/config who?

This is my current windows centric dev config for nvim. I daily drive Windows,
 I use to maintain a mac config as-well but I don't have time to mess with two
 set-ups.
 
## Install

It's windows nvim config should like at: C:\Users\YOU\AppData\Local\nvim

## Dependencies

There are a handful of other third party tools leveraged by my nvim config that
 scoopdepends.ps1 will install:

* ripgrep & fd for help make telescope fast
* zig to compile lsp stuff
* lazygit for my nvim git pop-up terminal window
* glow for better markdown preview

## Notable Keymap entries

### Markdown

* enter to follow a defined link
* enter to create a link
* alt enter to remove a link
* back space to jump to previous file
* xx to mark a to-do item

### File exploring

* space sf to open file searcher
* space se to open interactive file tree
* space space to open buffer list
* space ? to open old files

### Bar buffer moving

* alt < or > to move back and forth
* ctrl p to enter magic select mode

### Terminal pop-ups

* space md to open glow md previewer
* space g to open lazygit
* space t to open powershell

### Diagram drawing

* space v to toggle diagram mode
* v in diagram mode to start a box
* f to make box
* shift direction keys to draw lines
