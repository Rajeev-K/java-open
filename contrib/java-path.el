
;;From: Bruce Ingalls <bruce@conde-dev.com>
;;Reply-to: bingalls@panix.com 

;;I added this code to EMacro, as default settings for
;;java-open-source-path. You may wish to add this to a future version of
;;java-open.el. EMacro does support java-open. Let me know of updates.

;;Default to using CLASSPATH for finding java source files
;;Help from Benjamin Rutt <brutt@bloomington.in.us>
    (cond ((or (eq "ms-dos" system-type)
              (string-match "windows" (format "%s" system-type)))
           (setq java-open-source-path
                 (delq nil
                       (mapcar (lambda (x) (if (file-directory-p x) x nil))
                               (split-string (getenv "CLASSPATH") ";")))))
          (t		;Linux (mac?) separate paths with ":"
           (setq java-open-source-path
                 (delq nil
                       (mapcar (lambda (x) (if (file-directory-p x) x nil))
                               (split-string (getenv "CLASSPATH") ":"))))))

;;This searches out all the directories that I have in my CLASSPATH, as I
;;usually also keep my *.java source files there, too. I usually include
;;"." in CLASSPATH, fwiw.
