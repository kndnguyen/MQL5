//+------------------------------------------------------------------+
//|                                                  GTM_Program.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property version   "2.0"
#property description   "/nv2.00 Original version"

#include <Strings\String.mqh>
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
#include <ChartObjects\ChartObjectsLines.mqh>
#include <GTM\GTM_Enumerations.mqh>

#import "EALibrary.ex5"

//---Environments Funtions
double   fn_SetMyPoint();
double   fn_GetPipsSpread();
bool     fn_IsNewCandle();
int      fn_GenerateMagicNumber(int trial);
string   fn_IsConnectedToBroker();
// string   fn_RemainingTime();
bool     fn_RemoveObjects(string objName);
bool     fn_SendNotification(string myText,bool printLog,bool sendAlert,bool sendPushNotification);

//Funtions support GTM
long     fn_PlaceImmediateOrder(ENUM_ORDER_TYPE orderType,double orderLotSize,double orderSLPrice,double orderTPPrice,string orderComment,int orderMagicNum,double point);
bool     fn_IsPending(TRADE_DIRECTION direction, double targetPrice,double spreadPips,double Points);
double   fn_GetEntryPrice(TRADE_DIRECTION tradeDirection, ENTRY_TYPE entryType);
bool     fn_GetOpenOrders(GridItem &GridArray[],double &longTicketsCnt,double &shortTicketCnt,int magicNumber);
bool     fn_GetLatestOrderLevel(GridItem &GridArray[],int &longTicketIndex,int &shortTicketIndex,int magicNumber);
bool     fn_GetRunningPL(double &runningLongPL,double &runningShortPL,int magicNumber);
bool     fn_GetAccumulatePL(double &accumLongPL,double &accumShortPL,int magicNumber);

#import

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
      CComboBox         m_GRID_comboScaleMode;
      CSpinEdit         m_GRID_editScaleFactor;
      CSpinEdit         m_GRID_editScaleStartLevel;       
      CSimpleButton     m_GRID_buttonApply;
      CChartObjectHLine m_GRID_Gridline;

      //--- Account information tab
      CTable            m_AccountTable1;
      CTable            m_AccountTable2;
            
      //--- Control tab
      CSeparateLine     m_Control_sepline;
      CIconButtonsGroup m_CTRL_ButtonsGroup;
   
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
      //--- Trade
      void              OnTradeEvent(void);
      
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
      EAOperation       OPStatus;
      bool              OP_Init_Parameters(bool isTestMode);            // Initialise structure parameters before starting application
      bool              OP_Refresh_Parameters(bool isInfToStruct);      // Update structure parameters with oparational values
                                                                        // Call ACCT_UpdateStructureInterface()
                                                                        // Call RISK_UpdateStructureInterface(...)
                                                                        // Call GRID_UpdateStructureInterface(...)

      bool              OP_GTM_START(void);                             // START GTM Program
      bool              OP_GTM_PAUSE(void);                             // PAUSE GTM Program
      bool              OP_GTM_STOP(void);                              // STOP GTM Program
    
      //+------------------------------------------------------------------+
      //| Account tab - merging with Control tab
      //+------------------------------------------------------------------+
      AccountInformation   AcctInfo;
      bool              ACCT_UpdateStructureInterface();                // Update between interface values and structure value
      
      #define  CTRL_TabIndex        (2)
      #define  ACCT_TableRows       (7)
      #define  ACCT_TableColumns    (2)
      #define  ACCT_TABLE1_GAP_X    (5)
      #define  ACCT_TABLE1_GAP_Y    (65) 
      #define  ACCT_TABLE2_GAP_X    (305)
      #define  ACCT_TABLE2_GAP_Y    (65) 
      bool              Account_CreateTable1();                         // Table to display account information
      bool              Account_CreateTable2();                         // Table to display account information

       //+------------------------------------------------------------------+
      //| Control tab
      //+------------------------------------------------------------------+
      //--- Group of icon buttons Start/Pause/Stop
      #define  CTRL_BTNGROUP1_GAP_X        (100)
      #define  CTRL_BTNGROUP1_GAP_Y        (250)
      bool              CTRL_CreateButtonsGroup(void);          

      //+------------------------------------------------------------------+
      //| Risk management tab
      //+------------------------------------------------------------------+
      MoneyManagementParameters     MoneyMgmt;
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
      GridParameters    GridMgmt;
      bool              GRID_UpdateStructureInterface(bool isInfToStruct);    // Update between interface values and structure value
      bool              GRID_LockDown(bool lockStatus);                       // Lock down Grid settings
      
      #define  GRID_TabIndex     (1)
      #define  GRID_TableRows    (4)
      #define  GRID_TableColumns (3)
      #define  GRID_TABLE_GAP_X  (5)
      #define  GRID_TABLE_GAP_Y  (65)          
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
      bool              GRID_CreateScaleMode(const string text);               //Grid reset level  
      #define GRID_SE_SCALEFACTOR_GAP_X     (250)
      #define GRID_SE_SCALEFACTOR_GAP_Y     (150)
      bool              GRID_CreateScaleFactor(const string text);             //Counter Trend Scale Factor
      #define GRID_SE_SCALESTARTLEVEL_GAP_X     (250)
      #define GRID_SE_SCALESTARTLEVEL_GAP_Y     (180)
      bool              GRID_CreateScaleStartLevel(const string text);              //Counter Trend Scale Start level
      #define GRID_BTN_APPLY_GAP_X            (250)
      #define GRID_BTN_APPLY_GAP_Y            (250)
      bool              GRID_CreateApplyButton(const string text);             //Construct grid
    
      //+------------------------------------------------------------------+
      //| GRID TREND MULTIPLIER FUNCTIONS and parameters
      //+------------------------------------------------------------------+ 
      GridItem          GRID_ARRAY[1001];                      //Main array of GridItem structure to keep track of grid levels 
      GridItem          GTMItem;                               //Object to track current Grid Item
      
      bool              GRID_InitializeIndex(void);            // Initialize GRID_ARRAY level and values
      bool              GRID_InitializeScaleIndex(void);       // Initialize GRID_ARRAY scale level and values
      bool              GRID_Display(bool show);               // Draw grid
      bool              GRID_RefreshIndexInformation(GridItem &curGridItem);    // Refresh index information for displaying on Grid Managemen Tab
      
      void              GRIDTRENDMULTIPLIER(void);          //Main function to control Grid Trend Multiplier   
      bool              GTM_Start(void);                    //Function to Enter GTM trade  
      bool              GTM_Manage(void);                   //Function to Manage GTM trade after entering
      bool              GTM_ManageLong(void);               //Function to Manage Long trades
      bool              GTM_ManageShort(void);              //Function to Manage Short trades
      
      GridItem          GTM_GetLevelByPrice(void);          //Function to locate the current Grid level using price
      bool              GTM_ManageTicket(void);             //Function to count open tickets and reset closed tickets to 0
      bool              GTM_ManageScaleStartLevel(void);    //Function to manage Scale Start Level when Scale Mode is 1: Always scale
      
      bool              isFirstStart;                       //Variables used for testing
      
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
   CProgram::GRID_Display(false);
}

//+------------------------------------------------------------------+
//| On Tick event                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTickEvent(void)
{
   //Print("isFirstStart:",isFirstStart);
   //--- Enable only when testing
   if(!isFirstStart){
      OP_GTM_START();
      isFirstStart=true;
   }     
   
   //--- NEVER USE OP_Refresh_Parameters(true) HERE AS IT WILL RESET EVERYTHING
   
   //+++ Update information from Structure to Interface
   switch(OPStatus.GTM_Status)
   {
   case  PAUSE:
      CProgram::ACCT_UpdateStructureInterface();
     break;
   case  START: //--- Entry/Manage GTM every tick
      OPStatus.OP_isVariableRefreshed = OP_Refresh_Parameters(false);    
      CProgram::GTM_ManageTicket();
      CProgram::GRIDTRENDMULTIPLIER();
      break;
   default:
     break;
   }
          
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
//| Trade event                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTradeEvent(void)
{
   //--- Update Accumulate LONG/SHORT PL when OnTradeEvent happens
   fn_GetAccumulatePL(AcctInfo.inf_AccumLongBalance,AcctInfo.inf_AccumShortBalance,AcctInfo.inf_MagicNumber);
   
   //--- Update Scale Start Level if mode is 1: always scale
   CProgram::GTM_ManageScaleStartLevel();

   CProgram::OP_Refresh_Parameters(false);
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

   //--- The text label press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL){
      Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
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
      //--- Update structure parameters
         if(!RISK_UpdateStructureInterface(true))
            MessageBox("Fail to refresh Money Management variables","Error",0);    
      }
      
      if(lparam==m_RISK_comboDirection.Id()){
         //--- Update structure parameters
         if(!RISK_UpdateStructureInterface(true))
            MessageBox("Fail to refresh Money Management variables","Error",0);    
      }    

      if(lparam==m_GRID_comboScaleMode.Id()){
         //--- Update structure parameters
         if(!GRID_UpdateStructureInterface(true))
            MessageBox("Fail to refresh Grid Management variables","Error",0);    
      }      
  
   }
    
   //--- Button click event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON){
      
      //--- Click Apply GRID button
      if(lparam==m_GRID_buttonApply.Id()){
         //--- Update structure parameters
         if(!RISK_UpdateStructureInterface(true))
            MessageBox("Fail to refresh Money Management variables","Error",0);
                  
         if(!GRID_UpdateStructureInterface(true))
            MessageBox("Fail to refresh GRID variables","Error",0);
         
         GRID_Display(false);
         if(!GRID_InitializeIndex())
            MessageBox("Fail to Initialize grid level","Error",0);
         else if(!GRID_InitializeScaleIndex())
            MessageBox("Fail to Initialize grid scale level","Error",0);
         else
            GRID_Display(true);
      }
     
      //--- Check button group
      if(lparam==m_CTRL_ButtonsGroup.Id()){
         curSelectedButton = m_CTRL_ButtonsGroup.SelectedButtonIndex();
         
         switch((int)dparam){
            //--- START button
            case 0:
               //--- Start GTM               
               OP_GTM_START();
               break;
            //--- PAUSE button
            case 1:
               //--- PAUSE GTM               
               OP_GTM_PAUSE();
               break;
            //--- STOP button
            case 2:
               //---STOP GTM
               OP_GTM_STOP();
               break;
            //--- Default              
            default:
               //--- PAUSE GTM
               OP_GTM_PAUSE();
               break;
         }
      }           
   }  //--- End button click event

}

//+------------------------------------------------------------------------------------------------------------------------------------+
//| USER INTERFACE SECTION
//+------------------------------------------------------------------------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(string panelName, bool isTestMode)
{  
   if(isTestMode)
      isFirstStart = false;
   else
      isFirstStart = true;   
   
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
   if(!GRID_CreateScaleMode("Grid Scale Mode"))
     return(false);      
   if(!GRID_CreateScaleFactor("Scale Factor"))
     return(false);
   if(!GRID_CreateScaleStartLevel("Scale Start Level"))
     return(false);
   if(!GRID_CreateApplyButton("Create Grid"))
     return(false);

   //--- Create Account components
   if(!Account_CreateTable1()) 
      return(false);  
   if(!Account_CreateTable2()) 
      return(false);      
   

   //--- Create Control components
   //if(!Control_CreateSepLine()) 
   //   return(false);   
   if(!CTRL_CreateButtonsGroup()) 
      return(false);   

   //if(!Control_CreateCheckBoxAskLine("Display ASK Line")) 
   //   return(false);
   
   //--- Display controls of the active tab only
   m_tabs.ShowTabElements();
   
   //--- Redrawing the chart
   m_chart.Redraw();
   
   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+


//+------------------------------------------------------------------------------------------------------------------------------------+
// GRID TREND MULTIPLIER operations
//+------------------------------------------------------------------------------------------------------------------------------------+
void CProgram::GRIDTRENDMULTIPLIER(void)
{
   //--- Refresh Operation Parameters
   OPStatus.OP_isVariableRefreshed = OP_Refresh_Parameters(true);
   if(!OPStatus.OP_isVariableRefreshed){
      fn_SendNotification(Symbol()+"-EA STOP at function GRIDTRENDMULTIPLIER. Variables not refreshed",true,true,true);
      CProgram::OP_GTM_STOP();
      return;
   }
   
   //+++ Manage Stoploss
   //if(grid_isActive == true && CTRL_Status == START){
   //   GTM_ManageStopLoss();
   //}
   
   //+++ Manage Take Profit
   //if(grid_isActive == true && CTRL_Status == START){
   //   GTM_ManageTarget();
   //}
      
   //--- Start GTM operation if START and GRID is still In-active
   if(OPStatus.GTM_Status == START && OPStatus.GTM_isActive == false){
      
      //--- IMMEDIATE entry
      if(MoneyMgmt.mm_EntryType==IMMEDIATE){         
         //--- After GTM_Start then GTMItem will be set to current entry
         if(!GTM_Start()){
            //--- Error entering GTM Stop
            OP_GTM_STOP();
            fn_SendNotification(Symbol()+"-EA STOP at function GRIDTRENDMULTIPLIER. Fail to IMMEDIATE Entry",true,true,true);
         }
      }
      
      //--- PENDING entry
      if(MoneyMgmt.mm_EntryType==PENDING){
         //--- Only Start when GTM has reached the target price level
         if(fn_IsPending(HEDGE,GRID_ARRAY[GridMgmt.grid_EntryLevel].item_curPrice,MoneyMgmt.mm_MaxSpreadPips,AcctInfo.inf_Point)){
            //--- After GTM_Start then GTMItem will be set to current entry
            if(!GTM_Start()){
               //--- Error entering GTM Stop
               OP_GTM_STOP();
               fn_SendNotification(Symbol()+"-EA STOP at function GRIDTRENDMULTIPLIER. Fail to PENDING Entry",true,true,true);
            }
         }
      }
   }
   
   //--- Manage GTM operation if START and GRID are Active
   if(OPStatus.GTM_Status == START && OPStatus.GTM_isActive == true){
      OPStatus.GTM_isActive = GTM_Manage();
   }
   
   //--- Stop GTM operation when status is Stop
   if(OPStatus.GTM_Status == STOP){
      OPStatus.GTM_isActive = OP_GTM_STOP();
      Print("--->" + Symbol() + " - GTM STOP <-------------------");
   }
     
}

//+------------------------------------------------------------------+
//| GTM Function to start enter trade
//+------------------------------------------------------------------+
bool CProgram::GTM_Start(void)
{
   //--- GTM status not ACTIVE
   OPStatus.GTM_isActive = false;
   //-- Set GTMItem to Entry index
   GTMItem = GRID_ARRAY[GridMgmt.grid_EntryLevel];
   
   //--- Trim comment
   string myString = GTMItem.item_Comment;
   int trimIdx = StringTrimLeft(myString);
   
   if(MoneyMgmt.mm_TradeDirection == HEDGE){
      //--- Place BUY order
      if(AcctInfo.inf_CurLongTickets < MoneyMgmt.mm_MaxLongPositions){
         GTMItem.item_BUYTicket = fn_PlaceImmediateOrder(ORDER_TYPE_BUY,MoneyMgmt.mm_LotSize,0,GTMItem.item_nextPrice,"BUY-" + myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
               
         if(GTMItem.item_BUYTicket <= 0){         
            fn_SendNotification(Symbol()+"GTM_Start-Error entering LONG trade!",true,true,true);
         }else{
            //--- Update GRID_ARRAY
            GRID_ARRAY[GridMgmt.grid_EntryLevel].item_BUYTicket = GTMItem.item_BUYTicket;
            //--- Set GTM status to ACTIVE      
            OPStatus.GTM_isActive = true;
            //--- Send notification
         }
      }//---         
      
      //--- Place SELL order
      if(AcctInfo.inf_CurShortTickets < MoneyMgmt.mm_MaxShortPositions){

         GTMItem.item_SELLTicket = fn_PlaceImmediateOrder(ORDER_TYPE_SELL,MoneyMgmt.mm_LotSize,0,GTMItem.item_prevPrice,"SELL-" + myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
         if(GTMItem.item_SELLTicket <= 0){         
            fn_SendNotification(Symbol()+"GTM_Start-Error entering SHORT trade!",true,true,true);
         }else{
            //--- Update GRID_ARRAY
            GRID_ARRAY[GridMgmt.grid_EntryLevel].item_SELLTicket = GTMItem.item_SELLTicket;
            OPStatus.GTM_isActive = true;
            //--- Send notification
         }
      }//---
      
      //--- Update to the interface
      CProgram::GRID_RefreshIndexInformation(GTMItem);
   }   

   if(MoneyMgmt.mm_TradeDirection == LONG){
      //--- Place BUY order
      GTMItem.item_BUYTicket = fn_PlaceImmediateOrder(ORDER_TYPE_BUY,MoneyMgmt.mm_LotSize,0,GTMItem.item_nextPrice,"BUY-" + myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
      if(GTMItem.item_BUYTicket <= 0){         
         fn_SendNotification(Symbol()+"GTM_Start-Error entering LONG trade!",true,true,true);
      }else{
         //--- Update GRID_ARRAY
         GRID_ARRAY[GridMgmt.grid_EntryLevel].item_BUYTicket = GTMItem.item_BUYTicket;
         //--- Set GTM status to ACTIVE      
         OPStatus.GTM_isActive = true;
      }
      //--- Update to the interface
      CProgram::GRID_RefreshIndexInformation(GTMItem);
   }

   if(MoneyMgmt.mm_TradeDirection == SHORT){
      //--- Place SELL order
      GTMItem.item_SELLTicket = fn_PlaceImmediateOrder(ORDER_TYPE_SELL,MoneyMgmt.mm_LotSize,0,GTMItem.item_prevPrice,"SELL-" + myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
      if(GTMItem.item_SELLTicket <= 0){         
         fn_SendNotification(Symbol()+"GTM_Start-Error entering SHORT trade!",true,true,true);
      }else{
         //--- Update GRID_ARRAY
         GRID_ARRAY[GridMgmt.grid_EntryLevel].item_SELLTicket = GTMItem.item_SELLTicket;
         OPStatus.GTM_isActive = true;
      }
      //--- Update to the interface
      CProgram::GRID_RefreshIndexInformation(GTMItem);
   }   
   
   return OPStatus.GTM_isActive;
}


//+------------------------------------------------------------------+
//| GTM Functions to manage Active grid
//+------------------------------------------------------------------+
bool CProgram::GTM_Manage(void)
{
   bool isNewCandle = fn_IsNewCandle();
         
   //--- Locate the current GTM Level
   GTMItem = GTM_GetLevelByPrice();
   //--- If Current level is 0 PAUSE EA
   if(GTMItem.item_curIndex == 0){
      fn_SendNotification(Symbol()+"-Error at function GTM_Manage-EA PAUSE due to unable to locate Current GTM Level",true,true,true);
      CProgram::OP_GTM_PAUSE();
      return(true);
   }else{
      //--- Update to the interface
      CProgram::GRID_RefreshIndexInformation(GTMItem);
   }
         
   switch(MoneyMgmt.mm_TradeDirection)
   {
      case HEDGE:
         if(!GTM_ManageLong()) CProgram::OP_GTM_PAUSE();
         if(!GTM_ManageShort()) CProgram::OP_GTM_PAUSE();
         break;
      case LONG:
         if(!GTM_ManageLong()) CProgram::OP_GTM_PAUSE();
         break;
      case SHORT:
         if(!GTM_ManageShort()) CProgram::OP_GTM_PAUSE();
         break;
      default:
         fn_SendNotification(Symbol()+"-Error at function GTM_Manage - Invalid Trade Direction",true,true,true);
         CProgram::OP_GTM_PAUSE();
         break;
   }

   return(true);
}


//+------------------------------------------------------------------+
//| GTM Functions to manage LONG Trades
//|   Input: GTMItem  with level != 0
//+------------------------------------------------------------------+
bool CProgram::GTM_ManageLong(void)
{
   string myString = GTMItem.item_Comment;
   int trimIdx = StringTrimLeft(myString);
   myString = "BUY-" + myString;

   string myMessage = Symbol() + "-BUY:" + DoubleToString(MoneyMgmt.mm_LotSize,2) + " lots"
                     + "-TP:" + DoubleToString(GTMItem.item_nextPrice,4) + " or " + DoubleToString(MathAbs(GTMItem.item_nextPrice-Ask)/AcctInfo.inf_Point,1) + " pips"                     
                     + "-SL:" + DoubleToString(0,4) + " or " + DoubleToString(0,1) + " pips";
      
   //--- Current LONG ticket is INACTIVE
   if(!PositionSelectByTicket(GTMItem.item_BUYTicket)){
      //--- NO SCALE: Place the order
      //--- MANUAL SCALE, AUTO SCALE: Check scale level
      //--- ALWAYS SCALE: Move to next condition   
      if(    GridMgmt.grid_ScaleMode == NO_SCALE
         || (GridMgmt.grid_ScaleMode != ALWAYS_SCALE && GTMItem.item_curIndex >= GridMgmt.grid_ScaleStartLevel)
      ){
         //--- Check if price is at current level
         //--- Check Max allow open tickets
         if(fn_IsPending(LONG,GTMItem.item_curPrice,MoneyMgmt.mm_MaxSpreadPips,AcctInfo.inf_Point)
            && AcctInfo.inf_CurLongTickets < MoneyMgmt.mm_MaxLongPositions
         ){
            //--- Place BUY order
            GTMItem.item_BUYTicket = fn_PlaceImmediateOrder(ORDER_TYPE_BUY,MoneyMgmt.mm_LotSize,0,GTMItem.item_nextPrice,myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
            if(GTMItem.item_BUYTicket <= 0){         
               fn_SendNotification(Symbol()+"-Error at function GTM_ManageLong-Error placing LONG order",true,true,true);
               return(false);
            }else{
               //--- Update GRID_ARRAY
               GRID_ARRAY[GTMItem.item_curIndex].item_BUYTicket = GTMItem.item_BUYTicket;
               fn_SendNotification(myMessage,true,false,true);
            }
         }
      //--- NO SCALE: Move to next condition
      //--- MANUAL SCALE, AUTO SCALE: Check scale start level
      //--- ALWAYS SCALE: Go ahead
      }else if(    GridMgmt.grid_ScaleMode == ALWAYS_SCALE
               || (GridMgmt.grid_ScaleMode != NO_SCALE && GTMItem.item_curIndex < GridMgmt.grid_ScaleStartLevel)
      ){
         //--- Only Progress further if current level is also scale level
         if(GTMItem.item_curIndex == GTMItem.item_curScaleIndex){
            //--- Check if price is at current level
            if(fn_IsPending(LONG,GTMItem.item_curPrice,MoneyMgmt.mm_MaxSpreadPips,AcctInfo.inf_Point)
               && AcctInfo.inf_CurLongTickets < MoneyMgmt.mm_MaxLongPositions
            ){
               //--- Place BUY order
               GTMItem.item_BUYTicket = fn_PlaceImmediateOrder(ORDER_TYPE_BUY,MoneyMgmt.mm_LotSize,0,GTMItem.item_nextScalePrice,myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
               if(GTMItem.item_BUYTicket <= 0){         
                  fn_SendNotification(Symbol()+"-Error at function GTM_ManageLong-Error placing LONG Scaling order",true,true,true);
                  return(false);
               }else{
                  //--- Update GRID_ARRAY
                  GRID_ARRAY[GTMItem.item_curIndex].item_BUYTicket = GTMItem.item_BUYTicket;
                  fn_SendNotification(myMessage,true,false,true);
               }
            }
         }//--- End check current level is also scaling level
      }//--- End grid_ScaleStartLevel check
   }//--- End checking current LONG tiket

   return (true);
}

//+------------------------------------------------------------------+
//| GTM Functions to manage SHORT Trades
//+------------------------------------------------------------------+
bool CProgram::GTM_ManageShort(void)
{
   string myString = GTMItem.item_Comment;
   int trimIdx = StringTrimLeft(myString);
   myString = "SELL-" + myString;

   //--- TODO: Handle gap
   string myMessage = Symbol() + "-SELL:" + DoubleToString(MoneyMgmt.mm_LotSize,2) + " lots"
                     + "-TP:" + DoubleToString(GTMItem.item_prevPrice,4) + " or " + DoubleToString(MathAbs(GTMItem.item_prevPrice-Bid)/AcctInfo.inf_Point,1) + " pips"                     
                     + "-SL:" + DoubleToString(0,4) + " or " + DoubleToString(0,1) + " pips";

   
   //--- Current SHORT ticket is INACTIVE
   if(!PositionSelectByTicket(GTMItem.item_SELLTicket)){
      //--- NO SCALE: Move to next condition
      //--- MANUAL SCALE, AUTO SCALE: Check scale start level
      //--- ALWAYS SCALE: Go ahead
      if(    GridMgmt.grid_ScaleMode == ALWAYS_SCALE
         || (GridMgmt.grid_ScaleMode != NO_SCALE && GTMItem.item_curIndex > GridMgmt.grid_ScaleStartLevel)
      ){
         //--- Only Progress further if current level is also scale level
         if(GTMItem.item_curIndex == GTMItem.item_curScaleIndex){
            //--- Check if price is at current level
            if(fn_IsPending(SHORT,GTMItem.item_curPrice,MoneyMgmt.mm_MaxSpreadPips,AcctInfo.inf_Point)
               && AcctInfo.inf_CurShortTickets < MoneyMgmt.mm_MaxShortPositions
            ){
               //--- Place BUY order
               GTMItem.item_SELLTicket = fn_PlaceImmediateOrder(ORDER_TYPE_SELL,MoneyMgmt.mm_LotSize,0,GTMItem.item_prevScalePrice,myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
               if(GTMItem.item_SELLTicket <= 0){         
                  fn_SendNotification(Symbol()+"-Error at function GTM_ManageLong-Error placing SHORT order",true,true,true);
                  return(false);
               }else{
                  //--- Update GRID_ARRAY
                  GRID_ARRAY[GTMItem.item_curIndex].item_SELLTicket = GTMItem.item_SELLTicket;
                  fn_SendNotification(myMessage,true,false,true);
               }
            }
         }//--- End check current level is also scaling level

      //--- NO SCALE: Place order
      //--- MANUAL SCALE, AUTO SCALE: Check scale start level
      //--- ALWAYS SCALE: Move to next condition
      }else if(    GridMgmt.grid_ScaleMode == NO_SCALE
               || (GridMgmt.grid_ScaleMode != ALWAYS_SCALE && GTMItem.item_curIndex <= GridMgmt.grid_ScaleStartLevel)      
      ){
         //--- Check if price is at current level
         if(fn_IsPending(SHORT,GTMItem.item_curPrice,MoneyMgmt.mm_MaxSpreadPips,AcctInfo.inf_Point)
            && AcctInfo.inf_CurShortTickets < MoneyMgmt.mm_MaxShortPositions
         ){
            //--- Place SELL order
            GTMItem.item_SELLTicket = fn_PlaceImmediateOrder(ORDER_TYPE_SELL,MoneyMgmt.mm_LotSize,0,GTMItem.item_prevPrice,myString,AcctInfo.inf_MagicNumber,AcctInfo.inf_Point);
            if(GTMItem.item_SELLTicket <= 0){         
               fn_SendNotification(Symbol()+"-Error at function GTM_ManageLong-Error placing SHORT Scaling order",true,true,true);
               return(false);
            }else{
               //--- Update GRID_ARRAY
               GRID_ARRAY[GTMItem.item_curIndex].item_SELLTicket = GTMItem.item_SELLTicket;
               fn_SendNotification(myMessage,true,false,true);               
            }
         }
      }//--- End grid_ScaleStartLevel check
   }//--- End checking current SHORT tiket


   return (true);
}



//+------------------------------------------------------------------+
//| Function to Return total open deals
//+------------------------------------------------------------------+
bool CProgram::GTM_ManageTicket(void)
{
   //--- Count open tickets and reset closed ticket number to 0
   if(!fn_GetOpenOrders(GRID_ARRAY,AcctInfo.inf_CurLongTickets,AcctInfo.inf_CurShortTickets,AcctInfo.inf_MagicNumber)){
      return (false);
   }
   
   //--- Update interface
   return(true);
}

//+------------------------------------------------------------------+
//| Function to Manage ScaleStartLevel when mode is AUTO SCALE
//+------------------------------------------------------------------+
bool CProgram::GTM_ManageScaleStartLevel(void)
{
   if(GridMgmt.grid_ScaleMode != AUTO_SCALE){
      return(true);
   }   

   int longTicketIndex = 0;
   int shortTicketIndex = 0;
   
   //--- Retrieve current level of Long ticket and Short Ticket
   fn_GetLatestOrderLevel(GRID_ARRAY,longTicketIndex,shortTicketIndex,AcctInfo.inf_MagicNumber);

   //--- The number of ticket different
   int ticketDiff = AcctInfo.inf_CurLongTickets - AcctInfo.inf_CurShortTickets;
      
   //--- More Long tickets than Short tickets -> Down trend
   //--- Set to Previous Scale level
   if(ticketDiff > 0){
      GridMgmt.grid_ScaleStartLevel = (shortTicketIndex == 0) ?  GridMgmt.grid_ScaleStartLevel : GRID_ARRAY[shortTicketIndex].item_nextScaleIndex;
   //--- More Short ticket than Long tickets -> Up trend
   //--- Set to Next Scale level
   }else if(ticketDiff < 0){
      GridMgmt.grid_ScaleStartLevel = (longTicketIndex == 0) ?  GridMgmt.grid_ScaleStartLevel : GRID_ARRAY[longTicketIndex].item_prevScaleIndex;
   //--- Balance
   }else{
      //--- Mid scale level
      //--- Leave as it is
   }

   //--- Update interface
   GRID_Display(false);
   GRID_Display(true);
   
   return(true);
}



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

   AcctInfo.inf_Point = fn_SetMyPoint();
   AcctInfo.inf_MagicNumber = fn_GenerateMagicNumber(3);
   AcctInfo.inf_CurrencyPair = Symbol();
   AcctInfo.inf_CurSpreadPips = fn_GetPipsSpread();  
   
   AcctInfo.inf_RunningShortPL = 0;
   AcctInfo.inf_RunningLongPL = 0;
   AcctInfo.inf_AccumShortBalance = 0;
   AcctInfo.inf_AccumLongBalance = 0;
   AcctInfo.inf_PruneBalance = 0;
   AcctInfo.inf_CurLongTickets = 0;
   AcctInfo.inf_CurShortTickets = 0;
    
   if(isTestMode){
      OPStatus.GTM_Status = START;
      
      MoneyMgmt.mm_EntryType              =IMMEDIATE;
      MoneyMgmt.mm_TradeDirection         =HEDGE;
      MoneyMgmt.mm_EntryPrice             =fn_GetEntryPrice(MoneyMgmt.mm_TradeDirection,MoneyMgmt.mm_EntryType);
      MoneyMgmt.mm_LotSize                =0.01;
      MoneyMgmt.mm_SLPips                 =0;
      MoneyMgmt.mm_TPAmount               =1000;
      MoneyMgmt.mm_TPPips                 =0;
      MoneyMgmt.mm_MaxSpreadPips          =6;
      MoneyMgmt.mm_MinSpreadPips          =6;
      MoneyMgmt.mm_MaxLongPositions       =15;
      MoneyMgmt.mm_MaxShortPositions      =15;
      
      GridMgmt.grid_GapSizePips           =20;
      GridMgmt.grid_EntryLevel            =500;
      //GridMgmt.grid_ScaleMode            =100;
      GridMgmt.grid_ScaleFactor           =2;
      GridMgmt.grid_ScaleStartLevel       =500;
      GridMgmt.grid_ScaleMode             =ALWAYS_SCALE;
      
   }else{
      OPStatus.GTM_Status = STOP;
      
      MoneyMgmt.mm_EntryType              =IMMEDIATE;
      MoneyMgmt.mm_TradeDirection         =HEDGE;
      MoneyMgmt.mm_EntryPrice             =fn_GetEntryPrice(MoneyMgmt.mm_TradeDirection,MoneyMgmt.mm_EntryType);
      MoneyMgmt.mm_LotSize                =0.01;
      MoneyMgmt.mm_SLPips                 =0;
      MoneyMgmt.mm_TPAmount               =1000;
      MoneyMgmt.mm_TPPips                 =0;
      MoneyMgmt.mm_MaxSpreadPips          =6;
      MoneyMgmt.mm_MinSpreadPips          =6;
      MoneyMgmt.mm_MaxLongPositions       =15;
      MoneyMgmt.mm_MaxShortPositions      =15;
      
      GridMgmt.grid_GapSizePips           =20;
      GridMgmt.grid_EntryLevel            =500;
      //GridMgmt.grid_ScaleMode            =100;
      GridMgmt.grid_ScaleFactor           =3;
      GridMgmt.grid_ScaleStartLevel       =500; 
      GridMgmt.grid_ScaleMode             =ALWAYS_SCALE;
   }
   
   //-- Common parameters
   MoneyMgmt.mm_LONG_SLPrice = 0;
   MoneyMgmt.mm_SHORT_SLPrice = 0;
   if(MoneyMgmt.mm_SLPips >0){
      MoneyMgmt.mm_LONG_SLPrice = MoneyMgmt.mm_EntryPrice - MoneyMgmt.mm_SLPips/AcctInfo.inf_Point;
      MoneyMgmt.mm_SHORT_SLPrice = MoneyMgmt.mm_EntryPrice + MoneyMgmt.mm_SLPips/AcctInfo.inf_Point;
   }
   
   MoneyMgmt.mm_LONG_TPPrice = 0;
   MoneyMgmt.mm_SHORT_TPPrice = 0;   
   if(MoneyMgmt.mm_TPPips >0){
      MoneyMgmt.mm_LONG_TPPrice = MoneyMgmt.mm_EntryPrice + MoneyMgmt.mm_TPPips/AcctInfo.inf_Point;
      MoneyMgmt.mm_SHORT_TPPrice = MoneyMgmt.mm_EntryPrice - MoneyMgmt.mm_TPPips/AcctInfo.inf_Point;
   }
   
   if(GRID_InitializeIndex() && GRID_InitializeScaleIndex())
      OPStatus.GRID_isInitialize = true;

   return(true);
}



//+------------------------------------------------------------------+
//| Function to refresh all operation structure parameters
//+------------------------------------------------------------------+
bool CProgram::OP_Refresh_Parameters(bool isInfToStruct)
{
   //---Refresh regardless of operational status
   AcctInfo.inf_CurSpreadPips = fn_GetPipsSpread();
   //--- use statistic functions to populate
   fn_GetRunningPL(AcctInfo.inf_RunningLongPL,AcctInfo.inf_RunningShortPL,AcctInfo.inf_MagicNumber);
   //AcctInfo.inf_RunningShortPL = 999;
   //AcctInfo.inf_RunningLongPL = 999;
   
   //AcctInfo.inf_AccumShortBalance = 999;
   //AcctInfo.inf_AccumLongBalance = 999;
   AcctInfo.inf_PruneBalance = (AcctInfo.inf_AccumShortBalance+AcctInfo.inf_AccumLongBalance)*0.5;
   
   //--- Update AcctInfo.inf_CurLongTickets and AcctInfo.inf_CurShortTickets
   CProgram::GTM_ManageTicket();
   
   //---Refresh Account information table   
   ACCT_UpdateStructureInterface();
   //---Refresh Money Management
   RISK_UpdateStructureInterface(isInfToStruct);
   //---Refresh GRID Management
   GRID_UpdateStructureInterface(isInfToStruct);      

   return(true);
}


//+------------------------------------------------------------------+
//| Function to START GTM
//+------------------------------------------------------------------+
bool CProgram::OP_GTM_START(void)
{
   //+++ Update information from Interface to Structure
   OPStatus.OP_isVariableRefreshed = OP_Refresh_Parameters(true);
   
   //--- GRID is not Active, this is fresh start
   GRID_Display(false);
   //---Re-initialize GRID and Display
   if(GRID_InitializeIndex() && GRID_InitializeScaleIndex()){
      OPStatus.GRID_isInitialize = true;
      GRID_Display(true);
   }    

   //---Refresh operation parameters
   if(OPStatus.OP_isVariableRefreshed && OPStatus.GRID_isInitialize){
      //---Disable all the buttons when GTM is running
      RISK_LockDown(true);
      GRID_LockDown(true);
      //---Set START status
      OPStatus.GTM_Status=START;
      fn_SendNotification(Symbol()+"--->GTM successfully started<----------",true,false,false);
   }else{ // If start failed, select Pause button and send notification
      m_CTRL_ButtonsGroup.SelectedRadioButton(1);   //Select pause button
      fn_SendNotification(Symbol()+"--->GTM Failed to start<----------Variables has not been refreshed",true,true,false);
      return(false);
   }
   
   return(true);   
}

//+------------------------------------------------------------------+
//| Function to PAUSE GTM
//+------------------------------------------------------------------+
bool CProgram::OP_GTM_PAUSE(void)
{
   OPStatus.GTM_Status = PAUSE;
   OPStatus.OP_isVariableRefreshed = false;
   //---Enable certain buttons
   RISK_LockDown(false);
   GRID_LockDown(false);
   //Select Pause button
   m_CTRL_ButtonsGroup.SelectedRadioButton(1);      
   fn_SendNotification(Symbol()+"--->GTM pause<----------",true,false,false); 
   
   return(true);
}


//+------------------------------------------------------------------+
//| Function to STOP GTM
//+------------------------------------------------------------------+
bool CProgram::OP_GTM_STOP(void)
{
   OPStatus.GTM_Status = STOP;
   OPStatus.OP_isVariableRefreshed = false;
   OPStatus.GTM_isActive = false;
   //---Enable all the buttons
   RISK_LockDown(false);
   GRID_LockDown(false);
   //Select STOP button
   m_CTRL_ButtonsGroup.SelectedRadioButton(2);      
   fn_SendNotification(Symbol()+"--->GTM successfully stopped<----------",true,false,false);
   return(true);   
}

//+------------------------------------------------------------------+
//| Function to get the current grid level, previous level, next level using price level
//+------------------------------------------------------------------+
GridItem CProgram::GTM_GetLevelByPrice(void)
{
   GridItem returnItem = {0};
   double curMidPrice = (SymbolInfoDouble(Symbol(),SYMBOL_ASK) + SymbolInfoDouble(Symbol(),SYMBOL_BID))/2;
   //double spreadPrice = MoneyMgmt.mm_MinSpreadPips * AcctInfo.inf_Point / 2;
   double spreadPrice = GridMgmt.grid_GapSizePips * AcctInfo.inf_Point / 2;
   
   //--- Locate the current Grid level by price
   for(int i=0;i<ArrayRange(GRID_ARRAY,0);i++){    
      if(curMidPrice <= GRID_ARRAY[i].item_curPrice + spreadPrice
         && curMidPrice >= GRID_ARRAY[i].item_curPrice - spreadPrice){
         returnItem = GRID_ARRAY[i];
         break;
      }
   }//---End for loop   
   
   return returnItem;
}

//+------------------------------------------------------------------+
//| Refresh Grid Management interface fields with struct GridManagementParameters
//+------------------------------------------------------------------+
bool CProgram::GRID_UpdateStructureInterface(bool isInfToStruct)
{  
   //---Update to Structure
   if(isInfToStruct){
      GridMgmt.grid_GapSizePips        = m_GRID_editGridSize.GetValue();
      GridMgmt.grid_EntryLevel         = m_GRID_editEntryLevel.GetValue();
      GridMgmt.grid_ScaleMode          = StringToEnum(m_GRID_comboScaleMode.ButtonText(),GridMgmt.grid_ScaleMode);
      GridMgmt.grid_ScaleFactor        = m_GRID_editScaleFactor.GetValue();
      GridMgmt.grid_ScaleStartLevel    = m_GRID_editScaleStartLevel.GetValue();   
   }else{ //---Update to Interface
      m_GRID_editGridSize.SetValue(GridMgmt.grid_GapSizePips);
      m_GRID_editEntryLevel.SetValue(GridMgmt.grid_EntryLevel);
      
      switch(GridMgmt.grid_ScaleMode)
      {
         case NO_SCALE:
            m_GRID_comboScaleMode.SelectedItemByIndex(0);
            break;
         case MANUAL_SCALE:
            m_GRID_comboScaleMode.SelectedItemByIndex(1);
            break; 
         case AUTO_SCALE:
            m_GRID_comboScaleMode.SelectedItemByIndex(2);
            break; 
         default:
            m_GRID_comboScaleMode.SelectedItemByIndex(3);
            break;
      }      
      m_GRID_editScaleFactor.SetValue(GridMgmt.grid_ScaleFactor);
      m_GRID_editScaleStartLevel.SetValue(GridMgmt.grid_ScaleStartLevel);
      
      m_GRID_Table.SetValue(1,1,DoubleToString(GridMgmt.grid_NextLongLevel,0) + " | " + DoubleToString(GridMgmt.grid_NextLongScaleLevel,0));
      m_GRID_Table.SetValue(1,2,DoubleToString(GridMgmt.grid_CurLongLevel,0));
      m_GRID_Table.SetValue(1,3,DoubleToString(GridMgmt.grid_PrevLongLevel,0) + " | " + DoubleToString(GridMgmt.grid_PrevLongScaleLevel,0));
   
      m_GRID_Table.SetValue(2,1,DoubleToString(GridMgmt.grid_NextShortLevel,0) + " | " + DoubleToString(GridMgmt.grid_NextShortScaleLevel,0));
      m_GRID_Table.SetValue(2,2,DoubleToString(GridMgmt.grid_CurShortLevel,0));
      m_GRID_Table.SetValue(2,3,DoubleToString(GridMgmt.grid_PrevShortLevel,0) + " | " + DoubleToString(GridMgmt.grid_PrevShortScaleLevel,0));
   }   

   //--- Update the table to display changes
   m_GRID_Table.UpdateTable();        

   return(true);
}

//+------------------------------------------------------------------+
//| Refresh Grid Management structures with GridItem information
//+------------------------------------------------------------------+
bool CProgram::GRID_RefreshIndexInformation(GridItem &curGridItem)
{        
      GridMgmt.grid_NextLongLevel = curGridItem.item_nextIndex;
      GridMgmt.grid_NextLongScaleLevel = curGridItem.item_nextScaleIndex;
      GridMgmt.grid_CurLongLevel = curGridItem.item_curIndex;
      GridMgmt.grid_PrevLongLevel = curGridItem.item_prevIndex;
      GridMgmt.grid_PrevLongScaleLevel = curGridItem.item_prevScaleIndex;
   
      GridMgmt.grid_NextShortLevel = curGridItem.item_prevIndex;
      GridMgmt.grid_NextShortScaleLevel = curGridItem.item_prevScaleIndex;
      GridMgmt.grid_CurShortLevel = curGridItem.item_curIndex;
      GridMgmt.grid_PrevShortLevel = curGridItem.item_nextIndex;
      GridMgmt.grid_PrevShortScaleLevel = curGridItem.item_nextScaleIndex;

   return(true);
}

//+------------------------------------------------------------------+
//| Function to initialize grid
//+------------------------------------------------------------------+
bool CProgram::GRID_InitializeIndex(void)
{
   
   // Initialize Grid Price
   for(int i=0; i < ArrayRange(GRID_ARRAY,0) ; i++){
      GRID_ARRAY[i].item_curPrice = MoneyMgmt.mm_EntryPrice + (i-GridMgmt.grid_EntryLevel)*GridMgmt.grid_GapSizePips*AcctInfo.inf_Point;
   }
   
   // Initialize Grid Next Price and Grid Previous Price
   GRID_ARRAY[0].item_curIndex = 0;
   GRID_ARRAY[0].item_prevPrice = 0;
   GRID_ARRAY[0].item_prevIndex = 0;
   GRID_ARRAY[0].item_nextPrice = GRID_ARRAY[1].item_curPrice;
   GRID_ARRAY[0].item_nextIndex = 1;
   GRID_ARRAY[0].item_Comment = "                              Level-0";
   
   GRID_ARRAY[1000].item_curIndex = 1000;
   GRID_ARRAY[1000].item_prevPrice = GRID_ARRAY[999].item_curPrice;
   GRID_ARRAY[1000].item_prevIndex = 999;
   GRID_ARRAY[1000].item_nextPrice = 0;
   GRID_ARRAY[1000].item_nextIndex = 1000;
   GRID_ARRAY[1000].item_Comment = "                              Level-1000";
   
   for(int i=1; i < ArrayRange(GRID_ARRAY,0)-1 ; i++){
      GRID_ARRAY[i].item_curIndex = i;
      GRID_ARRAY[i].item_prevPrice = GRID_ARRAY[i-1].item_curPrice;
      GRID_ARRAY[i].item_prevIndex = i-1;
      GRID_ARRAY[i].item_nextPrice = GRID_ARRAY[i+1].item_curPrice; 
      GRID_ARRAY[i].item_nextIndex = i+1;
      GRID_ARRAY[i].item_Comment = "                              Level-" + IntegerToString(i);
   }
   
   GRID_ARRAY[GridMgmt.grid_EntryLevel].item_Comment = "                              Grid Entry Level";
      
   return(true);       
}


//+------------------------------------------------------------------+
//| Function to refresh grid - used when changing scale level
//+------------------------------------------------------------------+
bool CProgram::GRID_InitializeScaleIndex(void)
{
   //--- Assume some input control has been done. 
   //--- Scale start level = 0 mean no scaling
   //--- Scale Factor = 0 means no scaling
   //--- Scale start level must >= Scale Factor
   
   int modValue = 0;
   
   if(GridMgmt.grid_ScaleStartLevel == 0 || GridMgmt.grid_ScaleStartLevel == 1000
      || GridMgmt.grid_ScaleFactor == 0 || GridMgmt.grid_ScaleFactor == 1000){
      Print(Symbol()+"-GRID scaling disable");
      return (true);
   }   
   
   //--- Scale index need to start from the scale level onward
   if(GridMgmt.grid_ScaleStartLevel < 0 
      || GridMgmt.grid_ScaleStartLevel >  ArrayRange(GRID_ARRAY,0)-1
      || GridMgmt.grid_ScaleStartLevel < GridMgmt.grid_ScaleFactor
      ){
      return (false);
   }
          
   //--- Initialize Scale index
   for (int i=0; i<ArrayRange(GRID_ARRAY,0); i++){
      modValue = (int)MathMod(GridMgmt.grid_ScaleStartLevel-i,GridMgmt.grid_ScaleFactor);
      
      //---Set to 0 if it is at the end of GRID_ARRAY
      if(i<GridMgmt.grid_ScaleFactor || i>(ArrayRange(GRID_ARRAY,0)-GridMgmt.grid_ScaleFactor-1)){
         GRID_ARRAY[i].item_nextScaleIndex = 0;
         GRID_ARRAY[i].item_nextScalePrice = 0;
         
         GRID_ARRAY[i].item_curScaleIndex = 0;
         GRID_ARRAY[i].item_curScalePrice = 0;
      
         GRID_ARRAY[i].item_prevScaleIndex = 0;
         GRID_ARRAY[i].item_prevScalePrice = 0;
      //---In the middle of GRID_ARRAY
      }else{
         //--- If modulo (Scale Start Level - i) against Scale Factor is 0 then this is the scale level
         if(modValue == 0){
            GRID_ARRAY[i].item_nextScaleIndex = i+GridMgmt.grid_ScaleFactor;
            GRID_ARRAY[i].item_nextScalePrice = GRID_ARRAY[i+GridMgmt.grid_ScaleFactor].item_curPrice;

            GRID_ARRAY[i].item_curScaleIndex = i;
            GRID_ARRAY[i].item_curScalePrice = GRID_ARRAY[i].item_curPrice;
         
            GRID_ARRAY[i].item_prevScaleIndex = i-GridMgmt.grid_ScaleFactor;
            GRID_ARRAY[i].item_prevScalePrice = GRID_ARRAY[i-GridMgmt.grid_ScaleFactor].item_curPrice;

            GRID_ARRAY[i].item_Comment += "-Scale";
            
         }else{
            //--- If Above scale start level, set currentScaleIndex to nextScaleIndex
            if(i > GridMgmt.grid_ScaleStartLevel){
               GRID_ARRAY[i].item_nextScaleIndex = i+modValue;
               GRID_ARRAY[i].item_nextScalePrice = GRID_ARRAY[i+modValue].item_curPrice;
            
               GRID_ARRAY[i].item_curScaleIndex = i+modValue;
               GRID_ARRAY[i].item_curScalePrice = GRID_ARRAY[i+modValue].item_prevScalePrice;
               
               GRID_ARRAY[i].item_prevScaleIndex = i-(GridMgmt.grid_ScaleFactor-modValue);
               GRID_ARRAY[i].item_prevScalePrice = GRID_ARRAY[i-(GridMgmt.grid_ScaleFactor-modValue)].item_curPrice;            
            //--- If Below scale start level, currentScaleIndex to previousScaleIndex
            }else{
               GRID_ARRAY[i].item_nextScaleIndex = i+modValue;
               GRID_ARRAY[i].item_nextScalePrice = GRID_ARRAY[i+modValue].item_curPrice;
            
               GRID_ARRAY[i].item_curScaleIndex = i-(GridMgmt.grid_ScaleFactor-modValue);
               GRID_ARRAY[i].item_curScalePrice = GRID_ARRAY[i-(GridMgmt.grid_ScaleFactor-modValue)].item_prevScalePrice;
               
               GRID_ARRAY[i].item_prevScaleIndex = i-(GridMgmt.grid_ScaleFactor-modValue);
               GRID_ARRAY[i].item_prevScalePrice = GRID_ARRAY[i-(GridMgmt.grid_ScaleFactor-modValue)].item_curPrice;
            }//--End if   
         }//--End if Mod
      }//---End if initialize scale
   }//--- End for loop
    
   return(true);       
}

//+------------------------------------------------------------------+
//| Function to Show grid
//+------------------------------------------------------------------+
bool CProgram::GRID_Display(bool show)
{  
   if(show){
      for(int i=0;i<ArrayRange(GRID_ARRAY,0);i++){
         if(i==GridMgmt.grid_EntryLevel){
            m_GRID_Gridline.Create(0,"Entry",0,GRID_ARRAY[i].item_curPrice);
            m_GRID_Gridline.Description(GRID_ARRAY[i].item_Comment);
            m_GRID_Gridline.Color(clrBlue);
         }else if(i==GridMgmt.grid_ScaleStartLevel){
            m_GRID_Gridline.Create(0,"Scale Start",0,GRID_ARRAY[i].item_curPrice);
            m_GRID_Gridline.Description(GRID_ARRAY[i].item_Comment + "-Current Scale Level");
            m_GRID_Gridline.Color(clrAquamarine);
         }else{
            m_GRID_Gridline.Create(0,"Level "+ (string)i,0,GRID_ARRAY[i].item_curPrice);
            m_GRID_Gridline.Description(GRID_ARRAY[i].item_Comment);
         }

         m_GRID_Gridline.Width(1);
         m_GRID_Gridline.Style(STYLE_DASH);
         m_GRID_Gridline.Background(true);
            
         if(i!=GridMgmt.grid_EntryLevel && i!=GridMgmt.grid_ScaleStartLevel){      
            m_GRID_Gridline.Color(clrDarkSlateGray);
         }
      }
   }else{
      fn_RemoveObjects("Level");
      fn_RemoveObjects("Entry");
      fn_RemoveObjects("Scale");
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
   string entryTypeList[comboItems]={"IMMEDIATE","PENDING"};
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
   m_RISK_comboEntryType.LabelColorHover(clrBlack);
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
   
   switch(MoneyMgmt.mm_EntryType)
   {
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

   double eValue = MoneyMgmt.mm_EntryPrice;

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
   switch(MoneyMgmt.mm_TradeDirection)
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

   double eValue = (MoneyMgmt.mm_LotSize < 0) ? 0.01 : MoneyMgmt.mm_LotSize;

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

   double eValue = (MoneyMgmt.mm_SLPips < 0) ? 0 : MoneyMgmt.mm_SLPips;

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

   double eValue = (MoneyMgmt.mm_TPPips < 0) ? 0 : MoneyMgmt.mm_TPPips;

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

   double eValue = (MoneyMgmt.mm_TPAmount < 0) ? 1000 : MoneyMgmt.mm_TPAmount;

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

   double eValue = (MoneyMgmt.mm_MinSpreadPips < 6) ? 6 : MoneyMgmt.mm_MinSpreadPips;

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

   double eValue = (MoneyMgmt.mm_MaxSpreadPips < 6) ? 6 : MoneyMgmt.mm_MaxSpreadPips;

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

   double eValue = (MoneyMgmt.mm_MaxLongPositions < 0) ? 0 : MoneyMgmt.mm_MaxLongPositions;

   //--- Set properties before creation
   m_RISK_editMaxLongPos.XSize(200);
   m_RISK_editMaxLongPos.YSize(18);
   m_RISK_editMaxLongPos.EditXSize(76);
   m_RISK_editMaxLongPos.MaxValue(100000);
   m_RISK_editMaxLongPos.MinValue(0);
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

   double eValue = (MoneyMgmt.mm_MaxShortPositions < 0) ? 0 : MoneyMgmt.mm_MaxShortPositions;

   //--- Set properties before creation
   m_RISK_editMaxShortPos.XSize(200);
   m_RISK_editMaxShortPos.YSize(18);
   m_RISK_editMaxShortPos.EditXSize(76);
   m_RISK_editMaxShortPos.MaxValue(100000);
   m_RISK_editMaxShortPos.MinValue(0);
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
   //--- Update to Structure
   if(isInfToStruct){
      MoneyMgmt.mm_EntryType = StringToEnum(m_RISK_comboEntryType.ButtonText(),MoneyMgmt.mm_EntryType);
      MoneyMgmt.mm_TradeDirection = StringToEnum(m_RISK_comboDirection.ButtonText(),MoneyMgmt.mm_TradeDirection);
      
      if(OPStatus.GTM_isActive == false){
         if(MoneyMgmt.mm_EntryType==IMMEDIATE)
            MoneyMgmt.mm_EntryPrice = fn_GetEntryPrice(MoneyMgmt.mm_TradeDirection,MoneyMgmt.mm_EntryType); 
         else   
            MoneyMgmt.mm_EntryPrice = m_RISK_editEntryprice.GetValue();   
      }   
               
      MoneyMgmt.mm_LotSize = m_RISK_editLotSize.GetValue();
      MoneyMgmt.mm_SLPips = m_RISK_editSLPips.GetValue();
      MoneyMgmt.mm_TPPips = m_RISK_editTPPips.GetValue();
      MoneyMgmt.mm_TPAmount = m_RISK_editTPAmount.GetValue();
      MoneyMgmt.mm_MinSpreadPips = m_RISK_editMinSpreadPips.GetValue();
      MoneyMgmt.mm_MaxSpreadPips = m_RISK_editMaxSpreadPips.GetValue();
      MoneyMgmt.mm_MaxLongPositions = m_RISK_editMaxLongPos.GetValue();
      MoneyMgmt.mm_MaxShortPositions = m_RISK_editMaxShortPos.GetValue();
   }else{ //--- Update to interface
      m_RISK_comboEntryType.SelectedItemByIndex(MoneyMgmt.mm_EntryType);
      
      switch(MoneyMgmt.mm_TradeDirection)
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
 
      m_RISK_editEntryprice.SetValue(MoneyMgmt.mm_EntryPrice);
      m_RISK_editLotSize.SetValue(MoneyMgmt.mm_LotSize);
      m_RISK_editSLPips.SetValue(MoneyMgmt.mm_SLPips);
      m_RISK_editTPPips.SetValue(MoneyMgmt.mm_TPPips);
      m_RISK_editTPAmount.SetValue(MoneyMgmt.mm_TPAmount);
      m_RISK_editMinSpreadPips.SetValue(MoneyMgmt.mm_MinSpreadPips);
      m_RISK_editMaxSpreadPips.SetValue(MoneyMgmt.mm_MaxSpreadPips);
      m_RISK_editMaxLongPos.SetValue(MoneyMgmt.mm_MaxLongPositions);
      m_RISK_editMaxShortPos.SetValue(MoneyMgmt.mm_MaxShortPositions);
   }
   
   return(true);
}

//+------------------------------------------------------------------+
//| Function to Enable/Disable Configuration function
//+------------------------------------------------------------------+
bool CProgram::RISK_LockDown(bool lockStatus)
{
   //---If PAUSE then lock/unlock certain features
   if(OPStatus.GTM_Status==PAUSE){
      m_RISK_editLotSize.SpinEditState(!lockStatus);
      m_RISK_editSLPips.SpinEditState(!lockStatus);
      m_RISK_editTPPips.SpinEditState(!lockStatus);
      m_RISK_editTPAmount.SpinEditState(!lockStatus);
      m_RISK_editMinSpreadPips.SpinEditState(!lockStatus);
      m_RISK_editMaxSpreadPips.SpinEditState(!lockStatus);
      m_RISK_editMaxLongPos.SpinEditState(!lockStatus);
      m_RISK_editMaxShortPos.SpinEditState(!lockStatus);
   }else{
      m_RISK_comboEntryType.ComboBoxState(!lockStatus);
      m_RISK_comboDirection.ComboBoxState(!lockStatus);
      m_RISK_editEntryprice.SpinEditState(!lockStatus);
      m_RISK_editLotSize.SpinEditState(!lockStatus);
      m_RISK_editSLPips.SpinEditState(!lockStatus);   
      m_RISK_editTPPips.SpinEditState(!lockStatus);
      m_RISK_editTPAmount.SpinEditState(!lockStatus);
      m_RISK_editMinSpreadPips.SpinEditState(!lockStatus);
      m_RISK_editMaxSpreadPips.SpinEditState(!lockStatus);
      m_RISK_editMaxLongPos.SpinEditState(!lockStatus);
      m_RISK_editMaxShortPos.SpinEditState(!lockStatus);
   }
   
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
   int x=m_window1.X()+GRID_TABLE_GAP_X;
   int y=m_window1.Y()+GRID_TABLE_GAP_Y;

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

   m_GRID_Table.SetValue(1,1,DoubleToString(GridMgmt.grid_NextLongLevel,0) + " | " + DoubleToString(GridMgmt.grid_NextLongScaleLevel,0));
   m_GRID_Table.SetValue(1,2,DoubleToString(GridMgmt.grid_CurLongLevel,0));
   m_GRID_Table.SetValue(1,3,DoubleToString(GridMgmt.grid_PrevLongLevel,0) + " | " + DoubleToString(GridMgmt.grid_PrevLongScaleLevel,0));

   m_GRID_Table.SetValue(2,1,DoubleToString(GridMgmt.grid_NextShortLevel,0) + " | " + DoubleToString(GridMgmt.grid_NextShortScaleLevel,0));
   m_GRID_Table.SetValue(2,2,DoubleToString(GridMgmt.grid_CurShortLevel,0));
   m_GRID_Table.SetValue(2,3,DoubleToString(GridMgmt.grid_PrevShortLevel,0) + " | " + DoubleToString(GridMgmt.grid_PrevShortScaleLevel,0));
   
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

   double eValue = (GridMgmt.grid_GapSizePips < 10 ) ? 10: GridMgmt.grid_GapSizePips;

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

   double eValue = (GridMgmt.grid_EntryLevel >= 50 || GridMgmt.grid_EntryLevel <= 950) ? GridMgmt.grid_EntryLevel : 500;

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
bool CProgram::GRID_CreateScaleMode(const string text)
{
   #define comboItems 4
   string entryTypeList[comboItems]={"NO_SCALE","MANUAL_SCALE","AUTO_SCALE","ALWAYS_SCALE"};

   //--- Store the window pointer
   m_GRID_comboScaleMode.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_comboScaleMode);      
   
   //--- Coordinates
   int x=m_window1.X()+GRID_SE_RESETDISTANCE_GAP_X;
   int y=m_window1.Y()+GRID_SE_RESETDISTANCE_GAP_Y;
      
   //--- Set properties before creation
   m_GRID_comboScaleMode.XSize(200);
   m_GRID_comboScaleMode.YSize(18);
   m_GRID_comboScaleMode.LabelText(text);
   m_GRID_comboScaleMode.ButtonXSize(100);
   m_GRID_comboScaleMode.AreaColor(clrWhiteSmoke);
   m_GRID_comboScaleMode.LabelColor(clrBlack);
   m_GRID_comboScaleMode.LabelColorHover(clrBlack);
   m_GRID_comboScaleMode.ButtonBackColor(C'206,206,206');
   m_GRID_comboScaleMode.ButtonBackColorHover(C'193,218,255');
   m_GRID_comboScaleMode.ButtonBorderColor(C'150,170,180');
   m_GRID_comboScaleMode.ButtonBorderColorOff(C'178,195,207');
   m_GRID_comboScaleMode.ItemsTotal(comboItems);
   m_GRID_comboScaleMode.VisibleItemsTotal(comboItems);

   //--- Store the item values to the combo box list
   for(int i=0; i<comboItems; i++)
      m_GRID_comboScaleMode.ValueToList(i,entryTypeList[i]);

   //--- Get the list pointer
   CListView *lv=m_GRID_comboScaleMode.GetListViewPointer();
   //--- Set the list properties
   lv.LightsHover(true);

   switch(GridMgmt.grid_ScaleMode)
   {
   case  NO_SCALE: lv.SelectedItemByIndex(0); //No Scale
     break;
   case  MANUAL_SCALE: lv.SelectedItemByIndex(1); //Manual Scale
     break;
   case  AUTO_SCALE: lv.SelectedItemByIndex(2); //Auto Scale
     break;     
   default: lv.SelectedItemByIndex(3); //Always Scale
     break;
   }

   //--- Create a control
   if(!m_GRID_comboScaleMode.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
         
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_comboScaleMode);

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

   double eValue = (GridMgmt.grid_ScaleFactor < 0 ) ? 2: GridMgmt.grid_ScaleFactor;

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
bool CProgram::GRID_CreateScaleStartLevel(const string text)
{
   //--- Store the window pointer
   m_GRID_editScaleStartLevel.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(GRID_TabIndex,m_GRID_editScaleStartLevel);      
   
   //--- Coordinates
   int x=m_window1.X()+GRID_SE_SCALESTARTLEVEL_GAP_X;
   int y=m_window1.Y()+GRID_SE_SCALESTARTLEVEL_GAP_Y;
   //--- Value

   double eValue = (GridMgmt.grid_ScaleStartLevel < 0 ) ? 100 : GridMgmt.grid_ScaleStartLevel;

   //--- Set properties before creation
   m_GRID_editScaleStartLevel.XSize(200);
   m_GRID_editScaleStartLevel.YSize(18);
   m_GRID_editScaleStartLevel.EditXSize(76);
   m_GRID_editScaleStartLevel.MaxValue(900);
   m_GRID_editScaleStartLevel.MinValue(100);
   m_GRID_editScaleStartLevel.StepValue(1);
   m_GRID_editScaleStartLevel.SetDigits(0);
   m_GRID_editScaleStartLevel.SetValue(eValue);
   m_GRID_editScaleStartLevel.ResetMode(true);
   m_GRID_editScaleStartLevel.AreaColor(clrWhiteSmoke);
   m_GRID_editScaleStartLevel.LabelColor(clrBlack);
   m_GRID_editScaleStartLevel.LabelColorLocked(clrSilver);
   m_GRID_editScaleStartLevel.EditColorLocked(clrWhiteSmoke);
   m_GRID_editScaleStartLevel.EditTextColor(clrBlack);
   m_GRID_editScaleStartLevel.EditTextColorLocked(clrSilver);
   m_GRID_editScaleStartLevel.EditBorderColor(clrSilver);
   m_GRID_editScaleStartLevel.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GRID_editScaleStartLevel.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GRID_editScaleStartLevel);

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
   if(OPStatus.GTM_Status==PAUSE){
      m_GRID_editGridSize.SpinEditState(!lockStatus);
      m_GRID_comboScaleMode.ComboBoxState(!lockStatus);
      m_GRID_editScaleFactor.SpinEditState(!lockStatus);
      m_GRID_editScaleStartLevel.SpinEditState(!lockStatus); 
      m_GRID_buttonApply.ButtonState(!lockStatus);
   }else{
      m_GRID_editGridSize.SpinEditState(!lockStatus);
      m_GRID_editEntryLevel.SpinEditState(!lockStatus);
      m_GRID_comboScaleMode.ComboBoxState(!lockStatus);
      m_GRID_editScaleFactor.SpinEditState(!lockStatus);
      m_GRID_editScaleStartLevel.SpinEditState(!lockStatus);
      m_GRID_buttonApply.ButtonState(!lockStatus);  
   }
   
   return(true);
}



//+------------------------------------------------------------------------------------------------------------------------------------+
//| Account tab
//+------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create Account table 1
//+------------------------------------------------------------------+
bool CProgram::Account_CreateTable1()
{
   //--- Store pointer to the form
   m_AccountTable1.WindowPointer(m_window1);

   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(CTRL_TabIndex,m_AccountTable1);

   //--- Coordinates
   int x=m_window1.X()+ACCT_TABLE1_GAP_X;
   int y=m_window1.Y()+ACCT_TABLE1_GAP_Y;

   //--- Set properties before creation
   m_AccountTable1.XSize(280);  //594
   m_AccountTable1.RowYSize(18);
   m_AccountTable1.FixFirstRow(true);
   m_AccountTable1.FixFirstColumn(true);
   m_AccountTable1.LightsHover(true);
   m_AccountTable1.SelectableRow(true);
   m_AccountTable1.ReadOnly(true);
   m_AccountTable1.TextAlign(ALIGN_CENTER);
   m_AccountTable1.HeadersColor(C'255,244,213');
   m_AccountTable1.HeadersTextColor(clrBlack);
   m_AccountTable1.GridColor(clrLightGray);
   m_AccountTable1.CellColorHover(clrGold);
   m_AccountTable1.TableSize(ACCT_TableColumns,ACCT_TableRows);
   m_AccountTable1.VisibleTableSize(ACCT_TableColumns,ACCT_TableRows);

   //--- Create control
   if(!m_AccountTable1.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);


   string itemList[] = {"Item","Value"};
   
   for(int col=0; col<=1; col++){
      for(int row=0; row<1; row++){
         m_AccountTable1.SetValue(col,row, itemList[col]);
         m_AccountTable1.TextAlign(col,row,ALIGN_CENTER);
      }
   }
   
   string itemList2[][2] = {{"Magic Number",0}
                           ,{"Currency Pair",0}
                           ,{"------SHORT Information------","----------------------------"}
                           ,{"Open Deals",0}
                           ,{"Running PL",0}
                           ,{"Accum PL",0}};
   for(int col=0; col<=1; col++){
      for(int row=1; row<ACCT_TableRows; row++){
         m_AccountTable1.SetValue(col,row, itemList2[row-1][col]);
         m_AccountTable1.TextAlign(col,row,ALIGN_RIGHT);
      }
   }   
     
   m_AccountTable1.CellColor(0,3,clrWhiteSmoke);
   m_AccountTable1.CellColor(1,3,clrWhiteSmoke);
   
   m_AccountTable1.SetValue(1,1,DoubleToString(AcctInfo.inf_MagicNumber,0));
   m_AccountTable1.SetValue(1,2,AcctInfo.inf_CurrencyPair);
   m_AccountTable1.SetValue(1,4,DoubleToString(AcctInfo.inf_CurShortTickets,0));
   m_AccountTable1.SetValue(1,5,DoubleToString(AcctInfo.inf_RunningShortPL,2));
   m_AccountTable1.SetValue(1,6,DoubleToString(AcctInfo.inf_AccumShortBalance,2));
   
   //--- Update the table to display changes
   m_AccountTable1.UpdateTable();

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_AccountTable1);
   return(true);
}

//+------------------------------------------------------------------+
//| Create Account table 2
//+------------------------------------------------------------------+
bool CProgram::Account_CreateTable2()
{
   //--- Store pointer to the form
   m_AccountTable2.WindowPointer(m_window1);

   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(CTRL_TabIndex,m_AccountTable2);

   //--- Coordinates
   int x=m_window1.X()+ACCT_TABLE2_GAP_X;
   int y=m_window1.Y()+ACCT_TABLE2_GAP_Y;

   //--- Set properties before creation
   m_AccountTable2.XSize(280);  //594
   m_AccountTable2.RowYSize(18);
   m_AccountTable2.FixFirstRow(true);
   m_AccountTable2.FixFirstColumn(true);
   m_AccountTable2.LightsHover(true);
   m_AccountTable2.SelectableRow(true);
   m_AccountTable2.ReadOnly(true);
   m_AccountTable2.TextAlign(ALIGN_CENTER);
   m_AccountTable2.HeadersColor(C'255,244,213');
   m_AccountTable2.HeadersTextColor(clrBlack);
   m_AccountTable2.GridColor(clrLightGray);
   m_AccountTable2.CellColorHover(clrGold);
   m_AccountTable2.TableSize(ACCT_TableColumns,ACCT_TableRows);
   m_AccountTable2.VisibleTableSize(ACCT_TableColumns,ACCT_TableRows);

   //--- Create control
   if(!m_AccountTable2.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);

   string itemList[] = {"Item","Value"};
   
   for(int col=0; col<=1; col++){
      for(int row=0; row<1; row++){
         m_AccountTable2.SetValue(col,row, itemList[col]);
         m_AccountTable2.TextAlign(col,row,ALIGN_CENTER);
      }
   }
   
   string itemList2[][2] = {{"Spread (Pips)",0}
                           ,{"Prune Balance",0}
                           ,{"------LONG Information------","---------------------------"}
                           ,{"Open Deals",0}
                           ,{"Running PL",0}
                           ,{"Accum PL",0}};
   for(int col=0; col<=1; col++){
      for(int row=1; row<ACCT_TableRows; row++){
         m_AccountTable2.SetValue(col,row, itemList2[row-1][col]);
         m_AccountTable2.TextAlign(col,row,ALIGN_RIGHT);
      }
   }   
     
   m_AccountTable2.CellColor(0,3,clrWhiteSmoke);
   m_AccountTable2.CellColor(1,3,clrWhiteSmoke);
   
   m_AccountTable2.SetValue(1,1,DoubleToString(AcctInfo.inf_CurSpreadPips,0));
   m_AccountTable2.SetValue(1,2,DoubleToString(AcctInfo.inf_PruneBalance,2));
   m_AccountTable2.SetValue(1,4,DoubleToString(AcctInfo.inf_CurLongTickets,0));
   m_AccountTable2.SetValue(1,5,DoubleToString(AcctInfo.inf_RunningLongPL,2));
   m_AccountTable2.SetValue(1,6,DoubleToString(AcctInfo.inf_AccumLongBalance,2));

   //--- Update the table to display changes
   m_AccountTable2.UpdateTable();

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_AccountTable2);
   return(true);
}

//+------------------------------------------------------------------+
//| Update structure information to interface
//+------------------------------------------------------------------+
bool CProgram::ACCT_UpdateStructureInterface()
{  

   m_AccountTable1.SetValue(1,1,DoubleToString(AcctInfo.inf_MagicNumber,0));
   m_AccountTable1.SetValue(1,2,AcctInfo.inf_CurrencyPair);
   m_AccountTable1.SetValue(1,4,DoubleToString(AcctInfo.inf_CurShortTickets,0) + " / " + DoubleToString(MoneyMgmt.mm_MaxShortPositions,0));
   m_AccountTable1.SetValue(1,5,DoubleToString(AcctInfo.inf_RunningShortPL,2));
   m_AccountTable1.SetValue(1,6,DoubleToString(AcctInfo.inf_AccumShortBalance,2));
   
   m_AccountTable2.SetValue(1,1,DoubleToString(AcctInfo.inf_CurSpreadPips,0));
   m_AccountTable2.SetValue(1,2,DoubleToString(AcctInfo.inf_PruneBalance,2));
   m_AccountTable2.SetValue(1,4,DoubleToString(AcctInfo.inf_CurLongTickets,0) + " / " + DoubleToString(MoneyMgmt.mm_MaxLongPositions,0));
   m_AccountTable2.SetValue(1,5,DoubleToString(AcctInfo.inf_RunningLongPL,2));
   m_AccountTable2.SetValue(1,6,DoubleToString(AcctInfo.inf_AccumLongBalance,2));
   
   //--- Update the table to display changes
   m_AccountTable1.UpdateTable();
   m_AccountTable2.UpdateTable();

   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+
//| Control tab
//+------------------------------------------------------------------------------------------------------------------------------------+

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
bool CProgram::CTRL_CreateButtonsGroup(void)
{
   //--- Store the window pointer
   m_CTRL_ButtonsGroup.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(CTRL_TabIndex,m_CTRL_ButtonsGroup);     
   
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
   m_CTRL_ButtonsGroup.ButtonsYSize(85);
   m_CTRL_ButtonsGroup.IconXGap(14);
   m_CTRL_ButtonsGroup.IconYGap(5);
   m_CTRL_ButtonsGroup.LabelXGap(15);
   m_CTRL_ButtonsGroup.LabelYGap(69);
   m_CTRL_ButtonsGroup.BackColor(clrLightGray);
   m_CTRL_ButtonsGroup.BackColorHover(C'193,218,255');
   m_CTRL_ButtonsGroup.BackColorPressed(C'190,190,200');
   m_CTRL_ButtonsGroup.BorderColor(C'150,170,180');
   m_CTRL_ButtonsGroup.BorderColorOff(C'178,195,207');

   //--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_CTRL_ButtonsGroup.AddButton(buttons_x_gap[i],buttons_y_gap[i],buttons_text[i],buttons_width[i],items_bmp_on[i],items_bmp_off[i]);

   //--- Create a group of buttons
   if(!m_CTRL_ButtonsGroup.CreateIconButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Select the STOP button and set the default status is STOP
   m_CTRL_ButtonsGroup.SelectedRadioButton(2);
   OPStatus.GTM_Status = STOP;

   //--- Lock the group of buttons
   //m_CTRL_ButtonsGroup.IconButtonsState(false);

   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_CTRL_ButtonsGroup);
   
   return(true);
}

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