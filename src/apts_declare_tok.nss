/****************************************************
  Persistent Token Declaration Script
  apts_inc_toksys

  Last Updated: September 24, 2002

  ***Ambrosia Persistent Token System***
    Created by Mojo(Allen Sun)

  This script is for all token declarations.  If
  you wish to create a token variable, you must
  declare it here in order to use it so that
  it is always declared on module load up.

****************************************************/
#include "apts_inc_ptok"

void main()
{
// Declare token variables here

  DeclareTokenInt("vault_gold", 1, FALSE, APTS_LARGE_INT);
  DeclareTokenInt("vault_itemcount", 4, FALSE, APTS_SMALL_INT);
  DeclareTokenInt("vault_item_1", 5, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_2", 8, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_3", 11, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_4", 14, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_5", 17, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_6", 20, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_7", 23, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_8", 26, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_9", 29, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_10", 32, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_11", 35, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_12", 38, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_13", 41, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_14", 44, TRUE, APTS_LARGE_INT);
  DeclareTokenInt("vault_item_15", 47, TRUE, APTS_LARGE_INT);
  DeclareTokenBool("kobold_staff",50,1);   // Capt Tucker's Kobold Quest
  DeclareTokenBool("gurnal_quest_1",50,2);  // Gurnal Island Lich Quest
  DeclareTokenBool("gurnal_quest_2",50,3);  // Gurnal Lich Quest
  DeclareTokenBool("mainquest",50,4);  // Galdor Quest
  DeclareTokenBool("trgob_dorn_quest_1",50,5);  //Trondor Quest
  DeclareTokenBool("trgob_dorn_quest_2",50,6);//Trondor Quest
  DeclareTokenBool("trgob_quest_1",50,7);  //Trondor Quest
  DeclareTokenBool("trgob_quest_2",50,8); //Trondor Quest
  DeclareTokenBool("galdor_intro",51,1);  // Galdor Quest
  DeclareTokenBool("galdor_on_mission",51,2);  // Galdor Quest
  DeclareTokenBool("gal_rune_done",51,3);  // Galdor Quest
  DeclareTokenBool("duke_unger",51,4);   // Duke's Trommel Mines Quest
  DeclareTokenBool("farmer_beetle",51,5);  // Farmer in Ornal Pass
  DeclareTokenBool("tucker_ring",51,6);    // Capt. Tucker's Signet Ring
  DeclareTokenBool("denzecht_vendersh",51,7);   // Drow Bugbear Quest
  DeclareTokenBool("weary_bag",51,8);    // Weary Rest Inn Delivery Quest
  DeclareTokenBool("tkan_book",51,9);  // Benzor Gypsy's Book of TKan Quest
  DeclareTokenBool("drowquest",52,1);    // Drow Main Quest
  DeclareTokenBool("legendfarm",52,2);   // Legendary Farm Completion Tracking


// Examples:

//     DeclareTokenInt("varname", 1, TRUE, APTS_SMALL_INT);
// This reserves slot 1 for a signed small integer(range from -1024 -> 1023)
// called "varname".

//     DeclareTokenInt("bob", 2, FALSE, APTS_LARGE_INT);
// This reserves slots 2, 3, and 4 for a unsigned large integer
// (range from -2147483648 -> 2147483647) called "bob".

//     DeclareTokenBool("test_bool", 5, 1);
// This reserves slot 5 and bit 1 for a boolean called "test_bool".

//     DeclareTokenFloat("floatnum", 6);
// This reserves slots 6 through 8 for a floatint point number called "floatnum".

//     DeclareTokenString("string", 9, 16);
// This reserves slots 9 through 20 for a string with max length 16 called "string".

// Slot numbers range from 1 to 35 for the main install, 36 to 70 for the
// extra pack1 and 71 to 105 for the extra pack2.
// Slot numbers must be unique when declaring variables which means you cannot
// declare two different token variables using the same slot with the exception
// of booleans in which case the slot/bit combo has to be unique.
// Floats and Medium/Large integers take up more than one slot and thus
// are considered reserved and shouldnt be used in other declarations.

// Variable Types:
// Small Integers (APTS_SMALL_INT)
//   Range: 0 -> 2047  (Unsigned)
//          -1024 -> 1023 (Signed)
//   Takes up 1 slot.
// Medium Integers (APTS_MEDIUM_INT)
//   Range: 0 -> 4194303  (Unsigned)
//          -2097152 -> 2097151 (Signed)
//   Takes up 2 slot.
// Large Integers (APTS_LARGE_INT)
//   Range: 0 -> 2147483647  (Unsigned)
//          -2147483648 -> 2147483647 (Signed)
//   Takes up 3 slot.
// Booleans
//   Range: 0 or 1
//   Takes up 1 slot.
// Floats
//   Range: 0.238x10^-9 -> 4286578688 for positive numbers
//         -0.4294x10^10 -> -0.2328x10^-9 for negative numbers
//   Takes up 3 slot.

}
