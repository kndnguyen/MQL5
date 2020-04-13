// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Shows London, New York, Sydney and Tokyo sessions on the chart
// timginter @ ForexFactory
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#property indicator_chart_window

#property description "Recommended settings (to show all sessions):"
#property description "     London:	Green		|	Days:		92"
#property description "     New York:	SteelBlue	|"
#property description "     Sydney:	FireBrick	|	Style: 		Dot"
#property description "     Tokyo:	Goldenrod	|	Background:	false"
#property description " "
#property description " "
#property description "timginter @ ForexFactory"

input string _00 = "***** Set colour to  None  to disable session";
input color London			=	Green;		// 'Green' recommended, 'CLR_NONE' to disable by default
input color NewYork			=	SteelBlue;	// 'SteelBlue' recommended, 'CLR_NONE' to disable by default
input color Sydney			=	FireBrick;	// 'FireBrick' recommended, 'CLR_NONE' to disable by default
input color Tokyo				=	Goldenrod;	// 'Goldenrod' recommended, 'CLR_NONE' to disable by default
input string _10 = "***** Show/hide session high-low range (in pips)";
input bool ShowRange			=	true;
input string _11 = "***** Max timeframe to draw sessions on";
input ENUM_TIMEFRAMES MaxTF=	PERIOD_H4;
input string _20 = "***** Number of days to draw sessions";
input string _21 = "***** Set to  0  for all sessions (e.g. backtesting)";
input int MaxDays				=	92;			// '92' recommended (roughly 3 months)
input string _30 = "***** Session style";
input ENUM_LINE_STYLE Style=	STYLE_DOT;
input bool Background		=	false;
input string _40 = "***** ***** ***** ***** ***** ***** ***** ***** ***** ***** *****";
input string _41 = "***** Open/Close mods - move session open/close";
input string _42 = "***** Negative numbers: left; positive: right, e.g.";
input string _43 = "***** '4,0' shows 5 last hours (moves open by 4)";
input string _44 = "***** '0,-4' shows 5 first hours (moves close by -4)";
input string LondonMod		=	"0,0";
input string NewYorkMod		=	"0,0";
input string SydneyMod		=	"0,0";
input string TokyoMod		=	"0,0";
input string _45 = "***** If you are unsure leave ALL at '0,0'!";

int days, daysLimit, digits;
double points;
datetime dayTime, LO, NY, SY, TO;
string sLOMod[2], sNYMod[2], sSYMod[2], sTOMod[2];

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
void init()
{
	// do not draw if timeframe is higher than MaxTF input
   if( Period() > MaxTF ){ return; }
   
	datetime brokerDiff, DSTOffset, current, GMT;
	ulong modSep;
	
	// trim broker and GMT times to full hours
	current = MathFloor(TimeCurrent()/3600)*3600;
	GMT = MathFloor(TimeGMT()/3600)*3600;
	
	// calculate DST offset in hours instead of seconds
	DSTOffset = TimeDaylightSavings()/3600;
	// calculate proper difference between GMT time and broker time
	// recycling 'brokerDiff', look at the value, not name (datetime GMT of last Friday, 21:00
	// if GMT time is after Friday, 21:00 or before Sunday 22:00 (market close) - weekend
	if( (TimeDayOfWeek(TimeGMT()) == 5 && TimeHour(TimeGMT()) > 21) || TimeDayOfWeek(TimeGMT()) > 5 || (TimeDayOfWeek(TimeGMT()) == 0 && TimeHour(TimeGMT()) < 22) )
	{	
		// go hour by hour from GMT time now to GMT 21:00 on Friday
		brokerDiff = GMT;
		while( TimeDayOfWeek(brokerDiff) != 5 || TimeHour(brokerDiff) != 21 )
		{
			// count back if broker time is before GMT time
			if( current < GMT ){ brokerDiff -= 3600; }
			// count forward if broker time is ahead of GMT time
			else{ brokerDiff += 3600; }
		}
		// proper brokerDiff is the difference between broker time and GMT time
		brokerDiff = (current - brokerDiff)/3600;
	}
	// Monday - Friday -> easy math
	else
	{
		brokerDiff = (current - GMT)/3600;
	}

	// extract begin and end MOD from string settings
	modSep = StringGetCharacter(",", 0);
	StringSplit(LondonMod, StringGetCharacter(",", 0), sLOMod);
	StringSplit(NewYorkMod, StringGetCharacter(",", 0), sNYMod);
	StringSplit(SydneyMod, StringGetCharacter(",", 0), sSYMod);
	StringSplit(TokyoMod, StringGetCharacter(",", 0), sTOMod);

	// change GMT open hours to broker time hours, convert if passing midnight
	// multiply by the amount of seconds in an hour to convert to datetime format
	LO = ConvertTime(8 + DSTOffset + brokerDiff)*3600;
	NY = ConvertTime(13 + DSTOffset + brokerDiff)*3600;
	SY = ConvertTime(22 + DSTOffset + brokerDiff)*3600;
	TO = ConvertTime(1 + DSTOffset + brokerDiff)*3600;
   
   // calculate days since "the beginning of time" ;) Set MaxDays limit
   days = MathFloor(TimeCurrent()/86400);
   if( MaxDays == 0 ){ daysLimit = 1; }
   else{ daysLimit = days-MaxDays; }

	// adjust for 4- and 5- digits brokers
   digits = MarketInfo(NULL,MODE_DIGITS);
   points = MarketInfo(NULL,MODE_POINT);
   if( digits == 3 || digits == 5 ){ points *= 10; }
   
   // delete all boxes
   deinit();
   
   // draw boxes from today up until the limit
   for( int dayNr = days; dayNr >= daysLimit; dayNr-- )
   {   
   	// convert days into seconds for datetime format
      dayTime = dayNr*86400;
      // stop if day number is greater than days visisble on the whole chart
      if( dayTime < Time[Bars-1] ){ break; }
      // draw only from Sunday until Friday GMT time
      if( TimeDayOfWeek(dayTime-brokerDiff*3600) <= 5 )
      {        
      	// '2147483647' is "None" set in 'Inputs' tab, different from MQL's "CLR_NONE" 
         if( London != CLR_NONE && London != 2147483647 ){ Session("sa_LO_"+dayNr, LO+dayTime, StrToInteger(sLOMod[0]), StrToInteger(sLOMod[1])); }
         if( NewYork != CLR_NONE && NewYork != 2147483647 ){ Session("sa_NY_"+dayNr, NY+dayTime, StrToInteger(sNYMod[0]), StrToInteger(sNYMod[1])); }
         if( Sydney != CLR_NONE && Sydney != 2147483647 ){ Session("sa_SY_"+dayNr, SY+dayTime, StrToInteger(sSYMod[0]), StrToInteger(sSYMod[1])); }
         if( Tokyo != CLR_NONE && Tokyo != 2147483647 ){ Session("sa_TO_"+dayNr, TO+dayTime, StrToInteger(sTOMod[0]), StrToInteger(sTOMod[1])); }
      }
   }
}

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
void start()
{
	// do not draw if timeframe is higher than MaxTF input
   if( Period() > MaxTF ){ return; }
   
   // calculate today's number and convert to seconds for datetime format
   days = MathFloor(TimeCurrent()/86400);
   dayTime = days*86400;
      
   // redraw only the last session
   if( London != CLR_NONE && London != 2147483647 ){ Session("sa_LO_"+days, LO+dayTime, StrToInteger(sLOMod[0]), StrToInteger(sLOMod[1])); }
   if( NewYork != CLR_NONE && NewYork != 2147483647 ){ Session("sa_NY_"+days, NY+dayTime, StrToInteger(sNYMod[0]), StrToInteger(sNYMod[1])); }
   if( Sydney != CLR_NONE && Sydney != 2147483647 ){ Session("sa_SY_"+days, SY+dayTime, StrToInteger(sSYMod[0]), StrToInteger(sSYMod[1])); }
   if( Tokyo != CLR_NONE && Tokyo != 2147483647 ){ Session("sa_TO_"+days, TO+dayTime, StrToInteger(sTOMod[0]), StrToInteger(sTOMod[1])); }
}

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
void deinit()
{ 
	string objName;
	bool reCheck = true;
	
	while( reCheck )
	{
		reCheck = false;
		for( int i = 0; i < ObjectsTotal(); i++ )
		{
			objName = ObjectName(i);
			if( 	StringFind(objName, "sa_LO_") >= 0 || 
					StringFind(objName, "sa_NY_") >= 0 ||
					StringFind(objName, "sa_SY_") >= 0 ||
					StringFind(objName, "sa_TO_") >= 0 )
			{
				reCheck = true;
				ObjectDelete(objName);
			}
		}
	}
}

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
void Session(string id, datetime begin, datetime bMOD, datetime eMOD)
{
   datetime end, rEnd;
   int shiftB, shiftE;
   double high, low;
   color colour;
   bool extend = false;
   
   // calculate end of session in datetime format
   end = begin + 8*3600;
   // add begin and end mods
   begin += bMOD*3600;
   end += eMOD*3600;
   // trim if end is after current time
   if( end > TimeCurrent() ){ end = TimeCurrent(); rEnd = end + 3*Period()*60; }
   else{ rEnd = end; }
   
   // calculate open and close bar shift (from current bar, right to left)
   shiftB = iBarShift(NULL, 0, begin, true);
   shiftE = iBarShift(NULL, 0, end, true);
   if( shiftB < 0 || shiftE < 0 ){ return; }
   
   // calculate session high and low
   high = High[iHighest(NULL, 0, MODE_HIGH, shiftB-shiftE+1, shiftE)];
   low = Low[iLowest(NULL, 0, MODE_LOW, shiftB-shiftE+1, shiftE)];
   
   // get session colour
   if( StringFind(id, "sa_LO_") >= 0 ){ colour = London; }
   else if( StringFind(id, "sa_NY_") >= 0 ){ colour = NewYork; }
   else if( StringFind(id, "sa_SY_") >= 0 ){ colour = Sydney; }
   else if( StringFind(id, "sa_TO_") >= 0 ){ colour = Tokyo; }
   
   // create a box if none found with a specified day-number
   if( ObjectFind(id) < 0 )
   {
      ObjectCreate(id, OBJ_RECTANGLE, 0, 0,0, 0,0);
   }
   ObjectSet(id, OBJPROP_STYLE, Style);
   ObjectSet(id, OBJPROP_COLOR, colour);
   ObjectSet(id, OBJPROP_BACK, Background);
   ObjectSet(id, OBJPROP_TIME1 , begin);
   ObjectSet(id, OBJPROP_PRICE1, high);
   ObjectSet(id, OBJPROP_TIME2 , rEnd);
   ObjectSet(id, OBJPROP_PRICE2, low);
   // show (or not) session range in pips
   if( ShowRange )
   {
   	ObjectSetText(id, DoubleToStr((high-low)/points,0));
   }
}

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
int ConvertTime(datetime time)
{
	// convert numbers if they pass midnight
	if( time < 0 )
	{
		time = 24 + time;
	}
	else if( time > 23 )
	{
		time = time - 24;
	}
	return(time);
}