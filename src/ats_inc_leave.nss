void ATS_ClientClose(object oPlayer)
{
    DeleteLocalInt(GetModule(), "ats_refresh_useable_items_" + GetName(oPlayer));
}
