//+------------------------------------------------------------------+
//|                                             GTM_Enumerations.mqh |
//|                                                      Khoa Nguyen |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property link      ""

#define Spread SymbolInfoInteger(Symbol(),SYMBOL_SPREAD)
#define Bid SymbolInfoDouble(Symbol(),SYMBOL_BID)
#define Ask SymbolInfoDouble(Symbol(),SYMBOL_ASK)

//+------------------------------------------------------------------+
//| Enumerations
//+------------------------------------------------------------------+
enum TRADE_DIRECTION 
{
   HEDGE=0,
   LONG=1,
   SHORT=-1,
};

enum ENTRY_TYPE 
{
   IMMEDIATE=0,
   PENDING=1,
};

enum CONTROL_STATUS 
{
   STOP=-1,
   PAUSE=0,
   START=1,
};

//+------------------------------------------------------------------+
//| Struct declaration
//+------------------------------------------------------------------+
struct AccountInformation
{
   double            inf_MagicNumber;
   double            inf_Point;
   string            inf_CurrencyPair;
   double            inf_PipValue;
   double            inf_CurSpreadPips;
   double            inf_RunningShortPL;
   double            inf_RunningLongPL;
   double            inf_AccumShortBalance;
   double            inf_AccumLongBalance;
   double            inf_PruneBalance;
   double            inf_CurLongTickets;
   double            inf_CurShortTickets;
};

struct MoneyManagementParameters
{
   double            mm_LotSize;             // Lotsize
   ENTRY_TYPE        mm_EntryType;           // Entry Type
   TRADE_DIRECTION   mm_TradeDirection;      // Direction
   double            mm_EntryPrice;          // Entry Price
   double            mm_SLPips;              // SL in pips
   double            mm_TPAmount;            // TP amount
   double            mm_TPPips;              // TP in pips
   double            mm_MaxSpreadPips;       // Max Spread in Pips. If current spread exceed Max Spread then not entering trade
   double            mm_MinSpreadPips;       // Min Spread in Pips. If distance to current TP is smaller than Min Spread then not entering trade
   double            mm_MaxLongPositions;    // Max open Long positions
   double            mm_MaxShortPositions;   // Max open Short positions
   //--- Compute values
   double            mm_SHORT_SLPrice;       // Calculated SHORT SL Price Level based on SL Pips
   double            mm_LONG_SLPrice;        // Calculated LONG SL Price Level based on SL Pips
   double            mm_SHORT_TPPrice;       // Calculated SHORT TP Price Level based on TP Pips
   double            mm_LONG_TPPrice;        // Calculated LONG TP Price Level based on TP Pips
};

//--- Parameters used in construting GRID
struct GridParameters
{
   int               grid_GapSizePips;
   int               grid_EntryLevel;
   int               grid_ResetLevel;
   int               grid_ScaleFactor;
   int               grid_ScaleStartLevel;
   int               grid_ScaleMode;
   
   //--- To be displayed parameters
   int               grid_CurLongLevel;
   int               grid_CurShortLevel;
   int               grid_NextLongLevel;
   int               grid_NextShortLevel;
   int               grid_PrevLongLevel;
   int               grid_PrevShortLevel;
   int               grid_NextLongScaleLevel;
   int               grid_NextShortScaleLevel;
   int               grid_PrevLongScaleLevel;
   int               grid_PrevShortScaleLevel;
};

struct GridItem
{
   int               item_curIndex;          // Current grid level
   double            item_curPrice;          // Current grid price
   int               item_prevIndex;         // Previous grid level
   double            item_prevPrice;         // Previous grid price
   int               item_nextIndex;         // Next grid level
   double            item_nextPrice;         // Next grid price

   int               item_curScaleIndex;
   double            item_curScalePrice;
   int               item_prevScaleIndex;
   double            item_prevScalePrice;
   int               item_nextScaleIndex;
   double            item_nextScalePrice;
   
   long              item_BUYTicket;
   long              item_SELLTicket;
   double            item_SLPrice;
   bool              item_isClose;

   bool              item_isLargestTicket;
   string            item_Comment;
};

struct EAOperation
{
   bool              GRID_isInitialize;            //---Flag to check if GRID has been initialized
   bool              GTM_isActive;                 //---Flag to check if GTM has been activated
   CONTROL_STATUS    GTM_Status;                   //---Flag to check if GTM is running or pause or stop
   bool              OP_isVariableRefreshed;       //---Flag to check if structure variable has been refreshed from interface
};
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+
