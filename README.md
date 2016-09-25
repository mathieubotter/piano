# Piano
[![Build Status](https://travis-ci.org/mathieubotter/piano.svg?branch=master)](https://travis-ci.org/mathieubotter/piano)

__Piano__ is a simple Markdown editor written in ruby.

## Usage
### Installation
Clone the repository:

    $ git clone https://github.com/mathieubotter/piano.git
    $ cd piano

Next, you need to run the bootstrap process, which will verify that you have all of your settings set up correctly, and will guide
you through the configuration setup:

    $ ./script/bootstrap

During the bootstrap process you'll be asked to enter your [Twitter][twitter] API Key and API Secret.

At this point, you should be ready:

    $ rake start

That'll start the server up on [localhost:9393](http://localhost:9393).

## To Do
- [ ] Render Markdown text on the main page.

## Change Log
* __0.0.0__ Dev

[twitter]: https://dev.twitter.com/
