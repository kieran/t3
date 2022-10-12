import React from 'react'

import './styles.sass'

export default ({x,o})->
  <div className="Score">
    <div className="x">X: {x or '0'}</div>
    <div className="o">O: {o or '0'}</div>
  </div>
