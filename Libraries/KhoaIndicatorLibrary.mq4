//+------------------------------------------------------------------+
//|                                                  KhoaLibrary.mq4 |
//|                                                      Khoa Nguyen |
//|                                                                  |
//+------------------------------------------------------------------+
#property library
#property copyright "Khoa Nguyen"
#property version   "1.70"

//+------------------------------------------------------------------+
//| Enumeration and definitions
//+------------------------------------------------------------------+
enum ORDER_TYPE
{
   BUY_ORDER=1,
   SELL_ORDER=-1,
   NO_ORDER=0,
};

enum TRADE_DIRECTION {
   LONG=1,
   SHORT=-1,
   BOTH=0,
};

enum ENTRY_TYPE
{
   IMMEDIATE=0,
   PENDING_STOP=1,
   PENDING_LIMIT=2,
};


//+------------------------------------------------------------------------------------------------------------------------------------+
//| SETUP FUNCTIONS
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Function to set 3 digits or 5 digits depending to Broker
//+------------------------------------------------------------------+
double fn_SetMyPoint()
{
   double myPoint=Point();
   if(Digits()==3 || Digits()==5){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 10");
      myPoint=Point()*10;
   }else if(Digits==2){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 100");
      myPoint=Point()*100;
   }
   return(myPoint);
}

//+------------------------------------------------------------------+
//| Function to return an array containing Pip Value | Spreads in pips | Min Stop Loss in pips 
//| 26/08/2019: Implementation
//+------------------------------------------------------------------+
bool fn_GetMarketInfo(double &marketInfo[],double lotSize)
{
   if(Digits()==3 || Digits()==5){
      //Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Values of Pip values, MIN SL [pips] and SPREAD [pips] will be devided by 10");
      marketInfo[0]  = MarketInfo(Symbol(),MODE_TICKVALUE)*0.1*(lotSize/0.01);            //Pip value: Value of a pip based on standard 0.01 lotSize      
      marketInfo[1]  = MarketInfo(Symbol(),MODE_SPREAD)*0.1;                              //Broker spread in pips
      marketInfo[2]  = MarketInfo(Symbol(),MODE_STOPLEVEL)*0.1;                           //Broker minimum StopLoss in pips
   }else if(Digits==2){
      //Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Values of Pip values, MIN SL [pips] and SPREAD [pips] will be devided by 100");
      marketInfo[0]  = MarketInfo(Symbol(),MODE_TICKVALUE)*0.01*(lotSize/0.01);            //Pip value: Value of a pip based on standard 0.01 lotSize      
      marketInfo[1]  = MarketInfo(Symbol(),MODE_SPREAD)*0.01;                              //Broker spread in pips
      marketInfo[2]  = MarketInfo(Symbol(),MODE_STOPLEVEL)*0.01;                           //Broker minimum StopLoss in pips
   }
   return(true);
}


//+------------------------------------------------------------------+
// Function to check if its a new candle
//+------------------------------------------------------------------+
bool fn_IsNewCandle()
{
   static int BarsOnChart=0;
	if (Bars == BarsOnChart)
	return (false);
	BarsOnChart = Bars;
	return(true);
}

//+------------------------------------------------------------------+
//| Function to generate Magic Number
//+------------------------------------------------------------------+
int fn_GenerateMagicNumber(int trial)
{
   int result=0; 
   result = MathRand();
   
   while(trial<=10){
      for(int i=0;i<OrdersTotal();i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderCloseTime()==0 && OrderMagicNumber()==result){
               result = MathRand();
            }
         }
      }
      trial++;
   }
   return result;
}

//+------------------------------------------------------------------------------------------------------------------------------------+
//| UTILITIES FUNCTIONS
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Function to check if current bar is High/Low fractal
//+------------------------------------------------------------------+
bool fn_Fractal(int fractalRange, ENUM_TIMEFRAMES fractal_TimeFrame,int currentBar, double &highestValue, double &lowestValue)
{
   highestValue = 0;
   lowestValue = 0;
   
   //--- Exit if current bar is less than the range for fractals
   if (currentBar < fractalRange) return(false);
      
   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), fractal_TimeFrame)-fractalRange)
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
bool fn_Reversal(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double lipVal, double teethVal, double jawVal, double &highValue, double &lowValue)
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range) return(false); 

   //--- Scan through the fractalRange for Highest and Lowest bar
   int fractal_High = iHighest(NULL,timeFrame,MODE_HIGH,range*2+1,currentBar-range);
   int fractal_Low = iLowest(NULL,timeFrame,MODE_LOW,range*2+1,currentBar-range);  

   double halfCandle=(High[currentBar]+Low[currentBar])/2;
   
   //--- Bearish patterns
   if(fractal_High==currentBar
      && Close[currentBar]<=halfCandle
      && lipVal>teethVal && teethVal>jawVal
   ){
      result=true;
    }
   if(result){
      highValue=High[currentBar];
      lowValue=0;
      return(true);
   } 

   //--- Bullish patterns
   if(fractal_Low==currentBar
      && Close[currentBar]>=halfCandle
      && lipVal<teethVal && teethVal<jawVal
   ){
      result=true;
    }
   if(result){
      highValue=0;
      lowValue=Low[currentBar];
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
bool fn_Pinbar(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double candleWickBodyPct, double &highValue, double &lowValue)
{
   bool result=false;   
   double bodyHigh, bodyLow;

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   //--- Scan through the fractalRange for Highest and Lowest bar
   int fractal_High = iHighest(NULL,timeFrame,MODE_HIGH,range*2+1,currentBar-range);
   int fractal_Low = iLowest(NULL,timeFrame,MODE_LOW,range*2+1,currentBar-range);  

   if(Open[currentBar]>Close[currentBar]){
      bodyHigh = Open[currentBar];
      bodyLow = Close[currentBar];  
   }else{
      bodyHigh = Close[currentBar];
      bodyLow = Open[currentBar]; 
   }
   
   double bodyLength0 = Open[currentBar]-Close[currentBar];
   double bodySize0 = MathAbs(bodyLength0) * candleWickBodyPct;

   double upperWick = High[currentBar]-bodyHigh;
   double lowerWick = bodyLow-Low[currentBar];
 
   //--- Bearish patterns
   //--- Check for Bearish Shooting Star

   //if(High[currentBar]>=High[currentBar+1] && High[currentBar]>High[currentBar+2] && High[currentBar]>High[currentBar+3]) {
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
         lowValue =MathMin(MathMin(Open[currentBar+1],Open[currentBar+1]),Low[currentBar]);
         return(true);
      } 
   }

   //--- Bullish patterns
   //--- Check for Bullish Hammer
   //if(Low[currentBar]<=Low[currentBar+1] && Low[currentBar]<Low[currentBar+2] && Low[currentBar]<Low[currentBar+3]) {
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
         highValue=MathMax(MathMax(Open[currentBar+1],Open[currentBar+1]),High[currentBar]);
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
bool fn_Doji(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double Doji_Star_Ratio, double &highValue, double &lowValue)
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 


   //--- Bearish patterns
   //--- Check for Evening Doji
   if(High[currentBar]>=High[currentBar+1] && High[currentBar]>High[currentBar+2]) {
      if(   Open[currentBar]==Close[currentBar]
         && High[currentBar]>Low[currentBar]
         && Close[currentBar+1]>Open[currentBar+1]
         && Close[currentBar+2]>Open[currentBar+2]
      ){
         result=true;
      }
      if(result){
         highValue=High[currentBar];
         lowValue =0;
         return(true);
      } 
   }

   //--- Bullish patterns
   //--- Check for Morning Doji
   if(Low[currentBar]<=Low[currentBar+1] && Low[currentBar]<Low[currentBar+2]) {
      if(   Open[currentBar]==Close[currentBar]
         && High[currentBar]>Low[currentBar]
         && Open[currentBar+1]>Close[currentBar+1]
         && Open[currentBar+2]>Close[currentBar+2]
      ){
         result=true;
      }
      if(result){
         highValue=0;
         lowValue =Low[currentBar];
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
bool fn_Engulfing(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double &highValue, double &lowValue)
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   //--- Bearish patterns
   if(Open[currentBar]>Close[currentBar] 
      //&& Open[currentBar+1]>Close[currentBar+1] 
      && Open[currentBar]>=MathMax(Open[currentBar+1],Close[currentBar+1])
      && Close[currentBar]<=MathMin(Open[currentBar+1],Close[currentBar+1])
      && High[currentBar]>=High[currentBar+1]
      && Low[currentBar]<=Low[currentBar+1]
   ){
      result=true;
    }
   if(result){
      highValue=0;
      lowValue =Low[currentBar];
      return(true);
   } 

   //--- Bullish patterns
   if(Open[currentBar]<Close[currentBar]
      //&& Open[currentBar+1]<Close[currentBar+1]  
      && Open[currentBar]<=MathMin(Open[currentBar+1],Close[currentBar+1])
      && Close[currentBar]>=MathMax(Open[currentBar+1],Close[currentBar+1])
      && High[currentBar]>High[currentBar+1]
      && Low[currentBar]<Low[currentBar+1]
   ){
      result=true;
    }
   if(result){
      highValue=High[currentBar];
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
bool fn_Harami(int range, ENUM_TIMEFRAMES timeFrame,int currentBar, double &highValue, double &lowValue)
{
   bool result=false;   

   //--- Exit if not enough bars on the chart for fractal
   if (currentBar > Bars(Symbol(), timeFrame)-range)
      return(false); 

   //--- Bearish patterns
   if(Open[currentBar+1]<Close[currentBar+1] 
      && Open[currentBar+1]>=MathMax(Open[currentBar],Close[currentBar])
      && Close[currentBar+1]<=MathMin(Open[currentBar],Close[currentBar])
      && High[currentBar+1]>=High[currentBar]
      && Low[currentBar+1]<=Low[currentBar]
   ){
      result=true;
    }
   if(result){
      highValue=High[currentBar+1];
      lowValue =Low[currentBar+1];
      return(true);
   } 

   //--- Bullish patterns
   if(Open[currentBar]>Close[currentBar]
      && Open[currentBar+1]<=MathMin(Open[currentBar],Close[currentBar])
      && Close[currentBar+1]>=MathMax(Open[currentBar],Close[currentBar])
      && High[currentBar+1]>High[currentBar]
      && Low[currentBar+1]<Low[currentBar]
   ){
      result=true;
    }
   if(result){
      highValue=High[currentBar+1];
      lowValue =Low[currentBar+1];
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
double fn_RoundNearest(double frmValue, double toValue){
   return toValue * MathRound(frmValue / toValue); 
}

//+------------------------------------------------------------------+
//| Function to display Timer count down
//+------------------------------------------------------------------+
void fn_ShowCounter(int LoacalToServerTime)
{ 
   int   fontSize=8;
   string myFont="Calibri";
   color myColor=clrGold;
   string myLabel = "Counter_";
   
   int   iX=0;
   int   iY=0;

   datetime serverTime  = TimeLocal() + LoacalToServerTime;
   string myText =  TimeToString(Time[0] + PeriodSeconds() - serverTime, TIME_SECONDS);

   
   ChartTimePriceToXY(0,0,Time[0]+PeriodSeconds(PERIOD_CURRENT),Ask,iX,iY);

   fn_DisplayLabel(myLabel,myText,iX,ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0)-iY,fontSize,myFont,myColor,2);
}

//+------------------------------------------------------------------+
//| Function to display Timer count down
//+------------------------------------------------------------------+
string fn_RemainingTime()
{
   int hrLeft=0;
   int minLeft=0;
   int secLeft=0;
   string remainTime="00.00.00";
   
   switch(ChartPeriod()){ 
      case PERIOD_D1: 
         hrLeft=24-TimeHour(TimeCurrent()-Time[0]);
         minLeft=60-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime=IntegerToString(hrLeft,2,'0')+":"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,'0'); 
         break; 
      case PERIOD_H4: 
         hrLeft=4-TimeHour(TimeCurrent()-Time[0]);
         minLeft=60-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime=IntegerToString(hrLeft,2,'0')+":"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break;
      case PERIOD_H1: 
         minLeft=PERIOD_H1-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break; 
      case PERIOD_M30: 
         minLeft=PERIOD_M30-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break; 
      case PERIOD_M15: 
         minLeft=PERIOD_M15-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break;  
      case PERIOD_M5: 
         minLeft=PERIOD_M5-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft)+":"+IntegerToString(secLeft);
         break;   
      default:    
         remainTime=TimeToString(TimeLocal(),TIME_SECONDS);
         break;         
   }
   
   return remainTime;
}

//+------------------------------------------------------------------+
//| Function to check for server connection
//+------------------------------------------------------------------+
string fn_IsConnectedToBroker()
{
   string connectionStatus = "Disconnected";
   //--Make sure to set EventSetMillisecondTimer(1000); at OnInit())
   static bool alarmSounded=false;
   
   if(IsConnected()){
      connectionStatus = "Connected";
      if(!alarmSounded){
         Alert("We have reconnected to the Broker server at...",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
         alarmSounded=true;
      }
   }
   else{
      if(alarmSounded){
         Alert("We lost the Broker server at...",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
         alarmSounded=false;
      }
   } 
   
   return connectionStatus;
}


//+------------------------------------------------------------------+
//| Function to check for server connection
//+------------------------------------------------------------------+
bool fn_SendNotification(string myText,bool printLog,bool sendAlert,bool sendPushNotification)
{   
   if(sendAlert){
      Alert(myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(printLog){
      Print(myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(sendPushNotification)
      SendNotification(myText);
   
   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+
//| GRAPHICAL FUNCTIONS
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Function to remove objects
//+------------------------------------------------------------------+
bool fn_RemoveObjects(string objName)
{
   for(int iObj=ObjectsTotal()-1; iObj>=0; iObj--){
      string oFullName=ObjectName(iObj);
      if(StringFind(oFullName,objName)>=0){
         ObjectDelete(oFullName);
      }
   }
   
   return(true);   
}

//+------------------------------------------------------------------+
//| Function to display symbol on chart
//+------------------------------------------------------------------+
void fn_DisplaySymbol(string objName, int arrowCode, int index, double priceLevel, color symbolColor)
{   
   ObjectCreate(objName,OBJ_ARROW,0,Time[index],priceLevel);
   ObjectSet(objName,OBJPROP_SELECTABLE,false);
   ObjectSet(objName,OBJPROP_ARROWCODE,arrowCode);
   ObjectSet(objName,OBJPROP_COLOR,symbolColor);
   ObjectSet(objName,OBJPROP_WIDTH,1);
   return;
}

//+------------------------------------------------------------------+
//| Function to move symbol on chart
//+------------------------------------------------------------------+
void fn_MoveSymbol(string objName, int index, double priceLevel)
{   
   ObjectMove(objName,0,Time[index],priceLevel);
   return;
}

//+------------------------------------------------------------------+
//| Function to display text label
//+------------------------------------------------------------------+
void fn_DisplayText(string objName, datetime time, double priceLevel, int fontSize, string fontName,color textColor, string content)
{
   ObjectCreate(0,objName,OBJ_TEXT,0,time,priceLevel);
   ObjectSetText(objName,content,fontSize,fontName,textColor);  
   ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false);
   return;
}

//+------------------------------------------------------------------+
//| Function to move text label
//+------------------------------------------------------------------+
void fn_MoveText(string objName, datetime time, double priceLevel, int fontSize, string fontName,color textColor, string content)
{
   ObjectMove(objName,0,time,priceLevel);
   ObjectSetText(objName,content,fontSize,fontName,textColor);
   return;
}

//+------------------------------------------------------------------+
//| Function to draw information panel
//+------------------------------------------------------------------+
void ShowPanel(string panelName,string & myArray[],int startX,int startY,int stepX, int stepY,color myColor,int LabelCorner)
{
   // Delete all existing label
   fn_RemoveObjects(panelName);

   for(int index=0;index<ArraySize(myArray);index++){
      DisplayLabel(panelName,startX,startY,stepX,stepY,stepY,index,myArray[index],myColor,LabelCorner);     
   }

}

//+------------------------------------------------------------------+
//| Function to draw trendline
//+------------------------------------------------------------------+
void fn_DrawTrendLine(string objName,int objWindow,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objRay)
{
   ObjectCreate(objName,OBJ_TREND,objWindow,0,0,0,0);
   ObjectSet(objName,OBJPROP_TIME1,objTime1);
   ObjectSet(objName,OBJPROP_TIME2,objTime2);
   ObjectSet(objName,OBJPROP_PRICE1,objPrice1);
   ObjectSet(objName,OBJPROP_PRICE2,objPrice2);
   ObjectSet(objName,OBJPROP_COLOR,objColor);
   ObjectSet(objName,OBJPROP_WIDTH,objWidth);
   ObjectSet(objName,OBJPROP_STYLE,objStyle);
   ObjectSet(objName,OBJPROP_RAY,objRay);
   ObjectSet(objName,OBJPROP_SELECTABLE,false);
   return;
}

//+------------------------------------------------------------------+
//| Function to draw rectangle
//+------------------------------------------------------------------+
void fn_DrawRectangle(string objName,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objBackground)
{
   ObjectCreate(objName,OBJ_RECTANGLE, 0, 0, 0, 0, 0);
   ObjectSet(objName,OBJPROP_TIME1,objTime1);
   ObjectSet(objName,OBJPROP_TIME2,objTime2);
   ObjectSet(objName,OBJPROP_PRICE1,objPrice1);
   ObjectSet(objName,OBJPROP_PRICE2,objPrice2);
   ObjectSet(objName,OBJPROP_COLOR,objColor);
   ObjectSet(objName,OBJPROP_WIDTH,objWidth);
   ObjectSet(objName,OBJPROP_STYLE,objStyle);
   ObjectSet(objName,OBJPROP_BACK,objBackground); 
   ObjectSet(objName,OBJPROP_SELECTABLE,false);
   return;
}


//+------------------------------------------------------------------+
//| Function to create label objects on chart
//+------------------------------------------------------------------+
void fn_DisplayLabel(string objName,string objText,int iX,int iY,int fontSize,string fontName,color fontColor,ENUM_BASE_CORNER objLabelCorner)
{
   ObjectCreate(objName,OBJ_LABEL,0,0,0);
   ObjectSet(objName,OBJPROP_CORNER,objLabelCorner);
   ObjectSet(objName,OBJPROP_XDISTANCE,iX);
   ObjectSet(objName,OBJPROP_YDISTANCE,iY);
   ObjectSetText(objName,objText,fontSize,fontName,fontColor);
}

//+------------------------------------------------------------------+
//| Function to move label objects on chart
//+------------------------------------------------------------------+
void fn_MoveLabel(string objName,string objText,int iX,int iY,int fontSize,string fontName,color fontColor,ENUM_BASE_CORNER objLabelCorner)
{
   ObjectSet(objName,OBJPROP_XDISTANCE,iX);
   ObjectSet(objName,OBJPROP_YDISTANCE,iY);
   ObjectSetText(objName,objText,fontSize,fontName,fontColor);
}


//+------------------------------------------------------------------+
//| Function to display multiple labels
//+------------------------------------------------------------------+
void DisplayLabel(string objName,int startX,int startY,int stepX, int stepY,int idxX,int idxY,string myText,color myColor,int LabelCorner)
{
   int   iFontSize=11;
   string sFontName="Calibri";

   ObjectCreate(objName+IntegerToString(idxY),OBJ_LABEL,0,0,0);
   ObjectSet(objName+IntegerToString(idxY),OBJPROP_CORNER,LabelCorner);
   ObjectSet(objName+IntegerToString(idxY),OBJPROP_XDISTANCE,startX+stepX*idxX);
   ObjectSet(objName+IntegerToString(idxY),OBJPROP_YDISTANCE,startY+stepY*idxY);
   ObjectSetText(objName+IntegerToString(idxY),myText,iFontSize,sFontName,myColor);
}


//+------------------------------------------------------------------+
//| Function to convert from String to enum
//+------------------------------------------------------------------+
template<typename T>
T StringToEnum(string str,T enu)
{
   for(int i=0;i<256;i++)
      if(EnumToString(enu=(T)i)==str)
         return(enu);
//---
   return(-1);
}



