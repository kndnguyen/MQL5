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
   double myPoint=Point();
   if(Digits()==3 || Digits()==5){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 10");
      myPoint=Point()*10;
   }else if(Digits()==2){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 100");
      myPoint=Point()*100;
   }
   return(myPoint);
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

   
   ChartTimePriceToXY(0,0,Time(0)+PeriodSeconds(PERIOD_CURRENT),Ask,iX,iY);

   fn_DisplayLabel(myLabel,myText,iX,ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0)-iY,fontSize,myFont,myColor,2);
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
   for(int iObj=ObjectsTotal(0,0,-1)-1; iObj>=0; iObj--){
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
void fn_DrawTrendLine(string objName,int objWindow,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objRay) export
{
   //Print("objName:",objName,"-objTime1:",objTime1,"-objTime2:",objTime2);
   ObjectCreate(0,objName,OBJ_TREND,objWindow,objTime1,objPrice1,objTime2,objPrice2);
   ObjectSetInteger(0,objName,OBJPROP_COLOR,objColor);
   ObjectSetInteger(0,objName,OBJPROP_WIDTH,objWidth);
   ObjectSetInteger(0,objName,OBJPROP_STYLE,objStyle);
   ObjectSetInteger(0,objName,OBJPROP_RAY,objRay);
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
   ObjectSetInteger(0,objName,OBJPROP_BACK,objBackground); 
   ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false);
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
