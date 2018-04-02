/*        Various States of Death and Dying in the Hardcore system
    Starting Status: Alive

    Case 1: Player reaches 0 hp for some reason (from > 0).
    Effect: Player is labeled as DISABLED. See DR effects below.
    Curing: Player may be healed by spells, may drink a potion, rest, or any
            normal healing method.  Doing so removed the DR Effects.

    Case 2: Player reaches -1 to -9 hp for some reason.
    Effect: You are DYING, you lose 1 hp every round (6 seconds).  You are
            incapable of any action. (You can talk and shout, but if i could
            prevent that I would turn it off too).  All unequipped items on
            your body become lootable on a Death Corpse (DC).
    Curing: Any external healing that takes you above 1hp fully restores you.
            You have a 10% chance per round to Stabilize (see case 4).  Any
            healing that increases your hp but doesnt take you to >= 1 hp also
            stabilizes you.

    Case 3: Player is -10 hp or more.
    Effect: You are DEAD.  You go to Limbo where you are revived, but are
            paralyzed, waiting for help.  All items on your body, INCLUDING
            gold, are lootable.  You remain in Limbo till restored in a manner
            below (Curing) or till you decide to quit and reroll.
    Curing: 1)  A level 9+ PC cleric may cast raise dead on you.
            2)  A level 13+ PC cleric may cast resurrection on you.
            3)  On your body is a PC Token.  A living player may pick up this
                token, in effect Dragging your corpse.  When he drops the token
                your corpse reappears.  If he takes your PC Token to a NPC
                cleric of level 9+ and activated the token using the cleric as
                the target, you will be raised for a cost of 50gp * level of the
                cleric (so min 450gp).
            4)  All of these options will result in the loss of 1pt of Con if
                level 1, or the loss of one level if greater than level one.
            5)  You may pray (press respawn) for resurrection.  There is only a
                5% base chance this will work, plus 1% for ever 4 levels, so a
                level 20 character has a 10% chance of being heard.  If you are
                resurrected by your Deity, there is no death penalty.

    Case 4: Player WAS -1 to -9, but is now STABILIZED.
    Effect: You are still uncounscious, unable to take any actions.
    Curing: Any normal external means that brings you greater than 1 hp means
            your back to normal operation.  Otherwise, once an hour (2 min) you
            have a 10% chance of becoming conscious but disabled (RECOVERING).
            If you miss the 10%, you lose 1 hp.

    Case 5: Player was STABLIZED but is now RECOVERING.
    Effect: You are conscious, but suffering DR Effects (see below).
    Curing: Any normal external means that brings you greater than 1 hp means
            your back to normal operation.  Otherwise, once a day (48 min) you
            have a 10% chance of beginning to recover normally (you can rest
            again).  If you miss the 10%, you lose 1 hp.

    DISABLED / RECOVERY Effect (DR)
    When a person is concious, but disabled or recovering (see above), the
    following effects will be in place:
    1) Slowed 80%
    2) Cursed (-5 all stats)
    3) Unable to Rest

    The only way to remove these effects are to be cured by a spell or potion
    or to make the 10% roll that happens once per day.
*/
void main(){}
