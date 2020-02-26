//+------------------------------------------------------------------+
//|                                          GridTrendMultiplier.mq5 |
//|                                                      Khoa Nguyen |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      "https://www.mql5.com"
#property version   "2.00"
#property strict

#include "GTM_Program.mqh"

enum EA_MODE1 {
   NORMAL=1,
   TEST=-1
};
//--- Create GUI class
CProgram program;

//+------------------------------------------------------------------+
//| External variables
//+------------------------------------------------------------------+
extern EA_MODE1 eaMode = 1;                       //Running Test Mode

//--- Configurations


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
  //--- create timer
  EventSetTimer(1000);

      //Initialize GUI   
  program.OnInitEvent();

  //--- Set up the trading panel
  if(!program.CreateExpertPanel("Grid Trend Multiplier v2.0",1)){
    Print(__FUNCTION__," > Failed to create graphical interface!");
    return(INIT_FAILED);
  }
//---
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
//--- destroy timer
  EventKillTimer();
  program.OnDeinitEvent(reason);
  ExpertRemove();  
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
//---
  program.OnTickEvent();
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
//---
  program.OnTimerEvent();
}
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+

void OnTrade()
{
//---
   
}

//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
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
  program.ChartEvent(id,lparam,dparam,sparam);
}


//+------------------------------------------------------------------+
