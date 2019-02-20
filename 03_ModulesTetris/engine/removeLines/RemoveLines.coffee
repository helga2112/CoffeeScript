settings = require('../../utils/GameSettings.coffee')
###
    get data from GameSettings and pass
    it to variables with the help of destructurization
###
{gridStep, speed, maxCells, isMoving,
colorSelected, currentFigure, figures,
colors, takenCells, shape, shapes} = settings

module.exports = () ->
    removeLines()


removeLines = () ->
    controll = 0
    settings.takenCells = settings.takenCells.sort()
    toRemove = []
    current = -1

    if settings.takenCells.length > 0
        count = 0
        current = Math.floor(settings.takenCells[0] / 10)
        tempArr = []
        for i of settings.takenCells
            row = Math.floor(settings.takenCells[i] / 10)
            if current == row
                temp = document.getElementsByClassName('grid-item' + settings.takenCells[i])
                console.log settings.colorSelected
                if temp[0].style.backgroundColor == settings.colorSelected
                   tempArr.push settings.takenCells[i]
                   if tempArr.length == gridStep 
                       toRemove = toRemove.concat tempArr
                       current += 1
                       tempArr = []
            else 
                tempArr = []
                tempArr.push settings.takenCells[i]
                current = row

     removeRow(toRemove) 


removeRow = (array) -> 
    if array.length > 0
        start = settings.takenCells.indexOf array[0]
        end = settings.takenCells.indexOf array[array.length - 1]
        settings.takenCells.splice start, end + 1 
        for i of array   
            temp = document.getElementsByClassName('grid-item' + array[i])
            temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)'
    
        moveLinesDown()


moveLinesDown = () ->
    for r of settings.takenCells   
        temp = document.getElementsByClassName('grid-item' + settings.takenCells[r])
        temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)'
    step = Math.floor (maxCells - settings.takenCells[takenCells.length - 1]) / gridStep
    settings.takenCells = settings.takenCells.map (element)-> element + step * gridStep

    for i of settings.takenCells   
        temp = document.getElementsByClassName('grid-item' + settings.takenCells[i])
        console.log settings.colorSelected
        temp[0].style.backgroundColor = settings.colorSelected