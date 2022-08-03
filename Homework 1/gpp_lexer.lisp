(setq keywords '("and" "or" "not" "equal" "less" "nil" "list" "append" "concat" "set" "deffun" "for" "if" "exit" "load" "disp" "true" "false"))
(setq kwords '("KW_AND" "KW_OR" "KW_ NOT" "KW_EQUAL" "KW_LESS" "KW_NIL" "KW_LIST" "KW_APPEND" "KW_CONCAT" "KW_SET" "KW_DEFFUN" "KW_FOR" "KW_IF" "KW_EXIT" "KW_LOAD" "KW_DISP" "KW_TRUE" "KW_FALSE"))
(setf operators '("+" "-" "/" "*"  "(" ")" "**" "\"" "\"" ","))
(setf ooperators '("OP_PLUS" "OP_MINUS" "OP_DIV" "OP_MULT" "OP_OP" "OP_CP" "OP_DBLMULT" "OP_OC" "OP_CC" "OP_COMMA"))
(setq flag 0)
(defvar temp 0)
(defvar index -1)

(defun read_file (file_name)
	(with-open-file (stream file_name)
		(loop for line = (read-line stream nil)
			while line do (control (my-split line))))
)

;spliting string function is taken from this link.			
;https://stackoverflow.com/questions/15393797/lisp-splitting-input-into-separate-strings/24963458 
(defun my-split (string &key (delimiterp #'delimiterp))
  (loop :for beg = (position-if-not delimiterp string)
    :then (position-if-not delimiterp string :start (1+ end))
    :for end = (and beg (position-if delimiterp string :start beg))
    :when beg :collect (subseq string beg end)
    :while end))

(defun delimiterp (c) (or (char= c #\Space) (char= c #\,)))


(defun control(flist)
	(setq flag 0)
	(dolist (i flist)
		(check_comment i)
		(if(not(= flag -3))(progn(check_op i) (if (= flag -1)(check_others i)))
		) 
	)
)
(defun check_keywords (word)
	(dolist (i keywords)
		(if (equal word i) (setq index temp) (incf temp))
	)
	(if (>= index 0) (progn (write-line (nth index kwords))(setq flag 1)) (setq flag -1))
	(setq temp 0)
	(setq index -1)
)
(defun check_value (word)
	(setq temp2 0)
	(dotimes (n (length word))
		(if (= temp2 0) (if(and(CHAR> (char word n) #\.) (CHAR< (char word n) #\:))(setq temp2 1) (setq temp2 -1)))
	)
	(if (= temp2 1) (progn (write-line "VALUE") (setq flag 1)))
)

(defun check_comment (word)
	(if (> (length word) 1) (if (equal (subseq word 0 2) ";;")(progn (write-line "COMMENT") (setq flag -3))))

)


(defun check_others (word)
	(dolist (i operators)
		(setq word(remove (char i 0)  word))
	)
	(if (= flag -1)(check_value word))
	(if (= flag -1)(check_keywords word))
	(if (= flag -1)(write-line "IDENTIFER"))
)

(defun check_op (word)

	(setq index -1)
	(setq temp 0)
	(dotimes (n (length word))
		(dolist (i operators)
			(if (char= (char word n) (char i 0)) (setq index temp) (incf temp))
		)
		(if (>= index 0) (write-line (nth index ooperators)) (setq flag -1))
		(setq temp 0)
		(setq index -1)
	)
)

(defun gppinterpreter()
	(write-line "Enter a file name (For entering input enter 0)")
	(defvar input(read-line))
	(if (equal input "0")(getinput)(read_file input))
)

(defun getinput ()
	(defvar value(read-line))
	(setq flist(my-split value))
	(control flist)
)

(gppinterpreter)
