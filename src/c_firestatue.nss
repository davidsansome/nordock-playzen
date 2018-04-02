void main()
{
        int VFX_EFFECT = VFX_DUR_PARALYZED; //Which VFX to use
        string eVis;
        int nDamage;
        int nToofar;
        nDamage = 0;
        float HOWFAR = 20.0;
        object oPlayer = GetFirstPC();
                 while (oPlayer != OBJECT_INVALID)
    {
          if (oPlayer != OBJECT_INVALID)
         {
          float fDist = GetDistanceToObject(oPlayer);
          if (fDist<HOWFAR)
            {
          if (fDist > 0.0)
                     {
             location lTarget = GetLocation(oPlayer);
             effect eVis = EffectVisualEffect(VFX_EFFECT);
             ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF , 7.);
             //ActionCastSpellAtObject(SPELL_METEOR_SWARM,oPlayer,METAMAGIC_ANY,TRUE,15,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
            //ActionCastFakeSpellAtLocation(SPELL_FLAME_STRIKE,lTarget);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIRESTORM), lTarget);
            ActionDoCommand( PlaySound("mummy_laugh1")  );
//              eVisualImpact = EffectVisualEffect(VFX_COM_HIT_FIRE);
//               ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualImpact, oTarget);
              // damage
              int iDC = 25;               //Difficulty check(reflex save for half damage)
              int iDice = 5;              //Number of Damage Dice to roll
              //effect eDam;
              nDamage = d6(iDice); //size of damage dice rolled 1d6
              nDamage = GetReflexAdjustedDamage(nDamage, oPlayer, iDC, SAVING_THROW_TYPE_FIRE);
              //eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
             if((nDamage > 0) && (oPlayer != OBJECT_INVALID))
                              {
               DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage,DAMAGE_TYPE_FIRE),oPlayer));
            //end damage
                      nDamage = 0;
                              }
                       }
             }
           }
          oPlayer = GetNextPC();
       }
  }



