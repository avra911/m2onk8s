Project Outline
----------------

*** WARNING *** - Though this is intended to be "production worthy" as soon as possible, it's never going to be tested in a production environment. 
*** WARNING *** - This isn't completed. I'll let you know when it is (there'll be celebrations - you won't miss it). 

- Please, point out things that are wrong with it. I am building this as a reference

Project Goals
`````````````
Magento 2 is a rewrite of the Magento e-commerce platform in PHP. Kubernetes is a container management solution created by Google (I think, at least) to orchestrate the deployment and life cycle of containerized applications. I initially intended to write a guide up about "how this works", but that's proving to be too much of a burden. Instead, I'm just going to get it up and running and document my progress through the git history. It's super informal, but it'll help me learn a bunch of things.

It's a Christmas holiday project, so it'll either live or not. If it does, awesome, if it doesn't, I found better things to do.
Edit: It didn't live, I found better things to do. But it lives again!`

Summary
```````
============= ============ ==============
License       Code Style   Code Locale
------------- ------------ --------------
MIT           PSR-2        en-AU [lang]_
============= ============ ==============

Scope
`````
The goal of this project is to see what infrastructure is required to get Magento 2 to run transparently on Kubernetes. For this, we'll be working on:
  - [Todo] Setting up the PHP container
  - [Todo] Setting up the NGINX container
  - [Todo] Setting up the required volumes for media, etc. 
  - [Todo] Exfiling logs via the Kubernetes log handler for PHP, NGINX and Magento
  - [Todo] Creating fault tolerance for the Magento pod
  - [Wishlist] Simulating container death (ideally with something from the simian army)

Expressly out of scope are:
  - Database management on Kubernetes
  - Logging treatment on Kubernetes
  - Pretty much anything else except the PHP7-FPM + NGINX stack.

Compatibility
`````````````
Magento  Compatibility

===== 
 2.0 
-----
  Y 
=====

Installation
-------------

Please see the guide. This is a README template that I do my best to use whenever possible, but it does not fit the format or intent of this project.

Usage
-----

.. Code::bash

  # Todo: Actually test
  $ gcloud container clusters create magento2-example# Todo: Specify additional options
  $ gcloud container clusters get-credentials magento2-example
  $ kubectl create -f ./build/kubernetes/magento.json

Contributing
------------
Contributions are always welcome! Feel free to open an issue for discussion 

References
-----------
.. [lang] Lingoes.net,. (2015). Language Code Table. Retrieved 4 June 2015, from http://www.lingoes.net/en/translator/langcode.htm
