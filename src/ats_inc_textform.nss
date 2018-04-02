/****************************************************
  Text Formatting Include Script
  ats_inc_textform
  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This include script contains various functions for
  formatting text and calculating text width.
****************************************************/

int ATS_GetCharPeriodWidth(string sCharacter)
{
   if(sCharacter == "W")
        return 6;
   else if(sCharacter == "A" || sCharacter == "C" ||
           sCharacter == "D" || sCharacter == "G" || sCharacter == "K" ||
           sCharacter == "L" || sCharacter == "M" || sCharacter == "m" ||
           sCharacter == "N" || sCharacter == "O" || sCharacter == "Q" ||
           sCharacter == "R" || sCharacter == "S" || sCharacter == "U" ||
           sCharacter == "V" || sCharacter == "w" || sCharacter == "Y" )
        return 4;
    else if(sCharacter == "a" || sCharacter == "b" || sCharacter == "c" ||
            sCharacter == "d" || sCharacter == "E" || sCharacter == "e" ||
            sCharacter == "F" || sCharacter == "g" || sCharacter == "H" ||
            sCharacter == "h" || sCharacter == "J" || sCharacter == "k" ||
            sCharacter == "n" || sCharacter == "o" || sCharacter == "P" ||
            sCharacter == "p" || sCharacter == "q" || sCharacter == "s" ||
            sCharacter == "T" || sCharacter == "u" || sCharacter == "v" ||
            sCharacter == "X" || sCharacter == "x" || sCharacter == "y" ||
            sCharacter == "Z" || sCharacter == "z" || sCharacter == "B" )
        return 3;
    else if(sCharacter == "f" || sCharacter == "I" || sCharacter == "j" ||
            sCharacter == "r" || sCharacter == "t" )
        return 2;
    else if(sCharacter == "i" || sCharacter == "l" )
        return 1;
    else
        return 0;

}
// Calculates the width of a string equivalent to some number of periods
int ATS_GetStringPeriodWidth(string sTextString)
{
    int i = 0;
    int iTotalWidth = 0;
    string sChar = GetSubString(sTextString, 0, 1);
    while(sChar != "")
    {
        iTotalWidth += ATS_GetCharPeriodWidth(sChar);
        sChar = GetSubString(sTextString, ++i, 1);
    }
    return iTotalWidth;
}

// Returns a string of iNumber of periods
string ATS_GetPeriodString(int iNumber)
{
    string sRetString = "";
    int i;
    for(i = 0; i < iNumber; ++i)
        sRetString += ".";
    return sRetString;
}


