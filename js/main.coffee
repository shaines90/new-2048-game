$ ->

  # creating rows and columns
  ppArray = (array) ->
    for row in array
      console.log row

  @board = [0..3].map (x) -> [0..3].map (y) -> 0
  ppArray(@board)


  generateTile = (board) ->

  randomIndex = (x) ->
    Math.floor(Math.random() * 4)

  randomValue = ->
    values = [2,2,2,4]
    val = values[randomIndex(values.length)]