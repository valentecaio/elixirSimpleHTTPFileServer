# FileServer

A simple HTTP File Server made in Elixir using cowboy Erlang/OTP HTTP server that handles GET and PUT methods.

## Launch server

You only need to fetch the dependencies and launch it as a simple elixir application.
```
$ mix deps.get
$ iex -S mix
```
And there it is! your server is running and serving the `/tmp/` dir.

## Configure server

You may change the default ip, port, or root_dir in the file config/config.ex.

## GET requests

### GET `<directory>`

GET `<directory>` : requests of directories will return the `ls -AF` of the requested dir.

example:
```
$ curl localhost:8080/
```
Return the `ls -AF` of the root directory of the application, `<root-dir>`, that may be set in `config.ex`.

### GET `<file>`

GET `<file>` : requests of files will return the content of the file.

examples: 

(1) Check the content of the file `<root-dir>/a.txt` as a text/html.
```
$ curl localhost:8080/a.txt
```

(2) Download the content of the file `<root-dir>/a.txt`.
```
$ wget localhost:8080/a.txt
```

## PUT requests

PUT `<file>` : use PUT requests to upload files to the server

example: Upload the file `a.txt` and write it under the dir `<root-dir>/b/c/d/e/`. 
         Create all necessary subdirectories. Overwrite files with same path.
```
$ curl --upload-file a.txt localhost:8080/b/c/d/e/
```

