void main()
{
object oCreature = GetEnteringObject();
int nDruid = CLASS_TYPE_DRUID;
int nMonk = CLASS_TYPE_MONK;
int nRogue = CLASS_TYPE_ROGUE;
int nWizard = CLASS_TYPE_WIZARD;
int nSorcerer = CLASS_TYPE_SORCERER;
int nFighter = CLASS_TYPE_FIGHTER;
int nBarbarian = CLASS_TYPE_BARBARIAN;
int nBard = CLASS_TYPE_BARD;
int nCleric = CLASS_TYPE_CLERIC;
int nPaladin = CLASS_TYPE_PALADIN;
int nRanger = CLASS_TYPE_RANGER;
int iStr=GetAbilityScore(oCreature, ABILITY_STRENGTH);
int iDex=GetAbilityScore(oCreature, ABILITY_DEXTERITY);
int iWis=GetAbilityScore(oCreature, ABILITY_WISDOM);
int iInt=GetAbilityScore(oCreature, ABILITY_INTELLIGENCE);
int iCon=GetAbilityScore(oCreature, ABILITY_CONSTITUTION);
int iCha=GetAbilityScore(oCreature, ABILITY_CHARISMA);
string sStr=IntToString(iStr);
string sDex=IntToString(iDex);
string sWis=IntToString(iWis);
string sInt=IntToString(iInt);
string sCon=IntToString(iCon);
string sCha=IntToString(iCha);
int nPrintDruid = GetLevelByClass(nDruid, oCreature);
int nPrintMonk = GetLevelByClass(nMonk, oCreature);
int nPrintRogue = GetLevelByClass(nRogue, oCreature);
int nPrintWizard = GetLevelByClass(nWizard, oCreature);
int nPrintSorcerer = GetLevelByClass(nWizard, oCreature);
int nPrintFighter = GetLevelByClass(nFighter, oCreature);
int nPrintBarbarian = GetLevelByClass(nBarbarian, oCreature);
int nPrintBard = GetLevelByClass(nBard, oCreature);
int nPrintCleric = GetLevelByClass(nCleric, oCreature);
int nPrintPaladin = GetLevelByClass(nPaladin, oCreature);
int nPrintRanger = GetLevelByClass(nRanger, oCreature);
string sDruid = IntToString(nPrintDruid);
string sMonk = IntToString(nPrintMonk);
string sRogue = IntToString(nPrintRogue);
string sWizard = IntToString(nPrintWizard);
string sSorcerer = IntToString(nPrintSorcerer);
string sFighter = IntToString(nPrintFighter);
string sBarbarian = IntToString(nPrintBarbarian);
string sBard = IntToString(nPrintBard);
string sCleric = IntToString(nPrintCleric);
string sPaladin = IntToString(nPrintPaladin);
string sRanger = IntToString(nPrintRanger);
string sName=GetName(oCreature);
SendMessageToAllDMs(sName+"'s Stats: Str:"+sStr+" Dex:"+sDex+" Con:"+sCon+" Int:"+sInt+" Wis:"+sWis+" Cha: "+sCha);
WriteTimestampedLogEntry(sName+"'s Stats: Str:"+sStr+" Dex:"+sDex+" Con:"+sCon+" Int:"+sInt+" Wis:"+sWis+" Cha: "+sCha);
if  (nPrintDruid>0)
  {
 SendMessageToAllDMs(sName+"'s Druid Level: "+sDruid);
 WriteTimestampedLogEntry(sName+"'s Druid Level: "+sDruid);
  }
if (nPrintMonk>0)
{
 SendMessageToAllDMs(sName+"'s Monk Level: "+sMonk);
 WriteTimestampedLogEntry(sName+"'s Monk Level: "+sMonk);
 }
 if (nPrintRogue>0)
{
 SendMessageToAllDMs(sName+"'s Rogue Level: "+sRogue);
 WriteTimestampedLogEntry(sName+"'s Rogue Level: "+sRogue);
 }
 if (nPrintWizard>0)
{
 SendMessageToAllDMs(sName+"'s Wizard Level: "+sWizard);
 WriteTimestampedLogEntry(sName+"'s Wizard Level: "+sWizard);
 }
  if (nPrintSorcerer>0)
{
 SendMessageToAllDMs(sName+"'s Sorcerer Level: "+sSorcerer);
 WriteTimestampedLogEntry(sName+"'s Sorcerer Level: "+sSorcerer);
 }
  if (nPrintFighter>0)
{
 SendMessageToAllDMs(sName+"'s Fighter Level: "+sFighter);
 WriteTimestampedLogEntry(sName+"'s Fighter Level: "+sFighter);
 }
  if (nPrintBarbarian>0)
{
 SendMessageToAllDMs(sName+"'s Barbarian Level: "+sBarbarian);
 WriteTimestampedLogEntry(sName+"'s Barbarian Level: "+sBarbarian);
 }
 if (nPrintBard>0)
{
 SendMessageToAllDMs(sName+"'s Bard Level: "+sBard);
 WriteTimestampedLogEntry(sName+"'s Bard Level: "+sBard);
 }
 if (nPrintCleric>0)
{
 SendMessageToAllDMs(sName+"'s Cleric Level: "+sCleric);
 WriteTimestampedLogEntry(sName+"'s Cleric Level: "+sCleric);
 }
  if (nPrintPaladin>0)
{
 SendMessageToAllDMs(sName+"'s Paladin Level: "+sPaladin);
 WriteTimestampedLogEntry("Paladin Level: "+sPaladin);
 }
 if (nPrintRanger>0)
{
 SendMessageToAllDMs(sName+"'s Ranger Level: "+sRanger);
 WriteTimestampedLogEntry(sName+"'s Ranger Level: "+sRanger);
 }
}

