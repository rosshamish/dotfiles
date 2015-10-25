
Dotfiles and system setup.

Based on http://github.com/paulmillr/dotfiles. See that repo for documentation. Many undocumented changes have been made here.

Sets up the following
- git (gitconfig, gitignore)
- zsh (highlighting, autocomplete)
- sublime 3 (theme = Soda Light, color = Dawn, font = Source Code Pro, various settings)
- mac os (finder, spotlight, safari, various settings)
- ssh (generates key if one doesn't exist, opens github to paste it in)
- homebrew, brew-cask

Remember to install Source Code Pro from here https://github.com/adobe-fonts/source-code-pro/downloads. Download it, open Font Book, +

---

Download and symlink dotfiles

This will clone rosshamish/dotfiles into ~/Developer/rosshamish/dotfiles, then symlink ~/.files to ~/Developer/rosshamish/dotfiles/home/.files

```
curl --silent https://raw.githubusercontent.com/rosshamish/dotfiles/master/install.sh | sh
```

---

Bootstrap new system

This is a lot heavier and will change lots of system settings. Read bootstrap-new-system.sh before executing it. This will also download and symlink dotfiles.

```
curl --silent https://raw.githubusercontent.com/rosshamish/dotfiles/master/install.sh | sh
cd ~/Developer/rosshamish/dotfiles
sh bootstrap-new-system.sh
```

---

License

The MIT license.

Copyright (c) 2013-2015 Paul Miller, Ross Anderson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
