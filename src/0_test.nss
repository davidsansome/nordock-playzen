#include "0_artifact"

void main()
{
    object oCorpse = GetNearestObjectByTag("TEST_BLOODSTAIN");
    SummonArtifact(oCorpse);
}
