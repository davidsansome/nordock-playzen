/*
CHANGES
1.0.6
    NOTE: Only usable with NWN v1.25 beta 2 and above.

    NEW DIALOG ENHANCEMENTS
     - You can now manage the gold of a cohort. This can be found under the
       Manage Inventory conversation branch.
     - When cohorts find a PC who maybe able to rez their master, they will also
       now offer any rez scrolls that they picked up to help entice the PC to help.
     - Added functions for changing a cohorts "Town Centre" location if
       PWCOHORT = TRUE.

    NEW DOCUMENTATION
     - Add example for a hc_inc_on_death script to the bottom of cohort_readme.
     - New script, cohort_pwreadme. Which details the Persistent Cohort System.

    NEW
     - Cohorts can now use all standard HCR healing potions!
     - New switch in cohort_inc_vars, called PWCOHORT. Setting this to TRUE will
       enable Persistent World Cohort support. If the Cohorts are being used in
       a Persistent World environment instead of a standard module, you should
       read cohort_pwreadme for details.
     - Cohorts can now actively seek employment. SEEKEMPLOYMENT = TRUE  and
       USELEADERSHIP = TRUE must be set in cohort_inc_vars. SEEKEMPLOYMENT = TRUE
       flag line must be uncommented in the cohorts spawn script. The flag line
       is included in cohort_ac9 so you can make a duplicate script with this
       line uncommented, so you can have some cohorts that seek and some that don't.

    CHANGED
     - Stopped cohorts from shouting when accosting PCs for various reasons. It was
       really annoying.
     - Cohorts will now provide location information when they are carrying corpses
       around.

    FIXED
     - Any item can now be given to Cohorts non-standard items (items which do not have
       matching tags and resrefs.

    KNOWN ISSUES
     - Cohorts can sometimes "lose" items during inventory management when the player
       gives the items back to the Cohort. This was noted with NWN v1.25 BETA 2.

1.0.5
    HCR Compliance:
     - HCR 2.0 SR2, now contains as part of the SR2 patch, the appropriate changes
       to the HCR files that the cohort system once modified. This now means
       that it is no longer necessary to overwrite those files provided you have
       upgraded to HCR 2.0 SR2. These overwritten files will now no longer be included
       in the ERF package.

    NEW DIALOG ENHANCEMENTS
     - Cohorts who lack the funds to ressurect their master will ask a passing PC
       that has has enough of the difference if they can grant the funds.

    NEW
     - Most Ressurection feedback strings have now been placed in cohort_text.
     - Emergency rezzing cohorts will no longer spam the player with lack of funds
       messages. There may still be a few stray 'looking' or 'stuck' messages
       while the cohort lines up with it's waypoint.
     - When using a PCT on an NPC cohorts will now provide more useful feedback.
     - Cohorts will attempt to talk to the player after NPC resurrection.

    FIXED
     - Occurances in which the game and/or server would crash when attempting to
       talk to your cohort.
     - Removed some debugging string that had been accidently left in.

1.0.4
    NEW DIALOG ENHANCEMENTS
     - Added all remaining low intellifence dialog branchs to the cohort_dlg template.
     - Added the variable USELEADERSHIP to cohort_inc_vars. If this value
       is set to true, then the PC attempting to hire a cohort must be at least
       level 6 and have the feat skill focus persuade. (this is a stand in for the
       leadership feat)
     - Added the variable ALIGNRESTRICT to cohort_inc_vars. The value assigned
       here determines the type of alignment restrictions placed on a PC when they
       attempt to hire a cohort.
     - The cast spell and summon familiar dialog options now only show up if
       the cohort actually has these abilities.

    CHANGED
     - Many dialog scripts have changed or renamed. See cohort_changed for a
       full list of affected files.

    FIXED
     - Cohort not equipping armor and items after finishing inventory managment.
     - Cohort enhaced worong target when request made to enhance themselves.
     - Familiar will now be unsummoned before the cohort levels up.
     - Division by zero errors were occuring from HCR 2.0, upgrade to HCR 2.0 SR1 to
       correct this.


1.0.3
    NEW
     - Added cohort resurrection scripts which provide the following functionality:

        1.  When their master/mistress dies, they will attempt to resurrect them!

            a.  The cohort will utilise any Raise Dead or Resurrection scrolls that
                they have.
            b.  The cohort will utilise any Raise Dead or Resurrection spells that
                they have.
            c.  The cohort will pick-up any Raise Dead or Resurrection scrolls that
                are on the floor within a 50 foot area.
            d.  The cohort will rifle the Death Corpse for any Raise Dead or
                Resurrection scrolls.
            e.  Cohort will pickup PCT and make their way to a waypoint for
                resurrection attempt. This waypoint must be added and by default
                it's tag should be: COHORT_TOWN_CENTRE_ + Tag of cohort. So
                our ALEXAs base waypoint tag would be COHORT_TOWN_CENTRE_ALEXA.
            f.  Cohort should approach PC clerics to resurrect a PCT. (NOT
                TESTED).
            g.  Cohort will use NPC clerics to resurrect a PCT.

        2.  The master/mistress of a cohort can now order them to attempt a
        resurrection of another player. In order to prevent changes to HCR
        shipped scripts, this is done through a conversation file, and can be
        found under the "Cast Spells" tree.

    NEW
     - You can now cast healing spells and effects on a bleeding Cohort/NPC in order
       to bring them back up to a disabled state.

    CHANGED
     - Cohort/NPC should now automatically equip the items they retrieve from
       their dropped items bag and/or death corpse after getting rezzed.

    FIXED
     - Stopped extra Spell effects being cast on Cohort/NPC after ressurection.
     - Issue with Raise Dead killing Cohort/NPC after raising them.
     - Cohort/NPC not bleeding when they die a second time when at a disabled state.
     - PCT of the Cohort/NPC not destoying itself after they get rezzed.
     - Issue where duplicate Cohort/NPC death corpses could be generated.
     - Issue where Cohort was uncommandable when in a disabled state.
     - Issue whern using the right click menu on Cohort #1 and removing them from the
       party would drop the entire chain.
     - Added in a few of Paus's v89 modifications that were accidently left out.
     - Cohorts will no longer turn into a Badger if you request them to level up and
       a blueprint resource for the new level does not exist.

1.0.2
    NEW
     - Added cohort states that match the ones described by the Player states in HCR.
       Cohort and/or NPCs using the same scripts will now bleed to death down to -10
       (this is tracked internally and is not visable via the portrait) Cohorts and/or
       NPCs gave the chance to stabilize and recover heaiing naturally just like
       players do if using the beedsystem.
     - Cohorts and NPCs using the same scripts will generate a 'dropped items' bag and
       a death corpse upon dyding state or true death at -10 hit points, if using
       lootsystem. A PCT is generated for the Cohort/NPC as well allowing the corpse
       to be movable and/or brought to a cleric.
     - Cohorts and NPCs can be raised via Raise Dead and Ressurection spells.
       (there is an issue with raise dead but it is fixable with a fix to HCR)
     - Added several "low PC intelligence" branchs to the dialog tree. Made a few
       spelling and grammer corrections to the dialog.
     - Incorporated Pausianas v89 into henchman AI and inventory management.

    CHANGED
     - Renamed and replaced some of the dialog scripts.

1.0.1
    NEW
     - Added cohort_inc_vars and cohort_text. Cohort_inc_vars contains user adjustable
       variables to give greater control of various parts of the cohort system.
       Cohort_text will contain all text string in one place for easier localization
       by builders.
     - Restrictions on Cohort hiring are as follows:
       Cannot hire more cohorts than specified by MAXCOHORTS variable.
       Cannot hire cohorts that are higher than potential employer's level minus
       COHORTLAG (the lag is the number of levels a cohort lags behind the PC that
       hired them)

    CHANGED
     - Renamed and replaced some of the dialog scripts.

    FIXED:
     - Several Issues with Cohorts #2+ not following their RealMaster correctly and not
       doing normal activities and commands.

1.0.0
    Used v1.3 of 69MEH69's henchman kit as a base to start from.
    The kit uses Pausians v88 Battle amd Henchman AI and Inventory Management system
    Took source scripts from mistermister's multiple henchmen system and upgraded
    them using v87 of Paus, to v89 and incorporated them into the v1.3 henchman kit.
    Took the now altered kit and renamed files and merged and removed unesesary file
    dependancies (such as the nw_c2_default1 - 9 files that only effect Paus's Monster
    battle AI, and have nothing to do with henchmen. Renamed all files that that
    would have overwritten Bioware files. Edited all references and includes of said
    files in all affected scripts. Renamed all files to hold consisntant naming
    convention. Made sure system could coexist with HCR by not sharing any files that
    would conflict between updates.
    Generated ERF and imported into HCR base 1.8.4 for Demo mod.

*/
void main() {}
