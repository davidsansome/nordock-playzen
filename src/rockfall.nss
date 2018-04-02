void main() //rockfall by treehugger
//==================================
// modified by Q'el 24-June-2003
// added reflex save logic
// changes indicated by ---Qel-1
//==================================
{
//put this on a trigger to do rockfall damage w/ rocks flying everywhere..
//note that falling rocks effect seems to generate visually at a distance
//when PC is distant from them--not a continuous generation,
//just the basic destroy effect. the PC usually has to be at certain angles to see it.
object oPC = GetEnteringObject();  //trigger, works wells placed before cave entrance.

/*---Qel-1 these lines are doing nothing, comment them out
object oWay = GetObjectByTag("WP_ROCKFALL1"); //waypoints at sides of cave entrance, leaving some walkway, play w/ positioning
object oWay2 = GetObjectByTag("WP_ROCKFALL2");//till you get the effect you like
object oWay3 = GetObjectByTag("WP_ROCKFALL3");//waypoint also on ramp area above cave entrance, helps w/ "rockslide" effect
location lWay = GetLocation(oWay);
location lWay2 = GetLocation(oWay2);
location lWay3 = GetLocation(oWay3);
*/

//---Qel-1  set DC & damage taking into account reflex save and evasion
int nDC = 25;               // reflex save DC to avoid some damage
int nDamage = d10(2)+2;     // damage for the rockfall

nDamage = GetReflexAdjustedDamage(nDamage, oPC, nDC);
//---end

effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);

   ActionDoCommand(PlaySound("as_na_rockfalsm4")); //or go thru the sounds
   ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC));

   if (nDamage > 0)  //---Qel-1 only apply damage effects if there is actual damage
   {
       DelayCommand(1.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, eDam, oPC));
       SendMessageToPC(oPC, "You get hit by falling rock.");
   }
   else             //---Qel-1 no damage, tell PC they were lucky this time
   {
       SendMessageToPC(oPC, "You narrowly avoid falling rocks.");
   }

}
//now i think if you strategically placed a lot of waypoints at ground level & ramps,
//a decent avalanche effect could be generated...planning stages here ;)
//i also set this this type of trigger into a climbing script, makes the ledge more interesting
//but spawning only one rock. here it deals a little extra damage as the PC climbs.

