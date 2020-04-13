//+------------------------------------------------------------------+
//|                                              CustomIndicator.mq4 |
//|                                                      Khoa Nguyen |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      ""
#property version   "1.01"
#property strict
#property description   "v1.01:Fix the overlap drawing"
                        "/nv1.00:Initial design support and resistance indicator based on SS_SupportResistance_v07.53"
                        "/n"

#import "KhoaIndicatorLibrary.ex4"
double fn_SetMyPoint();
bool fn_RemoveObjects(string objName);
double fn_RoundNearest(double frmValue, double toValue);
void fn_ShowCounter(int LoacalToServerTime);

bool fn_Fractal(int fractalRange, ENUM_TIMEFRAMES fractal_TimeFrame,int currentBar, double &highestValue, double &lowestValue);
void fn_DrawRectangle(string objName,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objBackground);
void fn_DisplayText(string objName, datetime time, double priceLevel, int fontSize, string fontName,color textColor, string content);

#import

enum ZONE_TYPE
{
   ZONE_SUPPORT=1,
   ZONE_RESIST=2,
   ZONE_BROKEN=3,
   ZONE_POSSIBLE=4,
   ZONE_TURNCOAT=5,
   ZONE_UNTESTED=6,
   ZONE_VERIFIED=7,
   ZONE_WEAK=8,  
};

//--- Enumeration if any
enum ENUM_DRAW_TYPE{
   DRW_LINE=0,
   DRW_SECTION=1,
   DRW_HISTOGRAM=2,
   DRW_ARROW=3,
   DRW_ZIGZAG=4,
   DRW_NONE=12
};

//--- On chart or on separate windos
#property indicator_chart_window      // Indicator is drawn in the main window
//--- Number of buffers
#property indicator_buffers 4         // Number of buffers
#property indicator_plots   4

//--- Input variables
extern int NumberOfBars   =10000;                   // Number of bars
extern ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT; //Timeframe

extern string  SHOW_ZONES            = "==========SHOW ZONES==========";
extern bool   zone_show_untested     = true;
extern bool   zone_show_verified     = true;
extern bool   zone_show_truncoat     = true;
extern bool   zone_show_weak         = false;
extern bool   zone_show_possible     = false;
extern bool   zone_showbroken        = false;
extern bool   show_Counter           = true;

extern string  STYLE_ZONES            = "==========STYLE ZONES==========";
extern bool   zone_merge             = true;       //Merge Zone
extern bool   zone_extend            = false;      //Extend Zone
extern bool   zone_solid             = false;      //Display Background
extern int    zone_linewidth         = 1;          //Zone thickness
extern ENUM_LINE_STYLE zone_style    = STYLE_DOT;  //Zone Style
extern int    ShiftEndRight          = 13;         //Extend the end of zones X bars beyond last bar
extern int    zone_limit             = 1000;       //Max number of zones to identified
extern bool   zone_show_info         = true;

extern string  ZONES_COLOR             = "==========COLOR ZONES==========";
extern color   color_support_possible  = clrDarkSlateGray;
extern color   color_support_untested  = clrSeaGreen;
extern color   color_support_verified  = clrGreen;
extern color   color_support_weak      = clrLimeGreen;
extern color   color_support_turncoat  = clrOliveDrab;
extern color   color_resist_possible   = clrIndigo;
extern color   color_resist_untested   = clrOrchid;
extern color   color_resist_verified   = clrCrimson;
extern color   color_resist_weak       = clrRed;
extern color   color_resist_turncoat   = clrDarkOrange;
extern color   color_broken_weak       = clrDarkGray;
extern color   color_broken_verified   = clrGray;
extern color   color_broken_other      = clrDimGray;

extern string  ZONE_FRACTALS         = "==========ZONE FRACTALS==========";
extern double  zone_fuzzfactor        = 0.75;   //Fuzzy factor
extern int     fractal_fast_factor    = 8;      //Fast Fractals scan range
extern int     fractal_slow_factor    = 13;     //Slow Fractals scan range

//--- Indicator buffers
double FastDnPts[];
double FastUpPts[];
double SlowDnPts[];
double SlowUpPts[];


//--- Indicator variables
double   myPoint =0;
int      startBar =0;   //To define a bar to perform calculation from
int      checkBarsCalc =0;
datetime firstDate =(_Period==PERIOD_CURRENT || _Period==PERIOD_M15 || _Period==PERIOD_H1 || _Period==PERIOD_H4 || _Period==PERIOD_D1 || _Period==PERIOD_D1 || _Period==PERIOD_W1 || _Period==PERIOD_MN1) ? 0 : D'01.01.2000';

//--- Master arrays to store zones
double zone_H[];              // Zone high value
double zone_L[];              // Zone low value
int    zone_Start[];          // Zone start bar
int    zone_End[];            // Zone end bar
int    zone_Hits[];           // Zone verification times
int    zone_Type[];           // Zone types
int    zone_Strength[];       // Strength of zone
bool   zone_Turncoat[];       // Zone turncoat
int    zone_Found=0;          // Number of identified zones

//--- Temporary arrays to store zones
double curZone_H[1000];          // Current zone High and Low value
double curZone_L[1000];
int    curZone_Start[1000];      // Current zone Starting bar
int    curZone_Hits[1000];       // Current zone verification points count
int    curZone_Strength[1000];   // Current zone type
bool   curZone_Turncoat[1000];   // Current Turncoat zone
bool   curZone_Merge[1000];      // Current Merge zone
int    curZone_Found=0;          // Number of zones identified
//--- Temporary Arrays to store historical zones
double burstZone_H[1000];
double burstZone_L[1000];
int    burstZone_Start[1000];
int    burstZone_Hits[1000];
int    burstZone_Strength[1000];
int    burstZone_End[1000];
bool   burstZone_Turncoat[1000];
bool   burstZone_Merge[1000];
int    burstZone_Found=0;

int    merge_Target[1000];
int    merge_Source[1000];
int    merge_count=0;
int    mergeBroken_Target[1000];
int    mergeBroken_Source[1000];
int    mergeBroken_count=0;

//--- Varibale to verify zone is Support/Resistance
int   zone_touchCount=0;
int   zone_bustCount=0;
int   zone_borkenBarCount=0;

//--- Environments variables
int time_offset=0;
int LatestBar=0;              //Last visible bar on the chart - in Testing mode
int localToServer;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   
   fn_RemoveObjects("SR#");
   fn_RemoveObjects("Counter_"); 

   SetPropertiesIndicator();
   EventSetMillisecondTimer(100);
   //---
   return(INIT_SUCCEEDED);
}

int deinit()
{
   fn_RemoveObjects("SR#");  
   fn_RemoveObjects("Counter_"); 
   return(0);
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
   if(show_Counter)
      fn_ShowCounter(localToServer);
   else
      fn_RemoveObjects("Counter_");
      
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]) {
   int i;
   localToServer = (int)fn_RoundNearest(TimeCurrent() - TimeLocal(), 1800);

   //--- Disable calculation on each tick
   if(prev_calculated==rates_total) {return(rates_total);}
   
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
      startBar=MathMax(rates_total-prev_calculated, 2);
   }

   //--- Fill in the High Bid and Low Ask indicator buffers
   for(i=startBar; i>0; i--) {
      FillIndicatorBuffers(i, time);
      //--- Iterate through all the bar and find the Support/Resistance Zone
      if(i>5){
         FindZones(i, time, high, low, open, close);
      }
   }
   
   if(zone_merge) MergeZones(close);
   if(zone_showbroken) BrokenZones();
   DrawZones(time);
   
//--- Return the data array size
   return(rates_total);
}


//+------------------------------------------------------------------+
//| Set the indicator properties                                     |
//+------------------------------------------------------------------+
void SetPropertiesIndicator(void) {
   int i;
   myPoint = fn_SetMyPoint();
   //--- Set a short name
   IndicatorSetString(INDICATOR_SHORTNAME, "Support and Resistance");

   //--- Set a number of decimal places
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   
   //--- Define buffers for drawing
   SetIndexBuffer(0, SlowDnPts);
   SetIndexBuffer(1, SlowUpPts);
   SetIndexBuffer(2, FastDnPts);
   SetIndexBuffer(3, FastUpPts);

   //--- Set the labels
   string text[]= {"SlowDnPts","SlowUpPts","FastDnPts","FastUpPts"};
   for(i=0; i<indicator_plots; i++)
      SetIndexLabel(i, text[i]);

   //--- Set the type
   ENUM_DRAW_TYPE draw_type = DRW_NONE;  
   //draw_type =(ShowH1)? DRW_LINE : DRW_NONE;
   SetIndexStyle(0, draw_type, STYLE_DASH, 1, clrMaroon);
   SetIndexStyle(1, draw_type, STYLE_DASH, 1, clrDarkBlue);
   //draw_type =(ShowH4)? DRW_LINE : DRW_NONE;
   SetIndexStyle(2, draw_type, STYLE_DASH, 1, clrMaroon);
   SetIndexStyle(3, draw_type, STYLE_DASH, 1, clrDarkBlue);
   
   for(i=0; i<indicator_plots; i++)
      SetIndexEmptyValue(i, 0.0);

   //--- Limit number of bar per zone. Minimum 100 bar
   zone_limit = MathMax(zone_limit, 100);
   ArrayResize(zone_H, zone_limit);
   ArrayResize(zone_L, zone_limit);
   ArrayResize(zone_Start, zone_limit);
   ArrayResize(zone_Hits, zone_limit);
   ArrayResize(zone_Type, zone_limit);
   ArrayResize(zone_Strength, zone_limit);
   ArrayResize(zone_End, zone_limit);
   ArrayResize(zone_Turncoat, zone_limit);

}


//+------------------------------------------------------------------+
//| Reset the indicator buffers                                      |
//+------------------------------------------------------------------+
void ZeroIndicatorBuffers(void)
{
   ArrayInitialize(SlowDnPts,0);
   ArrayInitialize(SlowUpPts,0);
   ArrayInitialize(FastDnPts,0);
   ArrayInitialize(FastUpPts,0);
}

//+------------------------------------------------------------------+
//| Reset temporary variables
//+------------------------------------------------------------------+
void ZeroTemporaryVariables(void)
{
   //--- Temporary arrays to store zones
   ArrayInitialize(curZone_H,0);
   ArrayInitialize(curZone_L,0);
   ArrayInitialize(curZone_Start,0);
   ArrayInitialize(curZone_Hits,0);
   ArrayInitialize(curZone_Strength,0);
   ArrayInitialize(curZone_Turncoat,0);
   ArrayInitialize(curZone_Merge,0);
   curZone_Found=0;
   //--- Temporary Arrays to store historical zones
   ArrayInitialize(burstZone_H,0);
   ArrayInitialize(burstZone_L,0);
   ArrayInitialize(burstZone_Start,0);
   ArrayInitialize(burstZone_Hits,0);
   ArrayInitialize(burstZone_Strength,0);
   ArrayInitialize(burstZone_End,0);
   ArrayInitialize(burstZone_Turncoat,0);
   ArrayInitialize(burstZone_Merge,0);
   burstZone_Found=0;
   
   ArrayInitialize(merge_Target,0);
   ArrayInitialize(merge_Source,0);
   merge_count=0;
   ArrayInitialize(mergeBroken_Target,0);
   ArrayInitialize(mergeBroken_Source,0);
   mergeBroken_count=0;
   
   //--- Varibale to verify zone is Support/Resistance
   zone_touchCount=0;
   zone_bustCount=0;
   zone_borkenBarCount=0;
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
//| Define the number of days for display                            |
//+------------------------------------------------------------------+
void DetermineNumberData(void) {
//--- If not all bars are needed
   if(NumberOfBars>0) {
      //--- If specified more than the current amount, inform of that
      if(NumberOfBars>checkBarsCalc)
         printf("%s: Not enough data to calculate! NumberOfBars: %d; Indicator data: %d",
                _Symbol, NumberOfBars, checkBarsCalc);
      else
         checkBarsCalc=NumberOfBars;
   }
}

//+------------------------------------------------------------------+
//| Define the index of the first bar to plot                        |
//+------------------------------------------------------------------+
void DetermineBeginForCalculate(const int rates_total) {
//--- If there is more indicator data than there is on the current symbol, then
//    plot from the first one available on the current symbol
   if(checkBarsCalc>rates_total)
      startBar=rates_total-1;
   else
      startBar=checkBarsCalc-1;
}

//+------------------------------------------------------------------+
//| Fill in the indicator buffers
//+------------------------------------------------------------------+
void FillIndicatorBuffers(int i, const datetime &time[]) {
//--- Exit if the start date is not reached
   if(time[i]<firstDate)
      return;
      
   double fastHigh=0, fastLow=0, slowHigh=0, slowLow=0;
   fn_Fractal(fractal_fast_factor,TimeFrame,i,fastHigh,fastLow);
   FastUpPts[i] = fastHigh;
   FastDnPts[i] = fastLow;

   fn_Fractal(fractal_slow_factor,TimeFrame,i,slowHigh,slowLow);
   SlowUpPts[i] = slowHigh;
   SlowDnPts[i] = slowLow;
}


//+------------------------------------------------------------------+
//| Function to find support and resistance zones
//+------------------------------------------------------------------+
void FindZones(int currentBar,const datetime &time[],const double &high[],const double &low[],const double &open[],const double &close[])
{
   int i, j;
   
   //Variable to store High and Low price of currentBar
   double HValue=0, LValue=0;
   //Varuable to store High and Low price of bar infornt of currentBar        
   double H_iValue=0, L_iValue=0;       
   //--- Varibale to verify zone is Support/Resistance
   bool zone_isPossible=false;
   bool zone_isTurncoat=false, zone_confirmTurncoat=false;
   bool zone_isTouched=false;   
   bool zone_isBusted=false;

   //--- Calculate zone width based on ATR and zone_fuzzValue
   double atr=iATR(NULL, TimeFrame, 7, currentBar);
   double zone_fuzzValue = atr/2 * zone_fuzzfactor;
      
   double cur_Close = close[currentBar];
   double cur_High  = high[currentBar];
   double cur_Low   = low[currentBar];
      
//--- Find Resistance zones -------------------------------------      
   if (FastUpPts[currentBar] > 0.001) {
      //--- If current Fast Fractal is not 0 then assume it is a zone
      zone_isPossible = true;
      //--- If current Slow is also larger than 0 then it is not anymore
      if (SlowUpPts[currentBar] > 0.001) zone_isPossible = false;

      HValue = cur_High;
      if (zone_extend == true) HValue += zone_fuzzValue;
      LValue = MathMax(MathMin(cur_Close,cur_High-zone_fuzzValue), cur_High-zone_fuzzValue*2); 
      
      zone_isTurncoat = false;
      zone_confirmTurncoat = false;
      zone_isBusted = false;

      zone_bustCount = 0;
      zone_touchCount = 0;
      zone_borkenBarCount = 0;

      //--- From the currentBar , look forward to first bar
      for (i=currentBar-1; i>=LatestBar + 0; i--) {
         //--- continue looking for high and low value
         H_iValue = high[i];
         L_iValue = low[i];

         //--- Verify Zone ha been touched and not bursted
            //--- If Zone is not TurnCoat and future FastUp is within HValue and LValue of currentBar
            //--- If Zone is TurnCoat and future FastDown is within HValue and LValue of currentBar
         if ((zone_isTurncoat == false && FastUpPts[i] >= LValue && FastUpPts[i] <= HValue) ||
             (zone_isTurncoat == true && FastDnPts[i] <= HValue && FastDnPts[i] >= LValue)
         ){
            // Zone has been confirmed
            zone_isTouched = true;
            //--- Make sure its been 10+ candles since the prev touch
            for (j=i+1; j<i+11; j++){
               if ((zone_isTurncoat == false && FastUpPts[j] >= LValue && FastUpPts[j] <= HValue) ||
                   (zone_isTurncoat == true && FastDnPts[j] <= HValue && FastDnPts[j] >= LValue))
               {
                  zone_isTouched = false;
                  break;
               }
            }
            
            //--- Zone confirmed. Update number of touches and reset number of burst
            if (zone_isTouched == true){
               zone_bustCount = 0;
               zone_touchCount++;
            }
         }

         //--- Verfiry broken zones
            //--- If Zone is not TurnCoat and H_iValue > HValue this means zone has been broken
            //--- If Zone is TurnCoat and L_iValue < LValue this means zone has been broken
         if ((zone_isTurncoat == false && H_iValue > HValue) ||
             (zone_isTurncoat == true && L_iValue < LValue)
         ){
            //--- Update bust count
            zone_bustCount++;
            zone_borkenBarCount = MathMax(zone_borkenBarCount, i);

            //--- If zone has been broken more than 2 then confirm it's busted
            if (zone_bustCount > 1 || zone_isPossible == true){
               zone_isBusted = true;
               break;
            }

            //--- If zone has been bursted then it's definately turncoat'
            zone_isTurncoat = !zone_isTurncoat;            
            zone_confirmTurncoat = true;
            //--- Zone has busted, reset zone_touching
            zone_touchCount = 0;
         }
      }//---End for loop

      //--- Store value into corresponding array for displaying
      //--- If zone is not busted then categorise type of zone
      if (zone_isBusted == false) {
         curZone_H[curZone_Found] = HValue;
         curZone_L[curZone_Found] = LValue;
         curZone_Turncoat[curZone_Found] = zone_confirmTurncoat;
         curZone_Hits[curZone_Found] = zone_touchCount;
         curZone_Start[curZone_Found] = currentBar;
         curZone_Merge[curZone_Found] = false;
         
         if (zone_touchCount > 3)
            curZone_Strength[curZone_Found] = ZONE_WEAK;
         else if (zone_touchCount > 0)
            curZone_Strength[curZone_Found] = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            curZone_Strength[curZone_Found] = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            curZone_Strength[curZone_Found] = ZONE_UNTESTED;
         else
            curZone_Strength[curZone_Found] = ZONE_POSSIBLE;

         curZone_Found++;
      }
      //--- Display historical zones
      else if (zone_showbroken) {
         burstZone_H[burstZone_Found] = HValue;
         burstZone_L[burstZone_Found] = LValue;
         burstZone_Turncoat[burstZone_Found] = zone_confirmTurncoat;
         burstZone_Hits[burstZone_Found] = zone_touchCount;
         burstZone_Start[burstZone_Found] = currentBar;
         burstZone_End[burstZone_Found] = zone_borkenBarCount;
         burstZone_Merge[burstZone_Found] = false;

         if (zone_touchCount > 3)
            burstZone_Strength[burstZone_Found] = ZONE_WEAK;
         else if (zone_touchCount > 0)
            burstZone_Strength[burstZone_Found] = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            burstZone_Strength[burstZone_Found] = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            burstZone_Strength[burstZone_Found] = ZONE_UNTESTED;
         else
            burstZone_Strength[burstZone_Found] = ZONE_POSSIBLE;

         burstZone_Found++;
      }
   }//---
//--- Find Support zones -------------------------------------
   else if (FastDnPts[currentBar] > 0.001){
      zone_isPossible = true;
      if (SlowDnPts[currentBar] > 0.001) zone_isPossible = false;

      LValue = cur_Low;
      if (zone_extend == true) LValue -= zone_fuzzValue;

      HValue = MathMin(MathMax(cur_Close, cur_Low+zone_fuzzValue), cur_Low+zone_fuzzValue*2);
      zone_isTurncoat = false;
      zone_confirmTurncoat = false;

      zone_bustCount=0;
      zone_touchCount=0;
      zone_borkenBarCount=0;
      zone_isBusted=false;

      for (i=currentBar-1; i>=LatestBar + 0; i--) {
         H_iValue = iHigh(NULL, TimeFrame, i);
         L_iValue = iLow(NULL, TimeFrame, i);

         if ((zone_isTurncoat == true && FastUpPts[i] >= LValue && FastUpPts[i] <= HValue) ||
             (zone_isTurncoat == false && FastDnPts[i] <= HValue && FastDnPts[i] >= LValue)
         ){
            zone_isTouched = true;
            for (j=i+1; j<i+11; j++){
               if ((zone_isTurncoat == true && FastUpPts[j] >= LValue && FastUpPts[j] <= HValue) ||
                   (zone_isTurncoat == false && FastDnPts[j] <= HValue && FastDnPts[j] >= LValue)
               ){
                  zone_isTouched = false;
                  break;
               }
            }

            if (zone_isTouched == true){
               zone_bustCount = 0;
               zone_touchCount++;
            }
         }

         if ((zone_isTurncoat == true && H_iValue > HValue) ||
             (zone_isTurncoat == false && L_iValue < LValue)
         ){
            // this level has been busted at least once
            zone_bustCount++;
            zone_borkenBarCount = MathMax(zone_borkenBarCount, i);

            if (zone_bustCount > 1 || zone_isPossible == true){
               // busted twice or more
               zone_isBusted = true;
               break;
            }

            zone_isTurncoat = !zone_isTurncoat;
            zone_confirmTurncoat = true;
            zone_touchCount = 0;
         }
      }//--- End for loop
      
      if (zone_isBusted == false){
         curZone_H[curZone_Found] = HValue;
         curZone_L[curZone_Found] = LValue;
         curZone_Turncoat[curZone_Found] = zone_confirmTurncoat;
         curZone_Hits[curZone_Found] = zone_touchCount;
         curZone_Start[curZone_Found] = currentBar;
         curZone_Merge[curZone_Found] = false;

         if (zone_touchCount > 3)
            curZone_Strength[curZone_Found] = ZONE_WEAK;
         else if (zone_touchCount > 0)
            curZone_Strength[curZone_Found] = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            curZone_Strength[curZone_Found] = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            curZone_Strength[curZone_Found] = ZONE_UNTESTED;
         else
            curZone_Strength[curZone_Found] = ZONE_POSSIBLE;

         curZone_Found++;
      }
      else if (zone_showbroken)
      {
         // level is broken, but we're showing it anyway
         burstZone_H[burstZone_Found] = HValue;
         burstZone_L[burstZone_Found] = LValue;
         burstZone_Turncoat[burstZone_Found] = zone_confirmTurncoat;
         burstZone_Hits[burstZone_Found] = zone_touchCount;
         burstZone_Start[burstZone_Found] = currentBar;
         burstZone_End[burstZone_Found] = zone_borkenBarCount;
         burstZone_Merge[burstZone_Found] = false;

         if (zone_touchCount > 3)
            burstZone_Strength[burstZone_Found] = ZONE_WEAK;
         else if (zone_touchCount > 0)
            burstZone_Strength[burstZone_Found] = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            burstZone_Strength[burstZone_Found] = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            burstZone_Strength[burstZone_Found] = ZONE_UNTESTED;
         else
            burstZone_Strength[burstZone_Found] = ZONE_POSSIBLE;

         burstZone_Found++;
      }
   }//---
   
}//---

//+------------------------------------------------------------------+
//| Function to merge overlapping zones
//+------------------------------------------------------------------+
void MergeZones(const double &close[])
{
   int i,j;
   
   //--- Merge Zones -------------------------------------------------
   if (zone_merge == true){
      merge_count = 1;
      int iterations = 0, target, source;
      
      while (merge_count>0 && iterations<3){
         merge_count = 0;
         iterations++;
         
         
         //--- Reset current merge aount
         for (i=0; i<curZone_Found; i++)
            curZone_Merge[i] = false;

         //--- Iterating through all founded zones
         for (i = 0; i < curZone_Found-1; i++){
            //--- Ignore if current zone has not been verified or has been merged
            if (curZone_Hits[i] == -1 || curZone_Merge[j] == true)
               continue;



            //--- Search forward zones
            for (j = i+1; j < curZone_Found; j++){
               //--- Ignore if that zone has not been verified or has been merged
               if (curZone_Hits[j] == -1 || curZone_Merge[j] == true)
                  continue;

               //--- Check if current zone is overlapping with future zone and mark them
               if ((curZone_H[i] >= curZone_L[j] && curZone_H[i] <= curZone_H[j]) ||
                   (curZone_L[i] <= curZone_H[j] && curZone_L[i] >= curZone_L[j]) ||
                   (curZone_H[j] >= curZone_L[i] && curZone_H[j] <= curZone_H[i]) ||
                   (curZone_L[j] <= curZone_H[i] && curZone_L[j] >= curZone_L[i]))
               {
                  merge_Target[merge_count] = i;
                  merge_Source[merge_count] = j;
                  curZone_Merge[i] = true;
                  curZone_Merge[j] = true;
                  merge_count++;
               }
            }
         }

         //--- Merging zones
         for (i=0; i<merge_count; i++){
            target = merge_Target[i];
            source = merge_Source[i];

            curZone_H[target] = MathMax(curZone_H[target], curZone_H[source]);
            curZone_L[target] = MathMin(curZone_L[target], curZone_L[source]);
            curZone_Hits[target] += curZone_Hits[source];
            curZone_Start[target] = MathMax(curZone_Start[target], curZone_Start[source]);
            curZone_Strength[target] = MathMax(curZone_Strength[target], curZone_Strength[source]);
            
            if (curZone_Hits[target] > 3)
               curZone_Strength[target] = ZONE_WEAK;

            if (curZone_Hits[target] == 0 && curZone_Turncoat[target] == false){
               curZone_Hits[target] = 1;
               if (curZone_Strength[target] < ZONE_VERIFIED)
                  curZone_Strength[target] = ZONE_VERIFIED;
            }

            if (curZone_Turncoat[target] == false || curZone_Turncoat[source] == false)
               curZone_Turncoat[target] = false;
            
            if (curZone_Turncoat[target] == true)
               curZone_Hits[target] = 0;

            curZone_Hits[source] = -1;
         }
      }//--- End while loop
      
   
      //--- Display historical zones
      if (zone_showbroken){
         mergeBroken_count = 1;
         iterations = 0;
         
         while (mergeBroken_count > 0 && iterations < 3){
            mergeBroken_count = 0;
            iterations++;
   
            for (i = 0; i < burstZone_Found; i++)
               burstZone_Merge[i] = false;

            for (i = 0; i < burstZone_Found-1; i++){
               if (burstZone_Hits[i] == -1 || burstZone_Merge[j] == true)
                  continue;

               for (j = i+1; j < burstZone_Found; j++){
                  if (burstZone_Hits[j] == -1 || burstZone_Merge[j] == true)
                     continue;

                  if ((burstZone_H[i] >= burstZone_L[j] && burstZone_H[i] <= burstZone_H[j]) ||
                      (burstZone_L[i] <= burstZone_H[j] && burstZone_L[i] >= burstZone_L[j]) ||
                      (burstZone_H[j] >= burstZone_L[i] && burstZone_H[j] <= burstZone_H[i]) ||
                      (burstZone_L[j] <= burstZone_H[i] && burstZone_L[j] >= burstZone_L[i]))
                  {
                     mergeBroken_Target[mergeBroken_count] = i;
                     mergeBroken_Source[mergeBroken_count] = j;
                     burstZone_Merge[i] = true;
                     burstZone_Merge[j] = true;
                     mergeBroken_count++;
                  }
               }
            }

            // ... and merge them ...
            for (i=0; i<mergeBroken_count; i++){
               target = mergeBroken_Target[i];
               source = mergeBroken_Source[i];

               burstZone_H[target] = MathMax(burstZone_H[target], burstZone_H[source]);
               burstZone_L[target] = MathMin(burstZone_L[target], burstZone_L[source]);
               burstZone_Hits[target] += burstZone_Hits[source];
               burstZone_Start[target] = MathMax(burstZone_Start[target], burstZone_Start[source]);
               burstZone_End[target] = MathMax(burstZone_End[target], burstZone_End[source]);
               burstZone_Strength[target] = MathMax(burstZone_Strength[target], burstZone_Strength[source]);
               if (burstZone_Hits[target] > 3)
                  burstZone_Strength[target] = ZONE_WEAK;

               if (burstZone_Hits[target] == 0 && burstZone_Turncoat[target] == false){
                  burstZone_Hits[target] = 1;
                  if (burstZone_Strength[target] < ZONE_VERIFIED)
                     burstZone_Strength[target] = ZONE_VERIFIED;
               }

               if (burstZone_Turncoat[target] == false || burstZone_Turncoat[source] == false)
                  burstZone_Turncoat[target] = false;
               if (burstZone_Turncoat[target] == true)
                  burstZone_Hits[target] = 0;

               burstZone_Hits[source] = -1;
            }
         }//--- End while loop
      }//--- End show broken
      
   }//--- End merging

   //--- Copy the remaining list into our official zones arrays
   zone_Found=0;
   for (i=0; i<curZone_Found; i++){
      if (curZone_Hits[i] >= 0 && zone_Found < zone_limit){
         
         zone_H[zone_Found]         = curZone_H[i];
         zone_L[zone_Found]         = curZone_L[i];
         zone_Hits[zone_Found]      = curZone_Hits[i];
         zone_Turncoat[zone_Found]  = curZone_Turncoat[i];
         zone_Start[zone_Found]     = curZone_Start[i];
         zone_Strength[zone_Found]  = curZone_Strength[i];
         zone_End[zone_Found]       = LatestBar + 0;
         
         if (zone_H[zone_Found] < close[LatestBar + 4])
            zone_Type[zone_Found] = ZONE_SUPPORT;
         else if (zone_L[zone_Found] > close[LatestBar + 4])
            zone_Type[zone_Found] = ZONE_RESIST;
         else{
            for (j=LatestBar + 5; j< LatestBar + 1000; j++){
               if (close[j] < zone_L[curZone_Found]){
                  zone_Type[zone_Found] = ZONE_RESIST;
                  break;
               }
               else if (close[j] > zone_H[curZone_Found]){
                  zone_Type[zone_Found] = ZONE_SUPPORT;
                  break;
               }
            }

            if (j == LatestBar + 1000)
               zone_Type[curZone_Found] = ZONE_SUPPORT;
         }

         zone_Found++;
      }
   }//--- End for loop
}//---


//+------------------------------------------------------------------+
//| Function to retrieve broken zones
//+------------------------------------------------------------------+
void BrokenZones()
{
   for (int i=burstZone_Found-1; i>=0; i--){
      if (burstZone_Hits[i] >= 0 && zone_Found < zone_limit){
         zone_H[zone_Found]         = burstZone_H[i];
         zone_L[zone_Found]         = burstZone_L[i];
         zone_Hits[zone_Found]      = burstZone_Hits[i];
         zone_Turncoat[zone_Found]  = burstZone_Turncoat[i];
         zone_Start[zone_Found]     = burstZone_Start[i];
         zone_Strength[zone_Found]  = burstZone_Strength[i];
         zone_End[zone_Found]       = burstZone_End[i];
         zone_Type[zone_Found]      = ZONE_BROKEN;
         zone_Found++;
      }
   }
}

//+------------------------------------------------------------------+
//| Function to draw zones
//+------------------------------------------------------------------+
void DrawZones(const datetime &time[])
{
   string fontName="Calibri";
   int fontSize=8;

   fn_RemoveObjects("SR#");
   
   //--- Iterate through all found zones and display them
   for (int i=0; i<zone_Found; i++){
   
      if (zone_Strength[i] == ZONE_UNTESTED && zone_show_untested == False)
         continue;
     
      if (zone_Strength[i] == ZONE_VERIFIED && zone_show_verified == False)
         continue;
   
      if (zone_Strength[i] == ZONE_POSSIBLE && zone_show_possible == false)
         continue;
         
      if (zone_Strength[i] == ZONE_WEAK && zone_show_weak == false)
         continue;

      if (zone_Strength[i] == ZONE_TURNCOAT && zone_show_truncoat == false)
         continue;

      string objName = "SR#" + TimeToString(time[zone_Start[i]],TIME_DATE|TIME_MINUTES) + "_";
      color objColor = clrSilver;
      datetime startTime = time[zone_Start[i]];
      datetime endTime = time[zone_End[i]] + ShiftEndRight * PeriodSeconds();
      datetime lblTime = time[0] + ShiftEndRight * PeriodSeconds();
      double startPrice = zone_H[i];
      double endPrice = zone_L[i];
      string zoneWidth = DoubleToStr((zone_H[i] - zone_L[i])/myPoint,0) + " pips";
      string zoneTest = "Test count " + IntegerToString(zone_Hits[i]) + "times";
      
      string lblName = "SR#LBL" + TimeToString(time[zone_Start[i]],TIME_DATE|TIME_MINUTES) + "_";
      string lblDescription;
      
      if(zone_Type[i]==ZONE_SUPPORT){
         switch(zone_Strength[i]){
            case ZONE_TURNCOAT:
               objName = objName + "S_ZONE_TURNCOAT";
               objColor=color_support_turncoat;
               
               lblName = lblName + "S_ZONE_TURNCOAT";
               lblDescription = "Turncoat Support-" + zoneWidth;
               
               break;
            case ZONE_WEAK:
               objName = objName + "S_ZONE_WEAK";
               objColor=color_support_weak;
               
               lblName = lblName + "S_ZONE_WEAK";
               lblDescription = "Weak Support-" + zoneWidth;
               break;
            case ZONE_VERIFIED:
               objName = objName + "S_ZONE_VERIFIED";
               objColor=color_support_verified;
               
               lblName = lblName + "S_ZONE_VERIFIED";
               lblDescription = "Verified Support-" + zoneWidth;
               break;
            case ZONE_UNTESTED:
               objName = objName + "S_ZONE_UNTESTED";
               objColor=color_support_untested;
               
               lblName = lblName + "S_ZONE_UNTESTED";
               lblDescription = "Untested Support-" + zoneWidth;
               break;
            case ZONE_POSSIBLE:
               objName = objName + "S_ZONE_POSSIBLE";
               objColor=color_support_possible;
               
               lblName = lblName + "S_ZONE_POSSIBLE";
               lblDescription = "Possible Support-" + zoneWidth;
               break;
            default:
               break;
         }
      }else if (zone_Type[i] == ZONE_RESIST){
         switch(zone_Strength[i]){
            case ZONE_TURNCOAT:
               objName = objName + "R_ZONE_TURNCOAT";
               objColor=color_resist_turncoat;
               
               lblName = lblName + "R_ZONE_TURNCOAT";
               lblDescription = "Turncoat Resist-" + zoneWidth;
               break;
            case ZONE_WEAK:
               objName = objName + "R_ZONE_WEAK";
               objColor=color_resist_weak;
               
               lblName = lblName + "R_ZONE_WEAK";
               lblDescription = "Weak Resist-" + zoneWidth;
               break;
            case ZONE_VERIFIED:
               objName = objName + "R_ZONE_VERIFIED";
               objColor=color_resist_verified;
               
               lblName = lblName + "R_ZONE_VERIFIED";
               lblDescription = "Verified Resist-" + zoneWidth;
               break;
            case ZONE_UNTESTED:
               objName = objName + "R_ZONE_UNTESTED";
               objColor=color_resist_untested;
               
               lblName = lblName + "R_ZONE_UNTESTED";
               lblDescription = "Untested Resist-" + zoneWidth;
               break;
            case ZONE_POSSIBLE:
               objName = objName + "R_ZONE_POSSIBLE";
               objColor=color_resist_possible;
               
               lblName = lblName + "R_ZONE_POSSIBLE";
               lblDescription = "Possible Resist-" + zoneWidth;
               break;
            default:
               break;
         }      
      }else{
         switch(zone_Strength[i]){
            case ZONE_WEAK:
               objName = objName + "H_ZONE_WEAK";
               objColor=color_broken_weak;
               break;
            case ZONE_VERIFIED:
               objName = objName + "H_ZONE_VERIFIED";            
               objColor=color_broken_verified;
               break;
            default:
               objName = objName + "H_OTHER";
               objColor=color_broken_other;
               break;
         }      
      }
      
      //--- For each rectangle object, remove then draw again
      fn_DrawRectangle(objName,startTime,endTime,startPrice,endPrice,objColor,zone_linewidth,zone_style,zone_solid);
      //--- For each label object, if already there then move
      fn_DisplayText(lblName,lblTime,(startPrice+endPrice)*0.5,fontSize,fontName,objColor,lblDescription);
   }
   
}

//+------------------------------------------------------------------+


