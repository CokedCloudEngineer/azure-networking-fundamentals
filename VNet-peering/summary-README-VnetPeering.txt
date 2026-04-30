#Vnet Peering

## What This Is
One paragraph. What this concept is and why it matters.
In your own words. Never copied from documentation.

## What I Built
I configured a working peer between two networks, i used network watcher to make sure those two vnets were
able to talk to each other correctly. I provisioned two vms using the portal with a windows server image template. I made sure their ip addresses didn't overlap i turned off boot diagnostics and i cleaned up when i was done like normal.

## Why I Made These Choices
I decided with more justification in the next section that i will be following somewhat the instructions on Microsoft's learn exercises

## What Broke
When i was checking network watcher, the two networks were unreachable. I tried following the instructions to the exact letter but nevertheless it didn't work after several attempts. 

## How I Diagnosed It
I checked if my configurations were wrong, they weren't. I tired restarting the portal, deleted everything and reprovisioned everything still to no avail. I figured since things were taking way longer than normal to complete maybe it was a problem with my connection. So i went to a place with better wifi and everything peered now.

## What I Consulted
Nothing i just consulted for myself for now at least

## What I Understand Now
That peering is intuitive but simple and that you do need a decent internet connection to use Azure

## Open Questions
In the future how am i supposed to finish my capstone project and lay out the foundations for my separate workloads?
How will i be able to define the routes on these?