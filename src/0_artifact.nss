// Artifact system using SQL
// -- Robin May 05

#include "aps_include"

void ArtifactMagic(object oArtifact) //Tell everyone that an artifact has been created and makes a collum of light appear near it
{
    object oOwner = GetItemPossessor(oArtifact);
    AssignCommand(GetModule(), SpeakString("You sense that an artifact has entered the world...", TALKVOLUME_SHOUT));
    object oLight = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_solblue", GetLocation(oOwner), TRUE);
    AssignCommand(oLight, DelayCommand(60.0, DestroyObject(oLight)));
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), oArtifact, 0.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), oOwner, 60.0f);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SOUND_BURST), oOwner, 30.0f);
}

object SummonArtifact(object oOwner)
{
    SQLExecDirect("SELECT `resref` FROM `nordock_artifacts` WHERE `found` = 0 ORDER BY RAND() LIMIT 1");
    if (SQLFetch() == SQL_ERROR)
    {
        SendMessageToAllDMs("Out of artifacts");
        PrintString("Out of artifacts");
    }
    else
    {
        string sResRef = SQLGetData(1);
        SQLExecDirect("UPDATE `nordock_artifacts` SET `found`=1 WHERE `resref` = '" + SQLEncodeSpecialChars(sResRef) + "'");

        object oArtifact = CreateItemOnObject(sResRef, oOwner);
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
    return OBJECT_INVALID;
}
