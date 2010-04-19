;;; peggy.el --- The game of Master Mind

;; Copyright (c) 2010 Søren Lund <soren@lund.org>

;; Author: Søren Lund <soren@lund.org>
;; Version: 1.0
;; Keywords: game

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is my humble attempt of implementing the game of Master Mind.

;;; History

;; 1.0 - Initial release

;;; Code:

(setq peggy-version 1.0)

(defun peggy ()
  "Swith to *peggy* buffer and play a game."
  (interactive)
  (switch-to-buffer "*peggy*")
  (peggy-mode))

(defun peggy-mode ()
  "Major mode for playing peggy."
  (interactive)
  (text-mode)
  (make-peggy-variables)
  (use-local-map peggy-mode-map)
  (setq mode-name "Peggy")
  (turn-on-auto-fill)
  (peggy-welcome)
  (message "%s" (cdr (assoc "r" color-keys-alist))))


(defun peggy-welcome ()
  "Print welcome screen."
  (insert (format "Peggy v%s - Copyright (c) 2010 Søren Lund\n" peggy-version )
	  "Commands: help, quit\n"))


(defun make-peggy-variables ()
  (make-local-variable 'colors)
  (setq colors '("red" "green" "blue" "yellow" "purple" "cyan"))
  (make-local-variable 'color-keys-alist)
  (setq color-keys-alist (mapcar (lambda (x) (cons (substring x 0 1) x)) colors)))

(defvar peggy-mode-map nil)
(if peggy-mode-map
    nil
  (setq peggy-mode-map (make-sparse-keymap))
  (define-key peggy-mode-map "\n" 'peggy-io)
  (define-key peggy-mode-map "\r" 'peggy-io))

(defun peggy-io nil)

;;; peggy.el ends here
