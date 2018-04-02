void main()
{
    //Move delaer to chair object with the tag 'DealerChair' and sit in it.
    AssignCommand(OBJECT_SELF,ActionSit(GetObjectByTag("DealerChair")));
}
