// PUKE IT UP!!!!
// You didn't ask for it...but you got it anyway.
// This is my first script from scratch.
// Created by DM_Rothgar
// Its a PUKING script!!!

void main()
{
    effect ePuke = EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL);
    object oPuker= GetNearestObjectByTag("Waldo");
    string sPukeTalk = "BBBLLLLAAAARRRRGGGGHHHHH!!!!";
    string sPukeApology = "Sho Shorry about your shooesh...I thinksh I have hash too much to drinksh!";
    ClearAllActions();
    AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE));
    AssignCommand(OBJECT_SELF, ActionSpeakString(sPukeTalk));
    DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePuke, OBJECT_SELF, 1.0));
    DelayCommand(5.0, ActionSpeakString(sPukeApology));
}
