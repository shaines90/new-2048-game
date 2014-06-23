$ ->

  # creating rows and columns
  ppArray = (array) ->
    for row in array
      console.log row

  @board = [0..3].map (x) -> [0..3].map (y) -> 0

  randomIndex = (x) ->
    Math.floor(Math.random() * 4)

  getRandomCellIndecies = ->
    [randomIndex(4), randomIndex(4)]

  randomValue = ->
    values = [2,2,2,2,2,4]
    val = values[randomIndex(values.length)]

  boardIsFull = (board) ->
    for x in [0..3]
      for y in [0..3]
        if board[x][y] == 0
          return false
    true

  generateTile = (board) ->
    unless boardIsFull(board)
      # get random value for tile
      val = randomValue()
      # get random position
      [x, y] = getRandomCellIndecies()
      # only if the cell = 0
      if board[x][y] == 0
        board[x][y] = val
      else
        generateTile(board)

  $('body').keydown (e) ->
    key = e.which
    keys = [37..40]

    if $.inArray(key, keys) > -1
      e.preventDefault()

    switch key
      when 37
        console.log 'left'
      when 38
        console.log 'up'
      when 39
        console.log 'right'
      when 40
        console.log 'down'

  generateTile(@board)
  generateTile(@board)
  ppArray(@board)