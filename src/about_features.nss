/*
FEATURES of Hardcore Ruleset
27 June 2002

The Hardcore ruleset is a set of rules, most optional to use, that restores
the game truer to normal DND.  It is released with all features enabled, and
recommended to be run on a Server Vault system with setting at DND Hardcore
(thats one to the right on your slider when DM).  The ruleset features the
following:

* Normal DND bleeding and death system.  When a player reaches 0 hp, he is
  disabled.  When he is -1 to -9, he is dying and slowly bleeds to death at
  the rate of 1 hp per round with a 10% chance to stabilize each round.  At
  -10 he is dead, and must either be resurrected or can use the respawn
  button to pray to his Deity (IF he chose one).  A special death amulet
  prevents him from quitting and returning to get around this death if the
  server is a Server Vault.

* Death Corpse - When a player is dying, all of his unequipped gear appears
  on a corpse.  When the player is dead, all of his equipped gear joins it.
  This corpse may be looted by anyone. Once looted of all items, the corpse
  vanishes.

* Drag Corpses - On a players death corpse, you will find a Player Corpse.
  If you take it to a cleric and activate the corpse with the cleric as the
  target, the cleric will raise dead the player if you have the proper funds.
  50 * level of cleric, (min 500 since level 10 needed to cast level 5 raise
  dead spell) per DMG pg 149.

* Dying/Disabled Healing - Players now heal IAW PHB pg 129.

* Resting restrictions - A player my only rest every 8 hours (configurable).
  That is every 16 minutes in a game that still has 2 min per hour default.
  This prevents spam casting, where a caster dumps all spells, rests for
  30 seconds, and then rinses and repeats.

* Message of the Day (sorta) - All players are show a message upon login.

And of course the DM Helper

DM Helper (Lead Doppleganger)
Current Features of DM's Helper:

If cast on a player
- Display attributes (stats, equipped items, player name, etc)
- Change alignment (Law, Chaos, Good, Evil) by one or five points
- Give the player a full map of the area
- Take items - all equipped, all unequipped, all items, or an item equipped into a specific slot
- Boot the PC out of the game

If cast on a creature
- Display attributes (stats, equipped items, player name, etc)
- Change alignment (Law, Chaos, Good, Evil) by one or five points
- Take items - all equipped, all unequipped, all items, or an item equipped into a specific slot
- Kill creature, leaving a corpse

If cast on a creature or selectable object
- Destroy this object

If cast on a door
- lock or unlock the door

If cast without a target
- Change the weather of the area (rain, snow, clear, or original map setting)
- Reload the current running module (use with caution, may cause server to become unstable on large maps)
- Advance the current time of day by one, three, or five hours
- Destroy an object that is close by (includes untargettable objects)
*/
void main (){}
