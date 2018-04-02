void CreatePenguin(location lPenguin)
{
    object oPenguin = CreateObject(OBJECT_TYPE_CREATURE, "legendarypeng001", lPenguin);
    SetLocalInt(oPenguin, "GongSpawned", 1);
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "Part2") == 1)
        return;

    object oPC = GetLastUsedBy();

    // Cycle through all PCs in area
    object oGongWP = GetObjectByTag("WP_PenguinGong");
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    object oObject = GetFirstObjectInArea();
    while (GetIsObjectValid(oObject))
    {
        if (GetIsPC(oObject))
        {
            // Jump to gong
            AssignCommand(oObject, ClearAllActions(TRUE));
            AssignCommand(oObject, ActionJumpToObject(oGongWP));

            // Apply shaking effect
            DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oObject));
        }
        oObject = GetNextObjectInArea();
    }

    // Lock doors
    object oDoor1 = GetObjectByTag("PenguinDoor1");
    object oDoor2 = GetObjectByTag("PenguinDoor2");
    object oGong = GetObjectByTag("PenguinGong");
    AssignCommand(oGong, ActionDoCommand(SetLocked(oDoor1, FALSE)));
    AssignCommand(oGong, ActionCloseDoor(oDoor1));
    AssignCommand(oGong, ActionDoCommand(SetLocked(oDoor1, TRUE)));
    AssignCommand(oGong, ActionDoCommand(SetLocked(oDoor2, FALSE)));
    AssignCommand(oGong, ActionCloseDoor(oDoor2));
    AssignCommand(oGong, ActionDoCommand(SetLocked(oDoor2, TRUE)));

    // Play sounds
    DelayCommand(1.0f, PlaySound("as_na_rockfalsm4")); // Shaking
    PlaySound("as_cv_gongring1"); // Gong ring

    // Summon penguin
    location lPenguin = GetLocation(GetObjectByTag("WP_PenguinBoss"));
    effect eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    DelayCommand(3.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGate, lPenguin));
    DelayCommand(6.0f, CreatePenguin(lPenguin));

    // Set variable on gong
    SetLocalInt(OBJECT_SELF, "Part2", 1);
    DelayCommand(900.0f, DeleteLocalInt(OBJECT_SELF, "Part2")); // Delete in 15 mins
}
