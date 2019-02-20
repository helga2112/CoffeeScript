settings = require('../../utils/GameSettings.coffee')
colorSelected = settings.colorSelected
gridStep = settings.gridStep
colorPrev = settings.colorPrev

module.exports = ()->
    document.addEventListener('keyup', onKeyup)

onKeyup = (e) -> 
    console.log settings.shape
    if e.keyCode is 37   # <=
        if(settings.isMoving)
            shift settings.shape, -1
    else if e.keyCode is 39 # =>
        if(settings.isMoving)
            shift settings.shape, 1
    else  if e.keyCode is 32 # Space
        rotateFigure()


# move the figure to the right or to the left (on user key up)
shift = (arr, num)->
    if(canShift(arr, num))
        for i of arr
            temp = document.getElementsByClassName('grid-item' + arr[i])
            temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)'

        for i of arr
            arr[i] += num 
            temp = document.getElementsByClassName('grid-item' + arr[i])
            temp[0].style.backgroundColor = colorSelected
        console.log 'canShift >>' + arr



# check if the figure can be shifted
canShift = (arr, num) ->
    if num < 0 
        for t of arr
            if settings.takenCells.includes +arr[t] + num
                return false
            row = Math.floor +arr[t] / gridStep  
            newRow = Math.floor (+arr[t]  + num) / gridStep
            if newRow != row
                return false

    if num > 0
        for t of arr
            if settings.takenCells.includes +arr[t] + num
                return false
            else if (+arr[t] % gridStep + num)  >= gridStep 
                return false
    return true