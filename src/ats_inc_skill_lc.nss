/****************************************************
  Include Script: Tanning(Leathercrafting)
                  related functions
  ats_inc_skill_lc

  Last Updated: July 26, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains all functions related to
  leathercrafting.   The skinnable corpses function
  is a heavily modified version of Keron Blackfeld's
  Lootable Creature Corpses script.

  Special thanks to Keron!
****************************************************/



void ATS_CreateSkinnableCorpse(object oDeadAnimal, int iCorpseFade)
{
        string   sBaseTag = GetTag(oDeadAnimal); //Get that TAG of the dead creature
        string   sPrefix = GetStringLeft(sBaseTag, 4); //Look for Dead Prefix
        location lCorpseLoc = GetLocation(oDeadAnimal); //Set the spawnpoint for our lootable object
        string   sInfoTag = GetStringRight(sBaseTag, 9);  // Get the info tag to determine
                                                          // pelt type and amount

        //Do 'spawned corpse' if desired
        if (sPrefix == "Dead")
        {
            iCorpseFade = 0; //Disable Corpse Fade for 'Spawned Dead' corpses
        }

        SetIsDestroyable(FALSE,TRUE,FALSE); //Protect our corpse from decaying

        /* Needed to make compatible with HCR or Lootable Corpses mod  */
        ClearAllActions();
        //Effectively Cancels HCR's delay command
        //DelayCommand(30.0,SetIsDestroyable(FALSE, FALSE, TRUE));
        object oOldLootCorpse = GetNearestObjectByTag("invis_corpse_obj", oDeadAnimal);
        if(GetIsObjectValid(oOldLootCorpse) == TRUE && GetLocation(oOldLootCorpse) == lCorpseLoc)
            DestroyObject(oOldLootCorpse);
        object oBloodStain = GetNearestObjectByTag("plc_bloodstain", oDeadAnimal);
        if(GetIsObjectValid(oOldLootCorpse) == TRUE && GetLocation(oBloodStain) == lCorpseLoc)
            DestroyObject(oBloodStain);


        object oLootCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "ats_invis_corpse", lCorpseLoc, FALSE); //Spawn our lootable object
        SetLocalObject(oLootCorpse, "ats_oHostBody", oDeadAnimal); //Set Local for deletion later if needed
        SetLocalObject(oDeadAnimal, "ats_oLootCorse", oLootCorpse); //Set Local for deletion later if needed

        //Get pelt type and amount
        string sPeltType = GetStringLeft(sInfoTag, 4);
        string sValues = GetStringRight(sInfoTag, 4);
        int iPeltAmount = StringToInt(GetStringLeft(sValues, 2));
        int iMeatAmount = StringToInt(GetStringRight(sValues, 2));

        SetLocalString(oLootCorpse, "ats_sPeltType", sPeltType);
        SetLocalInt(oLootCorpse, "ats_iPeltAmount", iPeltAmount);
        SetLocalInt(oLootCorpse, "ats_iMeatAmount", iMeatAmount);

        //Do Corpse Fade out after specified delay (unless flagged 0)
        if (iCorpseFade > 0)
        {
            float fCorpseFade = IntToFloat(iCorpseFade);
            ActionWait(fCorpseFade);
            SetLocalInt(oDeadAnimal, "ats_self_destruct", TRUE);
            // Signal user defined event to destroy corpse
            DelayCommand(fCorpseFade, SignalEvent(oDeadAnimal, EventUserDefined(500)));
        }
}
