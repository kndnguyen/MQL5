//+------------------------------------------------------------------+
//|                                                      Testing.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   int ticket;
   if(ticket=PositionGetTicket(0))
     {
      MessageBox(PositionGetInteger(POSITION_TICKET));
     }

   //MessageBox(PositionsTotal());
   //MessageBox(SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
   
   
  // struct MqlTick 
  //{ 
  // datetime     time;          // Time of the last prices update 
  // double       bid;           // Current Bid price 
  // double       ask;           // Current Ask price 
  // double       last;          // Price of the last deal (Last) 
  // ulong        volume;        // Volume for the current Last price 
  // long         time_msc;      // Time of a price last update in milliseconds 
  // uint         flags;         // Tick flags 
  // double       volume_real;   // Volume for the current Last price with greater accuracy 
  //};
  
  }
//+------------------------------------------------------------------+
