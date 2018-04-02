/*
Gambletron 2000 Slot Machine v1.0 for Neverwinter nights.
Written by Steven Hunter (steven_hunter@NOSPAMyahoo.com)

Features
-Easily extendable to include additional wheels or symbols.
-Variable payout scale.
-Variable odds (looseness).
-Works with any size bet (within integer limits).

CustomToken numbers used:
90001 = Results token
90002 = Win/lose/error token

Coming soon:
Video Poker

Also available:
Baccarat
*/

void main()
{
object oPC = GetPCSpeaker();
int iFudge = 0; //To be used later for a "fudge factor".
int wheel1 = d100() + iFudge;
int wheel2 = d100() + iFudge;
int wheel3 = d100() + iFudge;
int val = 0;
int payout = 0;
int bet = GetLocalInt(oPC, "bet"); //Must be set from another script
SetCustomToken(90001, "No results to show. ");

if (GetGold(oPC) < bet) //No credit given!
{
SetCustomToken(90002, "You do not have enough GP to cover that bet! Please choose a different amount. Try again?");
return;
}

if (bet < 1) //Should never occur.
{
SetCustomToken(90002,"Wow, somehow you bet less than 1 GP. Bet has been reset to 1GP. Try again?");
SetLocalInt(oPC, "bet", 1);
return;
}

TakeGoldFromCreature(bet, oPC, TRUE);

ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 1.0, 1.0);
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE, 1.0, 1.0);

string fruit1 = "Blank";
string fruit2 = "Blank";
string fruit3 = "Blank";

if (d6() > 1){//This affects the loose-ness of the machine. The closer to 1=1
              //you get the looser it is.
if (wheel1 < 51){
fruit1 = "Lemon";
val = val + 1;
}else{
    if (wheel1 < 76){
    fruit1 = "Cherry";
    val = val + 2;
    }else{
        if (wheel1 < 90){
        fruit1 = "Orange";
        val = val + 3;
        }else{
            if (wheel1 < 99){
            fruit1 = "Liberty Bell";
            val = val + 4;
            }else{
                if (wheel1 < 101 + iFudge){
                fruit1 = "Lucky 7";
                val = val + 5;
                }
            }
        }
    }
}
}

if (d6() > 1){
if (wheel2 < 51){
fruit2 = "Lemon";
val = val + 10;
}else{
    if (wheel2 < 76){
    fruit2 = "Cherry";
    val = val + 20;
    }else{
        if (wheel2 < 90){
        fruit2 = "Orange";
        val = val + 30;
        }else{
            if (wheel2 < 99){
            fruit2 = "Liberty Bell";
            val = val + 40;
            }else{
                if (wheel2 < 101 + iFudge){
                fruit2 = "Lucky 7";
                val = val + 50;
                }
            }
        }
    }
}
}

if (d6() > 1){
if (wheel3 < 51){
fruit3 = "Lemon";
val = val + 100;
}else{
    if (wheel3 < 76){
    fruit3 = "Cherry";
    val = val + 200;
    }else{
        if (wheel3 < 90){
        fruit3 = "Orange";
        val = val + 300;
        }else{
            if (wheel3 < 99){
            fruit3 = "Liberty Bell";
            val = val + 400;
            }else{
                if (wheel3 < 101 + iFudge){
                fruit3 = "Lucky 7";
                val = val + 500;
                }
            }
        }
    }
}
}

switch(val){

/*
case XYZ:
X = wheel3
Y = wheel2
Z = wheel1

1 = Lemon
2 = Cherry
3 = Orange
4 = Liberty Bell
5 = Lucky 7

payout = the multiplier

Below are the winning combinations:
*/
case 111:
{
payout = 2;
break;
}

case 222:
{
payout = 5;
break;
}

case 333:
{
payout = 10;
break;
}

case 444:
{
payout = 20;
break;
}

case 555:
{
payout = 100;
break;
}

case 0:
case 112:
case 113:
case 114:
case 115:
case 211:
case 311:
case 411:
case 511:
case 121:
case 131:
case 141:
case 151:
case 110:
case 101:
case 11:
{
payout = 1;
break;
}

case 221:
case 223:
case 224:
case 225:
case 122:
case 322:
case 422:
case 522:
case 212:
case 232:
case 242:
case 252:
case 220:
case 202:
case 22:
{
payout = 2;
break;
}

case 331:
case 332:
case 334:
case 335:
case 133:
case 233:
case 433:
case 533:
case 313:
case 323:
case 343:
case 353:
case 330:
case 303:
case 33:
{
payout = 4;
break;
}

case 441:
case 442:
case 443:
case 445:
case 144:
case 244:
case 344:
case 544:
case 414:
case 424:
case 434:
case 454:
case 440:
case 404:
case 44:
{
payout = 8;
break;
}

case 551:
case 552:
case 553:
case 155:
case 255:
case 355:
case 515:
case 525:
case 535:
case 550:
case 505:
case 55:
{
payout = 10;
break;
}

case 123:
case 132:
case 321:
case 312:
case 231:
case 213:
{
payout = 5;
break;
}

case 545:
case 455:
case 554:
{
payout = 25;
break;
}

}//End Switch

SetCustomToken(90001, "Here is the result: | " + fruit1 + " | " + fruit2 + " | " + fruit3 + " |");

if (payout > 0)
{
SetCustomToken(90002, "Winner paid " + IntToString(bet * payout) + " GP. Play again?");
GiveGoldToCreature(oPC, (bet * payout)); //Pay the (wo)man.
}
else
{
SetCustomToken(90002, "Sorry, you lost. Play again?");
}

return;
} //End main
