#Network Security Groups

## What This Is
These are firewalls you can use to control the traffic between your vNets or subnets. These have a priority list just like regular firewalls but they only go from 100 to 4096. NSGs can be either applied at the subnet or at the NIC level. It's generally recommended to put NSGs at the subnet level so it'll be easier to manage once these networks become bigger.

## What I Built
I followed the lab in Microsoft Learn and I built an NSG where traffic to and from those networks were being monitored. I also set up a public and private DNS zone so there is host resolution for the services inside. 

## Why I Made These Choices
At least for now until i get into sections where there's a really deep need to document what i did, all im going to say for this section at least is i prioritized the best practices when configuring said nsg associating affected subnets, making sure the specific rules have higher priority first

## What Broke
I realized why i kept getting policy errors even if i configured my deployments correctly, it's because for my case specifically the account i have can only support a limited amount of regions so in that sense, whenever i tried to pass a deployment request it would constantly say policy violation

## How I Diagnosed It
I then looked closely when i was selecting regions and there i realized that there were eligible and ineligible regions on my azure subscription. And i chose the right region this time and fortunately the deployments finally worked

## What I Consulted
Networking masterclass of John Savill, Firewall and ACL videos of professor Messer and of course configuring Network Security Groups from Microsoft Learn

## What I Understand Now
I know understand basically what it means to have a firewall for my private network and how i can use said firewall to control traffic so i can protect my resources better

## Open Questions
Will i be able to route traffic this way or do i need to use a different way to route it?