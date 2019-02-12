hasMovingFigure = false

ready = () -> 

        parent = document.body.appendChild(document.createElement('div'))
        parent.className = 'grid-container'

        for i in [0 ...maxCells]
              newElement = parent.appendChild(document.createElement('div'))
              newElement.innerHTML = '<p>' + i + '</p>'
              newElement.className = 'grid-item' + i
        a = 0
        setInterval ( -> addItem()),
                         1000
                     
document.addEventListener("DOMContentLoaded", ready)

maxCells = 160
rowLength = 10

class square
    color = 0x005500
    @pos = 0
    move: (newPos) ->
            if newPos
                @pos = newPos
                console.log 'move ferst', @pos
                temp = document.getElementsByClassName('grid-item' + @pos)
                temp[0].style.backgroundColor = 'red'
            else
                @pos =+ 10
                temp = document.getElementsByClassName('grid-item' + @pos)
                temp[0].style.backgroundColor = 'red'
                console.log(@pos)

figures = [square]

addItem =-> 
       a = new square()
       if !hasMovingFigure
            hasMovingFigure = true
            pos = Math.round (Math.random() * 10)
            a.move(pos)
        else
            a.move()
            console.log 'move next'

###            
colorGrigItem = (pos) ->
            temp = document.getElementsByClassName('grid-item' + pos)
            temp[0].style.backgroundColor = 'red'
###            