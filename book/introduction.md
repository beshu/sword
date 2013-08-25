**{{name}}** is a designer’s best friend.

It works as follows: you put, say, `index.slim`, `main.sass` and `script.coffee` into your project folder,
run {{name}} in it, it tells you to open `localhost:{{port}}` in your browser, you do so, and you see your
website all working.

Technically, it is a Sinatra server application with a configurable environment,
very wise routing mechanisms and a lot of metaprogramming stuff inside.

When you make `GET /page` query to {{name}} application, it searches for files named `page` in the project
root with an extension linked to some templating engine in `templates`. When it finds, it compiles it
and gives you back (if you're interested in how {{name}} works, run it with `--debug` flag).

Sword is designed to be used in local static website development, when you want to use different preprocessors like Sass, but
you are way to lazy to compile them all manually. And you do not need to: really not comfortable.

Still, Sword can be used as a smart but slow semi-production server. You can easily deploy it on your own server using
`--daemonize`, `--pid <path>`, `--compress` and `--cache` flags. Those were added to run Sword on the server.

**{{name}}** uses [semantic versioning](http://semver.org) starting with version 1.6.0.
