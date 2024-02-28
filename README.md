# how-to-make-vim-real-ide

## Install Git
Install git on your windows. by using the choco command or on official website of git.

```bash
choco install git
```

## Plug Vim
**Install plug-vim**
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## .vimrc (I preferr) or init.vim
Create a `.vimrc` file in your home directory, for example in Windows: `C:\Users\username`

## Install Plugins
In mode `COMMAND` using `:PlugInstall` inside vim by open vim using `vim` command in bash to install plugins.

## Vim Modes
1. Default mode is `NORMAL`, you can back to normal mode by press `Esc` in Windows, which means you can switch between different modes and copy, past, undo, and movement in file.
2. Command mode is `COMMAND`, to choice this mode by press `Shift + ;` together to make `:` in Windows, which means you can write VIM Commands in this mode.
3. Visual mode is `VISUAL`, you can choice this mode by press `v` in Windows, which means you can select the spcific lines of code and make changes on it.

## Coc Settings
```json
{
  "snippets.userSnippetsDirectory": "~/.config/coc/ultisnips",
  "python.pythonPath": "python3.11",
  "python.autoComplete.extraPaths": ["python3.11"],
  "python.linting.pylintPath": "python3.11",
  "snippets.ultisnips.pythonPrompt": false
}
```

## Telescope Plugin
Telescope is an amazing plugin that provides fuzzy searching capabilities. You can use it to search and navigate through all of the files.
You can install it by using the following command inside .vimrc file:

**You should install (fzf and ripgrep) first, if not have**
```
choco install fzf
choco install ripgrep
```

```
Plug 'nvim-telescope/telescope.nvim'
```

## Vim Commands
All commands that are used in this vim configuration.

**Basic Movement:**
```
h - Move the cursor left
j - Move the cursor down
k - Move the cursor up
l - Move the cursor right
```

**Insert Mode:**
```
i - Insert before the cursor
I - Insert at the beginning of the line
a - Insert after the cursor
A - Insert at the end of the line
o - Open a new line below the current line
O - Open a new line above the current line
```

**Exiting:**
```
:q - Quit (close) Vim
:w - Write (save) the file
:wq - Write and quit (save and close)
:x or :wq - Write and quit (save and close)
:q! - Quit without saving changes
ZZ - Write and quit if changes have been made
```

**Copy, Cut, Paste:**
```
yy - Yank (copy) the current line
dd - Delete (cut) the current line
p - Paste the contents of the register after the cursor
P - Paste before the cursor
```

**Undo and Redo:**
```
u - Undo the last change
Ctrl + r - Redo the last undone change
```

**Visual Mode:**
```
v - Start visual mode to select text character by character
V - Start visual line mode to select whole lines
Ctrl + v - Start visual block mode to select a block of text
```

**Word Movement:**
```
w - Move forward to the beginning of the next word
b - Move backward to the beginning of the previous word
e - Move forward to the end of the current word
```

**Line Movement:**
```
0 - Move to the beginning of the current line
$ - Move to the end of the current line
^ - Move to the first non-blank character of the current line
```

**Page Movement:**
```
Ctrl + u - Move half a page up
Ctrl + d - Move half a page down
Ctrl + b - Move one page up
Ctrl + f - Move one page down
```

**Search and Replace:**
```
/pattern - Search forward for a pattern
?pattern - Search backward for a pattern
:s/old/new - Replace the first occurrence of "old" with "new" in the current line
:s/old/new/g - Replace all occurrences of "old" with "new" in the current line
:%s/old/new/g - Replace all occurrences of "old" with "new" in the entire file
```

**Indentation:**
```
>> - Indent the current line
<< - Unindent the current line
```

**Marks:**
```
m{letter} - Set a mark at the current cursor position with {letter}
`` {letter} - Jump to the mark at {letter}
```

**Plugins:**
```
:PlugInstall - Install
:PlugClean - Clean
:PlugUpdate - Update
:PlugUninstall - Uninstall
```

**Coc:**
```
:CocInstall <package-name> - Install
:CocUninstall <package-name> - Uninstall
:CocUpdate <package-name> - Update
:CocConfig - Open coc-settings.json
:CocInfo - Know any error in coc
:CocCommand
```

## My Custom Keymap Shortcuts
In `NORMAL` mode:
`<leader>` by default equal `space`(in keyboard), but i set it to equal `,`(in keyboard).
```
CTRL + n -- to open :NERDTreeToggle
CTRL + a -- to select all
,pv -- to open file explorer
,t -- to open terminal
Esc -- to close terminal
,c -- to create and open new file in new tab
,cn -- to move and rename file to different folder
,d -- to create new folder
,o -- to create or open new file in new tab
,tc -- to close current tab
,tp -- to move tp prev tab
,tn -- to move tp next tab
```
## Codeium
In this vim ide, I'm using Codeium free AI pair programmer, you can use Github Copilot instead.

## License
**MIT**
