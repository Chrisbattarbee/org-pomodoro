# org-pomodoro.el

A small package which allows you to run a pomodoro based workflow based on your org-mode todos.
It will create a notification when it is time to stop your task and another notification when it is time to select another task.

## Usage 
Put the cursor over the todo item (either in an agenda view or in the org file itself), run `org-pomodoro-start` / `M-p`.

Customizable variable:
* `org-pomodoro.el/pomodoro-task-length`: The length of time to run a pomodoro task for.
* `org-pomodoro.el/pomodoro-break-length`: The length of time to have as a break between pomodoro tasks.
* `org-pomodoro.el/terminal-notifier-command`: The path to terminal-notifier.
* `org-pomodoro.el/bind-key`: The shortcut to run org-pomodoro-start.

## Dependencies
* [terminal-notifier](https://github.com/julienXX/terminal-notifier) `brew install terminal-notifier`
