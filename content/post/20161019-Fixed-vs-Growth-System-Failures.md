+++
description = ""
title = "Fixed vs. Growth System Failures"
date = "2016-10-19T11:06:08-08:00"
tags = ["Growth Mindset", "Postmortem", "DevOps", "Software Development"]
+++

The concept of Mindset based on the work: [Mindset by Dr. Carol S. Dweck,
Ph.D.](http://amzn.to/2dEPR9M)
has been around for some time now, but recently I was thinking about root cause
analyses meant as a tool for learning. Revisiting the John Allspaw post: The
[Infinite Hows (or, the Dangers Of The Five
Whys)](http://www.kitchensoap.com/2014/11/14/the-infinite-hows-or-the-dangers-of-the-five-whys/) make me start thinking about
what makes a lot of people look at postmortems as a checkbox or paperwork and
not value them as learning experiences.
<!--more-->

## Mindsets
Mindsets are how people view qualities related to their own abilities. There are
two types of mindsets: fixed and growth.

A fixed mindset views abilities as fixed traits that have a finite limit. A
person with a fixed mindset tends to think that challenges should be avoided and
can give up easily; effort is unnecessary because their ability is a known
quality.

In contrast to a fixed mindset, a growth mindset believes that abilities can be
developed and a person's full potential cannot be known because there is no end
to developing traits. A person with a growth mindset tends to think that
challenges can be embraced because the potential to grow is greater; effort
leads to greater understanding.

I tend to see a growth mindset with engineers in tech when approaching software
development. Engineers in tech, in general, have to have a growth mindset
because there's always a new language, framework, service, system, etc. to
learn. However, when bad things happen in production on a lot of teams will
approach the postmortem with a fixed mindset.

## Qualities of a Fixed Mindset RCA
**Fixed Mindset Quality #1:** The root cause asserts blame.

> When cloud/infrastructure provider x has an outage and our software is
> unavailable as a result.

A fixed mindset will assert blame for a failure. This is usually because an RCA
is perceived as a tool for finding fault.

**Fixed Mindset Quality #2:** The root cause is an admission of failure.

I've heard the answer in many postmortem meetings that "I did this" or "an
engineer acted on the system". It implies that the engineer who pushed the
button caused the failure.

> Q: How do we prevent the issue that caused the outage from happening again?  
> A: Engineers need to do a better job.

**Fixed Mindset Quality #3:** The root cause is extraneous paperwork.

Organizations will sometimes put the requirement that a software engineering
team conduct a root cause analysis before they can release again. This is
generally a good practice, but if RCAs are approached with a fixed mindset the
RCA is viewed as red tape, paperwork, or some sort of bureaucratic checkbox.

**Fixed Mindset Quality #4:** The postmortem lacks follow-up actions

A fixed mindset perspective views each incident as isolated and based on a
mistake and being more careful next time will prevent another outage.

## Qualities of a Growth Mindset RCA

**Growth Mindset Quality #1:** The root cause asserts responsibility.

> Cloud/infrastructure provider x had an outage and our software does not
> handle the case when y service is not available.

A growth mindset will see faults as something that can be fixed and improved.
The growth mindset views RCAs as a tool for understanding and improvement.

**Growth Mindset Quality #2:** The root cause is an opportunity to learn.

A growth mindset will explore the deeper understanding of what happened and the
circumstances. This implies that the engineer is an actor in a larger systemic
problem and not simply a single cause.

**Growth Mindset Quality #3:** The root cause is a necessary learning opportunity.

A growth mindset will conduct a postmortem without it being a required
activity. The learning opportunity is valuable and a growth mindset will view
it as a way for all parties involved to learn more about the system under
review. Typically a growth mindset will value reading RCAs out of interest and
curiosity.

**Growth Mindset Quality #4:** The postmortem has many follow-up actions.

After a postmortem has taken place, a growth mindset will have at least 2
possibly 3 follow-up actions as the postmortem should have created a way for
teams to collaborate and provided a venue for solving problems and finding
innovative ways to prevent problems.

## Methods for Growth Mindset Postmortems
**Almost all questions should begin with "what" or "how" and seldom should they
begin with "why".**

Why tends to be the wrong question more often than not. Why tends to lead to pointing fingers at people or systems and doesn't tend to understand the _actual_ cause of the event.

For example, "Why did a bug ship to production?" vs. "How did a bug ship to production?". Why would lead you to a response similar to "because the team didn't test it". How would lead you to a response similar to "because the tests did not catch it."

**Hindsight is 20/20 so remember the actions that cause an incident are obvious
now, but may not have been obvious during the incident.**

A postmortem can't focus on what should have been done, but rather what was done
and, based on that, how the software or the system can be changed to prevent
failures. At a postmortem you typically have a better idea of what went wrong
and can look at an event and say "yep, we shouldn't have done that" but that
brings present context into a past event. At the time, the causes of the event
happened because something was perceived to be not dangerous.

**Reinforce accountability without reinforcing blame.**

It's okay for a retrospective to come up with a set of action items that teams
and other people and teams are accountable for, but remember that everyone is
on the same "team". The goal is to improve the system, learn more as engineers,
and share the knowledge. Blaming failures on yourself, other engineers, other
teams, technologies, frameworks, etc. will not help anyone grow.

> The x feature of this language's core library is a mess and causes y issue.

Even if the description of the issue was well formed (which it tends not to be) the lead into it absolves the team of accountability.

> The team was not aware at the time that the x feature of the language's core library would cause y issue.

This indicates that the the team has acknowledged the gap in understanding and sets up describing a follow up action easily and shares knowledge of the issue at hand.

## Feed your Growth Mindset postmortems
Be a consumer of postmortems. There are a lot of public postmortems out there
because a lot of companies have run into very non-obvious problems with
technologies integrated into a system.

Here are a couple of my favorite postmortems:

* https://www.joyent.com/blog/manta-postmortem-7-27-2015  
Joyent's postmortem had a lot of reflection and I learned a lot reading it. I
can only imagine how much the engineering teams learned from the postmortem.
* https://github.com/blog/1261-github-availability-this-week  
Github's postmortem from 2012 is my first exposure to failure in distributed
system failures and really got me thinking about to what extent a failure of a
distributed system could mean.
  
  
You don't have to share your postmortems publicly to get people motivated.
Internally at the company you work at, you should share your postmortems across
your engineering organization; A wiki is a good medium for this. Embracing the
Growth Mindset means accepting feedback on your postmortems you publish and
looking to learn from others. What happened to team X? How did they fix it? How
will they keep it from happening again?
