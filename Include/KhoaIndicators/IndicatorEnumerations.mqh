//+------------------------------------------------------------------+
//|                                        IndicatorEnumerations.mqh |
//|                                                      Khoa Nguyen |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      "https://www.mql5.com"

#import "IndicatorLibrary.ex5"
double fn_SetMyPoint();
#import

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
#define Spread SymbolInfoInteger(Symbol(),SYMBOL_SPREAD)
#define Bid    SymbolInfoDouble(Symbol(),SYMBOL_BID)
#define Ask    SymbolInfoDouble(Symbol(),SYMBOL_ASK)

#define Time(shift)     iTime(Symbol(),Period(),shift)
#define Open(shift)     iOpen(Symbol(),Period(),shift) 
#define High(shift)     iHigh(Symbol(),Period(),shift) 
#define Low(shift)      iLow(Symbol(),Period(),shift)
#define Close(shift)    iClose(NULL,PERIOD_CURRENT,shift) 
#define Volume(shift)   iVolume(Symbol(),0,shift)

#define myPoint   fn_SetMyPoint();

//+------------------------------------------------------------------+
//| Enumerations
//+------------------------------------------------------------------+
enum TREND_DIRECTION {
   UP_TREND=1,
   DOWN_TREND=-1,
   NO_TREND=0,
};


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
//+------------------------------------------------------------------+
//| Struct declaration
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Functions
//+------------------------------------------------------------------+
  