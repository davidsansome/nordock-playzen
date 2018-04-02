#include "rr_persist"
int StartingConditional()
{
  object oBBS = GetLocalObject(GetModule(), "BBS_" + GetTag(OBJECT_SELF));
  int PageSize = GPI(oBBS, "PageSize"  + GetTag(OBJECT_SELF));
  int PageIndex = GetLocalInt(GetPCSpeaker(), "BBSPageIndex_" + GetTag(OBJECT_SELF));
  int TotalItems = GPI(oBBS, "TotalItems"  + GetTag(OBJECT_SELF));
  if (TotalItems > (PageIndex + 1) * PageSize) {
    return TRUE;
  }
  return FALSE;
}
