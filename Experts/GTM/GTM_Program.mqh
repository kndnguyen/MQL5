//+------------------------------------------------------------------+
//|                                                  GTM_Program.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property version   "2.0"
#property description   "/nv2.00 Original version"

#include <EasyAndFastGUI\Controls\WndEvents.mqh>
#include <ChartObjects\ChartObjectsLines.mqh>

//enum ORDER_TYPE
//{
//   BUY_ORDER=1,
//   SELL_ORDER=-1,
//   NO_ORDER=0,
//};

enum TRADE_DIRECTION 
{
   HEDGE=0,
   LONG=1,
   SHORT=-1,
};

enum ENTRY_TYPE 
{
   IMMEDIATE=0,
   PENDING_STOP=1,
   PENDING_LIMIT=2,
};

enum CONTROL_STATUS 
{
   STOP=-1,
   PAUSE=0,
   START=1,
};

enum SL_MODE 
{
   HARDPIP=0,
   CANDLES=1
};  

#import "EALibrary.ex5"

//---Environments Funtions
double   fn_SetMyPoint();
bool     fn_GetMarketInfo(double &marketInfo[],double lotSize);
bool     fn_IsNewCandle();
int      fn_GenerateMagicNumber(int trial);
string   fn_IsConnectedToBroker();
// string   fn_RemainingTime();
 bool     fn_RemoveObjects(string objName);
// bool     fn_SendNotification(string myText,bool printLog,bool sendAlert,bool sendPushNotification);

//Funtions support GTM
// int      fn_GetRunningProfitLossPip(int magicNumber,double myPoint);
// int      fn_GetOrderProfitLossPip(int ticket,double myPoint);
// int      fn_GetOpenOrders(int magicNumber);
// bool     fn_IsOrderOpened(int ticketNumber,int magicNumber);
// int      fn_IsPendingStop(double priceLevel,int direction);
// int      fn_IsPendingLimit(double priceLevel,int direction);
// int      fn_OrderEntry_1(ORDER_TYPE orderDirection,double orderSize,double orderSLPrice,double orderTPPrice,string orderComment,int orderMagicNum);
// void     fn_CloseAllOrders(int magicNumber);
double   fn_GetEntryPrice(TRADE_DIRECTION tradeDirection, ENTRY_TYPE entryType);
#import

//+------------------------------------------------------------------+
//| Struct declaration
//+------------------------------------------------------------------+
struct MoneyManagementParameters
{
   double            mm_LotSize;
   ENTRY_TYPE        mm_EntryType; 
   TRADE_DIRECTION   mm_TradeDirection;
   double            mm_EntryPrice;
   double            mm_SLPips;
   double            mm_TPAmount;
   double            mm_TPPips;
   double            mm_MaxSpreadPips;
   double            mm_MinSpreadPips;
   double            mm_MaxLongPositions;
   double            mm_MaxShortPositions;
};

struct GridParameters
{
   double            grid_GapSizePips;
   double            grid_EntryLevel;
   double            grid_ResetLevelDistance;
   double            grid_ScaleFactor;
   double            grid_ScaleStartLvlDst;
   double            grid_CurLongLevel;
   double            grid_CurShortLevel;
   double            grid_NextLongLevel;
   double            grid_NextShortLevel;
   double            grid_PrevLongLevel;
   double            grid_PrevShortLevel;
   double            grid_NextLongScaleLevel;
   double            grid_NextShortScaleLevel;
   double            grid_PrevLongScaleLevel;
   double            grid_PrevShortScaleLevel;
};

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

struct GridItem
{
   double            item_curPrice;
   double            item_prevPrice;
   double            item_nextPrice;
   int               item_curScaleIndex;
   double            imte_curScalePrice;
   int               item_prevScaleIndex;
   double            item_prev_ScalePrice;
   int               item_nextScaleIndex;
   double            item_nextScalePrice;
   ulong             item_Ticket;
   double            item_SLPrice;
   bool              item_isClose;
   bool              item_isEntry;
   bool              item_isScaleStart;
   bool              item_isLargestTicket;
   
};


//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
{
   //---Class Declaration   
   private:
      //--- Main windows
      CWindow           m_window1;
      //--- Main menu and its context menus
      CMenuBar          m_menubar;
      //--- Status bar
      CStatusBar        m_status_bar;

      //--- Tabs
      CTabs             m_tabs;
      
      //--- Money Management tab
      CComboBox         m_RISK_comboEntryType;
      CComboBox         m_RISK_comboDirection;
      CSpinEdit         m_RISK_editEntryprice;
      CSpinEdit         m_RISK_editLotSize;   
      CSpinEdit         m_RISK_editSLPips;   
      CSpinEdit         m_RISK_editTPPips;   
      CSpinEdit         m_RISK_editTPAmount;   
      CSpinEdit         m_RISK_editMinSpreadPips;   
      CSpinEdit         m_RISK_editMaxSpreadPips;   
      CSpinEdit         m_RISK_editMaxLongPos;   
      CSpinEdit         m_RISK_editMaxShortPos;   

      //--- Grid Management tab
      CTable            m_GRID_Table;
      CSpinEdit         m_GRID_editGridSize;
      CSpinEdit         m_GRID_editEntryLevel;
      CSpinEdit         m_GRID_editResetLevelDistance;
      CSpinEdit         m_GRID_editScaleFactor;
      CSpinEdit         m_GRID_editScaleStartLvlDst;       
      CSimpleButton     m_GRID_buttonApply;
      CChartObjectHLine m_GRID_Gridline;
 
      




      //--- Account information tab
      CTable            m_AccountTable;
      
      //--- Control tab
      CSeparateLine     m_Control_sepline;
      CCheckBox         m_Control_checkboxAskLine;
      CIconButtonsGroup m_RISK_ButtonsGroup;

   
      
   //---Functions declaration
   public:
                        CProgram(void);
                       ~CProgram(void);
      //--- Initialization/uninitialization
      void              OnInitEvent(void);
      void              OnDeinitEvent(const int reason);
      //--- Timer
      void              OnTickEvent(void);
      void              OnTimerEvent(void);
      //--- Create an expert panel
      bool              CreateExpertPanel(string panelName, bool isTestMode);
      
   protected:
      //--- Chart event handler
      virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
      
   private:
      //--- Create main Window
      bool              CreateWindow1(const string text);
      //--- Create Main menu
      #define MENUBAR_GAP_X         (1)
      #define MENUBAR_GAP_Y         (20)
      bool              CreateMenuBar(void);
      //--- Create Status bar
      #define STATUSBAR1_GAP_X      (1)
      #define STATUSBAR1_GAP_Y      (375)
      bool              CreateStatusBar(void);
      //--- Create Tabs
      #define TABS1_GAP_X           (4)
      #define TABS1_GAP_Y           (45)
      bool              CreateTabs(void);

      // Global Variables
      #define TABLE2_GAP_X          (5)
      #define TABLE2_GAP_Y          (65)      
      #define VISIBLE_COLUMNS       (2)
      #define VISIBLE_ROWS          (12)
      #define TABLE_COLUMNS         (2)

      //+------------------------------------------------------------------+
      //| Operational functions
      //+------------------------------------------------------------------+
      bool              OP_Init_Parameters(bool isTestMode);            // Initialise structure parameters before starting application
      bool              Op_Refresh_Parameters(void);                    // Update structure parameters with oparational values

      //bool              Op_GTM_START(void);
      //bool              Op_GTM_PAUSE(void);
      //bool              Op_GTM_STOP(void);

      //bool              isGridInitialize;
      //bool              isVariablesRefreshed;

      //+------------------------------------------------------------------+
      //| Risk management tab
      //+------------------------------------------------------------------+
      MoneyManagementParameters     MoneyManagement;
      bool              RISK_UpdateStructureInterface(bool isInfToStruct);    // Update between interface values and structure value
      bool              RISK_LockDown(bool lockStatus);
      #define RISK_TabIndex               (0)

      // Column 1
      #define RISK_CB_ENTRY_GAP_X         (10)      //Horizonal Distance
      #define RISK_CB_ENTRY_GAP_Y         (80)      //Vertical Distance
      bool              RISK_CreateComboEntryType(const string text); 

      #define RISK_CB_DIRECTION_GAP_X     (10)
      #define RISK_CB_DIRECTION_GAP_Y     (110)
      bool              RISK_CreateComboDirection(const string text); 
      
      // Column 2
      #define RISK_SE_ENTRYPRICE_GAP_X    (250)
      #define RISK_SE_ENTRYPRICE_GAP_Y    (80)
      bool              RISK_CreateEntryPrice(const string text);      
      #define RISK_SE_LOTSIZE_GAP_X       (250)
      #define RISK_SE_LOTSIZE_GAP_Y       (110)
      bool              RISK_CreateLotSize(const string text);
      #define RISK_SE_SLPIPS_GAP_X       (250)
      #define RISK_SE_SLPIPS_GAP_Y       (140)
      bool              RISK_CreateSLPips(const string text);      
      #define RISK_SE_TPPIPS_GAP_X       (250)
      #define RISK_SE_TPPIPS_GAP_Y       (170)
      bool              RISK_CreateTPPips(const string text);     
      #define RISK_SE_TPAMOUNT_GAP_X      (250)
      #define RISK_SE_TPAMOUNT_GAP_Y      (200)
      bool              RISK_CreateTPAmount(const string text);         
      #define RISK_SE_MINSPREADPIPS_GAP_X      (250)
      #define RISK_SE_MINSPREADPIPS_GAP_Y      (230)
      bool              RISK_CreateMinSpreadPips(const string text);
      #define RISK_SE_MAXSPREADPIPS_GAP_X      (250)
      #define RISK_SE_MAXSPREADPIPS_GAP_Y      (260)
      bool              RISK_CreateMaxSpreadPips(const string text);
      #define RISK_SE_MAXLONGPOS_GAP_X      (250)
      #define RISK_SE_MAXLONGPOS_GAP_Y      (290)
      bool              RISK_CreateMaxLongPosition(const string text);
      #define RISK_SE_MAXSHORTPOS_GAP_X      (250)
      #define RISK_SE_MAXSHORTPOS_GAP_Y      (320)
      bool              RISK_CreateMaxShortPosition(const string text);

      //+------------------------------------------------------------------+
      //| Grid Management tab
      //+------------------------------------------------------------------+
      GridParameters    GridManagement;
      bool              GRID_UpdateStructureInterface(bool isInfToStruct);    // Update between interface values and structure value
      bool              GRID_LockDown(bool lockStatus);
      bool              GRID_Initialize(void);
      bool              GRID_Display(bool show);
      
      #define  GRID_TabIndex     (1)
      #define  GRID_TableRows    (4)
      #define  GRID_TableColumns (3)
      string            GRID_Table[][GRID_TableColumns];            
      bool              GRID_CreateTable();
      // Column 1
      #define GRID_SE_GRIDSIZE_GAP_X     (10)
      #define GRID_SE_GRIDSIZE_GAP_Y     (150)
      bool              GRID_CreateGridSize(const string text);                //Field to enter Grid size
      #define GRID_SE_ENTRYLEVEL_GAP_X     (10)
      #define GRID_SE_ENTRYLEVEL_GAP_Y     (180)
      bool              GRID_CreateGridEntry(const string text);               //Field to enter Grid entry level
      #define GRID_SE_RESETDISTANCE_GAP_X     (10)
      #define GRID_SE_RESETDISTANCE_GAP_Y     (210)
      bool              GRID_CreateResetDistance(const string text);               //Grid reset level  
      #define GRID_SE_SCALEFACTOR_GAP_X     (250)
      #define GRID_SE_SCALEFACTOR_GAP_Y     (150)
      bool              GRID_CreateScaleFactor(const string text);             //Counter Trend Scale Factor
      #define GRID_SE_SCALESTARTLEVEL_GAP_X     (250)
      #define GRID_SE_SCALESTARTLEVEL_GAP_Y     (180)
      bool              GRID_CreateScaleStartLvlDst(const string text);              //Counter Trend Scale Start level
      #define GRID_BTN_APPLY_GAP_X            (175)
      #define GRID_BTN_APPLY_GAP_Y            (250)
      bool              GRID_CreateApplyButton(const string text);             //Construct grid

      //+------------------------------------------------------------------+
      //| Account tab
      //+------------------------------------------------------------------+
      AccountInformation   AcctInfo;
      //bool              Account_CreateTable();
      //bool              Account_RefreshTable();

      int               table_Account_Rows;
      string            AccountTable[][TABLE_COLUMNS];      

      //double            acct_MyPoint;                      //Broker digit point
      //int               acct_MagicNumber;                  //Magic Number for this sequence
      //double            acct_MarketInfo[3];                //Array contains: pipValue | spread[pips] | SL[pips]
      //double            acct_pipValue;                     //Value of a microlot pip
      //double            acct_spreadPips;                   //Spread value in pips
      //double            acct_spreadPrice;                  //Spread value in price
      //double            acct_minSLPips;                    //Minimum Stoploss in pips      
      //double            acct_minDistancePrice;             //Max distance to TP price
      
            
      //+------------------------------------------------------------------+
      //| Control tab
      //+------------------------------------------------------------------+
      //--- Group of icon buttons Start/Pause/Stop
      #define CTRL_BTNGROUP1_GAP_X        (180)
      #define CTRL_BTNGROUP1_GAP_Y        (190)
      bool              Control_CreateButtonsGroup(void);          
      //--- Control tab
      #define CTRL_SEPLINE_GAP_X          (150)
      #define CTRL_SEPLINE_GAP_Y          (70)
      bool              Control_CreateSepLine(void);
      
      #define CTRL_CHECKBOX2_GAP_X        (18)
      #define CTRL_CHECKBOX2_GAP_Y        (100)
      bool              Control_CreateCheckBoxAskLine(const string text);

      bool              Control_LockDown(bool lockStatus,bool lockAll);
      
      double            lotSize;
      ENTRY_TYPE        entryType;
      TRADE_DIRECTION   tradeDirection;
      double            entryPrice;
      
      //+------------------------------------------------------------------+
      //| GRID TREND MULTIPLIER FUNCTIONS and parameters
      //+------------------------------------------------------------------+ 
      // Parameters
      GridItem          GRID_ARRAY[1001];                //Main array of GridItem structure to keep track of grid levels 
      
      
      void              GridTrendMultiplier(void);          //Main function to control Grid Trend Multiplier
      
      bool              GTM_Entry(void);                    //Function to handle Grid entry
      bool              grid_isActive;                      //Flag to indicate grid is active
      
      bool              GTM_Manage(void);                   //Function to manage Grid      
      CONTROL_STATUS    CTRL_Status;                        //Flag to track which button is active START-PAUSE-STOP
      
      bool              GTM_ManageTarget(void);             //Function to check if Grid has reached target then close all orders
      
      bool              GTM_ManageStopLoss(void);           //Function to check if Grid has reached Stop Loss then close all orders
      int               grid_SL_Level;                      //StopLoss level from entry = grid_entryIndex
      double            grid_SL_Price;                      //Store Stoploss price
      
      bool              GTM_ResetGrid(void);                //Function to reset the grid to save margin
      double            GTM_RefreshGrid(void);              //Function to calculate accum profit and set closed ticket to 0      
      
      double            grid_accumPLPips;                   //Total accummulate Profit/Loss in pips
      
      bool              GTM_GetIndexByTicket(void);         //Function to locate the current level using ticket number
      bool              GTM_GetIndexByPriceLevel(void);     //Function to locate the current level using price and trade direction
 
               
          
      int               grid_currentIndex;                  //Store current index
      int               grid_currentScaleIndex;             //Store current scale index
      int               grid_prevIndex;                     //Store previous index
      int               grid_prevScaleIndex;               //Store previous scale index
      int               grid_nextIndex;                     //Store next index
      int               grid_nextScaleIndex;               //Store next scale index
      int               grid_MaxSize;

      double            grid_runningPLAmount;              //Current running Profit/Loss amount
      int               grid_runningPLPips;                //Current running Profit/Loss in pips
      double            grid_accumPLAmount;                //Total accummulate Profit/Loss amount  
      int               grid_cntActiveTickets;             //Total current open ticket   


};
  
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void)
{
}

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CProgram::~CProgram(void)
{
}

//+------------------------------------------------------------------+
//| Initialization                                                   |
//+------------------------------------------------------------------+
void CProgram::OnInitEvent(void)
{

}

//+------------------------------------------------------------------+
//| Uninitialization                                                 |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
{
   //--- Removing the interface
   CWndEvents::Destroy();
   //CProgram::GRID_Display(false);
}

//+------------------------------------------------------------------+
//| On Tick event                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTickEvent(void)
{
   //+++ Enable this when testing
   //CTRL_Status=START; 
   //isVariablesRefreshed = Op_Refresh_Parameters();
   
   //+++ Entry/Manage GTM every tick
   // if(CTRL_Status==START) {
   //    CProgram::GridTrendMultiplier();  
   //    CProgram::RISK_UpdateStructureInterface(); 
   // }

   //+++ Refresh control panel
   // CProgram::Account_RefreshTable();
   // CProgram::GRID_UpdateStructureInterface();
}

//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
{
   CWndEvents::OnTimerEvent();
   //--- Updating the second item of the status bar every 500 milliseconds
   static int count=0;
   if(count<500){
      count+=TIMER_STEP_MSC;
      return;
   }
   //--- Zero the counter
   // count=0;
   //--- Change the value in the second item of the status bar
   // m_status_bar.ValueToItem(1,::TimeToString(TimeLocal(),TIME_DATE|TIME_SECONDS));
   // m_status_bar.ValueToItem(2,fn_RemainingTime());
   // m_status_bar.ValueToItem(3,fn_IsConnectedToBroker());

   //--- Redraw the chart
   m_chart.Redraw();
   
}

//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
{

   int curSelectedButton = 1;
   
   //--- Clicking on the menu item event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM){
      Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
   }
/*
   //--- The text label press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL){
      Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      
      //--- Counter Trend Scaling      
      if(lparam==m_GTM_checkTrendScaling.Id()){
         if(m_GTM_checkTrendScaling.CheckButtonState()){
            m_GRID_editScaleFactor.SpinEditState(true);
            m_GRID_editScaleStartLvlDst.SpinEditState(true);
         }else{
            m_GRID_editScaleFactor.SpinEditState(false);
            m_GRID_editScaleStartLvlDst.SpinEditState(false);
         }            
      }
      //--- Show/Hide Grid
      if(lparam==m_GTM_checkGridDisplay.Id()){
         if(m_GTM_checkGridDisplay.CheckButtonState())
            CProgram::GRID_Display(true);            
         else
            CProgram::GRID_Display(false);
      }
      //--- Show/Hide Ask line
      if(lparam==m_Control_checkboxAskLine.Id()){
         if(m_Control_checkboxAskLine.CheckButtonState())
            ChartSetInteger(0,CHART_SHOW_ASK_LINE,true);
         else
            ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
      }
   }
*/  

 
   //--- Button click event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON){
      //--- Click Apply GRID button
      if(lparam==m_GRID_buttonApply.Id()){
         if(!GRID_UpdateStructureInterface(true))
            MessageBox("Fail to refresh variables","Error",0);
         else{
            GRID_Display(false);
            if(!GRID_Initialize())
               MessageBox("Fail to Initialize grid","Error",0);
            else
               GRID_Display(true);
         }
      }
/*      
      //--- Check button group
      if(lparam==m_RISK_ButtonsGroup.Id()){
         curSelectedButton = m_RISK_ButtonsGroup.SelectedButtonIndex();
         
         switch((int)dparam){
            //--- START button
            case 0:
               //isVariablesRefreshed = Op_Refresh_Parameters();
               //if(isVariablesRefreshed){
               //   CTRL_Status=START;
               //   //---Disable all the buttons
               //   RISK_LockDown(true);
               //   GRID_LockDown(true);
               //   Control_LockDown(true);
               //   fn_SendNotification("--->GTM successfully started<----------",true,false,false);
               //}else{
               //   fn_SendNotification("--->GTM Failed to start<----------Variables has not been refreshed",true,false,false);                  
               //   m_RISK_ButtonsGroup.SelectedRadioButton(1);
               //}
               Op_GTM_START();
               break;
            //--- PAUSE button
            case 1:
               //CTRL_Status=PAUSE;
               ////---Enable certain buttons
               //RISK_LockDown(false);
               ////GRID_LockDown(true);
               ////Control_LockDown(true);
               //fn_SendNotification("--->GTM pause<----------",true,false,false); 
               Op_GTM_PAUSE();
               break;
            //--- STOP button
            case 2:
               if(MessageBox("Pressing STOP will close all existing order. Are you sure?","WARNING",MB_YESNO)==IDYES){
                  Op_GTM_STOP();
               //   CTRL_Status=STOP;
               //   fn_CloseAllOrders(acct_MagicNumber);
               //   //---Enable all the buttons
               //   RISK_LockDown(false);
               //   GRID_LockDown(false);
               //   Control_LockDown(false); 
               //   fn_SendNotification("--->GTM successfully stopped<----------",true,false,false);
               }else{
                  m_RISK_ButtonsGroup.SelectedRadioButton(1);
                  fn_SendNotification("--->GTM stop cancelled<----------",true,false,false);
               }
               
               break;
            //--- Default              
            default:
               Op_GTM_PAUSE();
            //CTRL_Status=PAUSE;
              break;
         }
      }           
           
      //if(lparam==m_RISK_ApplyButton.Id()){
      //   if(MessageBox("Apply configuration settings?","Apply Config",MB_YESNO)==IDYES){
      //      if(!Op_Refresh_Parameters())
      //         MessageBox("Fail to Refresh variables","Error",0);            
      //   }
      //} 
*/      
   
   }

   
   //--- Disable entry price when EntryType is Immediate
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM){
      //--- Entry Type is immediate      
      if(lparam==m_RISK_comboEntryType.Id()){
         if(m_RISK_comboEntryType.ButtonText()=="IMMEDIATE"){
            m_RISK_editEntryprice.SpinEditState(false);            
         }else{
            m_RISK_editEntryprice.SpinEditState(true);            
         }
      }      
   }


}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| USER INTERFACE SECTION
//+------------------------------------------------------------------------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(string panelName, bool isTestMode)
{
   //--- Initialize Variables
   if(!OP_Init_Parameters(isTestMode))
      return(false);

   //--- Creating Main Window
   if(!CreateWindow1(panelName))
      return(false);

   //--- Creating controls:
   //    Main menu
   if(!CreateMenuBar())
      return(false);  
   //--- Status bar
   if(!CreateStatusBar())
      return(false);     
   //--- Tabs
   if(!CreateTabs())
      return(false);
   
   //--- Create Risk management components
   if(!RISK_CreateComboEntryType("Entry Type")) 
      return(false);
   if(!RISK_CreateComboDirection("Trade Direction")) 
      return(false);
   if(!RISK_CreateEntryPrice("Entry Price:")) 
      return(false);
   if(!RISK_CreateLotSize("Lot Size:")) 
      return(false);
   if(!RISK_CreateSLPips("SL Pips:")) 
      return(false);
   if(!RISK_CreateTPPips("TP Pips:")) 
      return(false);      
   if(!RISK_CreateTPAmount("TP Amount:")) 
      return(false);
   if(!RISK_CreateMinSpreadPips("MIN Spread:")) 
      return(false);
   if(!RISK_CreateMaxSpreadPips("MAX Spread:")) 
      return(false);
   if(!RISK_CreateMaxLongPosition("MAX LONG Pos:")) 
      return(false);
   if(!RISK_CreateMaxShortPosition("MAX SHORT Pos:")) 
      return(false);            

   //--- Create Grid Management components
   if(!GRID_CreateTable())
     return(false);      
   if(!GRID_CreateGridSize("Grid Size [pips]")) 
     return(false);
   if(!GRID_CreateGridEntry("Grid Entry Level"))
     return(false);
   if(!GRID_CreateResetDistance("Grid Reset Lvl Dst"))
     return(false);      
   if(!GRID_CreateScaleFactor("Scale Factor"))
     return(false);
   if(!GRID_CreateScaleStartLvlDst("Scale Start Lvl Dst"))
     return(false);
   if(!GRID_CreateApplyButton("Create Grid"))
     return(false);

   //--- Create Account components
   //if(!Account_CreateTable()) 
   //   return(false);    
   

   //--- Create Control components
   //if(!Control_CreateSepLine()) 
   //   return(false);   
   //if(!Control_CreateButtonsGroup()) 
   //   return(false);   

   //if(!Control_CreateCheckBoxAskLine("Display ASK Line")) 
   //   return(false);
   
   //--- Display controls of the active tab only
   m_tabs.ShowTabElements();
   
   //--- Redrawing the chart
   m_chart.Redraw();
   
   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+

/*
//+------------------------------------------------------------------------------------------------------------------------------------+
// GRID TREND MULTIPLIER functions
//+------------------------------------------------------------------------------------------------------------------------------------+
void CProgram::GridTrendMultiplier(void)
{

   if(!isVariablesRefreshed){
      MessageBox("Error! Variables not refreshed! GTM Stop","Error",0);
      Print("Error! Variables not refreshed! GTM Stop","Error");
      return;
   }
   
   //+++ Manage Stoploss
   if(grid_isActive == true && CTRL_Status == START){
      GTM_ManageStopLoss();
   }
   
   //+++ Manage Take Profit
   if(grid_isActive == true && CTRL_Status == START){
      GTM_ManageTarget();
   }
   
   if(acct_spreadPips>ticket_Max_Spreads){
      Print("Current spread exceed MAX allowable Spread - Current Spread:",acct_spreadPips," | Allow Spread:",ticket_Max_Spreads);
   }
   
   //+++ Enter trade if grid is inactive and Start button is pressed
   if(grid_isActive == false && CTRL_Status == START){   
   
      if(entryType==IMMEDIATE){
         grid_isActive = GTM_Entry();
      }
      
      if(entryType==PENDING_STOP){
         //BUY_ORDER 
         if(fn_IsPendingStop(entryPrice,LONG)==BUY_ORDER){
            grid_isActive = GTM_Entry();
         }
         //SELL_ORDER 
         else if(fn_IsPendingStop(entryPrice,SHORT)==SELL_ORDER){
            grid_isActive = GTM_Entry();
         }
      }
   
      if(entryType==PENDING_LIMIT){
         //BUY_ORDER 
         if(fn_IsPendingLimit(entryPrice,LONG)==BUY_ORDER){
            grid_isActive = GTM_Entry();
         }
         //SELL_ORDER 
         else if(fn_IsPendingLimit(entryPrice,SHORT)==SELL_ORDER){
            grid_isActive = GTM_Entry();
         }
      }    
   }
   
   //+++ MAINTAIN ACTIVE GRID
   if(grid_isActive == true && CTRL_Status == START){
      grid_isActive = GTM_Manage();
   }
   
   //+++ CLOSE ALL ORDERS
   if(grid_isActive == true && CTRL_Status == STOP){
      Op_GTM_STOP();
      //fn_CloseAllOrders(acct_MagicNumber);
      //grid_isActive = false;
      //Print("---> CTRL_Status=STOP - Close all orders <-------------------");
   }
     
}
*/

/*
//+------------------------------------------------------------------+
//| GTM Function to start the grid
//+------------------------------------------------------------------+
bool CProgram::GTM_Entry(void)
{
   int ticket=0;                       //Store ticket number
   double TPPrice=0;

   double upperGridPrice=0;            //Variable used in setting TP and SL
   double currentGridPrice=0;          //Variable to store current grid price
   double lowerGridPrice=0;            //Variable used in setting TP and SL

   grid_currentIndex    = grid_entryIndex;      // current/entry grid index
   grid_prevIndex       = grid_currentIndex-1;  // previous grid index
   grid_nextIndex       = grid_currentIndex+1;  // next grid index
   
   upperGridPrice    = grid_PriceArray[grid_nextIndex][0];           // update upperGridPrice to next upper level
   currentGridPrice  = grid_PriceArray[grid_currentIndex][0];
   lowerGridPrice    = grid_PriceArray[grid_prevIndex][0];           // update lowerGridPrie to next lower level
   
   if(tradeDirection==LONG){
      TPPrice = upperGridPrice;
      
      ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Entry",acct_MagicNumber);
      if(OrderSelect(ticket,SELECT_BY_TICKET)){
         grid_PriceArray[grid_currentIndex][1]=ticket;               //Update ticket number
         return(true);         
      }
      else{
         fn_SendNotification("Warning LONG entry error! GTM Pause",true,true,true);
         //CTRL_Status=PAUSE;
         Op_GTM_PAUSE();
         return(false);
      }
         
   }else
   if(tradeDirection==SHORT){
      TPPrice = upperGridPrice;
   
      ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Entry",acct_MagicNumber);
   
      if(OrderSelect(ticket,SELECT_BY_TICKET)){
         grid_PriceArray[grid_currentIndex][1]=ticket;               //Update ticket number
         return(true);         
      }
      else{
         fn_SendNotification("Warning SHORT entry error! GTM Pause",true,true,true);
         //CTRL_Status=PAUSE;
         Op_GTM_PAUSE();
         return(false);
      }
   }

   return(true);
}
*/

/*
//+------------------------------------------------------------------+
//| Function to STOP GTM when target profit reached
//+------------------------------------------------------------------+
bool CProgram::GTM_ManageTarget(void)
{
   //+++ Target TP amount hit
   if(conf_TP_Amount!=0 && grid_accumPLAmount+grid_runningPLAmount >= conf_TP_Amount){
      //fn_CloseAllOrders(acct_MagicNumber);
      //CTRL_Status=STOP;
      //grid_isActive=false;
      Op_GTM_STOP();
      fn_SendNotification("---> TARGET Profit hit - Close all orders <-------------------",true,true,true);
   }else
   //+++ Target TP Price hit on Long trade
   if(conf_TP_Price!=0 && tradeDirection==LONG && Ask>=conf_TP_Price)
   {
      //fn_CloseAllOrders(acct_MagicNumber);
      //CTRL_Status=STOP;
      //grid_isActive=false;
      Op_GTM_STOP();
      fn_SendNotification("---> TARGET Price:" + DoubleToStr(conf_TP_Price,4) + " hit - Close all orders <-------------------",true,true,true);
   }else
   //+++ Target TP Price hit on Short trade
   if(conf_TP_Price!=0 && tradeDirection==SHORT && conf_TP_Price>=Bid)
   {      
      //fn_CloseAllOrders(acct_MagicNumber);
      //CTRL_Status=STOP;
      //grid_isActive=false;
      Op_GTM_STOP();
      fn_SendNotification("---> TARGET Price:" + DoubleToStr(conf_TP_Price,4) + " hit - Close all orders <-------------------",true,true,true);
   }
   
   return(true);
}
*/

/*
//+------------------------------------------------------------------+
//| Function to STOP GTM and close all orders when stop loss reached
//+------------------------------------------------------------------+
bool CProgram::GTM_ManageStopLoss(void)
{
   int i=0;
   int isClosed=0;
   double stealthSLPrice=0;

   grid_SL_Price = grid_PriceArray[0][0];  //lowest level - gapSize. Will be use as StopLoss

   if(grid_SL_Price!=0 && tradeDirection==LONG && Bid<=(grid_SL_Price+conf_SL_StealthPips*acct_MyPoint)){
      //fn_CloseAllOrders(acct_MagicNumber);
      //CTRL_Status=STOP;
      //grid_isActive=false;
      Op_GTM_STOP();
      fn_SendNotification("---> STOPLOSS Price:" + DoubleToStr(grid_SL_Price,4) + " hit - Close all orders <-------------------",true,true,true);
   }else
   if(grid_SL_Price!=0 && tradeDirection==SHORT && Ask>=(grid_SL_Price-conf_SL_StealthPips*acct_MyPoint)){  
      //fn_CloseAllOrders(acct_MagicNumber);
      //CTRL_Status=STOP;
      //grid_isActive=false;
      Op_GTM_STOP();
      fn_SendNotification("---> STOPLOSS Price:" + DoubleToStr(grid_SL_Price,4) + " hit - Close all orders <-------------------",true,true,true);
   }

   return(true);
}
*/

/*
//+------------------------------------------------------------------+
//| GTM Functions to manage active grid
//+------------------------------------------------------------------+
bool CProgram::GTM_Manage(void)
{
   bool isNewCandle = fn_IsNewCandle();
   int ticket=0;                       //Store ticket number
   double TPPrice=0;

   double currentPrice=0;
   double upperGridPrice=0;            //Variable for next grid price
   double upperScaleGridPrice=0;       //Variable for next scale grid price
   double currentGridPrice=0;          //Variable for current grid price
   double currentScaleGridPrice=0;     //Variable for scaling current grid price
   double lowerGridPrice=0;            //Variable for previous grid price
   double lowerScaleGridPrice=0;       //Variable for scaling previous grid price
   
   int curTicket,curScaleTicket,prevTicket,prevScaleTicket,nextTicket,nextScaleTicket;

   grid_nextIndex=0;
   grid_nextScaleIndex=0;
   grid_currentIndex=0;
   grid_currentScaleIndex=0;
   grid_prevIndex=0;
   grid_prevScaleIndex=0;
   
   //+++ Scan grid and reset inactive ticket number to 0
   //+++ Return accumulate GTM profit in pips
   grid_accumPLPips = GTM_RefreshGrid();
   
   //+++ Get current index, prev index, next index of lowest active order using ticket number
   GTM_GetIndexByTicket();
   
   //+++ If all the indexes are 0, locate the indexes using current Ask/Bid price
   if(grid_nextIndex==0 && grid_currentIndex==0 && grid_prevIndex==0){
      GTM_GetIndexByPriceLevel();
   }else
   //--- If resume from pause, check current Bid price against scale level and locate index by price level if below gird_prevIndex
   if(tradeDirection==LONG && (double)grid_PriceArray[grid_prevScaleIndex][0] > Ask){
      GTM_GetIndexByPriceLevel();
   }else
   if(tradeDirection==SHORT && (double)grid_PriceArray[grid_prevScaleIndex][0] < Bid){
      GTM_GetIndexByPriceLevel();
   }
   
   //+++ Reset the Grid if 
   //+++    grid_Reset_Level is not 0. If 0 means no reset
   //+++    current index must be higher or equal SL level + grid_Reset_Level
   if(grid_Reset_Level!=0 
      && grid_currentIndex >= grid_Reset_Level)
   {
      fn_SendNotification("---> Grid reset at level: " + grid_currentIndex,true,true,true);
      
      //+++ Reset grid
      GTM_ResetGrid();
      grid_currentIndex = grid_entryIndex;
      //+++ Locate lowest active ticket levels
      GTM_GetIndexByTicket();
      
      //++ If no active order currently then locate grid level using current price
      if(grid_nextIndex==0 && grid_currentIndex==0 && grid_prevIndex==0){
         GTM_GetIndexByPriceLevel();
      }
   }
      
   //+++ Get current StopLoss
   grid_SL_Price=grid_PriceArray[0][0];
      
   //+++ Update current grid pricing and ticket
   upperGridPrice = (double)grid_PriceArray[grid_nextIndex][0];
   nextTicket = (int)grid_PriceArray[grid_nextIndex][1];
   
   upperScaleGridPrice = (double)grid_PriceArray[grid_nextScaleIndex][0];
   nextScaleTicket = (int)grid_PriceArray[grid_nextScaleIndex][1];
      
   currentGridPrice = (double)grid_PriceArray[grid_currentIndex][0];
   curTicket = (int)grid_PriceArray[grid_currentIndex][1];
      
   currentScaleGridPrice = (double)grid_PriceArray[grid_currentScaleIndex][0];
   curScaleTicket = (int)grid_PriceArray[grid_currentScaleIndex][1];  
            
   lowerGridPrice = (double)grid_PriceArray[grid_prevIndex][0];
   prevTicket = (int)grid_PriceArray[grid_prevIndex][1];
   
   lowerScaleGridPrice = (double)grid_PriceArray[grid_prevScaleIndex][0];
   prevScaleTicket = (int)grid_PriceArray[grid_prevScaleIndex][1];
   
   grid_cntActiveTickets=fn_GetOpenOrders(acct_MagicNumber);
   
   //+------------------------------------------------------------------+
   //| Scenario 1.0: LONG ORDERS
   //+------------------------------------------------------------------+
   if(tradeDirection==LONG){
      currentPrice=Ask;   
      
      //+++ Current ticket is active
      if(fn_IsOrderOpened(curTicket,acct_MagicNumber)==true){
         //+++ Scenario 1.1
         //+++    Next ticket is Inactive
         //+++    Current ticket is Active
         //+++    Previous ticket is Inactive
         if(fn_IsOrderOpened(nextTicket,acct_MagicNumber)==false && fn_IsOrderOpened(prevTicket,acct_MagicNumber)==false){

            //+++ Price is on trend
            if(fn_IsPendingStop(upperGridPrice,LONG)==BUY_ORDER && acct_spreadPips <= ticket_Max_Spreads){
            
               TPPrice = grid_PriceArray[grid_nextIndex+1][0];
               if(grid_cntActiveTickets<ticket_Max_Open){
                  ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_nextIndex),acct_MagicNumber);
                  if(OrderSelect(ticket,SELECT_BY_TICKET)){
                     grid_PriceArray[grid_nextIndex][1]=ticket;
                  }else{
                     fn_SendNotification("Warning 1.11 LONG entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                     //CTRL_Status=PAUSE;
                     Op_GTM_PAUSE();
                  }
               }
            }else
            //+++ Scenario 1.12: Price is counter trend
               //+++ Counter Trend Scaling is Active
               if(grid_Scale_Enable && grid_currentIndex <= grid_Scale_StartLevel){
                  //+++ Price is moving down
                  if(fn_IsPendingLimit(lowerScaleGridPrice,LONG)==BUY_ORDER && acct_spreadPips <= ticket_Max_Spreads){
                  
                     TPPrice = currentScaleGridPrice;
                     
                     if(grid_cntActiveTickets<ticket_Max_Open){
                        ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevScaleIndex),acct_MagicNumber);
                        if(OrderSelect(ticket,SELECT_BY_TICKET)){
                           grid_PriceArray[grid_prevScaleIndex][1]=ticket;
                        }else{
                           fn_SendNotification("Warning 1.12 LONG entry error! GTM Pause at level: " + IntegerToString(grid_currentScaleIndex),true,true,true);
                           //CTRL_Status=PAUSE;
                           Op_GTM_PAUSE();
                        }
                     }
                  }
               }
               //+++ Scenario 1.13 Counter Trend Scaling is InActive
               else{
                  //+++ Price is moving down
                  if(fn_IsPendingLimit(lowerGridPrice,LONG)==BUY_ORDER && acct_spreadPips <= ticket_Max_Spreads){
                  
                     TPPrice = currentGridPrice;
                  
                     ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevIndex),acct_MagicNumber);
                     if(OrderSelect(ticket,SELECT_BY_TICKET)){
                        grid_PriceArray[grid_prevIndex][1]=ticket;
                     }else{
                        fn_SendNotification("Warning 1.13 LONG entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                        //CTRL_Status=PAUSE;
                        Op_GTM_PAUSE();
                     }
                  }
               }//--- End counterTrendScaling
                       
         }//--- End scenario 1.1
         
         //+++ Scenario 1.2 - Price going down
         //+++    Next ticket is active
         //+++    Current ticket is active
         //+++    Previous ticket is Inactive
         if(fn_IsOrderOpened(nextTicket,acct_MagicNumber)==true && fn_IsOrderOpened(prevTicket,acct_MagicNumber)==false){

            //+++ Counter Trend Scaling is Active
            if(grid_Scale_Enable && grid_currentIndex<=grid_Scale_StartLevel){
               //+++ Price is moving down
               if(fn_IsPendingLimit(lowerScaleGridPrice,LONG)==BUY_ORDER && acct_spreadPips<=ticket_Max_Spreads){
                  
                  TPPrice = currentScaleGridPrice;
                  
                  if(grid_cntActiveTickets<ticket_Max_Open){
                     ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevScaleIndex),acct_MagicNumber);
                     if(OrderSelect(ticket,SELECT_BY_TICKET)){
                        grid_PriceArray[grid_prevScaleIndex][1]=ticket;
                     }else{
                        fn_SendNotification("Warning 1.21 LONG entry error! GTM Pause at level: " + IntegerToString(grid_currentScaleIndex),true,true,true);
                        //CTRL_Status=PAUSE;
                        Op_GTM_PAUSE();
                     }
                  }
               }
            }
            //+++ Scenario 1.22 Counter Trend Scaling is InActive
            else{
               if(fn_IsPendingLimit(lowerGridPrice,LONG)==BUY_ORDER && acct_spreadPips<=ticket_Max_Spreads){
               
                  TPPrice = currentGridPrice;
                  
                  if(grid_cntActiveTickets<ticket_Max_Open){
                     ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevIndex),acct_MagicNumber);
                     if(OrderSelect(ticket,SELECT_BY_TICKET)){
                        grid_PriceArray[grid_prevIndex][1]=ticket;
                     }else{
                        fn_SendNotification("Warning 1,22 LONG entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                        //CTRL_Status=PAUSE;
                        Op_GTM_PAUSE();
                     }
                  }
               }  
            }//--- End counterTrendScaling
        
         }//--- End scenario 1.2
      }//--- End current ticket is Active
      else
      //+++ Current ticket is inactive due to price gap
      if(fn_IsOrderOpened(curTicket,acct_MagicNumber)==false){
         //--- Only send notification once every new candle
         if(isNewCandle) fn_SendNotification("Warning 1.30 Price gap current ticket #" + IntegerToString(curTicket) + " is inactive",true,true,false);
         
         //--- Ask > currentGridPrice > Low[1]
         if(fn_IsPendingStop(currentGridPrice,LONG)==BUY_ORDER && acct_spreadPips<=ticket_Max_Spreads){               
               TPPrice = upperGridPrice;
               if(grid_cntActiveTickets<ticket_Max_Open){
                  ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_currentIndex),acct_MagicNumber);
                  if(OrderSelect(ticket,SELECT_BY_TICKET)){
                     grid_PriceArray[grid_currentIndex][1]=ticket;
                  }else{
                     fn_SendNotification("Warning 1.31 LONG entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                     //CTRL_Status=PAUSE;
                     Op_GTM_PAUSE();
                  }
               }
         //--- currentGridPrice < Ask < upperGridPrice
         }else if(Ask>=currentGridPrice && Ask+MathMax(acct_spreadPrice,acct_minDistancePrice)<upperGridPrice){
               TPPrice = upperGridPrice;
               if(grid_cntActiveTickets<ticket_Max_Open){
                  ticket=fn_OrderEntry_1(BUY_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_currentIndex),acct_MagicNumber);
                  if(OrderSelect(ticket,SELECT_BY_TICKET)){
                     grid_PriceArray[grid_currentIndex][1]=ticket;
                  }else{
                     fn_SendNotification("Warning 1.32 LONG entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                     //CTRL_Status=PAUSE;
                     Op_GTM_PAUSE();
                  }
               }
         }
      }//--- End current ticket is inactive
   } //--- End BUY_ONLY

   //+------------------------------------------------------------------+
   //| Scenario 2.0: SHORT ORDERS
   //+------------------------------------------------------------------+   
   if(tradeDirection==SHORT){
      currentPrice=Bid;
      
      if(fn_IsOrderOpened(curTicket,acct_MagicNumber)==true){
         
         //+++ Scenario 2.1
         //+++    Next ticket is Inactive
         //+++    Current ticket is Active
         //+++    Previous ticket is Inactive
         if(fn_IsOrderOpened(nextTicket,acct_MagicNumber)==false && fn_IsOrderOpened(prevTicket,acct_MagicNumber)==false){

            //+++ Price is on trend
            if(fn_IsPendingStop(upperGridPrice,SHORT)==SELL_ORDER && acct_spreadPips<=ticket_Max_Spreads){
            
               TPPrice = grid_PriceArray[grid_nextIndex+1][0];
               
               if(grid_cntActiveTickets<ticket_Max_Open){
                  ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_nextIndex),acct_MagicNumber);
                  if(OrderSelect(ticket,SELECT_BY_TICKET)){
                     grid_PriceArray[grid_nextIndex][1]=ticket;
                  }else{
                     fn_SendNotification("Warning 2.11 SHORT entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                     //CTRL_Status=PAUSE;
                     Op_GTM_PAUSE();
                  }
               }
            }else
            //+++ Price is counter trend
               //+++ Counter Trend Scaling is Active
               if(grid_Scale_Enable && grid_currentIndex<=grid_Scale_StartLevel){
                  //+++ Price is moving down
                  if(fn_IsPendingLimit(lowerScaleGridPrice,SHORT)==SELL_ORDER && acct_spreadPips<=ticket_Max_Spreads){
                  
                     TPPrice = currentScaleGridPrice;
                     
                     if(grid_cntActiveTickets<ticket_Max_Open){
                        ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevScaleIndex),acct_MagicNumber);
                        if(OrderSelect(ticket,SELECT_BY_TICKET)){
                           grid_PriceArray[grid_prevScaleIndex][1]=ticket;
                        }else{
                           fn_SendNotification("Warning 2,12 SHORT entry error! GTM Pause at level: " + IntegerToString(grid_currentScaleIndex),true,true,true);
                           //CTRL_Status=PAUSE;
                           Op_GTM_PAUSE();
                        }
                     }
                  }
               }
               //+++ Counter Trend Scaling is InActive
               else{
                  //+++ Price is moving down
                  if(fn_IsPendingLimit(lowerGridPrice,SHORT)==SELL_ORDER && acct_spreadPips<=ticket_Max_Spreads){
                  
                     TPPrice = currentGridPrice;
                     
                     if(grid_cntActiveTickets<ticket_Max_Open){
                        ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevIndex),acct_MagicNumber);
                        if(OrderSelect(ticket,SELECT_BY_TICKET)){
                           grid_PriceArray[grid_prevIndex][1]=ticket;
                        }else{
                           fn_SendNotification("Warning 2.13 SHORT entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                           //CTRL_Status=PAUSE;
                           Op_GTM_PAUSE();
                        }
                     }
                  }
               }//--- End counterTrendScaling          
         }//--- End scenario 2.1
         
         //+++ Scenario 2.2 - Price going down
         //+++    Next ticket is active
         //+++    Current ticket is active
         //+++    Previous ticket is Inactive
         if(fn_IsOrderOpened(nextTicket,acct_MagicNumber)==true && fn_IsOrderOpened(prevTicket,acct_MagicNumber)==false){

            //+++ Counter Trend Scaling is Active
            if(grid_Scale_Enable && grid_currentIndex<=grid_Scale_StartLevel){
               //+++ Price is moving down
               if(fn_IsPendingLimit(lowerScaleGridPrice,SHORT)==SELL_ORDER && acct_spreadPips<=ticket_Max_Spreads){
                  
                  TPPrice = currentScaleGridPrice;
                  
                  if(grid_cntActiveTickets<ticket_Max_Open){
                     ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevScaleIndex),acct_MagicNumber);
                     if(OrderSelect(ticket,SELECT_BY_TICKET)){
                        grid_PriceArray[grid_prevScaleIndex][1]=ticket;
                     }else{
                        fn_SendNotification("Warning 2.21 SHORT entry error! GTM Pause at level: " + IntegerToString(grid_currentScaleIndex),true,true,true);
                        //CTRL_Status=PAUSE;
                        Op_GTM_PAUSE();
                     }
                  }
               }
            }
            //+++ Counter Trend Scaling is InActive
            else{
               if(fn_IsPendingLimit(lowerGridPrice,SHORT)==SELL_ORDER && acct_spreadPips<=ticket_Max_Spreads){
               
                  TPPrice = currentGridPrice;
                  
                  if(grid_cntActiveTickets<ticket_Max_Open){
                     ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_prevIndex),acct_MagicNumber);
                     if(OrderSelect(ticket,SELECT_BY_TICKET)){
                        grid_PriceArray[grid_prevIndex][1]=ticket;
                     }else{
                        fn_SendNotification("Warning 2.22 SHORT entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                        //CTRL_Status=PAUSE;
                        Op_GTM_PAUSE();
                     }
                  }
               }   
            }//--- End counterTrendScaling         
         }//--- End scenario 2.2
      }//--- End current ticket is active  
      else
      //+++ Current ticket is inactive due to price gap
      if(fn_IsOrderOpened(curTicket,acct_MagicNumber)==false){
         //--- Only send notification once every new candle
         if(isNewCandle) fn_SendNotification("Warning 2.30 Price gap current ticket #" + IntegerToString(curTicket) + " is inactive",true,true,false);
         
         //--- Bid < current grid price < High[1]
         if(fn_IsPendingStop(currentGridPrice,SHORT)==SELL_ORDER && acct_spreadPips<=ticket_Max_Spreads){               
               TPPrice = upperGridPrice;
               if(grid_cntActiveTickets<ticket_Max_Open){
                  ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_currentIndex),acct_MagicNumber);
                  if(OrderSelect(ticket,SELECT_BY_TICKET)){
                     grid_PriceArray[grid_currentIndex][1]=ticket;
                  }else{
                     fn_SendNotification("Warning 2.31 SHORT entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                     Op_GTM_PAUSE();
                  }
               }
         //--- Current grid price > Bid > Upper grid price
         }else if(Bid <= currentGridPrice && Bid-MathMax(acct_spreadPrice,acct_minDistancePrice) > upperGridPrice){
               TPPrice = upperGridPrice;
               if(grid_cntActiveTickets<ticket_Max_Open){
                  ticket=fn_OrderEntry_1(SELL_ORDER,lotSize,grid_SL_Price,TPPrice,"Grid Level " + IntegerToString(grid_currentIndex),acct_MagicNumber);
                  if(OrderSelect(ticket,SELECT_BY_TICKET)){
                     grid_PriceArray[grid_currentIndex][1]=ticket;
                  }else{
                     fn_SendNotification("Warning 2.32 SHORT entry error! GTM Pause at level: " + IntegerToString(grid_currentIndex),true,true,true);
                     Op_GTM_PAUSE();
                  }
               }
         }         
      }//--- End current ticket is inactive      
   } //--- End SELL_ONLY   

   return(true);
}
*/

//+------------------------------------------------------------------------------------------------------------------------------------+
// Support functions
//+------------------------------------------------------------------------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Function to initialize configuration parameters
//+------------------------------------------------------------------+
bool CProgram::OP_Init_Parameters(bool isTestMode)
{
   MqlTick currentPrice;
   SymbolInfoTick(Symbol(),currentPrice);
   
   if(isTestMode){
      MoneyManagement.mm_EntryType              =IMMEDIATE;
      MoneyManagement.mm_EntryPrice             =currentPrice.ask;
      MoneyManagement.mm_TradeDirection         =HEDGE;
      MoneyManagement.mm_LotSize                =0.01;
      MoneyManagement.mm_SLPips                 =0;
      MoneyManagement.mm_TPAmount               =1000;
      MoneyManagement.mm_TPPips                 =0;
      MoneyManagement.mm_MaxSpreadPips          =10;
      MoneyManagement.mm_MinSpreadPips          =6;
      MoneyManagement.mm_MaxLongPositions       =3;
      MoneyManagement.mm_MaxShortPositions      =3;
      
      GridManagement.grid_GapSizePips           =10;
      GridManagement.grid_EntryLevel            =500;
      GridManagement.grid_ResetLevelDistance    =100;
      GridManagement.grid_ScaleFactor           =3;
      GridManagement.grid_ScaleStartLvlDst      =100;
      
   }else{
      MoneyManagement.mm_EntryType              =IMMEDIATE;
      MoneyManagement.mm_EntryPrice             =currentPrice.ask;
      MoneyManagement.mm_TradeDirection         =HEDGE;
      MoneyManagement.mm_LotSize                =0.01;
      MoneyManagement.mm_SLPips                 =0;
      MoneyManagement.mm_TPAmount               =1000;
      MoneyManagement.mm_TPPips                 =0;
      MoneyManagement.mm_MaxSpreadPips          =10;
      MoneyManagement.mm_MinSpreadPips          =6;
      MoneyManagement.mm_MaxLongPositions       =3;
      MoneyManagement.mm_MaxShortPositions      =3;
      
      GridManagement.grid_GapSizePips           =10;
      GridManagement.grid_EntryLevel            =500;
      GridManagement.grid_ResetLevelDistance    =100;
      GridManagement.grid_ScaleFactor           =3;
      GridManagement.grid_ScaleStartLvlDst      =100;      
   }
   
   AcctInfo.inf_Point = fn_SetMyPoint();
   AcctInfo.inf_MagicNumber = fn_GenerateMagicNumber(3);
   

/*   
   //--- Account parameters
   acct_MyPoint      =fn_SetMyPoint();                                                    //Initialise broker digit
   acct_MagicNumber  =fn_GenerateMagicNumber(3);                                          //Magic Number
   if(fn_GetMarketInfo(acct_MarketInfo,lotSize)){
      acct_pipValue     =acct_MarketInfo[0];                                              //Value of a pip based on lotSize
      acct_spreadPips   =acct_MarketInfo[1];                                              //Broker spread in pips
      acct_minSLPips    =acct_MarketInfo[2];                                              //Broker minimum StopLoss in pips      
      acct_spreadPrice  =acct_spreadPips*acct_MyPoint;                                    //Broker spread in price
      acct_minDistancePrice = 5*acct_MyPoint;                                             //Min distance to TP price
   }
   //acct_pipValue     =MarketInfo(Symbol(),MODE_TICKVALUE)*0.1*(lotSize/0.01);             //Value of a pip based on lotSize
   //acct_minSLPips    =MarketInfo(Symbol(),MODE_STOPLEVEL)*0.1;                            //Broker minimum StopLoss in pips
   //acct_spreadPips   =MarketInfo(Symbol(),MODE_SPREAD)*0.1;                               //Broker spread in pips
   //acct_spreadPrice  =acct_spreadPips*acct_MyPoint;                                       //Broker spread in price

   table_Account_Rows=10;                                                                 //Number of items in Account table
   ArrayResize(AccountTable,table_Account_Rows);
   
   index=0;
   AccountTable[index][0]="Account Information";
   AccountTable[index][1]="Value";
   index++;
   AccountTable[index][0]="Magic Number";
   AccountTable[index][1]=acct_MagicNumber;
   index++;
   AccountTable[index][0]="Currency Pair";
   AccountTable[index][1]=Symbol();
   index++;
   AccountTable[index][0]="Pip Value";
   AccountTable[index][1]=DoubleToString(acct_pipValue,2);
   index++;
   AccountTable[index][0]="Account Balance";
   AccountTable[index][1]=DoubleToString(AccountBalance(),2);
   index++;
   AccountTable[index][0]="Account Equity";
   AccountTable[index][1]=DoubleToString(AccountEquity(),2);
   index++;
   AccountTable[index][0]="Account Leverage";
   AccountTable[index][1]=AccountLeverage();
   index++;
   AccountTable[index][0]="Current Spread (pips)";
   AccountTable[index][1]=DoubleToString(acct_spreadPips,1);     
   index++;
   AccountTable[index][0]="Min Stop Loss (pips)";
   AccountTable[index][1]=DoubleToString(acct_minSLPips,1);   
   index++;
   AccountTable[index][0]="Running Profit/Loss";
   AccountTable[index][1]=DoubleToString(AccountProfit(),2);

   
   //--- GTM parameter
   grid_cntActiveTickets=0;
   grid_runningPLPips=0;
   grid_runningPLAmount=0;
   grid_accumPLPips=0;
   grid_accumPLAmount=0;
   grid_nextIndex=0;
   grid_currentIndex=0;
   grid_prevIndex=0;
   
   grid_currentIndex=998;                    //Store current index
   grid_currentScaleIndex=998;               //Store current scale index
   grid_prevIndex=997;                       //Store previous index
   grid_prevScaleIndex=997;                  //Store previous scale index
   grid_nextIndex=999;                       //Store next index
   grid_nextScaleIndex=999;                  //Store next scale index
   grid_MaxSize=1000;                        //Used in reseting grid
   grid_isActive=false;                      //Flag to indicate Grid is active

   //+++ Check grid scale starting level and reset to entry if not set
   if(grid_Scale_Enable && grid_Scale_StartLevel==0){
      grid_Scale_StartLevel = grid_entryIndex;
      Print("Scale Start Level is not set. Reseting to Grid Entry Level");
   }
   //+++ Check grid scale factor and reset to 1 if not set
   if(grid_Scale_Factor==0){
      grid_Scale_Factor = 1;
      Print("Grid Scale Factor is not set. Reseting to 1");
   }
       
   if(!GRID_Initialize())
      return(false);

   grid_SL_Price=grid_PriceArray[0][0];      //Store Stoploss price
   GRID_TableRows=11;
   ArrayResize(GRID_Table,GRID_TableRows);
         
*/
   return(true);
}



//+------------------------------------------------------------------+
//| Function to Refresh structure parameters with interfaces value
//+------------------------------------------------------------------+
bool CProgram::Op_Refresh_Parameters(void)
{



   /*
   //--- Grid variables
   grid_Size = m_GRID_editGridSize.GetValue();
   grid_entryIndex = m_GRID_editEntryLevel.GetValue();
   grid_Reset_Level = m_GRID_editResetLevelDistance.GetValue();
   
   grid_Scale_Enable = m_GTM_checkTrendScaling.CheckButtonState();
   grid_Scale_StartLevel = m_GRID_editScaleStartLvlDst.GetValue();
   if(grid_Scale_Enable && grid_Scale_StartLevel==0){
      grid_Scale_StartLevel = grid_entryIndex;
      Print("Scale Start Level is not set. Reseting to Grid Entry Level");
   }
   grid_Scale_Factor = m_GRID_editScaleFactor.GetValue();
   if(grid_Scale_Factor==0){
      grid_Scale_Factor = 1;
      Print("Grid Scale Factor is not set. Reseting to 1");
   }
   
   grid_SL_Price=grid_PriceArray[0][0];      //Store Stoploss price

   //--- Configuration variables
   conf_SL_StealthPips = m_RISKTable.GetValue(1,3);
   conf_TP_Amount = m_RISKTable.GetValue(1,4);
   conf_TP_Price = m_RISKTable.GetValue(1,5);
   ticket_Max_Open = m_RISKTable.GetValue(1,6);
   ticket_Max_Spreads = m_RISKTable.GetValue(1,7);
   */
   
   
   return(true);
}






/*
//+------------------------------------------------------------------+
//| Function to handle grid when START button is pressed
//+------------------------------------------------------------------+
bool CProgram::Op_GTM_START(void)
{
   isVariablesRefreshed = Op_Refresh_Parameters();
   if(isVariablesRefreshed){
      //---Disable all the buttons
      RISK_LockDown(true);
      GRID_LockDown(true);
      Control_LockDown(true,true);
      //---Activate grid
      CTRL_Status=START;
      fn_SendNotification("--->GTM successfully started<----------",true,false,false);
   }else{ // If start failed, select Pause button and send notification
      m_RISK_ButtonsGroup.SelectedRadioButton(1);   //Select pause button
      fn_SendNotification("--->GTM Failed to start<----------Variables has not been refreshed",true,true,false);
      return(false);
   }
   
   return(true);
}
*/

/*
//+------------------------------------------------------------------+
//| Function to handle grid when PAUSE button is pressed
//+------------------------------------------------------------------+
bool CProgram::Op_GTM_PAUSE(void)
{
   CTRL_Status=PAUSE;
   isVariablesRefreshed = false;
   //---Enable certain buttons
   RISK_LockDown(false);
   //GRID_LockDown(true);
   Control_LockDown(false,false);
   m_RISK_ButtonsGroup.SelectedRadioButton(1);      //Select Pause button
   fn_SendNotification("--->GTM pause<----------",true,false,false); 
   return(true);
}
*/

/*
//+------------------------------------------------------------------+
//| Function to handle grid when STOP button is pressed
//+------------------------------------------------------------------+
bool CProgram::Op_GTM_STOP(void)
{
   CTRL_Status=STOP;
   isVariablesRefreshed = false;
   fn_CloseAllOrders(acct_MagicNumber);
   //---Enable all the buttons
   RISK_LockDown(false);
   GRID_LockDown(false);
   Control_LockDown(false,true); 
   m_RISK_ButtonsGroup.SelectedRadioButton(2);      //Select Stop button
   fn_SendNotification("--->GTM successfully stopped<----------",true,false,false);
   return(true);
}
*/

/*
//+------------------------------------------------------------------+
//| Function to reset the grid to reduce the stoploss and margin
//+------------------------------------------------------------------+
bool CProgram::GTM_ResetGrid(void)
{
   double drawGapSize=grid_Size;
   double tempArray[1000][2];
   double currentEntryPrice=0;
 
   //+++ Reset array
   ArrayInitialize(tempArray,0);
   ArrayCopy(tempArray,grid_PriceArray,0,0,WHOLE_ARRAY);
   ArrayInitialize(grid_PriceArray,0);
   //ArrayCopy(grid_PriceArray,tempArray,0,grid_entryIndex,WHOLE_ARRAY);

   // +++ Assign currentEntryPrice and currentEntryTicket if active
   //currentEntryPrice = grid_PriceArray[grid_entryIndex][0];
   currentEntryPrice = tempArray[grid_Reset_Level][0];
   if(fn_IsOrderOpened(tempArray[grid_Reset_Level][1],acct_MagicNumber)==true)
      grid_PriceArray[grid_entryIndex][1] = tempArray[grid_Reset_Level][1];
   
   //Print("grid_entryIndex:",grid_entryIndex," currentEntryPrice:",currentEntryPrice);

   // +++ Re-Initialize grid values
   if(tradeDirection==LONG){
      for (int i=0; i<grid_MaxSize; i++) {
         grid_PriceArray[i][0]= currentEntryPrice + (i-grid_entryIndex)*grid_Size*acct_MyPoint;
      }      
   }else
   if(tradeDirection==SHORT){
      for (int i=0; i<grid_MaxSize; i++) {
         grid_PriceArray[i][0]= currentEntryPrice - (i-grid_entryIndex)*grid_Size*acct_MyPoint;
      }      
   }  
   
   //Print("tradeDirection:",tradeDirection," SL Price:",grid_PriceArray[0][0]);
   
   //+++ Drawing Grid
   GRID_Display(false);
   GRID_Display(true);

   return(true);  
}
*/





/*
//+------------------------------------------------------------------+
//| Function to scan through the grid
//|   Reset ticket number to 0 if ticket has been closed
//|   Calculate and return Accummulate Profit/Loss
//+------------------------------------------------------------------+
double CProgram::GTM_RefreshGrid(void)
{
   //+++ Locate lowset active order and reset inactive order ticket number to 0
   for(int i=1;i<998;i++){
      //+++ Set ticket number to 0 if current order has been closed
      if(grid_PriceArray[i][1] != 0 && fn_IsOrderOpened(grid_PriceArray[i][1],acct_MagicNumber)==false){
         grid_accumPLPips = grid_accumPLPips + fn_GetOrderProfitLossPip(grid_PriceArray[i][1],acct_MyPoint);
         grid_PriceArray[i][1] = 0;
      }
   }//--- End for loop
   
   return grid_accumPLPips;
}
*/

//+------------------------------------------------------------------+
//| Function using ticket number to retrive 
//|   current index, previous index, next index                      
//|   current scale index, previous scale index, next scale index
//+------------------------------------------------------------------+
/* bool CProgram::GTM_GetIndexByTicket(void)
{
   //+++ Locate lowest active order
   for(int i=1;i<998;i++){
      //+++ Return lowest active order ticker
      if(grid_PriceArray[i][1] != 0 && fn_IsOrderOpened(grid_PriceArray[i][1],acct_MagicNumber)==true){
         grid_nextIndex=i+1;
         grid_currentIndex=i;               
         grid_prevIndex=i-1;
         
         if(grid_Scale_Enable){
            //grid_nextScaleIndex=i+1-grid_Scale_Factor;
            //grid_currentScaleIndex=i-grid_Scale_Factor;            
            //grid_prevScaleIndex=i-1-grid_Scale_Factor;
            grid_nextScaleIndex=i+2-grid_Scale_Factor;
            grid_currentScaleIndex=i+1-grid_Scale_Factor;            
            grid_prevScaleIndex=i-grid_Scale_Factor;    
         }
         break;
      }
   }//--- End for loop
   
   return(true);
} */

//+------------------------------------------------------------------+
//| Function to get the current grid index, previous index, next index using price level
//+------------------------------------------------------------------+
/* bool CProgram::GTM_GetIndexByPriceLevel(void)
{
   //+++ Locate lowest active order
   for(int i=1;i<998;i++){
      // If Long trade and current Ask price is between grid upper price and current level price
      if(grid_PriceArray[i][1] == 0 
         && tradeDirection == LONG                                      // Long trade
         && Ask+acct_minSLPips*acct_MyPoint < grid_PriceArray[i+1][0]   // TP price larger than Ask price + min SL
         && Ask >= grid_PriceArray[i][0])                               // Current grid price less than Ask price 
      {
         grid_nextIndex=i+1;
         grid_currentIndex=i;
         grid_prevIndex=i-1;
         
         if(grid_Scale_Enable){
            grid_nextScaleIndex=i+2-grid_Scale_Factor;
            grid_currentScaleIndex=i+1-grid_Scale_Factor;            
            grid_prevScaleIndex=i-grid_Scale_Factor;    
         }

         break;
      }else{
         // If Short trader and current Bid price is between grid lower price and current level price
         if(grid_PriceArray[i][1] == 0 
            && tradeDirection == SHORT                                     // Short trade
            && Bid-acct_minSLPips*acct_MyPoint > grid_PriceArray[i+1][0]   // TP price lower than Bid price - min SL
            && Bid <= grid_PriceArray[i][0])                               // Current grid price larger than Bid price
         {
            grid_nextIndex=i+1;
            grid_currentIndex=i;
            grid_prevIndex=i-1;            
         
            if(grid_Scale_Enable){
               grid_nextScaleIndex=i+2-grid_Scale_Factor;
               grid_currentScaleIndex=i+1-grid_Scale_Factor;            
               grid_prevScaleIndex=i-grid_Scale_Factor;    
            }

            break;
         }
      }
   }//--- End for loop
   
   return(true);
} */

//+------------------------------------------------------------------+
//| Refresh Grid Management interface fields ith struct GridManagementParameters
//+------------------------------------------------------------------+
bool CProgram::GRID_UpdateStructureInterface(bool isInfToStruct)
{  
   //grid_accumPLAmount   =grid_accumPLPips * acct_pipValue;
   //grid_runningPLPips   =fn_GetRunningProfitLossPip(acct_MagicNumber,acct_MyPoint);
   //grid_runningPLAmount =grid_runningPLPips * acct_pipValue;

   if(isInfToStruct){
      GridManagement.grid_GapSizePips        = m_GRID_editGridSize.GetValue();
      GridManagement.grid_EntryLevel         = m_GRID_editEntryLevel.GetValue();
      GridManagement.grid_ResetLevelDistance = m_GRID_editResetLevelDistance.GetValue();
      GridManagement.grid_ScaleFactor        = m_GRID_editScaleFactor.GetValue();
      GridManagement.grid_ScaleStartLvlDst   = m_GRID_editScaleStartLvlDst.GetValue();   
   }else{
      m_GRID_editGridSize.SetValue(GridManagement.grid_GapSizePips);
      m_GRID_editEntryLevel.SetValue(GridManagement.grid_EntryLevel);
      m_GRID_editResetLevelDistance.SetValue(GridManagement.grid_ResetLevelDistance);
      m_GRID_editScaleFactor.SetValue(GridManagement.grid_ScaleFactor);
      m_GRID_editScaleStartLvlDst.SetValue(GridManagement.grid_ScaleStartLvlDst);
   }   
   

//   GRID_Table[8][1]=IntegerToString(grid_nextIndex) + " | " + IntegerToString(grid_nextScaleIndex);
//   GRID_Table[9][1]=IntegerToString(grid_currentIndex) + " | " + IntegerToString(grid_currentScaleIndex);
//   GRID_Table[10][1]=IntegerToString(grid_prevIndex) + " | " + IntegerToString(grid_prevScaleIndex);
//
//   //--- Data and formatting of the table (background color and cell color)
//   for(int c=1; c<TABLE_COLUMNS; c++){
//      for(int r=1; r<GRID_TableRows; r++){
//         m_GRID_Table.SetValue(c,r,GRID_Table[r][c]);
//         m_GRID_Table.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
//         m_GRID_Table.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
//      }
//   }

   //--- Update the table to display changes
   m_GRID_Table.UpdateTable();

   return(true);
}

//+------------------------------------------------------------------+
//| Function to initialize grid
//+------------------------------------------------------------------+
bool CProgram::GRID_Initialize(void)
{
   
   // Initialize Grid index
   for(int i=0; i < ArrayRange(GRID_ARRAY,0) ; i++){
      GRID_ARRAY[i].item_curPrice = MoneyManagement.mm_EntryPrice + (i-GridManagement.grid_EntryLevel)*GridManagement.grid_GapSizePips*AcctInfo.inf_Point;
   }
    
   return(true);       
}

//+------------------------------------------------------------------+
//| Function to Show grid
//+------------------------------------------------------------------+
bool CProgram::GRID_Display(bool show)
{  
   if(show){
      for(int i=0;i<ArrayRange(GRID_ARRAY,0);i++){
         if(i==GridManagement.grid_EntryLevel){
            m_GRID_Gridline.Create(0,"Entry",0,GRID_ARRAY[i].item_curPrice);
            m_GRID_Gridline.Description("Entry Level");
            m_GRID_Gridline.Color(clrBlue);
         }else{
            m_GRID_Gridline.Create(0,"Level "+ (string)i,0,GRID_ARRAY[i].item_curPrice);
            m_GRID_Gridline.Description("Level "+ (string)i);
         }
      	  
         m_GRID_Gridline.Width(1);
         m_GRID_Gridline.Style(STYLE_DASH);
         m_GRID_Gridline.Background(true);
            
         if(i!=GridManagement.grid_EntryLevel){      
            m_GRID_Gridline.Color(clrDarkSlateGray);
         }
      }
   }else{
      fn_RemoveObjects("Level");
      fn_RemoveObjects("Entry");
   }    

   //--- Redraw the chart
   m_chart.Redraw();
      
   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+
//| GRAPHICAL INTERFACE
//+------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------------------------------------------------------------------------+
//| Creates form 1 for controls
//+------------------------------------------------------------------------------------------------------------------------------------+
bool CProgram::CreateWindow1(const string caption_text)
{
   //--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window1);
   
   //--- Coordinates
   int x=(m_window1.X()>0) ? m_window1.X() : 1;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 20;
   
   //--- Properties
   m_window1.Movable(true);
   m_window1.XSize(600);
   m_window1.YSize(400);
   m_window1.WindowBgColor(clrWhiteSmoke);
   m_window1.WindowBorderColor(clrLightSteelBlue);
   m_window1.CaptionBgColor(clrLightSteelBlue);
   m_window1.CaptionBgColorHover(clrLightSteelBlue);
   
   //--- Creating the form
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
   //---
   return(true);
}
  
//+------------------------------------------------------------------------------------------------------------------------------------+
//| Creates the main menu
//+------------------------------------------------------------------------------------------------------------------------------------+
bool CProgram::CreateMenuBar(void)
{
   //--- Three items in the main menu
   #define MENUBAR_TOTAL 3
   
   //--- Store the window pointer
   m_menubar.WindowPointer(m_window1);
   
   //--- Coordinates
   int x=m_window1.X()+MENUBAR_GAP_X;
   int y=m_window1.Y()+MENUBAR_GAP_Y;

   //--- Arrays with unique properties of each item
   int width[MENUBAR_TOTAL] = {50,55,53};
   string text[MENUBAR_TOTAL] = {"File","View","Help"};

   //--- Properties
   m_menubar.MenuBackColor(C'225,225,225');
   m_menubar.MenuBorderColor(C'225,225,225');
   m_menubar.ItemBackColor(C'225,225,225');
   m_menubar.ItemBorderColor(C'225,225,225');

   //--- Add items to the main menu
   for(int i=0; i<MENUBAR_TOTAL; i++)
      m_menubar.AddItem(width[i],text[i]);

   //--- Create control
   if(!m_menubar.CreateMenuBar(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menubar);
   
   return(true);
}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| Creates the status bar
//+------------------------------------------------------------------------------------------------------------------------------------+
bool CProgram::CreateStatusBar(void)
{
   #define STATUS_LABELS_TOTAL 4

   //--- Store the window pointer
   m_status_bar.WindowPointer(m_window1);

   //--- Coordinates
   int x=m_window1.X()+STATUSBAR1_GAP_X;
   int y=m_window1.Y()+STATUSBAR1_GAP_Y;
   //--- Width
   int width[]={0,110,110,110};

   //--- Set properties before creation
   m_status_bar.YSize(25);
   m_status_bar.AreaColor(C'225,225,225'); //
   m_status_bar.AreaBorderColor(C'225,225,225');

   //--- Specify the number of parts and set their properties
   for(int i=0; i<STATUS_LABELS_TOTAL; i++)
      m_status_bar.AddItem(width[i]);

   //--- Create control
   if(!m_status_bar.CreateStatusBar(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Set text in the first item of the status bar
   m_status_bar.ValueToItem(0,"For Help, press F1");
   

   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+
//| Create area with tabs
//+------------------------------------------------------------------------------------------------------------------------------------+
bool CProgram::CreateTabs(void)
{
   #define TABS1_TOTAL 4
   
   //--- Pass the panel object
   m_tabs.WindowPointer(m_window1);

   //--- Coordinates
   int x=m_window1.X()+TABS1_GAP_X;
   int y=m_window1.Y()+TABS1_GAP_Y;

   //--- Arrays with text and width for tabs
   string tabs_text[]={"MONEY MGMT","GRID MGMT","CONTROL","INFORMATION"};
   int tabs_width[]={100,100,100,100};

   //--- Set properties before creation
   m_tabs.XSize(596);
   m_tabs.YSize(330);
   m_tabs.TabYSize(20);
   m_tabs.PositionMode(TABS_TOP);
   m_tabs.SelectedTab((m_tabs.SelectedTab()==WRONG_VALUE) ? 0 : m_tabs.SelectedTab());
   m_tabs.AreaColor(clrWhite);
   m_tabs.TabBackColor(C'225,225,225');
   m_tabs.TabBackColorHover(C'240,240,240');
   m_tabs.TabBackColorSelected(clrWhite);
   m_tabs.TabBorderColor(clrSilver);
   m_tabs.TabTextColor(clrGray);
   m_tabs.TabTextColorSelected(clrBlack);

   //--- Add tabs with the specified properties
   for(int i=0; i<TABS1_TOTAL; i++)
      m_tabs.AddTab(tabs_text[i],tabs_width[i]);

   //--- Create control
   if(!m_tabs.CreateTabs(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tabs);
   return(true);
}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| MONEY MANAGEMENT TAB
//+------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create combo box trade entry type
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateComboEntryType (const string text)
{
   #define comboItems 3
   string entryTypeList[comboItems]={"IMMEDIATE","PENDING_STOP","PENDING_LIMIT"};
   //--- Store pointer to the form
   m_RISK_comboEntryType.WindowPointer(m_window1);
      
   //--- Attach to the RISK Tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_comboEntryType);   
     
   //--- Coordinates
   int x=m_window1.X()+RISK_CB_ENTRY_GAP_X;
   int y=m_window1.Y()+RISK_CB_ENTRY_GAP_Y;
   
   //--- Set up properties before creation
   m_RISK_comboEntryType.XSize(180);
   m_RISK_comboEntryType.YSize(18);
   m_RISK_comboEntryType.LabelText(text);
   m_RISK_comboEntryType.ButtonXSize(100);
   m_RISK_comboEntryType.AreaColor(clrWhiteSmoke);
   m_RISK_comboEntryType.LabelColor(clrBlack);
   m_RISK_comboEntryType.LabelColorHover(clrCornflowerBlue);
   m_RISK_comboEntryType.ButtonBackColor(C'206,206,206');
   m_RISK_comboEntryType.ButtonBackColorHover(C'193,218,255');
   m_RISK_comboEntryType.ButtonBorderColor(C'150,170,180');
   m_RISK_comboEntryType.ButtonBorderColorOff(C'178,195,207');
   m_RISK_comboEntryType.ItemsTotal(comboItems);
   m_RISK_comboEntryType.VisibleItemsTotal(comboItems);
   
   //--- Store the item values to the combo box list
   for(int i=0; i<comboItems; i++)
      m_RISK_comboEntryType.ValueToList(i,entryTypeList[i]);
   
   //--- Get the list pointer
   CListView *lv=m_RISK_comboEntryType.GetListViewPointer();

   //--- Set the list properties
   lv.LightsHover(true);
   
   switch(MoneyManagement.mm_EntryType)
   {
   case  2: lv.SelectedItemByIndex(2); //Pending Limit
     break;
   case  1: lv.SelectedItemByIndex(1); //Pending Stop
     break;
   default: lv.SelectedItemByIndex(0); //Immediate
     break;
   }

   //--- Create a control
   if(!m_RISK_comboEntryType.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_comboEntryType);
   return(true);
}

//+------------------------------------------------------------------+
//| Creates entry price edit field                                                  |
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateEntryPrice(string text)
{
   //--- Store the window pointer
   m_RISK_editEntryprice.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editEntryprice);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_ENTRYPRICE_GAP_X;
   int y=m_window1.Y()+RISK_SE_ENTRYPRICE_GAP_Y;
   //--- Value

   double eValue = MoneyManagement.mm_EntryPrice;

   //--- Set properties before creation
   m_RISK_editEntryprice.XSize(200);
   m_RISK_editEntryprice.YSize(18);
   m_RISK_editEntryprice.EditXSize(76);
   m_RISK_editEntryprice.MaxValue(100000);
   m_RISK_editEntryprice.MinValue(0);
   m_RISK_editEntryprice.StepValue(0.0001);
   m_RISK_editEntryprice.SetDigits(4);
   m_RISK_editEntryprice.SetValue(eValue);
   m_RISK_editEntryprice.ResetMode(false);
   m_RISK_editEntryprice.AreaColor(clrWhiteSmoke);
   m_RISK_editEntryprice.LabelColor(clrBlack);
   m_RISK_editEntryprice.LabelColorLocked(clrSilver);
   m_RISK_editEntryprice.EditColorLocked(clrWhiteSmoke);
   m_RISK_editEntryprice.EditTextColor(clrBlack);
   m_RISK_editEntryprice.EditTextColorLocked(clrSilver);
   m_RISK_editEntryprice.EditBorderColor(clrSilver);
   m_RISK_editEntryprice.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editEntryprice.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- The availability will depend on the current state of the first checkbox
   if(m_RISK_comboEntryType.ButtonText()=="IMMEDIATE")
      m_RISK_editEntryprice.SpinEditState(false);
   else
      m_RISK_editEntryprice.SpinEditState(true);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editEntryprice);

   return(true);
}


//+------------------------------------------------------------------+
//| Create combo box trade direction
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateComboDirection(const string text)
{
   #define comboItems 3
   string directionList[comboItems]={"HEDGE","LONG","SHORT"};

   //--- Store pointer to the form
   m_RISK_comboDirection.WindowPointer(m_window1);
      
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_comboDirection);   
     
   //--- Coordinates
   int x=m_window1.X()+RISK_CB_DIRECTION_GAP_X;
   int y=m_window1.Y()+RISK_CB_DIRECTION_GAP_Y;
   
   //--- Set up properties before creation
   m_RISK_comboDirection.XSize(180);
   m_RISK_comboDirection.YSize(18);
   m_RISK_comboDirection.LabelText(text);
   m_RISK_comboDirection.ButtonXSize(100);
   m_RISK_comboDirection.AreaColor(clrWhiteSmoke);
   m_RISK_comboDirection.LabelColor(clrBlack);
   m_RISK_comboDirection.LabelColorHover(clrCornflowerBlue);
   m_RISK_comboDirection.ButtonBackColor(C'206,206,206');
   m_RISK_comboDirection.ButtonBackColorHover(C'193,218,255');
   m_RISK_comboDirection.ButtonBorderColor(C'150,170,180');
   m_RISK_comboDirection.ButtonBorderColorOff(C'178,195,207');
   m_RISK_comboDirection.ItemsTotal(comboItems);
   m_RISK_comboDirection.VisibleItemsTotal(comboItems);
   
   //--- Store the item values to the combo box list
   for(int i=0; i<comboItems; i++)
      m_RISK_comboDirection.ValueToList(i,directionList[i]);
   
   //--- Get the list pointer
   CListView *lv=m_RISK_comboDirection.GetListViewPointer();

   //--- Set the list properties
   lv.LightsHover(true); 
   switch(MoneyManagement.mm_TradeDirection)
   {
      case -1: lv.SelectedItemByIndex(2); //Short
        break;
      case  1: lv.SelectedItemByIndex(1); //Long
        break;
      default: lv.SelectedItemByIndex(0); //Hedge
        break;
   }

   //--- Create a control
   if(!m_RISK_comboDirection.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_comboDirection);
   return(true);
}



//+------------------------------------------------------------------+
//| Creates lot size edit field                                                  |
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateLotSize(const string text)
{
   //--- Store the window pointer
   m_RISK_editLotSize.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editLotSize);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_LOTSIZE_GAP_X;
   int y=m_window1.Y()+RISK_SE_LOTSIZE_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_LotSize < 0) ? 0.01 : MoneyManagement.mm_LotSize;

   //--- Set properties before creation
   m_RISK_editLotSize.XSize(200);
   m_RISK_editLotSize.YSize(18);
   m_RISK_editLotSize.EditXSize(76);
   m_RISK_editLotSize.MaxValue(50);
   m_RISK_editLotSize.MinValue(0.01);
   m_RISK_editLotSize.StepValue(0.01);
   m_RISK_editLotSize.SetDigits(2);
   m_RISK_editLotSize.SetValue(eValue);
   m_RISK_editLotSize.ResetMode(false);
   m_RISK_editLotSize.AreaColor(clrWhiteSmoke);
   m_RISK_editLotSize.LabelColor(clrBlack);
   m_RISK_editLotSize.LabelColorLocked(clrSilver);
   m_RISK_editLotSize.EditColorLocked(clrWhiteSmoke);
   m_RISK_editLotSize.EditTextColor(clrBlack);
   m_RISK_editLotSize.EditTextColorLocked(clrSilver);
   m_RISK_editLotSize.EditBorderColor(clrSilver);
   m_RISK_editLotSize.EditBorderColorLocked(clrSilver);
   
   
   //--- Create control
   if(!m_RISK_editLotSize.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
         
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editLotSize);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates SL Price edit field
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateSLPips(string text)
{
   //--- Store the window pointer
   m_RISK_editSLPips.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editSLPips);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_SLPIPS_GAP_X;
   int y=m_window1.Y()+RISK_SE_SLPIPS_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_SLPips < 0) ? 0 : MoneyManagement.mm_SLPips;

   //--- Set properties before creation
   m_RISK_editSLPips.XSize(200);
   m_RISK_editSLPips.YSize(18);
   m_RISK_editSLPips.EditXSize(76);
   m_RISK_editSLPips.MaxValue(100000);
   m_RISK_editSLPips.MinValue(0);
   m_RISK_editSLPips.StepValue(10);
   m_RISK_editSLPips.SetDigits(0);
   m_RISK_editSLPips.SetValue(eValue);
   m_RISK_editSLPips.ResetMode(false);
   m_RISK_editSLPips.AreaColor(clrWhiteSmoke);
   m_RISK_editSLPips.LabelColor(clrBlack);
   m_RISK_editSLPips.LabelColorLocked(clrSilver);
   m_RISK_editSLPips.EditColorLocked(clrWhiteSmoke);
   m_RISK_editSLPips.EditTextColor(clrBlack);
   m_RISK_editSLPips.EditTextColorLocked(clrSilver);
   m_RISK_editSLPips.EditBorderColor(clrSilver);
   m_RISK_editSLPips.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editSLPips.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editSLPips);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates TP Price edit field
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateTPPips(string text)
{
   //--- Store the window pointer
   m_RISK_editTPPips.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editTPPips);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_TPPIPS_GAP_X;
   int y=m_window1.Y()+RISK_SE_TPPIPS_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_TPPips < 0) ? 0 : MoneyManagement.mm_TPPips;

   //--- Set properties before creation
   m_RISK_editTPPips.XSize(200);
   m_RISK_editTPPips.YSize(18);
   m_RISK_editTPPips.EditXSize(76);
   m_RISK_editTPPips.MaxValue(100000);
   m_RISK_editTPPips.MinValue(0);
   m_RISK_editTPPips.StepValue(10);
   m_RISK_editTPPips.SetDigits(0);
   m_RISK_editTPPips.SetValue(eValue);
   m_RISK_editTPPips.ResetMode(false);
   m_RISK_editTPPips.AreaColor(clrWhiteSmoke);
   m_RISK_editTPPips.LabelColor(clrBlack);
   m_RISK_editTPPips.LabelColorLocked(clrSilver);
   m_RISK_editTPPips.EditColorLocked(clrWhiteSmoke);
   m_RISK_editTPPips.EditTextColor(clrBlack);
   m_RISK_editTPPips.EditTextColorLocked(clrSilver);
   m_RISK_editTPPips.EditBorderColor(clrSilver);
   m_RISK_editTPPips.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editTPPips.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editTPPips);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates TP Amount edit field
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateTPAmount(string text)
{
   //--- Store the window pointer
   m_RISK_editTPAmount.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editTPAmount);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_TPAMOUNT_GAP_X;
   int y=m_window1.Y()+RISK_SE_TPAMOUNT_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_TPAmount < 0) ? 1000 : MoneyManagement.mm_TPAmount;

   //--- Set properties before creation
   m_RISK_editTPAmount.XSize(200);
   m_RISK_editTPAmount.YSize(18);
   m_RISK_editTPAmount.EditXSize(76);
   m_RISK_editTPAmount.MaxValue(100000);
   m_RISK_editTPAmount.MinValue(0);
   m_RISK_editTPAmount.StepValue(100);
   m_RISK_editTPAmount.SetDigits(2);
   m_RISK_editTPAmount.SetValue(eValue);
   m_RISK_editTPAmount.ResetMode(false);
   m_RISK_editTPAmount.AreaColor(clrWhiteSmoke);
   m_RISK_editTPAmount.LabelColor(clrBlack);
   m_RISK_editTPAmount.LabelColorLocked(clrSilver);
   m_RISK_editTPAmount.EditColorLocked(clrWhiteSmoke);
   m_RISK_editTPAmount.EditTextColor(clrBlack);
   m_RISK_editTPAmount.EditTextColorLocked(clrSilver);
   m_RISK_editTPAmount.EditBorderColor(clrSilver);
   m_RISK_editTPAmount.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editTPAmount.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editTPAmount);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates Min Spread Pips edit field
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateMinSpreadPips(string text)
{
   //--- Store the window pointer
   m_RISK_editMinSpreadPips.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editMinSpreadPips);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_MINSPREADPIPS_GAP_X;
   int y=m_window1.Y()+RISK_SE_MINSPREADPIPS_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_MinSpreadPips < 6) ? 6 : MoneyManagement.mm_MinSpreadPips;

   //--- Set properties before creation
   m_RISK_editMinSpreadPips.XSize(200);
   m_RISK_editMinSpreadPips.YSize(18);
   m_RISK_editMinSpreadPips.EditXSize(76);
   m_RISK_editMinSpreadPips.MaxValue(100000);
   m_RISK_editMinSpreadPips.MinValue(6);
   m_RISK_editMinSpreadPips.StepValue(1);
   m_RISK_editMinSpreadPips.SetDigits(1);
   m_RISK_editMinSpreadPips.SetValue(eValue);
   m_RISK_editMinSpreadPips.ResetMode(false);
   m_RISK_editMinSpreadPips.AreaColor(clrWhiteSmoke);
   m_RISK_editMinSpreadPips.LabelColor(clrBlack);
   m_RISK_editMinSpreadPips.LabelColorLocked(clrSilver);
   m_RISK_editMinSpreadPips.EditColorLocked(clrWhiteSmoke);
   m_RISK_editMinSpreadPips.EditTextColor(clrBlack);
   m_RISK_editMinSpreadPips.EditTextColorLocked(clrSilver);
   m_RISK_editMinSpreadPips.EditBorderColor(clrSilver);
   m_RISK_editMinSpreadPips.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editMinSpreadPips.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editMinSpreadPips);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates Max Spread Pips edit field
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateMaxSpreadPips(string text)
{
   //--- Store the window pointer
   m_RISK_editMaxSpreadPips.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editMaxSpreadPips);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_MAXSPREADPIPS_GAP_X;
   int y=m_window1.Y()+RISK_SE_MAXSPREADPIPS_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_MaxSpreadPips < 6) ? 6 : MoneyManagement.mm_MaxSpreadPips;

   //--- Set properties before creation
   m_RISK_editMaxSpreadPips.XSize(200);
   m_RISK_editMaxSpreadPips.YSize(18);
   m_RISK_editMaxSpreadPips.EditXSize(76);
   m_RISK_editMaxSpreadPips.MaxValue(100000);
   m_RISK_editMaxSpreadPips.MinValue(0);
   m_RISK_editMaxSpreadPips.StepValue(1);
   m_RISK_editMaxSpreadPips.SetDigits(1);
   m_RISK_editMaxSpreadPips.SetValue(eValue);
   m_RISK_editMaxSpreadPips.ResetMode(false);
   m_RISK_editMaxSpreadPips.AreaColor(clrWhiteSmoke);
   m_RISK_editMaxSpreadPips.LabelColor(clrBlack);
   m_RISK_editMaxSpreadPips.LabelColorLocked(clrSilver);
   m_RISK_editMaxSpreadPips.EditColorLocked(clrWhiteSmoke);
   m_RISK_editMaxSpreadPips.EditTextColor(clrBlack);
   m_RISK_editMaxSpreadPips.EditTextColorLocked(clrSilver);
   m_RISK_editMaxSpreadPips.EditBorderColor(clrSilver);
   m_RISK_editMaxSpreadPips.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editMaxSpreadPips.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editMaxSpreadPips);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates MAX LONG Positions edit field
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateMaxLongPosition(string text)
{
   //--- Store the window pointer
   m_RISK_editMaxLongPos.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editMaxLongPos);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_MAXLONGPOS_GAP_X;
   int y=m_window1.Y()+RISK_SE_MAXLONGPOS_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_MaxLongPositions < 1) ? 1 : MoneyManagement.mm_MaxLongPositions;

   //--- Set properties before creation
   m_RISK_editMaxLongPos.XSize(200);
   m_RISK_editMaxLongPos.YSize(18);
   m_RISK_editMaxLongPos.EditXSize(76);
   m_RISK_editMaxLongPos.MaxValue(100000);
   m_RISK_editMaxLongPos.MinValue(1);
   m_RISK_editMaxLongPos.StepValue(1);
   m_RISK_editMaxLongPos.SetDigits(0);
   m_RISK_editMaxLongPos.SetValue(eValue);
   m_RISK_editMaxLongPos.ResetMode(false);
   m_RISK_editMaxLongPos.AreaColor(clrWhiteSmoke);
   m_RISK_editMaxLongPos.LabelColor(clrBlack);
   m_RISK_editMaxLongPos.LabelColorLocked(clrSilver);
   m_RISK_editMaxLongPos.EditColorLocked(clrWhiteSmoke);
   m_RISK_editMaxLongPos.EditTextColor(clrBlack);
   m_RISK_editMaxLongPos.EditTextColorLocked(clrSilver);
   m_RISK_editMaxLongPos.EditBorderColor(clrSilver);
   m_RISK_editMaxLongPos.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editMaxLongPos.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editMaxLongPos);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates MAX SHORT Positions edit field
//+------------------------------------------------------------------+
bool CProgram::RISK_CreateMaxShortPosition(string text)
{
   //--- Store the window pointer
   m_RISK_editMaxShortPos.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(RISK_TabIndex,m_RISK_editMaxShortPos);      
   
   //--- Coordinates
   int x=m_window1.X()+RISK_SE_MAXSHORTPOS_GAP_X;
   int y=m_window1.Y()+RISK_SE_MAXSHORTPOS_GAP_Y;
   //--- Value

   double eValue = (MoneyManagement.mm_MaxShortPositions < 1) ? 1 : MoneyManagement.mm_MaxShortPositions;

   //--- Set properties before creation
   m_RISK_editMaxShortPos.XSize(200);
   m_RISK_editMaxShortPos.YSize(18);
   m_RISK_editMaxShortPos.EditXSize(76);
   m_RISK_editMaxShortPos.MaxValue(100000);
   m_RISK_editMaxShortPos.MinValue(1);
   m_RISK_editMaxShortPos.StepValue(1);
   m_RISK_editMaxShortPos.SetDigits(0);
   m_RISK_editMaxShortPos.SetValue(eValue);
   m_RISK_editMaxShortPos.ResetMode(false);
   m_RISK_editMaxShortPos.AreaColor(clrWhiteSmoke);
   m_RISK_editMaxShortPos.LabelColor(clrBlack);
   m_RISK_editMaxShortPos.LabelColorLocked(clrSilver);
   m_RISK_editMaxShortPos.EditColorLocked(clrWhiteSmoke);
   m_RISK_editMaxShortPos.EditTextColor(clrBlack);
   m_RISK_editMaxShortPos.EditTextColorLocked(clrSilver);
   m_RISK_editMaxShortPos.EditBorderColor(clrSilver);
   m_RISK_editMaxShortPos.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_RISK_editMaxShortPos.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_RISK_editMaxShortPos);

   return(true);
}

//+------------------------------------------------------------------+
//| Refresh Money Management interface fields with struct MoneyManagementParameters
//+------------------------------------------------------------------+
bool CProgram::RISK_UpdateStructureInterface(bool isInfToStruct)
{  
   if(isInfToStruct){
      MoneyManagement.mm_EntryType = StringToEnum(m_RISK_comboEntryType.ButtonText(),MoneyManagement.mm_EntryType);
      MoneyManagement.mm_TradeDirection = StringToEnum(m_RISK_comboDirection.ButtonText(),MoneyManagement.mm_TradeDirection);
      
      if(MoneyManagement.mm_EntryType==IMMEDIATE)
         MoneyManagement.mm_EntryPrice = fn_GetEntryPrice(MoneyManagement.mm_TradeDirection,MoneyManagement.mm_EntryType); 
      else   
         MoneyManagement.mm_EntryPrice = m_RISK_editEntryprice.GetValue();   
      
      MoneyManagement.mm_LotSize = m_RISK_editLotSize.GetValue();
      MoneyManagement.mm_SLPips = m_RISK_editSLPips.GetValue();
      MoneyManagement.mm_TPPips = m_RISK_editTPPips.GetValue();
      MoneyManagement.mm_TPAmount = m_RISK_editTPAmount.GetValue();
      MoneyManagement.mm_MinSpreadPips = m_RISK_editMinSpreadPips.GetValue();
      MoneyManagement.mm_MaxSpreadPips = m_RISK_editMaxSpreadPips.GetValue();
      MoneyManagement.mm_MaxLongPositions = m_RISK_editMaxLongPos.GetValue();
      MoneyManagement.mm_MaxShortPositions = m_RISK_editMaxShortPos.GetValue();
   }else{
      m_RISK_comboEntryType.SelectedItemByIndex(MoneyManagement.mm_EntryType);
      
      switch(MoneyManagement.mm_TradeDirection)
      {
         case 1:
            m_RISK_comboDirection.SelectedItemByIndex(1);
            break;
         case -1:
            m_RISK_comboDirection.SelectedItemByIndex(2);
            break;   
         default:
            m_RISK_comboDirection.SelectedItemByIndex(0);
            break;
      }
 
      m_RISK_editEntryprice.SetValue(MoneyManagement.mm_EntryPrice);
      m_RISK_editLotSize.SetValue(MoneyManagement.mm_LotSize);
      m_RISK_editSLPips.SetValue(MoneyManagement.mm_SLPips);
      m_RISK_editTPPips.SetValue(MoneyManagement.mm_TPPips);
      m_RISK_editTPAmount.SetValue(MoneyManagement.mm_TPAmount);
      m_RISK_editMinSpreadPips.SetValue(MoneyManagement.mm_MinSpreadPips);
      m_RISK_editMaxSpreadPips.SetValue(MoneyManagement.mm_MaxSpreadPips);
      m_RISK_editMaxLongPos.SetValue(MoneyManagement.mm_MaxLongPositions);
      m_RISK_editMaxShortPos.SetValue(MoneyManagement.mm_MaxShortPositions);
   }
   
   return(true);
}

//+------------------------------------------------------------------+
//| Function to Enable/Disable Configuration function
//+------------------------------------------------------------------+
bool CProgram::RISK_LockDown(bool lockStatus)
{
   m_RISK_comboEntryType.ComboBoxState(lockStatus);
   m_RISK_comboDirection.ComboBoxState(lockStatus);
   m_RISK_editEntryprice.SpinEditState(lockStatus);
   m_RISK_editLotSize.SpinEditState(lockStatus);
   m_RISK_editSLPips.SpinEditState(lockStatus);   
   m_RISK_editTPPips.SpinEditState(lockStatus);
   m_RISK_editTPAmount.SpinEditState(lockStatus);
   m_RISK_editMinSpreadPips.SpinEditState(lockStatus);
   m_RISK_editMaxSpreadPips.SpinEditState(lockStatus);
   m_RISK_editMaxLongPos.SpinEditState(lockStatus);
   m_RISK_editMaxShortPos.SpinEditState(lockStatus);
   
   return(true);
}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| GRID MANAGEMENT  tab
//+------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create GRID information table
//+------------------------------------------------------------------+
bool CProgram::GRID_CreateTable()
{
   //--- Store pointer to the form
   m_GRID_Table.WindowPointer(m_window1);

   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_Table);

   //--- Coordinates
   int x=m_window1.X()+TABLE2_GAP_X;
   int y=m_window1.Y()+TABLE2_GAP_Y;

   //--- Set properties before creation
   m_GRID_Table.XSize(400);  //594
   m_GRID_Table.RowYSize(18);
   m_GRID_Table.FixFirstRow(true);
   m_GRID_Table.FixFirstColumn(true);
   m_GRID_Table.LightsHover(true);
   m_GRID_Table.SelectableRow(true);
   m_GRID_Table.ReadOnly(true);
   m_GRID_Table.TextAlign(ALIGN_CENTER);
   m_GRID_Table.HeadersColor(C'255,244,213');
   m_GRID_Table.HeadersTextColor(clrBlack);
   m_GRID_Table.GridColor(clrLightGray);
   m_GRID_Table.CellColorHover(clrGold);
   m_GRID_Table.TableSize(GRID_TableColumns,GRID_TableRows);
   m_GRID_Table.VisibleTableSize(GRID_TableColumns,GRID_TableRows);

   //--- Create control
   if(!m_GRID_Table.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Headers for rows, text alignment mode - right
   m_GRID_Table.SetValue(0,0,"Information");
   m_GRID_Table.TextAlign(0,0,ALIGN_CENTER);
   m_GRID_Table.SetValue(1,0,"LONG");
   m_GRID_Table.TextAlign(1,0,ALIGN_CENTER);
   m_GRID_Table.SetValue(2,0,"SHORT");
   m_GRID_Table.TextAlign(1,0,ALIGN_CENTER);
   
   string itemList[] = {"Next Level | Scale Level","Current Level","Previous Level | Scale Level"};
   
   for(int col=0; col<1; col++){
      for(int row=1; row<GRID_TableRows; row++){
         m_GRID_Table.SetValue(col,row, itemList[row-1]);
         m_GRID_Table.TextAlign(col,row,ALIGN_RIGHT);
      }
   }

   m_GRID_Table.SetValue(1,1,DoubleToString(GridManagement.grid_NextLongLevel,0) + " | " + DoubleToString(GridManagement.grid_NextLongScaleLevel,0));
   m_GRID_Table.SetValue(1,2,DoubleToString(GridManagement.grid_CurLongLevel,0));
   m_GRID_Table.SetValue(1,3,DoubleToString(GridManagement.grid_PrevLongLevel,0) + " | " + DoubleToString(GridManagement.grid_PrevLongScaleLevel,0));

   m_GRID_Table.SetValue(2,1,DoubleToString(GridManagement.grid_NextShortLevel,0) + " | " + DoubleToString(GridManagement.grid_NextShortScaleLevel,0));
   m_GRID_Table.SetValue(2,2,DoubleToString(GridManagement.grid_CurShortLevel,0));
   m_GRID_Table.SetValue(2,3,DoubleToString(GridManagement.grid_PrevShortLevel,0) + " | " + DoubleToString(GridManagement.grid_PrevShortScaleLevel,0));
   
   //--- Data and formatting of the table (background color and cell color)
   for(int col=1; col<GRID_TableColumns; col++){
      for(int row=0; row<GRID_TableRows; row++)
      {
         m_GRID_Table.TextAlign(col,row,ALIGN_RIGHT);
         m_GRID_Table.TextColor(col,row,(col%2==0)? clrRed : clrRoyalBlue);
         m_GRID_Table.CellColor(col,row,(row%2==0)? clrWhiteSmoke : clrWhite);
      }
   }

   //--- Update the table to display changes
   m_GRID_Table.UpdateTable();

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_Table);
   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM Grid size                                         |
//+------------------------------------------------------------------+
bool CProgram::GRID_CreateGridSize(const string text)
{
   //--- Store the window pointer
   m_GRID_editGridSize.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_editGridSize);      
   
   //--- Coordinates
   int x=m_window1.X()+GRID_SE_GRIDSIZE_GAP_X;
   int y=m_window1.Y()+GRID_SE_GRIDSIZE_GAP_Y;
   //--- Value

   double eValue = (GridManagement.grid_GapSizePips < 10 ) ? 10: GridManagement.grid_GapSizePips;

   //--- Set properties before creation
   m_GRID_editGridSize.XSize(200);
   m_GRID_editGridSize.YSize(18);
   m_GRID_editGridSize.EditXSize(76);
   m_GRID_editGridSize.MaxValue(100);
   m_GRID_editGridSize.MinValue(10);
   m_GRID_editGridSize.StepValue(5);
   m_GRID_editGridSize.SetDigits(0);
   m_GRID_editGridSize.SetValue(eValue);
   m_GRID_editGridSize.ResetMode(true);
   m_GRID_editGridSize.AreaColor(clrWhiteSmoke);
   m_GRID_editGridSize.LabelColor(clrBlack);
   m_GRID_editGridSize.LabelColorLocked(clrSilver);
   m_GRID_editGridSize.EditColorLocked(clrWhiteSmoke);
   m_GRID_editGridSize.EditTextColor(clrBlack);
   m_GRID_editGridSize.EditTextColorLocked(clrSilver);
   m_GRID_editGridSize.EditBorderColor(clrSilver);
   m_GRID_editGridSize.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GRID_editGridSize.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_editGridSize);

   return(true);
}


//+------------------------------------------------------------------+
//| Creates GTM entry level                                             |
//+------------------------------------------------------------------+
bool CProgram::GRID_CreateGridEntry(const string text)
{
   //--- Store the window pointer
   m_GRID_editEntryLevel.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_editEntryLevel);      
   
   //--- Coordinates
   int x=m_window1.X()+GRID_SE_ENTRYLEVEL_GAP_X;
   int y=m_window1.Y()+GRID_SE_ENTRYLEVEL_GAP_Y;
   //--- Value

   double eValue = (GridManagement.grid_EntryLevel >= 50 || GridManagement.grid_EntryLevel <= 950) ? GridManagement.grid_EntryLevel : 500;

   //--- Set properties before creation
   m_GRID_editEntryLevel.XSize(200);
   m_GRID_editEntryLevel.YSize(18);
   m_GRID_editEntryLevel.EditXSize(76);
   m_GRID_editEntryLevel.MaxValue(950);
   m_GRID_editEntryLevel.MinValue(50);
   m_GRID_editEntryLevel.StepValue(1);
   m_GRID_editEntryLevel.SetDigits(0);
   m_GRID_editEntryLevel.SetValue(eValue);
   m_GRID_editEntryLevel.ResetMode(true);
   m_GRID_editEntryLevel.AreaColor(clrWhiteSmoke);
   m_GRID_editEntryLevel.LabelColor(clrBlack);
   m_GRID_editEntryLevel.LabelColorLocked(clrSilver);
   m_GRID_editEntryLevel.EditColorLocked(clrWhiteSmoke);
   m_GRID_editEntryLevel.EditTextColor(clrBlack);
   m_GRID_editEntryLevel.EditTextColorLocked(clrSilver);
   m_GRID_editEntryLevel.EditBorderColor(clrSilver);
   m_GRID_editEntryLevel.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GRID_editEntryLevel.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_editEntryLevel);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM reset level                                             |
//+------------------------------------------------------------------+
bool CProgram::GRID_CreateResetDistance(const string text)
{
   //--- Store the window pointer
   m_GRID_editResetLevelDistance.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_editResetLevelDistance);      
   
   //--- Coordinates
   int x=m_window1.X()+GRID_SE_RESETDISTANCE_GAP_X;
   int y=m_window1.Y()+GRID_SE_RESETDISTANCE_GAP_Y;
   //--- Value

   double eValue = (GridManagement.grid_ResetLevelDistance < 0) ? 0:GridManagement.grid_ResetLevelDistance;

   //--- Set properties before creation
   m_GRID_editResetLevelDistance.XSize(200);
   m_GRID_editResetLevelDistance.YSize(18);
   m_GRID_editResetLevelDistance.EditXSize(76);
   m_GRID_editResetLevelDistance.MaxValue(900);
   m_GRID_editResetLevelDistance.MinValue(0);
   m_GRID_editResetLevelDistance.StepValue(1);
   m_GRID_editResetLevelDistance.SetDigits(0);
   m_GRID_editResetLevelDistance.SetValue(eValue);
   m_GRID_editResetLevelDistance.ResetMode(true);
   m_GRID_editResetLevelDistance.AreaColor(clrWhiteSmoke);
   m_GRID_editResetLevelDistance.LabelColor(clrBlack);
   m_GRID_editResetLevelDistance.LabelColorLocked(clrSilver);
   m_GRID_editResetLevelDistance.EditColorLocked(clrWhiteSmoke);
   m_GRID_editResetLevelDistance.EditTextColor(clrBlack);
   m_GRID_editResetLevelDistance.EditTextColorLocked(clrSilver);
   m_GRID_editResetLevelDistance.EditBorderColor(clrSilver);
   m_GRID_editResetLevelDistance.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GRID_editResetLevelDistance.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
         
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_editResetLevelDistance);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM scale factor
//+------------------------------------------------------------------+
bool CProgram::GRID_CreateScaleFactor(const string text)
{
   //--- Store the window pointer
   m_GRID_editScaleFactor.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_editScaleFactor);      
   
   //--- Coordinates
   int x=m_window1.X()+GRID_SE_SCALEFACTOR_GAP_X;
   int y=m_window1.Y()+GRID_SE_SCALEFACTOR_GAP_Y;
   //--- Value

   double eValue = (GridManagement.grid_ScaleFactor < 0 ) ? 2: GridManagement.grid_ScaleFactor;

   //--- Set properties before creation
   m_GRID_editScaleFactor.XSize(200);
   m_GRID_editScaleFactor.YSize(18);
   m_GRID_editScaleFactor.EditXSize(76);
   m_GRID_editScaleFactor.MaxValue(100);
   m_GRID_editScaleFactor.MinValue(0);
   m_GRID_editScaleFactor.StepValue(1);
   m_GRID_editScaleFactor.SetDigits(0);
   m_GRID_editScaleFactor.SetValue(eValue);
   m_GRID_editScaleFactor.ResetMode(true);
   m_GRID_editScaleFactor.AreaColor(clrWhiteSmoke);
   m_GRID_editScaleFactor.LabelColor(clrBlack);
   m_GRID_editScaleFactor.LabelColorLocked(clrSilver);
   m_GRID_editScaleFactor.EditColorLocked(clrWhiteSmoke);
   m_GRID_editScaleFactor.EditTextColor(clrBlack);
   m_GRID_editScaleFactor.EditTextColorLocked(clrSilver);
   m_GRID_editScaleFactor.EditBorderColor(clrSilver);
   m_GRID_editScaleFactor.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GRID_editScaleFactor.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_editScaleFactor);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM scale start level
//+------------------------------------------------------------------+
bool CProgram::GRID_CreateScaleStartLvlDst(const string text)
{
   //--- Store the window pointer
   m_GRID_editScaleStartLvlDst.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_editScaleStartLvlDst);      
   
   //--- Coordinates
   int x=m_window1.X()+GRID_SE_SCALESTARTLEVEL_GAP_X;
   int y=m_window1.Y()+GRID_SE_SCALESTARTLEVEL_GAP_Y;
   //--- Value

   double eValue = (GridManagement.grid_ScaleStartLvlDst < 0 ) ? 100 : GridManagement.grid_ScaleStartLvlDst;

   //--- Set properties before creation
   m_GRID_editScaleStartLvlDst.XSize(200);
   m_GRID_editScaleStartLvlDst.YSize(18);
   m_GRID_editScaleStartLvlDst.EditXSize(76);
   m_GRID_editScaleStartLvlDst.MaxValue(900);
   m_GRID_editScaleStartLvlDst.MinValue(0);
   m_GRID_editScaleStartLvlDst.StepValue(1);
   m_GRID_editScaleStartLvlDst.SetDigits(0);
   m_GRID_editScaleStartLvlDst.SetValue(eValue);
   m_GRID_editScaleStartLvlDst.ResetMode(true);
   m_GRID_editScaleStartLvlDst.AreaColor(clrWhiteSmoke);
   m_GRID_editScaleStartLvlDst.LabelColor(clrBlack);
   m_GRID_editScaleStartLvlDst.LabelColorLocked(clrSilver);
   m_GRID_editScaleStartLvlDst.EditColorLocked(clrWhiteSmoke);
   m_GRID_editScaleStartLvlDst.EditTextColor(clrBlack);
   m_GRID_editScaleStartLvlDst.EditTextColorLocked(clrSilver);
   m_GRID_editScaleStartLvlDst.EditBorderColor(clrSilver);
   m_GRID_editScaleStartLvlDst.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GRID_editScaleStartLvlDst.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_editScaleStartLvlDst);

   return(true);
}

//+------------------------------------------------------------------+
//| Create generate grid button
//+------------------------------------------------------------------+
bool CProgram::GRID_CreateApplyButton(const string text)
{
   //--- Pass the object to the panel
   m_GRID_buttonApply.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_buttonApply);   
   //--- Coordinates
   int x=m_window1.X()+GRID_BTN_APPLY_GAP_X;
   int y=m_window1.Y()+GRID_BTN_APPLY_GAP_Y;
   //--- Set up properties before creation
   m_GRID_buttonApply.ButtonXSize(116);
   m_GRID_buttonApply.TextColor(clrWhite);
   m_GRID_buttonApply.TextColorPressed(clrBlack);
   m_GRID_buttonApply.BackColor(clrForestGreen);
   m_GRID_buttonApply.BackColorHover(C'255,180,180');
   m_GRID_buttonApply.BackColorPressed(C'255,120,120');
   m_GRID_buttonApply.BorderColor(C'150,170,180');
   m_GRID_buttonApply.BorderColorOff(C'178,195,207');
   
   //--- Create the button
   if(!m_GRID_buttonApply.CreateSimpleButton(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_GRID_buttonApply);
   return(true);
}

//+------------------------------------------------------------------+
//| Function to Enable/Disable Grid Management settings
//+------------------------------------------------------------------+
bool CProgram::GRID_LockDown(bool lockStatus)
{
   m_GRID_editGridSize.SpinEditState(!lockStatus);
   m_GRID_editEntryLevel.SpinEditState(!lockStatus);
   m_GRID_editResetLevelDistance.SpinEditState(!lockStatus);
   m_GRID_editScaleFactor.SpinEditState(!lockStatus);
   m_GRID_editScaleStartLvlDst.SpinEditState(!lockStatus);
   m_GRID_buttonApply.ButtonState(!lockStatus);  
   return(true);
}


/*
//+------------------------------------------------------------------------------------------------------------------------------------+
//| Account tab
//+------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create Account table
//+------------------------------------------------------------------+
bool CProgram::Account_CreateTable()
{
   //--- Store pointer to the form
   m_AccountTable.WindowPointer(m_window1);

   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(1,m_AccountTable);

   //--- Coordinates
   int x=m_window1.X()+TABLE2_GAP_X;
   int y=m_window1.Y()+TABLE2_GAP_Y;

   //--- Set properties before creation
   m_AccountTable.XSize(400);  //594
   m_AccountTable.RowYSize(18);
   m_AccountTable.FixFirstRow(true);
   m_AccountTable.FixFirstColumn(true);
   m_AccountTable.LightsHover(true);
   m_AccountTable.SelectableRow(true);
   m_AccountTable.ReadOnly(true);
   m_AccountTable.TextAlign(ALIGN_CENTER);
   m_AccountTable.HeadersColor(C'255,244,213');
   m_AccountTable.HeadersTextColor(clrBlack);
   m_AccountTable.GridColor(clrLightGray);
   m_AccountTable.CellColorHover(clrGold);
   m_AccountTable.TableSize(TABLE_COLUMNS,table_Account_Rows);
   m_AccountTable.VisibleTableSize(VISIBLE_COLUMNS,VISIBLE_ROWS);

   //--- Create control
   if(!m_AccountTable.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Headers for rows, text alignment mode - right
   for(int c=0; c<1; c++){
      for(int r=0; r<table_Account_Rows; r++){
         m_AccountTable.SetValue(c,r,AccountTable[r][c]);
         m_AccountTable.TextAlign(c,r,ALIGN_RIGHT);
      }
   }

   //--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<TABLE_COLUMNS; c++){
      for(int r=0; r<table_Account_Rows; r++)
      {
         m_AccountTable.SetValue(c,r,AccountTable[r][c]);
         m_AccountTable.TextAlign(c,r,ALIGN_RIGHT);
         m_AccountTable.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_AccountTable.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
      }
   }

   //--- Update the table to display changes
   m_AccountTable.UpdateTable();

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_AccountTable);
   return(true);
}

//+------------------------------------------------------------------+
//| Refresh Account table
//+------------------------------------------------------------------+
/*
bool CProgram::Account_RefreshTable()
{  
   if(fn_GetMarketInfo(acct_MarketInfo,lotSize)){
      acct_pipValue     =acct_MarketInfo[0];                                              //Value of a pip based on lotSize
      acct_spreadPips   =acct_MarketInfo[1];                                              //Broker spread in pips
      acct_minSLPips    =acct_MarketInfo[2];                                              //Broker minimum StopLoss in pips      
      acct_spreadPrice  =acct_spreadPips*acct_MyPoint;                                    //Broker spread in price
      acct_minDistancePrice = 5*acct_MyPoint;                                             //Min distance to TP price
   }

   //AccountTable[1][1]=acct_MagicNumber;
   //AccountTable[2][1]=Symbol();
   AccountTable[3][1]=DoubleToString(acct_pipValue,2);
   AccountTable[4][1]=DoubleToString(AccountBalance(),2);
   AccountTable[5][1]=DoubleToString(AccountEquity(),2);
   //AccountTable[6][1]=AccountLeverage();
   AccountTable[7][1]=DoubleToString(acct_spreadPips,1);
   AccountTable[8][1]=DoubleToString(acct_minSLPips,1);
   AccountTable[9][1]=DoubleToString(AccountProfit(),2);


   //--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<TABLE_COLUMNS; c++){
      for(int r=1; r<table_Account_Rows; r++)
      {
         m_AccountTable.SetValue(c,r,AccountTable[r][c]);
         m_AccountTable.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_AccountTable.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
      }
   }

   //--- Update the table to display changes
   m_AccountTable.UpdateTable();

   return(true);
}
*/





//+------------------------------------------------------------------------------------------------------------------------------------+
//| Control tab
//+------------------------------------------------------------------------------------------------------------------------------------+


/*
//+------------------------------------------------------------------+
//| Create group of buttons Start/Pause/Stop
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_colorless.bmp"

//---
bool CProgram::Control_CreateButtonsGroup(void)
{
   //--- Store the window pointer
   m_RISK_ButtonsGroup.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(3,m_RISK_ButtonsGroup);     
   
   //--- Coordinates
   int x =m_window1.X()+CTRL_BTNGROUP1_GAP_X;
   int y =m_window1.Y()+CTRL_BTNGROUP1_GAP_Y;
   //--- Properties
   int    buttons_x_gap[] ={0,150,300};
   int    buttons_y_gap[] ={0,0,0};
   string buttons_text[]  ={"START TRADE","PAUSE TRADE","STOP TRADE"};
   int    buttons_width[] ={92,92,92};

   string items_bmp_on[]= {"Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
                           ,"Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp"
                           ,"Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp"};
   //--- Label array for the blocked mode 
   string items_bmp_off[]= {"Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_colorless.bmp"
                           ,"Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_colorless.bmp"
                           ,"Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_colorless.bmp"};

   //--- Add three buttons to the group
   m_RISK_ButtonsGroup.ButtonsYSize(85);
   m_RISK_ButtonsGroup.IconXGap(14);
   m_RISK_ButtonsGroup.IconYGap(5);
   m_RISK_ButtonsGroup.LabelXGap(15);
   m_RISK_ButtonsGroup.LabelYGap(69);
   m_RISK_ButtonsGroup.BackColor(clrLightGray);
   m_RISK_ButtonsGroup.BackColorHover(C'193,218,255');
   m_RISK_ButtonsGroup.BackColorPressed(C'190,190,200');
   m_RISK_ButtonsGroup.BorderColor(C'150,170,180');
   m_RISK_ButtonsGroup.BorderColorOff(C'178,195,207');

   //--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_RISK_ButtonsGroup.AddButton(buttons_x_gap[i],buttons_y_gap[i],buttons_text[i],buttons_width[i],items_bmp_on[i],items_bmp_off[i]);

   //--- Create a group of buttons
   if(!m_RISK_ButtonsGroup.CreateIconButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Select the STOP button and set the default status is STOP
   m_RISK_ButtonsGroup.SelectedRadioButton(2);
   //CTRL_Status=STOP;

   //--- Lock the group of buttons
   //m_RISK_ButtonsGroup.IconButtonsState(false);

   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_RISK_ButtonsGroup);
   
   return(true);
}

//+------------------------------------------------------------------+
//| Creates a separation line                                        |
//+------------------------------------------------------------------+
bool CProgram::Control_CreateSepLine(void)
{
   //--- Store the window pointer
   m_Control_sepline.WindowPointer(m_window1);

   //--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_Control_sepline);

   //--- Coordinates  
   int x=m_window1.X()+CTRL_SEPLINE_GAP_X;
   int y=m_window1.Y()+CTRL_SEPLINE_GAP_Y;

   //--- Size
   int x_size=2;
   int y_size=210;

   //--- Set properties before creation
   m_Control_sepline.DarkColor(C'213,223,229');
   m_Control_sepline.LightColor(clrWhite);
   m_Control_sepline.TypeSepLine(V_SEP_LINE);

   //--- Creating an element
   if(!m_Control_sepline.CreateSeparateLine(m_chart_id,m_subwin,0,x,y,x_size,y_size))
      return(false);

   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_Control_sepline);
   return(true);
}


//+------------------------------------------------------------------+
//| Creates checkbox display askline
//+------------------------------------------------------------------+
bool CProgram::Control_CreateCheckBoxAskLine(string text)
{
   //--- Store the window pointer
   m_Control_checkboxAskLine.WindowPointer(m_window1);

   //--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_Control_checkboxAskLine);

   //--- Coordinates
   int x=m_window1.X()+CTRL_CHECKBOX2_GAP_X;
   int y=m_window1.Y()+CTRL_CHECKBOX2_GAP_Y;

   //--- Set properties before creation
   m_Control_checkboxAskLine.XSize(90);
   m_Control_checkboxAskLine.YSize(18);
   m_Control_checkboxAskLine.AreaColor(clrWhite);
   m_Control_checkboxAskLine.LabelColor(clrBlack);
   m_Control_checkboxAskLine.LabelColorOff(clrBlack);
   m_Control_checkboxAskLine.LabelColorLocked(clrSilver);
   m_Control_checkboxAskLine.CheckButtonState(true);

   //--- Create control
   if(!m_Control_checkboxAskLine.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_Control_checkboxAskLine);
   return(true);
}

//+------------------------------------------------------------------+
//| Function to Enable/Disable Control functions
//+------------------------------------------------------------------+
bool CProgram::Control_LockDown(bool lockStatus,bool lockAll)
{
   if(lockAll){
      m_RISK_editLotSize.SpinEditState(!lockStatus);
      m_RISK_editEntryprice.SpinEditState(!lockStatus);
      m_RISK_comboDirection.ComboBoxState(!lockStatus);
      m_RISK_comboEntryType.ComboBoxState(!lockStatus);
   }else{
      m_RISK_editLotSize.SpinEditState(!lockStatus);
   }
   
   return(true);
}
*/

//+------------------------------------------------------------------+
//| Function to convert from enumeration to string
//+------------------------------------------------------------------+
template<typename T>
T StringToEnum(string str,T enu)
{
   for(int i=-256;i<256;i++)
      if(EnumToString(enu=(T)i)==str)
         return(enu);
//---
   return(-1);
}