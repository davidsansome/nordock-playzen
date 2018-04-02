// rr_drunk_inc
// functions to check on player's drunken state - runs on heartbeat

// to use in your module, add #include "rr_drunk_inc" in your module's
// OnHeartbeat script. Then add a loop to check each player, such as:

//    object oPlayer = GetFirstPC();
//    while(GetIsObjectValid(oPlayer))
//    {
//      DrunkCheck(oPlayer);
//      oPlayer=GetNextPC();
//    }

int IsBooze(object oDrink)
{
    if (GetTag(oDrink)=="bainl")
       return TRUE;
    else
    if (GetTag(oDrink)=="NW_IT_MPOTION021")
       return TRUE;
    else
    if (GetTag(oDrink)=="NW_IT_MPOTION022")
       return TRUE;
    else
    if (GetTag(oDrink)=="SkullAlemain")
       return TRUE;
    else
    if (GetTag(oDrink)=="NW_IT_MPOTION023")
       return TRUE;
    else
    if (GetTag(oDrink)=="house_ale")
       return TRUE;
    else
        return FALSE;
}

void IncreaseBAC(object oPC)
{
    int nBAC=GetLocalInt(GetModule(),"BAC"+GetName(oPC)+GetPCPublicCDKey(oPC));
    nBAC=nBAC+1;
    SetLocalInt(GetModule(),"BAC"+GetName(oPC)+GetPCPublicCDKey(oPC),nBAC);
}

void DecreaseBAC(object oPC)
{
    int nBAC=GetLocalInt(GetModule(),"BAC"+GetName(oPC)+GetPCPublicCDKey(oPC));
    nBAC=nBAC-1;
    SetLocalInt(GetModule(),"BAC"+GetName(oPC)+GetPCPublicCDKey(oPC),nBAC);
}

// function to do a skill check against a level 15 task
// uses PC con modified by BAC
int DrunkSave(object oPC, int nBAC)
{
    int nConMod =GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    if ((d20() + nConMod - nBAC) > 14)
        {
            return TRUE;
        }
    else
        {
            return FALSE;
        }
}

// pardon my French...function to randomly say something dumb

string SayGoofyShit(object oPC)
{
// first, find the closest living thing to torment
    object oPoorSlob = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oPC);
//    if ((oPoorSlob = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oPC)) != OBJECT_TYPE_INVALID)
//    {
        string sSlobName = GetName(oPoorSlob);
//    }
//    else
//    {
//        string sSlobName = GetName (oPC);
//        oPoorSlob = oPC;
//    }
//Changed to d20 from d12 to allow more phrases
    switch (d20())
    {
        case 1: return "Wassup?";
                break;
        case 2: return "How dry I am...";
                break;
        case 3: return sSlobName + ", have I ever told you how cute you are?";
                break;
        case 4: return "Are there no toilets anywhere in all the land?";
                break;
        case 5: return "More booze!";
                break;
        case 6: return "Let the good times roll!";
                break;
        case 7: return "I need some orc lovin!";
                break;
        case 8: return "Dragons, schmagons! Where's my blade?";
                break;
        case 9: return "HDgd dgdd asdahsd?";
                break;
        case 10: return "yada yada yada...";
                break;
        case 11: return "*burp*";
                break;
//Added in another 8 drunken phrases - Grug 04/10/2003
        case 12: return sSlobName + ", is that a food ration in your pocket - or are you just happy to see me *wink*";
                break;
        case 13: return "Yarrrr!";
                break;
        case 14: return "*hic*";
                break;
        case 15: return "What are you? Some bottom-feeding, scum sucking, algae eater?";
                break;
        case 16: return "I can see through time...";
                break;
        case 17: return "Ahhh.. that hit the spot";
                break;
        case 18: return "*burp*";
                break;
        case 19: return "More booze!";
                break;
     }
     return "Yep, me love some good booze!";
}

void DrunkCheck(object oPC)
{
    int nBAC=GetLocalInt(oMod,"BAC"+GetName(oPC)+GetPCPublicCDKey(oPC));
    if (nBAC>0)
    {
        switch (nBAC)
        {
            case 1:
                if (!(DrunkSave(oPC, nBAC)))
                    {
//                        effect eDrunk = EffectStunned();
//                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrunk, oPC, 2.0);
                        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
                        FloatingTextStringOnCreature("*HIC*",oPC,FALSE);
                        AssignCommand(oPC, ActionSpeakString(SayGoofyShit(oPC),TALKVOLUME_TALK));
                    }
                break;
            case 2:
                 if (!(DrunkSave(oPC, nBAC)))
                    {
                        effect eDrunk = EffectStunned();
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrunk, oPC, 5.0);
                    }
                break;
            case 3:
                  if (!(DrunkSave(oPC, nBAC)))
                    {
                        SetCameraMode(oPC,CAMERA_MODE_CHASE_CAMERA);
                        SetCameraFacing(IntToFloat(Random(360)));
                        effect eDrunk = EffectStunned();
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrunk, oPC, 5.0);
                    }
                break;
            case 4:
                 if (!(DrunkSave(oPC, nBAC)))
                    {
                        SetCameraMode(oPC,CAMERA_MODE_CHASE_CAMERA);
                        SetCameraFacing(IntToFloat(Random(360)));
                        effect eDrunk = EffectKnockdown();
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrunk, oPC, 6.0);
                    }
                break;
            default:
                 if (!(DrunkSave(oPC, nBAC)))
                    {
                        SetCameraMode(oPC,CAMERA_MODE_CHASE_CAMERA);
                        SetCameraFacing(IntToFloat(Random(360)));
                        effect eDrunk = EffectKnockdown();
                        effect eBlind = EffectBlindness();
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrunk, oPC, 6.0);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 6.0);
                    }
                break;
         }

    if (d20()>18)
        {
            DecreaseBAC(oPC);
            SendMessageToPC(oPC,"You feel less drunk");
        }
    }
}




