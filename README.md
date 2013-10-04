Sword [![Sword](http://sword.mu/sword.gif)](http://sword.mu)
=====
[![Build status](https://secure.travis-ci.org/somu/sword.png?branch=master)](http://travis-ci.org/somu/sword)
[![Gem version](https://badge.fury.io/rb/sword.png)](http://rubygems.org/gems/sword)
[![Coverage status](https://coveralls.io/repos/somu/sword/badge.png)](https://coveralls.io/r/somu/sword)
[![Code readability](https://codeclimate.com/github/somu/sword.png)](https://codeclimate.com/github/somu/sword)
[![Dependency status](https://gemnasium.com/somu/sword.png)](https://gemnasium.com/somu/sword)

[![Paypal](https://www.paypalobjects.com/en_GB/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8PCQ52CFPFSKL)  
[**Documentation**](http://rubydoc.info/github/somu/sword/master/frames)  
[**Gem**](http://rubygems.org/gems/sword)

**Sword** is a designer’s best friend.

It works as follows: you put, say, `index.slim`, `main.sass` and `script.coffee` into your project folder,
run Sword in it, it tells you to open `localhost:1111` in your browser, you do so, and you see your
website all working.

Technically, it is a Sinatra server application with a configurable environment,
very wise routing mechanisms and a lot of metaprogramming stuff inside.

When you make `GET /page` query to Sword application, it searches for files named `page` in the project
root with an extension linked to some templating engine in `templates`. When it finds, it compiles it
and gives you back (if you're interested in how Sword works, run it with `--debug` flag).

Sword is designed to be used in local static website development, when you want to use different preprocessors like Sass, but
you are way to lazy to compile them all manually. And you do not need to: really not comfortable.

Still, Sword can be used as a smart but slow semi-production server. You can easily deploy it on your own server using
`--daemonize`, `--pid <path>`, `--compress` and `--cache` flags. Those were added to run Sword on the server.

**Sword** uses [semantic versioning](http://semver.org) starting with version 2.0.0.

Get started
-----------

**Sword** is avaliable as a gem, working with all popular
Ruby versions (JRuby, Rubinius, Ruby 1.8...2.0):

```sh
gem install sword
```

Running Windows? I’ve got your back.
[**Here’s your executable**](https://github.com/somu/sword/blob/master/sword.exe?raw=true) with all necessary gems built-in.  
No Ruby required.

Now you start it. If you are using the executable, just throw it into
the project directory and you're ready to rock.  
If you are using it as a gem:

```sh
sword -d your/project/directory
```

You can also `cd` to this directory first, and then run `sword`,
it is okay (`.` is the default directory).  
If you are on OS X, consider using `-o` flag:
it automatically opens `localhost:1111` in your browser.

So. It tells you something like:

    >> Sword 1.8.2/Thin at your service!
    >> http://localhost:1111 to see your project.
    >> CTRL+C to stop.

Now you need to stop it and install all basic gems used for
compiling templates, if you haven't got any.  
Do it using the `--install` flag:

```sh
sword --install
```

And it will install all possible dependencies automatically.
You are ready to go.

Options
-------

    -a, --add <x,y>           Permanently require the gems
        --aloud               Show server's guts
        --cache               Turn on caching for some engines
        --compile             Compile Sword queries
    -c, --compress            Compress templates and assets
        --console             Don't open browser
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
        --pid <path>          Make PID file
        --plain               Skip including gems from built-in list
    -p, --port <number>       Change the port, 1111 by default
        --production          Apply production settings
    -r, --require <x,y>       Require the gems this run
        --scripts <x,y>       List script engines you want to use
        --server <name>       Specify server
    -s, --settings <path>     Load settings from the file
        --silent              Turn off any messages excluding exceptions
        --styles <x,y>        List style engines you want to use
        --templates <x,y>     List template engines you want to use
    -v, --version             Print Sword's version
