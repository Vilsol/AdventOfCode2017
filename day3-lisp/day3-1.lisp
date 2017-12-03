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
                                ((= side 0) (print (+ radius (abs (- pos radius)))))
                                ((= side 1) (print (+ radius (abs (- (mod pos perface) radius)))))
                                ((= side 2) (print (+ radius (abs (- radius (mod pos perface))))))
                                ((= side 3) (print (+ radius (abs (- radius (mod pos perface))))))
                        )
                    )
                )
            )
        )
    )
)

(spiral 325489)