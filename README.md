# `mdgd` - Markdown to Google Doc

CLI utility to create a Google doc from Markdown input.

Tested on OSX, but might work in other `bash` environments.

## Installation

Dependencies: 
- [gdrive](https://github.com/prasmussen/gdrive)
- [markdown-it](https://github.com/markdown-it/markdown-it) installed globally (.e. `npm install -g markdown-it`)

```
git clone https://github.com/colophonemes/mdgd
# optional - symlink somwhere in your path
cd mdgd && ln -s "$PWD/mdgd.sh" /usr/local/bin/mdgd
```

## Usage

### From file:
```sh
$ mdgd /path/to/file.md "Your Filename"
```

### From STDIN:
```sh
$ echo **Some Markdown** | mdgd - "Your Filename"
```
