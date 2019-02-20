settings = {
    timerInterval: -1
    gridStep: 10
    speed: 500
    maxCells: 100

    isMoving: false

    colorSelected: 'lavender'
    currentFigure:''

    figures: ['square', 'shifted', 'corner', 'letterT', 'tower']
    colors: ['slateblue', 'yellow', 'lightgreen', 'darkturquoise', 'pink' ]
    takenCells: []
    shape: []

    shapes : {
        square: [0, 1, 10, 11]
        shifted:[0, 1, 11, 12]
        corner: [0, 10, 20, 21]
        letterT:[0, 1, 2, 11]
        tower:  [0, 10, 20, 30]
}


}

module.exports = settings