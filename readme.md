# Readme

## Install
`npm install`

### Install sublime plugin

You will need the Sublime Package Manager.

- Open the command palette: ⌘+shift+p on MacOS/Linux, ctrl+shift+p on Windows
- type install, select Package Control: Install Package
- type React, select ReactJS

source:
https://github.com/reactjs/sublime-react

### Ubuntu
sudo apt-get install libpq-dev build-essential

http://stackoverflow.com/questions/16748737/grunt-watch-error-waiting-fatal-error-watch-enospc :
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

## Running
`npm start`
