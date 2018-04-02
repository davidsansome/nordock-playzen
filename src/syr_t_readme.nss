/////////////////////////////////////////////////////////////////
/////
/////
/*

The Modified Treasure Generation Scripts:

The goal of these scripts is to create a treasure generation system closer to
that of the DMG.

By default there are six different scripts that can be found on a chest, but
three of these are redundant copies.
nw_o2_classlow and nw_o2_generallow are identical and produce 'poor' treasures.
nw_o2_classmed, and nw_o2_generalmed are identical and produce 'average' treasures.
nw_o2_classhig and nw_o2_generalhig are identical and produce 'rich' treasures

This script package will overwrite these scripts automatically.
The old nw_o2_classhig script is also reimported as sy_i_classhig.  The purpose of this is to
allow you to create (if desired) a bountious (special purpose) treasure with tailored to
the class of the player who opens the chest.

In these scripts, in keeping with the DMG system, magic items are randomly generated
according to a CR value but without regard for the players class (making it dependant
on the class of the chest opener is a bad idea in multiplayer anyways - it tends to
make the loot disproportionatly favor the rogue or whomever is the fastest
on the clicker).

However, the quantity of gold and the frequency of gems is reduced from the 3rd edition
levels to reflect the fact that most PCs will kill far more creatures over the span of a
level, thus allowing them to accumulate excessive loot in that time.  This value of this
variable is what distinguishes the three nw_o2_generalxxx scripts from each other.

At present this CR value is based on the level of the character who opens the chest.

A better system (for non-scaled encounters) would be to create a series of chests for each CR
and set the value of the CR in the relevant OnOpen script (i.e. nw_o2_generalmed).

These tables also reference a collection of new items, which are in Syr_Treasure002.erf.  These
items include scrolls for all divine spells, a bunch of rings, wands and potions and
a collection of items left off of the BioWare tables.

Carl
















 */

void main()
{

}
