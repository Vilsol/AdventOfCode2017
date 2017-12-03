(DEFUN spiral (n)
    (setf n (- n 2))
    (
        let ((
            radius (+ (floor (/ (- (sqrt (+ n 1)) 1) 2)) 1)
        ))
        (
            let ((
                point (/ (* (* 8 radius) (- radius 1)) 2)
            ))
            (
                let ((
                    perface (* radius 2)
                ))
                (
                    let ((
                        pos (mod (- (+ 1 n) point) (* radius 8))
                    ))
                    (
                        let ((
                            side (floor (/ pos (* radius 2)))
                        ))
                        (
                            cond
                                ((= side 0) (values-list (list (- pos radius) (* radius -1))))
                                ((= side 1) (values-list (list radius (- (mod pos perface) radius))))
                                ((= side 2) (values-list (list (- radius (mod pos perface)) radius)))
                                ((= side 3) (values-list (list (* radius -1) (- radius (mod pos perface)))))
                        )
                    )
                )
            )
        )
    )
)

(DEFUN sumAround(dict x y)
    (setq result 0)

    (setq result (+ (getDict dict (- x 1) y) result))
    (setq result (+ (getDict dict (- x 1) (- y 1)) result))
    (setq result (+ (getDict dict (- x 1) (+ y 1)) result))

    (setq result (+ (getDict dict (+ x 1) y) result))
    (setq result (+ (getDict dict (+ x 1) (- y 1)) result))
    (setq result (+ (getDict dict (+ x 1) (+ y 1)) result))

    (setq result (+ (getDict dict x (- y 1)) result))
    (setq result (+ (getDict dict x (+ y 1)) result))

    result
)

(DEFUN getDict(dict x y)
    (if (not (gethash x dict))
        (setf (gethash x dict) (make-hash-table)))

    (setq subdict (gethash x dict))

    (if (not (gethash y subdict))
        (setf (gethash y subdict) 0))

    (gethash y subdict)
)

(DEFUN setDict(dict x y val)
    (if (not (gethash x dict))
        (setf (gethash x dict) (make-hash-table)))

    (setq subdict (gethash x dict))
    (setf (gethash y subdict) val)
)

(DEFUN process(dict n)
    (setf (values x y) (spiral n))
    (setf summed (sumAround dict x y))
    (setDict dict x y summed)
)

(DEFUN looper (n)
    (setq dict (make-hash-table))
    (setDict dict 0 0 1)
    
    (setf i 2)
    (setf pos 0)
    (loop while (<= pos n)
        do (setf pos (process dict i))
        do (setf i (+ i 1))
    )

    (setf (values x y) (spiral (- i 1)))
    (print (getDict dict x y))
)

(looper 325489)