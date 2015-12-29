=================================
Step 2 - Let's serve some traffic
=================================

We need to get the actual application onto the kubernetes stack. To do this, we're going to create a "pod" with an NGINX container and a PHP7-FPM container. 

.. Warning:: I am leaving CRON as an unsolved issue at the moment. My intent is to use the Kubernetes scheduled job API, but it's due in 1.2. See https://github.com/kubernetes/kubernetes/pull/11980. If it becomes a greater issue, I'll home-brew something. 

.. Warning:: I haven't solved CLI usage yet. My feeling is somewhat "Try not to use it", but for things like cache caches during deloyment and the like some interaction is required. Maybe it should be via HTTPS?

.. Info:: My current thinking is that PHP7-FPM and NGINX should be in separate containers *with separate filesystems*. I dislike mounting filesystems unless it's strictly necessary, and certainly not for critical application or configuration files. If the containers are separate, kubernetes can keep an eye on each process and mark a container for restart if it fails for some reason (PHP7-FPM locks on a MySQL transaciton or something else nuts)

- // Todo: Notes about docker no longer limiting to just the build dir
- // Todo: Notes about why u no PHP
- // Todo: Change Step #1 guard notes for commands
