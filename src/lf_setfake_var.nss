//This assigns a token to the player.

#include "apts_inc_ptok"

void main()
{
    // Set the persistent token variable so quest cannot be repeated
    SetTokenBool(GetPCSpeaker(), "legendfarm", 1);

}
