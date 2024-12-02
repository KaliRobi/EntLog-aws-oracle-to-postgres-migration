The idea for this project comes from the need to migrate a couple of hundred business unit (BU) reports, originally written in Oracle SQL (but needed as PostgreSQL),
scheduled on a Red Hat server managed by a heroic support team. The storyline intensified due to the early-late departure of a side character (well, main, from a certain point of view).

I shall not mention here the name of the original environment — closely resembles STARLog 2*twink— I've chosen to dedicate this project to the oft-underrated Ents of Middle-earth. 
While I understand the sentiment toward dwarfs, elves and so on nobody is as awesome as trees who can walk, talk about old stores and shepherd the forest.

Why Ents? Because they are awesome. Also has something to do with reaching the first corresponding chapters in Sõrmuse Isand.  (Yes, when they reach the Old Forest)

From technical point of view the underlying aws test environment was a bit challenging to assemble than writing the python script (the main actor here), 
but it certainly helped sharpen my skills for the DVA-002. The CloudFormation template creates what the project needs so i dont need to do it manually.
EC2 with the user data, the two RDS(e)s oracle and Postgre dbs, VPC with subnets to allow accessing RDS instances, also a S3 bucket for the execution files.
