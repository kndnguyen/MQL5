//+------------------------------------------------------------------+
//|                                             IndicatorLibrary.mq5 |
//|                                                      Khoa Nguyen |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Khoa Nguyen"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include  <KhoaIndicators\IndicatorEnumerations.mqh>

//+------------------------------------------------------------------+
//| Function to set 3 digits or 5 digits depending to Broker
//+------------------------------------------------------------------+
double fn_SetMyPoint() export
{
   double point=Point();
   if(Digits()==3 || Digits()==5){
      //Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 10");
      point=Point()*10;
   }else if(Digits()==2){
      //Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 100");
      point=Point()*100;
   }
   return(point);
}

//+------------------------------------------------------------------+
// Function to check if its a new candle
//+------------------------------------------------------------------+
bool fn_IsNewCandle() export
{
    static int BarsOnChart=0;
    if (Bars(_Symbol,_Period) == BarsOnChart) 
      return (false);
      
    BarsOnChart = Bars(_Symbol,_Period);
        return(true);
}

//+------------------------------------------------------------------+
//| Function to fill fractal buffer
//+------------------------------------------------------------------+
bool fn_FillFractalBuffers(const int currentBar, const int fractalRange, double &fractalH[], double &fractalL[]) export
{
   double highValue, lowValue;
   if(fn_Fractal(fractalRange,PERIOD_CURRENT,currentBar,highValue,lowValue)){
      fractalH[currentBar] = highValue;
      fractalL[currentBar] = lowValue;
   }else{
      fractalH[currentBar] = 0;
      fractalL[currentBar] = 0;
   }
   
   return(true);
}

//+------------------------------------------------------------------+
//| Function to check if current bar is High/Low fractal
//+------------------------------------------------------------------+
bool fn_Fractal(int fractalRange, ENUM_TIMEFRAMES fractal_TimeFrame,int currentBar, double &highestValue, double &lowestValue) export
{
   highestValue = 0;
   lowestValue = 0;
   
   //--- Exit if current bar is less than the range for fractals
   if (currentBar < fractalRange) return(false);
      
   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(),fractal_TimeFrame)-fractalRange)
      return(false); 

   //--- Scan through the fractalRange for Highest and Lowest bar
   int fractal_High = iHighest(NULL,fractal_TimeFrame,MODE_HIGH,fractalRange*2+1,currentBar-fractalRange);
   int fractal_Low = iLowest(NULL,fractal_TimeFrame,MODE_LOW,fractalRange*2+1,currentBar-fractalRange);  
   
   //--- Return highest value if the current bar is high fractal
   if(fractal_High==currentBar){
      highestValue = iHigh(NULL,fractal_TimeFrame,currentBar);
   }
   //--- Return lowest value if the current bar is low fractal
   if(fractal_Low==currentBar){
      lowestValue = iLow(NULL,fractal_TimeFrame,currentBar);
   }

   return(true);   
}

//+------------------------------------------------------------------+
//| Function to setup and return ATR handle
//| To be place at OnInit
//+------------------------------------------------------------------+
int ATRHandle(string symbol=NULL,ENUM_TIMEFRAMES timeframe=PERIOD_CURRENT,int period=7) export
{
   //--- Setup Oscillator Handle
   int IndicatorHandle=iATR(symbol,timeframe,period); 
   //--- if the handle is not created 
   if(IndicatorHandle==INVALID_HANDLE) { 
      //--- tell about the failure and output the error code 
      PrintFormat("Failed to create handle of the ATR indicator for the symbol %s/%s, error code %d", 
                  Symbol(), 
                  EnumToString(PERIOD_CURRENT), 
                  GetLastError()); 
      //--- the indicator is stopped early 
   }
   return IndicatorHandle;   
}

//+------------------------------------------------------------------+
//| Function to setup and return ATR handle
//| To be place at OnInit
//+------------------------------------------------------------------+
double fn_GetBufferCurrentValue(int handle,int currentBar) export
{
   double returnValue=0;
   double targetArray[1];
   
   if(CopyBuffer(handle,0,currentBar,1,targetArray)!=-1)
      returnValue=targetArray[0];

   return returnValue;
}   

//+------------------------------------------------------------------+
//| Functions to detect Reversal bar
//|   Bearish reversal: Higher High + Close at lower half
//|   Bullish reversal: Lower Low + Close at upper half
//+------------------------------------------------------------------+
bool fn_Reversal(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double lipVal, double teethVal, double jawVal, double &highValue, double &lowValue) export
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range) return(false); 

   //--- Scan through the fractalRange for Highest and Lowest bar
   int fractal_High = iHighest(NULL,timeFrame,MODE_HIGH,range*2+1,currentBar-range);
   int fractal_Low = iLowest(NULL,timeFrame,MODE_LOW,range*2+1,currentBar-range);  

   double halfCandle=(High(currentBar)+Low(currentBar))/2;
   
   //--- Bearish patterns
   if(fractal_High==currentBar
      && Close(currentBar)<=halfCandle
      && lipVal>teethVal && teethVal>jawVal
   ){
      result=true;
    }
   if(result){
      highValue=High(currentBar);
      lowValue=0;
      return(true);
   } 

   //--- Bullish patterns
   if(fractal_Low==currentBar
      && Close(currentBar)>=halfCandle
      && lipVal<teethVal && teethVal<jawVal
   ){
      result=true;
    }
   if(result){
      highValue=0;
      lowValue=Low(currentBar);
      return(true);
   } 
 
   //--- Exit if current bar is less than the range for pin bar
   if (currentBar < range)
      return(false);
      
   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   return(result);   
}

//+------------------------------------------------------------------+
//| Functions to detect Pin bar: Shooting Star, Evening Star
//+------------------------------------------------------------------+
bool fn_Pinbar(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double candleWickBodyPct, double &highValue, double &lowValue) export
{
   bool result=false;   
   double bodyHigh, bodyLow;

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   //--- Scan through the fractalRange for Highest and Lowest bar
   int fractal_High = iHighest(NULL,timeFrame,MODE_HIGH,range*2+1,currentBar-range);
   int fractal_Low = iLowest(NULL,timeFrame,MODE_LOW,range*2+1,currentBar-range);  

   if(Open(currentBar)>Close(currentBar)){
      bodyHigh = Open(currentBar);
      bodyLow = Close(currentBar);  
   }else{
      bodyHigh = Close(currentBar);
      bodyLow = Open(currentBar); 
   }
   
   double bodyLength0 = Open(currentBar)-Close(currentBar);
   double bodySize0 = MathAbs(bodyLength0) * candleWickBodyPct;

   double upperWick = High(currentBar)-bodyHigh;
   double lowerWick = bodyLow-Low(currentBar);
 
   //--- Bearish patterns
   //--- Check for Bearish Shooting Star

   //if(High(currentBar)>=High(currentBar+1) && High(currentBar)>High(currentBar+2) && High(currentBar)>High(currentBar+3)) {
   if(fractal_High==currentBar){
      //--- 50% Upper wick > body size
      //--- Open != Close
      if(upperWick*0.5>bodySize0 && bodyLength0!=0){
         //--- Lower wick < 25% Upper wick 
         if(upperWick*0.25>lowerWick){  
            result=true;
         //--- 25% Upper wick < Lower wick < 30% Upper wick             
         }else if(upperWick*0.3>lowerWick && upperWick*0.25<=lowerWick){
            result=true;
         //--- 25% Upper wick < Lower wick < 50% Upper wick
         }else if(upperWick*0.5>lowerWick && upperWick*0.25<=lowerWick ){
            result=true;
         }
      }
      if(result){
         highValue=0;
         lowValue =MathMin(MathMin(Open(currentBar+1),Open(currentBar+1)),Low(currentBar));
         return(true);
      } 
   }

   //--- Bullish patterns
   //--- Check for Bullish Hammer
   //if(Low(currentBar)<=Low(currentBar+1) && Low(currentBar)<Low(currentBar+2) && Low(currentBar)<Low(currentBar+3)) {
   if(fractal_Low==currentBar){
      //--- 50% Upper wick > body size
      //--- Open != Close
      if(lowerWick*0.5>bodySize0 && bodyLength0!=0){
         //--- Lower wick < 25% Upper wick 
         if(lowerWick*0.25>upperWick){  
            result=true;
         //--- 25% Upper wick < Lower wick < 30% Upper wick             
         }else if(lowerWick*0.3>upperWick && lowerWick*0.25<=upperWick){
            result=true;
         //--- 25% Upper wick < Lower wick < 50% Upper wick
         }else if(lowerWick*0.5>upperWick && lowerWick*0.25<=upperWick){
            result=true;
         }
      }
      if(result){
         highValue=MathMax(MathMax(Open(currentBar+1),Open(currentBar+1)),High(currentBar));
         lowValue = 0;
         return(true);
      } 
   }
 
   //--- Exit if current bar is less than the range for pin bar
   if (currentBar < range)
      return(false);
      
   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   return(result);   
}


//+------------------------------------------------------------------+
//| Functions to detect Doji
//+------------------------------------------------------------------+
bool fn_Doji(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double Doji_Star_Ratio, double &highValue, double &lowValue) export
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 


   //--- Bearish patterns
   //--- Check for Evening Doji
   if(High(currentBar)>=High(currentBar+1) && High(currentBar)>High(currentBar+2)) {
      if(   Open(currentBar)==Close(currentBar)
         && High(currentBar)>Low(currentBar)
         && Close(currentBar+1)>Open(currentBar+1)
         && Close(currentBar+2)>Open(currentBar+2)
      ){
         result=true;
      }
      if(result){
         highValue=High(currentBar);
         lowValue =0;
         return(true);
      } 
   }

   //--- Bullish patterns
   //--- Check for Morning Doji
   if(Low(currentBar)<=Low(currentBar+1) && Low(currentBar)<Low(currentBar+2)) {
      if(   Open(currentBar)==Close(currentBar)
         && High(currentBar)>Low(currentBar)
         && Open(currentBar+1)>Close(currentBar+1)
         && Open(currentBar+2)>Close(currentBar+2)
      ){
         result=true;
      }
      if(result){
         highValue=0;
         lowValue =Low(currentBar);
         return(true);
      } 
   }
 
   //--- Exit if current bar is less than the range for pin bar
   if (currentBar < range)
      return(false);
      
   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   return(result);   
}

//+------------------------------------------------------------------+
//| Functions to detect Engulfing/Outside pattern
//+------------------------------------------------------------------+
bool fn_Engulfing(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double &highValue, double &lowValue) export
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   //--- Bearish patterns
   if(Open(currentBar)>Close(currentBar) 
      //&& Open(currentBar+1)>Close(currentBar+1) 
      && Open(currentBar)>=MathMax(Open(currentBar+1),Close(currentBar+1))
      && Close(currentBar)<=MathMin(Open(currentBar+1),Close(currentBar+1))
      && High(currentBar)>=High(currentBar+1)
      && Low(currentBar)<=Low(currentBar+1)
   ){
      result=true;
    }
   if(result){
      highValue=0;
      lowValue =Low(currentBar);
      return(true);
   } 

   //--- Bullish patterns
   if(Open(currentBar)<Close(currentBar)
      //&& Open(currentBar+1)<Close(currentBar+1)  
      && Open(currentBar)<=MathMin(Open(currentBar+1),Close(currentBar+1))
      && Close(currentBar)>=MathMax(Open(currentBar+1),Close(currentBar+1))
      && High(currentBar)>High(currentBar+1)
      && Low(currentBar)<Low(currentBar+1)
   ){
      result=true;
    }
   if(result){
      highValue=High(currentBar);
      lowValue =0;
      return(true);
   } 
 
   //--- Exit if current bar is less than the range for pin bar
   if (currentBar < range)
      return(false);
      
   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   return(result);   
}

//+------------------------------------------------------------------+
//| Functions to detect Harami/Inside pattern
//+------------------------------------------------------------------+
bool fn_Harami(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double &highValue, double &lowValue) export
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   //--- Bearish patterns
   if(Open(currentBar+1)<Close(currentBar+1) 
      && Open(currentBar+1)>=MathMax(Open(currentBar),Close(currentBar))
      && Close(currentBar+1)<=MathMin(Open(currentBar),Close(currentBar))
      && High(currentBar+1)>=High(currentBar)
      && Low(currentBar+1)<=Low(currentBar)
   ){
      result=true;
    }
   if(result){
      highValue=High(currentBar+1);
      lowValue =Low(currentBar+1);
      return(true);
   } 

   //--- Bullish patterns
   if(Open(currentBar)>Close(currentBar)
      && Open(currentBar+1)<=MathMin(Open(currentBar),Close(currentBar))
      && Close(currentBar+1)>=MathMax(Open(currentBar),Close(currentBar))
      && High(currentBar+1)>High(currentBar)
      && Low(currentBar+1)<Low(currentBar)
   ){
      result=true;
    }
   if(result){
      highValue=High(currentBar+1);
      lowValue =Low(currentBar+1);
      return(true);
   } 
 
   //--- Exit if current bar is less than the range for pin bar
   if (currentBar < range)
      return(false);
      
   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   return(result);   
}

//+------------------------------------------------------------------+
//| Function to round to nearest number
//+------------------------------------------------------------------+
double fn_RoundNearest(double frmValue, double toValue) export
{
   return toValue * MathRound(frmValue / toValue); 
}

//+------------------------------------------------------------------+
//| Function to display Timer count down
//+------------------------------------------------------------------+
void fn_ShowCounter(int LoacalToServerTime) export
{ 
   int   fontSize=8;
   string myFont="Calibri";
   color myColor=clrGold;
   string myLabel = "Counter_";
   
   int   iX=0;
   int   iY=0;

   datetime serverTime  = TimeLocal() + LoacalToServerTime;
   string myText =  TimeToString(Time(0) + PeriodSeconds() - serverTime, TIME_SECONDS);

   ChartTimePriceToXY(0,0,Time(0)+PeriodSeconds(),Ask,iX,iY);
   iX = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0)-iX;
   iY = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0)-iY;
   fn_DisplayLabel(myLabel,myText,iX,iY,fontSize,myFont,myColor,2);
}

//+------------------------------------------------------------------+
//| Function to return Trading session start time
//+------------------------------------------------------------------+
bool fn_SessionStartTime(datetime& brokerDiffTime,datetime& SydneyStart,datetime& TokyoStart,datetime& LondonStart,datetime& NewYorkStart) export
{ 
	// Do not draw if timeframe is higher than H4
   if( Period() > PERIOD_H4 ){ return(false); }
   
	datetime DSTOffsetTime, currentTime, GMTTime;
   
	//--- Trim broker and GMT times to full hours
	currentTime = MathFloor(TimeCurrent()/3600)*3600;
	GMTTime = MathFloor(TimeGMT()/3600)*3600;
	
	//--- Calculate DaylightSaving in hours instead of seconds
	DSTOffsetTime = TimeDaylightSavings()/3600;
	
	//--- Calculate proper difference between GMT time and broker time.
	//--- If GMT time is after Friday, 21:00 or before Sunday 22:00 (market close) - weekend
	if( (fn_DayOfWeek(TimeGMT()) == 5 && fn_HourOfDay(TimeGMT()) > 21) 
	     || fn_DayOfWeek(TimeGMT()) > 5 
	     || (fn_DayOfWeek(TimeGMT()) == 0 && fn_HourOfDay(TimeGMT()) < 22) 
   ){	
		//--- Go hour by hour from GMT time now to GMT 21:00 on Friday
		brokerDiffTime = GMTTime;
		while( fn_DayOfWeek(brokerDiffTime) != 5 || fn_HourOfDay(brokerDiffTime) != 21 )
		{
			//--- Count back if broker time is before GMT time
			if( currentTime < GMTTime ){ brokerDiffTime -= 3600; }
			//--- Count forward if broker time is ahead of GMT time
			else{ brokerDiffTime += 3600; }
		}
		//--- Proper brokerDiffTime is the difference between broker time and GMT time
		brokerDiffTime = (currentTime - brokerDiffTime)/3600;
	}
	// Monday - Friday -> easy math
	else
	{
		brokerDiffTime = (currentTime - GMTTime)/3600;
	}

	//Change GMT open hours to broker time hours, convert if passing midnight multiply by the amount of seconds in an hour to convert to datetime format
   //Sydney Open	10PM GMT (summer) / 9PM GMT (winter)
   //Sydney Close	 7AM GMT (summer) / 6AM GMT (winter)
   //Tokyo Open	11PM GMT (summer) / 11PM GMT (winter)
   //Tokyo Close	 7AM GMT (summer) /  7AM GMT (winter)
   //London Open	7AM GMT (summer) / 8AM GMT (winter)
   //London Close	4PM GMT (summer) /  PM GMT (winter)
   //NY Open	12PM GMT (summer) /  1PM GMT (winter)
   //NY Close	 9PM GMT (summer) / 10PM GMT (winter)
	SydneyStart = fn_ConvertTime(22 + DSTOffsetTime + brokerDiffTime)*3600;
	TokyoStart = fn_ConvertTime(23 + DSTOffsetTime + brokerDiffTime)*3600;
	LondonStart = fn_ConvertTime(7 + DSTOffsetTime + brokerDiffTime)*3600;
	NewYorkStart = fn_ConvertTime(12 + DSTOffsetTime + brokerDiffTime)*3600;
	
	return (true);
}

//+------------------------------------------------------------------+
//| Function to convert time if they past midnight
//+------------------------------------------------------------------+
int fn_ConvertTime(datetime time)
{
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

//+------------------------------------------------------------------+
//| Function return day of week
//+------------------------------------------------------------------+
int fn_DayOfWeek(datetime time) export
{
   MqlDateTime structTime;
   TimeToStruct(time,structTime);
   return structTime.day_of_week;
}

//+------------------------------------------------------------------+
//| Function return hour of the day
//+------------------------------------------------------------------+
int fn_HourOfDay(datetime time) export
{
   MqlDateTime structTime;
   TimeToStruct(time,structTime);
   return structTime.hour;
}


//+------------------------------------------------------------------+
//| Function to check for server connection
//+------------------------------------------------------------------+
bool fn_SendNotification(string myText,bool printLog,bool sendAlert,bool sendPushNotification) export
{   
   if(sendAlert){
      Alert(Symbol(),"-",myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(printLog){
      Print(myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(sendPushNotification)
      SendNotification(Symbol()+"-"+myText);
   
   return(true);
}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| Following sections define functions related to graphical
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Function to remove objects
//+------------------------------------------------------------------+
bool fn_RemoveObjects(string objName) export
{
   for(int iObj=ObjectsTotal(0,-1,-1)-1; iObj>=0; iObj--){
      string oFullName=ObjectName(0,iObj,-1,-1);
      if(StringFind(oFullName,objName)>=0){
         ObjectDelete(0,oFullName);
      }
   }
   
   return(true);   
}

//+------------------------------------------------------------------+
//| Function to draw trendline
//+------------------------------------------------------------------+
void fn_DrawTrendLine(string objName,int objWindow,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objRayRight,bool objRayLeft) export
{
   //Print("objName:",objName,"-objTime1:",objTime1,"-objTime2:",objTime2);
   ObjectCreate(0,objName,OBJ_TREND,objWindow,objTime1,objPrice1,objTime2,objPrice2);
   ObjectSetInteger(0,objName,OBJPROP_COLOR,objColor);
   ObjectSetInteger(0,objName,OBJPROP_WIDTH,objWidth);
   ObjectSetInteger(0,objName,OBJPROP_STYLE,objStyle);
   ObjectSetInteger(0,objName,OBJPROP_RAY_RIGHT,objRayRight);
   ObjectSetInteger(0,objName,OBJPROP_RAY_LEFT,objRayLeft);   
   ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false);
   //ObjectSetInteger(0,objName,OBJPROP_HIDDEN,false);
   return;
}

//+------------------------------------------------------------------+
//| Function to draw rectangle
//+------------------------------------------------------------------+
void fn_DrawRectangle(string objName,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objBackground) export
{
   ObjectCreate(0,objName,OBJ_RECTANGLE,0,objTime1,objPrice1,objTime2,objPrice2);
   ObjectSetInteger(0,objName,OBJPROP_COLOR,objColor);
   ObjectSetInteger(0,objName,OBJPROP_WIDTH,objWidth);
   ObjectSetInteger(0,objName,OBJPROP_STYLE,objStyle);
   ObjectSetInteger(0,objName,OBJPROP_FILL,objBackground); 
   ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,objName,OBJPROP_BACK,true); 
   return;
}


//+------------------------------------------------------------------+
//| Function to create label objects on chart
//+------------------------------------------------------------------+
void fn_DisplayLabel(string objName,string objText,int iX,int iY,int fontSize,string fontName,color fontColor,ENUM_BASE_CORNER objLabelCorner) export
{
   ObjectCreate(0,objName,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,objName,OBJPROP_CORNER,objLabelCorner);
   ObjectSetInteger(0,objName,OBJPROP_XDISTANCE,iX);
   ObjectSetInteger(0,objName,OBJPROP_YDISTANCE,iY);
   ObjectSetString(0,objName,OBJPROP_TEXT,objText);
   ObjectSetString(0,objName,OBJPROP_FONT,fontName); 
   ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,fontSize); 
   ObjectSetInteger(0,objName,OBJPROP_COLOR,fontColor); 
}

//+------------------------------------------------------------------+
//| Function to move label objects on chart
//+------------------------------------------------------------------+
void fn_MoveLabel(string objName,string objText,int iX,int iY,int fontSize,string fontName,color fontColor,ENUM_BASE_CORNER objLabelCorner) export
{
   ObjectSetInteger(0,objName,OBJPROP_XDISTANCE,iX);
   ObjectSetInteger(0,objName,OBJPROP_YDISTANCE,iY);
   ObjectSetString(0,objName,OBJPROP_TEXT,objText);
   ObjectSetString(0,objName,OBJPROP_FONT,fontName); 
   ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,fontSize); 
   ObjectSetInteger(0,objName,OBJPROP_COLOR,fontColor); 
}

//+------------------------------------------------------------------+
//| Function to display text label
//+------------------------------------------------------------------+
void fn_DisplayText(string objName, datetime time, double priceLevel,ENUM_ANCHOR_POINT anchor,double angle, int fontSize, string fontName,color fontColor, string content) export
{
   ObjectCreate(0,objName,OBJ_TEXT,0,time,priceLevel);
   ObjectSetString(0,objName,OBJPROP_TEXT,content);  
   ObjectSetInteger(0,objName,OBJPROP_ANCHOR,anchor);
   ObjectSetDouble(0,objName,OBJPROP_ANGLE,angle);
   ObjectSetString(0,objName,OBJPROP_FONT,fontName); 
   ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,fontSize); 
   ObjectSetInteger(0,objName,OBJPROP_COLOR,fontColor);    
   ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false);
   return;
}

//+------------------------------------------------------------------+
//| Function to move text label
//+------------------------------------------------------------------+
void fn_MoveText(string objName, datetime time, double priceLevel, int fontSize, string fontName,color fontColor, string content) export
{
   ObjectMove(0,objName,0,time,priceLevel);
   ObjectSetString(0,objName,OBJPROP_TEXT,content);  
   ObjectSetString(0,objName,OBJPROP_FONT,fontName); 
   ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,fontSize); 
   ObjectSetInteger(0,objName,OBJPROP_COLOR,fontColor);    
   ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false);
   return;
}


//+------------------------------------------------------------------+
