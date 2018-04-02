// This script will destroy the corpse after
// the timer expires.

void main()
{
int i = GetLocalInt(OBJECT_SELF,"counter");

//Minutes to decay (must be >= 1)
int timer = 700;

if (--i <= 0)
DestroyObject(OBJECT_SELF);
else
SetLocalInt(OBJECT_SELF,"counter",i);
}
