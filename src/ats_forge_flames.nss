/****************************************************
  Action Taken Script: Forge - Fan Flames
  ats_forge_flames

  Last Updated: July 15, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for fanning the flames
  of the forge and creating the various flame
  animations and sound changes.
****************************************************/

void main()
{
  object oForgeFlame = GetNearestObjectByTag("ATS_FORGE_FLAME");
  object oForgeSound;

  string sFlameResRef;
  string sFlameSoundTag;
  string sFlameName = GetName(oForgeFlame);

  if(sFlameName == "Small Flame")
  {
    sFlameResRef = "ats_flame_med";
    oForgeSound = GetNearestObjectByTag("ATS_SOUND_FLAME_SMALL");
    sFlameSoundTag = "ATS_SOUND_FLAME_MEDIUM";
  }
  else if(sFlameName == "Medium Flame")
  {
    sFlameResRef = "ats_flame_large";
    oForgeSound = GetNearestObjectByTag("ATS_SOUND_FLAME_MEDIUM");
    sFlameSoundTag = "ATS_SOUND_FLAME_LARGE";

  }
  else if(sFlameName == "Large Flame")
  {
    sFlameResRef = "ats_flame_small";
    oForgeSound = GetNearestObjectByTag("ATS_SOUND_FLAME_LARGE");
    sFlameSoundTag = "ATS_SOUND_FLAME_SMALL";
  }

    SoundObjectPlay(GetNearestObjectByTag("ATS_SOUND_BELLOWS"));
    CreateObject(OBJECT_TYPE_PLACEABLE, sFlameResRef, GetLocation(oForgeFlame));
    SetPlaceableIllumination(oForgeFlame, FALSE);
    DestroyObject(oForgeFlame);
    RecomputeStaticLighting(GetArea(OBJECT_SELF));
    SoundObjectPlay(GetNearestObjectByTag(sFlameSoundTag));
    SoundObjectStop(oForgeSound);




}
