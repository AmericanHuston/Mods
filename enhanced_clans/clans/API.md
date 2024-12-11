A little to know about me and my coding:
I'm by no means a professional coder, and as such this code isn't
great. That being said, it all should work as intended. It's all 
still under development.

Local playercs.
Playercs is = to the player name + "-clan".
Playercs is a common variable that has been put in for easier and better access to clan storage.

Local level.
Level is = player name and "-level"
"-Level" is = to the number of people killed(killer) - number of how many times they have died(victim), or total sum of the two variables(killer - victim = level).
Level is an important peice of the sorting alg, it is the variable being divided. 
Level has many uses for example, if you want to use level in your server to keep track of how many times somone has killed or been killed.
All you would need to do is change line 101 from ,klevel ~= 5 to ,klevel ~= whatever number you want.(Must be positive)


Alright, the cool stuff:
tables:
    clansmod.clans
        --- The avaliable clans, by default
    end
end

functions:
    clansmod.add_to_clan(issuer<string>, playername<string>, random<bool>, clan<optional,string>)
        --- Sets a player to a clan, if one isn't given
        --- its randomly selected from clansmod.clans
    clansmod.remove_from_clan


playername is = to the player name + the clan of the player.
All this is is playercs a local that has been put in for easier and better access to the player and clan at the same time.