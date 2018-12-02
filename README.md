# The Linux Box Generator

Sometimes you just need to write ludicrous things inside of a a Santa or Unicorn box.
Do you know [Confucius](https://en.wikipedia.org/wiki/Confucius)? I'm definitely a fan!
Inspired by [linux toy boxes](https://opensource.com/article/18/12/linux-toy-boxes),
and because I have extreme prowess in making things that are useful **sarcasm**, 
I present to you the linux box generator! And of course it's in a container. Let's get started.

[![asciicast](https://asciinema.org/a/214790.svg)](https://asciinema.org/a/214790)

## Build

```bash
docker build -t vanessa/boxes .
```

## Usage

### Get Usage or Help
If you just run the container without arguments, it will spit out it's usage.
This is what containers should do when you run them blindly, spit out their
guts and tiny little container hearts for you to see.

```bash
docker run vanessa/boxes
docker run vanessa/boxes --help

Usage:

         docker run <container> "Eat dog turds, you oompa loompa!"
         docker run -v $PWD:/data <container> /data/greeting.txt

         Commands:

                help: show help and exit
                list: list available templates
                all: run through ALL the templates (mrahaha)
                
         Options:

                --message:      Select one or more random messages
                --message-file: The file of messages to choose from
                --template:     choose the template that you want
                --no-color:     disable color output (you scrooge!)
                --sleep:        if you use all, the break between prints

         Examples:

             docker run <container> -t dog "I am a dog"
             docker run <container> -t santa greeting.txt
             docker run <container> all WHAT IS GOING ON
             docker run <container> Gogo gadget unibrow!
             docker run <container> Gogo gadget unibrow!
             docker run -v $PWD:/data <container> --message-file /data/insults.txt 
```

### Quick Start
The easiest thing to do (and most fun!) is to run **all** templates with randomly
selected messages. Here is how to do that:

```bash
docker run vanessa/boxes all --message
```

If you just want **one** message, then remove "all"

```bash
docker run vanessa/boxes --message
```

### List Templates

What templates can you select?

```bash
docker run -it vanessa/boxes list
...
santa
scroll
scroll-akn
shell
simple
spring
stark1
stark2
stone
sunset
test1
test2
test3
test4
test5
test6
tex-box
tex-cmt
tjc
twisted
underline
unicornsay
unicornthink
vim-cmt
whirly
xes
```

Oh my. You can use grep to search for a template

```bash
docker run vanessa/boxes list | grep cmt
ada-cmt
c-cmt
c-cmt2
c-cmt3
f90-cmt
html-cmt
java-cmt
lisp-cmt
pound-cmt
tex-cmt
vim-cmt
```

### Interactive Session

If you want to play around with the command inside the container, it's easiest
to shell inside:

```bash
$ docker run -it --entrypoint bash vanessa/boxes
# which boxes
/usr/bin/boxes
```


## Credits

The set of puns and quotes I used from the following source:

 - [Funny Sayings](https://github.com/aussieW/skill-confucius-say)
 
Thank you!
