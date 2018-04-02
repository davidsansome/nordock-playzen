// Heartbeat script for a Trash Fairy that collects and
// destroys any items left on the floor. Attach to the
// heartbeat of the creature you wish to collect items
// from the ground.  I use a fairy set to commoner faction,
// DM speed, with the plot switch so as people can't kill
// her when they realize she's taken what they just dropped.
//  Adjust perception as needed.
//
// This works quite well in Contest of Champion mods where
// people are always dropping items on the floor of the entry.
// Created 7.27.2002 by Undead Waiter

void EatObject(object oItem)
{
    if (GetItemPossessor(oItem) == OBJECT_SELF)
        DestroyObject(oItem);
}

void main()
{
    if (GetCurrentAction() != ACTION_INVALID)
        return;

    object oItemToDestroy = GetNearestObject(OBJECT_TYPE_ITEM);
    if (oItemToDestroy != OBJECT_INVALID)
    {
        ActionMoveToObject(oItemToDestroy);
        ActionPickUpItem(oItemToDestroy);
        ActionDoCommand(EatObject(oItemToDestroy));
    }
}
