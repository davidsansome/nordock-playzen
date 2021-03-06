//::///////////////////////////////////////////////
//:: aa_treedeath
//::
//:: This is the on_death script for custom tree's
//:: that will produce up 2 four types of lumber.
//:://////////////////////////////////////////////
/*

  This script can be easily be modified to work
  in almost any situation were you want "x" type
  of wood to be created on the player.  By simply
  replacing the 4 item tags that can be made by
  chopping on the tree.



*/
//:://////////////////////////////////////////////
//:: Created By: Raasta
//:: Created On: November 6, 2002
//:://////////////////////////////////////////////

object otree = OBJECT_SELF;
location lLoc = GetLocation(otree);

void RespawnTree(location lLoc)
    {

    // This is the command to create the new tree.
    //
    // If you want to add more trees all you have to
    // do is the following:
    //
    // Replace the reference "oaktree001" with the
    // with the correct reference name of your new
    // custom tree.

    CreateObject(OBJECT_TYPE_PLACEABLE,"oaktree003",lLoc,TRUE);
    }


void main()
    {

        object oPlayer = GetLastKiller();

        // Let's do our roll of the dice here.

        int idiceroll = d4();  // this will be the random item number created
        int ichophit = d20();  // this is the roll to see if a player succeeds or not.

        // Gets the item used to kill tree that is in the RightHand (primary slot)

        object oWeaponOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPlayer);

        // Checks player's weapon to make sure it is the right tool.
        // In this case "ITEM_WOODAXE" which is the pre-made axe that
        // comes with the .erf used to chop wood.
        //
        // Then returns the results for whatever number was randomly
        // rolled on a 1d4.
        //
        // You need to replace the "TAG_OF_WOOD#" with the tag of the
        // items you want people to get when lumberjacking.

        if (GetTag(oWeaponOnPlayer) ==  "ITEM_WOODAXE")  // checks for the correct tag
        {
           if (ichophit <= 10) // if the succeed roll is 10 or greater they get wood
           {
                if (idiceroll = 4) // short elm staves
                {
                CreateItemOnObject("ats_r_cash_b_sta", GetLastKiller(), d6()+1);
                }
                else if (idiceroll == 3) // short oak staves
                {
                CreateItemOnObject("ats_r_cash_b_sta", GetLastKiller(), d6()+1);
                }
                else if (idiceroll == 2) // long oak staves
                {
                CreateItemOnObject("ats_r_clsh_b_sta", GetLastKiller(), d6()+1);
                }
                else if (idiceroll == 1) // long oak staves
                {
                CreateItemOnObject("ats_r_clsh_b_sta", GetLastKiller(), d6()+1);
                }
            }
            else
            {
            // Give them a small message stating they missed.. sorry no wood.

            FloatingTextStringOnCreature("You failed to get any wood from the trees..", oPlayer, FALSE);
            }
        }
        else
        {

        // Oops.. notify the player that they are missing their axe.. and they need to replace it.

        FloatingTextStringOnCreature("You must equip your WoodCutters Axe to get wood from trees.", oPlayer, FALSE);

        //return;
        }

    // Now that the tree is gone, and the player has his wood..
    // let's recreate tree in 150 seconds..

    AssignCommand(GetNearestObjectByTag(GetTag(otree)),DelayCommand(45.0f,RespawnTree(lLoc)));

    }
