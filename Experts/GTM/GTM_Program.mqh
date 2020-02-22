//+------------------------------------------------------------------+
//|                                                  GTM_Program.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Khoa Nguyen"
#property version   "1.12"
#property description   "/nv1.12 Fix bugs at 1.3 where order is placed very close to the TP price"
                        "/nv1.11 Fix bugs at GTM_GetIndexByPriceLevel and enable notification when encountering price gap once every new bar"
                        "/nv1.10 When resume from pause, check current price against lowest grid level then find corresponding level. Setting StopLoss when Op_Refresh_Variables"
                        "/nv1.00 Original version"

#include <EasyAndFastGUI\Controls\WndEvents.mqh>
#include <ChartObjects\ChartObjectsLines.mqh>

enum ORDER_TYPE
{
   BUY_ORDER=1,
   SELL_ORDER=-1,
   NO_ORDER=0,
};

enum TRADE_DIRECTION 
{
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

#import "KhoaLibrary.ex4"

//---Environments Funtions
double   fn_SetMyPoint();
bool     fn_GetMarketInfo(double &marketInfo[],double lotSize);
bool     fn_IsNewCandle();
int      fn_GenerateMagicNumber(int trial);
string   fn_IsConnectedToBroker();
string   fn_RemainingTime();
bool     fn_RemoveObjects(string objName);
bool     fn_SendNotification(string myText,bool printLog,bool sendAlert,bool sendPushNotification);

//Funtions support GTM
int      fn_GetRunningProfitLossPip(int magicNumber,double myPoint);
int      fn_GetOrderProfitLossPip(int ticket,double myPoint);
int      fn_GetOpenOrders(int magicNumber);
bool     fn_IsOrderOpened(int ticketNumber,int magicNumber);
int      fn_IsPendingStop(double priceLevel,int direction);
int      fn_IsPendingLimit(double priceLevel,int direction);
int      fn_OrderEntry_1(ORDER_TYPE orderDirection,double orderSize,double orderSLPrice,double orderTPPrice,string orderComment,int orderMagicNum);
void     fn_CloseAllOrders(int magicNumber);
double   fn_GetEntryPrice(double price, TRADE_DIRECTION tradeDirection, ENTRY_TYPE entryType);

#import


//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
{
   //---Class Declaration   
   private:
      //--- Form 1
      CWindow           m_window1;
      //--- Main menu and its context menus
      CMenuBar          m_menubar;
      //--- Status bar
      CStatusBar        m_status_bar;
      //--- Tabs
      CTabs             m_tabs;
      //--- Configurations tab
      CTable            m_ConfigTable;
      CSimpleButton     m_Config_ApplyButton;
      CIconButtonsGroup m_Config_ButtonsGroup;
      //--- Account information tab
      CTable            m_AccountTable;
      //--- GTM tab
      CTable            m_GtmTable;
      CSpinEdit         m_GTM_editGridSize;
      CSpinEdit         m_GTM_editGridEntry;
      CSpinEdit         m_GTM_editGridReset;
      CCheckBox         m_GTM_checkGridDisplay;      
      CChartObjectHLine m_GTM_Gridline;
      CCheckBox         m_GTM_checkTrendScaling;
      CSpinEdit         m_GTM_editScaleFactor;
      CSpinEdit         m_GTM_editScaleLevel;      
      CSimpleButton     m_GTM_buttonApply;
      
      //--- Control tab
      CSeparateLine     m_Control_sepline;
      CCheckBox         m_Control_checkboxAskLine;
      CComboBox         m_Control_comboEntryType;
      CComboBox         m_Control_comboDirection;
      CSpinEdit         m_Control_editEntryprice;
      CSpinEdit         m_Control_editLotSize;      
      
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
      bool              CreateExpertPanel(string panelName, string &srcConfigTable[][]);
      
   protected:
      //--- Chart event handler
      virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
      
   private:
      //--- Form 1
      bool              CreateWindow1(const string text);
      //--- Main menu and its context menus
      #define MENUBAR_GAP_X         (1)
      #define MENUBAR_GAP_Y         (20)
      bool              CreateMenuBar(void);
      //--- Status bar
      #define STATUSBAR1_GAP_X      (1)
      #define STATUSBAR1_GAP_Y      (290)
      bool              CreateStatusBar(void);
      //--- Tabs
      #define TABS1_GAP_X           (4)
      #define TABS1_GAP_Y           (45)
      bool              CreateTabs(void);

      #define TABLE2_GAP_X          (5)
      #define TABLE2_GAP_Y          (65)      
      #define VISIBLE_COLUMNS       (2)
      #define VISIBLE_ROWS          (12)
      #define TABLE_COLUMNS         (2)

      //+------------------------------------------------------------------+
      //| Operational functions
      //+------------------------------------------------------------------+
      bool              Op_Init_Variables(string &configItems[][]);
      bool              Op_Refresh_Variables(void);
      bool              Op_Initialize_Grid(void);
      bool              Op_GTM_START(void);
      bool              Op_GTM_PAUSE(void);
      bool              Op_GTM_STOP(void);
      //bool              Op_Refresh_Account_Variables(void); //Not use
      bool              isGridInitialize;
      bool              isVariablesRefreshed;

      //+------------------------------------------------------------------+
      //| Configurations tab
      //+------------------------------------------------------------------+
      bool              Config_CreateTable();
      #define BUTTON1_GAP_X            (450)
      #define BUTTON1_GAP_Y            (100)
      bool              Config_CreateApplyButton(const string text);
      bool              Config_RefreshTable();
      bool              Config_LockDown(bool lockStatus);
      int               table_Config_Rows;
      string            ConfigTable[][TABLE_COLUMNS];      
      double            conf_SL_MinPips;
      int               conf_SL_StealthPips;
      double            conf_TP_Amount;
      double            conf_TP_Price;      
      int               ticket_Max_Open;
      double            ticket_Max_Spreads;

      //+------------------------------------------------------------------+
      //| Account tab
      //+------------------------------------------------------------------+
      bool              Account_CreateTable();
      bool              Account_RefreshTable();

      int               table_Account_Rows;
      string            AccountTable[][TABLE_COLUMNS];      

      double            acct_MyPoint;                      //Broker digit point
      int               acct_MagicNumber;                  //Magic Number for this sequence
      double            acct_MarketInfo[3];                //Array contains: pipValue | spread[pips] | SL[pips]
      double            acct_pipValue;                     //Value of a microlot pip
      double            acct_spreadPips;                   //Spread value in pips
      double            acct_spreadPrice;                  //Spread value in price
      double            acct_minSLPips;                    //Minimum Stoploss in pips      
      double            acct_minDistancePrice;             //Max distance to TP price
      
      //+------------------------------------------------------------------+
      //| GTM information tab
      //+------------------------------------------------------------------+
      bool              GTM_CreateTable();
      bool              GTM_RefreshTable();
      bool              GTM_LockDown(bool lockStatus);
      int               table_Gtm_Rows;
      string            GtmTable[][TABLE_COLUMNS];            

      #define GTM_SPINEDIT1_GAP_X     (420)
      #define GTM_SPINEDIT1_GAP_Y     (75)
      bool              GTM_CreateGridSize(const string text);                //Field to enter Grid size
      int               grid_Size;                                            //Grid Gap Size
      #define GTM_SPINEDIT2_GAP_X     (420)
      #define GTM_SPINEDIT2_GAP_Y     (100)
      bool              GTM_CreateGridEntry(const string text);               //Field to enter Grid entry level
      int               grid_entryIndex;                                      //Grid Entry Level = Stop Loss Level  
      #define GTM_SPINEDIT5_GAP_X     (420)
      #define GTM_SPINEDIT5_GAP_Y     (125)
      bool              GTM_CreateResetLevel(const string text);               //Grid reset level  
      int               grid_Reset_Level;
      #define GTM_CHECKBOX2_GAP_X     (420)
      #define GTM_CHECKBOX2_GAP_Y     (150)
      bool              GTM_CreateTrendScaling(const string text);            //Enable Counter Trend Scaling
      bool              grid_Scale_Enable;
      #define GTM_SPINEDIT3_GAP_X     (420)
      #define GTM_SPINEDIT3_GAP_Y     (175)
      bool              GTM_CreateScaleFactor(const string text);             //Counter Trend Scale Factor
      int               grid_Scale_Factor;
      #define GTM_SPINEDIT4_GAP_X     (420)
      #define GTM_SPINEDIT4_GAP_Y     (200)
      bool              GTM_CreateScaleStart(const string text);              //Counter Trend Scale Start level
      int               grid_Scale_StartLevel;      
      #define GTM_CHECKBOX1_GAP_X       (420)
      #define GTM_CHECKBOX1_GAP_Y       (250)
      bool              GTM_CreateGridDisplay(const string text);             //Show/Hide grid checkbox
      bool              GTM_DisplayGrid(bool show);                           //Function to Show/Hide Grid
      #define GTM_BUTTON1_GAP_X            (450)
      #define GTM_BUTTON1_GAP_Y            (225)
      bool              GTM_CreateApplyButton(const string text);             //Construct grid
            
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
      #define CTRL_COMBOBOX1_GAP_X        (160)
      #define CTRL_COMBOBOX1_GAP_Y        (75)
      bool              Control_CreateComboEntryType(const string text);      
      #define CTRL_COMBOBOX2_GAP_X        (160)
      #define CTRL_COMBOBOX2_GAP_Y        (100)
      bool              Control_CreateComboDirection(const string text); 
      #define CTRL_SPINEDIT1_GAP_X        (400)
      #define CTRL_SPINEDIT1_GAP_Y        (75)
      bool              Control_CreateEntryPrice(const string text);      
      #define CTRL_SPINEDIT2_GAP_X        (400)
      #define CTRL_SPINEDIT2_GAP_Y        (100)
      bool              Control_CreateLotSize(const string text);      

      bool              Control_LockDown(bool lockStatus,bool lockAll);
      
      double            lotSize;
      ENTRY_TYPE        entryType;
      TRADE_DIRECTION   tradeDirection;
      double            entryPrice;
      
      //+------------------------------------------------------------------+
      //| GRID TREND MULTIPLIER FUNCTIONS and parameters
      //+------------------------------------------------------------------+ 
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
 
      double            grid_PriceArray[1000][2];           //Grid [price][ticket] array to keep track of total open and entry price level           
          
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
   CProgram::GTM_DisplayGrid(false);
}

//+------------------------------------------------------------------+
//| On Tick event                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTickEvent(void)
{
   //+++ Enable this when testing
   //CTRL_Status=START; 
   //isVariablesRefreshed = Op_Refresh_Variables();
   
   //+++ Entry/Manage GTM every tick
   if(CTRL_Status==START) {
      CProgram::GridTrendMultiplier();  
      CProgram::Config_RefreshTable(); 
   }

   //+++ Refresh control panel
   CProgram::Account_RefreshTable();
   CProgram::GTM_RefreshTable();
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
   count=0;
   //--- Change the value in the second item of the status bar
   m_status_bar.ValueToItem(1,::TimeToString(TimeLocal(),TIME_DATE|TIME_SECONDS));
   m_status_bar.ValueToItem(2,fn_RemainingTime());
   m_status_bar.ValueToItem(3,fn_IsConnectedToBroker());

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

   //--- The text label press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL){
      Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      
      //--- Counter Trend Scaling      
      if(lparam==m_GTM_checkTrendScaling.Id()){
         if(m_GTM_checkTrendScaling.CheckButtonState()){
            m_GTM_editScaleFactor.SpinEditState(true);
            m_GTM_editScaleLevel.SpinEditState(true);
         }else{
            m_GTM_editScaleFactor.SpinEditState(false);
            m_GTM_editScaleLevel.SpinEditState(false);
         }            
      }
      //--- Show/Hide Grid
      if(lparam==m_GTM_checkGridDisplay.Id()){
         if(m_GTM_checkGridDisplay.CheckButtonState())
            CProgram::GTM_DisplayGrid(true);            
         else
            CProgram::GTM_DisplayGrid(false);
      }
      //--- Show/Hide Ask line
      if(lparam==m_Control_checkboxAskLine.Id()){
         if(m_Control_checkboxAskLine.CheckButtonState())
            ChartSetInteger(0,CHART_SHOW_ASK_LINE,true);
         else
            ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
      }
   }
   
   //--- Button click event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON){
      
      //--- Check button group
      if(lparam==m_Config_ButtonsGroup.Id()){
         curSelectedButton = m_Config_ButtonsGroup.SelectedButtonIndex();
         
         switch((int)dparam){
            //--- START button
            case 0:
               //isVariablesRefreshed = Op_Refresh_Variables();
               //if(isVariablesRefreshed){
               //   CTRL_Status=START;
               //   //---Disable all the buttons
               //   Config_LockDown(true);
               //   GTM_LockDown(true);
               //   Control_LockDown(true);
               //   fn_SendNotification("--->GTM successfully started<----------",true,false,false);
               //}else{
               //   fn_SendNotification("--->GTM Failed to start<----------Variables has not been refreshed",true,false,false);                  
               //   m_Config_ButtonsGroup.SelectedRadioButton(1);
               //}
               Op_GTM_START();
               break;
            //--- PAUSE button
            case 1:
               //CTRL_Status=PAUSE;
               ////---Enable certain buttons
               //Config_LockDown(false);
               ////GTM_LockDown(true);
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
               //   Config_LockDown(false);
               //   GTM_LockDown(false);
               //   Control_LockDown(false); 
               //   fn_SendNotification("--->GTM successfully stopped<----------",true,false,false);
               }else{
                  m_Config_ButtonsGroup.SelectedRadioButton(1);
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
           
      if(lparam==m_Config_ApplyButton.Id()){
         if(MessageBox("Apply configuration settings?","Apply Config",MB_YESNO)==IDYES){
            if(!Op_Refresh_Variables())
               MessageBox("Fail to Refresh variables","Error",0);            
         }
      } 
      
      //---
      if(lparam==m_GTM_buttonApply.Id()){
         if(!Op_Refresh_Variables())
            MessageBox("Fail to Refresh variables","Error",0);
         else{
            GTM_DisplayGrid(false);
            if(!Op_Initialize_Grid())
               MessageBox("Fail to Initialize grid","Error",0);
            else
               GTM_DisplayGrid(true);
         }
      }   
   }
   
   //--- Selection of item in combobox event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM){
      //--- Entry Type is immediate      
      if(lparam==m_Control_comboEntryType.Id()){
         if(m_Control_comboEntryType.ButtonText()=="IMMEDIATE"){
            m_Control_editEntryprice.SpinEditState(false);
         }else{
            m_Control_editEntryprice.SpinEditState(true);            
         }
      }      
   }


}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| Create an expert panel             
//+------------------------------------------------------------------------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(string panelName, string &srcConfigTable[][])
{
   //--- Initialize Variables
   if(!Op_Init_Variables(srcConfigTable))
      return(false);

   //--- Creating form 1 for controls
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
   
   //--- Create Configuration components
   if(!Config_CreateTable()) 
      return(false); 
   if(!Config_CreateApplyButton("Apply Config")) 
      return(false);
   
   //--- Create Account components
   if(!Account_CreateTable()) 
      return(false);    
   
   //--- Create GTM components
   if(!GTM_CreateTable())
      return(false);      
   if(!GTM_CreateGridSize("Grid Size [pips]")) 
      return(false);
   if(!GTM_CreateGridEntry("Grid Entry Level"))
      return(false);
   if(!GTM_CreateResetLevel("Grid Reset Level"))
      return(false);      
   if(!GTM_CreateTrendScaling("Counter Trend Scale"))
      return(false);
   if(!GTM_CreateScaleFactor("Scale Factor"))
      return(false);
   if(!GTM_CreateScaleStart("Scale Start Level"))
      return(false);
   if(!GTM_CreateApplyButton("Create Grid"))
      return(false);
   if(!GTM_CreateGridDisplay("Display GRID"))
      return(false);
   else
      GTM_DisplayGrid(true);

   //--- Create Control components
   if(!Control_CreateSepLine()) 
      return(false);   
   if(!Control_CreateButtonsGroup()) 
      return(false);   
   if(!Control_CreateComboEntryType("Entry Type")) 
      return(false);
   if(!Control_CreateComboDirection("Trade Direction")) 
      return(false);
   if(!Control_CreateEntryPrice("Entry Price:")) 
      return(false);
   if(!Control_CreateLotSize("Lot Size:")) 
      return(false);
   if(!Control_CreateCheckBoxAskLine("Display ASK Line")) 
      return(false);
   
   //--- Display controls of the active tab only
   m_tabs.ShowTabElements();
   
   //--- Redrawing the chart
   m_chart.Redraw();
   
   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+

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

//+------------------------------------------------------------------------------------------------------------------------------------+
// Support functions
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Function to initialize configurations variables
//+------------------------------------------------------------------+
bool CProgram::Op_Init_Variables(string &configItems[][])
{
   int index=0;
   
   //--- Configuration parameters
   table_Config_Rows = 8;                          //Initialise ConfigTable total item
   ArrayResize(ConfigTable,table_Config_Rows);     //Initialise ConfigTable size

   int totalRows = ArrayRange(configItems,0);
   for(int i=0;i<totalRows;i++){
      switch(i){
         case  0:lotSize=(double)configItems[i][1];
           break;
         case  1:entryType=StringToEnum(configItems[i][1],entryType);
           break;
         case  2:tradeDirection=StringToEnum(configItems[i][1],tradeDirection);
           break;
         case  3:entryPrice=(double)configItems[i][1];
           break;
         case  4:grid_SL_Level=(int)configItems[i][1]; grid_entryIndex=grid_SL_Level;
           break;
         case  5:grid_SL_Price=(double)configItems[i][1]; ConfigTable[1][0]=configItems[i][0]; ConfigTable[1][1]=DoubleToStr(configItems[i][1],4);
           break;
         case  6:conf_SL_MinPips=(int)configItems[i][1]; ConfigTable[2][0]=configItems[i][0]; ConfigTable[2][1]=DoubleToStr(configItems[i][1],0);
           break;
         case  7:conf_TP_Amount=(double)configItems[i][1]; ConfigTable[4][0]=configItems[i][0]; ConfigTable[4][1]=DoubleToStr(configItems[i][1],2);
           break;
         case  8:conf_TP_Price=(double)configItems[i][1]; ConfigTable[5][0]=configItems[i][0]; ConfigTable[5][1]=DoubleToStr(configItems[i][1],4);
           break;
         case  9:grid_Size=configItems[i][1];
           break;
         case 10:grid_Reset_Level=configItems[i][1];
           break;
         case 11:conf_SL_StealthPips=configItems[i][1]; ConfigTable[3][0]=configItems[i][0]; ConfigTable[3][1]=configItems[i][1];
           break;
         case 12:ticket_Max_Open=configItems[i][1]; ConfigTable[6][0]=configItems[i][0]; ConfigTable[6][1]=configItems[i][1];
           break;
         case 13:ticket_Max_Spreads=configItems[i][1]; ConfigTable[7][0]=configItems[i][0]; ConfigTable[7][1]=DoubleToStr(configItems[i][1],0);
           break;
         case 14:grid_Scale_Enable=((configItems[i][1]=="true") ? true:false);
           break;
         case 15:grid_Scale_Factor=configItems[i][1];
           break;
         case 16:grid_Scale_StartLevel=configItems[i][1];
           break;
         default:
           break;
        }   
   }
   
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
       
   if(!Op_Initialize_Grid())
      return(false);

   grid_SL_Price=grid_PriceArray[0][0];      //Store Stoploss price
   table_Gtm_Rows=11;
   ArrayResize(GtmTable,table_Gtm_Rows);
         
   index=0;
   GtmTable[index][0]="GTM Information";
   GtmTable[index][1]="Value";
   index++;
   GtmTable[index][0]="Margin Amount";
   GtmTable[index][1]=DoubleToString(AccountMargin(),2);
   index++;
   GtmTable[index][0]="Free Margin Amount";
   GtmTable[index][1]=DoubleToString(AccountFreeMargin(),2);   
   index++;
   GtmTable[index][0]="Total Active Orders";
   GtmTable[index][1]=grid_cntActiveTickets;
   index++;
   GtmTable[index][0]="Running Profit/Loss (pips)";
   GtmTable[index][1]=grid_runningPLPips;
   index++;
   GtmTable[index][0]="Running Profit/Loss amount";
   GtmTable[index][1]=DoubleToString(grid_runningPLAmount,2);
   index++;
   GtmTable[index][0]="Accum Profit (pips)";
   GtmTable[index][1]=grid_accumPLPips;
   index++;
   GtmTable[index][0]="Accum Profit Amount";
   GtmTable[index][1]=DoubleToString(grid_accumPLAmount,2);
   index++;
   GtmTable[index][0]="Next Level | Scale Level";
   GtmTable[index][1]=IntegerToString(grid_nextIndex) + " | " + IntegerToString(grid_nextScaleIndex) ;
   index++;
   GtmTable[index][0]="Current Level | Scale Level";
   GtmTable[index][1]=IntegerToString(grid_currentIndex) + " | " + IntegerToString(grid_currentScaleIndex);
   index++;
   GtmTable[index][0]="Previous Level | Scale Level";
   GtmTable[index][1]=IntegerToString(grid_prevIndex) + " | " + IntegerToString(grid_prevScaleIndex);

   return(true);
}

//+------------------------------------------------------------------+
//| Function to Refresh all program variables
//+------------------------------------------------------------------+
bool CProgram::Op_Refresh_Variables(void)
{
   //--- Trade Control variables
   tradeDirection = StringToEnum(m_Control_comboDirection.ButtonText(),tradeDirection);
   
   entryType = StringToEnum(m_Control_comboEntryType.ButtonText(),entryType);
   
   if(entryType==IMMEDIATE)
      entryPrice = fn_GetEntryPrice(entryPrice,tradeDirection,entryType);
   else      
      entryPrice = m_Control_editEntryprice.GetValue();
   
   lotSize = (double)m_Control_editLotSize.GetValue();

   //--- Grid variables
   grid_Size = m_GTM_editGridSize.GetValue();
   grid_entryIndex = m_GTM_editGridEntry.GetValue();
   grid_Reset_Level = m_GTM_editGridReset.GetValue();
   
   grid_Scale_Enable = m_GTM_checkTrendScaling.CheckButtonState();
   grid_Scale_StartLevel = m_GTM_editScaleLevel.GetValue();
   if(grid_Scale_Enable && grid_Scale_StartLevel==0){
      grid_Scale_StartLevel = grid_entryIndex;
      Print("Scale Start Level is not set. Reseting to Grid Entry Level");
   }
   grid_Scale_Factor = m_GTM_editScaleFactor.GetValue();
   if(grid_Scale_Factor==0){
      grid_Scale_Factor = 1;
      Print("Grid Scale Factor is not set. Reseting to 1");
   }
   
   grid_SL_Price=grid_PriceArray[0][0];      //Store Stoploss price

   //--- Configuration variables
   conf_SL_StealthPips = m_ConfigTable.GetValue(1,3);
   conf_TP_Amount = m_ConfigTable.GetValue(1,4);
   conf_TP_Price = m_ConfigTable.GetValue(1,5);
   ticket_Max_Open = m_ConfigTable.GetValue(1,6);
   ticket_Max_Spreads = m_ConfigTable.GetValue(1,7);
   
   return(true);
}

//+------------------------------------------------------------------+
//| Function to construct grid
//+------------------------------------------------------------------+
bool CProgram::Op_Initialize_Grid(void)
{
   entryPrice = fn_GetEntryPrice(entryPrice,tradeDirection,entryType);

   //Alert("tradeDirection:",EnumToString(tradeDirection),"-entryType:",EnumToString(entryType),"-entryPrice:",entryPrice,"-grid_entryIndex:",grid_entryIndex,"-grid_Size:",grid_Size,"-grid_MaxSize:",grid_MaxSize);
   
   //Initialize grid values
   if(tradeDirection==LONG && entryType==IMMEDIATE){
      for (int i=0; i<grid_MaxSize; i++){
         grid_PriceArray[i][0]= entryPrice + (i-grid_entryIndex)*grid_Size*acct_MyPoint;
      }      
   }else
   if(tradeDirection==SHORT && entryType==IMMEDIATE){
      for (int i=0; i<grid_MaxSize; i++) {         
         grid_PriceArray[i][0]= entryPrice - (i-grid_entryIndex)*grid_Size*acct_MyPoint;
      }      
   }else
   if(tradeDirection==LONG && entryType!=IMMEDIATE && entryPrice!=0){
      for (int i=0; i<grid_MaxSize; i++){
         grid_PriceArray[i][0]= entryPrice + (i-grid_entryIndex)*grid_Size*acct_MyPoint;
      }      
   }else
   if(tradeDirection==SHORT && entryType!=IMMEDIATE && entryPrice!=0){
      for (int i=0; i<grid_MaxSize; i++) {
         grid_PriceArray[i][0]= entryPrice - (i-grid_entryIndex)*grid_Size*acct_MyPoint;
      }      
   }
    
   return(true);       
}

//+------------------------------------------------------------------+
//| Function to handle grid when START button is pressed
//+------------------------------------------------------------------+
bool CProgram::Op_GTM_START(void)
{
   isVariablesRefreshed = Op_Refresh_Variables();
   if(isVariablesRefreshed){
      //---Disable all the buttons
      Config_LockDown(true);
      GTM_LockDown(true);
      Control_LockDown(true,true);
      //---Activate grid
      CTRL_Status=START;
      fn_SendNotification("--->GTM successfully started<----------",true,false,false);
   }else{ // If start failed, select Pause button and send notification
      m_Config_ButtonsGroup.SelectedRadioButton(1);   //Select pause button
      fn_SendNotification("--->GTM Failed to start<----------Variables has not been refreshed",true,true,false);
      return(false);
   }
   
   return(true);
}

//+------------------------------------------------------------------+
//| Function to handle grid when PAUSE button is pressed
//+------------------------------------------------------------------+
bool CProgram::Op_GTM_PAUSE(void)
{
   CTRL_Status=PAUSE;
   isVariablesRefreshed = false;
   //---Enable certain buttons
   Config_LockDown(false);
   //GTM_LockDown(true);
   Control_LockDown(false,false);
   m_Config_ButtonsGroup.SelectedRadioButton(1);      //Select Pause button
   fn_SendNotification("--->GTM pause<----------",true,false,false); 
   return(true);
}

//+------------------------------------------------------------------+
//| Function to handle grid when STOP button is pressed
//+------------------------------------------------------------------+
bool CProgram::Op_GTM_STOP(void)
{
   CTRL_Status=STOP;
   isVariablesRefreshed = false;
   fn_CloseAllOrders(acct_MagicNumber);
   //---Enable all the buttons
   Config_LockDown(false);
   GTM_LockDown(false);
   Control_LockDown(false,true); 
   m_Config_ButtonsGroup.SelectedRadioButton(2);      //Select Stop button
   fn_SendNotification("--->GTM successfully stopped<----------",true,false,false);
   return(true);
}

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
   GTM_DisplayGrid(false);
   GTM_DisplayGrid(true);

   return(true);  
}

//+------------------------------------------------------------------+
//| Function to Show grid
//+------------------------------------------------------------------+
bool CProgram::GTM_DisplayGrid(bool show)
{   
   if(show){
      for(int i=0;i<grid_entryIndex*6;i++){
         if(i==grid_entryIndex){
            m_GTM_Gridline.Create(0,"Entry",0,grid_PriceArray[i][0]);
            m_GTM_Gridline.Description("Entry Level");
            m_GTM_Gridline.Color(clrBlue);
         }else if(grid_Reset_Level!=0 && i==grid_Reset_Level){
            m_GTM_Gridline.Create(0,"Level "+ (string)i,0,grid_PriceArray[i][0]);
            m_GTM_Gridline.Description("Reset Level "+ (string)i);
         }else{
            m_GTM_Gridline.Create(0,"Level "+ (string)i,0,grid_PriceArray[i][0]);
            m_GTM_Gridline.Description("Level "+ (string)i);
         }
      	  
         m_GTM_Gridline.Width(1);
         m_GTM_Gridline.Style(STYLE_DASH);
         m_GTM_Gridline.Background(true);
            
         if(i<grid_entryIndex){      
            m_GTM_Gridline.Color(clrDarkSlateGray);
         }
         if(i>grid_entryIndex){
            m_GTM_Gridline.Color(clrMaroon);
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

//+------------------------------------------------------------------+
//| Function using ticket number to retrive 
//|   current index, previous index, next index                      
//|   current scale index, previous scale index, next scale index
//+------------------------------------------------------------------+
bool CProgram::GTM_GetIndexByTicket(void)
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
}

//+------------------------------------------------------------------+
//| Function to get the current grid index, previous index, next index using price level
//+------------------------------------------------------------------+
bool CProgram::GTM_GetIndexByPriceLevel(void)
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
}




//+------------------------------------------------------------------+
//| GRAPHICAL INTERFACE
//+------------------------------------------------------------------+
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
   m_window1.XSize(604);
   m_window1.YSize(315);
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
   int width[]={0,110,70,70};

   //--- Set properties before creation
   m_status_bar.YSize(24);
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
   string tabs_text[]={"Config","Account","GTM","Control"};
   int tabs_width[]={90,90,90,90};

   //--- Set properties before creation
   m_tabs.XSize(596);
   m_tabs.YSize(243);
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
//| Configuration tab
//+------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create Configuration table
//+------------------------------------------------------------------+
bool CProgram::Config_CreateTable()
{  

   //--- Store pointer to the form
   m_ConfigTable.WindowPointer(m_window1);

   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(0,m_ConfigTable);

   //--- Coordinates
   int x=m_window1.X()+TABLE2_GAP_X;
   int y=m_window1.Y()+TABLE2_GAP_Y;

   //--- Set properties before creation
   m_ConfigTable.XSize(400);  //594
   m_ConfigTable.RowYSize(18);
   m_ConfigTable.FixFirstRow(true);
   m_ConfigTable.FixFirstColumn(true);
   m_ConfigTable.LightsHover(true);
   m_ConfigTable.SelectableRow(true);
   m_ConfigTable.ReadOnly(false);
   m_ConfigTable.TextAlign(ALIGN_CENTER);
   m_ConfigTable.HeadersColor(C'255,244,213');
   m_ConfigTable.HeadersTextColor(clrBlack);
   m_ConfigTable.GridColor(clrLightGray);
   m_ConfigTable.CellColorHover(clrGold);
   m_ConfigTable.TableSize(TABLE_COLUMNS,table_Config_Rows);
   m_ConfigTable.VisibleTableSize(VISIBLE_COLUMNS,VISIBLE_ROWS);

   //--- Create control
   if(!m_ConfigTable.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);

   m_ConfigTable.SetValue(0,0,"Configuration Items");
   m_ConfigTable.SetValue(1,0,"Value");
   
   //--- Headers for rows, text alignment mode - right
   for(int c=0; c<1; c++){
      for(int r=1; r<table_Config_Rows; r++){
         m_ConfigTable.SetValue(c,r,ConfigTable[r][c]);
         m_ConfigTable.TextAlign(c,r,ALIGN_RIGHT);
      }
   }

   //--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<TABLE_COLUMNS; c++){
      for(int r=1; r<table_Config_Rows; r++)
      {
         m_ConfigTable.SetValue(c,r,ConfigTable[r][c]);
         m_ConfigTable.TextAlign(c,r,ALIGN_RIGHT);
         m_ConfigTable.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_ConfigTable.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
      }
   }

   //--- Update the table to display changes
   m_ConfigTable.UpdateTable();
   
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_ConfigTable);
   return(true);
}

//+------------------------------------------------------------------+
//| Reset Configuration table
//+------------------------------------------------------------------+
bool CProgram::Config_RefreshTable()
{  

   //Stoploss Price
   ConfigTable[1][1] = grid_SL_Price;
   //Stoploss Min Pip
   //ConfigTable[2][1] = grid_SL_Price;
   //Stoploss Stealth Pip
   ConfigTable[3][1] = conf_SL_StealthPips;
   //Take Profit Amount
   ConfigTable[4][1] = conf_TP_Amount;
   //Take Profit Price
   ConfigTable[5][1] = DoubleToStr(conf_TP_Price,4);
   //Max Active ticket
   ConfigTable[6][1] = ticket_Max_Open;
   //Max Spread pips
   ConfigTable[7][1] = ticket_Max_Spreads;
   
   //--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<TABLE_COLUMNS; c++){
      for(int r=1; r<table_Config_Rows; r++)
      {
         m_ConfigTable.SetValue(c,r,ConfigTable[r][c]);
         m_ConfigTable.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_ConfigTable.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
      }
   }

   //--- Update the table to display changes
   m_ConfigTable.UpdateTable();

   return(true);
}

//+------------------------------------------------------------------+
//| Create Apply Config button
//+------------------------------------------------------------------+
bool CProgram::Config_CreateApplyButton(string button_text)
{
   //--- Pass the object to the panel
   m_Config_ApplyButton.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(0,m_Config_ApplyButton);   
   //--- Coordinates
   int x=m_window1.X()+BUTTON1_GAP_X;
   int y=m_window1.Y()+BUTTON1_GAP_Y;
//--- Set up properties before creation
   m_Config_ApplyButton.ButtonXSize(116);
   m_Config_ApplyButton.TextColor(clrBlack);
   m_Config_ApplyButton.TextColorPressed(clrBlack);
   m_Config_ApplyButton.BackColor(C'255,140,140');
   m_Config_ApplyButton.BackColorHover(C'255,180,180');
   m_Config_ApplyButton.BackColorPressed(C'255,120,120');
   m_Config_ApplyButton.BorderColor(C'150,170,180');
   m_Config_ApplyButton.BorderColorOff(C'178,195,207');
   
   //--- Create the button
   if(!m_Config_ApplyButton.CreateSimpleButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
   
   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_Config_ApplyButton);
   return(true);
}

//+------------------------------------------------------------------+
//| Function to Enable/Disable Configuration function
//+------------------------------------------------------------------+
bool CProgram::Config_LockDown(bool lockStatus)
{
   m_ConfigTable.ReadOnly(lockStatus);
   m_Config_ApplyButton.ButtonState(!lockStatus);
   
   return(true);
}

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


//+------------------------------------------------------------------------------------------------------------------------------------+
//| GTM Information tab
//+------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create GTM table
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateTable()
{
   //--- Store pointer to the form
   m_GtmTable.WindowPointer(m_window1);

   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(2,m_GtmTable);

   //--- Coordinates
   int x=m_window1.X()+TABLE2_GAP_X;
   int y=m_window1.Y()+TABLE2_GAP_Y;

   //--- Set properties before creation
   m_GtmTable.XSize(400);  //594
   m_GtmTable.RowYSize(18);
   m_GtmTable.FixFirstRow(true);
   m_GtmTable.FixFirstColumn(true);
   m_GtmTable.LightsHover(true);
   m_GtmTable.SelectableRow(true);
   m_GtmTable.ReadOnly(true);
   m_GtmTable.TextAlign(ALIGN_CENTER);
   m_GtmTable.HeadersColor(C'255,244,213');
   m_GtmTable.HeadersTextColor(clrBlack);
   m_GtmTable.GridColor(clrLightGray);
   m_GtmTable.CellColorHover(clrGold);
   m_GtmTable.TableSize(TABLE_COLUMNS,table_Gtm_Rows);
   m_GtmTable.VisibleTableSize(VISIBLE_COLUMNS,VISIBLE_ROWS);

   //--- Create control
   if(!m_GtmTable.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Headers for rows, text alignment mode - right
   for(int c=0; c<1; c++){
      for(int r=0; r<table_Gtm_Rows; r++){
         m_GtmTable.SetValue(c,r,GtmTable[r][c]);
         m_GtmTable.TextAlign(c,r,ALIGN_RIGHT);
      }
   }

   //--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<TABLE_COLUMNS; c++){
      for(int r=0; r<table_Gtm_Rows; r++)
      {
         m_GtmTable.SetValue(c,r,GtmTable[r][c]);
         m_GtmTable.TextAlign(c,r,ALIGN_RIGHT);
         m_GtmTable.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_GtmTable.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
      }
   }

   //--- Update the table to display changes
   m_GtmTable.UpdateTable();

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GtmTable);
   return(true);
}

//+------------------------------------------------------------------+
//| Refresh GTM table
//+------------------------------------------------------------------+
bool CProgram::GTM_RefreshTable()
{  
   grid_accumPLAmount   =grid_accumPLPips * acct_pipValue;
   grid_runningPLPips   =fn_GetRunningProfitLossPip(acct_MagicNumber,acct_MyPoint);
   grid_runningPLAmount =grid_runningPLPips * acct_pipValue;
   
   GtmTable[1][1]=DoubleToString(AccountMargin(),2);
   GtmTable[2][1]=DoubleToString(AccountFreeMargin(),2);   
   GtmTable[3][1]=DoubleToStr(grid_cntActiveTickets,0);
   GtmTable[4][1]=DoubleToStr(grid_runningPLPips,0);
   GtmTable[5][1]=DoubleToString(grid_runningPLAmount,2);
   GtmTable[6][1]=DoubleToStr(grid_accumPLPips,0);
   GtmTable[7][1]=DoubleToString(grid_accumPLAmount,2);
   GtmTable[8][1]=IntegerToString(grid_nextIndex) + " | " + IntegerToString(grid_nextScaleIndex);
   GtmTable[9][1]=IntegerToString(grid_currentIndex) + " | " + IntegerToString(grid_currentScaleIndex);
   GtmTable[10][1]=IntegerToString(grid_prevIndex) + " | " + IntegerToString(grid_prevScaleIndex);

   //--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<TABLE_COLUMNS; c++){
      for(int r=1; r<table_Gtm_Rows; r++){
         m_GtmTable.SetValue(c,r,GtmTable[r][c]);
         m_GtmTable.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_GtmTable.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
      }
   }

   //--- Update the table to display changes
   m_GtmTable.UpdateTable();

   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM Grid size                                         |
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateGridSize(const string text)
{
   //--- Store the window pointer
   m_GTM_editGridSize.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(2,m_GTM_editGridSize);      
   
   //--- Coordinates
   int x=m_window1.X()+GTM_SPINEDIT1_GAP_X;
   int y=m_window1.Y()+GTM_SPINEDIT1_GAP_Y;
   //--- Value

   double eValue = (grid_Size >=2 ) ? grid_Size : 2;

   //--- Set properties before creation
   m_GTM_editGridSize.XSize(175);
   m_GTM_editGridSize.YSize(18);
   m_GTM_editGridSize.EditXSize(76);
   m_GTM_editGridSize.MaxValue(1000);
   m_GTM_editGridSize.MinValue(2);
   m_GTM_editGridSize.StepValue(1);
   m_GTM_editGridSize.SetDigits(0);
   m_GTM_editGridSize.SetValue(eValue);
   m_GTM_editGridSize.ResetMode(true);
   m_GTM_editGridSize.AreaColor(clrWhiteSmoke);
   m_GTM_editGridSize.LabelColor(clrBlack);
   m_GTM_editGridSize.LabelColorLocked(clrSilver);
   m_GTM_editGridSize.EditColorLocked(clrWhiteSmoke);
   m_GTM_editGridSize.EditTextColor(clrBlack);
   m_GTM_editGridSize.EditTextColorLocked(clrSilver);
   m_GTM_editGridSize.EditBorderColor(clrSilver);
   m_GTM_editGridSize.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GTM_editGridSize.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- The availability will depend on the current trading state
   //if(m_GTM_editGridSize.ButtonText()=="IMMEDIATE")
   //   m_GTM_editGridSize.SpinEditState(false);
   //else
   //   m_GTM_editGridSize.SpinEditState(true);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GTM_editGridSize);

   return(true);
}


//+------------------------------------------------------------------+
//| Creates GTM entry level                                             |
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateGridEntry(const string text)
{
   //--- Store the window pointer
   m_GTM_editGridEntry.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(2,m_GTM_editGridEntry);      
   
   //--- Coordinates
   int x=m_window1.X()+GTM_SPINEDIT2_GAP_X;
   int y=m_window1.Y()+GTM_SPINEDIT2_GAP_Y;
   //--- Value

   double eValue = (grid_entryIndex >=15 ) ? grid_entryIndex : 15;

   //--- Set properties before creation
   m_GTM_editGridEntry.XSize(175);
   m_GTM_editGridEntry.YSize(18);
   m_GTM_editGridEntry.EditXSize(76);
   m_GTM_editGridEntry.MaxValue(50);
   m_GTM_editGridEntry.MinValue(5);
   m_GTM_editGridEntry.StepValue(1);
   m_GTM_editGridEntry.SetDigits(0);
   m_GTM_editGridEntry.SetValue(eValue);
   m_GTM_editGridEntry.ResetMode(true);
   m_GTM_editGridEntry.AreaColor(clrWhiteSmoke);
   m_GTM_editGridEntry.LabelColor(clrBlack);
   m_GTM_editGridEntry.LabelColorLocked(clrSilver);
   m_GTM_editGridEntry.EditColorLocked(clrWhiteSmoke);
   m_GTM_editGridEntry.EditTextColor(clrBlack);
   m_GTM_editGridEntry.EditTextColorLocked(clrSilver);
   m_GTM_editGridEntry.EditBorderColor(clrSilver);
   m_GTM_editGridEntry.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GTM_editGridEntry.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- The availability will depend on the current trading state
   //if(m_GTM_editGridSize.ButtonText()=="IMMEDIATE")
   //   m_GTM_editGridSize.SpinEditState(false);
   //else
   //   m_GTM_editGridSize.SpinEditState(true);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GTM_editGridEntry);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM reset level                                             |
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateResetLevel(const string text)
{
   //--- Store the window pointer
   m_GTM_editGridReset.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(2,m_GTM_editGridReset);      
   
   //--- Coordinates
   int x=m_window1.X()+GTM_SPINEDIT5_GAP_X;
   int y=m_window1.Y()+GTM_SPINEDIT5_GAP_Y;
   //--- Value

   double eValue = (grid_Reset_Level >=1 ) ? grid_Reset_Level : 1;

   //--- Set properties before creation
   m_GTM_editGridReset.XSize(175);
   m_GTM_editGridReset.YSize(18);
   m_GTM_editGridReset.EditXSize(76);
   m_GTM_editGridReset.MaxValue(100);
   m_GTM_editGridReset.MinValue(5);
   m_GTM_editGridReset.StepValue(1);
   m_GTM_editGridReset.SetDigits(0);
   m_GTM_editGridReset.SetValue(eValue);
   m_GTM_editGridReset.ResetMode(true);
   m_GTM_editGridReset.AreaColor(clrWhiteSmoke);
   m_GTM_editGridReset.LabelColor(clrBlack);
   m_GTM_editGridReset.LabelColorLocked(clrSilver);
   m_GTM_editGridReset.EditColorLocked(clrWhiteSmoke);
   m_GTM_editGridReset.EditTextColor(clrBlack);
   m_GTM_editGridReset.EditTextColorLocked(clrSilver);
   m_GTM_editGridReset.EditBorderColor(clrSilver);
   m_GTM_editGridReset.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GTM_editGridReset.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
         
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GTM_editGridReset);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates checkbox display grid
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateGridDisplay(string text)
{
   //--- Store the window pointer
   m_GTM_checkGridDisplay.WindowPointer(m_window1);

   //--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(2,m_GTM_checkGridDisplay);

   //--- Coordinates
   int x=m_window1.X()+GTM_CHECKBOX1_GAP_X;
   int y=m_window1.Y()+GTM_CHECKBOX1_GAP_Y;

   //--- Set properties before creation
   m_GTM_checkGridDisplay.XSize(90);
   m_GTM_checkGridDisplay.YSize(18);
   m_GTM_checkGridDisplay.AreaColor(clrWhite);
   m_GTM_checkGridDisplay.LabelColor(clrBlack);
   m_GTM_checkGridDisplay.LabelColorOff(clrBlack);
   m_GTM_checkGridDisplay.LabelColorLocked(clrSilver);
   m_GTM_checkGridDisplay.CheckButtonState(true);

   //--- Create control
   if(!m_GTM_checkGridDisplay.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GTM_checkGridDisplay);
   return(true);
}

//+------------------------------------------------------------------+
//| Creates checkbox display grid
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateTrendScaling(const string text)
{
   //--- Store the window pointer
   m_GTM_checkTrendScaling.WindowPointer(m_window1);

   //--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(2,m_GTM_checkTrendScaling);

   //--- Coordinates
   int x=m_window1.X()+GTM_CHECKBOX2_GAP_X;
   int y=m_window1.Y()+GTM_CHECKBOX2_GAP_Y;

   //--- Set properties before creation
   m_GTM_checkTrendScaling.XSize(90);
   m_GTM_checkTrendScaling.YSize(18);
   m_GTM_checkTrendScaling.AreaColor(clrWhite);
   m_GTM_checkTrendScaling.LabelColor(clrBlack);
   m_GTM_checkTrendScaling.LabelColorOff(clrBlack);
   m_GTM_checkTrendScaling.LabelColorLocked(clrSilver);
   m_GTM_checkTrendScaling.CheckButtonState(grid_Scale_Enable);

   //--- Create control
   if(!m_GTM_checkTrendScaling.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GTM_checkTrendScaling);
   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM scale factor
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateScaleFactor(const string text)
{
   //--- Store the window pointer
   m_GTM_editScaleFactor.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(2,m_GTM_editScaleFactor);      
   
   //--- Coordinates
   int x=m_window1.X()+GTM_SPINEDIT3_GAP_X;
   int y=m_window1.Y()+GTM_SPINEDIT3_GAP_Y;
   //--- Value

   double eValue = (grid_Scale_Factor >=0 ) ? grid_Scale_Factor : 2;

   //--- Set properties before creation
   m_GTM_editScaleFactor.XSize(175);
   m_GTM_editScaleFactor.YSize(18);
   m_GTM_editScaleFactor.EditXSize(76);
   m_GTM_editScaleFactor.MaxValue(100);
   m_GTM_editScaleFactor.MinValue(2);
   m_GTM_editScaleFactor.StepValue(1);
   m_GTM_editScaleFactor.SetDigits(0);
   m_GTM_editScaleFactor.SetValue(eValue);
   m_GTM_editScaleFactor.ResetMode(true);
   m_GTM_editScaleFactor.AreaColor(clrWhiteSmoke);
   m_GTM_editScaleFactor.LabelColor(clrBlack);
   m_GTM_editScaleFactor.LabelColorLocked(clrSilver);
   m_GTM_editScaleFactor.EditColorLocked(clrWhiteSmoke);
   m_GTM_editScaleFactor.EditTextColor(clrBlack);
   m_GTM_editScaleFactor.EditTextColorLocked(clrSilver);
   m_GTM_editScaleFactor.EditBorderColor(clrSilver);
   m_GTM_editScaleFactor.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GTM_editScaleFactor.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- The availability will depend on the current enable scaling state
   if(!m_GTM_checkTrendScaling.CheckButtonState())
      m_GTM_editScaleFactor.SpinEditState(false);
   else
      m_GTM_editScaleFactor.SpinEditState(true);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GTM_editScaleFactor);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates GTM scale start level
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateScaleStart(const string text)
{
   //--- Store the window pointer
   m_GTM_editScaleLevel.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(2,m_GTM_editScaleLevel);      
   
   //--- Coordinates
   int x=m_window1.X()+GTM_SPINEDIT4_GAP_X;
   int y=m_window1.Y()+GTM_SPINEDIT4_GAP_Y;
   //--- Value

   double eValue = (grid_Scale_StartLevel >=10 ) ? grid_Scale_StartLevel : 10;

   //--- Set properties before creation
   m_GTM_editScaleLevel.XSize(175);
   m_GTM_editScaleLevel.YSize(18);
   m_GTM_editScaleLevel.EditXSize(76);
   m_GTM_editScaleLevel.MaxValue(100);
   m_GTM_editScaleLevel.MinValue(5);
   m_GTM_editScaleLevel.StepValue(1);
   m_GTM_editScaleLevel.SetDigits(0);
   m_GTM_editScaleLevel.SetValue(eValue);
   m_GTM_editScaleLevel.ResetMode(true);
   m_GTM_editScaleLevel.AreaColor(clrWhiteSmoke);
   m_GTM_editScaleLevel.LabelColor(clrBlack);
   m_GTM_editScaleLevel.LabelColorLocked(clrSilver);
   m_GTM_editScaleLevel.EditColorLocked(clrWhiteSmoke);
   m_GTM_editScaleLevel.EditTextColor(clrBlack);
   m_GTM_editScaleLevel.EditTextColorLocked(clrSilver);
   m_GTM_editScaleLevel.EditBorderColor(clrSilver);
   m_GTM_editScaleLevel.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_GTM_editScaleLevel.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- The availability will depend on the current enable scaling state
   if(!m_GTM_checkTrendScaling.CheckButtonState())
      m_GTM_editScaleLevel.SpinEditState(false);
   else
      m_GTM_editScaleLevel.SpinEditState(true);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_GTM_editScaleLevel);

   return(true);
}

//+------------------------------------------------------------------+
//| Create generate grid button
//+------------------------------------------------------------------+
bool CProgram::GTM_CreateApplyButton(const string text)
{
   //--- Pass the object to the panel
   m_GTM_buttonApply.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(2,m_GTM_buttonApply);   
   //--- Coordinates
   int x=m_window1.X()+GTM_BUTTON1_GAP_X;
   int y=m_window1.Y()+GTM_BUTTON1_GAP_Y;
   //--- Set up properties before creation
   m_GTM_buttonApply.ButtonXSize(116);
   m_GTM_buttonApply.TextColor(clrWhite);
   m_GTM_buttonApply.TextColorPressed(clrBlack);
   m_GTM_buttonApply.BackColor(clrForestGreen);
   m_GTM_buttonApply.BackColorHover(C'255,180,180');
   m_GTM_buttonApply.BackColorPressed(C'255,120,120');
   m_GTM_buttonApply.BorderColor(C'150,170,180');
   m_GTM_buttonApply.BorderColorOff(C'178,195,207');
   
   //--- Create the button
   if(!m_GTM_buttonApply.CreateSimpleButton(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_GTM_buttonApply);
   return(true);
}

//+------------------------------------------------------------------+
//| Function to Enable/Disable GTM functions
//+------------------------------------------------------------------+
bool CProgram::GTM_LockDown(bool lockStatus)
{
   m_GTM_buttonApply.ButtonState(!lockStatus);
   m_GTM_editScaleLevel.SpinEditState(!lockStatus);
   m_GTM_editScaleFactor.SpinEditState(!lockStatus);
   m_GTM_checkTrendScaling.CheckBoxState(!lockStatus);
   m_GTM_editGridReset.SpinEditState(!lockStatus);
   m_GTM_editGridEntry.SpinEditState(!lockStatus);
   m_GTM_editGridSize.SpinEditState(!lockStatus);  
   
   return(true);
}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| Control tab
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Create combo box trade entry type
//+------------------------------------------------------------------+
bool CProgram::Control_CreateComboEntryType (const string text)
{
   #define comboItems 3
   string entryTypeList[comboItems]={"IMMEDIATE","PENDING_STOP","PENDING_LIMIT"};
   //--- Store pointer to the form
   m_Control_comboEntryType.WindowPointer(m_window1);
      
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(3,m_Control_comboEntryType);   
     
   //--- Coordinates
   int x=m_window1.X()+CTRL_COMBOBOX1_GAP_X;
   int y=m_window1.Y()+CTRL_COMBOBOX1_GAP_Y;
   
   //--- Set up properties before creation
   m_Control_comboEntryType.XSize(180);
   m_Control_comboEntryType.YSize(18);
   m_Control_comboEntryType.LabelText(text);
   m_Control_comboEntryType.ButtonXSize(100);
   m_Control_comboEntryType.AreaColor(clrWhiteSmoke);
   m_Control_comboEntryType.LabelColor(clrBlack);
   m_Control_comboEntryType.LabelColorHover(clrCornflowerBlue);
   m_Control_comboEntryType.ButtonBackColor(C'206,206,206');
   m_Control_comboEntryType.ButtonBackColorHover(C'193,218,255');
   m_Control_comboEntryType.ButtonBorderColor(C'150,170,180');
   m_Control_comboEntryType.ButtonBorderColorOff(C'178,195,207');
   m_Control_comboEntryType.ItemsTotal(comboItems);
   m_Control_comboEntryType.VisibleItemsTotal(comboItems);
   
   //--- Store the item values to the combo box list
   for(int i=0; i<comboItems; i++)
      m_Control_comboEntryType.ValueToList(i,entryTypeList[i]);
   
   //--- Get the list pointer
   CListView *lv=m_Control_comboEntryType.GetListViewPointer();

   //--- Set the list properties
   lv.LightsHover(true);
   if(entryType>-1 && entryType <3)
      lv.SelectedItemByIndex(entryType);
   else
      lv.SelectedItemByIndex(1);

   //--- Create a control
   if(!m_Control_comboEntryType.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_Control_comboEntryType);
   return(true);
}

//+------------------------------------------------------------------+
//| Create combo box trade direction
//+------------------------------------------------------------------+
bool CProgram::Control_CreateComboDirection(const string text)
{
   #define comboItems 2
   string directionList[comboItems]={"LONG","SHORT"};

   //--- Store pointer to the form
   m_Control_comboDirection.WindowPointer(m_window1);
      
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(3,m_Control_comboDirection);   
     
   //--- Coordinates
   int x=m_window1.X()+CTRL_COMBOBOX2_GAP_X;
   int y=m_window1.Y()+CTRL_COMBOBOX2_GAP_Y;
   
   //--- Set up properties before creation
   m_Control_comboDirection.XSize(180);
   m_Control_comboDirection.YSize(18);
   m_Control_comboDirection.LabelText(text);
   m_Control_comboDirection.ButtonXSize(100);
   m_Control_comboDirection.AreaColor(clrWhiteSmoke);
   m_Control_comboDirection.LabelColor(clrBlack);
   m_Control_comboDirection.LabelColorHover(clrCornflowerBlue);
   m_Control_comboDirection.ButtonBackColor(C'206,206,206');
   m_Control_comboDirection.ButtonBackColorHover(C'193,218,255');
   m_Control_comboDirection.ButtonBorderColor(C'150,170,180');
   m_Control_comboDirection.ButtonBorderColorOff(C'178,195,207');
   m_Control_comboDirection.ItemsTotal(comboItems);
   m_Control_comboDirection.VisibleItemsTotal(comboItems);
   
   //--- Store the item values to the combo box list
   for(int i=0; i<comboItems; i++)
      m_Control_comboDirection.ValueToList(i,directionList[i]);
   
   //--- Get the list pointer
   CListView *lv=m_Control_comboDirection.GetListViewPointer();

   //--- Set the list properties
   lv.LightsHover(true);
   switch(tradeDirection)
   {
      case -1: lv.SelectedItemByIndex(1);
        break;
      case  1: lv.SelectedItemByIndex(0);       
        break;
      default: lv.SelectedItemByIndex(0);
        break;
     }

   //--- Create a control
   if(!m_Control_comboDirection.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_Control_comboDirection);
   return(true);
}

//+------------------------------------------------------------------+
//| Creates entry price edit field                                                  |
//+------------------------------------------------------------------+
bool CProgram::Control_CreateEntryPrice(string text)
{
   //--- Store the window pointer
   m_Control_editEntryprice.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(3,m_Control_editEntryprice);      
   
   //--- Coordinates
   int x=m_window1.X()+CTRL_SPINEDIT1_GAP_X;
   int y=m_window1.Y()+CTRL_SPINEDIT1_GAP_Y;
   //--- Value

   double eValue = fn_GetEntryPrice(entryPrice,tradeDirection,entryType);   

   //--- Set properties before creation
   m_Control_editEntryprice.XSize(150);
   m_Control_editEntryprice.YSize(18);
   m_Control_editEntryprice.EditXSize(76);
   m_Control_editEntryprice.MaxValue(100000);
   m_Control_editEntryprice.MinValue(0);
   m_Control_editEntryprice.StepValue(0.0001);
   m_Control_editEntryprice.SetDigits(4);
   m_Control_editEntryprice.SetValue(eValue);
   m_Control_editEntryprice.ResetMode(false);
   m_Control_editEntryprice.AreaColor(clrWhiteSmoke);
   m_Control_editEntryprice.LabelColor(clrBlack);
   m_Control_editEntryprice.LabelColorLocked(clrSilver);
   m_Control_editEntryprice.EditColorLocked(clrWhiteSmoke);
   m_Control_editEntryprice.EditTextColor(clrBlack);
   m_Control_editEntryprice.EditTextColorLocked(clrSilver);
   m_Control_editEntryprice.EditBorderColor(clrSilver);
   m_Control_editEntryprice.EditBorderColorLocked(clrSilver);
   
   //--- Create control
   if(!m_Control_editEntryprice.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
   
   //--- The availability will depend on the current state of the first checkbox
   if(m_Control_comboEntryType.ButtonText()=="IMMEDIATE")
      m_Control_editEntryprice.SpinEditState(false);
   else
      m_Control_editEntryprice.SpinEditState(true);
      
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_Control_editEntryprice);

   return(true);
}

//+------------------------------------------------------------------+
//| Creates lot size edit field                                                  |
//+------------------------------------------------------------------+
bool CProgram::Control_CreateLotSize(const string text)
{
   //--- Store the window pointer
   m_Control_editLotSize.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(3,m_Control_editLotSize);      
   
   //--- Coordinates
   int x=m_window1.X()+CTRL_SPINEDIT2_GAP_X;
   int y=m_window1.Y()+CTRL_SPINEDIT2_GAP_Y;
   //--- Value

   
   double eValue = (lotSize < 0) ? 0.01 : lotSize;

   //--- Set properties before creation
   m_Control_editLotSize.XSize(150);
   m_Control_editLotSize.YSize(18);
   m_Control_editLotSize.EditXSize(76);
   m_Control_editLotSize.MaxValue(50);
   m_Control_editLotSize.MinValue(0.01);
   m_Control_editLotSize.StepValue(0.01);
   m_Control_editLotSize.SetDigits(2);
   m_Control_editLotSize.SetValue(eValue);
   m_Control_editLotSize.ResetMode(false);
   m_Control_editLotSize.AreaColor(clrWhiteSmoke);
   m_Control_editLotSize.LabelColor(clrBlack);
   m_Control_editLotSize.LabelColorLocked(clrSilver);
   m_Control_editLotSize.EditColorLocked(clrWhiteSmoke);
   m_Control_editLotSize.EditTextColor(clrBlack);
   m_Control_editLotSize.EditTextColorLocked(clrSilver);
   m_Control_editLotSize.EditBorderColor(clrSilver);
   m_Control_editLotSize.EditBorderColorLocked(clrSilver);
   
   
   //--- Create control
   if(!m_Control_editLotSize.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
         
   //--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_Control_editLotSize);

   return(true);
}

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
   m_Config_ButtonsGroup.WindowPointer(m_window1);
   //--- Attach to the first tab of the first group of tabs - Config tab
   m_tabs.AddToElementsArray(3,m_Config_ButtonsGroup);     
   
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
   m_Config_ButtonsGroup.ButtonsYSize(85);
   m_Config_ButtonsGroup.IconXGap(14);
   m_Config_ButtonsGroup.IconYGap(5);
   m_Config_ButtonsGroup.LabelXGap(15);
   m_Config_ButtonsGroup.LabelYGap(69);
   m_Config_ButtonsGroup.BackColor(clrLightGray);
   m_Config_ButtonsGroup.BackColorHover(C'193,218,255');
   m_Config_ButtonsGroup.BackColorPressed(C'190,190,200');
   m_Config_ButtonsGroup.BorderColor(C'150,170,180');
   m_Config_ButtonsGroup.BorderColorOff(C'178,195,207');

   //--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_Config_ButtonsGroup.AddButton(buttons_x_gap[i],buttons_y_gap[i],buttons_text[i],buttons_width[i],items_bmp_on[i],items_bmp_off[i]);

   //--- Create a group of buttons
   if(!m_Config_ButtonsGroup.CreateIconButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);

   //--- Select the STOP button and set the default status is STOP
   m_Config_ButtonsGroup.SelectedRadioButton(2);
   //CTRL_Status=STOP;

   //--- Lock the group of buttons
   //m_Config_ButtonsGroup.IconButtonsState(false);

   //--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_Config_ButtonsGroup);
   
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
      m_Control_editLotSize.SpinEditState(!lockStatus);
      m_Control_editEntryprice.SpinEditState(!lockStatus);
      m_Control_comboDirection.ComboBoxState(!lockStatus);
      m_Control_comboEntryType.ComboBoxState(!lockStatus);
   }else{
      m_Control_editLotSize.SpinEditState(!lockStatus);
   }
   
   return(true);
}