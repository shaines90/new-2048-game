score = 0

$ ->

  ppArray = (array) ->
    for row in array
      console.log row

  buildBoard = ->
    [0..3].map (x) -> [0..3].map (y) -> 0

  randomIndex = (x) ->
    Math.floor(Math.random() * 4)

  getRandomCellIndecies = ->
    [randomIndex(4), randomIndex(4)]

  randomValue = ->
    values = [2,2,2,2,2,4]
    val = values[randomIndex(values.length)]

  arrayEqual = (a, b) ->
    for valueInA, index in a
      if valueInA != b[index]
        return false
    true

  boardEqual = (a, b) ->
    for array, i in a
      if !arrayEqual(array, b[i])
        return false
    true

  moveIsValid = (a, b) ->
    not boardEqual(a,b)

  noValidMoves = (board) ->
    directions = ['up', 'down', 'left', 'right']

    for direction in directions
      newBoard = move board, direction
      return false if moveIsValid(newBoard, board)
    true

  boardIsFull = (board) ->
    for x in [0..3]
      for y in [0..3]
        if board[x][y] == 0
          return false
    true

  generateTile = (board) ->
    unless boardIsFull(board)
      val = randomValue()
      [x, y] = getRandomCellIndecies()
      if board[x][y] == 0
        board[x][y] = val
      else
        generateTile(board)

  getRow = (rowNumber, board) ->
    [r, b] = [rowNumber, board]
    [b[r][0], b[r][1], b[r][2], b[r][3]]

  getColumn = (columnNum, board) ->
    b = board
    c = columnNum
    [b[0][c], b[1][c], b[2][c], b[3][c]]

  setRow = (newArray, rowNumber, board) ->
    row = newArray
    board[rowNumber] = row

  setColumn = (newArray, columnNumber, board) ->
    c = columnNumber
    b = board
    [b[0][c], b[1][c], b[2][c], b[3][c]] = newArray

  collapseCells = (cells, direction) ->
    cells = cells.filter (x) -> x != 0
    padding = 4 - cells.length

    for i in [0...padding]
      switch direction
        when 'right' then cells.unshift 0
        when 'left' then cells.push 0
        when 'down' then cells.unshift 0
        when 'up' then cells.push 0
    cells

  mergeCells = (cells, direction) ->
    value = cells

    switch direction
      when 'left', 'up'
        for i in [0...3]
          for j in [i+1..3]
            if value[i] == 0
              break
            else if value[i] == value[j]
              value[i] = value[i]*2
              addScore(value[i])
              value[j] = 0
              break
            else
              if value[j] != 0
                break
      when 'right', 'down'
        for i in [3...0]
          for j in [i-1..0]
            if value[i] == 0
              break
            else if value[i] == value[j]
              value[i] = value[i]*2
              addScore(value[i])
              value[j] = 0
              break
            else
              if value[j] != 0
                break
    value

  gameLost = (board) ->
    boardIsFull(board) && noValidMoves(board)

  gameWon = (board) ->
    for row in board
      for cell in row
        if cell >= 2048
          return true
        else
          false

  showBoard = (board) ->
    for i in [0..3]
      for j in [0..3]
        $(".r#{i}.c#{j}").css("background-color", getColor(board[i][j]))
        unless board[i][j] is 0
          $(".r#{i}.c#{j}").html('<p>' + board[i][j] + '</p>')
        else
          $(".r#{i}.c#{j}").html('')

  getColor = (rgb) ->
    switch rgb
      when 0 then '#FFFFFF'
      when 2 then 'rgb(250,223,14)'
      when 4 then 'rgb(248,154,67)'
      when 8 then '#FA5454'
      when 16 then '#FA54A7'
      when 32 then '#FA54FA'
      when 64 then '#A754FA'
      when 128 then '#5454FA'
      when 256 then '#54A7FA'
      when 1024 then '#00FFFF'
      when 2048 then '#00FF80'
      when 4096 then '#00FF00'
      else '#80FF00'

  setScoreZero = ->
    score = 0
    $('.score > h2').html("Score: 0")

  addScore = (x) ->
    score = score + x
    $('.score > h2').html("Score: #{score}")

  $('#resetButton').click =>
    setScoreZero(@board)
    @board = buildBoard()
    generateTile(@board)
    generateTile(@board)
    showBoard(@board)

  move = (board, direction) ->

    newBoard = buildBoard()

    switch direction
      when 'left'
        for i in [0..3]
          row = getRow(i, board)
          row = mergeCells(row, 'left')
          row = collapseCells(row, 'left')
          setRow(row, i, newBoard)
      when 'up'
        for i in [0..3]
          row = getColumn(i, board)
          row = mergeCells(row, 'up')
          row = collapseCells(row, 'up')
          setColumn(row, i, newBoard)
      when 'right'
        for i in [3..0]
          row = getRow(i, board)
          row = mergeCells(row, 'right')
          row = collapseCells(row, 'right')
          setRow(row, i, newBoard)
      when 'down'
        for i in [3..0]
          row = getColumn(i, board)
          row = mergeCells(row, 'down')
          row = collapseCells(row, 'down')
          setColumn(row, i, newBoard)
    newBoard

  $("body").swipe
    swipe: (event, direction, distance, duration, fingerCount, fingerData) =>
      newBoard = move(@board, direction)

      if moveIsValid(newBoard, @board)
        @board = newBoard
        generateTile(@board)
        showBoard(@board)
        console.log gameLost(@board)
        if gameLost(@board)
          alert "Game Over!"
        else if gameWon(@board)
          console.log "Game Won!"
        return

  $('body').keydown (e) =>
    key = e.which
    keys = [37..40]

    if $.inArray(key, keys) > -1
      e.preventDefault()
    else
      return

    direction = switch key
      when 37 then 'left'
      when 38 then 'up'
      when 39 then 'right'
      when 40 then 'down'

    ppArray @board
    newBoard = move(@board, direction)

    if moveIsValid(newBoard, @board)
      @board = newBoard
      generateTile(@board)
      showBoard(@board)
      console.log gameLost(@board)
      if gameLost(@board)
        alert "Game Over!"
      else if gameWon(@board)
        console.log "Game Won!"

  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  showBoard(@board)






