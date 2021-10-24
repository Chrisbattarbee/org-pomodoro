;;; org-pomodoro.el --- Pomodoro with support for org / agenda
;;; Commentary:
;;  A package which allows you to perform the pomodoro methodology using
;;  your org mode TODOs as input

;;; Dependencies:
;;  * terminal-notifier (brew install terminal-notifier)

;;; Code:

(defvar org-pomodoro.el/pomodoro-task-length "25 minute"
  "The length of time to run a pomodoro task for.")

(defvar org-pomodoro.el/pomodoro-break-length "5 minute"
  "The length of time to have as a break between pomodoro tasks.")

(defvar org-pomodoro.el/terminal-notifier-command
  (executable-find "terminal-notifier")
  "The path to terminal-notifier.")

(defun terminal-notifier-notify (title message)
  "Show a MESSAGE with TITLE using `terminal-notifier-command`."
  (start-process "terminal-notifier"
                 "*terminal-notifier*"
                 org-pomodoro.el/terminal-notifier-command
                 "-title" title
                 "-message" message
                 "-activate" "org.gnu.Emacs"
                 "-ignoreDnD"
                 ))


(defun org-agenda-switch-to-if-agenda-mode () "If we are in agenda mode, switch to the org mode item under point."
  (when (equal major-mode 'org-agenda-mode)
    (org-agenda-switch-to)))

(defun org-pomodoro-start ()
  "Look at the current agenda view to get items for pomodoro."
  (interactive "")
  (let ((oldbuf (current-buffer)))
    (org-agenda-switch-to-if-agenda-mode)
    (let ((heading (nth 4 (org-heading-components))))

      (terminal-notifier-notify (concat "Pomodoro started (" org-pomodoro.el/pomodoro-task-length " task)")
                                heading)
      (run-at-time org-pomodoro.el/pomodoro-task-length
                   nil
                   #'(lambda (first-title first-message second-title second-message)
                       (progn
                         (terminal-notifier-notify first-title first-message)
                         (run-at-time org-pomodoro.el/pomodoro-break-length nil 'terminal-notifier-notify second-title second-message)
                         ))
                   "Pomodoro finished"
                   heading
                   "Pomodoro Break Over"
                   ""
                   )
      (switch-to-buffer oldbuf))))


(provide 'org-pomodoro)
;;; org-pomodoro.el ends here
