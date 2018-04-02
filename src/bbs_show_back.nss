#include "rr_persist"
int StartingConditional()
{
  int PageIndex = GetLocalInt(GetPCSpeaker(), "BBSPageIndex_" + GetTag(OBJECT_SELF));
  if (PageIndex == 0)
    return FALSE;

  return TRUE;
}
