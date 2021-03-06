(function() {

  /*
  Move the shape
  */
  /*
     - create grid
     - add shape motion
  */
  var addItem, canContinue, canShift, checkMoves, colorPrev, colorSelected, colors, currentFigure, figures, getNewPosition, gridStep, interval, isFigureRotated, isMoving, maxCells, move, moveLinesDown, onKeyup, ready, redrawGameField, removeLines, removeRow, rotateFigure, rotated, setColor, shape, shapes, shift, takenCells;

  maxCells = 100;

  gridStep = 10;

  interval = -1;

  colorSelected = 'lavender';

  colorPrev = 'rgba(255, 255, 255, 0.8)';

  shape = [];

  isMoving = false;

  currentFigure = '';

  isFigureRotated = false;

  figures = ['square', 'shifted', 'corner', 'letterT', 'tower'];

  colors = ['slateblue', 'yellow', 'lightgreen', 'darkturquoise', 'pink'];

  shapes = {
    square: [0, 1, 10, 11],
    shifted: [0, 1, 11, 12],
    corner: [0, 10, 20, 21],
    letterT: [0, 1, 2, 11],
    tower: [0, 10, 20, 30]
  };

  rotated = {
    square: [0, 1, 10, 11],
    shifted: [1, 10, 11, 20],
    corner: [0, 10, 20, 21],
    letterT: [0, 1, 2, 11],
    tower: [0, 10, 20, 30]
  };

  takenCells = [];

  ready = function() {
    var a, i, j, newElement, parent, ref;
    parent = document.body.appendChild(document.createElement('div'));
    parent.className = 'grid-container';
    for (i = j = 0, ref = maxCells; (0 <= ref ? j < ref : j > ref); i = 0 <= ref ? ++j : --j) {
      newElement = parent.appendChild(document.createElement('div'));
      newElement.innerHTML = '<p>' + i + '</p>';
      newElement.className = 'grid-item' + i;
    }
    a = 0;
    return interval = setInterval((function() {
      return addItem();
    }), 500);
  };

  onKeyup = function(e) {
    if (e.keyCode === 37) { // <=
      if (isMoving) {
        return shift(shape, -1);
      }
    } else if (e.keyCode === 39) { // =>
      if (isMoving) {
        return shift(shape, 1);
      }
    } else if (e.keyCode === 32) { // Space
      return rotateFigure();
    }
  };

  document.addEventListener("DOMContentLoaded", ready);

  document.addEventListener('keyup', onKeyup);

  rotateFigure = function() {
    /*
    square: [0, 1, 10, 11]
    shifted:[0, 1, 11, 12]
    corner: [0, 10, 20, 21]
    letterT:[0, 1, 2, 11]
    tower:  [0, 10, 20, 30]
    */
    switch (currentFigure) {
      case 'shifted':
        return 1;
      case 'corner':
        return 1;
      case 'letterT':
        return 1;
      case 'tower':
        return 1;
    }
  };

  // move the figure to the right or to the left (on user key up)
  shift = function(arr, num) {
    var i, results, temp;
    if (canShift(arr, num)) {
      for (i in arr) {
        temp = document.getElementsByClassName('grid-item' + arr[i]);
        temp[0].style.backgroundColor = colorPrev;
      }
      results = [];
      for (i in arr) {
        arr[i] += num;
        temp = document.getElementsByClassName('grid-item' + arr[i]);
        results.push(temp[0].style.backgroundColor = colorSelected);
      }
      return results;
    }
  };

  // check if the figure can be shifted
  canShift = function(arr, num) {
    var newRow, row, t;
    if (num < 0) {
      for (t in arr) {
        if (takenCells.includes(+arr[t] + num)) {
          return false;
        }
        row = Math.floor(+arr[t] / gridStep);
        newRow = Math.floor((+arr[t] + num) / gridStep);
        if (newRow !== row) {
          return false;
        }
      }
    }
    if (num > 0) {
      for (t in arr) {
        if (takenCells.includes(+arr[t] + num)) {
          return false;
        } else if ((+arr[t] % gridStep + num) >= gridStep) {
          return false;
        }
      }
    }
    return true;
  };

  
  // move the figure down each second
  move = function(shape, newPos) {
    var canMoveOn, i, results, temp;
    if (newPos) {
      results = [];
      for (i in shape) {
        shape[i] += newPos;
        temp = document.getElementsByClassName('grid-item' + shape[i]);
        results.push(temp[0].style.backgroundColor = colorSelected);
      }
      return results;
    } else {
      //clean prev cells
      redrawGameField();
      // check if can continue moving 
      canMoveOn = canContinue(shape, takenCells, gridStep);
      if (canMoveOn) {
        return setColor(shape, gridStep);
      } else {
        setColor(shape);
        isMoving = false;
        takenCells = [...takenCells, ...shape];
      }
    }
  };

  
  //clean prev cells
  redrawGameField = function() {
    var clean;
    clean = document.getElementsByTagName('div');
    return [].forEach.call(clean, function(item) {
      var num;
      if (item.className !== 'grid-container') {
        num = item.className.slice('grid-item'.length, item.className.length);
        if (!takenCells.includes(+num)) {
          return item.style.backgroundColor = 'rgba(255, 255, 255, 0.8)';
        }
      }
    });
  };

  // set color to Figure
  setColor = function(array, delta = 0) {
    var i, temp;
    for (i in array) {
      array[i] = array[i] + delta;
      temp = document.getElementsByClassName('grid-item' + array[i]);
      temp[0].style.backgroundColor = colorSelected;
    }
  };

  //check if the shape can move on
  canContinue = function(array, takenCells, gridStep) {
    var a, i;
    // a = array.slice()
    a = array.map(function(item) {
      return item + gridStep;
    });
    for (i in a) {
      if (takenCells.includes(a[i])) {
        return false;
      } else if (a[i] > maxCells) {
        return false;
      }
    }
    return true;
  };

  removeLines = function() {
    var controll, count, current, i, row, temp, tempArr, toRemove;
    controll = 0;
    takenCells = takenCells.sort();
    toRemove = [];
    current = -1;
    if (takenCells.length > 0) {
      count = 0;
      current = Math.floor(takenCells[0] / 10);
      tempArr = [];
      for (i in takenCells) {
        row = Math.floor(takenCells[i] / 10);
        if (current === row) {
          temp = document.getElementsByClassName('grid-item' + takenCells[i]);
          if (temp[0].style.backgroundColor === colorSelected) {
            tempArr.push(takenCells[i]);
            if (tempArr.length === gridStep) {
              toRemove = toRemove.concat(tempArr);
              current += 1;
              tempArr = [];
            }
          }
        } else {
          tempArr = [];
          tempArr.push(takenCells[i]);
          current = row;
        }
      }
    }
    return removeRow(toRemove);
  };

  moveLinesDown = function() {
    var i, r, results, step, temp;
    for (r in takenCells) {
      temp = document.getElementsByClassName('grid-item' + takenCells[r]);
      temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)';
    }
    step = Math.floor((maxCells - takenCells[takenCells.length - 1]) / gridStep);
    takenCells = takenCells.map(function(element) {
      return element + step * gridStep;
    });
    results = [];
    for (i in takenCells) {
      temp = document.getElementsByClassName('grid-item' + takenCells[i]);
      results.push(temp[0].style.backgroundColor = colorSelected);
    }
    return results;
  };

  removeRow = function(array) {
    var end, i, start, temp;
    if (array.length > 0) {
      start = takenCells.indexOf(array[0]);
      end = takenCells.indexOf(array[array.length - 1]);
      takenCells.splice(start, end + 1);
      for (i in array) {
        temp = document.getElementsByClassName('grid-item' + array[i]);
        temp[0].style.backgroundColor = 'rgba(255, 255, 255, 0.8)';
      }
      return moveLinesDown();
    }
  };

  checkMoves = function() {
    var a, j, results;
    results = [];
    for (a = j = 0; j < 9; a = ++j) {
      if (takenCells.indexOf(a) > -1) {
        console.log('STOP');
        results.push(clearInterval(interval));
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  getNewPosition = function(shape, ramdonFigure) {
    var diapazon, pos;
    diapazon = 8;
    //'square', 'shifted', 'corner', 'letterT', 'tower'
    switch (ramdonFigure) {
      case 'shifted':
        diapazon = 7;
        break;
      case 'letterT':
        diapazon = 7;
        break;
      case 'tower':
        diapazon = 9;
    }
    pos = Math.round(Math.random() * diapazon);
    return pos;
  };

  addItem = function() {
    var ind, pos;
    if (!isMoving) {
      removeLines();
      checkMoves();
      isMoving = true;
      
      // define random figure
      ind = Math.floor(Math.random() * 5);
      currentFigure = figures[ind];
      shape = shapes[currentFigure].slice();
      colorSelected = colors[ind];
      // make it move
      pos = getNewPosition(shape, currentFigure);
      return move(shape, pos);
    } else {
      return move(shape);
    }
  };

}).call(this);


//# sourceMappingURL=Tetris.js.map
//# sourceURL=coffeescript