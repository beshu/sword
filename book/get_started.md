**{{name}}** is avaliable as a gem, working with all popular Ruby versions (JRuby, Rubinius, Ruby 1.8...2.0):

```sh
gem install {{gem}}
```

Running Windows? I’ve got your back. [**Here’s your executable**](https://github.com/{{user}}/{{repo}}/blob/master/{{repo}}.exe?raw=true)
with all necessary gems built-in.  
No Ruby required.

Now you start it. If you are using the executable, just throw it into the project directory and you're ready to rock.  
If you are using it as a gem:

```sh
{{name}} -d {{dir_sample}}
```

You can also `cd` to this directory first, and then run `{{name}}`, it is okay (`{{directory}}` is the default directory).  
If you are on OS X, consider using `-o` flag: it automatically opens `localhost:{{port}}` in your browser.

So. It tells you something like:

    >> Sword {{version}}/Thin at your service!
    >> http://localhost:{{port}} to see your project.
    >> CTRL+C to stop.

Now you need to stop it and install all basic gems used for compiling templates, if you haven't got any.  
Do it using the `--install` flag:

```sh
{{name}} --install
```

And it will install all possible dependencies automatically. You are ready to go.
