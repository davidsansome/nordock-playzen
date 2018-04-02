// rr_persist - written Jan 28, 2003 by Marc Richter
// This script is a "wrapper" for whatever persistant database system
// that you may settle on. It was initially written to provide a plug-in
// point for the conversion to Sam's Auto Persistant System

// SPI - Set Persistent Int. Pass the object, name of the variable and the
// value.
void SPI (object pObject, string pName, int pValue);

// GPI - Get Persistent Int. Pass the object, name of the variable. Function returns value.
int GPI (object pObject, string pName);

#include "aps_include"

// Check database connection

int CheckODBC()
{
//    SSetPersistentInt(GetModule(),"odbc_test",TRUE);
    return TRUE;
}

// SPI - Set Persistent Int. Pass the object, name of the variable and the
// value.
void SPI (object pObject, string pName, int pValue)
{
    SSetPersistentInt(pObject, pName, pValue, 0, "nordock_db");
//    SetCampaignInt("nordock_db", pName, pValue, pObject);
}

// SPF - Set Persistent Float. Pass the object, name of the variable and the
// value.

void SPF (object pObject, string pName, float pValue)
{
    SSetPersistentFloat(pObject, pName, pValue, 0, "nordock_db");
//    SetCampaignFloat("nordock_db", pName, pValue, pObject);
}

// SPStr - Set Peristent String. Pass the object, name of the variable and the
// value.

void SPStr (object pObject, string pName, string pValue)
{
    SSetPersistentString(pObject, pName, pValue, 0, "nordock_db");
//    SetCampaignString("nordock_db", pName, pValue, pObject);
}

// SPLoc - Set Peristent Location. Pass the object, name of the variable and the
// value.

void SPLoc (object pObject, string pName, location pValue)
{
    SSetPersistentLocation(pObject, pName, pValue, 0, "nordock_db");
//    SetCampaignLocation("nordock_db", pName, pValue, pObject);
}

// GPI - Get Persistent Int. Pass the object, name of the variable. Function returns value.
int GPI (object pObject, string pName)
{
    return GGetPersistentInt(pObject, pName, "nordock_db");
//    return GetCampaignInt("nordock_db", pName, pObject);
}

// GPF - Get Persistent Float. Pass the object, name of the variable. Function returns value.

float GPF (object pObject, string pName)
{
    return GGetPersistentFloat(pObject, pName, "nordock_db");
//    return GetCampaignFloat("nordock_db", pName, pObject);
}

// GPStr - Get Peristent String. Pass the object, name of the variable. Function returns value.

string GPStr (object pObject, string pName)
{
    return GGetPersistentString(pObject, pName, "nordock_db");
//    return GetCampaignString("nordock_db", pName, pObject);
}

// GPLoc - Get Peristent Location. Pass the object, name of the variable. Function returns value.

location GPLoc (object pObject, string pName)
{
    return GGetPersistentLocation(pObject, pName, "nordock_db");
//    return GetCampaignLocation("nordock_db", pName, pObject);
}

// DPV - Delete Persistent Var

void DPV(object pObject, string pName)
{
    DeletePersistentVariable(pObject, pName, "nordock_db");
//    DeleteCampaignVariable("nordock_db", pName, pObject);
}
