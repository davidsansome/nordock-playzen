/*
Detailed comments and change log about the Hardcore Module overall

CHANGES
2.0   Well, all good things must come to an end.  With this version of HCR I am
      retiring from it as project manager.  If you look below, Im going out with
      a bang.  That being said, it has been a lot of fun folks.  I am NOT done
      with NWN by a long shot, its just HCR has reached a good stopping point, at
      least for me.  It is also to the popularity level where I get a lot of
      "hate" mail from folks who dont like one thing or the other, that was
      inevitable, but its not why I code.  Coding is my hobby, I do it to relax,
      and to help others.  That being said, lets get on to the changes to HCR
      Base 2.0

      Due to the numerous changes, I recommend using the HCR Base ERF set to
      upgrade, there is a changed_files in this one, but you would be better
      going clean.
      NEW
      - Persistent World Exp System.  This system uses the Wizard exp table from
        1E ADnD as the new base table.  Due to this, it means players will need
        2500xp for level 2 (vice 1000) and 3,750,000xp for level 20 (vice 190,000).
        There are Class multiples for each class (defaulted to 1E ratios).  This
        system works WITH the Subrace xp system if you turn on the PW Exp system.
        So you will have class multiple, and a racial multiple for ECL races.  The
        system is auto-persistent, storing the exp in the normal BW exp counter
        as a ratio.  Using this system, you can set BASEXP very high (100-300) and
        players will get through levels 1-4 semi quick, and then slow way down.
        System from Archaegeo.
      - Caster AI system added.  This will make casters NPC/Monsters cast their
        spells in a smart manner.  For example, instead of casting ray of frost
        as a CR 15 Drow mage, the mage will cast Timestop, haste, greater stoneskin,
        circle of death, and then start attacking. (Thanks to Jugalator for the
        nastier casters)
      - DM's now receive a message if a PC dies more than 2x in 60 seconds, it
        normally means they are using the click like mad to avoid fugue bug.
      - Players are now set unplot every heartbeat to avoid having players run
        around invuln.  (if you need them to be invuln, you can comment out the
        code in hc_on_heartbeat)
      CHANGED
      - HCR Original subrace system is gone, now replaced by ALFA's Subrace system.
        This is an EXCELLENT system, with a TON of power for any subraces you care
        to create, even supports ECLs. Note, with this new system, due to ECL (
        Equivalent character level, ie a drow at 1 is the same as a human at 3) you
        must add all XP in your module via XP_RewardXP. NOTE: some subraces still get
        items under the SEI system, but they are not equipped, so you can turn ILR
        back on in your modules. (Many thanks to Shir'lee for putting out such a
        well made system)

1.8.7 NEW
      - New System:  If you set GHOSTSYSTEM to 1.  Instead of lingering in Fugue,
        players will go to fugue, hang out there a moment, then be sent back to
        "haunt" their bodies as an invisible, invulnerable, cant move around,
        ghost.
      CHANGED
      - Added hc_version, all it is is a version number file.  hc_defaults will
        no longer be changed unless something important changes (this time being
        the last).
      FIXED
      - Problem with canteen refilling self if player wasnt thirsty.

1.8.6 NOTE: hc_on_cl_enter was changed in this rev, if you are using ATS
            this will overwrite the ATS setup.  To resetup ATS, put
            # include "ats_inc_init"
            at the top of hc_on_cl_enter (without the space between # and include
            and put ATS_InitializePlayer(GetEnteringObject());  on line 249
      CHANGED
      - Corrected issue with a canteen being able to be filled form a water
        source trigger area with an invalid tag. Made canteen correct itself
        incase it ever gets assign an invalid water source tag descriptor.
        Made food and drink tag properties non case sensitive
      - The death corpse is invisible now when a player is dying.  It becomes
        visable when they are dead and gone.
      - Changed the default death script to support those who want to bypass the
        HCR method of animal corpse, and the NPCCorpse.  (transparent change)
        Now if you have uncommented the NW_FLAG_DEATH_EVENT in OnSpawn of your
        critter it will ignore the HCR corpses
      - When you use a PCT on a NPC cleric, it moves the existing DC to the user
        location, this should help prevent loss of items.
      - Changed it so that you only come back at 1hp after raise dead if the
        module is NOT using Rezpenalty (where you lose a level).  Will try to
        make both work later, but this fixes the problem with folks redying due
        to hp loss of the loss of level.
      FIXED
      - Problem with disabled state being applied, thanks 01.

1.8.5 NEW
      - Added ability for DMs to ban players from in game, will last till
        server restart or permamently if using pwdb
      CHANGED
      - Ranger tracking changed to not track anything that has the Trackless
        step feat (FEAT_TRACKLESS_STEP).  (Also wont track anything with an
        int of NOTRACK, but using FEATs is better).
      REMOVED
      - KCS system removed from base, made into an add-on, some folks pointed
        out rightly that it belongs better there.

*/
void main(){}
