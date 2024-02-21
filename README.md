# ArchiveXenobotMagebomb
This is a script for the popular game bot tool Xenobot used for the game Tibia. This script allowed the player to control 11 game clients at once. It worked by having the player use one client and have 10 automated clients who would follow the leading character and help in combat.

I developed this script prior to and during my first year in college. The script initially started as a fun project on unofficial game servers, after 7 major updates I began selling the script for $5 to about 50 paying users while providing support and future updates.  

## Notable Features:  
* Proximity based healing - Each client would scan for nearby clients and notify them of their current mana if they were wounded. If a client was full health it would heal one of its neighbors who had the lowest health.  
* Automated Onscreen attacks - The player could set peoplet to either attack or "Paralyze". If they came onscreen they would automatically be attacked.  
* Floor following - The script would detect the player changing floors, where they suddenly dissapear. It scans for nearby stairs and would automtaically move each character to change floors and then begin following the leader again.  
* Zerg - The characters all chase a designated target surrounding them resulting in them being unable to move. If no spot next to the target was free they would find a non-friendly client who was beside the target and block them in as well.
* Ingame Help - Full documentation for all 200+ commands with ingame help that would tell the user how to use each command and what it did.  
* Automatic following - If one character died, the line would not break and characters would automatically switch to following the next character
![follow](https://user-images.githubusercontent.com/25403970/213793575-d3fd8ed5-2866-4cc2-bd23-31970e917e27.png)
* Hud - Reported health, supplies for all characters, players being automatically attacked, paralyzed and trigger traps as well as if the module was on or off. 
![image](https://user-images.githubusercontent.com/25403970/213785249-8e215d40-5f1f-44ba-8fca-920d4a89340a.png)
* Dynamic Trap Layouts - The player could add specific squares to a trap. For example, a trap that blocks an exit with unpassable walls. The trap could be triggered manually or by designated squares would would automatically trigger upon a designated or "Skulled" player walking over the trigger square.  
![trap](https://user-images.githubusercontent.com/25403970/213791211-a9d327b5-3261-467d-bcbc-cae07dda25c3.png)
