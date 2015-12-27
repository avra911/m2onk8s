============
Introduction
============

This guide is going to illustrate one way to implement Magento 2 on Kubernetes, hosted on the Google Cloud container engine. The definition of "complete" is fluid, as I'll be progressively filling out the "stack", but below is the approximate path I plan taking:

  - [DRAFT] Set up the repository and build pipeline. 
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
