///////////
//Drunken fool
/////////// //////////////////////////////////////////
//This script rolls 1d10 and causes a random walking NPC to be have as a drunk.
//Not that I know anything about that :)
///////////
//Script by Christopher Bernert
//Date Created: 6/27/02
//////////////////////////////////////////////////////
//object oPC = GetLastPerceived(); This can go in to recognize PCs in the future
int iRollTen = d10(1);
void main()
{
//object oAle;
//oAle = (NW_IT_THNMISC002);
DelayCommand(20.0, ActionRandomWalk());
if(d100(1) > 41)            //60% chance of performing a drunken act
    {
      {
        switch(iRollTen)    //Generated Number
            {
            case 1:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(PlaySound("as_pl_tavtoastm2"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_LISTEN));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 2:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 3:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(PlaySound("as_pl_tavdrunkm2"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 4:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(PlaySound("as_pl_tavdrunkm1"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 5:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ActionDoCommand(PlaySound("as_pl_hiccupm2"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 6:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(PlaySound("as_pl_tavdrunkm3"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 7:
            ClearAllActions();
            ActionDoCommand(PlaySound("as_pl_tavtoastm3"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 8:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(PlaySound("as_pl_tavdrunkm4"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 9:
            ClearAllActions();
            ActionDoCommand(PlaySound("as_pl_hiccupm2"));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            case 10:
            ClearAllActions();
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            ApplyEffectToObject( DURATION_TYPE_PERMANENT, eVis, OBJECT_SELF);
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ApplyEffectToObject( DURATION_TYPE_PERMANENT, eVis, OBJECT_SELF);
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS));
            ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
            break;
            }
         }
      }
   }

