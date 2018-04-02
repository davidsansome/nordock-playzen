/*
    Script cohort_about,  HCR compliant Cohort System v1.0.6 BETA.
    For Persistent World Cohort support information, read cohort_pwreadme.

    Made Sept 2, 2002 by Edward Beck (0100010)

    Readme file for HCR compliant Cohort system, built upon and expand from
    the great works of others:

    Pausianas for enhaned henchman AI and inventory management.
    mistermister for providing a base for multiple henchmen support.
    69MEH69 for tweaking dialogs, stripping SP campaign code and making it easy
    to use as a module kit.

    And to any other people and/or work I may have forgot to mention.

    All of the files from the ERF should function stand alone as separate files.
    Any other files refered to should be either original Bioware scripts or HCR scripts
    that should remain unaffected, with the exception of the following five files:
    hc_fugue_enter, hc_fugue_exit, nw_s0_raisedead, nw_s0_resserec, and hc_act_pct.
    If you compare these files to the HCR 2.0 SR1 versions of these files, the only
    changes are minor, where a GetIsPC() check has been added to a few lines, and that
    is the only differnece between the files. These changes will not adversely affect
    any aspect of HCR, but were added to make the system more compatible.

    NOTE!!!: Make sure the in hc_defaults LIMBO and LOOTSYSTEM are set to true!
    This system has not been tested when either of those switchs are off, and turning
    either one off may result in breaking the cohort system.

    Email any bugs and/or enhancement requests to edbeck@0100010.com. Note that if it
    is hate mail, I am just going to trash it without reading it so don't even bother.
    If it is constructive then I will review it and make changes where necessary.

    The majority of the following is from 69MEH69's original readme document, but
    modified where approiate to reflect adjustments for this system. Celowin's
    henchmen tutorial also served often as a reference.

    Creating the cohort Blueprint
    BioWare level up functions are not being used.
    The naming conventions is therefore different from theirs.
    The tag for the cohort should be the first name, but in all uppercase.
    In my case, the tag is CORIC. The blueprint (found on the Advanced tab)
    is the name in all lower case, plus the three digit version of the cohort level.
    Again, in my case for a level 1 Coric, the blueprint would be coric001.

    Tag = uppercase, blueprint = lowercase with level.
    Conforming to this standard is required to get this to work.

    Note: The reason a three digit level is being used instead of a two digit level
    like some other systems, is because useing "Edit Copy" from a blueprint defaults
    to incrmenting the new object in exactly this way. Thus it was easier to do an
    edit copy off of the preceding level, and get the blueprint resref name right
    automatically.

    One more time -
    Tag: CORIC
    Blueprint: coric001

    Moving on, other things to set on our cohort:
    Make sure the faction is set to "Merchant"
    Make sure the No Permanent Death box is checked.
    Equip the cohort. Start him out with a melee weapon equipped, but have a ranged
    weapon in inventory, with plenty of ammunition.
    There will be lots of conversation with the cohort. Make certain it has a portrait.
    Make sure perception range is set to Default.
    Create a deity for your cohort

    Making Cohorts of level 2+.
    You should simply right click the level one version of your cohort and select
    "Edit Copy". For level 2+, be sure to remove all inventory.
    Add all appropriate skills, feats, stats, and/or spells as desired, as if you
    just leveled up the creature. Repeat this for as many levels as you wish.

    Now, we need to set up the basic scripts for our cohort. I'm just going to use a
    "plug and play" approach here, we're not going to delve into exactly how these
    scripts work. All these scripts can be selected from the drop down menu, or else
    the names typed in manually. (Of course, double check you have the name exactly
    right if you type it.)

    A couple of notes: I have tried to test making use of an OnRested event script,
    using both the Bioware default nw_ch_aca, and one with a different name. I could
    never get the script to actually fire when the cohort rested. This appears to be
    a Bioware bug that either fails to signal the OnRested event for NPCs when they
    rest or it is missng an internal linking refernece to know which  script to fire
    when the event occurs. So for now, just leave that event's script blank.

        OnBlocked: nw_ch_ace
        OnCombatRoundEnd: cohort_ac3
        OnConversation: cohort_ac4
        OnDamaged: cohort_ac6
        OnDeath: cohort_ac7
        OnDisturbed: cohort_ac8
        OnHeartbeat: cohort_ac1
        OnPerception: cohort_ac2
        OnPhysicalAttacked: cohort_ac5
        OnRested: Leave Blank
        OnSpawn: cohort_ac9
        OnSpellCastAt: cohort_acb
        OnUserDefined: cohort_acd

    Ok, check one more time that your tag and blueprint are set properly, and also make certain that
    the cohort actually has the feats to use the equipment you've given it. Once
    everything is set, it is time to work on the conversation.

    Cohort Conversation:
    I assume everyone knows how to create dialog for their NPC. I have included a
    dialog tree which contains all the possible options for your cohort, use this as
    a reference dialog. Simply copy and paste from this dialog tree into a new
    conversation or save it as a new conversation and remove or add what you need
    for your cohort. The dialog tree has conditionals for the intelligence of the
    PC and all required scripts are attached to the specific lines. I simply reused
    the dialog that is within the original game, you can change it to your hearts
    content.

    The Cohort Repository:
    There is a Waypoint tagged COHORT_REPOSITORY. You will need to place this waypoint
    in an area that is inacessible to players, such as the blocked off portion of
    the fugue plane in HCR. Will have to make such an area if one does not exist.
    This is where Cohorts go for a moment when they level up, (so you wont see their
    naked selves before they equiped their items.) This is also where they will go
    when they die to await ressurection.

    The Cohort Emergency Home WayPoint
    If a Cohort cannot resurrect their master, they will pickup PCT and make
    their way to a waypoint for a resurrection attempt. This waypoint must be
    added and by default it's tag should be: COHORT_TOWN_CENTRE_ + Tag of cohort.
    So our ALEXAs base waypoint tag would be COHORT_TOWN_CENTRE_ALEXA. This is ignored
    is PWCOHORT = TRUE;

    Example hc_inc_on_death Script
    Certain variables must be applied when a player dies that allow the Cohort to
    determine that this player has died. This allows cohorts to re-join resurrected
    players.

//://////////////////////////////////////////////
    #include "cohort_inc_vars"

    // PLACEHOLDER

    int preEvent()
    {
        return 1;
    }

    void postEvent()
    {
        object oPlayer = GetLastPlayerDied();
        object oMod = GetModule();

        //Clear any associated henchman, so they will offer to rejoin.
        if(PWCOHORT)
        {
            if(GetPersistentInt(oPlayer ,"NW_L_HIREDALEXA") == 10)
                SetPersistentInt(GetObjectByTag("ALEXA"), "NW_L_HEN_I_DIED", TRUE);

            if(GetPersistentInt(oPlayer ,"NW_L_HIREDCINDY") == 10)
                SetPersistentInt(GetObjectByTag("CINDY"), "NW_L_HEN_I_DIED", TRUE);

            if(GetPersistentInt(oPlayer ,"NW_L_HIREDKATIE") == 10)
                SetPersistentInt(GetObjectByTag("KATIE"), "NW_L_HEN_I_DIED", TRUE);

            if(GetPersistentInt(oPlayer ,"NW_L_HIREDMINERVA") == 10)
                SetPersistentInt(GetObjectByTag("MINERVA"), "NW_L_HEN_I_DIED", TRUE);
        }
        else
        {
            if(GetLocalInt(oPlayer ,"NW_L_HIREDALEXA") == 10)
                SetLocalInt(GetObjectByTag("ALEXA"), "NW_L_HEN_I_DIED", TRUE);

            if(GetLocalInt(oPlayer ,"NW_L_HIREDCINDY") == 10)
                SetLocalInt(GetObjectByTag("CINDY"), "NW_L_HEN_I_DIED", TRUE);

            if(GetLocalInt(oPlayer ,"NW_L_HIREDKATIE") == 10)
                SetLocalInt(GetObjectByTag("KATIE"), "NW_L_HEN_I_DIED", TRUE);

            if(GetLocalInt(oPlayer ,"NW_L_HIREDMINERVA") == 10)
                SetLocalInt(GetObjectByTag("MINERVA"), "NW_L_HEN_I_DIED", TRUE);
        }
        return;
    }
//://////////////////////////////////////////////


    Revision info:
    See cohort_about  for chage and correction summaries per version
    See cohort_changed  for a list of altered and/or new scripts per version

*/
void main() {}
