//::///////////////////////////////////////////////
//:: FileName prost_check_fem
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/6/2002 4:39:18 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Add the gender restrictions
	if(GetGender(GetPCSpeaker()) != GENDER_FEMALE)
		return FALSE;

	return TRUE;
}
