/*
    hc_fb_death_crps
    by Celedhros, 25 July 2002

    If the Hardcore Death system is in use, putting this script in the
    OnOpen event of the Death Corpse object will cause the corpse to identify
    its owner whenever it is opened. If you wish to have it also identify the
    person looting the corpse, uncomment lines 20-22 and comment out line 18.
    You may change the text between the quotes of line 22 to say whatever you
    wish when someone loots a death corpse.
*/
#include "hc_inc"
#include "hc_text_health"


void main()
{
    object oCorpse = OBJECT_SELF;
    string sOwner = GetLocalString(oCorpse,"Name");

    string sFeedback = CORPSEOF + sOwner;

//    object oLooter = GetLastOpenedBy();
//    string sLooter = GetName(oLooter);
//    string sFeedback = sLooter + " is looting the corpse of " + sOwner;

    SpeakString(sFeedback);
}
