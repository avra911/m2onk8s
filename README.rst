===============
Project Outline
===============

*** WARNING *** - Though this is intended to be "production worthy" as soon as
possible, it's never going to be tested in a production environment.

- Please, point out things that are wrong with it. I am building this as a
  reference
- Also, this recently got a bunch more "serious". It's now working, give or
  take, and I'm improving the design.

Documentation: http://andrewhowdencom.github.io/m2onk8s/

Project Goals
-------------

Magento 2 is a rewrite of the Magento e-commerce platform in PHP. Kubernetes is
a container management solution created by Google (I think, at least) to
orchestrate the deployment and life cycle of containerized applications. This is
Magento 2, running on Kubernetes.

Todo
''''

- Deploy via Travis
- Run Redis in High Availability
- Run MySQL + Slave
- Allow easy local development
- Set up Varnish
- Setting up the required volumes for media, etc.
- [Wishlist] Kill containers randomly, with increasing chance as they reach {n} life.

============= ============ ==============
License       Code Style   Code Locale
------------- ------------ --------------
MIT           PSR-2        en-AU [lang]_
============= ============ ==============

Similar Work
------------

None, so far as I know.

Justification
-------------

Demonstrate a POC of Magento on Kubernetes

Alerting Policies
-----------------

Todo: Implement

========================== ====================================================
Policy                     Description
-------------------------- ----------------------------------------------------
GET / (https) not 200      Check whether the HTTPS homepage is working
GET / (http) not 302       Check whether the site is redirecting from HTTP
TCP Open for Redis         Check whether the Redis service is operating correctly
Get / (http) 200 Varnish   Check whether the Varnish service is OK
TCP Open for MySQL         Check whether MySQL is OK
Query for MySQL            Check whether we can query in MySQL
========================== ====================================================

Naming Standards
----------------
Things are named after their purpose in the stack rather than the relevant
software they use. For example, the load balancer is powered by "NGINX" and
there are references to "NGINX" in various places. However, it's a load balancer
(that also serves static assets -- A bit of a problem there). Therefore, it's
called "lb" and not "NGINX".

Definitions
-----------

Build Pipeline
''''''''''''''

===================== ===================================================================================
Word                  Meaning
--------------------- -----------------------------------------------------------------------------------
Artifact              The deployable unit that goes into a Kubernetes pod. Probably a docker container
Package               A tarball of some series of files that goes into an artifact
===================== ===================================================================================

Infrastructure
''''''''''''''

====================== ====================================================================================
Word                   Purpose
---------------------- ------------------------------------------------------------------------------------
lb (Load Balancer)     The entrypoint for the application. The only public facing container
m2 (Magento 2)         The application. Accepts FastCGI responses
====================== ====================================================================================

Magento  Compatibility
----------------------

This should *always* be running the latest version of Magento. If the most
recent version of Magneto is broken, this is broken. Further, I don't care about
older builds. I'm trying to get into the habit of always working based off the
most recent versions of all dependencies.

Usage
-----

This is deployed entirely by Travis. For developing things, I'll eventually
host a cluster locally, but for the time being I'm just pushing changes out and
if it breaks, it breaks.

Contributing
------------

Contributions are always welcome! Feel free to open an issue for discussion

References
-----------

.. [lang] Lingoes.net,. (2015). Language Code Table. Retrieved 4 June 2015,
from http://www.lingoes.net/en/translator/langcode.htm
