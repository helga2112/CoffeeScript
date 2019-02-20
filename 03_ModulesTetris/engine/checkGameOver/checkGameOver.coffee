settings = require('../../utils/GameSettings.coffee')

module.exports = ()->
    for a in [0...9]
        if settings.takenCells.indexOf(a) > -1
            console.log 'STOP'
            clearInterval settings.timerInterval