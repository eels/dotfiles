# dotfiles

Another .dotfiles repository, except this one is mine.

## Installation

### Clone

```bash
git clone https://github.com/eels/dotfiles ~/.dotfiles
```

### Install Xcode Command Line Tools

```bash
xcode-select --install
```

### Bootstrap

```bash
cd ~/.dotfiles
bash bootstrap.sh
```

## Local Secrets & Other Personal Items

To keep environment variables and other personal tokens out of the commit history, create a `.localrc` file in the root of the project directory and `.bash_profile` will automatically pick it up. Magic :sparkles:

## License

MIT - see the [LICENSE.md](https://github.com/eels/dotfiles/blob/main/LICENSE.md) file for details

## Acknowledgments

Thanks to the countless other developers who've uploaded and shared their own dotfiles for me to obsessively trawl through and cherry pick my favourite ideas
