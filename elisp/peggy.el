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
(setq peggy-program "Brain")
(setq peggy-copyright "Copyright 2010")
(setq peggy-author "Søren Lund")

(defun peggy ()
  "Play the game."
  (interactive)
  (peggy-welcome)
  (let (colors)
    (setq colors '("red" "green" "blue" "yellow" "purple" "cyan"))
    (setq color-keys-alist (mapcar (lambda (x) (cons (substring x 0 1) x)) colors))
    (message "%s" (cdr (assoc "r" color-keys-alist)))))

(defun peggy-welcome ()
  "Initialize a new buffer and print welcome screen."
  (let (buffer)
    (setq buffer (get-buffer-create "*Peggy*"))
    (switch-to-buffer buffer)
    (erase-buffer)
    (insert (format "%s v%s - %s %s\nCommands: help, quit\n"
		    peggy-program peggy-version peggy-copyright peggy-author))
  nil))

;;; peggy.el ends here
