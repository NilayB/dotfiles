# dotfiles

My Linux (Arch) terminal setup: a `.bashrc`, a set of [Starship](https://starship.rs) prompt presets with a quick switcher, and a Konsole colorscheme. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's inside

```
dotfiles/
├── bash/
│   └── .bashrc                          # aliases, prompt fallback, sprompt switcher
├── starship/
│   └── .config/starship/
│       └── *.toml                       # Starship presets
├── konsole/
│   └── .local/share/konsole/
│       └── Koda-Konsole.colorscheme     # Konsole port of the Koda theme
├── LICENSE
└── README.md
```

Each top-level folder is a Stow package. The path inside it mirrors the path relative to `$HOME`, so `starship/.config/starship/foo.toml` ends up at `~/.config/starship/foo.toml`.

## Install

```bash
git clone git@github.com:<you>/dotfiles.git ~/dotfiles
cd ~/dotfiles

# dependencies
sudo pacman -S --needed stow starship konsole bash-completion ttf-jetbrains-mono-nerd

# Stow refuses to overwrite existing files, so move the default bashrc away
mv ~/.bashrc ~/.bashrc.bak

# create the symlinks
stow bash starship konsole

# reload the shell
source ~/.bashrc
```

Then, in Konsole: **Settings → Edit Current Profile → Appearance**, pick the **Koda-Konsole** colorscheme, and set the font to a Nerd Font (for example *JetBrainsMono Nerd Font*). Without a Nerd Font, the powerline-style presets show broken glyphs.

Stow can also be used per package, e.g. `stow starship` on its own. To remove the links again: `stow -D bash starship konsole`.

## Switching Starship presets

`.bashrc` defines a `sprompt` function that points Starship at a preset for the current shell:

```bash
sprompt <preset-name>    # switch (Tab completes names)
sprompt                  # list available presets
```

New terminals start with the default preset set near the bottom of `.bashrc`. Change the `STARSHIP_CONFIG` line there to pick a different default.

Because the active preset is chosen through the `STARSHIP_CONFIG` environment variable, there is no `~/.config/starship.toml` to manage.

## Notes

- If Starship isn't installed, the `.bashrc` falls back to a plain colored prompt instead of erroring.
- If Konsole doesn't list the colorscheme after stowing, restart Konsole. If it still doesn't show up, copy the file instead of linking it:
  `cp konsole/.local/share/konsole/*.colorscheme ~/.local/share/konsole/`

## License and attribution

This repository is released under the [MIT License](LICENSE). Parts derived from other projects are credited below.

- **`starship/`**: based on the presets from the [Starship presets page](https://starship.rs/presets/), with my own modifications. Starship's own license applies to the original material.
- **`konsole/`**: a Konsole port of the [Koda](https://github.com/oskarnurm/koda.nvim) theme by oskarnurm, with minor modifications. Koda's own license applies to the original material.
