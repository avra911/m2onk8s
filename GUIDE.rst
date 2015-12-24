=====
Guide
=====

This guide is going to illustrate one way to implement Magento 2 on Kubernetes, hosted on the Google Cloud container engine. The definition of "complete" is fluid, as I'll be progressively filling out the "stack", but below is the approximate path I plan taking:

  - Create the Magento 2 stack (using Google Cloud SQL) running with PHP7 & NGINX - Serve traffic.
  - Create the session handler, cache pods.
  - Create periodically backed-up mounts for shared files such as the media directory (logs are delt with separately)
  - Create monitoring for pod health (so, alert when a pod becomes unhealthy)
  - Create monitoring on the kubernetes nodes for CPU, HDD Space, RAM
  - Set up autoscaling of the kubernetes nodes based on CPU, RAM
  - Create alterting when a pod cannot be provisioned due to resource limits 
  - Create monitoring & alerting for HTTP Response speed (cached & un cached)
  - Implement Varnish, or a suitable alternative (Varnish Y U NO HTTPS)
  - Implement configuration management for payment gateways and the like
  - Implement a CD/CI pipeline

As each of these items are "done", they'll be prefixed with [done] (and the appropriate section of the guide filled out)

Background
----------
  - I know very little about Magento 2. This is to document my experience trying to get it working on Kubernetes so others might gain some insight.
  - This guide will never be finished. If it is successful, I'll be showing it to colleagues as a "Look! This works. Try thinking about it some, see if you think it works"

Presumptions
------------
I'm making the following presumptions: 

  - You're developing on Linux (in my case, Arch Linux). If you're not, start (with Ubuntu) -- It makes development tonnes easier, and lets you get feet-wet on systems you'll be deploying to.
  - You're familar with Magento 1.x, and even Magento 2. I'm a (junior) Magento developer, so if things are unclear, please point it out and I'll clarify.
  - You have the authentication keys from Magento Connect

Let's start with basic housekeeping
-----------------------------------
Keeping everything required for creating a new environment in version control is super important. So, we create the following folder structure (inspired by the excellent thephpleage/skeleton repo)::

  ./.editorconfig
  ./.gitattributes
  ./.gitignore
  ./.scrutinizer.yml
  ./.travis.yml
  ./CHANGELOG.rst
  ./CONDUCT.rst
  ./CONTRIBUTING.rst
  ./LICENSE.rst
  ./README.md
  ./composer.json
  ./phpunit.xml

  ./build/ 
  ./application/
  ./etc/

.. insight:: I have found heavy resistence to changing server software (such as the PHP or NGINX version) on manually managed servers. Upgrading these packages brings a host of new risks, including in the case of one PHP upgrade, changing from listening on a TCP port to socket. It is impossible to automatically provision without keeping things in version control, thus: we keep things in version control.


