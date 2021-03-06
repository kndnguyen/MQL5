//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- Form 1
   CWindow           m_window1;
   //--- Main menu and its context menus
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Combo boxes
   CComboBox         m_combobox1;
   CComboBox         m_combobox2;
   CComboBox         m_combobox3;
   CComboBox         m_combobox4;
   //--- Lists
   CListView         m_listview1;
   CListView         m_listview2;
   CListView         m_listview3;
   //--- Status Bar
   CStatusBar        m_status_bar;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Initialization/deinitialization
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Timer
   void              OnTimerEvent(void);
   //---
protected:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
public:
   //--- Creates a trading panel
   bool              CreateTradePanel(void);
   //---
private:
   //--- Form 1
   bool              CreateWindow1(const string text);

   //--- Main menu and its context menus
#define MENUBAR_GAP_X    (1)
#define MENUBAR_GAP_Y    (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Status Bar
#define STATUSBAR1_GAP_X         (1)
#define STATUSBAR1_GAP_Y         (227)
   bool              CreateStatusBar(void);
   //--- Combo Box 1
#define COMBOBOX1_GAP_X       (7)
#define COMBOBOX1_GAP_Y       (50)
   bool              CreateComboBox1(const string text);
   //--- Combo Box 2
#define COMBOBOX2_GAP_X       (160)
#define COMBOBOX2_GAP_Y       (50)
   bool              CreateComboBox2(const string text);
   //--- Combo Box 3
#define COMBOBOX3_GAP_X       (7)
#define COMBOBOX3_GAP_Y       (202)
   bool              CreateComboBox3(const string text);
   //--- Combo Box 4
#define COMBOBOX4_GAP_X       (160)
#define COMBOBOX4_GAP_Y       (202)
   bool              CreateComboBox4(const string text);
   //--- List 1
#define LISTVIEW1_GAP_X       (2)
#define LISTVIEW1_GAP_Y       (73)
   bool              CreateListView1(void);
   //--- List 2
#define LISTVIEW2_GAP_X       (103)
#define LISTVIEW2_GAP_Y       (73)
   bool              CreateListView2(void);
   //--- List 3
#define LISTVIEW3_GAP_X       (204)
#define LISTVIEW3_GAP_Y       (73)
   bool              CreateListView3(void);
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
//| Deinitialization                                                 |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
  {
//--- Deleting the interface
   CWndEvents::Destroy();
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
  {
   CWndEvents::OnTimerEvent();
//--- The second item of the status bar will be updated every 500 milliseconds
   static int count=0;
   if(count<500)
     {
      count+=TIMER_STEP_MSC;
      return;
     }
//--- Reset counter
   count=0;
//--- Change the value in the second item of the status bar
   m_status_bar.ValueToItem(1,TimeToString(TimeLocal(),TIME_DATE|TIME_SECONDS));
//--- Redraw the chart
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Menu item click event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- List item click event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LIST_ITEM)
     {
      if(lparam==m_listview1.Id())
         ::Print(__FUNCTION__," > This is a message from the first list > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      else if(lparam==m_listview2.Id())
         ::Print(__FUNCTION__," > This is a message from the second list > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      else if(lparam==m_listview3.Id())
         ::Print(__FUNCTION__," > This is a message from the third list > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- Combo box item selection event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      if(sparam==m_combobox1.LabelText())
         ::Print(__FUNCTION__," > This is a message from the first combo box > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      else if(sparam==m_combobox2.LabelText())
         ::Print(__FUNCTION__," > This is a message from the second combo box > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      //--- Handle the message from the third combo box
      else if(sparam==m_combobox3.LabelText())
        {
         ::Print(__FUNCTION__," > This is a message from the third combo box > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
         //--- If the specified vale is selected, disable the fourth combo box
         if(m_combobox3.ButtonText()=="FALSE")
            m_combobox4.ComboBoxState(false);
         //--- If a different value is selected, enable the fourth combo box
         else
            m_combobox4.ComboBoxState(true);
        }
      else if(sparam==m_combobox4.LabelText())
         ::Print(__FUNCTION__," > This is a message from the fourth combo box > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
  }
//+------------------------------------------------------------------+
//| Creates a trading panel                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateTradePanel(void)
  {
//--- Creating form 1 for controls
   if(!CreateWindow1("EXPERT PANEL"))
      return(false);
//--- Creating controls:
//    Main menu
   if(!CreateMenuBar())
      return(false);
//--- Context menus
   if(!CreateMBContextMenu1())
      return(false);
   if(!CreateMBContextMenu2())
      return(false);
   if(!CreateMBContextMenu3())
      return(false);
   if(!CreateMBContextMenu4())
      return(false);
//--- Creating status bar
   if(!CreateStatusBar())
      return(false);
//--- Combo boxes
   if(!CreateComboBox1("Combobox 1:"))
      return(false);
   if(!CreateComboBox2("Combobox 2:"))
      return(false);
   if(!CreateComboBox3("Combobox 3:"))
      return(false);
   if(!CreateComboBox4("Combobox 4:"))
      return(false);
//--- Lists
   if(!CreateListView1())
      return(false);
   if(!CreateListView2())
      return(false);
   if(!CreateListView3())
      return(false);
//--- Redrawing of the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Create form 1 for controls                                       |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow1(const string caption_text)
  {
//--- Add a window pointer to the window array
   CWndContainer::AddWindow(m_window1);
//--- Coordinates
   int x=(m_window1.X()>0) ? m_window1.X() : 1;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 20;
//--- Properties
   m_window1.Movable(true);
   m_window1.XSize(306);
   m_window1.YSize(252);
   m_window1.WindowBgColor(clrWhiteSmoke);
   m_window1.WindowBorderColor(clrLightSteelBlue);
   m_window1.CaptionBgColor(clrLightSteelBlue);
   m_window1.CaptionBgColorHover(clrLightSteelBlue);
//--- Creating a form
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the main menu                                            |
//+------------------------------------------------------------------+
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
   int    width[MENUBAR_TOTAL] ={50,55,53};
   string text[MENUBAR_TOTAL]  ={"File","View","Help"};
//--- Properties
   m_menubar.MenuBackColor(C'225,225,225');
   m_menubar.MenuBorderColor(C'225,225,225');
   m_menubar.ItemBackColor(C'225,225,225');
   m_menubar.ItemBorderColor(C'225,225,225');
//--- Add items to the main menu
   for(int i=0; i<MENUBAR_TOTAL; i++)
      m_menubar.AddItem(width[i],text[i]);
//--- Create a control
   if(!m_menubar.CreateMenuBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menubar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
//---
bool CProgram::CreateMBContextMenu1(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS1 3
//--- Store the window pointer
   m_mb_contextmenu1.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu1.PrevNodePointer(m_menubar.ItemPointerByIndex(0));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(0,m_mb_contextmenu1);
//--- Array of item names
   string items_text[CONTEXTMENU_ITEMS1]=
     {
      "ContextMenu 1 Item 1",
      "ContextMenu 1 Item 2",
      "ContextMenu 1 Item 3..."
     };
//--- Label array for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- Label array for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE
     };
//--- Set up properties before creation
   m_mb_contextmenu1.FixSide(FIX_BOTTOM);
   m_mb_contextmenu1.XSize(160);
   m_mb_contextmenu1.AreaBackColor(C'240,240,240');
   m_mb_contextmenu1.AreaBorderColor(clrSilver);
   m_mb_contextmenu1.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu1.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu1.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu1.LabelColor(clrBlack);
   m_mb_contextmenu1.LabelColorHover(clrWhite);
   m_mb_contextmenu1.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu1.SeparateLineLightColor(clrWhite);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS1; i++)
      m_mb_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu1.AddSeparateLine(1);
//--- Deactivate the second item
   m_mb_contextmenu1.ItemPointerByIndex(1).ItemState(false);
//--- Create a context menu
   if(!m_mb_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu2(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS2 3
//--- Store the window pointer
   m_mb_contextmenu2.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu2.PrevNodePointer(m_menubar.ItemPointerByIndex(1));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(1,m_mb_contextmenu2);
//--- Array of item names
   string items_text[CONTEXTMENU_ITEMS2]=
     {
      "ContextMenu 2 Item 1",
      "ContextMenu 2 Item 2",
      "ContextMenu 2 Item 3"
     };
//--- Label array for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Label array for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS2]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set up properties before creation
   m_mb_contextmenu2.FixSide(FIX_BOTTOM);
   m_mb_contextmenu2.XSize(160);
   m_mb_contextmenu2.AreaBackColor(C'240,240,240');
   m_mb_contextmenu2.AreaBorderColor(clrSilver);
   m_mb_contextmenu2.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu2.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu2.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu2.LabelColor(clrBlack);
   m_mb_contextmenu2.LabelColorHover(clrWhite);
   m_mb_contextmenu2.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu2.SeparateLineLightColor(clrWhite);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS2; i++)
      m_mb_contextmenu2.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu2.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu2.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp"
//---
bool CProgram::CreateMBContextMenu3(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS3 5
//--- Store the window pointer
   m_mb_contextmenu3.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu3.PrevNodePointer(m_menubar.ItemPointerByIndex(2));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(2,m_mb_contextmenu3);
//--- Array of item names
   string items_text[CONTEXTMENU_ITEMS3]=
     {
      "ContextMenu 3 Item 1",
      "ContextMenu 3 Item 2",
      "ContextMenu 3 Item 3...",
      "ContextMenu 3 Item 4",
      "ContextMenu 3 Item 5"
     };
//--- Label array for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp",
      "",""
     };
//--- Label array for the blocked mode 
   string items_bmp_off[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS3]=
     {
      MI_SIMPLE,
      MI_HAS_CONTEXT_MENU,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set up properties before creation
   m_mb_contextmenu3.FixSide(FIX_BOTTOM);
   m_mb_contextmenu3.XSize(160);
   m_mb_contextmenu3.AreaBackColor(C'240,240,240');
   m_mb_contextmenu3.AreaBorderColor(clrSilver);
   m_mb_contextmenu3.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu3.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu3.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu3.LabelColor(clrBlack);
   m_mb_contextmenu3.LabelColorHover(clrWhite);
   m_mb_contextmenu3.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu3.SeparateLineLightColor(clrWhite);
   m_mb_contextmenu3.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp");
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS3; i++)
      m_mb_contextmenu3.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the third item
   m_mb_contextmenu3.AddSeparateLine(2);
//--- Create a context menu
   if(!m_mb_contextmenu3.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu4(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS4 3
//--- Store the window pointer
   m_mb_contextmenu4.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu4.PrevNodePointer(m_mb_contextmenu3.ItemPointerByIndex(1));
//--- Array of item names
   string items_text[CONTEXTMENU_ITEMS4]=
     {
      "ContextMenu 4 Item 1",
      "ContextMenu 4 Item 2",
      "ContextMenu 4 Item 3"
     };
//--- Label array for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Label array for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS4]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set up properties before creation
   m_mb_contextmenu4.XSize(160);
   m_mb_contextmenu4.AreaBackColor(C'240,240,240');
   m_mb_contextmenu4.AreaBorderColor(clrSilver);
   m_mb_contextmenu4.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu4.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu4.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu4.LabelColor(clrBlack);
   m_mb_contextmenu4.LabelColorHover(clrWhite);
   m_mb_contextmenu4.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu4.SeparateLineLightColor(clrWhite);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS4; i++)
      m_mb_contextmenu4.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu4.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu4.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create status bar                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateStatusBar(void)
  {
#define STATUS_LABELS_TOTAL 2
//--- Store the window pointer
   m_status_bar.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+STATUSBAR1_GAP_X;
   int y=m_window1.Y()+STATUSBAR1_GAP_Y;
//--- Width
   int width[]={0,110};
//--- Set up properties before creation
   m_status_bar.YSize(24);
   m_status_bar.AreaColor(C'225,225,225');
   m_status_bar.AreaBorderColor(C'225,225,225');
//--- Specify the required number of parts and set their properties
   for(int i=0; i<STATUS_LABELS_TOTAL; i++)
      m_status_bar.AddItem(width[i]);
//--- Create a control
   if(!m_status_bar.CreateStatusBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Set the text in the first item of the status bar
   m_status_bar.ValueToItem(0,"For Help, press F1");
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create combo box 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBox1(const string text)
  {
//--- Total number of items in the list
#define ITEMS_TOTAL1 8
//--- Pass the object to the panel
   m_combobox1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COMBOBOX1_GAP_X;
   int y=m_window1.Y()+COMBOBOX1_GAP_Y;
//--- Array of list item values
   string items_text[ITEMS_TOTAL1]={"FALSE","item 1","item 2","item 3","item 4","item 5","item 6","item 7"};
//--- Set up properties before creation
   m_combobox1.XSize(140);
   m_combobox1.YSize(18);
   m_combobox1.LabelText(text);
   m_combobox1.ButtonXSize(70);
   m_combobox1.AreaColor(clrWhiteSmoke);
   m_combobox1.LabelColor(clrBlack);
   m_combobox1.LabelColorHover(clrCornflowerBlue);
   m_combobox1.ButtonBackColor(C'206,206,206');
   m_combobox1.ButtonBackColorHover(C'193,218,255');
   m_combobox1.ButtonBorderColor(C'150,170,180');
   m_combobox1.ButtonBorderColorOff(C'178,195,207');
   m_combobox1.ItemsTotal(ITEMS_TOTAL1);
   m_combobox1.VisibleItemsTotal(5);
//--- Store the item values to the combo box list
   for(int i=0; i<ITEMS_TOTAL1; i++)
      m_combobox1.ValueToList(i,items_text[i]);
//--- Get the list pointer
   CListView *lv=m_combobox1.GetListViewPointer();
//--- Set the list properties
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 2 : lv.SelectedItemIndex());
//--- Create a control
   if(!m_combobox1.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_combobox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create combo box 2                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBox2(const string text)
  {
//--- Total number of items in the list
#define ITEMS_TOTAL2 8
//--- Pass the object to the panel
   m_combobox2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COMBOBOX2_GAP_X;
   int y=m_window1.Y()+COMBOBOX2_GAP_Y;
//--- Array of list item values
   string items_text[ITEMS_TOTAL2]={"FALSE","item 1","item 2","item 3","item 4","item 5","item 6","item 7"};
//--- Set up properties before creation
   m_combobox2.XSize(140);
   m_combobox2.YSize(18);
   m_combobox2.LabelText(text);
   m_combobox2.ButtonXSize(70);
   m_combobox2.AreaColor(clrWhiteSmoke);
   m_combobox2.LabelColor(clrBlack);
   m_combobox1.LabelColorHover(clrCornflowerBlue);
   m_combobox2.ButtonBackColor(C'206,206,206');
   m_combobox2.ButtonBackColorHover(C'193,218,255');
   m_combobox2.ButtonBorderColor(C'150,170,180');
   m_combobox2.ButtonBorderColorOff(C'178,195,207');
   m_combobox2.ItemsTotal(ITEMS_TOTAL2);
   m_combobox2.VisibleItemsTotal(5);
//--- Store the item values to the combo box list
   for(int i=0; i<ITEMS_TOTAL2; i++)
      m_combobox2.ValueToList(i,items_text[i]);
//--- Get the list pointer
   CListView *lv=m_combobox2.GetListViewPointer();
//--- Set the list properties
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 5 : lv.SelectedItemIndex());
//--- Create a control
   if(!m_combobox2.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_combobox2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create combo box 3                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBox3(const string text)
  {
//--- Total number of items in the list
#define ITEMS_TOTAL3 8
//--- Pass the object to the panel
   m_combobox3.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COMBOBOX3_GAP_X;
   int y=m_window1.Y()+COMBOBOX3_GAP_Y;
//--- Array of list item values
   string items_text[ITEMS_TOTAL3]={"FALSE","item 1","item 2","item 3","item 4","item 5","item 6","item 7"};
//--- Set up properties before creation
   m_combobox3.XSize(140);
   m_combobox3.YSize(18);
   m_combobox3.LabelText(text);
   m_combobox3.ButtonXSize(70);
   m_combobox3.AreaColor(clrWhiteSmoke);
   m_combobox3.LabelColor(clrBlack);
   m_combobox3.LabelColorOff(clrLightGray);
   m_combobox3.LabelColorHover(clrCornflowerBlue);
   m_combobox3.ButtonBackColor(C'206,206,206');
   m_combobox3.ButtonBackColorHover(C'193,218,255');
   m_combobox3.ButtonBorderColor(C'150,170,180');
   m_combobox3.ButtonBorderColorOff(C'178,195,207');
   m_combobox3.ItemsTotal(ITEMS_TOTAL3);
   m_combobox3.VisibleItemsTotal(5);
//--- Store the item values to the combo box list
   for(int i=0; i<ITEMS_TOTAL3; i++)
      m_combobox3.ValueToList(i,items_text[i]);
//--- Get the list pointer
   CListView *lv=m_combobox3.GetListViewPointer();
//--- Set the list properties
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 0 : lv.SelectedItemIndex());
//--- Create a control
   if(!m_combobox3.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_combobox3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create combo box 4                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBox4(const string text)
  {
//--- Total number of items in the list
#define ITEMS_TOTAL4 8
//--- Pass the object to the panel
   m_combobox4.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COMBOBOX4_GAP_X;
   int y=m_window1.Y()+COMBOBOX4_GAP_Y;
//--- Array of list item values
   string items_text[ITEMS_TOTAL4]={"FALSE","item 1","item 2","item 3","item 4","item 5","item 6","item 7"};
//--- Set up properties before creation
   m_combobox4.XSize(140);
   m_combobox4.YSize(18);
   m_combobox4.LabelText(text);
   m_combobox4.ButtonXSize(70);
   m_combobox4.AreaColor(clrWhiteSmoke);
   m_combobox4.LabelColor(clrBlack);
   m_combobox4.LabelColorHover(clrCornflowerBlue);
   m_combobox4.ButtonBackColor(C'206,206,206');
   m_combobox4.ButtonBackColorHover(C'193,218,255');
   m_combobox4.ButtonBorderColor(C'150,170,180');
   m_combobox4.ButtonBorderColorOff(C'178,195,207');
   m_combobox4.ItemsTotal(ITEMS_TOTAL4);
   m_combobox4.VisibleItemsTotal(5);
//--- Store the item values to the combo box list
   for(int i=0; i<ITEMS_TOTAL4; i++)
      m_combobox4.ValueToList(i,items_text[i]);
//--- Get the list pointer
   CListView *lv=m_combobox4.GetListViewPointer();
//--- Set the list properties
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 4 : lv.SelectedItemIndex());
//--- Create a control
   if(!m_combobox4.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- Lock the combo box
   m_combobox4.ComboBoxState(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_combobox4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create list 1                                                    |
//+------------------------------------------------------------------+
bool CProgram::CreateListView1(void)
  {
//--- List size
#define ITEMS_TOTAL5 20
//--- Store the window pointer
   m_listview1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+LISTVIEW1_GAP_X;
   int y=m_window1.Y()+LISTVIEW1_GAP_Y;
//--- Set up properties before creation
   m_listview1.XSize(100);
   m_listview1.LightsHover(true);
   m_listview1.ListSize(ITEMS_TOTAL5);
   m_listview1.VisibleListSize(7);
   m_listview1.AreaBorderColor(C'150,170,180');
   m_listview1.SelectedItemByIndex(5);
//--- Get the scrollbar pointer
   CScrollV *sv=m_listview1.GetScrollVPointer();
//--- Scrollbar properties
   sv.ThumbBorderColor(C'190,190,190');
   sv.ThumbBorderColorHover(C'180,180,180');
   sv.ThumbBorderColorPressed(C'160,160,160');
//--- Populate the list
   for(int r=0; r<ITEMS_TOTAL5; r++)
      m_listview1.ValueToList(r,"SYMBOL "+string(r));
//--- Create a list
   if(!m_listview1.CreateListView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_listview1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create list 2                                                    |
//+------------------------------------------------------------------+
bool CProgram::CreateListView2(void)
  {
//--- List size
#define ITEMS_TOTAL6 20
//--- Store the window pointer
   m_listview2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+LISTVIEW2_GAP_X;
   int y=m_window1.Y()+LISTVIEW2_GAP_Y;
//--- Set up properties before creation
   m_listview2.XSize(100);
   m_listview2.LightsHover(true);
   m_listview2.ListSize(ITEMS_TOTAL6);
   m_listview2.VisibleListSize(7);
   m_listview2.AreaBorderColor(C'150,170,180');
   m_listview2.SelectedItemByIndex(1);
//--- Get the scrollbar pointer
   CScrollV *sv=m_listview2.GetScrollVPointer();
//--- Scrollbar properties
   sv.ThumbBorderColor(C'190,190,190');
   sv.ThumbBorderColorHover(C'180,180,180');
   sv.ThumbBorderColorPressed(C'160,160,160');
//--- Populate the list
   for(int r=0; r<ITEMS_TOTAL6; r++)
      m_listview2.ValueToList(r,"SYMBOL "+string(r));
//--- Create a list
   if(!m_listview2.CreateListView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_listview2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create list 3                                                    |
//+------------------------------------------------------------------+
bool CProgram::CreateListView3(void)
  {
//--- List size
#define ITEMS_TOTAL7 20
//--- Store the window pointer
   m_listview3.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+LISTVIEW3_GAP_X;
   int y=m_window1.Y()+LISTVIEW3_GAP_Y;
//--- Set up properties before creation
   m_listview3.XSize(100);
   m_listview3.LightsHover(true);
   m_listview3.ListSize(ITEMS_TOTAL7);
   m_listview3.VisibleListSize(7);
   m_listview3.AreaBorderColor(C'150,170,180');
   m_listview3.SelectedItemByIndex(4);
//--- Get the scrollbar pointer
   CScrollV *sv=m_listview3.GetScrollVPointer();
//--- Scrollbar properties
   sv.ThumbBorderColor(C'190,190,190');
   sv.ThumbBorderColorHover(C'180,180,180');
   sv.ThumbBorderColorPressed(C'160,160,160');
//--- Populate the list
   for(int r=0; r<ITEMS_TOTAL7; r++)
      m_listview3.ValueToList(r,"SYMBOL "+string(r));
//--- Create a list
   if(!m_listview3.CreateListView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_listview3);
   return(true);
  }
//+------------------------------------------------------------------+
