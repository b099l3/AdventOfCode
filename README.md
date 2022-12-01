# Advent of Code

![advent of code](adventofcode.png)


This is my Advent of code repo, it has a couple of helpers to make it easy to setup for the next day. 

As a wise Fergus Howe once said:
> Same as every other year, do it until it becomes remotely challenging

I used [asdf](https://asdf-vm.com/) for managing my flutter version, more info [here](https://www.iainsmith.me/blog/future-proof-your-flutter-env)

## VSCode snippets

I have a couple of snippets to help with the days:

### adventday | ad
Create the days class


## bin/secrets.dart

** Also need todo this, once every year **

This repo pulls down the inputs from the advent of code site, using the session cookie. You will need to create a file: `bin/secrets.dart` with the code from your session cookie:

``` dart
const code =
    'THE CODE FOR THE COOKIE';
```

to get your session cookie, log into https://adventofcode.com/ then inspect then pull teh code from the cookie `session=blahblah`
