//+------------------------------------------------------------------+
//|                                              SessionBreakout.mq5 |
//|                                                      Khoa Nguyen |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      "https://www.mql5.com"
#property version   "1.00"

//+------------------------------------------------------------------+
//| Include and Import sections
//+------------------------------------------------------------------+
#include  <KhoaIndicators\IndicatorEnumerations.mqh>

#import "IndicatorLibrary.ex5"
bool fn_RemoveObjects(string objName);
void fn_DrawRectangle(string objName,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objBackground);
void fn_DisplayText(string objName, datetime time, double priceLevel,ENUM_ANCHOR_POINT anchor,double angle, int fontSize, string fontName,color fontColor, string content);
bool fn_SessionStartTime(datetime& brokerDiffTime,datetime& SydneyStart,datetime& TokyoStart,datetime& LondonStart,datetime& NewYorkStart);
int fn_DayOfWeek(datetime time);
#import

//+------------------------------------------------------------------+
//| Structure declaration
//+------------------------------------------------------------------+
struct SessionStruct
{
   string   ssName;
   datetime ssStartHour;
   datetime ssStart;
   datetime ssEnd;
   double   ssHigh;
   double   ssLow;
   double   ssRange;
   color    ssColor;
};

//+------------------------------------------------------------------+
//| Indicator Properties
//+------------------------------------------------------------------+
#property strict
#property indicator_chart_window
#property indicator_buffers 0
#property indicator_plots   0



//+------------------------------------------------------------------+
//| Indicator Inputs
//+------------------------------------------------------------------+
input string  TRADE_SESSION         = "==========TRADING SESSIONS==========";
input bool     showSydney           = true;           //Show Sydney Sessiom
input color    colorSydney          = clrYellow;
input bool     showTokyo            = true;           //Show Tokyo Sessiom
input color    colorTokyo           = clrRed;
input bool     showLondon           = false;           //Show London Sessiom
input color    colorLondon          = clrDarkBlue;
input bool     showNewYork          = false;           //Show NewYork Sessiom
input color    colorNewYork         = clrCornflowerBlue;

//+------------------------------------------------------------------+
//| Indicator Variables
//+------------------------------------------------------------------+
int      ExtBegin=0;          //To define a bar to perform calculation from
int      NumberOfBars=5000;   //Number of bars
int      checkBarsCalc=0;     //Number of bars required for calculation

//--- Variable for drawing Trading Session
SessionStruct SYD, TKY, LDN, NYC;

#define  maxSession 365;
datetime brokerDiffTime;
datetime SYD_StartHour,TKY_StartHour,LDN_StartHour,NYC_StartHour;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   fn_RemoveObjects("SS_");
   SetPropertiesIndicator();
//---
return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   fn_RemoveObjects("SS_");   
   return;
}


//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
//---
   //--- Revert access to array
   ArraySetAsSeries(time,true);
   //ArraySetAsSeries(open,true);
   ArraySetAsSeries(high,true);
   ArraySetAsSeries(low,true);
   //ArraySetAsSeries(close,true);
   //ArraySetAsSeries(tick_volume,true);
   //ArraySetAsSeries(volume,true);
   //ArraySetAsSeries(spread,true);

   //--- Disable calculation on each tick
   if(prev_calculated==rates_total || Period() > PERIOD_H4) {
      return(rates_total);
   }

   //--- If this is the first calculation
   if(prev_calculated==0) {
      //--- Reset indicator buffers
      ZeroIndicatorBuffers();
      //--- Reset variables
      ZeroTemporaryVariables();
      //--- Check the amount of available data
      if(!CheckDataAvailable()) return(0);
      //--- If more data specified for copying, the current amount is used
      DetermineNumberData();
      //--- Define the bar plotting for each symbol starts from
      DetermineBeginForCalculate(rates_total);
        
   } else {
      //--- Calculate the last value only
      ExtBegin=MathMax(rates_total-prev_calculated,1);      
   }  

   //--- Draw sessions from current datetime
   for(int currentBar=ExtBegin; currentBar>0; currentBar--){   
      if(showSydney) ShowSession(currentBar,SYD,brokerDiffTime,time,high,low);
      if(showTokyo) ShowSession(currentBar,TKY,brokerDiffTime,time,high,low);
      if(showLondon) ShowSession(currentBar,LDN,brokerDiffTime,time,high,low);
      if(showNewYork) ShowSession(currentBar,NYC,brokerDiffTime,time,high,low);
   }
   
   //--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
//---

}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
//---

}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Function to draw trading sessions
//+------------------------------------------------------------------+
void ShowSession(int currentBar
                 ,SessionStruct &currentSession
                 ,const datetime brokerDiffTime
                 ,const datetime &time[]
                 ,const double &high[]
                 ,const double &low[]
                 )
{
int currentDay, currentTime;
//datetime sessionStart;
int sessionBeginBar, sessionEndBar;
double sessionHigh, sessionLow;
string objName, lblName, lblDescription;

	//--- Do not draw if timeframe is higher than MaxTF input
   if(Period() > PERIOD_H4) return;

   //--- Calculate today's number and convert to seconds for datetime format
   currentDay = MathFloor(time[currentBar]/86400);
   currentTime = currentDay*86400;
   
   //--- calculate end of session in datetime format
   currentSession.ssStart = currentTime + currentSession.ssStartHour;
   currentSession.ssEnd = currentSession.ssStart + 8*3600;
   
   //--- Draw only from Sunday until Friday GMT time
   if(fn_DayOfWeek(currentTime-brokerDiffTime*3600) <= 5){   
      // Trim if end is after current time
      if( currentSession.ssEnd > TimeCurrent() ){ 
         currentSession.ssEnd = TimeCurrent(); 
      }
      // Calculate open and close bar shift (from current bar, right to left)
      sessionBeginBar = iBarShift(NULL,0,currentSession.ssStart, true);
      sessionEndBar = iBarShift(NULL, 0, currentSession.ssEnd, true);
      if( sessionBeginBar < 0 || sessionEndBar < 0 ) return;

      // calculate session high and low
      currentSession.ssHigh = high[iHighest(NULL,0,MODE_HIGH,sessionBeginBar-sessionEndBar+1,sessionEndBar)];
      currentSession.ssLow = low[iLowest(NULL,0,MODE_LOW,sessionBeginBar-sessionEndBar+1,sessionEndBar)];
      currentSession.ssRange = (currentSession.ssHigh - currentSession.ssLow)/myPoint;
      
      objName = "SS_" + currentSession.ssName + "_" + TimeToString(currentSession.ssStart);
      //fn_RemoveObjects(objName);
      //--- For each rectangle object, remove then draw again
      fn_DrawRectangle(objName,currentSession.ssStart,currentSession.ssEnd,currentSession.ssHigh,currentSession.ssLow,currentSession.ssColor,1,STYLE_DOT,false);
   
      lblName = "SS_" + currentSession.ssName + "_T_" + TimeToString(currentSession.ssStart);
      lblDescription = currentSession.ssName + ":" + IntegerToString(currentSession.ssRange) + " pips";
      //--- For each label object, if already there then move
      fn_DisplayText(lblName,currentSession.ssStart,currentSession.ssHigh,ANCHOR_LEFT_UPPER,0,10,"Calibri",currentSession.ssColor,lblDescription);
      
   }     

   return;
}
//--- End Session


//+------------------------------------------------------------------+
//| Set the indicator properties                                     |
//+------------------------------------------------------------------+
void SetPropertiesIndicator(void) {
   //--- Set a short name
   IndicatorSetString(INDICATOR_SHORTNAME, "Session Breakout");

   //--- Set a number of decimal places
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   
   //--- Get session start hour of the day
   if(!fn_SessionStartTime(brokerDiffTime,SYD.ssStartHour,TKY.ssStartHour,LDN.ssStartHour,NYC.ssStartHour)) return;    
   
   SYD.ssName = "SYD";
   SYD.ssColor = colorSydney;
   TKY.ssName = "TKY";
   TKY.ssColor = colorTokyo;
   LDN.ssName = "LDN";
   LDN.ssColor = colorLondon;
   NYC.ssName = "NYC";
   NYC.ssColor = colorNewYork;
     
}

//+------------------------------------------------------------------+
//| Reset temporary variables
//+------------------------------------------------------------------+
void ZeroTemporaryVariables(void)
{

}

//+------------------------------------------------------------------+
//| Reset the indicator buffers                                      |
//+------------------------------------------------------------------+
void ZeroIndicatorBuffers(void)
{

}

//+------------------------------------------------------------------+
//| Check the amount of available data for all symbols               |
//+------------------------------------------------------------------+
bool CheckDataAvailable(void) {
//--- Reset the last error in memory
   ResetLastError();
//--- Get the number of bars on the current timeframe
   checkBarsCalc=TerminalInfoInteger(TERMINAL_MAXBARS);
//--- Try again in case of a data retrieval error
   if(checkBarsCalc<=0)
      return(false);
//---
   return(true);
}

//+------------------------------------------------------------------+
//| Define the number of bars to display                            |
//+------------------------------------------------------------------+
void DetermineNumberData(void) {
//--- If not all bars are needed
   if(NumberOfBars>0) {
      //--- If specified more than the current amount, inform of that
      if(NumberOfBars>checkBarsCalc)
         printf("%s: Not enough data to calculate! NumberOfBars: %d; Indicator data: %d",_Symbol, NumberOfBars, checkBarsCalc);
      else
         checkBarsCalc=NumberOfBars;
   }
}

//+------------------------------------------------------------------+
//| Define the index of the first bar to plot                        |
//+------------------------------------------------------------------+
void DetermineBeginForCalculate(const int rates_total) {
   //--- If there is more indicator data than there is on the current symbol, then plot from the first one available on the current symbol
   if(checkBarsCalc>rates_total)
      ExtBegin=rates_total-1;
   else
      ExtBegin=checkBarsCalc-1;
}