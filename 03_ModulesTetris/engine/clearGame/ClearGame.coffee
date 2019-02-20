settings = require('../../utils/GameSettings.coffee')
module.exports = () ->
    redrawGameField()

#clean prev cells
redrawGameField = () ->
    clean = document.getElementsByTagName('div')
    [].forEach.call(clean, (item) -> 
        unless item.className is 'grid-container' 
            num = item.className.slice('grid-item'.length, item.className.length)
            unless settings.takenCells.includes +num
                item.style.backgroundColor = 'rgba(255, 255, 255, 0.8)')