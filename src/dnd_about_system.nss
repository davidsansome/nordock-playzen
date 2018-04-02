// Persisten World Extended Exp System
// Coded By: Archaegeo
// Sept 3rd, 2002

/*

This system is based off of the First Edition DND Exp system i released a few
days ago.  In this system, there is one experience chart.  It goes from 0 to
3,750,000xp for level 20.  (As compared with 190,000xp for level 20 under the
default NWN system).

What do you gain from this system?

One - You get to give players real experience numbers vice 3-4xp at a time to
control your levelling rate.  Plus since the chart is more spread out, players
will be able to get through level 1-3 kinda quick, and then it naturally slows.
This gives your persistent world the quick levelling needed early, and then the
longevity it needs later.

Two - There is a multiple defined for each class, default to 1.0, that is
multiplied times the exp awarded to a PC.  So, you can set your classes to level
at different rates, thus simulating that it is harder in your world for mages to
level than it is for fighters, etc.  If someone is multiclassed, an average is
taken of their levelling rates.

Three - It is inheritently persistent.  It uses the actual xp of the player as
a tracking system, ratioing that to the new chart. So the character still levels
by the game at the same spots, but all exp adds go through the new system.

To Use Default:
Set your XP Slider (under Module Properties) to 0.
Replace the nw_c0_default7 with the one in the ERF set.
Make sure that any other exp award devices/scripts you have use DND_add_exp to
make the award.

If you have existing characters, they will automagically convert over to the
new system the first time they get awarded any experience by DND_add_exp.

*/

void main()
{
}
