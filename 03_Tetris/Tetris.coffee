maxCells = 100
gridStep = 10
interval = -1

figures = ['square', 'shifted', 'corner', 'letterT', 'tower']


shapes = {
    square: [0, 1, 10, 11]
    shifted:[0, 1, 11, 12]
    corner: [0, 10, 20, 21]
    letterT:[0, 1, 2, 11]
    tower:  [0, 10, 20, 30]
}

takenCells = []

###
   - create grid
   - add shape motion
###
ready = () -> 
        parent = document.body.appendChild(document.createElement('div'))
        parent.className = 'grid-container'

        for i in [0 ...maxCells]
              newElement = parent.appendChild(document.createElement('div'))
              newElement.innerHTML = '<p>' + i + '</p>'
              newElement.className = 'grid-item' + i
        a = 0
       interval = setInterval ( -> addItem()),
                         1000

###
    Move the shape
###                     
onKeyup = (e) -> 
    if e.keyCode is 37
        if(a.isMoving)
            a.shift -1
    else if e.keyCode is 39
        if(a.isMoving)
            a.shift 1


document.addEventListener("DOMContentLoaded", ready)
document.addEventListener('keyup', onKeyup)



class Figure
    colors = ['green', 'yellow', 'blue', 'aqua', 'pink' ]
    colorSelected = 'green'
    colorPrev = 'rgba(255, 255, 255, 0.8)'
    shape: []
    isMoving: false
    
    # move the figure to the right or to the left (on user key up)
    shift: (num)->
        if(canShift(@shape, num))
            for i of @shape
                temp = document.getElementsByClassName('grid-item' + @shape[i])
                temp[0].style.backgroundColor = colorPrev

            for i of @shape
                @shape[i] += num 
                temp = document.getElementsByClassName('grid-item' + @shape[i])
                temp[0].style.backgroundColor = 'green'


    # check if the figure can be shifted
    canShift = (arr, num) ->
        if num < 0 
         for t of arr
            if (+arr[t]  + num) % gridStep  < 0 
                return false

        if num > 0
            for t of arr
                if (+arr[t] % gridStep + num)  >= gridStep 
                    return false
         return true

    # move the figure down each second
    move: (newPos) ->
            if newPos
                for i of @shape
                    @shape[i] += newPos
                    temp = document.getElementsByClassName('grid-item' + @shape[i])
                    temp[0].style.backgroundColor = colorSelected

            else
                #clean prev cells
                clean = document.getElementsByTagName('div')
                [].forEach.call(clean, (item) -> 
                    unless item.className is 'grid-container' 
                        num = item.className.slice('grid-item'.length, item.className.length)
                        unless takenCells.includes +num
                            item.style.backgroundColor = 'rgba(255, 255, 255, 0.8)')

                # check if can continue moving
                if canContinue(@shape, takenCells, gridStep)
                    setColor @shape, gridStep
                    
                else
                    setColor @shape
                    @isMoving = false
                    takenCells = [...takenCells, ...@shape]
                    return  

    setColor = (array, delta = 0) ->
         for i of array
            array[i] = array[i] + delta
            temp = document.getElementsByClassName('grid-item' + array[i])
            temp[0].style.backgroundColor = colorSelected

    #check if the shape can move on
    canContinue = (array, takenCells, gridStep) ->
             a = array.slice()
            # a.forEach((element)-> element + gridStep)
            
             for i of a 
                a[i] += gridStep
                if takenCells.includes a[i]
                    return false
                else if a[i] > maxCells
                    return false
             return true 


removeLines = () ->
    controll = 0
    for a in [0...gridStep]
        controll += a
       
    r = []
    takenCells = takenCells.sort()
    currentRow = -1
    rowSum = 0
    rowToRemove = []

    if takenCells.length > 0
        for i of takenCells 
            d = Math.floor(takenCells[i] / gridStep)
            if d isnt currentRow
                if rowSum is controll
                    removeRow(rowToRemove)
                    start = takenCells.indexOf rowToRemove[0]
                    end = takenCells.indexOf rowToRemove[rowToRemove.length]
                    takenCells = takenCells.slice(start, end)
                rowSum = 0
                currentRow = d
                rowToRemove = []
                
            rowSum += takenCells[i] % gridStep
            rowToRemove.concat takenCells[i]


removeRow = (array) -> 
    for i of array   
        temp = document.getElementsByClassName('grid-item' + array[i])
        temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)'


checkMoves = ()->
    for a in [0...9]
        if takenCells.indexOf(a) > -1
            console.log 'STOP'
            clearInterval interval

a = new Figure()

addItem =-> 
       if !a.isMoving
            removeLines()
            checkMoves()
            a.isMoving = true
            
            # define random figure
            ind = 0 #Math.floor(Math.random() * 5)
            ramdonFigure = figures[ind]
            a.shape = shapes[ramdonFigure].slice()

            # make it move
            a.move(Math.round (Math.random() * 10))
        else
            a.move()



        
        