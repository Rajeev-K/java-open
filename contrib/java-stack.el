;java-open based java stack trace processing
; Author: Kevin A. Burton (burton@apache.org)

;TODO: 
; - split the current buffer and open the file up in the other window
; - don't always return errors... return nill so that it can be 
;   integrated with the native java-open

(defvar java-open-stacktrace-error "Not a java stack trace entry" )

(defun java-open-use-stacktrace() 
  "function which allows you to jump to the file and line in a 
   java stacktrace exception"

  (interactive)

  ;require that this current buffer is a .java file
  ;(if (not (string-equal (file-name-extension (buffer-name)) "java"))
  ;    (error "This is not a java source file"))

  (beginning-of-line)
  
  ;WARNING: I don't know if this works under NT.  The regexp 
  ;has reported to be wrong in some reasons.

  (setq case-fold-search nil)

  ;this should bring us to the start of the stacktrace
  (if (not (search-forward "\tat " nil t))
      (error java-open-stacktrace-error))

  ;search for the whole classname
  (if (not (search-forward-regexp "[a-z]+\\(\\.[a-z]+\\)+\\.\\([A-Z][a-z]*\\)+" nil t))
      (error java-open-stacktrace-error))

  ;get the classname as a variable
  (setq java-open-stacktrace-classname (match-string 0))

  ;get the line number
  (if (not (search-forward ":" nil t))
      (error java-open-stacktrace-error))

  (if (not (search-forward-regexp "[0-9]+" nil t))
      (error java-open-stacktrace-error))


  (setq java-open-stacktrace-linenumber (match-string 0))

  ;debug info
  (message (concat java-open-stacktrace-classname ":" java-open-stacktrace-linenumber))

  ;use java-open with the classname and get the file

  (setq java-open-stack-filename (java-open-get-filename java-open-stacktrace-classname))

  ;make sure that java-open-class worked
  (if (not java-open-stack-filename) 
      (error "class was not found in source path"))

  ;set to the correct buffer
  (set-buffer (file-name-nondirectory java-open-stack-filename))

  ;open this file in another window
  (find-file-other-window java-open-stack-filename)

  ;change to the current line
  (goto-line 0)
  (vertical-motion (- (string-to-int java-open-stacktrace-linenumber) 1) )

)
