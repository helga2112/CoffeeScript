square = (a) -> a * a
quadratic = (a, b, c) -> 
    rez1
    rez2

    d = b * b - 4 * a * c
    console.log d
    if d is 0 
        rez1 = -1 *  b / (2 * a )  
        console.log  'result 1 = ', rez1
    else if d > 0
        rez1 = (-b + Math.sqrt d ) / (2 * a)
        rez2 = (-b - Math.sqrt d ) / (2 * a)
        console.log 'result 1 = ', rez1, 'result 2 = ', rez2 
    else if d < 0
        console.log 'there is no answer'


quadratic 1 , -70, 600