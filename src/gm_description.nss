/*  The Archaegeo Gambling System
    Based on the Appendix F games from DMG first edition
    (I really feel bad about having coded this, but its too cool to not use.)

    **** WARNING - The NWN Surgeon General has determined that gambling can be
    an addictive past-time.  Do not enter any casino with more than your willing
    to lose.

    To set up:
    Put gm_on_mod_load into the Module Event On Module Load (or incorporate it
    with your current one).

    In gm_include, there is a variable called HOUSESTART that sets up the initial
    "bank" of the house.  Each time a player loses, the money is added to the bank.
    Each time a player wins, money is taken from the bank.  If a player wins more
    than the house has, he gets told he has "broke the bank".

    Each game has an Animation with it, and a effect if the player wins.

    There are several games that can be set up, you can use one or all of them.
    All games have a BASECOST variable at the top of their script.

    Easels are used to explain the various games, you dont have to place them.

    Slot
    Place the slot placeable where you want the game, and the Slot Easel beside it.
    Odds are 1:216, with max payoff of 36:1

    Zowie Slot
    Place the zowie placeable where you want it, and the zowie easel beside it.
    Odds are 1:512, with a max payoff of 100:1

    In-Between
    Place the In-Between placeable where you want it, and its easel beside it.
    Odds are 5:2, payoff is 2:!


*/
void main(){}
