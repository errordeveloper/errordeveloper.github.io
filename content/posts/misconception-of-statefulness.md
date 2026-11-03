---
title: "Misconception of Statefulness"
date: 2026-11-03
draft: true
---

When you think of deploying an ordinary web app to Kubernetes, you must assume it is stateless, of course. Namely, an app that just has an ingress config, some number of pods serving API traffic and connecting to a hosted database.

Most folks will assume the app is stateless and you can just sit back and make lots of assumptions about how easy your life is, and how stateful database operations are worse paying someone else to take care of.

Now, we said you have just deployed an app to Kubernetes. Yes, there is a hosted database handing most of stateful business. There is some negligible state, perhaps on the client side, as eg cookies, you might even have sticky load balancer or long-lived websocket connections, however for most part you app is not handing state. You are very chill and feeling safe.

Deployment is seemingly easy, you have some images and some YAML, all this stuff is automated, and perhaps you have provisioned a database with some YAML also, and it is all fun and games.

Now, think again - what about the operating system running this Kubernetes cluster, if you are lucky the sate is somewhat contained and you can manage entropy by rehydrating nodes on upgrade, because the app is, as we said, stateless and easy to restart on another node very quickly.

However, if your nodes were easily rehydrated, what about the Kubernetes control plane? Are you also quite lucky to be able to easily rebuilt every cluster you have and seamlessly switch the traffic over? It is good for you if you can, if you don’t - you have state and a dose of unmanaged entropy already.

Are you already following where I might be going? Maybe you aren’t, and that is also fine, I am maybe you don’t have much to worry about yet, but I am not done here. I can guess that a few will be able to guess, let me know in a comment!

So, just to recap, entropy is state, and nodes are a common source of entropy, and folks deal with that very explicitly or implicitly, albeit not everyone has the luxury.

Now, cluster entropy is supposedly easier to manage, or at least one who have been practicing GitOps to the latter, will be able to claim that they have it under control.

Are you the lucky type who has a small GitOps setup where all Is are doted and Ts crossed, at least on weekly basis? Are you a part of a small team who own all workloads, and know how everything is supposed to work? Or are you someone who inherited an organically grown set of application and solutions that you didn’t have anything to do with…?

Let’s say you just walked into a job, and GitOps vision that you have lived by is nothing but… ok, maybe i am getting too personal, haha.

All in all, we can say with a fair level of certainty that GitOps ideas are somewhat of a dream state, it is perfectly viable at a certain scale, just like anything else one could daydream about. A perfect state of affairs. Going back to personal matters, I can say I am as much of a perfectionist as I am a realists, for better or worse.

What can we say about a cluster plus some GitOps-y deployment solution and that may have looked like stateless app on day one and is no longer? We can only wish it remains stateless and we can go back to party with all those safe assumptions that someone else is taking care of the databases and we can bet on their SLAs for the app to work perfectly well for all of our users. Maybe; but it would be quite foolish of me to maintain that kind of assumption of the world of this app been all that perfectly stateless. It is in fact perfectly stateful, just the minute there is any entropy. It is even more stateful just the minute I deployed a few things into this cluster, and trusted the tools to delete whatever it was, without checking for any leftover state. Imagine I have deployed a bunch of OSS apps, and deleted without looking back. Did I check if namespaces were cleaned up along with any cluster-scope resources? Of course I only made some cursory checks. Did validate that the app didn’t touch anything outside of its dedicated namespace? Be sure I haven’t done more than any other engineer would.

And we didn’t even consider agents doing much of what I just described at an enormous pace in a large org, against cluster that may not be all that perfect in the first place.

Anyone with contradictory opinions has my ear, of course, just do not try to convince me that I am exaggerating any of these matters. If you are lucky in your very constrained small-scale situation, do keep in mind that when commercial success knocks on the doors of your bubble, it is going to burst.

Part 2: forever pet
