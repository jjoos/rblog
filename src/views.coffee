# @jsx React.DOM
React = require 'react'

Post = React.createClass
  displayName: 'Post'

  render: ->
    <BlogLayout>
      <article>
        <h2>{ @props.post.title }</h2>
        <p>{ @props.post.body }</p>
      </article>
    </BlogLayout>

Summary = React.createClass
  displayName: 'Summary'

  render: ->
    <article>
      <a href={ @props.post.link }>
        <h2>{ @props.post.title }</h2>
      </a>
      <p>{ @props.post.body.substring(0,10) }...</p>
      <footer className="postinfo">
        <li>17th October 2011</li>
        <li>Posted in <a href="#">Articles</a></li>
        <li><a href={ @props.post.link}>Continue Reading »</a></li>
      </footer>
    </article>

SidebarSection = React.createClass
  displayName: 'SidebarSection'

  render: ->
    <section id={ @props.id }>
      <h3>{ @props.title }</h3>
      { @props.children }
    </section>

BlogLayout = React.createClass
  displayName: 'BlogLayout'

  menu: -> 
    <nav>
      <ul>
        <li>
          <a href="/archives">Archives</a>
        </li>
        <li>
          <a href="/about">About</a>
        </li>
      </ul>
    </nav>

  sidebar: ->
    <aside>
      <SidebarSection id="about" titl="About me">
        <p>Typo is a WordPress theme based entirely on a balanced typographic design. A strict grid layout keeps everything tidy, allowing the content to shine. <a href="/about" className="more">Find out more »</a></p>
      </SidebarSection>
      <SidebarSection id="categories" title="Categories">
        <ul>
          <li><a href="#">Articles</a></li>
          <li><a href="#">Design</a></li>
          <li><a href="#">Graphics</a></li>
          <li><a href="#">Inspiration</a></li>
          <li><a href="#">Retro</a></li>
        </ul>
      </SidebarSection>
      <SidebarSection id="social" title="Social">
        <ul>
          <li><a href="#">Twitter</a></li>
          <li><a href="#">Facebook</a></li>
          <li><a href="#">Flickr</a></li>
          <li><a href="#">Behance</a></li>
          <li><a href="#">Last.FM</a></li>
          <li><a href="#">YouTube</a></li>
        </ul>
      </SidebarSection>
      <SidebarSection id="latest" title="Latest posts">
        <ul>
          <li><a href="#">Getting your stock photos seen</a></li>
          <li><a href="#">Top 10 tips for new bloggers</a></li>
          <li><a href="#">10 fantastic photography tips</a></li>
        </ul>
      </SidebarSection>
      <SidebarSection id="search" title="Search">
        <fieldset>
          <input type="text" id="searchbar" placeholder="I'm looking for..." />
          <input type="submit" id="searchsubmit" value="Search" />
        </fieldset>
      </SidebarSection>
    </aside>

  render: ->
    <div id='container'>
      <header>
        <a href="/">
          <h1>JJoos</h1>
        </a>
        { @menu() }
      </header>
      <main>
        { @props.children }
      </main>
      { @sidebar() }
      <footer>
        <div id="credits">
          Copyright JJoos
        </div>
      
        <div id="back-top"><a href="#">Back to top</a></div>
      </footer>
    </div>

Index = React.createClass
  displayName: 'Index'

  posts: ->  
    for post in @props.posts
      <Summary post={post} key={post.link} />

  render: ->
    <BlogLayout>
      { @posts() }
    </BlogLayout>

module.exports.Index = Index
module.exports.Post = Post