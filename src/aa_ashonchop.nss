// routine for shooting out little pieces of wood on damage

object otree = OBJECT_SELF;

void main()
{
        object oPlayer = GetLastDamager();

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
           if (ichophit <= 5) // if the succeed roll is 10 or greater they get wood
           {
                if (idiceroll == 4) // short oak staves
                {
                CreateItemOnObject("ats_r_cash_n_sta", oPlayer, d6()+1);
                }
                else if (idiceroll == 3) // short oak staves
                {
                CreateItemOnObject("ats_r_cash_n_sta", oPlayer, d6()+1);
                }
                else if (idiceroll == 2) // long oak staves
                {
                CreateItemOnObject("ats_r_clsh_n_sta", oPlayer, d6()+1);
                }
                else if (idiceroll == 1) // long oak staves
                {
                CreateItemOnObject("ats_r_clsh_n_sta", oPlayer, d6()+1);
                }
            }
        }
        else
        {

        // Oops.. notify the player that they are missing their axe.. and they need to replace it.

        FloatingTextStringOnCreature("You must equip your WoodCutters Axe to get wood from trees.", oPlayer, FALSE);

        //return;
        }



}
