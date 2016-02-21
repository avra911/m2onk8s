Project Outline
----------------

*** WARNING *** - Though this is intended to be "production worthy" as soon as possible, it's never going to be tested in a production environment. 

- Please, point out things that are wrong with it. I am building this as a reference

Project Goals
`````````````
Magento 2 is a rewrite of the Magento e-commerce platform in PHP. Kubernetes is a container management solution created by Google (I think, at least) to orchestrate the deployment and life cycle of containerized applications. I initially intended to write a guide up about "how this works", but that proved too much of a burden. Instead, I just got it up and running. Check out the git history if you're looking for a bit of a "How To", otherwise, ask me quesitons and I'll write documentation by way of answer.

P.S. Kubernetes is so cool.

```````
============= ============ ==============
License       Code Style   Code Locale
------------- ------------ --------------
MIT           PSR-2        en-AU [lang]_
============= ============ ==============

Scope
`````
The goal of this project is to see what infrastructure is required to get Magento 2 to run efficiently on Kubernetes. For this, we'll be working on:
  - [DONE] Setting up the PHP container
  - [DONE] Setting up the NGINX container
  - [DONE] Setting up the REDIS container for sesions, cache
  - [Todo] Set up Varnish
  - [Todo] Setting up the required volumes for media, etc. 
  - [Todo] Exfiling logs via the Kubernetes log handler for PHP, NGINX and Magento
  - [DONE] Creating fault tolerance for the Magento pod
  - [Wishlist] Simulating container death (ideally with something from the simian army)

Compatibility
`````````````
Magento  Compatibility

======
 2.0.1 
------
   Y 
======

Usage
-----

Take a look at the Makefile for the various common tasks that you're likely to require. If you're looking for specific instructions, lodge an issue and I'll write some up. I won't answer questions directly - Instead, I'll amend the documentation and ask you if you can derive your answer from that! In this way, we'll build a reference others can look at without 

Contributing
------------
Contributions are always welcome! Feel free to open an issue for discussion 

References
-----------
.. [lang] Lingoes.net,. (2015). Language Code Table. Retrieved 4 June 2015, from http://www.lingoes.net/en/translator/langcode.htm
