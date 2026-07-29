# .dotfiles

needed software 

| name    | url                                      | description           | built |
| ------- | ---------------------------------------- | --------------------- | ----- |
| glazemw | https://github.com/glzr-io/glazewm       | tiling window manager |       |
| lazygit | https://github.com/jesseduffield/lazygit | tui git client        | go    |
| fzf     | https://github.com/junegunn/fzf          | cli fuzzy finder      | go    |
| ripgrep | https://github.com/BurntSushi/ripgrep    | fast file finds       | rs    | 
| zoxide  | https://github.com/ajeetdsouza/zoxide    | modern cd replacement | rs    |
| fd      | https://github.com/sharkdp/fd            | modern find           |       |
| eza     | https://github.com/eza-community/eza     | modern ls             |       |



install 1password 

```
sudo pacman-mirrors -f
sudo rm /var/lib/pacman/sync/*
sudo pacman-key –init
sudo pacman-key –populate archlinux manjaro
sudo pacman -Syy

sudo pacman -S ansible
ansible-galaxy collection install kewlfft.aur
ansible-playbook ~/.dotfiles/.config/ansible/home.yaml --ask-become-pass
```

## symlinks

Symlinks from `~` into this repo are managed by the "Create symlinks for dotfiles" task in
`.config/ansible/home.yaml` (not stow, even though it's installed). It loops over a list of
paths and links `~/.dotfiles/<path>` -> `~/<path>`.

To add a new dotfile: add its path to the `loop` list in that task, then re-run:

```
ansible-playbook ~/.dotfiles/.config/ansible/home.yaml --ask-become-pass
```
