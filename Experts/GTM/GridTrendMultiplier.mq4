//+------------------------------------------------------------------+
//|                                          GridTrendMultiplier.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property version   "1.11"
#property description   "v1.11 Fix bugs at GTM_GetIndexByPriceLevel and enable notification when encountering price gap once every new bar"
                        "/nv1.10 When resume from pause, check current price against lowest grid level then find corresponding level. Setting StopLoss when Op_Refresh_Variables"
                        "/nv1.00 Original version"
#property strict

//--- Including the trading panel class
#include "GTM_Program.mqh"

//--- Create GUI class
CProgram program;

//+------------------------------------------------------------------+
//| External variables
//+------------------------------------------------------------------+
extern string lb1="";                                 //---------- Profit Settings
extern double tgtProfitAmt=500;                       //Target Profit - Whatever reach first
extern double tgtPrice=0;                             //Target Price - Whatever reach first

extern string lb2="";                                 //---------- Risk Settings
extern int stopLossLevel=20;                          //Stoploss levels from entry
extern double trendGapSize=10;                        //Grid Trend Gap Size
extern int maxOpenTicket=10;                          //Max Open Ticket
extern int resetLevel=25;                             //Level to reset the StopLoss [0-No Reset]
extern bool enableCounterTrendScale=true;             //Enable Counter Trend Scalling
extern int counterTrendScaleFactor=2;                 //Counter Trend Scalling Factor [Gap Size x Factor]
extern int counterTrendScaleLevel=25;                 //Level to start counter trend scaling
extern double maxSpreadPips=5;                        //Max Spread (pips)
extern int StealthDistancePips=5;                     //Pips distance from actual Stoploss

extern string lb3="";                                 //---------- Operation Settings
extern ENTRY_TYPE entryType=IMMEDIATE;                //Entry Type [Select]
extern TRADE_DIRECTION tradeDirection=LONG;           //Trade direction [Select]
extern double lotSize=0.01;                           //Trade Lot Size
extern double entryPrice=0;                           //Grid Entry Price if PENDING entry

//========== Configurations table
string configTable[17][2];

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(void)
{
     
   //========== Display Information
   InitConfigTable();

   //Initialize GUI   
   program.OnInitEvent();

   //--- Set up the trading panel
   if(!program.CreateExpertPanel("Grid Trend Multiplier v2.0",configTable)){
      Print(__FUNCTION__," > Failed to create graphical interface!");
      return(INIT_FAILED);
   }
    
   //--- Initialization successful
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   program.OnDeinitEvent(reason);
   ExpertRemove();      
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(void)
{
   program.OnTickEvent();
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer(void)
{
   program.OnTimerEvent();
}

//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade(void)
{
}

//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int    id,
                  const long   &lparam,
                  const double &dparam,
                  const string &sparam)
{
   program.ChartEvent(id,lparam,dparam,sparam);     
}
//+------------------------------------------------------------------+





//+------------------------------------------------------------------+
//| Function to initialize config table
//+------------------------------------------------------------------+
void InitConfigTable()
{
int index=0;
   configTable[index][0]="Lot Size*";
   configTable[index][1]=DoubleToString(lotSize);
   index++;
   configTable[index][0]="Entry Type";
   configTable[index][1]=EnumToString(entryType);
   index++;
   configTable[index][0]="Trade Direction";
   configTable[index][1]=EnumToString(tradeDirection);
   index++;
   configTable[index][0]="Entry Price";
   configTable[index][1]=DoubleToString(entryPrice);
   index++;
   configTable[index][0]="Stop Loss Level from Entry";
   configTable[index][1]=stopLossLevel;
   index++;
   configTable[index][0]="Stop Loss Price [Display Only]";
   configTable[index][1]=DoubleToString(0);
   index++;
   configTable[index][0]="MIN Stop Loss [pips] [Display Only]";
   configTable[index][1]=DoubleToString(0);
   index++;
   configTable[index][0]="Target Profit Amount*";
   configTable[index][1]=DoubleToString(tgtProfitAmt);
   index++;
   configTable[index][0]="Target Profit Price*";
   configTable[index][1]=DoubleToString(tgtPrice);
   index++;
   configTable[index][0]="Grid Gap Size [pips]";
   configTable[index][1]=trendGapSize;
   index++;
   configTable[index][0]="Grid Reset Level [0-No Reset]*";
   configTable[index][1]=resetLevel;
   index++;
   configTable[index][0]="Distance from SL [pips]*";
   configTable[index][1]=StealthDistancePips;
   index++;
   configTable[index][0]="Max Open Tickets*";
   configTable[index][1]=maxOpenTicket;
   index++;
   configTable[index][0]="MAX Spread [pips]*";
   configTable[index][1]=DoubleToString(maxSpreadPips);
   index++;
   configTable[index][0]="Counter Trend Scaling";
   configTable[index][1]=enableCounterTrendScale;
   index++;
   configTable[index][0]="Counter Trend Factor [Gap x Factor]";
   configTable[index][1]=counterTrendScaleFactor;
   index++;
   configTable[index][0]="Counter Trend Start Level";
   configTable[index][1]=counterTrendScaleLevel;
}

