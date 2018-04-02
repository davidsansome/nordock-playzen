/*Warning - this version of the DM's Helper is compatible with the HardCore Mod v.1.3.4 or higher.
**If you have an older version of the HardCore Mod installed, please consider obtaining a newer
** version!

Current Features of DM's Helper:

If cast on a player
- Display attributes (stats, equipped items, player name, etc)
- Change alignment (Law, Chaos, Good, Evil) by one or five points
- Give the player a full map of the area
- Follow the player
- Force the player to follow you (for a short period of time)
- Take items - all equipped, all unequipped, all items, or an item equipped into a specific slot
- Penguin the player - paralyze the player, and turn him into a penguin
- Unpenguin the player
- Boot the PC out of the game
- Roll a skill or ability check
- Join the PC's party
- Leave the party

If cast on a creature
- Display attributes (stats, equipped items, player name, etc)
- Change alignment (Law, Chaos, Good, Evil) by one or five points
- Follow the creature
- Force the creature to follow you (for a short period of time) (it will resume walking
  waypoints, if any, once it stops following)
- Tell the creature to run the "nw_c2_default9" script (resumes waypoint walking)
- Take items - all equipped, all unequipped, all items, or an item equipped into a specific slot
- Kill creature, leaving a corpse
- Roll a skill or ability check

If cast on a creature or selectable object
- Kill object, leaving any loot it would normally leave
- Destroy this object
- Turn this object on or off (for placeables that can turn on and off)

If cast on a door
- lock or unlock the door

If cast without a target
- Change the weather of the area (rain, snow, clear, or original map setting)
- Reload the current running module (use with caution, may cause server to become unstable on large maps)
- Advance the current time of day by one, three, or five hours
- Advance to the next day or night period
- Destroy an object that is close by (includes untargettable objects)
- Turn an object that is close by on or off (for placeables that can turn on and off)
  (Warning: some objects may not show the change until the observer has exited the area and re-entered.
  This is probably related to a similiar problem with destroying static objects)
- if the Hardcore Rules mod is installed, report on what systems are enabled

---------------------------
Change log:

1.2.8
- Changed include file from "jth_dmwand" to "dmw_inc" for consistency
- Moved onactivate code out of dmw_inc... including dmw_inc in onactivate unnecesarily
  bloated the script.
- Added skill and ability rolls
- Added function to make npc resume waypoints (useful after posession)
- Added impressive lightning special effect to BootPC function, including temporary
  scorch mark :)
- Added ability to turn both selectable and unselectable objects on and off
- Added ability to join and leave player parties at will
- Added a dummy hc_inc, and the ability to report on Hardcore Rules systems if the
  Hardcore Rules mod is installed

*/
void main(){}
