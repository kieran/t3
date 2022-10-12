import { Component } from 'react'
import { render } from 'react-dom'

import Score from './components/score'
import Board from './components/board'

# counts the number of squares occupied
squaresOccupied = (b=[])->
  b.flat().filter((o)->o?).length

# declares a winner given a board
# this could be cleaned up lol
winner = (b=[])=>
  # possible vertical wins
  return b[0][0] if b[0][0]? and b[0][0] is b[0][1] is b[0][2]
  return b[1][0] if b[1][0]? and b[1][0] is b[1][1] is b[1][2]
  return b[2][0] if b[2][0]? and b[2][0] is b[2][1] is b[2][2]

  # possible horizontal wins
  return b[0][0] if b[0][0]? and b[0][0] is b[1][0] is b[2][0]
  return b[0][1] if b[0][1]? and b[0][1] is b[1][1] is b[2][1]
  return b[0][2] if b[0][2]? and b[0][2] is b[1][2] is b[2][2]

  # possible diagonal wins
  return b[0][0] if b[0][0]? and b[0][0] is b[1][1] is b[2][2]
  return b[0][2] if b[0][2]? and b[0][2] is b[1][1] is b[2][0]

  # no winner
  null

# a blank board
blank = [
  [null, null, null]
  [null, null, null]
  [null, null, null]
]

class TicTacToe extends Component
  state:
    board: blank
    score:
      x: 0
      o: 0

  # whose turn is it?
  # we can calculate that from the state of the board
  # X goes first
  player: =>
    return 'o' if squaresOccupied(@state.board) % 2
    'x'

  # main play move - updates the game state and
  # checks for a winner / stalemate state
  play: (player='x', x=0, y=0)=>
    # make a copy of the current board for modification
    board = JSON.parse JSON.stringify @state.board

    # place the mark
    board[y][x] = player unless board[y][x]?

    # is there a winner?
    # give a point to the winnner
    # and reset the board
    if won = winner board
      score = @state.score
      score[won] += 1
      @setState { score }
      board = blank

    # stalemate? reset the board
    else if squaresOccupied(board) is 9
      board = blank

    @setState { board }

  # really this is just a high-level layout.
  # The state is provided to the components
  # for rendering along with mutation methods
  render: ->
    {board} = @state
    <>
      <h1>TIC TAC TOE</h1>
      <Score {@state.score...}/>
      <Board board={board} player={@player()} play={@play}/>
      <h2>{@player()}'s move</h2>
    </>

# render the root TicTacToe in the HTML
render <TicTacToe/>, document.getElementById 'Application'
