# Dotfiles

This repository contains the dotfiles in my home directory. Feel free to use any of these configuration files as you wish. Any contribution is appreciated!

## My VIMRC

### Colorschemes

I've used many different colorschemes but only 2 have managed to keep me sane over the long term. [Dracula](https://github.com/dracula/vim) and [Gruvbox](https://github.com/morhetz/gruvbox) (Dark). I switch between the two whenever I get tired or bored of one.

### Keybindings

These are the key mappings and shortcuts that I use the most often:

* **,,v** and **,,s**: To quickly open, edit, and source my VIMRC. Whenever I feel like I'm repeating my self with a command, it's convenient to use these mappings to add a quick key binding in my VIMRC.
* **CTRL-u**: Change the word under the cursor to uppercase. This is exceptionally helpful when I'm defining constants or header gaurds in my C++ projects (Since they are all uppercase).
* **,nh** Disable highlighting after search. It's easier to type these than `:nohl` every time.
* **\s**: This expands into `std::` in C++. I don't want to make all the names from the standard library visible in my programs. That's why this little abbreviation is super handy. 

### Plugins

### Eliminating Bad Habits

I disabled the arrow keys in both **Normal** and **Insert** modes. Moving around the file with **HJKL** is much more efficient. There are other mappings for efficient navigation too that I use quite often:

* **CTRL-f**: Scroll one page down
* **CTRL-b**: Scroll one page up
* **zz**: Place the current line at the center of the window

Another bad habit I used to have was exiting the **Insert** mode using the `<esc>` key. The `<esc>` key is a far reach for the pinky on the left hand and it's important to exit the insert mode and save the changes every few seconds or so. That's why I use `jk` to exit the **Insert** mode instead. The mouse buttons and scrolling functionalities are also disabled in my VIMRC.
