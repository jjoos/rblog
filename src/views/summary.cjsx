{Helper} = require 'onehundredfourtytwo'
React = require 'react'

module.exports = class Summary extends React.Component
  render: ->
    <article>
      <a href={"/posts/#{@props.post.slug}"}>
        <h2>{@props.post.title}</h2>
      </a>
      <p>{@props.post.body.substring(0,10)}...</p>
      <footer className="postinfo">
        <li>17th October 2011</li>
        <li>
          Posted in
          <a href="#">
            Articles
          </a>
        </li>
        <li>
          <a
            href={@props.post.link}>
            Continue Reading »
          </a>
        </li>
      </footer>
    </article>
