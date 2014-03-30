Title: Why Pindown ?
Date: 2013-03-29 10:20
Slug: why
Author: ybrs
Summary: What's the motivation behind Pindown.io ? Why we started making yet another continuous deployment server ?


First, what is Continous Deployment ?
--------------------------------------

tl;dr use Jenkins if you can, but if you need something simpler, use Pindown.

When you make a change in your code, you add it to git, commit it, and you push. And that should be the only thing to update your website. Automate the ssh/login/restart services and what ever needs to be done. We call it continous deployment.

There are a couple of ways you can do this, first - and maybe the easiest - you can write a simple fabric file, or automate it with some git hooks and ssh commands.

This works, but if you aren't alone in the project, it makes things complicated, first you have to provide 
access to other people. Of course you can have some deployment users in your servers with restricted access and all, but makes things complicated.

The other alternative is install Jenkins - or maybe some other CI server - in another server, add some git hooks and attach your deployment script. Honestly, this is the perfect setup, people in the project, other developers, frontend developers, document writers... Can deploy by just pushing their code, without even knowing where the servers are. I use Jenkins for more than a few years and really love it.

But the downside is, you have to setup a Jenkins server and give access to people. If you have more than a few servers in your project, thats totally acceptable, though if you have more than a few side/small projects running on just a couple of servers, this makes things complicated.

I have a few side-projects, small things, like wordpress site for my friends... I really hate, whenever I change something I need to login to servers do something, or setup ssh access for other people, I had this pretty idea, if i have a single Jenkins server for all those projects, things will get simpler.

Well eventually it didn't get any simpler. All I wanted to do is copy a github hook url, paste it in github, add a deploy script in repo, and send invites to people in the project - so they can see when it deploys. Jenkins is overkill for this kind of setup. I just got bored in the middle, adding ssh keys of jenkins to multiple servers, setting up users, really I just needed something more lightweight. And I had another thing to look after.

Then I wrote a simple Flask app, listening to github hook url, running deploy script, mailing to people. This worked pretty well, even without a UI, frontend developer pushes the code, it deploys and sends a mail. Cool. But I had to make sure it works, so added it to supervisor, install it to different servers, change firewall rules... I wrote an installer first, added to fabric, different github urls for different servers, multiple githook urls for multiple servers. Oh fuck, its solving the problem but in the most complicated way. Now I had a new project to maintain.

These didn't work, so I started looking at alternatives, hosted Jenkins or deployment server, well they are either complicated, or wants my ssh keys, or not cheaper than a VPS. So doesn't make sense - it makes sense if you have more than a few people working on a project running on more than a few servers, don't get me wrong.

Back to square one, run a single jenkins server ?

I said fuck it, I can make something dead simple in a weekend - or maybe two. If I have to look after some other project, at least it can be something I'd love. Well it took more than a few months, but it's working as I like since day one.

Anyways, since I really love using this, I added a few features and thought someone might be trying to solve the same problem, and started running it as a service. Thats it, Pindown.io, simple continous deployment as a service.
