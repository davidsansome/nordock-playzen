/*
file: about_scroll
Created By: Brandon Mathis
Created On: 7/12/2002

The scroll system allows players to create scrolls.  It follows the 3rd edition
dungeon master guide rules, so it may create scrolls that are more expensive
than just buying them normally in NWN.  If so, you may want to remove scrolls
from shopkeepers or up their price.  This module is to make NWN more like
true 3rd D&D.

To create a scroll the player must have memorized the spell that they wish to
inscribe.  Additionally they must have enough gold, and enough xp to create the
spell.  The cost of the spell in gold is 25 * spell level * caster level / 2.
The cost of the spell in XP is spell level * caster level.

There is a scroll delay between when the PC first starts to create a scroll and
when it is actually added to his inventory.  It default to 24hours per 1000gp of
base cost of the scroll.  To adjust this see the bm_scr_opt_inc file.  To turn it
off completely change it to 0.
If the PC logs off, they will still be able to create the scroll when they next
log on as long as the module has not been reset.
If the player goes into combat during this time of waiting they will fail the
creation of scroll.


To use the system you can either use the delivered scroll maker npc, named scrollmaker
found under custom npc's, elf.  Or you can create your own spell maker npc.
To do so follow the following instructions:
Goto scripts tab of NPC.
OnCoversation - bm_scr_onconv
OnSpawn - bm_scr_spawn
OnHeartBeat - bm_scr_hb - only put this on one scrollmaker NPC if you have multiple
and set this scrollmaker npc to plot.  Killing this npc will stop players from creating
scroll that have been delayed.
goto basic tab of NPC
Conversation - bm_scr_conv
Set the NPC to plot.
Create a waypoint someplace and name it BM_SCROLLCREATION. Put it someplace
where PC's can't get to.  This is where scrolls are initially created before
they are given to the PC.  You must do this regardless of if you are using the
scroll creation delay.

To use the potion system edit the bm_po_inc to set the POTIONWAITTIME to
the number of hours per 1000gp of the potion you want to delay the creation
of the potion.
Then to setup a potion creation lab, simply drop the potion lab item from the
custom containers into a location.  To create a potion you must have an empty
bottle and place it in the lab.  Then cast the spell that you want to create
a potion of on the lab.  All the bioware delivered potions except bless are
in this release.  It will charge you xp and gold based on the caster level of
the spell of the potion, not your caster level.


That's it.  Talking to the NPC will give you the options to create the scroll.
Just follow the directions.
Version 2.0
Added Potions

Version 1.0.4 -- 7/15/2002
Fixed Endure Elements, Shadow Conjuration and Greater Shadow Conjuration

Version 1.0.3 -- 7/13/2002
Added Scroll Delay
Updated Scrollmaker Elf on_heartbeat script


Version 1.0.2
Added Levels 6 through 9
Added custom scrolls Create Undead, Legend Lore and Shadow Shield
Changed Spell names to be case insensitive.


Version 1.0.1
Added Levels 3 through 5
Added about_scroll
Added four custom scrolls
    Energy Buffer, Evard's Black Tentacles, Find Traps, and Ice Storm

Version 1.0.0
Wizard Spell Level 0 through 2 implemented.
Scroll Creation System implemented as conversation on NPC.

ToDo:

Convert from NPC conversation to Item players can use.
Implement Cleric spells
Fix Bless Potion



Contact:
For suggestion, bug reports, or other contact
pothole@quad.net

Final Notes:
This system is largely untested.  If you discover a mispelling in spell
names or spells creating the wrong scroll or spells missing from the system
don't hesitant to email me.


*/

void main()
{

}
