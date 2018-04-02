//::///////////////////////////////////////////////

//:: Name: Object Respawner

//:: FileName: objectrespawner

//:: Copyright (c) 2001 Bioware Corp.

//:://////////////////////////////////////////////

/*

Respawn an object after its destroyed.

*/

//:://////////////////////////////////////////////

//:: Created By: VorpalBlade

//:: Created On: 7/21/02

//:://////////////////////////////////////////////

void RespawnObject(int nType, string sTemp, location lRespawn);

void main()

{

// Get the object's spawn point, Type and the template name as the Tag.

    location lSpawn = GetLocation(OBJECT_SELF);

    string sTemplate = GetTag(OBJECT_SELF);

    int nObjectType = GetObjectType(OBJECT_SELF);

// Send Respawn command to the module so it will execute even

// after this object is dead and buried

    AssignCommand(GetModule(), DelayCommand(600.0, RespawnObject(nObjectType, sTemplate, lSpawn)));

}

void RespawnObject(int nType, string sTemp, location lRespawn)

{

    CreateObject(nType, sTemp, lRespawn);

}

