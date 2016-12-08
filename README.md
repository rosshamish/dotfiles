
Dotfiles and system setup.

update Dec 7, 2016:
- update and improve system setup to be lighter and interactive
- add minimal vimrc from https://github.com/skwp/dotfiles/blob/master/vimrc
- add minimal tmux.conf from http://raw.githubusercontent.com/mguterl/dotfiles/master/tmux.conf
- switch to iterm2, previously terminal. color theme and font from https://gist.github.com/kevin-smets/8568070
- switch to oh-my-zsh, previously zsh settings from paulmillr/dotfiles. Use default robbymiller theme.
- remove sublime stuff

this is now an iTerm2 + zsh + tmux + git + vim setup. There's also some osx tweaks available.

---

You probably just want to do this. It'll symlink config files for git, vim, and tmux

```
git clone http://github.com/rosshamish/dotfiles
cd dotfiles
./symlink-dotfiles.sh
```

You can also do this. It'll walk you through setting up your system. You'll want to install iTerm2.

```
./install-interactive.sh
```

---

License

The MIT license.

Copyright (c) 2016 Ross Anderson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
