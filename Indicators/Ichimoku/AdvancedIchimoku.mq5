//+------------------------------------------------------------------+
//|                                             AdvancedIchimoku.mq5 |
//|                                                      Khoa Nguyen |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      "https://www.mql5.com"
#property version   "2.00"
#property description   "/nv2.00: Implement in MQL5"

#property strict

#include  <KhoaIndicators\IndicatorEnumerations.mqh>

#import "IndicatorLibrary.ex5"
bool fn_RemoveObjects(string objName);
void fn_DisplaySymbol(string objName, int arrowCode, int index, double priceLevel, color symbolColor);
void fn_MoveSymbol(string objName, int index, double priceLevel);
bool fn_FillFractalBuffers(const int currentBar, const int fractalRange, double &fractalH[], double &fractalL[]);
bool fn_Fractal(int fractalRange, ENUM_TIMEFRAMES fractal_TimeFrame,int currentBar, double &highestValue, double &lowestValue);
void fn_DrawTrendLine(string objName,int objWindow,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objRayRight,bool objRayLeft);
void fn_DisplayText(string objName, datetime time, double priceLevel,ENUM_ANCHOR_POINT anchor,double angle, int fontSize, string fontName,color fontColor, string content);
int ATRHandle(string symbol,ENUM_TIMEFRAMES timeframe,int period);
double fn_GetBufferCurrentValue(int handle,int currentBar);

#import

#property indicator_chart_window
//--- Number of buffers
#property indicator_buffers 9
#property indicator_plots   8
//--- Colour for filled Kumo
#property indicator_color3  clrMidnightBlue,clrMaroon

//+------------------------------------------------------------------+
//| Indicator Inputs
//+------------------------------------------------------------------+
input int InpTenkan =9;          // Tenkan-sen
input bool ShowTenkan =true;     // Show Tenkan-sen
input int InpKijun =26;          // Kijun-sen
input bool ShowKijun =true;      // Show Kijun-sen
input int InpSenkou =52;         // Senkou Span B
input bool ShowChikou =true;     // Show Chikou-span
input int FractalRange =4;       // Fractal range
//input bool ShowSpanAHighLow=true;// Show Senkou Span A High and Low
input bool ShowSpanBHighLow =true;// Show Senkou Span B High and Low
input bool ShowKijunHighLow =true;// Show Kijunsen High and Low
input bool ShowTenkanHighLow =true;// Show Tenkansen High and Low


//+------------------------------------------------------------------+
//| Indicator Buffers
//+------------------------------------------------------------------+
double ExtTenkanBuffer[];
double ExtKijunBuffer[];
double ExtSpanA_Buffer[];
double ExtSpanB_Buffer[];
double ExtChikouBuffer[];
double HighFractal_Buffer[];
double LowFractal_Buffer[];
double KumoBreak_Buffer[];
double TKCross_Buffer[];

//+------------------------------------------------------------------+
//| Indicator Variables
//+------------------------------------------------------------------+
int      ExtBegin=0;          //To define a bar to perform calculation from
int      NumberOfBars=0;      //Number of bars
int      checkBarsCalc=0;
//--- variable for storing the handle of the iIchimoku indicator 
int      handle;
int      ATRHdl;

bool     kumoBreak=false;   //Flag to indicate kumo break out signal has been detected
bool     tkCross=false;     //Flag to indicate Tenkansen has crossed Kijunsend

TREND_DIRECTION direction=NO_TREND;
TREND_DIRECTION chikouCrossDirection=NO_TREND;
TREND_DIRECTION TKCrossDirection=NO_TREND;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   //--- indicator buffers mapping
   fn_RemoveObjects("ICHILabel_");
   SetIndicatorProperties();
   
   //---
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   fn_RemoveObjects("ICHILabel_");
   fn_RemoveObjects("ICHILine_");
   if(handle!=INVALID_HANDLE) 
      IndicatorRelease(handle); 
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
   int calculated=BarsCalculated(handle); 
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
      
      //--- if the Tenkan_sen_Buffer array is greater than the number of values in the iIchimoku indicator for symbol/period, then we don't copy everything  
      //--- otherwise, we copy less than the size of indicator buffers 
      if(calculated>rates_total) 
         ExtBegin=rates_total; 
      else                      
         ExtBegin=calculated; 
   } else {
      //--- Calculate the last value only
      ExtBegin=MathMax(rates_total-prev_calculated, 2);      
   }   

   
   //--- fill the arrays with values of the Ichimoku Kinko Hyo indicator 
   //--- if FillArraysFromBuffer returns false, it means the information is nor ready yet, quit operation 
   if(!FillArraysFromBuffers( ExtTenkanBuffer,
                              ExtKijunBuffer,
                              ExtSpanA_Buffer,
                              ExtSpanB_Buffer,
                              ExtChikouBuffer, 
                              InpKijun,
                              handle,
                              ExtBegin)
   ) return(0); 


   if (ShowSpanBHighLow) HanneHighLow(time,high,low,InpSenkou,clrGray,"SSB");
   //if (ShowSpanAHighLow) Senkou1HighLow(i,time,high,low);
   if (ShowKijunHighLow) HanneHighLow(time,high,low,InpKijun,clrCornflowerBlue,"KS");
   if (ShowTenkanHighLow) HanneHighLow(time,high,low,InpTenkan,clrPink,"TS");

   //--- memorize the number of values in the Ichimoku Kinko Hyo indicator 
   checkBarsCalc=calculated; 

   ExtBegin = InpKijun+1;   
   //--- Detect signals 
   for(int i=0; i<rates_total-ExtBegin; i++) {
      fn_FillFractalBuffers(i,FractalRange,HighFractal_Buffer,LowFractal_Buffer);
      KumoBreakout(i, time, open, close, high, low, spread);
      TKCross1(i, time, open, close, high, low, spread);
      TKCross2(i, time, open, close, high, low, spread);   
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
//| Function to detect Tenkan-Kijun Cross
//+------------------------------------------------------------------+
void TKCross2(const int i,
                  const datetime &time[],
                  const double &open[],
                  const double &close[],
                  const double &high[],
                  const double &low[],
                  const int &spread[]
                  )
{
   int position = InpKijun;

   //--- Gold Cross of Tenkan Kijun
   //--- UP_TREND
   if(   ExtTenkanBuffer[i] > ExtKijunBuffer[i]
      && ExtTenkanBuffer[i+1] > ExtKijunBuffer[i+1]
      && ExtTenkanBuffer[i+2] <= ExtKijunBuffer[i+2]
   ){
      TKCrossDirection = UP_TREND;
   }else
   //--- Death corss of TK
   if(   ExtTenkanBuffer[i] < ExtKijunBuffer[i]
      && ExtTenkanBuffer[i+1] < ExtKijunBuffer[i+1]
      && ExtTenkanBuffer[i+2] >= ExtKijunBuffer[i+2]
   ){   
      TKCrossDirection = DOWN_TREND; 
   }else{
   //--- NO_TREND
      TKCrossDirection = NO_TREND;
   }
   
   //--- When Gold Cross of Tenkan-Kijun first
   //--- Then Gold cross of Chikou
   if(   TKCrossDirection == UP_TREND
      && ExtChikouBuffer[i+position] > MathMax(open[i+position],close[i+position])
      && ExtChikouBuffer[i+position+1] <= MathMax(open[i+position+1],close[i+position+1])
   ){
      if(!tkCross){
         tkCross=true;
         TKCross_Buffer[i]=high[i]+fn_GetBufferCurrentValue(ATRHdl,i)*30*myPoint;
      }   
   }   

   //--- Reset signal if Open/Close Below Kijun
   if(   (TKCrossDirection == UP_TREND)
      && ExtChikouBuffer[i+position] < close[i+position]
   ){
      tkCross=false;
   }   
  
   //--- When Death cross of Tenkan-Kijun first
   //--- Then Death cross of Chikou
   if(   TKCrossDirection == DOWN_TREND
      && ExtChikouBuffer[i+position] < MathMin(open[i+position],close[i+position])
      && ExtChikouBuffer[i+position+1] >= MathMax(open[i+position+1],close[i+position+1])
   ){
      if(!tkCross){
         tkCross=true;
         TKCross_Buffer[i]=low[i]-fn_GetBufferCurrentValue(ATRHdl,i)*30*myPoint;
      }   
   }   

   //--- Reset signal if Oepn/Close above Kijun
   if(   (TKCrossDirection == DOWN_TREND)
      && ExtChikouBuffer[i+position] >= close[i+position]
   ){
      tkCross=false;
   }   

}//---


//+------------------------------------------------------------------+
//| Function to detect Tenkan-Kijun Cross
//+------------------------------------------------------------------+
void TKCross1(const int i,
                  const datetime &time[],
                  const double &open[],
                  const double &close[],
                  const double &high[],
                  const double &low[],
                  const int &spread[]
                  )
{
   int position = InpKijun;

   //--- Gold Cross of Chikou
   //--- UP_TREND
   if(ExtChikouBuffer[i+position] > MathMax(open[i+position],close[i+position])){
      chikouCrossDirection = UP_TREND;
   }else
   //--- Death cross of Chikou
   //--- DOWN_TREND
   if(ExtChikouBuffer[i+position] < MathMin(open[i+position],close[i+position])){
      chikouCrossDirection = DOWN_TREND;
   }else
   {
   //--- NO_TREND
      chikouCrossDirection = NO_TREND;
      //TKCross_Buffer[i]=0;
   }
   
   //--- When Gold Cross of Chikou first
   //--- Then Gold cross of Tenkan-Kijun
   if(   chikouCrossDirection == UP_TREND
      && ExtTenkanBuffer[i] > ExtKijunBuffer[i]
      && ExtTenkanBuffer[i+1] > ExtKijunBuffer[i+1]
      && ExtTenkanBuffer[i+2] <= ExtKijunBuffer[i+2]
      && ExtSpanA_Buffer[i] >= ExtSpanB_Buffer[i]
   ){
      if(!tkCross){
         tkCross=true;
         TKCross_Buffer[i]=high[i]+fn_GetBufferCurrentValue(ATRHdl,i)*30*myPoint;
      }   
   }   

   //--- Reset signal if Open/Close Below Kijun
   if(   (chikouCrossDirection == UP_TREND)
      && (MathMin(open[i],close[i]) < ExtKijunBuffer[i] || ExtTenkanBuffer[i] <= ExtKijunBuffer[i])
   ){
      tkCross=false;
   }   
  
   //--- When Death cross of Chikou first
   //--- Then Death cross of Tenkan-Kijun
   if(   chikouCrossDirection == DOWN_TREND
      && ExtTenkanBuffer[i] < ExtKijunBuffer[i]
      && ExtTenkanBuffer[i+1] < ExtKijunBuffer[i+1]
      && ExtTenkanBuffer[i+2] >= ExtKijunBuffer[i+2]
      && ExtSpanA_Buffer[i] <= ExtSpanB_Buffer[i]
   ){
      if(!tkCross){
         tkCross=true;
         TKCross_Buffer[i]=low[i]-fn_GetBufferCurrentValue(ATRHdl,i)*30*myPoint;
      }   
   }   

   //--- Reset signal if Oepn/Close above Kijun
   if(   (chikouCrossDirection == DOWN_TREND)
      && (MathMax(open[i],close[i])>ExtKijunBuffer[i] || ExtTenkanBuffer[i] >= ExtKijunBuffer[i])
   ){
      tkCross=false;
   }   

}//---


//+------------------------------------------------------------------+
//| Function to detect Kumo breakout signal
//+------------------------------------------------------------------+
void KumoBreakout(const int i,
                  const datetime &time[],
                  const double &open[],
                  const double &close[],
                  const double &high[],
                  const double &low[],
                  const int &spread[]
                  )
{
   int position = InpKijun;

   //---If SpanA > Span B then Future sentiment is UP
   //---If Chikou > High of 25 prev bars then Chikou is UP
   //---If Tenkan > Kijun
   //---Thus UP_TREND       
   if(ExtSpanA_Buffer[i] > ExtSpanB_Buffer[i]
      && ExtChikouBuffer[i] > high[i+position]
      && ExtTenkanBuffer[i] > ExtKijunBuffer[i]
   ){
      //Print("ExtChikouBuffer[",i,"]",ExtChikouBuffer[i],"-high[",i+position,"]:",high[i+position],"-low[",i+position,"]",low[i+position]);
      direction=UP_TREND;     
   }else 
   //---If SpanA < Span B then Future sentiment is DOWN
   //---If Chikou < Low of 25 prev bars then Chikou is DOWN
   //---If Tenkan < Kijun
   //---Thus DOWN_TREND   
   if(ExtSpanA_Buffer[i] < ExtSpanB_Buffer[i]
      && ExtChikouBuffer[i] < low[i+position]
      && ExtTenkanBuffer[i] < ExtKijunBuffer[i]
   ){
      direction=DOWN_TREND;
   }
   //--- Reset trend direction when non of above exists
   else{
      direction=NO_TREND;
      KumoBreak_Buffer[i]=0;
   }
   
   //---If UP_TREND
   //---Bar 1 open/close above SpanA and SpanB
   //---Bar 1 open/close above Kijun  
   if(direction==UP_TREND
      && close[i] > ExtKijunBuffer[i]
      && close[i] > ExtSpanA_Buffer[i+position] 
      && close[i] > ExtSpanB_Buffer[i+position]
      && ( (ExtSpanA_Buffer[i+position] < ExtSpanB_Buffer[i+position] && MathMin(low[i],open[i]) < ExtSpanB_Buffer[i+position]) 
         || (ExtSpanA_Buffer[i+position] > ExtSpanB_Buffer[i+position] && MathMin(low[i],open[i]) < ExtSpanA_Buffer[i+position]) 
         )
   ){
      if(!kumoBreak){
         kumoBreak=true;
         KumoBreak_Buffer[i]=high[i]+fn_GetBufferCurrentValue(ATRHdl,i)*30*myPoint;
      }
   }
   
   //---If close below Kijun then reset signal
   if(direction==UP_TREND && (close[i] < ExtKijunBuffer[i] || ExtTenkanBuffer[i] < ExtKijunBuffer[i]) ){
      kumoBreak=false;
   }   
     
   //---If DOWN_TREND
   //---Bar 1 close below SpanA and SpanB
   //---Bar 1 close below Kijun  
   if(direction==DOWN_TREND
      && close[i] < ExtKijunBuffer[i]
      && close[i] < ExtSpanA_Buffer[i+position] 
      && close[i] < ExtSpanB_Buffer[i+position]
      && (     (ExtSpanA_Buffer[i+position] < ExtSpanB_Buffer[i+position] && MathMax(high[i],open[i]) > ExtSpanA_Buffer[i+position]) 
            || (ExtSpanA_Buffer[i+position] > ExtSpanB_Buffer[i+position] && MathMax(high[i],open[i]) > ExtSpanB_Buffer[i+position])
         )
   ){
      if(!kumoBreak){
         kumoBreak=true;
         KumoBreak_Buffer[i]=low[i]-fn_GetBufferCurrentValue(ATRHdl,i)*30*myPoint;
      } 
   }

   //---If close above Kijun then reset signal
   if(direction == DOWN_TREND && (close[i] > ExtKijunBuffer[i] || ExtTenkanBuffer[i] > ExtKijunBuffer[i] ) ){
      kumoBreak=false;
   }   
  
}

//+------------------------------------------------------------------+
//| Function to draw high and low value of Hanne  
//+------------------------------------------------------------------+
void HanneHighLow(const datetime &time[],
                  const double &high[],
                  const double &low[],
                  int InpPeriod,
                  color lineColor,
                  string lineName
                  )
{
string   objName, text;
int      hanneTopBar, hanneBottomBar, topBarsCountDown, bottomBarsCountDown;
double   hanneTopPrice, hanneBottomPrice;   

      
   hanneTopBar = iHighest(NULL,0,MODE_HIGH,InpPeriod,0);
   hanneTopPrice = NormalizeDouble(high[hanneTopBar],Digits());
   
   objName = "ICHILine_" + lineName + "_Top";
   fn_DrawTrendLine(objName,0,time[InpPeriod],time[0],hanneTopPrice,hanneTopPrice,lineColor,1,STYLE_DOT,false,false);
   
   hanneBottomBar = iLowest(NULL,0,MODE_LOW,InpPeriod,0);
   hanneBottomPrice = low[hanneBottomBar];
   objName = "ICHILine_" + lineName + "_Bottom";
   fn_DrawTrendLine(objName,0,time[InpPeriod],time[0],hanneBottomPrice,hanneBottomPrice,lineColor,1,STYLE_DOT,false,false);
   
   topBarsCountDown = InpPeriod - hanneTopBar;
   bottomBarsCountDown = InpPeriod - hanneBottomBar;
   objName = "ICHILine_" + lineName + "_Label";
   text = IntegerToString(topBarsCountDown) + "/" + IntegerToString(bottomBarsCountDown);
   if(topBarsCountDown > bottomBarsCountDown)
      text = text + "/Up";
   else if(topBarsCountDown < bottomBarsCountDown)
      text = text + "/Down";
   else
      text = text + "/Flat";      
   fn_DisplayText(objName,time[InpPeriod],hanneBottomPrice,ANCHOR_UPPER,0,8,"Calibri",lineColor,text);
     
}

//+------------------------------------------------------------------+ 
//| Filling indicator buffers from the iIchimoku indicator           | 
//+------------------------------------------------------------------+ 
bool FillArraysFromBuffers(double &tenkan_sen_buffer[],     // indicator buffer of the Tenkan-sen line 
                           double &kijun_sen_buffer[],      // indicator buffer of the Kijun_sen line 
                           double &senkou_span_A_buffer[],  // indicator buffer of the Senkou Span A line 
                           double &senkou_span_B_buffer[],  // indicator buffer of the Senkou Span B line 
                           double &chinkou_span_buffer[],   // indicator buffer of the Chinkou Span line 
                           int senkou_span_shift,           // shift of the Senkou Span lines in the future direction 
                           int ind_handle,                  // handle of the iIchimoku indicator 
                           int amount                       // number of copied values 
                           ) 
{ 
   //--- reset error code 
   ResetLastError(); 
   
   //--- fill a part of the Tenkan_sen_Buffer array with values from the indicator buffer that has 0 index 
   if(CopyBuffer(ind_handle,0,0,amount,tenkan_sen_buffer)<0) { 
      //--- if the copying fails, tell the error code 
      PrintFormat("1.Failed to copy data from the iIchimoku indicator, error code %d",GetLastError()); 
      //--- quit with zero result - it means that the indicator is considered as not calculated 
    return(false); 
   } 

   //--- fill a part of the Kijun_sen_Buffer array with values from the indicator buffer that has index 1 
   if(CopyBuffer(ind_handle,1,0,amount,kijun_sen_buffer)<0) { 
      //--- if the copying fails, tell the error code 
      PrintFormat("2.Failed to copy data from the iIchimoku indicator, error code %d",GetLastError()); 
      //--- quit with zero result - it means that the indicator is considered as not calculated 
      return(false); 
   } 

   //--- fill a part of the Chinkou_Span_Buffer array with values from the indicator buffer that has index 2 
   //--- if senkou_span_shift>0, the line is shifted in the future direction by senkou_span_shift bars 
   if(CopyBuffer(ind_handle,2,-senkou_span_shift,amount,senkou_span_A_buffer)<0) { 
      //--- if the copying fails, tell the error code 
      PrintFormat("3.Failed to copy data from the iIchimoku indicator, error code %d",GetLastError()); 
      //--- quit with zero result - it means that the indicator is considered as not calculated 
      return(false); 
   } 

   //--- fill a part of the Senkou_Span_A_Buffer array with values from the indicator buffer that has index 3 
   //--- if senkou_span_shift>0, the line is shifted in the future direction by senkou_span_shift bars 
   if(CopyBuffer(ind_handle,3,-senkou_span_shift,amount,senkou_span_B_buffer)<0) { 
      //--- if the copying fails, tell the error code 
      PrintFormat("4.Failed to copy data from the iIchimoku indicator, error code %d",GetLastError()); 
      //--- quit with zero result - it means that the indicator is considered as not calculated 
      return(false); 
   } 

   //--- fill a part of the Senkou_Span_B_Buffer array with values from the indicator buffer that has 0 index 
   //--- when copying Chinkou Span, we don't need to consider the shift, since the Chinkou Span data 
   //--- is already stored with a shift in iIchimoku   
   if(CopyBuffer(ind_handle,4,0,amount,chinkou_span_buffer)<0) { 
      //--- if the copying fails, tell the error code 
      PrintFormat("5.Failed to copy data from the iIchimoku indicator, error code %d",GetLastError()); 
      //--- quit with zero result - it means that the indicator is considered as not calculated 
      return(false); 
   } 
   
   //--- everything is fine 
   return(true); 
} 

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Set the indicator properties                                     |
//+------------------------------------------------------------------+
bool SetIndicatorProperties(void) {
   int i;
   ENUM_DRAW_TYPE draw_type;
   
   //--- Set Indicator Name
   IndicatorSetString(INDICATOR_SHORTNAME, "Ichimoku Kinko Hyo");
   //--- Set a number of decimal places
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   //ChartSetInteger(0,CHART_FOREGROUND,true);
   
   //--- Define buffers for drawing
   SetIndexBuffer(0, ExtTenkanBuffer,INDICATOR_DATA);    //Tenkan-sen
   SetIndexBuffer(1, ExtKijunBuffer, INDICATOR_DATA);     //Kijun-sen
   SetIndexBuffer(2, ExtSpanA_Buffer, INDICATOR_DATA);    //Kumo A
   SetIndexBuffer(3, ExtSpanB_Buffer, INDICATOR_DATA);    //Kumo B   
   SetIndexBuffer(4, ExtChikouBuffer, INDICATOR_DATA);    //Chikou
   SetIndexBuffer(5, HighFractal_Buffer, INDICATOR_DATA); //High Fractal
   SetIndexBuffer(6, LowFractal_Buffer, INDICATOR_DATA);  //Low Fractal
   SetIndexBuffer(7, KumoBreak_Buffer, INDICATOR_DATA);   //Kumo breakout signal
   SetIndexBuffer(8, TKCross_Buffer, INDICATOR_DATA);     //TK Cross signal


   ArraySetAsSeries(ExtTenkanBuffer,true);
   ArraySetAsSeries(ExtKijunBuffer,true);
   ArraySetAsSeries(ExtSpanA_Buffer,true);
   ArraySetAsSeries(ExtSpanB_Buffer,true);
   ArraySetAsSeries(ExtChikouBuffer,true);
   ArraySetAsSeries(HighFractal_Buffer,true);
   ArraySetAsSeries(LowFractal_Buffer,true);
   ArraySetAsSeries(KumoBreak_Buffer,true);
   ArraySetAsSeries(TKCross_Buffer,true);

   //--- Set the labels
   //string text[]= {"Tenkan Sen", "Kijun Sen", "Senkou Span A", "Senkou Span B", "Chikou Span", "Kumo Break", "High Fractal", "Low Fractal"};
   //for(i=0; i<indicator_plots; i++)
   //   PlotIndexSetString(i,PLOT_LABEL,text[i]);

   ExtBegin=MathMax(InpKijun,InpTenkan);

   //--- Tenkan-sen
   PlotIndexSetString(0,PLOT_LABEL,"Tenkan-sen");
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,InpTenkan-1);
   draw_type =(ShowTenkan)? DRAW_LINE : DRAW_NONE;
   PlotIndexSetInteger(0,PLOT_DRAW_TYPE,draw_type);
   PlotIndexSetInteger(0,PLOT_LINE_STYLE,STYLE_SOLID);
   PlotIndexSetInteger(0,PLOT_LINE_COLOR,clrPink);
   PlotIndexSetInteger(0,PLOT_LINE_WIDTH,1);
   
   //--- Kijun-sen
   PlotIndexSetString(1,PLOT_LABEL,"Kijun-sen");
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,InpKijun-1);
   draw_type =(ShowKijun)? DRAW_LINE : DRAW_NONE;
   PlotIndexSetInteger(1,PLOT_DRAW_TYPE,draw_type);
   PlotIndexSetInteger(1,PLOT_LINE_STYLE,STYLE_SOLID);
   PlotIndexSetInteger(1,PLOT_LINE_COLOR,clrCornflowerBlue);
   PlotIndexSetInteger(1,PLOT_LINE_WIDTH,2);

   //--- Senkou Span A
   PlotIndexSetString(2,PLOT_LABEL,"Senkou Span A;Senkou Span B");
   PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,InpKijun+ExtBegin-1);
   PlotIndexSetInteger(2,PLOT_SHIFT,InpKijun);
   PlotIndexSetInteger(2,PLOT_DRAW_TYPE,DRAW_FILLING);
   PlotIndexSetInteger(2,PLOT_LINE_WIDTH,3);
      
   //--- Chikou
   PlotIndexSetString(3,PLOT_LABEL,"Chikou");   
   PlotIndexSetInteger(3,PLOT_DRAW_BEGIN,InpKijun-1);
   //PlotIndexSetInteger(3,PLOT_SHIFT,-InpKijun);   
   draw_type =(ShowChikou)? DRAW_LINE : DRAW_NONE;
   PlotIndexSetInteger(3,PLOT_DRAW_TYPE,draw_type);
   PlotIndexSetInteger(3,PLOT_LINE_STYLE,STYLE_SOLID);
   PlotIndexSetInteger(3,PLOT_LINE_COLOR,clrDarkGoldenrod);
   PlotIndexSetInteger(3,PLOT_LINE_WIDTH,1);
   
   //--- High Fractals
   PlotIndexSetString(4,PLOT_LABEL,"H-Fractals");   
   PlotIndexSetInteger(4,PLOT_DRAW_TYPE,DRAW_ARROW);
   PlotIndexSetInteger(4,PLOT_ARROW,217);
   PlotIndexSetInteger(4,PLOT_ARROW_SHIFT,-10);
   PlotIndexSetInteger(4,PLOT_LINE_COLOR,clrGray);

   //--- Low Fractals
   PlotIndexSetString(5,PLOT_LABEL,"L-Fractals");  
   PlotIndexSetInteger(5,PLOT_DRAW_TYPE,DRAW_ARROW);
   PlotIndexSetInteger(5,PLOT_ARROW,218);
   PlotIndexSetInteger(5,PLOT_ARROW_SHIFT,10);
   PlotIndexSetInteger(5,PLOT_LINE_COLOR,clrGray);

   //--- Kumo Break out signal
   PlotIndexSetString(6,PLOT_LABEL,"KumoBreak");      
   PlotIndexSetInteger(6,PLOT_DRAW_TYPE,DRAW_ARROW);
   PlotIndexSetInteger(6,PLOT_ARROW,181);   
   PlotIndexSetInteger(6,PLOT_LINE_COLOR,0,clrGold);
   PlotIndexSetInteger(6,PLOT_LINE_WIDTH,2);

   //--- TK Cross signal
   PlotIndexSetString(7,PLOT_LABEL,"TKCross");      
   PlotIndexSetInteger(7,PLOT_DRAW_TYPE,DRAW_ARROW);
   PlotIndexSetInteger(7,PLOT_ARROW,181);   
   PlotIndexSetInteger(7,PLOT_LINE_COLOR,0,clrSilver);
   PlotIndexSetInteger(7,PLOT_LINE_WIDTH,2);

   for(i=0; i<indicator_plots; i++)
      PlotIndexSetDouble(i,PLOT_EMPTY_VALUE,0.0); 
      
   //--- Setup Ichimoku indicator handle
   handle=iIchimoku(Symbol(),PERIOD_CURRENT,InpTenkan,InpKijun,InpSenkou); 
   //--- if the handle is not created 
   if(handle==INVALID_HANDLE) { 
      //--- tell about the failure and output the error code 
      PrintFormat("Failed to create handle of the iIchimoku indicator for the symbol %s/%s, error code %d", 
                  Symbol(), 
                  EnumToString(PERIOD_CURRENT), 
                  GetLastError()); 
      //--- the indicator is stopped early 
      return(false); 
   } 

   //--- Setup ATR indicator handle
   ATRHdl = ATRHandle(NULL,0,7);

   return(true);
}

//+------------------------------------------------------------------+
//| Reset the indicator buffers                                      |
//+------------------------------------------------------------------+
void ZeroIndicatorBuffers(void)
{
   ArrayInitialize(ExtTenkanBuffer,0);
   ArrayInitialize(ExtKijunBuffer,0);
   ArrayInitialize(ExtSpanA_Buffer,0);
   ArrayInitialize(ExtSpanB_Buffer,0);
   ArrayInitialize(ExtChikouBuffer,0);
   ArrayInitialize(KumoBreak_Buffer,0);
   ArrayInitialize(HighFractal_Buffer,0);
   ArrayInitialize(LowFractal_Buffer,0);
   ArrayInitialize(TKCross_Buffer,0);
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