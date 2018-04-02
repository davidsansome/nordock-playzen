// Attach this to the onUsed and onPhysicalAttacked scripts of a gong
// Be sure your gong has the word 'gong' in its tag.
// If you put a club nearby (or anything nearby) with the tag 'baton'
// then players will pick it up and use it to play the gong.

int isGong( object gong ) {
    return ( FindSubString( GetStringLowerCase(GetTag(gong)), "gong" ) >= 0 );
}

int isBaton( object baton ) {
    int type = GetBaseItemType(baton);
    return
        type == BASE_ITEM_TORCH ||
        type == BASE_ITEM_CLUB ||
        type == BASE_ITEM_LIGHTFLAIL ||
        type == BASE_ITEM_HEAVYFLAIL ||
        type == BASE_ITEM_MORNINGSTAR;
}

void main()
{
    if( !GetIsObjectValid(OBJECT_SELF) )
        return;

    if( GetLocalInt( OBJECT_SELF, "gongPlay" ) > 0 ) {
        object me = OBJECT_SELF;
        float delay = GetLocalFloat( me, "gongDelay" );
        DelayCommand( delay, PlaySound( "as_cv_gongring3" ) );
        if( GetLocalInt( me, "gongPlay" ) == 1 ) {
            DeleteLocalInt( me, "gongPlay" );
            DeleteLocalFloat( me, "gongDelay" );
        }
        else
            SetLocalInt( me, "gongPlay", GetLocalInt(me, "gongPlay")-1 );
        FloatingTextStringOnCreature( GetTag(me)+" gp="+IntToString(GetLocalInt(me,"gongPlay")), GetFirstPC() );
        return;
    }

    if( isGong(OBJECT_SELF) ) {
        object pc = GetLastUsedBy();
        SetLocalObject( pc, "gong", OBJECT_SELF );
        ExecuteScript( "gong_play", pc );
        return;
    }

    if( GetIsPC(OBJECT_SELF) ) {
        object pc = OBJECT_SELF;
        ClearAllActions();

        object gong = GetLocalObject( pc, "gong" );
        // First, get a baton.  If there is one on the ground, get it.  It not,
        // make one.
        object oldRightHand = GetItemInSlot( INVENTORY_SLOT_RIGHTHAND, pc );
        object oldLeftHand = GetItemInSlot( INVENTORY_SLOT_LEFTHAND, pc );
        object baton;

        int batonState = 0; // 0=alreadyHadSomething, 1=hadTorch, 2=gotFromGround, 3=created, 4=GotFromInv
        float facing = GetFacingFromLocation( GetLocation(pc) );

        if( isBaton(oldRightHand) ) {
            baton = oldRightHand;
            batonState = 0;
        }
        else
        if( isBaton(oldLeftHand) ) {
            baton = oldLeftHand;
            //ActionUnequipItem( baton );
            batonState = 1;
        }
        else {
            baton = GetItemPossessedBy( pc, "baton" );
            if( GetIsObjectValid(baton) ) {
                batonState = 4;
            }
            else {
                // Check nearby
                baton = GetNearestObjectByTag( "baton", pc );
                if( GetIsObjectValid(baton) ) {
                    location gongSpot = GetLocation(pc);
                    ActionPickUpItem( baton );
                    ActionMoveToLocation( gongSpot );
                    ActionDoCommand( SetFacing( facing ) );
                    ActionWait( 1.0 );
                    batonState = 2;
                }
                else {
                    baton = CreateItemOnObject( "nw_wblcl001", pc );
                    batonState = 3;
                }
            }
        }

        if( batonState != 0 && batonState != 1 ) {
            ActionEquipItem( baton, INVENTORY_SLOT_RIGHTHAND );
            ActionWait( 0.4 );
        }

        int reps = 1;

        float delay = 2.0;
        if( batonState == 1 )
            delay = 0.1;
        SetLocalFloat( gong, "gongDelay", delay );
        SetLocalInt( gong, "gongPlay", GetLocalInt(OBJECT_SELF, "gongPlay")+reps );
        ActionDoCommand( ExecuteScript( "gong_play", gong ) );

        while( reps > 0 ) {
            int act = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;
            if( batonState == 1 )
                act = ANIMATION_FIREFORGET_GREETING;

            //ActionAttack( gong );
            ActionPlayAnimation( act );
            ActionWait( 0.2 );
            --reps;
        }
        ActionWait( 1.0 );

        if( batonState == 1 )
            ActionEquipItem( oldLeftHand, INVENTORY_SLOT_LEFTHAND );
        if( batonState == 2 ) {
            ActionPutDownItem( baton );
            ActionWait( 0.7 );
        }
        if( batonState != 0 && batonState != 1)
            ActionEquipItem( oldRightHand, INVENTORY_SLOT_RIGHTHAND );
        if( batonState == 3 )
            ActionDoCommand( DestroyObject( baton ) );

        DeleteLocalObject( pc, "gong" );
        FloatingTextStringOnCreature( "batonState:"+IntToString(batonState), GetFirstPC() );

//        FloatingTextStringOnCreature( IntToString(n)+":pc("+IntToString(GetLocalInt(pc,"test"))+")", pc );
    }
}
