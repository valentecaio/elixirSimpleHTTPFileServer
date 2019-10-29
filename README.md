# FileServer

A simple elixir http file server that handles GET and PUT methods.

GET requests of directories will return the `ls -AF` of the requested dir.

example: `curl localhost:8080/`
-> It will return the `ls -AF` of the root directory of the application, `<root-dir>`, that may be set in `config.ex`.

GET requests of files will return the content of the file.

examples: 
(1) `curl localhost:8080/a.txt`
-> It will return the content of the file `<root-dir>/a.txt` as a text/html.

(2) `wget localhost:8080/a.txt`
-> It will download the content of the file `<root-dir>/a.txt`.

PUT example: `curl -T a.txt localhost:8080/b/c/d/e/`
-> It will upload the file `a.txt` and write it under the dir `<root-dir>/b/c/d/e/`. All necessaries subdirectories will be created. Files with same path will be overwritten.

