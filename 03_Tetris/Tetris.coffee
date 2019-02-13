maxCells = 100
gridStep = 10
interval = -1

colorSelected = 'lavender'
colorPrev = 'rgba(255, 255, 255, 0.8)'
shape = []
isMoving = false
currentFigure = ''
isFigureRotated = false

figures = ['square', 'shifted', 'corner', 'letterT', 'tower']
colors = ['slateblue', 'yellow', 'lightgreen', 'darkturquoise', 'pink' ]


shapes = {
    square: [0, 1, 10, 11]
    shifted:[0, 1, 11, 12]
    corner: [0, 10, 20, 21]
    letterT:[0, 1, 2, 11]
    tower:  [0, 10, 20, 30]
}

rotated = {
    square: [0, 1, 10, 11],
    shifted: [1, 10, 11, 20],
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
    interval = setInterval ( -> addItem()), 500

###
    Move the shape
###                     
onKeyup = (e) -> 
    if e.keyCode is 37   # <=
        if(isMoving)
            shift shape, -1
    else if e.keyCode is 39 # =>
        if(isMoving)
            shift shape, 1
    else  if e.keyCode is 32 # Space
        rotateFigure()


document.addEventListener("DOMContentLoaded", ready)
document.addEventListener('keyup', onKeyup)


rotateFigure = () ->
    ###
    square: [0, 1, 10, 11]
    shifted:[0, 1, 11, 12]
    corner: [0, 10, 20, 21]
    letterT:[0, 1, 2, 11]
    tower:  [0, 10, 20, 30]
    ###

    switch currentFigure
        when 'shifted' then 1
        when 'corner' then 1
        when 'letterT' then 1
        when 'tower' then 1

# move the figure to the right or to the left (on user key up)
shift = (arr, num)->
    if(canShift(arr, num))
        for i of arr
            temp = document.getElementsByClassName('grid-item' + arr[i])
            temp[0].style.backgroundColor = colorPrev

        for i of arr
            arr[i] += num 
            temp = document.getElementsByClassName('grid-item' + arr[i])
            temp[0].style.backgroundColor = colorSelected




# check if the figure can be shifted
canShift = (arr, num) ->
    if num < 0 
        for t of arr
            if takenCells.includes +arr[t] + num
                return false
            row = Math.floor +arr[t] / gridStep  
            newRow = Math.floor (+arr[t]  + num) / gridStep
            if newRow != row
                return false

    if num > 0
        for t of arr
            if takenCells.includes +arr[t] + num
                return false
            else if (+arr[t] % gridStep + num)  >= gridStep 
                return false
    return true

   
   

# move the figure down each second
move = (shape, newPos) ->
    if newPos
        for i of shape
            shape[i] += newPos
            temp = document.getElementsByClassName('grid-item' + shape[i])
            temp[0].style.backgroundColor = colorSelected
    else
        #clean prev cells
        redrawGameField()

        # check if can continue moving 
        canMoveOn = canContinue(shape, takenCells, gridStep)
        if canMoveOn
            setColor shape, gridStep
        else
            setColor shape
            isMoving = false
            takenCells = [...takenCells, ...shape]
            return  

#clean prev cells
redrawGameField = () ->
    clean = document.getElementsByTagName('div')
    [].forEach.call(clean, (item) -> 
        unless item.className is 'grid-container' 
            num = item.className.slice('grid-item'.length, item.className.length)
            unless takenCells.includes +num
                item.style.backgroundColor = 'rgba(255, 255, 255, 0.8)')

# set color to Figure
setColor = (array, delta = 0) ->
    for i of array
        array[i] = array[i] + delta
        temp = document.getElementsByClassName('grid-item' + array[i])
        temp[0].style.backgroundColor = colorSelected
    return



#check if the shape can move on
canContinue = (array, takenCells, gridStep) ->
   # a = array.slice()
    a = array.map (item) -> item + gridStep
    for i of a 
        if takenCells.includes a[i]
            return false
        else if a[i] > maxCells
            return false
    return true 



removeLines = () ->
    controll = 0
    takenCells = takenCells.sort()
    toRemove = []
    current = -1

    if takenCells.length > 0
        count = 0
        current = Math.floor(takenCells[0] / 10)
        tempArr = []
        for i of takenCells
            row = Math.floor(takenCells[i] / 10)
            if current == row
                temp = document.getElementsByClassName('grid-item' + takenCells[i])
                if temp[0].style.backgroundColor == colorSelected
                   tempArr.push takenCells[i]
                   if tempArr.length == gridStep 
                       toRemove = toRemove.concat tempArr
                       current += 1
                       tempArr = []
            else 
                tempArr = []
                tempArr.push takenCells[i]
                current = row

     removeRow(toRemove)        
               

          

moveLinesDown = () ->
    for r of takenCells   
        temp = document.getElementsByClassName('grid-item' + takenCells[r])
        temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)'
    step = Math.floor (maxCells - takenCells[takenCells.length - 1]) / gridStep
    takenCells = takenCells.map (element)-> element + step * gridStep

    for i of takenCells   
        temp = document.getElementsByClassName('grid-item' + takenCells[i])
        temp[0].style.backgroundColor = colorSelected


removeRow = (array) -> 
    if array.length > 0
        start = takenCells.indexOf array[0]
        end = takenCells.indexOf array[array.length - 1]
        takenCells.splice start, end + 1 
        for i of array   
            temp = document.getElementsByClassName('grid-item' + array[i])
            temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)'
    
        moveLinesDown()


checkMoves = ()->
    for a in [0...9]
        if takenCells.indexOf(a) > -1
            console.log 'STOP'
            clearInterval interval

getNewPosition = (shape, ramdonFigure) ->
    diapazon = 8
    #'square', 'shifted', 'corner', 'letterT', 'tower'
    switch ramdonFigure 
        when 'shifted' then diapazon = 7
        when 'letterT' then diapazon = 7
        when 'tower' then diapazon = 9

    pos = Math.round (Math.random() * diapazon)
    return pos


addItem = () -> 
    if !isMoving
        removeLines()
        checkMoves()
        isMoving = true
        
        # define random figure
        ind = Math.floor(Math.random() * 5)
        currentFigure = figures[ind]
        shape = shapes[currentFigure].slice()
        colorSelected = colors[ind]
        # make it move
        pos = getNewPosition shape, currentFigure
        move shape, pos
    else
        move shape