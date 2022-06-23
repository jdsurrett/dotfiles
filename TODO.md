# ToDo:

> In the raw file there will be commented out items.<br>
> This is for visual cleanliness.

> If it's just checked then it's most of the way done.<br>
> If it's crossed out and checked then it's finished.
 
<!-- * [X] ~~Refactor lvim configuration file.~~ -->
<!-- * [X] ~~Refactor kitty configuration file.~~ -->
<!-- * [X] ~~Refactor sway configuration file.~~ -->
<!-- * [X] ~~Fix waybar.~~ -->
<!-- * [X] ~~Fix wofi.~~ -->
<!-- * [X] ~~Setup notification daemon.~~ -->

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
* [ ] Integrate email.

## Shell scrips:

| Name         | Description               | Args | Interaction method       |
|:-------------|:--------------------------|:-----|:-------------------------|
| todo         | A todo list, wofi script  | yes  | Key binding: win+shift+t |
| chezmoi_arch | Run chezmoi in an arch VM | yes  | Custom launcher          |

## Email scrips:

### Backend:

| Name                | Description                       | Args | Interaction method       |
|:--------------------|:----------------------------------|:-----|:-------------------------|
| Email manager       | Email manager/notification daemon | N/a  | managed by systemd       |
| Email downloader    | Manage the downloading of email   | N/a  | managed by email manager |
| Email filter/router | Filter/rout emails                | N/a  | managed by email manager |

### Frontend:

| Name                | Description                 | Args | Interaction method       |
|:--------------------|:----------------------------|:-----|:-------------------------|
| Email UI            | Custom ranger configuration | yes  | Custom launcher    |
| Email render        | Render emails               | N/a  | launched by email ui     |
| Email reply         | Use nvim for email          | N/a  | launched by email ui     |
