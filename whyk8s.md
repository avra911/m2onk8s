---
layout: page
title: Why Kubernetes 
permalink: /whyk8s/
---

# Why Kubernetes 

## Let me tell you a scary, campfire story

* Side note: This didn't happen to me, and it's loosely based on the truth.*

It's Friday afternoon, and you have been tasked with upgrading PHP-FPM on a reasonably low traffic util server so some feature or other will start working. The server is running Ubuntu, and unbenknown to you the package repo has recently been changed by the provisioner. So, you upgrade PHP-FPM and restart - Promptly, the webserver alerts start firing. Oh no! You quickly debug cleverly find that that PHP now defaults to listening on a socket, rather than port 9000. Excellent! You update webserver and you're away. The util server is humming along nicely.

But wait. Alarms are going off? What on earth. Public facing production is down! How can this be?! You immediately demand to know who else is working on this environment. No one pipes up. You investigate the issue and - What is this? *Production* is now listening on a socket? You didn't touch that environment! Precious minutes roll past, and managers are demanding to know what's going on.

A thought occurs to you. It couldn't be - No one would be that insane. You run ``mount``.

WHY THE HELL ARE THE WEBSERVER CONFIGURATIONS SHARED OVER NFS.

You rapidly resolve the issue by making PHP-FPM on the util server listen to a port once again, and reviving the webservers. You now slowly decompress and try to decide what on earth you're going to tell the boss.

## Well, that was stupid. How does Kubernetes help? 

Indirectly, it doesn't that much. It's a provisioner for a technology called "Containers" (or, more particularly, Docker). Containers are a kind of declarative runtime environment that you can ship and it should (from an application point of view) be indistinguishable from development to production. Instead of deploying an application, you deploy the *entire environment*, including (in this case) PHP configuration, webserver configuration, application at a given checkout and whatever else you can think of in an lovely immutable unit. 

## Okay, that's containers. They sound pretty cool. Kubernetes?

Something needs to run the containers. Further, these declarative environments need to know how to find each other. Lastly, secret information needs to be managed. Kubernetes handles all that. It provides lovely abstractions around what is a "deployable unit" (or "Pod"), how that pod should be deployed (or "Replication Controller") and where one pod can find another set of pods ("Service"). 

It's like everything I'd ever wished Chef was. Netflix style "Baking of EC2s" for the masses. 

## Wicked! Where do I get a hold of that

http://kubernetes.io

Be warned, though -- There's quite a bit of thinking you'll need to do to get your head around "Deployable environments". Particularly not deploying code seems to trip people up. Also, I haven't figured out how to develop these environments at any reasonable pace (2 minutes per environment build?! That's a tonne faster than provisioning a vagrant box, but not quiiite fast enough for development)

GLHF, Ask me questions if you find them. 

