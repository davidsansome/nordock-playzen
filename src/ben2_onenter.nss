void main()
{
object oPC;
effect eEffect;
int nEffectType;
string sText;
oPC = GetEnteringObject();

if (GetIsPC(oPC))
    {
    eEffect = GetFirstEffect(oPC);
    nEffectType = GetEffectType(eEffect);
    while (nEffectType != EFFECT_TYPE_INVALIDEFFECT)
        {
        if (nEffectType = EFFECT_TYPE_INVISIBILITY)
            {
            sText = "A powerful magical energy dispells your invisibility.";
            RemoveEffect(oPC, eEffect);
            SendMessageToPC(oPC, sText);
            }
        eEffect = GetNextEffect(oPC);
        nEffectType = GetEffectType(eEffect);
        }
    }
}
