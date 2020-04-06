//+------------------------------------------------------------------+
//|                                               RSI-Divergence.mq5 |
//|                                                      Khoa Nguyen |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      "https://www.mql5.com"
#property version   "3.00"
#property description   "\nv3.00: Implement in MQL5"

//---
#include  <KhoaIndicators\IndicatorEnumerations.mqh>

#import "IndicatorLibrary.ex5"
bool fn_RemoveObjects(string objName);
void fn_DisplaySymbol(string objName, int arrowCode, int index, double priceLevel, color symbolColor);
void fn_MoveSymbol(string objName, int index, double priceLevel);
double fn_ATR(int currentBar);
bool fn_FillFractalBuffers(const int currentBar, const int fractalRange, double &fractalH[], double &fractalL[]);
bool fn_Fractal(int fractalRange, ENUM_TIMEFRAMES fractal_TimeFrame,int currentBar, double &highestValue, double &lowestValue);
void fn_DrawTrendLine(string objName,int objWindow,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objRayRight,bool objRayLeft);
void fn_DisplayText(string objName, datetime time, double priceLevel,ENUM_ANCHOR_POINT anchor,double angle, int fontSize, string fontName,color fontColor, string content);

#import

#property strict
#property indicator_separate_window

#property indicator_buffers 8
#property indicator_plots   8

//+------------------------------------------------------------------+
//| Indicator Inputs
//+------------------------------------------------------------------+
input string lb1="";                                     //=====Indicator Parameters
input int oscPeriod=4;                                   //RSI Period
input ENUM_APPLIED_PRICE oscAppliedPrice=PRICE_MEDIAN;   //RSI Applied Price
input int OSC_LVL=20;                                    //RSI Level - Between 5-95
input int FractalRange=4;                                //Fractal range

input string lb2="";                                    //=====Violation and Divergence Parameters
input int lookBackSteps=5;                             //Number of Min/Max point to check for Violation/Divergence

input string lb3="";                                    //=====Violation Notification Parameters
input bool EnableNotification=false;                    //Enable push notification
input int PNoticeLevel=0;                               //Notification level
input ENUM_TIMEFRAMES PNoticeTime=0;                    //Notification timeframe
input TREND_DIRECTION PNoticeDirection=0;               //Notification of violation direction

//+------------------------------------------------------------------+
//| Indicator Buffers
//+------------------------------------------------------------------+
double arrOscilator[];       //Array to store Oscillator value
//double t3_Oscil[];
double arrMax[];             //Array to store MAX value
double arrMin[];             //Array to store MIN value
double arrFractalH[];        //Array to store Fractal high value
double arrFractalL[];        //Array to store Fractal low value
double arrOBOscillator[];    //Array to store OB values
double arrOSOscillator[];    //Array to store OS values
double arrRGOscillator[];    //Array to store Range values

//+------------------------------------------------------------------+
//| Indicator Variables
//+------------------------------------------------------------------+
int      limit=0;             //Number of bars for calculation
int      ExtBegin=0;          //To define a bar to perform calculation from
int      NumberOfBars=5000;   //Number of bars
int      checkBarsCalc=2;     //Number of bars required for calculation

struct IndexStruct
{
   int   idx_High;
   int   idx_Low;
};

//--- variable for storing the handle of the iIchimoku indicator 
int      IndicatorHandle; 

int      OSC_OB=80;             //Indicator Overbought and OverSold Level
int      OSC_OS=20;             //Indicator Overbought and OverSold Level
int      indicatorWindowID=1;   //ID of indicator windows

int      retries=3;                                     //Number of retries when calculating trendline

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   //--- indicator buffers mapping
   fn_RemoveObjects("RSIV_");
   
   SetIndicatorProperties();
   
//---
   return(INIT_SUCCEEDED);
}
  
void OnDeinit(const int reason)
{
   fn_RemoveObjects("RSIV_");
   if(IndicatorHandle!=INVALID_HANDLE) 
      IndicatorRelease(IndicatorHandle); 
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
   //--- Revert access to array
   ArraySetAsSeries(time,true);
   ArraySetAsSeries(open,true);
   ArraySetAsSeries(high,true);
   ArraySetAsSeries(low,true);
   ArraySetAsSeries(close,true);
   ArraySetAsSeries(tick_volume,true);
   ArraySetAsSeries(volume,true);
   ArraySetAsSeries(spread,true);
  
   //--- Disable calculation on each tick
   if(prev_calculated==rates_total) {
      return(rates_total);
   }

   //--- determine the number of values calculated in the indicator 
   int calculated = BarsCalculated(IndicatorHandle);
   if(calculated<=0) { 
      PrintFormat("BarsCalculated() returned %d, error code %d",calculated,GetLastError()); 
      return(0); 
   } 

   //--- If this is the first calculation
   if(prev_calculated==0 || calculated!=checkBarsCalc || rates_total>prev_calculated+1) {
      //--- Reset indicator buffers
      ZeroIndicatorBuffers();
      //--- Check the amount of available data
      if(!CheckDataAvailable())
         return(0);
      //--- If more data specified for copying, the current amount is used
      DetermineNumberData();
      
      //--- if the Buffer array is greater than the number of values in the iIchimoku indicator for symbol/period, then we don't copy everything  
      //--- otherwise, we copy less than the size of indicator buffers 
      if(NumberOfBars>rates_total) 
         ExtBegin=rates_total; 
      else                      
         ExtBegin=NumberOfBars; 
   } else {
      //--- Calculate the last value only
      ExtBegin=MathMax(rates_total-prev_calculated, 2);      
   }   


   //--- fill the arrays with values of the Ichimoku Kinko Hyo indicator 
   //--- if FillArraysFromBuffer returns false, it means the information is nor ready yet, quit operation 
   if(!FillArraysFromBuffers( arrOscilator,
                              arrOBOscillator,
                              arrOSOscillator,
                              arrRGOscillator,
                              IndicatorHandle,
                              ExtBegin)
   ) return(0); 

   //--- memorize the number of values in the Ichimoku Kinko Hyo indicator 
   checkBarsCalc=calculated; 

   //--- Detect signals 
   for(int i=0; i<ExtBegin; i++) {
      fn_FillFractalBuffers(i,FractalRange,arrFractalH,arrFractalL);
      if(i>=FractalRange && i<rates_total-FractalRange)
         FillOscillatorMinMax(i);
   }

   //--- Main function to detect Violation and Divergence
   TrendLineViolationDivergence(time,high,low);
      
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
//| Function to detect and draw Trendline violation
//+------------------------------------------------------------------+
void TrendLineViolationDivergence(const datetime &time[]
                                 ,const double &high[]
                                 ,const double &low[]
                                 )
{  
   string objName;
   bool foundUp=false,foundDown=false;
   bool brokenRule=false;
   
   IndexStruct IndexArray[];      // Array to store High and Low index of indicators
   ArrayResize(IndexArray,lookBackSteps);

   int index,benchmarkIndex;
   
   //--- Consilidate locations of High and Low index into 1 array
   for(index=0;index<lookBackSteps;index++){
      //--- Get first High Low index
      if(index==0) {
         IndexArray[index].idx_High = GetFirstIndex(3,arrMax);
         IndexArray[index].idx_Low = GetFirstIndex(3,arrMin);
      //--- Get subsequence High Low indexes
      }else{
         IndexArray[index].idx_High = GetNextIndex(IndexArray[index-1].idx_High,arrMax);
         IndexArray[index].idx_Low = GetNextIndex(IndexArray[index-1].idx_Low,arrMin);
      }   
   }

   //--- Looping through IndexArray compare each subsequence index against benchmark index
   //--- Up Violation
   foundUp=false;
   benchmarkIndex=0;    
   while(!foundUp && benchmarkIndex<lookBackSteps-1) {
      //--- Subsequence index will start at 1
      index=benchmarkIndex+1;
      while(!foundUp && index<lookBackSteps){
         //--- Current High > Benchmark High and Current arrMax > Benchmark arrMax
         //--- Current High > Previous High and Current arrMax > Previous arrMax      
         if(high[IndexArray[index].idx_High] > high[IndexArray[benchmarkIndex].idx_High] 
            && high[IndexArray[index].idx_High] > high[IndexArray[index-1].idx_High]
            && arrMax[IndexArray[index].idx_High] > arrMax[IndexArray[benchmarkIndex].idx_High]
            && arrMax[IndexArray[index].idx_High] > arrMax[IndexArray[index-1].idx_High] ){

            //--- Update benchmark index to current index
            foundUp=true; 
            objName = "RSIV_IND_VIO_HIGH";
            
            fn_DrawTrendLine(objName,indicatorWindowID
                             ,time[IndexArray[index].idx_High],time[IndexArray[benchmarkIndex].idx_High]
                             ,arrMax[IndexArray[index].idx_High],arrMax[IndexArray[benchmarkIndex].idx_High]
                             ,clrCornflowerBlue,1,STYLE_SOLID,true,false);
         }
         
         index++;
      }//--- End for loop
      //--- Increase benchmarkIndex if not found
      benchmarkIndex++;
   }//---End foundUp

   //--- Down Violation
   foundDown=false;
   benchmarkIndex=0;    
   while(!foundDown && benchmarkIndex<lookBackSteps-1) {
      //--- Subsequence index will start at 1
      index=benchmarkIndex+1;
      while(!foundDown && index<lookBackSteps){
         //--- Current Low < Benchmark Low and Current arrMin < Benchmark arrMin
         //--- Current Low < Previous Low and Current arrMin < Previous arrMin      
         if(low[IndexArray[index].idx_Low] < low[IndexArray[benchmarkIndex].idx_Low] 
            && low[IndexArray[index].idx_Low] < low[IndexArray[index-1].idx_Low]
            && arrMin[IndexArray[index].idx_Low] < arrMin[IndexArray[benchmarkIndex].idx_Low]
            && arrMin[IndexArray[index].idx_Low] < arrMin[IndexArray[index-1].idx_Low] ){

            //--- Update benchmark index to current index
            foundDown=true;
            objName = "RSIV_IND_VIO_LOW";
            
            fn_DrawTrendLine(objName,indicatorWindowID
                             ,time[IndexArray[index].idx_Low],time[IndexArray[benchmarkIndex].idx_Low]
                             ,arrMin[IndexArray[index].idx_Low],arrMin[IndexArray[benchmarkIndex].idx_Low]
                             ,clrFireBrick,1,STYLE_SOLID,true,false);
         }
         
         index++;
      }//--- End for loop
      //--- Increase benchmarkIndex if not found
      benchmarkIndex++;
   }//---End foundDown   

   //--- Bearish Reversal Divergence
   foundUp=false;
   benchmarkIndex=0;    
   while(!foundUp && benchmarkIndex<lookBackSteps-1) {
      //--- Subsequence index will start at 1
      index=benchmarkIndex+1;
      brokenRule=false;
      while(!foundUp && !brokenRule && index<lookBackSteps){
         //--- Current High < Benchmark High and Current arrMax > Benchmark arrMax
         //--- Current High < Previous High and Current arrMax > Previous arrMax      
         if(high[IndexArray[index].idx_High] < high[IndexArray[benchmarkIndex].idx_High] 
            && high[IndexArray[index].idx_High] < high[IndexArray[index-1].idx_High]
            && arrMax[IndexArray[index].idx_High] > arrMax[IndexArray[benchmarkIndex].idx_High]
            && arrMax[IndexArray[index].idx_High] > arrMax[IndexArray[index-1].idx_High] ){
            //--- Update benchmark index to current index
            foundUp=true;  
            
            //--- Draw lines
            objName = "RSIV_IND_DIV_BEARREV";                  
            fn_DrawTrendLine(objName,indicatorWindowID
                             ,time[IndexArray[index].idx_High],time[IndexArray[benchmarkIndex].idx_High]
                             ,arrMax[IndexArray[index].idx_High],arrMax[IndexArray[benchmarkIndex].idx_High]
                             ,clrGold,1,STYLE_DOT,false,false);

            objName = "RSIV_CHT_DIV_BEARREV";                             
            fn_DrawTrendLine(objName,0
                             ,time[IndexArray[index].idx_High],time[IndexArray[benchmarkIndex].idx_High]
                             ,high[IndexArray[index].idx_High],high[IndexArray[benchmarkIndex].idx_High]
                             ,clrGold,1,STYLE_DOT,false,false);                             
         //--- Prev Oscilatior value is less than benchmark, rule broken, increase benchmark
         }else if(high[IndexArray[index].idx_High] < high[IndexArray[index-1].idx_High]
                  && arrMax[IndexArray[index].idx_High] < arrMax[IndexArray[index-1].idx_High]){
            brokenRule=true;
         }
         
         index++;
      }//--- End for loop
      //--- Increase benchmarkIndex if not found
      benchmarkIndex++;
   }//---End foundUp

   //--- Bearish Continuous Divergence
   foundUp=false;
   benchmarkIndex=0;    
   while(!foundUp && benchmarkIndex<lookBackSteps-1) {
      //--- Subsequence index will start at 1
      index=benchmarkIndex+1;
      brokenRule=false;
      while(!foundUp && !brokenRule && index<lookBackSteps){
         //--- Current High > Benchmark High and Current arrMax < Benchmark arrMax
         //--- Current High > Previous High and Current arrMax < Previous arrMax      
         if(high[IndexArray[index].idx_High] > high[IndexArray[benchmarkIndex].idx_High] 
            && high[IndexArray[index].idx_High] > high[IndexArray[index-1].idx_High]
            && arrMax[IndexArray[index].idx_High] < arrMax[IndexArray[benchmarkIndex].idx_High]
            && arrMax[IndexArray[index].idx_High] < arrMax[IndexArray[index-1].idx_High] ){
            //--- Update benchmark index to current index
            foundUp=true;  
            
            //--- Draw lines
            objName = "RSIV_IND_DIV_BEARCONT";                  
            fn_DrawTrendLine(objName,indicatorWindowID
                             ,time[IndexArray[index].idx_High],time[IndexArray[benchmarkIndex].idx_High]
                             ,arrMax[IndexArray[index].idx_High],arrMax[IndexArray[benchmarkIndex].idx_High]
                             ,clrGold,1,STYLE_DOT,false,false);

            objName = "RSIV_CHT_DIV_BEARCONT";                             
            fn_DrawTrendLine(objName,0
                             ,time[IndexArray[index].idx_High],time[IndexArray[benchmarkIndex].idx_High]
                             ,high[IndexArray[index].idx_High],high[IndexArray[benchmarkIndex].idx_High]
                             ,clrGold,1,STYLE_DOT,false,false);                             
         }else if(high[IndexArray[index].idx_High] > high[IndexArray[index-1].idx_High]
                  && arrMax[IndexArray[index].idx_High] > arrMax[IndexArray[index-1].idx_High]
         ){
            brokenRule=true;
         }
         
         index++;
      }//--- End for loop
      //--- Increase benchmarkIndex if not found
      benchmarkIndex++;
   }//---End foundUp


   //--- Bullish Reversal Divergence
   foundDown=false;
   benchmarkIndex=0;    
   while(!foundDown && benchmarkIndex<lookBackSteps-1) {
      //--- Subsequence index will start at 1
      index=benchmarkIndex+1;
      brokenRule=false;
      while(!foundDown && !brokenRule && index<lookBackSteps){
         //--- Current Low < Benchmark Low and Current arrMin > Benchmark arrMin
         //--- Current Low < Previous Low and Current arrMin > Previous arrMin      
         if(low[IndexArray[index].idx_Low] < low[IndexArray[benchmarkIndex].idx_Low] 
            && low[IndexArray[index].idx_Low] < low[IndexArray[index-1].idx_Low]
            && arrMin[IndexArray[index].idx_Low] > arrMin[IndexArray[benchmarkIndex].idx_Low]
            && arrMin[IndexArray[index].idx_Low] > arrMin[IndexArray[index-1].idx_Low] ){

            //--- Update benchmark index to current index
            foundDown=true;
            
            //--- Draw lines
            objName = "RSIV_IND_DIV_BULLREV";           
            fn_DrawTrendLine(objName,indicatorWindowID
                             ,time[IndexArray[index].idx_Low],time[IndexArray[benchmarkIndex].idx_Low]
                             ,arrMin[IndexArray[index].idx_Low],arrMin[IndexArray[benchmarkIndex].idx_Low]
                             ,clrGold,1,STYLE_DOT,false,false);

            objName = "RSIV_CHT_DIV_BULLREV";           
            fn_DrawTrendLine(objName,0
                             ,time[IndexArray[index].idx_Low],time[IndexArray[benchmarkIndex].idx_Low]
                             ,low[IndexArray[index].idx_Low],low[IndexArray[benchmarkIndex].idx_Low]
                             ,clrGold,1,STYLE_DOT,false,false);
         }else if(low[IndexArray[index].idx_Low] < low[IndexArray[index-1].idx_Low]
                  && arrMin[IndexArray[index].idx_Low] < arrMin[IndexArray[index-1].idx_Low]
         ){
            brokenRule=true;
         }
         
         index++;
      }//--- End for loop
      //--- Increase benchmarkIndex if not found
      benchmarkIndex++;
   }//---End foundDown   

   //--- Bullish Continous Divergence
   foundDown=false;
   benchmarkIndex=0;    
   while(!foundDown && benchmarkIndex<lookBackSteps-1) {
      //--- Subsequence index will start at 1
      index=benchmarkIndex+1;
      brokenRule=false;
      while(!foundDown && !brokenRule && index<lookBackSteps){
         //--- Current Low > Benchmark Low and Current arrMin < Benchmark arrMin
         //--- Current Low > Previous Low and Current arrMin < Previous arrMin      
         if(low[IndexArray[index].idx_Low] > low[IndexArray[benchmarkIndex].idx_Low] 
            && low[IndexArray[index].idx_Low] > low[IndexArray[index-1].idx_Low]
            && arrMin[IndexArray[index].idx_Low] < arrMin[IndexArray[benchmarkIndex].idx_Low]
            && arrMin[IndexArray[index].idx_Low] < arrMin[IndexArray[index-1].idx_Low] ){

            //--- Update benchmark index to current index
            foundDown=true;
            
            //--- Draw lines
            objName = "RSIV_IND_DIV_BULLCONT";           
            fn_DrawTrendLine(objName,indicatorWindowID
                             ,time[IndexArray[index].idx_Low],time[IndexArray[benchmarkIndex].idx_Low]
                             ,arrMin[IndexArray[index].idx_Low],arrMin[IndexArray[benchmarkIndex].idx_Low]
                             ,clrGold,1,STYLE_DOT,false,false);

            objName = "RSIV_CHT_DIV_BULLCONT";           
            fn_DrawTrendLine(objName,0
                             ,time[IndexArray[index].idx_Low],time[IndexArray[benchmarkIndex].idx_Low]
                             ,low[IndexArray[index].idx_Low],low[IndexArray[benchmarkIndex].idx_Low]
                             ,clrGold,1,STYLE_DOT,false,false);
         }else if(low[IndexArray[index].idx_Low] > low[IndexArray[index-1].idx_Low]
                  && arrMin[IndexArray[index].idx_Low] > arrMin[IndexArray[index-1].idx_Low]
         ){
            brokenRule=true;
         }
         
         index++;
      }//--- End for loop
      //--- Increase benchmarkIndex if not found
      benchmarkIndex++;
   }//---End foundDown   

   
}


//+------------------------------------------------------------------+
//| Function to search the array and return the first array index having non zero value
//+------------------------------------------------------------------+
int GetFirstIndex(int maxRetry, double& myArray[])
{
   int idx;
   for(idx=0;idx<ArrayRange(myArray,0);idx++){   
      //--- Keep moving if current value is 0
      if(myArray[idx]>0){
         break;
      } 
   }
   
   if(idx==ArrayRange(myArray,0)-1) idx=0;
   
   return (idx);         
}

//+------------------------------------------------------------------+
//| Function to search Buf1 array (High value array) for the index having high value 
//+------------------------------------------------------------------+
int GetNextIndex(int startIndex, double& myArray[])
{ 
   int idx=startIndex+1;
   while(myArray[idx]==0){
      idx++;
      if(idx>NumberOfBars-2) return(-1);
   }
   return (idx);
}

//+------------------------------------------------------------------+
//| Function to scan fratal array and for x index left and x index right of the start index, returning the index having non 0 value
//+------------------------------------------------------------------+
int FindNearestIndex(int startIdx, int range,const double &SearchArr[])
{
int returnIdx=0;
           
   for(int idx=range; idx>=-range; idx--){
      if(startIdx+idx >= 0 && SearchArr[startIdx+idx]>0){
         returnIdx=startIdx+idx;
         break;
      }
   }
   return returnIdx;
}

//+------------------------------------------------------------------+
//| Function to calculate RSI MIN MAX values
//+------------------------------------------------------------------+
void FillOscillatorMinMax(int curIdx)
{  
   //---Calulating max value and min value
   //---Initialize min and max value
   int maxIdx=0;
   int minIdx=0;

   maxIdx = ArrayMaximum(arrOscilator,curIdx-FractalRange,FractalRange*2+1);
   minIdx = ArrayMinimum(arrOscilator,curIdx-FractalRange,FractalRange*2+1);

   if(curIdx == maxIdx){
      arrMax[curIdx] = arrOscilator[curIdx];
   }else if(curIdx == minIdx){
      arrMin[curIdx] = arrOscilator[curIdx];
   } 
//---
}


//+------------------------------------------------------------------+ 
//| Filling indicator buffers from the iIchimoku indicator           | 
//+------------------------------------------------------------------+ 
bool FillArraysFromBuffers(double &mainBuffer[],    // indicator buffer of the Oscillator
                           double &obBuffer[],     // indicator buffer of the OB
                           double &osBuffer[],     // indicator buffer of the OS
                           double &rgBuffer[],     // indicator buffer of the RG
                           int ind_handle,         // handle of the iIchimoku indicator 
                           int amount              // number of copied values 
                           ) 
{ 
   //--- reset error code 
   ResetLastError(); 
   
   //--- fill a part of the arrBuffer array with values from the indicator buffer that has 0 index 
   if(CopyBuffer(ind_handle,0,0,amount,mainBuffer)<0) { 
      //--- if the copying fails, tell the error code 
      PrintFormat("1.Failed to copy data from the iIchimoku indicator, error code %d",GetLastError()); 
      //--- quit with zero result - it means that the indicator is considered as not calculated 
    return(false); 
   } 

   for(int i=0;i<amount;i++){
      if(mainBuffer[i]>=OSC_OB){
         obBuffer[i] = mainBuffer[i];
         if(i>0) obBuffer[i-1] = mainBuffer[i-1];
         if(i<amount-1) obBuffer[i+1] = mainBuffer[i+1];
      }else if(mainBuffer[i]<=OSC_OS){
         osBuffer[i] = mainBuffer[i];
         if(i>0) osBuffer[i-1] = mainBuffer[i-1];
         if(i<amount-1) osBuffer[i+1] = mainBuffer[i+1];
      }else{
         rgBuffer[i] = mainBuffer[i];
      }   
   }

   //--- everything is fine 
   return(true); 
} 

//+------------------------------------------------------------------+
//| Set the indicator properties                                     |
//+------------------------------------------------------------------+
bool SetIndicatorProperties(void) {

   ENUM_DRAW_TYPE draw_type;
   
   //--- Set Indicator Name
   IndicatorSetString(INDICATOR_SHORTNAME, "RSI Violation Divergence");
   indicatorWindowID = ChartWindowFind(0,"RSI Violation Divergence");
   //--- Set a number of decimal places
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

   //--- Setup RSI level
   if(OSC_LVL<50 && OSC_LVL>5){
      OSC_OB = 100-OSC_LVL;
      OSC_OS = OSC_LVL;
   }else
   if(OSC_LVL>50 && OSC_LVL<95){
      OSC_OB = OSC_LVL;
      OSC_OS = 100-OSC_LVL;
   }
   IndicatorSetInteger(INDICATOR_LEVELS,3); 
   IndicatorSetDouble(INDICATOR_MAXIMUM,100);
   IndicatorSetDouble(INDICATOR_MINIMUM,0);
   IndicatorSetDouble(INDICATOR_LEVELVALUE,0,50);
   IndicatorSetDouble(INDICATOR_LEVELVALUE,1,OSC_OB); 
   IndicatorSetDouble(INDICATOR_LEVELVALUE,2,OSC_OS);
   IndicatorSetInteger(INDICATOR_LEVELSTYLE,STYLE_DOT);
   IndicatorSetInteger(INDICATOR_LEVELCOLOR,clrSilver);
   
   //--- Define buffers for drawing
   SetIndexBuffer(0, arrOscilator,INDICATOR_CALCULATIONS);
   SetIndexBuffer(1, arrMax, INDICATOR_DATA);
   SetIndexBuffer(2, arrMin, INDICATOR_DATA);
   SetIndexBuffer(3, arrFractalH, INDICATOR_DATA);
   SetIndexBuffer(4, arrFractalL, INDICATOR_DATA);
   SetIndexBuffer(5, arrOBOscillator, INDICATOR_DATA);
   SetIndexBuffer(6, arrOSOscillator, INDICATOR_DATA);
   SetIndexBuffer(7, arrRGOscillator, INDICATOR_DATA);

   ArraySetAsSeries(arrOscilator,true);
   ArraySetAsSeries(arrMax,true);
   ArraySetAsSeries(arrMin,true);
   ArraySetAsSeries(arrFractalH,true);
   ArraySetAsSeries(arrFractalL,true);
   ArraySetAsSeries(arrOBOscillator,true);
   ArraySetAsSeries(arrOSOscillator,true);
   ArraySetAsSeries(arrRGOscillator,true);

   //--- Set the labels
   string text[]= {"Oscilator", "Max Value", "Min Value", "Fractal H", "Fractal L", "OB Value", "OS Value", "Range Value"};
   for(int i=0; i<indicator_plots; i++)
      PlotIndexSetString(i,PLOT_LABEL,text[i]);


   //--- Oscillator
   PlotIndexSetString(0,PLOT_LABEL,"Oscillator");
   //PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,checkBarsCalc);
   PlotIndexSetInteger(0,PLOT_DRAW_TYPE,DRAW_NONE);
   PlotIndexSetInteger(0,PLOT_LINE_STYLE,STYLE_SOLID);
   PlotIndexSetInteger(0,PLOT_LINE_COLOR,clrCornflowerBlue);
   PlotIndexSetInteger(0,PLOT_LINE_WIDTH,1);

   //--- Max Oscillator value
   PlotIndexSetString(1,PLOT_LABEL,"Max Oscil");      
   PlotIndexSetInteger(1,PLOT_DRAW_TYPE,DRAW_ARROW);
   PlotIndexSetInteger(1,PLOT_ARROW,159);   
   PlotIndexSetInteger(1,PLOT_LINE_COLOR,0,clrLimeGreen);
   PlotIndexSetInteger(1,PLOT_LINE_WIDTH,3);
   
   //--- Min Oscillator value
   PlotIndexSetString(2,PLOT_LABEL,"Min Oscil");      
   PlotIndexSetInteger(2,PLOT_DRAW_TYPE,DRAW_ARROW);
   PlotIndexSetInteger(2,PLOT_ARROW,159);   
   PlotIndexSetInteger(2,PLOT_LINE_COLOR,0,clrRed);
   PlotIndexSetInteger(2,PLOT_LINE_WIDTH,3);

   //--- High Fractals
   PlotIndexSetString(3,PLOT_LABEL,"H-Fractals");   
   PlotIndexSetInteger(3,PLOT_DRAW_TYPE,DRAW_NONE);
   //PlotIndexSetInteger(3,PLOT_ARROW,217);
   //PlotIndexSetInteger(3,PLOT_ARROW_SHIFT,-10);
   //PlotIndexSetInteger(3,PLOT_LINE_COLOR,clrGray);

   //--- Low Fractals
   PlotIndexSetString(4,PLOT_LABEL,"L-Fractals");  
   PlotIndexSetInteger(4,PLOT_DRAW_TYPE,DRAW_NONE);
   //PlotIndexSetInteger(4,PLOT_ARROW,218);
   //PlotIndexSetInteger(4,PLOT_ARROW_SHIFT,10);
   //PlotIndexSetInteger(4,PLOT_LINE_COLOR,clrGray);   

   //--- Oscillator OB
   PlotIndexSetString(5,PLOT_LABEL,"OB Value");
   //PlotIndexSetInteger(5,PLOT_DRAW_BEGIN,checkBarsCalc);
   PlotIndexSetInteger(5,PLOT_DRAW_TYPE,DRAW_LINE);
   PlotIndexSetInteger(5,PLOT_LINE_STYLE,STYLE_SOLID);
   PlotIndexSetInteger(5,PLOT_LINE_COLOR,clrCornflowerBlue);
   PlotIndexSetInteger(5,PLOT_LINE_WIDTH,2);

   //--- Oscillator OS
   PlotIndexSetString(6,PLOT_LABEL,"OS Value");
   //PlotIndexSetInteger(6,PLOT_DRAW_BEGIN,checkBarsCalc);
   PlotIndexSetInteger(6,PLOT_DRAW_TYPE,DRAW_LINE);
   PlotIndexSetInteger(6,PLOT_LINE_STYLE,STYLE_SOLID);
   PlotIndexSetInteger(6,PLOT_LINE_COLOR,clrFireBrick);
   PlotIndexSetInteger(6,PLOT_LINE_WIDTH,2);

   //--- Oscillator RANGE
   PlotIndexSetString(7,PLOT_LABEL,"Range Value");
   //PlotIndexSetInteger(7,PLOT_DRAW_BEGIN,checkBarsCalc);
   PlotIndexSetInteger(7,PLOT_DRAW_TYPE,DRAW_LINE);
   PlotIndexSetInteger(7,PLOT_LINE_STYLE,STYLE_SOLID);
   PlotIndexSetInteger(7,PLOT_LINE_COLOR,clrDarkOrchid);
   PlotIndexSetInteger(7,PLOT_LINE_WIDTH,1);

   //--- Initialize for plotting empty value
   for(int i=0; i<indicator_plots; i++)
      PlotIndexSetDouble(i,PLOT_EMPTY_VALUE,0.0); 
      
   //--- Setup Oscillator Handle
   IndicatorHandle=iRSI(NULL,0,oscPeriod,oscAppliedPrice); 
   //--- if the handle is not created 
   if(IndicatorHandle==INVALID_HANDLE) { 
      //--- tell about the failure and output the error code 
      PrintFormat("Failed to create handle of the iIchimoku indicator for the symbol %s/%s, error code %d", 
                  Symbol(), 
                  EnumToString(PERIOD_CURRENT), 
                  GetLastError()); 
      //--- the indicator is stopped early 
      return(false); 
   } 

   return(true);
}

//+------------------------------------------------------------------+
//| Reset the indicator buffers                                      |
//+------------------------------------------------------------------+
void ZeroIndicatorBuffers(void)
{
   ArrayInitialize(arrOscilator,0);
   ArrayInitialize(arrMax,0);
   ArrayInitialize(arrMin,0);
   ArrayInitialize(arrFractalH,0);
   ArrayInitialize(arrFractalL,0);
   ArrayInitialize(arrOBOscillator,0);
   ArrayInitialize(arrOSOscillator,0);
   ArrayInitialize(arrRGOscillator,0);
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
      //startBar=rates_total-checkBarsCalc;
      ExtBegin=checkBarsCalc-1;
}