;;; ob-openbabel.el --- org-babel functions for openbabel conversion

;; Author: Jiajie Chen
;; Keywords: org babel, openbabel
;; Homepage: https://github.com/jiegec/ob-openbabel
;; Package-Version: 0.1
;; Package-Requires: ()

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(require 'ob)
(require 'ob-ref)
(require 'ob-comint)
(require 'ob-eval)

(defvar org-babel-default-header-args:openbabel `((:input-format . "smi")
						  (:output-format . "svg")
						  (:other-options . "")))

(defun org-babel-execute:openbabel (body params)
  "Convert a block of openbabel-compatible chemical data with org-babel.
This function is called by `org-babel-execute-src-block'"
  (let* ((temp-file (make-temp-file "openbabel-temp"))
	 (command-line (format "babel %s -i%s -o%s %s"
			       temp-file
			       (cdr (assq :input-format params))
			       (cdr (assq :output-format params))
			       (cdr (assq :other-options params)))))
    (message temp-file)
    (with-temp-file temp-file
      (insert (org-babel-chomp body)))
    (message command-line)
    (org-babel-eval command-line
		    "")))

(defun org-babel-prep-session:openbabel (session params)
  "Prepare SESSION according to the header arguments specified in PARAMS."
  )

(provide 'ob-openbabel)
;;; ob-openbabel.el ends here
