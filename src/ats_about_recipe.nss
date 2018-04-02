/****************************************************
How recipes work:

    It is very easy to create a new recipe.  You first
  need to make sure you have the item blueprints
  created.  When creating an craftable item, you must
  use a special format for the tag.  The tag and the
  resref must also be the same.  In order to get them
  to be the same, you need to use the command edit
  copy which will create a copy of the item which you
  can then edit it's resref and delete the old copy.
    The tag of the craftable item must be in the
  following example format:

  ATS_C_A511_N_IRO

  1. The first three letters are always ATS which is
     the unique identifier for this tradeskill system.
  2. The next letter after the underscore can be one
     of four letters: C for craftable items, S for
     store bought items, R for a natural resource
     like ore, and finally I for imbued items.
  3. The middle 4 alphanumeric characters represent
     the item's base tag.
        Note that for resources, these four characters
        can be anything as long as it uniquely
        identifies the item.

        a) In the case of craftable items, the first
        character is always a letter which denotes
        what skill is involved with making the item.
        This is called the craft type.
        Here are a current list of possible letters:
            Armorcrafting       = A
            Blacksmithing       = B
            Tanning             = L
            Tailoring           = T
            Weaponcrafting      = W
        You can also find the constants for these
        in the ats_constants script.

        For store bought items, this letter can be
        used to represent the category it is in much
        like the skill.  A for armor, W for weapon, L
        for leather, etc.

        b) The next character is always a number for
        both craftable and store bought items that
        denotes the category number.  For armor, this means
        what part the armor covers as follows (A full list of
        categories can be found in the ats_inc_constant
        script):
            BODY        = 0
            HELMET      = 1
            SHIELD      = 2
            MISC        = 9
        For weapons, this denotes the weapon category:
            AXES        = 0
            BLADES      = 1
            BLUNTS      = 2
            POLEARMS    = 3
            EXOTIC      = 4
            TOOLS       = 9

        c) The final two numbers are the item's ID
        number. This can be anything you want from
        21-99. 0-20 are reserved for the default
        items.  These numbers must be unique for each
        skill and category.  So you can have the same
        two items with the same ID value as long
        as they are in different catergories
        or different skills.

  4. The next letter after the underscore represents
     the quality of the item. N for normal quality,
     E for exceptional quality, and J for jewelled
     items.
  5. The last three letters indicate the main
     material of the item.  For example, for armors,
     this represents the type of ingot used to make
     the armor.  A complete list of material IDs can
     be found in the ats_constants script. Here are
     the IDs for armor/weapon materials:
         IRON      = IRO
         COPPER    = COP
         BRONZE    = BRO
         SILVER    = SIL
         GOLD      = GOL
         SHADOW    = BLA
         VERDICITE = VER
         RUBICITE  = RUB
         SYENITE   = SYE
         MITHRAL   = MIT
         ADAMANTINE = ADA
         MYRKANDITE = MYR


   Once you have all your craft related items tagged
   as such you can begin creating recipes.

   Below are the basic commands for recipe scripting:
   ATS_Recipe_NewRecipe
   ATS_Recipe_AddAlternateRecipe
   ATS_Recipe_SetMinSkill
   ATS_Recipe_SetMaxSkil
   ATS_Recipe_Ingots
   ATS_Recipe_AddMaterial
   ATS_Recipe_SetSingleType
   ATS_Recipe_SetRacialRestriction
   ATS_Recipe_SetClassRestriction
   ATS_Recipe_SetAlignmentGood
   ATS_Recipe_SetAlignmentEvil
   ATS_Recipe_SetAlignmentLawful
   ATS_Recipe_SetAlignmentNeutral
   ATS_Recipe_SetAlignmentChaotic
   ATS_Recipe_AddFailureProduct

   More information on what each of these does can
   be found below or in the ats_recipehelper script.

   ATS_Recipe_NewRecipe(string, string, int, int)
   ----------------------------------------------
   Takes 4 parameters: two strings and two integer.
   The first string is the name of the recipe.  The
   second is the craft type which should be the same
   as the craft type in the item's base tag. This tells
   the recipe what tradeskill is used primary for skill
   checks.
   You can use the constants:
        ATS_CRAFT_TYPE_ARMOR
        ATS_CRAFT_TYPE_WEAPON
        ATS_CRAFT_TYPE_LEATHER
        ATS_CRAFT_TYPE_BLACKSMITH
   The next parameter is an integer that denotes the
   craft category which should be the same as in the
   item's base tag.
   Here is a list of craft category constants:
        ATS_CRAFT_PART_BODY
        ATS_CRAFT_PART_HELMET
        ATS_CRAFT_PART_SHIELD
        ATS_CRAFT_PART_MISC
        ATS_CRAFT_PART_AXES
        ATS_CRAFT_PART_BLADES
        ATS_CRAFT_PART_BLUNTS
        ATS_CRAFT_PART_POLEARMS
        ATS_CRAFT_PART_EXOTIC
        ATS_CRAFT_PART_TOOLS
    A list of category constants can be found in the
    ats_inc_common script

    The final integer is the Item ID number that is also
    a part of the item's base tag.

    As example, say we had an item with the base tag of
    "A511", we would then call:
        ATS_Recipe_NewRecipe("Name", ATS_CRAFT_TYPE_ARMOR,
                            ATS_CRAFT_PART_HELMET, 11);
    This creates the new recipe template so that we
    can start adding components.

    ATS_Recipe_AddAlternateRecipe(string, int)
    --------------------------------------------
    This function creates another recipe for the same item base tag(meaning same
    category and ID)
    You can use this to create alternate components needed to make the same item
    OR to make items of the same type but different material and require
    different components.  You must call this function after a new recipe has
    been created or after another alternate recipe has been added.
    Parameters: string - Name to display in menu
                int    - TRUE if you want to Display this recipe separate in the menu
                         FALSE if you just want to use the display of the original recipe


   ATS_Recipe_SetMinSkill(int)
   ATS_Recipe_SetMaxSkil(int)
   ---------------------------
   These functions set the minimum and maximum skill
   levels of the recipe.  The minimum skill level is
   the level at which the item can be made and will
   show up in the crafting menus.  The maximum skill
   level is the level at which the recipe becomes
   trivial and no more skill can be gained.

   ATS_Recipe_Ingots(int, int = 50, int = 80)
   --------------------------------
   This function sets how many ingots are required to
   make the item.  The first parameter is the number
   of ingots and the second paremeter is the
   percentage risk for consumption on a failure.
   This defaults to 50% for ingots meaning that 50%
   of the time, you will lose an ingot.  This is
   calculated per ingot.  The final parameter is the
   percent(0-100) of ingots that can be salvaged.
   By using ATS_Recipe_Ingots(), any type of ingot can be used
   as long as there is an equivalent item blueprint of
   that material type.  For example, if you only have
   blueprints for iron and copper versions of an armor,
   then the recipe can take iron ingots or copper ingots
   and will make the respective armor equivalent.

   ATS_Recipe_AddMaterial(string, int, int = 0)
   ----------------------------------------
   This function adds any item as a component to the
   recipe.  The first parameter is the item's tag.
   The second parameter is the quantity needed.
   And the final parameter is the percentage risk
   for consumption.  This defaults to 0 for this
   function meaning there is no risk of consumption.

   ATS_Recipe_SetSingleType(string)
   -----------------------------------------
   This function sets the recipe as a single type
   craft item which means that there is only one
   version of the item.  This is used so that in the
   craft menu's you don't have to select the material
   type. The only parameter is the item's complete
   tag that this recipe is for.

   ATS_Recipe_SetRacialRestriction(int)
   -----------------------------------------
   This function sets a racial restriction on the recipe.
   Racial types can be found in the built-in constants list.
   They have the format RACIAL_TYPE_*.  By setting a racial
   restriction you can limit a recipe to be only made by
   particular races.

   ATS_Recipe_SetClassRestriction(int)
   -----------------------------------------
   This function sets a class restriction on the recipe.
   Class types can be found in the built-in constants list.
   They have the format CLASS_TYPE_*.  By setting a class
   restriction you can limit a recipe to be only made by
   particular classes.

   ATS_Recipe_SetAlignmentGood(bool)
   --------------------------------
   This function determines if a the good alignment
   can use the recipe.  If you call this with FALSE, then
   the good alignment cannot use this recipe. If you set
   this to TRUE, then it can.

   ATS_Recipe_SetAlignmentEvil(bool)
   --------------------------------
   This function determines if a the evil alignment
   can use the recipe.  If you call this with FALSE, then
   the evil alignment cannot use this recipe. If you set
   this to TRUE, then it can.

   ATS_Recipe_SetAlignmentLawful(bool)
   --------------------------------
   This function determines if a the lawful alignment
   can use the recipe.  If you call this with FALSE, then
   the lawful alignment cannot use this recipe. If you set
   this to TRUE, then it can.

   ATS_Recipe_SetAlignmentNeutral(bool)
   --------------------------------
   This function determines if a the neutral alignment
   can use the recipe.  If you call this with FALSE, then
   the neutral alignment cannot use this recipe. If you set
   this to TRUE, then it can.

   ATS_Recipe_SetAlignmentChaotic(bool)
   --------------------------------
   This function determines if a the chaotic alignment
   can use the recipe.  If you call this with FALSE, then
   the chaotic alignment cannot use this recipe. If you set
   this to TRUE, then it can.

   ATS_Recipe_AddFailureProduct(string, int)
   -------------------------------------------
   This function creates an item when someone fails at a recipe.
   This can be called more than once to create multiple failure products.

   Parameters: string - the tag of the item you wish to be created on failure
                           (The RESREF *must* be the same as the first 16 letters of this tag)
               int    - The percent that this product will be created on a failure

   You can refer to the ats_recipes for more examples
   on recipes already in the system.
****************************************************/
void main()
{

}
