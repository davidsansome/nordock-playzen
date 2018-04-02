void main()
{
   object oMyActivator = OBJECT_SELF;
   if(GetIsDM(oMyActivator) != TRUE)
   {
      object oTest = GetFirstPC();
      string sTestName = GetPCPlayerName(oMyActivator);
      int nFound = FALSE;
      while (GetIsObjectValid(oTest) && (! nFound))
      {
         if (GetPCPlayerName(oTest) == sTestName)
         {
            if(GetIsDM(oTest))
            {
               nFound = TRUE;
            }
            else
            {
               SendMessageToPC(oMyActivator,"This is too much power for mere mortals!");
               return;
            }
         }
         oTest=GetNextPC();
      }
   }
   // get the wand's activator and target, put target info into local vars on activator
   object oMyTarget;
   SetLocalObject(oMyActivator, "dmwandtarget", oMyTarget);
   location lMyLoc;
   SetLocalLocation(oMyActivator, "dmwandloc", lMyLoc);

   //Make the activator start a conversation with itself
   AssignCommand(oMyActivator, ActionStartConversation(oMyActivator, "dmwand", TRUE));
   return;
}
