//+------------------------------------------------------------------+
//|                                            SupportResistance.mq5 |
//|                                                      Khoa Nguyen |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description   "\nv3.00: Implement in MQL5"

//+------------------------------------------------------------------+
//| Include and Import sections
//+------------------------------------------------------------------+
#include  <KhoaIndicators\IndicatorEnumerations.mqh>

#import "IndicatorLibrary.ex5"
bool fn_RemoveObjects(string objName);
double fn_RoundNearest(double frmValue, double toValue);
void fn_ShowCounter(int LoacalToServerTime);
bool fn_FillFractalBuffers(const int currentBar, const int fractalRange, double &fractalH[], double &fractalL[]);
void fn_DrawRectangle(string objName,datetime objTime1,datetime objTime2,double objPrice1,double objPrice2,color objColor,int objWidth,int objStyle,bool objBackground);
void fn_DisplayText(string objName, datetime time, double priceLevel,ENUM_ANCHOR_POINT anchor,double angle, int fontSize, string fontName,color fontColor, string content);
bool fn_SessionStartTime(datetime& brokerDiffTime,datetime& SydneyStart,datetime& TokyoStart,datetime& LondonStart,datetime& NewYorkStart);
int fn_DayOfWeek(datetime time);
int ATRHandle(string symbol,ENUM_TIMEFRAMES timeframe,int period);
double fn_GetBufferCurrentValue(int handle,int currentBar);

#import

//+------------------------------------------------------------------+
//| Enumerations declaration
//+------------------------------------------------------------------+
enum ZONE_TYPE
{
   ZONE_SUPPORT=1,
   ZONE_RESIST=2,
   ZONE_BROKEN=3, 
};

enum ZONE_STATUS
{
   ZONE_POSSIBLE=1,
   ZONE_UNTESTED=2,
   ZONE_TURNCOAT=3,   
   ZONE_VERIFIED=4,
   ZONE_STRONG=5,  
};

//+------------------------------------------------------------------+
//| Structure declaration
//+------------------------------------------------------------------+
struct ZoneTruct
{
   double      zone_H;              // Zone high value
   double      zone_L;              // Zone low value
   int         zone_StartBar;       // Zone start bar
   int         zone_EndBar;         // Zone end bar
   int         zone_Hits;           // Zone verification times
   ZONE_TYPE   zone_Type;           // Zone type
   ZONE_STATUS zone_Status;         // Zone status
   bool        zone_IsTurncoat;     // Zone turncoat flag   
   bool        zone_IsMerge;        // Zone merge flag
};

//+------------------------------------------------------------------+
//| Indicator Properties
//+------------------------------------------------------------------+
#property strict
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_plots   4

double FastLow[];
double FastHigh[];
double SlowLow[];
double SlowHigh[];

//+------------------------------------------------------------------+
//| Indicator Inputs
//+------------------------------------------------------------------+
input ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT;  //Timeframe

input string  SHOW_ZONES            = "==========SHOW ZONES==========";
input bool   showFractal            = true;        //Show Fractals
input bool   show_Counter           = true;        //Show Clock
input bool   zone_show_verified     = true;        //Show Verified zones
input bool   zone_show_turncoat     = true;        //Show Turncoat zones
input bool   zone_show_strong       = true;        //Show Strong zones
input bool   zone_show_untested     = false;
input bool   zone_show_possible     = false;
input bool   zone_showbroken        = false;

input string  STYLE_ZONES            = "==========STYLE ZONES==========";
input bool   zone_merge             = true;        //Merge Zone
input bool   zone_isExtend          = false;       //Extend Zone
input bool   zone_solid             = false;        //Display Background
input int    zone_linewidth         = 1;           //Zone thickness
input ENUM_LINE_STYLE zone_style    = STYLE_DOT;   //Zone Style
input int    ShiftEndRight          = 5;           //Extend the end of zones X bars beyond last bar
input int    zone_limit             = 1000;        //Max number of bars per zone

input string  ZONES_COLOR             = "==========COLOR ZONES==========";
input color   color_support_verified  = clrNavy;
input color   color_resist_verified   = clrMaroon;

input color   color_support_strong    = clrDarkGreen;
input color   color_resist_strong     = clrFireBrick;

input color   color_support_turncoat  = clrIndigo;
input color   color_resist_turncoat   = clrIndigo;

input color   color_support_possible  = clrDarkSlateGray;
input color   color_resist_possible   = clrDarkSlateGray;

input color   color_support_untested  = clrDarkSlateGray;
input color   color_resist_untested   = clrDarkSlateGray;

input color   color_broken_weak       = clrDarkSlateGray;
input color   color_broken_verified   = clrGray;
input color   color_broken_other      = clrDimGray;

input string  ZONE_FRACTALS         = "==========ZONE FRACTALS==========";
input double  zone_fuzzfactor        = 0.75;       //Fuzzy factor
input int     fractal_FastFactor    = 4;           //Fast Fractals scan range
input int     fractal_SlowFactor    = 8;           //Slow Fractals scan range

//+------------------------------------------------------------------+
//| Indicator Variables
//+------------------------------------------------------------------+
int      limit=0;             //Number of bars for calculation
int      ExtBegin=0;          //To define a bar to perform calculation from
int      NumberOfBars=5000;   //Number of bars
int      checkBarsCalc=0;     //Number of bars required for calculation

//--- Arrays to store zones
ZoneTruct CurrentZones[1000];
ZoneTruct TempZones[1000];
ZoneTruct BurstZones[1000];

int    idx_ZoneFound=0;          // Index and count of found zones
int    idx_BurstZone=0;          // Index and count of bursted zones
int    idx_ZoneAfterMerged=0;    // Index annd count of zones after merged

//--- Varibale to verify zone is Support/Resistance
int   zone_touchCount=0;
int   zone_burstCount=0;
int   zone_brokenBarCount=0;
int   zone_StartBar=0;

int    merge_Target[1000];
int    merge_Source[1000];
int    merge_count=0;
int    mergeBroken_Target[1000];
int    mergeBroken_Source[1000];
int    mergeBroken_count=0;

//--- Environments variables
int ATRHdl;

int time_offset=0;
int LatestBar=0;              //Last visible bar on the chart - in Testing mode
int localToServer;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   fn_RemoveObjects("SRZone#");
   fn_RemoveObjects("Counter_"); 
   
   SetPropertiesIndicator();
   EventSetMillisecondTimer(100);
//---
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   fn_RemoveObjects("SRZone#");
   fn_RemoveObjects("Counter_"); 
   
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
   localToServer = (int)fn_RoundNearest(TimeCurrent() - TimeLocal(), 1800);

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

   //--- If this is the first calculation
   if(prev_calculated==0) {
      //--- Reset indicator buffers
      ZeroIndicatorBuffers();
      //--- Reset variables
      ZeroTemporaryVariables();
      //--- Check the amount of available data
      if(!CheckDataAvailable())
         return(0);
      //--- If more data specified for copying, the current amount is used
      DetermineNumberData();
      //--- Define the bar plotting for each symbol starts from
      DetermineBeginForCalculate(rates_total);

   } else {
      //--- Calculate the last value only
      ExtBegin=MathMax(rates_total-prev_calculated, fractal_SlowFactor);      
   }
   
   //--- Fill in the High Bid and Low Ask indicator buffers
   for(int i=0; i<ExtBegin; i++) {
      fn_FillFractalBuffers(i,fractal_FastFactor,FastHigh,FastLow);
      fn_FillFractalBuffers(i,fractal_SlowFactor,SlowHigh,SlowLow);  
   }   
   
   for(int i=ExtBegin;i>0;i--) {
      FindZones(i, time, high, low, open, close);
   }

   if(zone_merge) MergeZones(close);
   if(zone_showbroken) BrokenZones();
   DrawZones(time);

   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   if(show_Counter)
      fn_ShowCounter(localToServer);
   else
      fn_RemoveObjects("Counter_");
   
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
//| Function to find support and resistance zones
//+------------------------------------------------------------------+
void FindZones(int currentBar
               ,const datetime &time[]
               ,const double &high[]
               ,const double &low[]
               ,const double &open[]
               ,const double &close[]
               )
{
   int i, j;
   
   //--- Variable to store High and Low price of currentBar
   double H_Value=0, L_Value=0;
   //--- Varuable to store High and Low price of bar in front of currentBar        
   double H_iValue=0, L_iValue=0;       
   //--- Varibale to verify zone is Support/Resistance
   bool zone_isPossible=false;
   bool zone_isTurncoat=false;
   bool zone_confirmTurncoat=false;
   bool zone_isTouched=false;   
   bool zone_isBusted=false;
   
   
   //--- Calculate zone width based on ATR and zone_fuzzValue
   double atr = fn_GetBufferCurrentValue(ATRHdl,currentBar);
   double zone_fuzzValue = atr/2*zone_fuzzfactor;
      
   double cur_Close = close[currentBar];
   double cur_High  = high[currentBar];
   double cur_Low   = low[currentBar];

   //--- Find Resistance zones -------------------------------------      
   if (FastHigh[currentBar] > 0.001) {

      //--- Find Possible zones
      zone_isPossible = true;
      if (SlowHigh[currentBar] > 0.001) zone_isPossible = false;

      //--- Determine zone High and Low
      H_Value = cur_High;
      if (zone_isExtend == true) H_Value += zone_fuzzValue;
      L_Value = MathMax(MathMin(cur_Close,cur_High-zone_fuzzValue), cur_High-zone_fuzzValue*2); 
      
      //--- Initialize variables
      zone_isTurncoat = false;
      zone_confirmTurncoat = false;
      zone_isBusted = false;

      zone_burstCount = 0;
      zone_touchCount = 0;
      zone_brokenBarCount = 0;

      //--- Check past bars to determine type of zone
      for (i=currentBar-1; i>=0; i--) {
         //--- continue looking for high and low value
         H_iValue = high[i];
         L_iValue = low[i];

         //--- Check Zone 
            //--- If Zone is not TurnCoat and past FastHigh is within H_Value and L_Value of currentBar
            //--- If Zone is TurnCoat and past FastLow is within H_Value and L_Value of currentBar
         if ((zone_isTurncoat == false && FastHigh[i] >= L_Value && FastHigh[i] <= H_Value) ||
             (zone_isTurncoat == true && FastLow[i] >= L_Value && FastLow[i] <= H_Value)
         ){
            //--- Zone has been confirmed
            zone_isTouched = true;
            //--- Make sure its been 10+ candles since the prev touch
            for (j=i+1; j<i+fractal_SlowFactor; j++){
               if ((zone_isTurncoat == false && FastHigh[j] >= L_Value && FastHigh[j] <= H_Value) ||
                   (zone_isTurncoat == true && FastLow[j] <= H_Value && FastLow[j] >= L_Value))
               {
                  zone_isTouched = false;
                  break;
               }
            }
            
            //--- Zone confirmed. Update number of touches and reset number of burst
            if (zone_isTouched == true){
               zone_burstCount = 0;
               zone_touchCount++;
               zone_StartBar=i;
            }
         }

         //--- Check Broken Zones
            //--- If Zone is not TurnCoat and H_iValue > H_Value this means zone has been broken
            //--- If Zone is TurnCoat and L_iValue < L_Value this means zone has been broken
         if ((zone_isTurncoat == false && H_iValue > H_Value) ||
             (zone_isTurncoat == true && L_iValue < L_Value)
         ){
            //--- Update bust count
            zone_burstCount++;
            zone_brokenBarCount = MathMax(zone_brokenBarCount, i);
            zone_StartBar=i;

            //--- If zone has been broken more than 2 then confirm it's busted
            if (zone_burstCount > 1 || zone_isPossible == true){
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
         CurrentZones[idx_ZoneFound].zone_H = H_Value;
         CurrentZones[idx_ZoneFound].zone_L = L_Value;
         CurrentZones[idx_ZoneFound].zone_IsTurncoat = zone_confirmTurncoat;
         CurrentZones[idx_ZoneFound].zone_Hits = zone_touchCount;
         CurrentZones[idx_ZoneFound].zone_StartBar = currentBar;
         CurrentZones[idx_ZoneFound].zone_EndBar = 0;
         CurrentZones[idx_ZoneFound].zone_IsMerge = false;  
         CurrentZones[idx_ZoneFound].zone_Type = ZONE_RESIST;
                  
         if (zone_touchCount > 3)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_STRONG;
         else if (zone_touchCount > 0)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_UNTESTED;
         else
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_POSSIBLE;

         idx_ZoneFound++;
      }
      //--- Display historical zones
      else if (zone_showbroken) {
         BurstZones[idx_BurstZone].zone_H = H_Value;
         BurstZones[idx_BurstZone].zone_L = L_Value;
         BurstZones[idx_BurstZone].zone_IsTurncoat = zone_confirmTurncoat;
         BurstZones[idx_BurstZone].zone_Hits = zone_touchCount;
         BurstZones[idx_BurstZone].zone_StartBar = currentBar;
         BurstZones[idx_BurstZone].zone_EndBar = zone_brokenBarCount;
         BurstZones[idx_BurstZone].zone_IsMerge = false;
         BurstZones[idx_BurstZone].zone_Type = ZONE_RESIST;

         if (zone_touchCount > 3)
            BurstZones[idx_BurstZone].zone_Status = ZONE_STRONG;
         else if (zone_touchCount > 0)
            BurstZones[idx_BurstZone].zone_Status = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            BurstZones[idx_BurstZone].zone_Status = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            BurstZones[idx_BurstZone].zone_Status = ZONE_UNTESTED;
         else
            BurstZones[idx_BurstZone].zone_Status = ZONE_POSSIBLE;

         idx_BurstZone++;
      }
   }//---
   
   //--- Find Support zones -------------------------------------
   else if (FastLow[currentBar] > 0.001){
      zone_isPossible = true;
      if (SlowLow[currentBar] > 0.001) zone_isPossible = false;

      L_Value = cur_Low;
      if (zone_isExtend == true) L_Value -= zone_fuzzValue;
      H_Value = MathMin(MathMax(cur_Close, cur_Low+zone_fuzzValue), cur_Low+zone_fuzzValue*2);
      
      
      zone_isTurncoat = false;
      zone_confirmTurncoat = false;

      zone_burstCount=0;
      zone_touchCount=0;
      zone_brokenBarCount=0;
      zone_isBusted=false;

      for (i=currentBar-1; i>0; i--) {
         H_iValue = high[i];
         L_iValue = low[i];

         if ((zone_isTurncoat == true && FastHigh[i] >= L_Value && FastHigh[i] <= H_Value) ||
             (zone_isTurncoat == false && FastLow[i] >= L_Value && FastLow[i] <= H_Value)
         ){
            zone_isTouched = true;
            for (j=i+1; j<i+fractal_SlowFactor; j++){
               if ((zone_isTurncoat == true && FastHigh[j] >= L_Value && FastHigh[j] <= H_Value) ||
                   (zone_isTurncoat == false && FastLow[j] <= H_Value && FastLow[j] >= L_Value)
               ){
                  zone_isTouched = false;
                  break;
               }
            }

            if (zone_isTouched == true){
               zone_burstCount = 0;
               zone_touchCount++;
               zone_StartBar=i;
            }
         }
         
         //--- Check Broken Zones
            //--- If Zone is not TurnCoat and H_iValue > H_Value this means zone has been broken
            //--- If Zone is TurnCoat and L_iValue < L_Value this means zone has been broken
         if ((zone_isTurncoat == true && H_iValue > H_Value) ||
             (zone_isTurncoat == false && L_iValue < L_Value)
         ){
            // this level has been busted at least once
            zone_burstCount++;
            zone_brokenBarCount = MathMax(zone_brokenBarCount, i);
            zone_StartBar=i;

            if (zone_burstCount > 1 || zone_isPossible == true){
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
         CurrentZones[idx_ZoneFound].zone_H = H_Value;
         CurrentZones[idx_ZoneFound].zone_L = L_Value;
         CurrentZones[idx_ZoneFound].zone_IsTurncoat = zone_confirmTurncoat;
         CurrentZones[idx_ZoneFound].zone_Hits = zone_touchCount;
         CurrentZones[idx_ZoneFound].zone_StartBar = currentBar;
         CurrentZones[idx_ZoneFound].zone_EndBar = 0;
         CurrentZones[idx_ZoneFound].zone_IsMerge = false;
         CurrentZones[idx_ZoneFound].zone_Type = ZONE_SUPPORT;         
      
         if (zone_touchCount > 3)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_STRONG;
         else if (zone_touchCount > 0)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_UNTESTED;
         else
            CurrentZones[idx_ZoneFound].zone_Status = ZONE_POSSIBLE;

         idx_ZoneFound++;
      }
      else if (zone_showbroken) {
         BurstZones[idx_BurstZone].zone_H = H_Value;
         BurstZones[idx_BurstZone].zone_L = L_Value;
         BurstZones[idx_BurstZone].zone_IsTurncoat = zone_confirmTurncoat;
         BurstZones[idx_BurstZone].zone_Hits = zone_touchCount;
         BurstZones[idx_BurstZone].zone_StartBar = currentBar;
         BurstZones[idx_BurstZone].zone_EndBar = zone_brokenBarCount;
         BurstZones[idx_BurstZone].zone_IsMerge = false;
         BurstZones[idx_BurstZone].zone_Type = ZONE_SUPPORT;

         if (zone_touchCount > 3)
            BurstZones[idx_BurstZone].zone_Status = ZONE_STRONG;
         else if (zone_touchCount > 0)
            BurstZones[idx_BurstZone].zone_Status = ZONE_VERIFIED;
         else if (zone_confirmTurncoat == true)
            BurstZones[idx_BurstZone].zone_Status = ZONE_TURNCOAT;
         else if (zone_isPossible == false)
            BurstZones[idx_BurstZone].zone_Status = ZONE_UNTESTED;
         else
            BurstZones[idx_BurstZone].zone_Status = ZONE_POSSIBLE;

         idx_BurstZone++;
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
         for (i=0; i<idx_ZoneFound; i++)
            CurrentZones[i].zone_IsMerge = false;

         //--- Iterating through all founded zones to identify if can be merged
         for (i=0; i<idx_ZoneFound-1; i++){
            //--- Ignore if current zone has not been verified or has been merged
            if (CurrentZones[i].zone_Hits<0 || CurrentZones[i].zone_IsMerge == true)
               continue;

            //--- Search forward zones
            for (j=i+1; j<idx_ZoneFound; j++){
               //--- Ignore if that zone has not been verified or has been merged
               if (CurrentZones[j].zone_Hits<0 || CurrentZones[j].zone_IsMerge == true)
                  continue;

               //--- Check if current zone is overlapping with future zone and mark them
               if ((CurrentZones[i].zone_H >= CurrentZones[j].zone_L && CurrentZones[i].zone_H <= CurrentZones[j].zone_H) ||
                   (CurrentZones[i].zone_L <= CurrentZones[j].zone_H && CurrentZones[i].zone_L >= CurrentZones[j].zone_L) ||
                   (CurrentZones[j].zone_H >= CurrentZones[i].zone_L && CurrentZones[j].zone_H <= CurrentZones[i].zone_H) ||
                   (CurrentZones[j].zone_L <= CurrentZones[i].zone_H && CurrentZones[j].zone_L >= CurrentZones[i].zone_L))
               {
                  merge_Target[merge_count] = i;
                  merge_Source[merge_count] = j;
                  CurrentZones[i].zone_IsMerge = true;
                  CurrentZones[j].zone_IsMerge = true;
                  merge_count++;
               }
            }//--- End j loop
         }//--- End i loop

         //--- Begin Merging zones
         for (i=0; i<merge_count; i++){
            target = merge_Target[i];
            source = merge_Source[i];

            CurrentZones[target].zone_H = MathMax(CurrentZones[target].zone_H, CurrentZones[source].zone_H);
            CurrentZones[target].zone_L = MathMin(CurrentZones[target].zone_L, CurrentZones[source].zone_L);
            CurrentZones[target].zone_Hits += CurrentZones[source].zone_Hits;
            CurrentZones[target].zone_StartBar = MathMax(CurrentZones[target].zone_StartBar, CurrentZones[source].zone_StartBar);
            CurrentZones[target].zone_Status = MathMax(CurrentZones[target].zone_Status, CurrentZones[source].zone_Status);
            
            if (CurrentZones[target].zone_Hits > 3)
               CurrentZones[target].zone_Status = ZONE_STRONG;

            if (CurrentZones[target].zone_Hits == 0 && CurrentZones[target].zone_IsTurncoat == false){
               CurrentZones[target].zone_Hits = 1;
               if (CurrentZones[target].zone_Status != ZONE_VERIFIED)
                  CurrentZones[target].zone_Status = ZONE_VERIFIED;
            }

            if (CurrentZones[target].zone_IsTurncoat == false || CurrentZones[source].zone_IsTurncoat == false)
               CurrentZones[target].zone_IsTurncoat = false;
            
            if (CurrentZones[target].zone_IsTurncoat == true)
               CurrentZones[target].zone_Hits = 0;

            CurrentZones[source].zone_Hits = -1;
         }
      }//--- End while loop
      
   
      //--- Display historical zones
      if (zone_showbroken){
         mergeBroken_count = 1;
         iterations = 0;
         
         while (mergeBroken_count>0 && iterations<3){
            mergeBroken_count = 0;
            iterations++;
   
            for (i=0; i<idx_BurstZone; i++)
               BurstZones[i].zone_IsMerge = false;

            for (i=0; i<idx_BurstZone-1; i++){
               if (BurstZones[i].zone_Hits<0 || BurstZones[j].zone_IsMerge == true)
                  continue;

               for (j=i+1; j<idx_BurstZone; j++){
                  if (BurstZones[j].zone_Hits<0 || BurstZones[j].zone_IsMerge == true)
                     continue;

                  if ((BurstZones[i].zone_H >= BurstZones[j].zone_L && BurstZones[i].zone_H <= BurstZones[j].zone_H) ||
                      (BurstZones[i].zone_L <= BurstZones[j].zone_H && BurstZones[i].zone_L >= BurstZones[j].zone_L) ||
                      (BurstZones[j].zone_H >= BurstZones[i].zone_L && BurstZones[j].zone_H <= BurstZones[i].zone_H) ||
                      (BurstZones[j].zone_L <= BurstZones[i].zone_H && BurstZones[j].zone_L >= BurstZones[i].zone_L))
                  {
                     mergeBroken_Target[mergeBroken_count] = i;
                     mergeBroken_Source[mergeBroken_count] = j;
                     BurstZones[i].zone_IsMerge = true;
                     BurstZones[j].zone_IsMerge = true;
                     mergeBroken_count++;
                  }
               }
            }

            // ... and merge them ...
            for (i=0; i<mergeBroken_count; i++){
               target = mergeBroken_Target[i];
               source = mergeBroken_Source[i];

               BurstZones[target].zone_H = MathMax(BurstZones[target].zone_H, BurstZones[source].zone_H);
               BurstZones[target].zone_L = MathMin(BurstZones[target].zone_L, BurstZones[source].zone_L);
               BurstZones[target].zone_Hits += BurstZones[source].zone_Hits;
               BurstZones[target].zone_StartBar = MathMax(BurstZones[target].zone_StartBar, BurstZones[source].zone_StartBar);
               BurstZones[target].zone_EndBar = MathMax(BurstZones[target].zone_EndBar, BurstZones[source].zone_EndBar);
               BurstZones[target].zone_Status = MathMax(BurstZones[target].zone_Status, BurstZones[source].zone_Status);
               if (BurstZones[target].zone_Hits > 3)
                  BurstZones[target].zone_Status = ZONE_STRONG;

               if (BurstZones[target].zone_Hits == 0 && BurstZones[target].zone_IsTurncoat == false){
                  BurstZones[target].zone_Hits = 1;
                  if (BurstZones[target].zone_Status != ZONE_VERIFIED)
                     BurstZones[target].zone_Status = ZONE_VERIFIED;
               }

               if (BurstZones[target].zone_IsTurncoat == false || BurstZones[source].zone_IsTurncoat == false)
                  BurstZones[target].zone_IsTurncoat = false;
               if (BurstZones[target].zone_IsTurncoat == true)
                  BurstZones[target].zone_Hits = 0;

               BurstZones[source].zone_Hits = -1;
            }
         }//--- End while loop
      }//--- End show broken     
   }//--- End merging

   //--- Copy the remaining list into our official zones arrays
   idx_ZoneAfterMerged=0;
   for (i=0; i<idx_ZoneFound; i++){
      if (CurrentZones[i].zone_Hits>=0 && idx_ZoneAfterMerged < zone_limit){
         
         CurrentZones[idx_ZoneAfterMerged].zone_H           = CurrentZones[i].zone_H;
         CurrentZones[idx_ZoneAfterMerged].zone_L           = CurrentZones[i].zone_L;
         CurrentZones[idx_ZoneAfterMerged].zone_Hits        = CurrentZones[i].zone_Hits;
         CurrentZones[idx_ZoneAfterMerged].zone_IsTurncoat  = CurrentZones[i].zone_IsTurncoat;
         CurrentZones[idx_ZoneAfterMerged].zone_StartBar    = CurrentZones[i].zone_StartBar;
         CurrentZones[idx_ZoneAfterMerged].zone_Status      = CurrentZones[i].zone_Status;
         CurrentZones[idx_ZoneAfterMerged].zone_EndBar      = 0;
         
         if (CurrentZones[idx_ZoneAfterMerged].zone_H < close[0])
            CurrentZones[idx_ZoneAfterMerged].zone_Type = ZONE_SUPPORT;
         else if (CurrentZones[idx_ZoneAfterMerged].zone_L > close[0])
            CurrentZones[idx_ZoneAfterMerged].zone_Type = ZONE_RESIST;
         else{
            for (j=5; j<1000; j++){
               if (close[j] < CurrentZones[idx_ZoneFound].zone_L){
                  CurrentZones[idx_ZoneAfterMerged].zone_Type = ZONE_RESIST;
                  break;
               }
               else if (close[j] > CurrentZones[idx_ZoneFound].zone_H){
                  CurrentZones[idx_ZoneAfterMerged].zone_Type = ZONE_SUPPORT;
                  break;
               }
            }

            if (j == 1000)
               CurrentZones[idx_ZoneFound].zone_Type = ZONE_SUPPORT;
         }

         idx_ZoneAfterMerged++;
      }
   }//--- End for loop
}//---

//+------------------------------------------------------------------+
//| Function to retrieve broken zones
//+------------------------------------------------------------------+
void BrokenZones()
{
   for (int i=idx_BurstZone-1; i>=0; i--){
      if (BurstZones[i].zone_Hits >= 0 && idx_ZoneAfterMerged < zone_limit){
         BurstZones[idx_ZoneAfterMerged].zone_H          = BurstZones[i].zone_H;
         BurstZones[idx_ZoneAfterMerged].zone_L          = BurstZones[i].zone_L;
         BurstZones[idx_ZoneAfterMerged].zone_Hits       = BurstZones[i].zone_Hits;
         BurstZones[idx_ZoneAfterMerged].zone_IsTurncoat = BurstZones[i].zone_IsTurncoat;
         BurstZones[idx_ZoneAfterMerged].zone_StartBar   = BurstZones[i].zone_StartBar;
         BurstZones[idx_ZoneAfterMerged].zone_Status     = BurstZones[i].zone_Status;
         BurstZones[idx_ZoneAfterMerged].zone_EndBar     = BurstZones[i].zone_EndBar;
         BurstZones[idx_ZoneAfterMerged].zone_Type       = ZONE_BROKEN;
         idx_ZoneAfterMerged++;
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
   datetime startTime, endTime, lblTime;
   double startPrice, endPrice;
   color objColor = clrSilver;
   string objName, zoneWidth, lblName, lblDescription;
   int idx_ZoneToDraw = (zone_merge)? idx_ZoneAfterMerged : idx_ZoneFound;

   fn_RemoveObjects("SRZone#");
   
   //--- Iterate through all found zones and display them
   for (int i=0; i<idx_ZoneToDraw; i++){
   
      if (CurrentZones[i].zone_Status == ZONE_UNTESTED && zone_show_untested == false)
         continue;
     
      if (CurrentZones[i].zone_Status == ZONE_VERIFIED && zone_show_verified == false)
         continue;
   
      if (CurrentZones[i].zone_Status == ZONE_POSSIBLE && zone_show_possible == false)
         continue;
         
      if (CurrentZones[i].zone_Status == ZONE_STRONG && zone_show_strong == false)
         continue;

      if (CurrentZones[i].zone_Status == ZONE_TURNCOAT && zone_show_turncoat == false)
         continue;

      objName = "SRZone#" + TimeToString(time[CurrentZones[i].zone_StartBar],TIME_DATE|TIME_MINUTES) + "_";
      startTime = time[CurrentZones[i].zone_StartBar];
      endTime = time[CurrentZones[i].zone_EndBar] + ShiftEndRight * PeriodSeconds();
      lblTime = time[0] + ShiftEndRight * PeriodSeconds();
      startPrice = CurrentZones[i].zone_H;
      endPrice = CurrentZones[i].zone_L;
      double widthSize = (startPrice - endPrice) / myPoint;
      zoneWidth = DoubleToString(widthSize,0) + " pips";
      //zoneTest = "Test count " + IntegerToString(CurrentZones[i].zone_Hits) + "times";
      
      lblName = "SRZone#LBL" + TimeToString(time[CurrentZones[i].zone_StartBar],TIME_DATE|TIME_MINUTES) + "_";
      lblDescription = "";
      
      if(CurrentZones[i].zone_Type==ZONE_SUPPORT){
         switch(CurrentZones[i].zone_Status){
            case ZONE_TURNCOAT:
               objName = objName + "S_TURNCOAT";
               objColor=color_support_turncoat;
               
               lblName = lblName + "S_TURNCOAT";
               lblDescription = "Turncoat Support-" + zoneWidth;
               
               break;
            case ZONE_STRONG:
               objName = objName + "S_STRONG";
               objColor=color_support_strong;
               
               lblName = lblName + "S_STRONG";
               lblDescription = "Strong Support-" + zoneWidth;
               break;
            case ZONE_VERIFIED:
               objName = objName + "S_VERIFIED";
               objColor=color_support_verified;
               
               lblName = lblName + "S_VERIFIED";
               lblDescription = "Verified Support-" + zoneWidth;
               break;
            case ZONE_UNTESTED:
               objName = objName + "S_UNTESTED";
               objColor=color_support_untested;
               
               lblName = lblName + "S_UNTESTED";
               lblDescription = "Untested Support-" + zoneWidth;
               break;
            case ZONE_POSSIBLE:
               objName = objName + "S_POSSIBLE";
               objColor=color_support_possible;
               
               lblName = lblName + "S_POSSIBLE";
               lblDescription = "Possible Support-" + zoneWidth;
               break;
            default:
               break;
         }
      }else if (CurrentZones[i].zone_Type == ZONE_RESIST){
         switch(CurrentZones[i].zone_Status){
            case ZONE_TURNCOAT:
               objName = objName + "R_TURNCOAT";
               objColor=color_resist_turncoat;
               
               lblName = lblName + "R_TURNCOAT";
               lblDescription = "Turncoat Resist-" + zoneWidth;
               break;
            case ZONE_STRONG:
               objName = objName + "R_STRONG";
               objColor=color_resist_strong;
               
               lblName = lblName + "R_STRONG";
               lblDescription = "Strong Resist-" + zoneWidth;
               break;
            case ZONE_VERIFIED:
               objName = objName + "R_VERIFIED";
               objColor=color_resist_verified;
               
               lblName = lblName + "R_VERIFIED";
               lblDescription = "Verified Resist-" + zoneWidth;
               break;
            case ZONE_UNTESTED:
               objName = objName + "R_UNTESTED";
               objColor=color_resist_untested;
               
               lblName = lblName + "R_UNTESTED";
               lblDescription = "Untested Resist-" + zoneWidth;
               break;
            case ZONE_POSSIBLE:
               objName = objName + "R_POSSIBLE";
               objColor=color_resist_possible;
               
               lblName = lblName + "R_POSSIBLE";
               lblDescription = "Possible Resist-" + zoneWidth;
               break;
            default:
               break;
         }      
      }else{
         switch(CurrentZones[i].zone_Status){
            case ZONE_STRONG:
               objName = objName + "H_WEAK";
               objColor=color_broken_weak;
               break;
            case ZONE_VERIFIED:
               objName = objName + "H_VERIFIED";            
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
      fn_DisplayText(lblName,lblTime,(startPrice+endPrice)*0.5,ANCHOR_LEFT,0,fontSize,fontName,objColor,lblDescription);
   }
   
}//--- End draw zones


//+------------------------------------------------------------------+ 
//| Filling indicator buffers from the iIchimoku indicator           | 
//+------------------------------------------------------------------+ 
bool FillArraysFromBuffers(double &buffer[],    // indicator buffer of the ATR
                           int ind_handle,         // handle of the indicator 
                           int amount              // number of copied values 
                           ) 
{ 
   //--- reset error code 
   ResetLastError(); 
   
   //--- fill a part of the arrBuffer array with values from the indicator buffer that has 0 index 
   if(CopyBuffer(ind_handle,0,0,amount,buffer)<0) { 
      //--- if the copying fails, tell the error code 
      PrintFormat("1.Failed to copy data from the ATR indicator, error code %d",GetLastError()); 
      //--- quit with zero result - it means that the indicator is considered as not calculated 
    return(false); 
   } 

   //--- everything is fine 
   return(true); 
} 
//+------------------------------------------------------------------+
//| Set the indicator properties                                     |
//+------------------------------------------------------------------+
void SetPropertiesIndicator(void) {
   int i;
   //--- Set a short name
   IndicatorSetString(INDICATOR_SHORTNAME, "Support and Resistance");

   //--- Set a number of decimal places
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   
   //--- Define buffers for drawing
   SetIndexBuffer(0, SlowLow);
   SetIndexBuffer(1, SlowHigh);
   SetIndexBuffer(2, FastLow);
   SetIndexBuffer(3, FastHigh);
   
   ArraySetAsSeries(SlowLow,true);
   ArraySetAsSeries(SlowHigh,true);
   ArraySetAsSeries(FastLow,true);
   ArraySetAsSeries(FastHigh,true);
   //ArraySetAsSeries(ATR,true);
   
   //--- Set the labels
   string text[]= {"Slow Fractal L","Slow Fractal H","Fast Fractal L","Fast Fractal H"};
   for(i=0; i<indicator_plots; i++)
      PlotIndexSetString(i,PLOT_LABEL,text[i]);

   //--- Set the type
   ENUM_DRAW_TYPE draw_type = (showFractal)? DRAW_ARROW:DRAW_NONE;  
   PlotIndexSetInteger(0,PLOT_DRAW_TYPE,draw_type);
   PlotIndexSetInteger(0,PLOT_ARROW,218);
   PlotIndexSetInteger(0,PLOT_ARROW_SHIFT,15);
   PlotIndexSetInteger(0,PLOT_LINE_COLOR,clrGray);

   PlotIndexSetInteger(1,PLOT_DRAW_TYPE,draw_type);
   PlotIndexSetInteger(1,PLOT_ARROW,217);
   PlotIndexSetInteger(1,PLOT_ARROW_SHIFT,-15);
   PlotIndexSetInteger(1,PLOT_LINE_COLOR,clrGray);
   
   PlotIndexSetInteger(2,PLOT_DRAW_TYPE,draw_type);
   PlotIndexSetInteger(2,PLOT_ARROW,218);
   PlotIndexSetInteger(2,PLOT_ARROW_SHIFT,10);
   PlotIndexSetInteger(2,PLOT_LINE_COLOR,clrDarkBlue);
   
   PlotIndexSetInteger(3,PLOT_DRAW_TYPE,draw_type);
   PlotIndexSetInteger(3,PLOT_ARROW,217);
   PlotIndexSetInteger(3,PLOT_ARROW_SHIFT,-10);
   PlotIndexSetInteger(3,PLOT_LINE_COLOR,clrDarkBlue);
 
   for(i=0; i<indicator_plots; i++)
      PlotIndexSetDouble(i,PLOT_EMPTY_VALUE,0.0);

   //--- Setup ATR indicator handle
   ATRHdl = ATRHandle(NULL,0,7);
}

//+------------------------------------------------------------------+
//| Reset temporary variables
//+------------------------------------------------------------------+
void ZeroTemporaryVariables(void)
{
   idx_ZoneFound=0;
   idx_BurstZone=0;
   idx_ZoneAfterMerged=0;
   
   ArrayInitialize(merge_Target,0);
   ArrayInitialize(merge_Source,0);
   merge_count=0;
   ArrayInitialize(mergeBroken_Target,0);
   ArrayInitialize(mergeBroken_Source,0);
   mergeBroken_count=0;
   
   //--- Varibale to verify zone is Support/Resistance
   zone_touchCount=0;
   zone_burstCount=0;
   zone_brokenBarCount=0;
}

//+------------------------------------------------------------------+
//| Reset the indicator buffers                                      |
//+------------------------------------------------------------------+
void ZeroIndicatorBuffers(void)
{
   ArrayInitialize(SlowLow,0);
   ArrayInitialize(SlowHigh,0);
   ArrayInitialize(FastLow,0);
   ArrayInitialize(FastHigh,0);
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
      ExtBegin=rates_total-fractal_SlowFactor;
   else
      ExtBegin=checkBarsCalc-fractal_SlowFactor;
}