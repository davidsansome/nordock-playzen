#include "ats_inc_common"
#include "ats_inc_math"

void main()
{
    object oForge = OBJECT_SELF;

    location locForge = GetLocation(oForge);
    vector vAttachmentPos = GetPositionFromLocation(locForge);

    vAttachmentPos.z += 0.5;

    float fDirection = ATS_CorrectDirection(GetFacing(oForge));
    vector vRelativeVector = Vector(0.25, 0.5, 0.0);

    location locAttachment;
    vector vTranslate;
    object oCurrentFlame;

    vTranslate = ATS_Transform2DVector(vRelativeVector, fDirection);
    vAttachmentPos += vTranslate;

    locAttachment = Location( GetAreaFromLocation(locForge), vAttachmentPos,
                              GetFacingFromLocation(locForge) );

    SoundObjectStop(GetNearestObjectByTag("ATS_SOUND_FLAME_MEDIUM", oForge));
    SoundObjectStop(GetNearestObjectByTag("ATS_SOUND_FLAME_LARGE", oForge));

    CreateObject(OBJECT_TYPE_PLACEABLE, "ats_flame_small", locAttachment, TRUE);
    SoundObjectPlay(GetNearestObjectByTag("ATS_SOUND_FLAME_SMALL", oForge));
}

