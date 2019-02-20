module.exports = ()->
    addEventListeners()

addEventListeners = () ->
    document.addEventListener("DOMContentLoaded", addTable)


maxCells = 100
interval = -1

###
   - create grid
   - add shape motion
###
addTable = () -> 

    parent = document.body.appendChild(document.createElement('div'))
    parent.className = 'grid-container'

    for i in [0 ...maxCells]
        newElement = parent.appendChild(document.createElement('div'))
        newElement.innerHTML = '<p>' + i + '</p>'
        newElement.className = 'grid-item' + i
    a = 0

