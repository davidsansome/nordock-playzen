// hc_summon_inc - include file for Summon Creature I-IX spells
// Archaegeo, June 28, 2002
// Hardcore Ruleset

// HardCore Summons Table by Jaga Te'lesin
// To use, you must download and import HardCoreERFSU.zip from the
// HCR WWW page for the actual creature files.  Then COMMENT OUT
// Line 19

string pick_creature(int nLevel)
{
    int nRoll;
    string sCreature="";
    object oPC = OBJECT_SELF;
    int iStringLength;
    int iSummonAllow = FALSE;

    // Comment the next line to use the summoned creatures tables
//    return "";
    while (iSummonAllow == FALSE)
    {
    switch(nLevel) // Level of the Summon Creature spell
    {
    // This is all skipped right now due to the return "" above.  remove that line
    // when all of the creatures exist.
        // Summon Creature I
        case 1:
            if ( (GetLocalInt(oPC,"hcsumcreat1") >0) && (GetLocalInt(oPC,"hcsumcreat1")<5) ) // to bypass uninitialized var (happened before !)
                nRoll=GetLocalInt(oPC,"hcsumcreat1");
            else
                return "";

            switch(nRoll)
            {
                case 1:   sCreature="lg_sum_cel_dog"; break;     //Celestial Dog+
                case 2:   sCreature="cg_sum_cel_badger"; break;  //Celestial Badger+
                case 3:   sCreature="le_sum_fie_dir_rat"; break; //Fiendish Dire Rat+
                case 4:   sCreature="ce_sum_fiend_hawk"; break;  //Fiendish Hawk+
            }
        break;

        // Summon Creature II
        case 2:
            if ( (GetLocalInt(oPC,"hcsumcreat2") >0) && (GetLocalInt(oPC,"hcsumcreat2")<5) )
                nRoll=GetLocalInt(oPC,"hcsumcreat2");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="cg_sum_cel_eagle"; break;  //Celestial Eagle+
                case 2:   sCreature="le_sum_lemure"; break;     //Lemure+
                case 3:   sCreature="le_sum_fiend_wolf"; break; //Fiendish Wolf+
                case 4:   sCreature="lg_sum_cel_wolf"; break;   //Celestial Wolf+
                case 5:   sCreature="ce_sum_fiend_hyena"; break; //Fiendish Hyena+
             }

        break;
        // Summon Creature III
        case 3:
            if ( (GetLocalInt(oPC,"hcsumcreat3") >0) && (GetLocalInt(oPC,"hcsumcreat3")<9) )
                nRoll=GetLocalInt(oPC,"hcsumcreat3");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="lg_sum_cel_blk_bear"; break; //Celestial Black Bear+
                case 2:   sCreature="cg_sum_cel_dir_badg"; break; //Celestial Dire Badger+
                case 3:   sCreature="ne_sum_fie_boar"; break;     //Fiendish Boar+
                case 4:   sCreature="ce_sum_fie_leopard"; break;  //Fiendish Leopard+
                case 5:   sCreature="nn_sum_sml_air_elem"; break; //Small Air Elemental+
                case 6:   sCreature="nn_sum_sml_ear_elem"; break; //Small Earth Elemental+
                case 7:   sCreature="nn_sum_sml_fir_elem"; break; //Small Fire Elemental+
                case 8:   sCreature="nn_sum_sml_wat_elem"; break; //Small Water Elemental+
            }
        break;

        // Summon Creature IV
        case 4:
            if ( (GetLocalInt(oPC,"hcsumcreat4") >0) && (GetLocalInt(oPC,"hcsumcreat4")<5) )
                nRoll=GetLocalInt(oPC,"hcsumcreat4");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="lg_sum_lant_archon"; break; //Lantern Archon+
                case 2:   sCreature="cg_sum_cel_lion"; break;    //Celestial Lion+
                case 3:   sCreature="le_sum_imp"; break;         //Imp+
                case 4:   sCreature="le_sum_hell_hound"; break;  //Hell Hound+
                case 5:   sCreature="ce_sum_howler"; break; // Howler
            }
        break;

        // Summon Creature V
        case 5:
            if ( (GetLocalInt(oPC,"hcsumcreat5") >0) && (GetLocalInt(oPC,"hcsumcreat5")<19) )
                nRoll=GetLocalInt(oPC,"hcsumcreat5");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="lg_sum_cel_brn_bear"; break; //Celestial Brown Bear+
                case 2:   sCreature="lg_sum_hound_archon"; break; //Hound Archon+
                case 3:   sCreature="ne_sum_fie_dir_boar"; break; //Fiendish Dire Boar+
                case 4:   sCreature="ce_sum_fie_panther"; break;  //Fiendish Panther+
                case 5:   sCreature="nn_sum_med_air_elem"; break; //Medium Air Elemental+
                case 6:   sCreature="nn_sum_med_ear_elem"; break; //Medium Earth Elemental+
                case 7:   sCreature="nn_sum_med_fir_elem"; break; //Medium Fire Elemental+
                case 8:   sCreature="nn_sum_med_wat_elem"; break; //Medium Water Elemental+
                case 9:   sCreature="nn_sum_air_mephit"; break;   //Air Mephit+
                case 10:  sCreature="nn_sum_dust_mephit"; break;  //Dust Mephit+
                case 11:  sCreature="nn_sum_earth_mephit"; break; //Earth Mephit+
                case 12:  sCreature="nn_sum_fire_mephit"; break;  //Fire Mephit+
                case 13:  sCreature="nn_sum_ice_mephit"; break;   //Ice Mephit+
                case 14:  sCreature="nn_sum_magma_mephit"; break; //Magma Mephit+
                case 15:  sCreature="nn_sum_ooze_mephit"; break;  //Ooze Mephit+
                case 16:  sCreature="nn_sum_salt_mephit"; break;  //Salt Mephi+
                case 17:  sCreature="nn_sum_steam_mephit"; break; //Steam Mephit+
                case 18:  sCreature="nn_sum_water_mephit"; break; //Water Mephit+
            }
            break;

        // Summon Creature VI
        case 6:
            if ( (GetLocalInt(oPC,"hcsumcreat6") >0) && (GetLocalInt(oPC,"hcsumcreat6")<7) )
                nRoll=GetLocalInt(oPC,"hcsumcreat6");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="lg_sum_cel_dir_bear"; break; //Celestial Dire Bear+
                case 2:   sCreature="cn_sum_red_slaad"; break;    //Red Slaad+
                case 3:   sCreature="nn_sum_lrg_air_elem"; break; //Large Air Elemental+
                case 4:   sCreature="nn_sum_lrg_ear_elem"; break; //Large Earth Elemental+
                case 5:   sCreature="nn_sum_lrg_fir_elem"; break; //Large Fire Elemental+
                case 6:   sCreature="nn_sum_lrg_wat_elem"; break; //Large Water Elemental+
            }
            break;

        // Summon Creature VII
        case 7:
            if ( (GetLocalInt(oPC,"hcsumcreat7") >0) && (GetLocalInt(oPC,"hcsumcreat7")<8) )
                nRoll=GetLocalInt(oPC,"hcsumcreat7");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="nn_sum_hug_air_elem"; break; //Huge Air Elemental+
                case 2:   sCreature="nn_sum_hug_ear_elem"; break; //Huge Earth Elemental+
                case 3:   sCreature="nn_sum_hug_fir_elem"; break; //Huge Fire Elemental+
                case 4:   sCreature="nn_sum_hug_wat_elem"; break; //Huge Water Elemental+
                case 5:   sCreature="nn_sum_invis_stalkr"; break; //Invisible Stalker+
                case 6:   sCreature="cn_sum_blue_slaad"; break;   //Blue Slaad+
                case 7:   sCreature="ce_sum_fie_dir_tigr"; break; //Fiendish Dire Tiger+
            }
            break;

        // Summon Creature VIII
        case 8:
            if ( (GetLocalInt(oPC,"hcsumcreat8") >0) && (GetLocalInt(oPC,"hcsumcreat8")<6) )
                nRoll=GetLocalInt(oPC,"hcsumcreat8");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="nn_sum_gre_air_elem"; break; //Greater Air Elemental+
                case 2:   sCreature="nn_sum_gre_ear_elem"; break; //Greater Earth Elemental+
                case 3:   sCreature="nn_sum_gre_fir_elem"; break; //Greater Fire Elemental+
                case 4:   sCreature="nn_sum_gre_wat_elem"; break; //Greater Water Elemental+
                case 5:   sCreature="ce_sum_succubus"; break;     //Succubus+
            }
            break;

        // Summon Creature IX
        case 9:
            if ( (GetLocalInt(oPC,"hcsumcreat9") >0) && (GetLocalInt(oPC,"hcsumcreat9")<7) )
                nRoll=GetLocalInt(oPC,"hcsumcreat9");
            else return "";
            switch(nRoll)
            {
                case 1:   sCreature="nn_sum_eld_air_elem"; break; //Elder Air Elemental+
                case 2:   sCreature="nn_sum_eld_ear_elem"; break; //Elder Earth Elemental+
                case 3:   sCreature="nn_sum_eld_fir_elem"; break; //Elder Fire Elemental+
                case 4:   sCreature="nn_sum_eld_wat_elem"; break; //Elder Water Elemental+
                case 5:   sCreature="le_sum_rakshasa"; break;     //Rakshasa+
                case 6:   sCreature="ce_sum_vrock"; break;        //Vrock+
            }
            break;
    }
    /// determine if creature can be summoned
    iSummonAllow = TRUE;
    iStringLength = GetStringLength(sCreature)-3;
    if (GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF)>0) // aplies only to clerics
        {
        string sElem1,sElem2;
        sElem1 = GetSubString(sCreature,0,1);
        sElem2 = GetSubString(sCreature,1,1);
        if ((GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC) && (sElem1 == "l"))
            {iSummonAllow = FALSE;}
        else if ((GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL) && (sElem1 == "c"))
            {iSummonAllow = FALSE;}
        if ((GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL) && (sElem2 =="g"))
            {iSummonAllow = FALSE;}
        if ((GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD) && (sElem2 =="e"))
            {iSummonAllow = FALSE;}
        }


    } // while FALSE
    // Return the chosen critter
    sCreature = GetSubString(sCreature,3,iStringLength);
    return sCreature;
}

