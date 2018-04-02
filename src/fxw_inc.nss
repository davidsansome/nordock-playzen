//////////////////////////////////
/// Script: fxw_inc
/// Purpose: include file for a Wand of FX
/// Authors: Jhenne (tallonzek@hotmail.com)
///          Dopple (dopple@why-bother-me.com)
//////////////////////////////////
// function for OnActivateItem

object oDM = GetLastSpeaker();
object oMyTarget = GetLocalObject(oDM, "FXWandTarget");
location lTargetLoc = GetLocalLocation(oDM, "FXWandLoc");
int nRandom;
float fRandom;

void FXWand_Firestorm()
{

   // FireStorm Effect

   location lDMLoc = GetLocation ( oDM);

   // tell the DM object to rain fire and destruction
   AssignCommand ( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_METEOR_SWARM), lTargetLoc));
   AssignCommand ( oDM, DelayCommand (1.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_FNF_SCREEN_SHAKE), lTargetLoc)));

   // create some fires
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
  {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lFireLoc = Location(oTargetArea, vNewVector, 0.0);
      object oFire = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lFireLoc, FALSE);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lFireLoc, FALSE);
      DelayCommand ( 10.0, DestroyObject ( oFire));
      DelayCommand ( 14.0, DestroyObject ( oDust));
   }

}

void FXWand_Earthquake()
{
   // Earthquake Effect by Jhenne, 06/29/02
   // declare variables used for targetting and commands.
   location lDMLoc = GetLocation ( oDM);

   // tell the DM object to shake the screen
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lTargetLoc));
   AssignCommand ( oDM, DelayCommand( 2.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 3.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_SHAKE), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 4.5, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 5.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   // tell the DM object to play an earthquake sound
   AssignCommand ( oDM, PlaySound ("as_cv_boomdist1"));
   AssignCommand ( oDM, DelayCommand ( 2.0, PlaySound ("as_wt_thunderds3")));
   AssignCommand ( oDM, DelayCommand ( 4.0, PlaySound ("as_cv_boomdist1")));
   // create a dust plume at the DM and clicking location
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
   {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lDustLoc = Location(oTargetArea, vNewVector, 0.0);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lDustLoc, FALSE);
      DelayCommand ( 4.0, DestroyObject ( oDust));
   }
}

void FXWand_EarthquakeDamage()
{
   // Earthquake Effect by Jhenne, 06/29/02
   // declare variables used for targetting and commands.
   location lDMLoc = GetLocation ( oDM);

   // tell the DM object to shake the screen
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lTargetLoc));
   AssignCommand ( oDM, DelayCommand( 2.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 3.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_SHAKE), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 4.5, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 5.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   // tell the DM object to play an earthquake sound
   AssignCommand ( oDM, PlaySound ("as_cv_boomdist1"));
   AssignCommand ( oDM, DelayCommand ( 2.0, PlaySound ("as_wt_thunderds3")));
   AssignCommand ( oDM, DelayCommand ( 4.0, PlaySound ("as_cv_boomdist1")));
   object oTargetArea = GetArea(oDM);

   object oKnockdownTarget = GetFirstObjectInShape(SHAPE_CUBE, 15.0, lDMLoc, OBJECT_TYPE_CREATURE);
   while(GetIsObjectValid(oKnockdownTarget))
   {
      if (GetIsDM(oKnockdownTarget) == FALSE)
      {
         if (GetSkillRank ( SKILL_DISCIPLINE, oKnockdownTarget) <= 9)
         {
            nRandom=d6();
            fRandom=IntToFloat(nRandom);
            DelayCommand(fRandom, AssignCommand ( oKnockdownTarget, ApplyEffectToObject (DURATION_TYPE_TEMPORARY, EffectKnockdown(), oKnockdownTarget, 6.0)));
            DelayCommand(fRandom, AssignCommand ( oKnockdownTarget, ApplyEffectToObject (DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oKnockdownTarget)));
         }
      }
      oKnockdownTarget = GetNextObjectInShape(SHAPE_CUBE, 15.0, lDMLoc, OBJECT_TYPE_CREATURE);
   }

   //Create dust plumes in random locations around the DM
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
   {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lDustLoc = Location(oTargetArea, vNewVector, 0.0);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lDustLoc, FALSE);
      DelayCommand ( 4.0, DestroyObject ( oDust));
   }
}

void FXWand_AppearEvil()
{
  location lTarget = GetLocation( oDM);

  AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lTarget));
}

void FXWand_AppearGood()
{
  location lTarget = GetLocation( oDM);

  AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL), lTarget));
}

void FXWand_SummonEvil()
{
  location lTarget = GetLocation( oDM);

  AssignCommand( oDM, DelayCommand( 5.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lTargetLoc)));
}


void FXWand_SummonGood()
{
  location lTarget = GetLocation( oDM);

  AssignCommand( oDM, DelayCommand( 5.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL), lTargetLoc)));
}

void FXWand_DelayedSummon()
{

  AssignCommand ( oDM, DelayCommand ( 5.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SUMMON_MONSTER_3), lTargetLoc )));
}

void FXWand_WolfHowl()
{
// Wolves Howling by Jhenne, 06/29/02

   // get a random number and tell the DM object to play the matching sound.
   switch (Random(4))
   {
      case 0: AssignCommand ( oDM, PlaySound("as_an_wolfhowl1"));
              break;
      case 1: AssignCommand ( oDM, PlaySound("as_an_wolfhowl2"));
              break;
      case 2: AssignCommand ( oDM, PlaySound("as_an_wolveshwl1"));
              break;
      case 3: AssignCommand ( oDM, PlaySound("as_an_wolveshow2"));
              break;
   }
}

void FXWand_Lightning()
{
   // Lightning Strike by Jhenne. 06/29/02

   // tell the DM object to create a Lightning visual effect at targetted location
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lTargetLoc));
   // tell the DM object to play a thunderclap
   AssignCommand ( oDM, PlaySound ("as_wt_thundercl3"));
   // create a scorch mark where the lightning hit
   object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lTargetLoc, FALSE);
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 5; nCount++)
   {
      nXPos = Random(10) - 5;
      nYPos = Random(10) - 5;

      vector vNewVector = GetPositionFromLocation(lTargetLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
      AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
   }
   DelayCommand ( 20.0, DestroyObject ( oScorch));
}

void FXWand_WomanScream()
{
   // Woman's Scream by Jhenne, 06/29/02

   // get a random number and tell the DM object to play the matching sound.
   switch (Random(7))
   {
      case 0: AssignCommand ( oDM, PlaySound("as_pl_screamf1"));
              break;
      case 1: AssignCommand ( oDM, PlaySound("as_pl_screamf2"));
              break;
      case 2: AssignCommand ( oDM, PlaySound("as_pl_screamf3"));
              break;
      case 3: AssignCommand ( oDM, PlaySound("as_pl_screamf4"));
              break;
      case 4: AssignCommand ( oDM, PlaySound("as_pl_screamf5"));
              break;
      case 5: AssignCommand ( oDM, PlaySound("as_pl_screamf6"));
              break;
      case 6: AssignCommand (oDM, PlaySound("as_pl_skriekf2"));
   }
}
