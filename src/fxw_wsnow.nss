void main()
{
// Change the module's weather
// nWeatherType = WEATHER_*

   object oMyArea = GetArea(GetLastSpeaker());

   SetWeather(oMyArea, WEATHER_SNOW);
}
