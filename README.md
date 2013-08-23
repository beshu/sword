Sword [![](http://so.mu/icons/sword.png)](http://so.mu/blog/sword)
=====
[![Build status](https://secure.travis-ci.org/somu/sword.png?branch=master)](http://travis-ci.org/somu/sword)
[![Version](https://badge.fury.io/rb/sword.png)](http://rubygems.org/gems/sword)
[![Dependency Status](https://gemnasium.com/somu/sword.png)](https://gemnasium.com/somu/sword)
[![Code readability](https://codeclimate.com/github/somu/sword.png)](https://codeclimate.com/github/somu/sword)

[**Documentation**](http://rubydoc.info/github/somu/sword/master/frames)  
[**Rubygems**](http://rubygems.org/gems/sword)

**Sword** is a designer’s best friend.

It works as follows: you put, say, `index.slim`, `main.sass` and `script.coffee` into your project folder,
run Sword in it, it tells you to open `localhost:1111` in your browser, you do it, and you see your
website all working.

Technically, it is a Sinatra server application with a configurable environment,
very wise routing mechanisms and a lot of metaprogramming stuff inside.

Sword is designed to be used in local static website development, when you want to use different preprocessors like Sass, but
you are way to lazy to compile them all manually. And you do not need to: really not comfortable.

Still, Sword can be used as a smart but slow semi-production server. You can easily deploy it on your own server using
`--daemonize`, `--pid <path>`, `--compress` and `--cache` flags. Those were added to run Sword on the server.

**Sword** uses [semantic versioning](http://semver.org) starting with version 1.6.0.

Get started
-----------

**Sword** is avaliable as a gem, working with all popular Ruby versions (JRuby, Rubinius, Ruby 1.8...2.0):

```sh
gem install sword
```

Running Windows? I’ve got your back. [**Here’s your executable**](https://github.com/somu/sword/blob/master/sword.exe?raw=true)
with all necessary gems built-in.  No Ruby required.

Now you start it. If you are using the executable, just throw it into the project directory and you're ready to rock.  
If you are using it as a gem:

```sh
cd directory/you/wanna/watch
sword
```

And it works. One-liner:

```sh
sword -d directory/you/wanna/watch
```

So. It tells you something like:

    >> Sword 1.6.0/Thin at your service!
    >> http://localhost:1111 to see your project.
    >> CTRL+C to stop.

Now you need to install all basic gems used for compiling templates, if you haven't got any.  
Do it using the `--install` flag:

```sh
sword --install
```

And it will install all possible dependencies automatically. You are ready to go.

Options
-------

Sword has got a lot of different options:

    -a, --add <x,y>           Permanently require the gems
        --aloud               Show server's guts
        --cache               Turn on caching for some engines
    -c, --compress            Compress assets
        --daemonize           Daemonize Sword (good for servers)
        --debug               Show Sword's guts
    -d, --directory <path>    Specify watch directory
        --error <path>        Specify error page
        --exceptions          Show Sinatra exception page
        --favicon <path>      Specify favicon
    -h, --help                Print this message
        --here                Don't change directory
        --host <address>      Specify host (default is localhost)
    -i, --install             Install must-have gems using RubyGems
        --mutex               Turn on the mutex lock
        --no-layouts          Turn off layouts at all (pretty faster)
    -o, --open                Open in browser (OS X specific)
        --pid <path>          Make PID file
        --plain               Skip including gems from built-in list
    -p, --port <number>       Change the port, 1111 by default
    -r, --require <x,y>       Require the gems this run
        --server <name>       Specify server
    -s, --settings <path>     Load settings from the file
        --silent              Turn off any messages excluding exceptions
    -v, --version             Print Sword's version

