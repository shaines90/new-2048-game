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

  getRow = (row, board) ->
    board[row]
  # console.log getRow(2, @board)

  getColumn = (columnNum, board) ->
    b = board
    c = columnNum
    [b[0][c], b[1][c], b[2][c], b[3][c]]
  # console.log getColumn(3, @board)

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
              value[j] = 0
              break
            else
              if value[j] != 0
                break
    value

  console.log "mergeCells: " + mergeCells([2,2,2,2], 'left')
  console.log "mergeCells: " + mergeCells([2,2,2,2], 'right')
  console.log "mergeCells: " + mergeCells([2,4,2,2], 'left')
  console.log "mergeCells: " + mergeCells([4,2,0,2], 'up')
  console.log "mergeCells: " + mergeCells([4,0,0,4], 'left')



# animate cells

  # $( "#go" ).click(function() {
  #   $( ".animateCell:first" ).animate({
  #     left: 100
  #   }, {
  #     duration: 1000,
  #     step: function( now, fx ){
  #       $( ".animateCell:gt(0)" ).css( direction, now );
  #     }
  #   });
  # });




  # checkWin = (board) ->
  #   for row in board
  #     for cell in row
  #       if cell >=2048




