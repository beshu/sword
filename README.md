Sword [![](http://so.mu/icons/sword.png)](http://so.mu/blog/sword)
=====
[![Build status](https://secure.travis-ci.org/somu/sword.png?branch=master)](http://travis-ci.org/somu/sword)
[![Version](https://badge.fury.io/rb/sword.png)](http://rubygems.org/gems/sword)
[![Dependency Status](https://gemnasium.com/somu/sword.png)](https://gemnasium.com/somu/sword)
[![Code readability](https://codeclimate.com/github/somu/sword.png)](https://codeclimate.com/github/somu/sword)

[**Documentation**](http://rubydoc.info/github/somu/sword/master/frames)  
[**Rubygems**](http://rubygems.org/gems/sword)

Sword is a designer’s best friend. It allows to use any kind of preprocessor (Sass/Compass, CoffeeScript, Stylus, &c.)
out-of-the box, to emulate real paths and to compile all your result into .zip-archive to upload your result to a server.

Get started
-----------

**Sword** is avaliable as a gem:

```sh
gem install sword
```

Working with all popular Ruby versions (JRuby, Rubinius, Ruby 1.8..2.0).

Running Windows? I’ve got your back. Here’s your [**.exe version**](https://github.com/somu/sword/blob/master/sword.exe?raw=true)
with all necessary gems built-in.  No Ruby required.

Now you turn it on. If you are using compiled version, just throw the executable into the directory and you're ready to rock.  
If you are using it as gem:

```sh
cd directory/you/wanna/watch
sword
```

And it works. One-liner:

```sh
sword -d directory/you/wanna/watch
```

And it tells you something like:

    >> Sword 1.6.0/Thin at your service!
    >> http://localhost:1111 to see your project.
    >> CTRL+C to stop.

Still, you need to install all basic gems used for compiling templates. Do it using Sword `--install` flag:

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


[![Donate](https://www.paypalobjects.com/en_GB/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8PCQ52CFPFSKL)

Yandex.Money: 410011380966315
