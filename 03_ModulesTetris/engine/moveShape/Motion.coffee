settings = require('../../utils/GameSettings.coffee')
redrawGameField = require('../clearGame/ClearGame.coffee')

###
    get data from GameSettings and pass
    it to variables with the help of destructurization
###
gridStep = settings.gridStep
maxCells = settings.maxCells


module.exports = (shape, newPos) ->
	move(shape, newPos)


# move the figure down each second
move = (shape, newPos) ->
	unless newPos is undefined
		for i of shape
			shape[i] += newPos
			temp = document.getElementsByClassName('grid-item' + shape[i])
			temp[0].style.backgroundColor = settings.colorSelected
	else
		#clean prev cells
		redrawGameField()

		# check if can continue moving 
		canMoveOn = canContinue(shape, settings.takenCells, gridStep)
		if canMoveOn
			setColor shape, gridStep
		else
			setColor shape
			settings.isMoving = false
			settings.takenCells = [...settings.takenCells, ...shape]
			return

###
    set color to Figure
###
setColor = (array, delta = 0) ->
	for i of array
		array[i] = array[i] + delta
		temp = document.getElementsByClassName('grid-item' + array[i])
		temp[0].style.backgroundColor = settings.colorSelected
	return


#check if the shape can move on
canContinue = (array, takenCells, gridStep) ->
	a = array.map (item)-> item + gridStep
	for i of a 
		if takenCells.includes a[i]
			return false
		else if a[i] >= maxCells
			return false
	return true 
