======
Design
======

In this document, you'll find architectural notes as I feel I need them.

Problems that need solving
--------------------------
- Cron (Could run this in a separate container, invoking a public script with basic auth. Kind of awful, though)
- Secrets

Todo list:
----------
Items marked "[done]" are done.

- Get it running
- Get MySQL Running
- Get health checking working

Health checking and PHP
'''''''''''''''''''''''

Kubernetes supports arbitrary checking of the various pods to decide if they're
"healthy" or not. I haven't yet decided whether it's a good idea to couple
NGINX and PHP (at the moment I'm feeling like yes, it's a good idea, but it
varies a lot)

If NGINX is in the stack, heatlh check the PHP-FPM status page, and kill
the entire pod if that fails. If not, open a TCP socket to the PHP-FPM container.

See: liveness probes

Monitoring
''''''''''

Monitoring should probably be abstracted away behind an endpoint. The
justification is we want to be able to deploy this opaquely, to a
random cluster, and not rely on other services running in this cluster.
