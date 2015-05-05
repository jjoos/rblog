{Helper} = require 'onehundredfourtytwo'
React = require 'react'

SidebarSection = require './sidebar_section'

module.exports = class BlogLayout extends React.Component
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
      <SidebarSection
        id="about"
        title="About me">
        <p>
          Typo is a WordPress theme based entirely on a balanced typographic
      design. A strict grid layout keeps everything tidy, allowing the
      content to shine.
          <a href="/about" className="more">
            Find out more »
          </a>
        </p>
      </SidebarSection>
      <SidebarSection
        id="categories"
        title="Categories">
        <ul>
          <li>
            <a href="#">
              Articles
            </a>
          </li>
          <li>
            <a href="#">
              Design
            </a>
          </li>
          <li>
            <a href="#">
              Graphics
            </a>
          </li>
          <li>
            <a href="#">
              Inspiration
            </a>
          </li>
          <li>
            <a href="#">
              Retro
            </a>
          </li>
        </ul>
      </SidebarSection>
      <SidebarSection
        id="social"
        title="Social">
        <ul>
          <li>
            <a href="#">
              Twitter
            </a>
          </li>
          <li>
            <a href="#">
              Facebook
            </a>
          </li>
          <li>
            <a href="#">
              Flickr
            </a>
          </li>
          <li>
            <a href="#">
              Behance
            </a>
          </li>
          <li>
            <a href="#">
              Last.FM
            </a>
          </li>
          <li>
            <a href="#">
              YouTube
            </a>
          </li>
        </ul>
      </SidebarSection>
      <SidebarSection
        id="latest"
        title="Latest posts">
        <ul>
          <li>
            <a href="#">
              Getting your stock photos seen
            </a>
          </li>
          <li>
            <a href="#">
              Top 10 tips for new bloggers
            </a>
          </li>
          <li>
            <a href="#">
              10 fantastic photography tips
            </a>
          </li>
        </ul>
      </SidebarSection>
      <SidebarSection
        id="search"
        title="Search">
        <fieldset>
          <input
            type="text"
            id="searchbar"
            placeholder="I'm looking for..." />
          <input
            type="submit"
            id="searchsubmit"
            value="Search" />
        </fieldset>
      </SidebarSection>
    </aside>

  render: ->
    <div id='container'>
      <header>
        <a href="/">
          <h1>JJoos</h1>
        </a>
        {@menu()}
      </header>
      <main>
        {@props.children}
      </main>
      {@sidebar()}
      <footer>
        <div id="credits">
          Copyright JJoos
        </div>

        <div id="back-top">
          <a href="#">
            Back to top
          </a>
        </div>
      </footer>
    </div>
