BattlePets Arena Service
================

This is to be used with the [BattlePets
CLI](https://github.com/mwenger1/battle_pets_cli). Be sure to have this server
running in the background while playing the CLI game.

Getting Started
---------------

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, Redis, etc. If not,
set up your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using:

    % rails s -p 7001

NOTE: Using the correct port is critical for the CLI game to work.

Guidelines
----------

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best
  Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
