import { Component } from 'react'

import './styles.sass'

export default \
class Board extends Component
  render: ->
    <div className="Board">
      <table>
        <tbody>
        {for y, idx_y in @props.board
          <tr key={idx_y}>
            {for x, idx_x in y
              <td key={idx_x} onClick={@props.play.bind @, @props.player, idx_x, idx_y}>{x or ''}</td>
            }
          </tr>
        }
        </tbody>
      </table>
    </div>
