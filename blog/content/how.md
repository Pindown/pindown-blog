Title: How it works ?
Date: 2013-03-30 10:20
Slug: How-it-works
Author: ybrs
Summary: How it works in detail, what we used when building this.

Pindown, is not trying to be the next CI server, if you excuse the analogy, I don't want it to be what is wordpress or medium to blogging, I want it to be Tumblr. Simple, less features, but gets the job done, easy, simple.

So all the choices in product design is taken with this motto.

Summary
--------

- You install an agent with something like this, just copy paste it in your shell

````bash
pip install pindown-agent
pindown_agent_setup 542206bcec7d2b085118734f 1a718e1e-fd82-4e74-cc5b-fdf5c22e7fe8
pindown_agent_add_project 542206bcec7d2b085118734f "pindown"
pindown_agent_run
````

- You copy paste your hook url to Github. Something like this.

````python
https://pindown.io/hook/542206bcec7d2b085118734f/1a718e1e-fd82-4e74-cc5b-fdf5c22e7fe8
````

- Add a deploy script to your repo something like

````bash
#!/bin/bash
git pull origin $BRANCH
touch /var/run/uwsgi
````

- And if you want you can invite other people to project.

Thats all it takes. You don't need to deal with ssh keys, setup the next Paas/Saas thing with docker and all... Just plain simple.

![Screenshot]({filename}/images/pindown-blog-scr.png)



Agents
-------

Pindown uses agents to communicate with the Pindown.io. There are couple of reasons we use agents.

- I really don't like the idea of storing private keys in Pindown. Even Adobe, Sony gets hacked. Who knows your email account won't be stolen etc... Its just too risky.

- If you want to cancel your account - move to Jenkins maybe -, you can just uninstall agent. Since we don't store any sensitive information - eg. your ssh keys, ftp passwords etc. - you can just forget about it.

- Its fast, I mean its really fast, well logging into your servers with ssh takes seconds, and not something really makes sense when deploying but it feels really slick.

- Agents deploy in parallel. So if you have one server or a hundred, deployment takes seconds.

- Agents communicate with Pindown in encrypted way, with a pre-shared key. So no man in the middle attacks or someone sneaking if you are deploying. Well does it matter ? I really am not sure, but it feels better. Secure by default is better.

- Agents run only one file, deploy.sh in your repository. This is hardcoded and can't be changed. The reason is well again, security, if someone hacks your account, all they can do is running deploy script - if you add something simple like "deploy if any changes in the repo" line on top of it. They can't even do that.

- Agent's code is open source. Well no one wants to run something without knowing what it does right.

Access to your repo, to your code
---------------------------------

We don't access to your repo, this is something I thought for a while, it's nice to show what triggered your deploys in detail etc. But I decided I don't need to access your code at all, so for keeping the information minimum, we don't need to see your code at all.

Github, Bitbucket hooks sends latest commit messages, so we store them, but thats all. Can't see your code and don't want to.
