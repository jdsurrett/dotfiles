# ToDo:

> In the raw file there will be commented out items.<br>
> This is for visual cleanliness.

 
<!-- * [X] ~~Refactor lvim configuration file.~~ -->
<!-- * [X] ~~Refactor kitty configuration file.~~ -->
<!-- * [X] ~~Refactor sway configuration file.~~ -->
<!-- * [X] ~~Fix waybar.~~ -->
<!-- * [X] ~~Fix wofi.~~ -->
<!-- * [X] ~~Setup notification daemon.~~ -->

> If it's just checked then it's most of the way done.<br>
> If it's crossed out and checked then it's finished.

* [ ] Rewrite all files.
    * [X] Configure systemd/user files.
    * [X] Write chezmoi templates.
    * [X] Redesign way bar.
    * [ ] Write environment.d files.
    * [ ] Port the lvim configuration into nvim.
    * [ ] Unify key bindings.
* [ ] Write shell scrips.
    * [ ] chezmoi_arch
    * [ ] todo
    * [ ] File manager
* [ ] Integrate email.

## Shell scrips:

| Name         | Description                             | Interaction method       |
|:-------------|:----------------------------------------|:-------------------------|
| todo         | A todo list, wofi script                | Key binding: win+shift+t |
| chezmoi_arch | Run chezmoi in an arch VM               | Custom launcher          |
| File manager | Ranger and a custom kitty configuration | Key binding: win+shift+f |

## Email scrips:

### Backend:

| Name                | Description                       | Interaction method       |
|:--------------------|:----------------------------------|:-------------------------|
| Email manager       | Email manager/notification daemon | managed by systemd       |
| Email downloader    | Manage the downloading of email   | managed by email manager |
| Email filter/router | Filter/rout emails                | managed by email manager |

### Frontend:

| Name         | Description                 | Interaction method   |
|:-------------|:----------------------------|:---------------------|
| Email UI     | Custom ranger configuration | Custom launcher      |
| Email render | Render emails               | launched by email UI |
| Email reply  | Use nvim for email          | launched by email UI |
