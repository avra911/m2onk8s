===============
Project Outline
===============

*** WARNING *** - Though this is intended to be "production worthy" as soon as possible, it's never going to be tested
in a production environment.

- Please, point out things that are wrong with it. I am building this as a reference
- Also, this recently got a bunch more "serious". It's now working, give or take, and I'm improving the design. 

Project Goals
-------------
Magento 2 is a rewrite of the Magento e-commerce platform in PHP. Kubernetes is a container management solution created
by Google (I think, at least) to orchestrate the deployment and life cycle of containerized applications. I initially
intended to write a guide up about "how this works", but that proved too much of a burden. Instead, I just got it up
and running. Check out the git history if you're looking for a bit of a "How To", otherwise, ask me questions and I'll
write documentation by way of answer.

P.S. Kubernetes is so cool.

============= ============ ==============
License       Code Style   Code Locale
------------- ------------ --------------
MIT           PSR-2        en-AU [lang]_
============= ============ ==============

Scope
-----
The goal of this project is to see what infrastructure is required to get Magento 2 to run efficiently on Kubernetes.
For this, we'll be working on:
  - [Todo] Set up Varnish
  - [Todo] Setting up the required volumes for media, etc. 
  - [Todo] Exfiling logs via the Kubernetes log handler for PHP, NGINX and Magento
  - [Wishlist] Kill containers randomly, with increasing chance as they reach {n} life.

Definitions
-----------

Build Pipeline
``````````````

===================== ===================================================================================
Word                  Meaning
--------------------- -----------------------------------------------------------------------------------
Artifact              The deployable unit that goes into a Kubernetes pod. Probably a docker container
Package               A tarball of some series of files that goes into an artifact
===================== ===================================================================================

Infrastructure
``````````````

====================== ====================================================================================
Word                   Purpose
---------------------- ------------------------------------------------------------------------------------
lb (Load Balancer)     The entrypoint for the application. The only public facing container
m2 (Magento 2)         The application. Accepts FastCGI responses
====================== ====================================================================================

Magento  Compatibility
----------------------
This should *always* be running the latest version of Magento. If the most recent version of Magneto is broken, this is broken. 
Further, I don't care about older builds. I'm trying to get into the habit of always working based off the most recent versions
of all dependencies. 

Usage
-----
.. Code::bash

    $ make

That should give you a list of the current things the project can do. If you're looking for additional help for something in 
particular I'll comment that section of the build more heavily (or, at worst, write documentation). I try not to answer questions
directly. 

Contributing
------------
Contributions are always welcome! Feel free to open an issue for discussion 

References
-----------
.. [lang] Lingoes.net,. (2015). Language Code Table. Retrieved 4 June 2015, from http://www.lingoes.net/en/translator/langcode.htm
