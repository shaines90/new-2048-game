// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
    var arrayEqual, boardEqual, boardIsFull, buildBoard, collapseCells, gameLost, gameWon, generateTile, getColor, getColumn, getRandomCellIndecies, getRow, mergeCells, move, moveIsValid, noValidMoves, ppArray, randomIndex, randomValue, setColumn, setRow, showBoard;
    ppArray = function(array) {
      var row, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        row = array[_i];
        _results.push(console.log(row));
      }
      return _results;
    };
    buildBoard = function() {
      return [0, 1, 2, 3].map(function(x) {
        return [0, 1, 2, 3].map(function(y) {
          return 0;
        });
      });
    };
    randomIndex = function(x) {
      return Math.floor(Math.random() * 4);
    };
    getRandomCellIndecies = function() {
      return [randomIndex(4), randomIndex(4)];
    };
    randomValue = function() {
      var val, values;
      values = [2, 2, 2, 2, 2, 4];
      return val = values[randomIndex(values.length)];
    };
    arrayEqual = function(a, b) {
      var index, valueInA, _i, _len;
      for (index = _i = 0, _len = a.length; _i < _len; index = ++_i) {
        valueInA = a[index];
        if (valueInA !== b[index]) {
          return false;
        }
      }
      return true;
    };
    boardEqual = function(a, b) {
      var array, i, _i, _len;
      for (i = _i = 0, _len = a.length; _i < _len; i = ++_i) {
        array = a[i];
        if (!arrayEqual(array, b[i])) {
          return false;
        }
      }
      return true;
    };
    moveIsValid = function(a, b) {
      return !boardEqual(a, b);
    };
    noValidMoves = function(board) {
      var direction, directions, newBoard, _i, _len;
      directions = ['up', 'down', 'left', 'right'];
      for (_i = 0, _len = directions.length; _i < _len; _i++) {
        direction = directions[_i];
        newBoard = move(board, direction);
        if (moveIsValid(newBoard, board)) {
          return false;
        }
      }
      return true;
    };
    boardIsFull = function(board) {
      var x, y, _i, _j;
      for (x = _i = 0; _i <= 3; x = ++_i) {
        for (y = _j = 0; _j <= 3; y = ++_j) {
          if (board[x][y] === 0) {
            return false;
          }
        }
      }
      return true;
    };
    generateTile = function(board) {
      var val, x, y, _ref;
      if (!boardIsFull(board)) {
        val = randomValue();
        _ref = getRandomCellIndecies(), x = _ref[0], y = _ref[1];
        if (board[x][y] === 0) {
          return board[x][y] = val;
        } else {
          return generateTile(board);
        }
      }
    };
    getRow = function(rowNumber, board) {
      var b, r, _ref;
      _ref = [rowNumber, board], r = _ref[0], b = _ref[1];
      return [b[r][0], b[r][1], b[r][2], b[r][3]];
    };
    getColumn = function(columnNum, board) {
      var b, c;
      b = board;
      c = columnNum;
      return [b[0][c], b[1][c], b[2][c], b[3][c]];
    };
    setRow = function(newArray, rowNumber, board) {
      var row;
      row = newArray;
      return board[rowNumber] = row;
    };
    setColumn = function(newArray, columnNumber, board) {
      var b, c;
      c = columnNumber;
      b = board;
      return b[0][c] = newArray[0], b[1][c] = newArray[1], b[2][c] = newArray[2], b[3][c] = newArray[3], newArray;
    };
    collapseCells = function(cells, direction) {
      var i, padding, _i;
      cells = cells.filter(function(x) {
        return x !== 0;
      });
      padding = 4 - cells.length;
      for (i = _i = 0; 0 <= padding ? _i < padding : _i > padding; i = 0 <= padding ? ++_i : --_i) {
        switch (direction) {
          case 'right':
            cells.unshift(0);
            break;
          case 'left':
            cells.push(0);
            break;
          case 'down':
            cells.unshift(0);
            break;
          case 'up':
            cells.push(0);
        }
      }
      return cells;
    };
    mergeCells = function(cells, direction) {
      var i, j, value, _i, _j, _k, _l, _ref, _ref1;
      value = cells;
      switch (direction) {
        case 'left':
        case 'up':
          for (i = _i = 0; _i < 3; i = ++_i) {
            for (j = _j = _ref = i + 1; _ref <= 3 ? _j <= 3 : _j >= 3; j = _ref <= 3 ? ++_j : --_j) {
              if (value[i] === 0) {
                break;
              } else if (value[i] === value[j]) {
                value[i] = value[i] * 2;
                value[j] = 0;
                break;
              } else {
                if (value[j] !== 0) {
                  break;
                }
              }
            }
          }
          break;
        case 'right':
        case 'down':
          for (i = _k = 3; _k > 0; i = --_k) {
            for (j = _l = _ref1 = i - 1; _ref1 <= 0 ? _l <= 0 : _l >= 0; j = _ref1 <= 0 ? ++_l : --_l) {
              if (value[i] === 0) {
                break;
              } else if (value[i] === value[j]) {
                value[i] = value[i] * 2;
                value[j] = 0;
                break;
              } else {
                if (value[j] !== 0) {
                  break;
                }
              }
            }
          }
      }
      return value;
    };
    gameLost = function(board) {
      return boardIsFull(board) && noValidMoves(board);
    };
    gameWon = function(board) {
      var cell, row, _i, _j, _len, _len1;
      for (_i = 0, _len = board.length; _i < _len; _i++) {
        row = board[_i];
        for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
          cell = row[_j];
          if (cell >= 2048) {
            return true;
          } else {
            false;
          }
        }
      }
    };
    showBoard = function(board) {
      var i, j, _i, _results;
      _results = [];
      for (i = _i = 0; _i <= 3; i = ++_i) {
        _results.push((function() {
          var _j, _results1;
          _results1 = [];
          for (j = _j = 0; _j <= 3; j = ++_j) {
            $(".r" + i + ".c" + j).css("background-color", getColor(board[i][j]));
            if (board[i][j] !== 0) {
              _results1.push($(".r" + i + ".c" + j).html('<p>' + board[i][j] + '</p>'));
            } else {
              _results1.push($(".r" + i + ".c" + j).html(''));
            }
          }
          return _results1;
        })());
      }
      return _results;
    };
    getColor = function(rgb) {
      switch (rgb) {
        case 0:
          return '#FFFFFF';
        case 2:
          return 'rgb(250,223,14)';
        case 4:
          return 'rgb(248,154,67)';
        case 8:
          return '#FA5454';
        case 16:
          return '#FA54A7';
        case 32:
          return '#FA54FA';
        case 64:
          return '#A754FA';
        case 128:
          return '#5454FA';
        case 256:
          return '#54A7FA';
        case 1024:
          return '#00FFFF';
        case 2048:
          return '#00FF80';
        case 4096:
          return '#00FF00';
        default:
          return '#80FF00';
      }
    };
    move = function(board, direction) {
      var i, newBoard, row, _i, _j, _k, _l;
      newBoard = buildBoard();
      switch (direction) {
        case 'left':
          for (i = _i = 0; _i <= 3; i = ++_i) {
            row = getRow(i, board);
            row = mergeCells(row, 'left');
            row = collapseCells(row, 'left');
            setRow(row, i, newBoard);
          }
          break;
        case 'up':
          for (i = _j = 0; _j <= 3; i = ++_j) {
            row = getColumn(i, board);
            row = mergeCells(row, 'up');
            row = collapseCells(row, 'up');
            setColumn(row, i, newBoard);
          }
          break;
        case 'right':
          for (i = _k = 3; _k >= 0; i = --_k) {
            row = getRow(i, board);
            row = mergeCells(row, 'right');
            row = collapseCells(row, 'right');
            setRow(row, i, newBoard);
          }
          break;
        case 'down':
          for (i = _l = 3; _l >= 0; i = --_l) {
            row = getColumn(i, board);
            row = mergeCells(row, 'down');
            row = collapseCells(row, 'down');
            setColumn(row, i, newBoard);
          }
      }
      return newBoard;
    };
    $('body').keydown((function(_this) {
      return function(e) {
        var direction, key, keys, newBoard;
        key = e.which;
        keys = [37, 38, 39, 40];
        if ($.inArray(key, keys) > -1) {
          e.preventDefault();
        }
        direction = (function() {
          switch (key) {
            case 37:
              return 'left';
            case 38:
              return 'up';
            case 39:
              return 'right';
            case 40:
              return 'down';
          }
        })();
        ppArray(_this.board);
        newBoard = move(_this.board, direction);
        if (moveIsValid(newBoard, _this.board)) {
          _this.board = newBoard;
          generateTile(_this.board);
          showBoard(_this.board);
          console.log(gameLost(_this.board));
          if (gameLost(_this.board)) {
            return alert("Game Over!");
          } else if (gameWon(_this.board)) {
            return console.log("Game Won!");
          }
        }
      };
    })(this));
    this.board = buildBoard();
    generateTile(this.board);
    generateTile(this.board);
    return showBoard(this.board);
  });

}).call(this);

//# sourceMappingURL=main.map
