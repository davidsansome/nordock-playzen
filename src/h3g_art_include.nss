//::///////////////////////////////////////////////
//:: Artifact Item Include File
//:: h3g_art_include
//:://////////////////////////////////////////////
/*
    Allows for unique items that are only spawned
    once that can be added inrealtime without a
    module rebuild.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
string sCampaignName = "artifacts"; //Database name
float fArtifactDuration = 15.0f; //Currently just workouts how long the colum of light should stay around



//::///////////////////////////////////////////////
//:: Set the max artifact postion
//:://////////////////////////////////////////////
/*
    Sets the max artifaact. Used to know the last
    artifact avilable.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
void SetMaxArtifact(int nMaxArtifact)
{
    SetCampaignInt(sCampaignName, "nMaxArtifact", nMaxArtifact);
}



//::///////////////////////////////////////////////
//:: Get the max artifact
//:://////////////////////////////////////////////
/*
    Gets the max artifact. Used to know the last
    artifact avilable.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
int GetMaxArtifact()
{
    return GetCampaignInt(sCampaignName, "nMaxArtifact");
}



//::///////////////////////////////////////////////
//:: Increase Max Artifact
//:://////////////////////////////////////////////
/*
    Increases the max Artifact by 1
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////

void IncreaseMaxArtifact()
{
    SetMaxArtifact(GetMaxArtifact() + 1);
}



//::///////////////////////////////////////////////
//:: Decrease Max Artifact
//:://////////////////////////////////////////////
/*
    Amazingly decreases the Max Artifact by 1
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
void DecreaseMaxArtifact()
{
    SetMaxArtifact(GetMaxArtifact() - 1);
}



//::///////////////////////////////////////////////
//:: Store Artifact
//:://////////////////////////////////////////////
/*
    Stores oItem in nArtifact postion. Low level
    doesn't do stuff like update the max artifact.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void StoreArtifact(object oItem, int nArtifact)
{
    StoreCampaignObject(sCampaignName, "ART_" + IntToString(nArtifact), oItem);
}



//::///////////////////////////////////////////////
//:: Add Artifact
//:://////////////////////////////////////////////
/*
    Adds an artifact to the artifact DB.
    Automaticly finds the last position and updates
    the max artifact.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
void AddArtifact(object oItem)
{
    StoreArtifact(oItem, GetMaxArtifact()+1);
    IncreaseMaxArtifact();
}



//::///////////////////////////////////////////////
//:: Get Artifact Chest
//:://////////////////////////////////////////////
/*
    Finds the chest that is used for temp artifact
    creation and DM use.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
object GetArtifactChest()
{
    return GetObjectByTag("ARTIFACT_CHEST");
}



//::///////////////////////////////////////////////
//:: Copy Artifact
//:://////////////////////////////////////////////
/*
    Gets nArtifact from the artifact DB, doesn't
    change anything or do any special stuff.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
object CopyArtifact(int nArtifact, object oOwner)
{
    return RetrieveCampaignObject(sCampaignName, ("ART_" + IntToString(nArtifact)), GetLocation(oOwner), oOwner);
}



//::///////////////////////////////////////////////
//:: Move The Last Artifact To The Slot Of The Replaced One To Avoid Anoying Gaps W00t
//:://////////////////////////////////////////////
/*
    eh?
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
void MoveTheLastArtifactToTheSlotOfTheReplacedOneToAvoidAnoyingGapsW00t(int nArtifact)
{
    object oChest = GetArtifactChest();
    object oTemp = CopyArtifact(GetMaxArtifact(), oChest);
    StoreCampaignObject(sCampaignName, "ART_" + IntToString(nArtifact), oTemp);
    DestroyObject(oTemp);
    DecreaseMaxArtifact();
}



//::///////////////////////////////////////////////
//:: Get Artifact
//:://////////////////////////////////////////////
/*
    Creates nArtifact onto oOwner from the DB.
    Shifts the DB around and updates max artifact.
    If no artifacts are left a coupon will be made.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
object GetArtifact(int nArtifact, object oOwner)
{
    object oArtifact;
    if(nArtifact<1)
    {
        oArtifact = CreateItemOnObject("coupon_art", oOwner); //No artifacts? Give a coupon
        SendMessageToAllDMs("OUT OF ARTIFACTS!!!! Some poor person just got a coupon =(");
    }
    else
    {
        oArtifact = CopyArtifact(nArtifact, oOwner);
        MoveTheLastArtifactToTheSlotOfTheReplacedOneToAvoidAnoyingGapsW00t(nArtifact);
    }
    SetPlotFlag(oArtifact, TRUE);
    SetIdentified(oArtifact, TRUE);
    return oArtifact;
}


//::///////////////////////////////////////////////
//:: Pick Random Artifact
//:://////////////////////////////////////////////
/*
    Returns a random int based on the number of
    artifacts. Return -1 when there are no
    artifacts left to spawn.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
int PickRandomArtifact()
{
    int nMaxArtifact = GetMaxArtifact();
    if(nMaxArtifact < 1)
        return -1;
    return Random(nMaxArtifact)+1;
}


//::///////////////////////////////////////////////
//:: Artifact Magic
//:://////////////////////////////////////////////
/*
    This is the flashy stuff that happens when an
    artifact appears in the world. It includes
    announcing to the entire server that an
    artifact has appeared, creating a colum of
    light and making the artifact glow blue.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 20/02/04
//:://////////////////////////////////////////////
void ArtifactMagic(object oArtifact) //Tell everyone that an artifact has been created and makes a collum of light appear near it
{
    object oOwner = GetItemPossessor(oArtifact);
    AssignCommand(GetModule(), SpeakString("You sense that an artifact has entered the world...", TALKVOLUME_SHOUT));
    object oLight = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_solblue", GetLocation(oOwner), TRUE);
    AssignCommand(oLight, DelayCommand(fArtifactDuration, DestroyObject(oLight)));
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), oArtifact, 0.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), oOwner, fArtifactDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SOUND_BURST), oOwner, 30.0f);
}



//::///////////////////////////////////////////////
//:: List Artifacts
//:://////////////////////////////////////////////
/*
    Sends the DMs a list of all artifacts
    currently unspawned, The total number left
    and the max used slot.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 21/02/04
//:://////////////////////////////////////////////
void ListArtifacts()
{
    object oChest = GetArtifactChest();
    int nMaxArtifacts = GetMaxArtifact();
    int nTotal = 0;
    int nCounter;
    string sArtifactList;
    for(nCounter = 0; nCounter <= nMaxArtifacts; nCounter++)
    {
        object oTemp = CopyArtifact(nCounter, oChest);
        sArtifactList = sArtifactList + "ART #" + IntToString(nCounter) + ": " + GetName(oTemp) + ", ";
        DestroyObject(oTemp);
        nTotal++;

    }

    SendMessageToAllDMs(sArtifactList + "TOTAL: " + IntToString(nMaxArtifacts));
}



//::///////////////////////////////////////////////
//:: Summon Artifact
//:://////////////////////////////////////////////
/*
    The main artifact function, pick a random
    artifact, summons it and makes effects.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 24/02/04
//:://////////////////////////////////////////////
object SummonArtifact(object oOwner)
{
    int nArtifact = PickRandomArtifact();
    object oArtifact = GetArtifact(nArtifact, oOwner);
    ArtifactMagic(oArtifact);
    SendMessageToAllDMs(
          "An artifact ("
        + GetName(oArtifact)
        + ") was spawned on "
        + GetName(oOwner)
        + " in "
        + GetName(GetArea(oOwner))
        + ". 3 nearest PCs are "
        + GetName(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oOwner, 1))
        + ", "
        + GetName(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oOwner, 2))
        + ", "
        + GetName(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oOwner, 3))
    );
    return oArtifact;
}



//::///////////////////////////////////////////////
//:: Add all chest items to artifact DB
//:://////////////////////////////////////////////
/*
    Adds all the items in the chest to the
    artifact database. This will destroy the
    origionals for ease of use.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 21/02/04
//:://////////////////////////////////////////////
void AddChestItems2Artifacts()
{
    object oChest = GetArtifactChest();
    object oTemp = GetFirstItemInInventory(oChest);
    while(oTemp!=OBJECT_INVALID)
    {
        AddArtifact(oTemp);
        DestroyObject(oTemp);
        oTemp = GetNextItemInInventory(oChest);
    }
    SendMessageToAllDMs("All items in chest added to artifact database.");
}



//::///////////////////////////////////////////////
//:: Overide Artifact Database with items in chest
//:://////////////////////////////////////////////
/*
    Overides the artifact database with the
    objects in the chest. This will destroy
    anything in the artifact DB. Designed to be
    used with copyart2chest then a dm can remove
    specifc items and then the database can be
    overridden with the changes.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 21/02/04
//:://////////////////////////////////////////////
void ReplaceArtifactsWithChestItems()
{
    object oChest = GetArtifactChest();
    object oTemp = GetFirstItemInInventory(oChest);

    SetMaxArtifact(0);
    while(oTemp!=OBJECT_INVALID)
    {
        AddArtifact(oTemp);
        DestroyObject(oTemp);
        oTemp = GetNextItemInInventory(oChest);
    }
    SendMessageToAllDMs("Artifact Database overridden with chest items.");
}



//::///////////////////////////////////////////////
//:: Copy art database to chest
//:://////////////////////////////////////////////
/*
    Copies the art database to the chest without
    marking the items in the database as spawned
    usefull to modify stuff in the chest without
    the risk of a crash killing the entire DB. Or
    to examine an item in detail.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 21/02/04
//:://////////////////////////////////////////////
void CopyArtifacts2Chest()
{
    object oChest = GetArtifactChest();
    int nArtifactMax = GetMaxArtifact();
    int nCounter;
    for(nCounter = 0; nCounter <= nArtifactMax; nCounter++)
    {
        CopyArtifact(nCounter, oChest);
    }
    SendMessageToAllDMs("Finshed copying items to chest.");
}



//::///////////////////////////////////////////////
//:: Move Artifact Database to Chest
//:://////////////////////////////////////////////
/*
    ***YOU SHOULD NEVER NEED TO USE THIS***
    This will move the entire artifact DB to the
    chest. This should never be used beacause
    the server could crash leaving the DB empty
    and loosing the items in the chest. Instead
    use the copyart2chest then when finshed
    modifing the contence ochest2art to overide
    the artifact DB with the chest contence.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 21/02/04
//:://////////////////////////////////////////////
void MoveArtifacts2Chest()
{
    object oChest = GetArtifactChest();
    int nArtifactMax = GetMaxArtifact();
    int nCounter;
    for(nCounter = 1; nCounter <= nArtifactMax; nCounter++)
    {
            GetArtifact(nCounter, oChest);
    }
    SendMessageToAllDMs("Finshed copying items to chest.");
}



//::///////////////////////////////////////////////
//:: Artifact Chest clearing script
//:://////////////////////////////////////////////
/*
    This destroys all the items in the chest.
    Usefull if you have copied the entire DB to
    the chest to look at an item and want the
    chest clean.
*/
//:://////////////////////////////////////////////
//:: Created By: H3g3m0n
//:: Created On: 21/02/04
//:://////////////////////////////////////////////
void CleanArtifactChest()
{
    object oChest = GetArtifactChest();
    object oTemp = GetFirstItemInInventory(oChest);
    while(GetIsObjectValid(oTemp))
    {
        DestroyObject(oTemp);
        oTemp = GetNextItemInInventory(oChest);
    }
    SendMessageToAllDMs("Finshed cleaning chest.");
}
