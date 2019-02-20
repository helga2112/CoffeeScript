settings = require('../utils/GameSettings.coffee')
removeLines = require('./removeLines/RemoveLines.coffee')
initUserActions = require('./userActions/userActions.coffee')
move = require ('./moveShape/Motion.coffee')
checkMoves = require ('./checkGameOver/checkGameOver.coffee')

###
    get data from GameSettings and pass
    it to variables with the help of destructurization
###
{gridStep, speed, maxCells, isMoving,
colorSelected, currentFigure, figures,
colors, takenCells, shape, shapes} = settings



module.exports = ()->
    settings.timerInterval = setInterval ( -> start()), speed
    initUserActions()


start = () -> 
    if !settings.isMoving
        settings.isMoving = true
        removeLines()
        checkMoves()

        # define random figure
        settings.shape = createNewShape()
        pos = getNewPosition settings.shape, currentFigure
        move settings.shape, pos
    else
        move settings.shape



###
   creates new shape
###
createNewShape = ()->
    ind = Math.floor(Math.random() * 5)
    currentFigure = figures[ind]
    newShape = shapes[currentFigure].slice()
    settings.colorSelected = colors[ind]
    return newShape


###
    defines the position of a new shape so, that it fits the game field 
###
getNewPosition = (shape, ramdonFigure) ->
    diapazon = 8
    switch ramdonFigure 
        when 'shifted' then diapazon = 7
        when 'letterT' then diapazon = 7
        when 'tower' then diapazon = 9

    pos = Math.round (Math.random() * diapazon)
    return pos