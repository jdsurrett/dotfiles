# ToDo:

* [X] ~~Refactor lvim configuration file.~~
* [X] ~~Refactor kitty configuration file.~~
* [X] ~~Refactor sway configuration file.~~
* [X] ~~Fix waybar.~~
* [X] ~~Fix wofi.~~
* [X] ~~Setup notification daemon.~~
* [ ] Rewrite all files.
    * [ ] Write chezmoi templates.
    * [ ] Redesign way bar.
    * [ ] Write environment.d files.
    * [ ] Configure systemd/user files.
    * [ ] Port the lvim configuration into nvim.
    * [ ] Unify key bindings.
* [ ] Write shell scrips.
    * [ ] chezmoi_cd
    * [ ] todo
* [ ] Integrate email.

## Shell scrips:

| Name       | Description              | Args   | Interaction method       |
|:-----------|:-------------------------|:-------|:-------------------------|
| todo       | A todo list, wofi script | --help | Key binding: win+shift+t |
| chezmoi_cd | Run chezmoi in a VM      | --help | Run by chezmoi           |
