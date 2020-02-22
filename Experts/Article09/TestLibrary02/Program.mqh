//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//+------------------------------------------------------------------+
//| ����� ��� �������� ����������                                    |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- �����
   CWindow           m_window1;
   //--- ������� ���� � ��� ����������� ����
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- ��������� ������
   CStatusBar        m_status_bar;
   //--- ��������
   CSlider           m_slider1;
   //--- ���������� ����������
   CProgressBar      m_progress_bar1;
   CProgressBar      m_progress_bar2;
   CProgressBar      m_progress_bar3;
   CProgressBar      m_progress_bar4;
   CProgressBar      m_progress_bar5;
   CProgressBar      m_progress_bar6;
   CProgressBar      m_progress_bar7;
   CProgressBar      m_progress_bar8;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- �������������/���������������
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- ������
   void              OnTimerEvent(void);
   //---
protected:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
public:
   //--- ������ ���������� ������
   bool              CreateExpertPanel(void);
   //---
private:
   //--- ����� 1
   bool              CreateWindow1(const string text);

   //--- ������� ���� � ��� ����������� ����
#define MENUBAR_GAP_X         (1)
#define MENUBAR_GAP_Y         (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- ��������� ������
#define STATUSBAR1_GAP_X      (1)
#define STATUSBAR1_GAP_Y      (300)
   bool              CreateStatusBar(void);
   //--- ��������
#define SLIDER1_GAP_X         (7)
#define SLIDER1_GAP_Y         (50)
   bool              CreateSlider1(const string text);
//---
#define PROGRESSBAR1_GAP_X    (7)
#define PROGRESSBAR1_GAP_Y    (100)
   bool              CreateProgressBar1(void);
//---
#define PROGRESSBAR2_GAP_X    (7)
#define PROGRESSBAR2_GAP_Y    (125)
   bool              CreateProgressBar2(void);
//---
#define PROGRESSBAR3_GAP_X    (7)
#define PROGRESSBAR3_GAP_Y    (150)
   bool              CreateProgressBar3(void);
//---
#define PROGRESSBAR4_GAP_X    (7)
#define PROGRESSBAR4_GAP_Y    (175)
   bool              CreateProgressBar4(void);
//---
#define PROGRESSBAR5_GAP_X    (7)
#define PROGRESSBAR5_GAP_Y    (200)
   bool              CreateProgressBar5(void);
//---
#define PROGRESSBAR6_GAP_X    (7)
#define PROGRESSBAR6_GAP_Y    (225)
   bool              CreateProgressBar6(void);
//---
#define PROGRESSBAR7_GAP_X    (7)
#define PROGRESSBAR7_GAP_Y    (250)
   bool              CreateProgressBar7(void);
//---
#define PROGRESSBAR8_GAP_X    (7)
#define PROGRESSBAR8_GAP_Y    (275)
   bool              CreateProgressBar8(void);
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
//| �������������                                                    |
//+------------------------------------------------------------------+
void CProgram::OnInitEvent(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������������                                                  |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
  {
//--- �������� ����������
   CWndEvents::Destroy();
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
  {
   CWndEvents::OnTimerEvent();
//--- ���������� ��������
   int total=(int)m_slider1.GetValue();
//--- ������ �������� �����
   static int count1=0;
   count1=(count1>=total) ? 0 : count1+=8;
   m_progress_bar1.Update(count1,total);
//---
   static int count2=0;
   count2=(count2>=total) ? 0 : count2+=3;
   m_progress_bar2.Update(count2,total);
//---
   static int count3=0;
   count3=(count3>=total) ? 0 : count3+=12;
   m_progress_bar3.Update(count3,total);
//---
   static int count4=0;
   count4=(count4>=total) ? 0 : count4+=6;
   m_progress_bar4.Update(count4,total);
//---
   static int count5=0;
   count5=(count5>=total) ? 0 : count5+=18;
   m_progress_bar5.Update(count5,total);
//---
   static int count6=0;
   count6=(count6>=total) ? 0 : count6+=10;
   m_progress_bar6.Update(count6,total);
//---
   static int count7=0;
   count7=(count7>=total) ? 0 : count7+=1;
   m_progress_bar7.Update(count7,total);
//---
   static int count8=0;
   count8=(count8>=total) ? 0 : count8+=15;
   m_progress_bar8.Update(count8,total);
   
//--- ������ ��� ��������� ������
   static int count9=0;
   if(count9<TIMER_STEP_MSC*10)
     {
      count9+=TIMER_STEP_MSC;
      return;
     }
   count9=0;
   m_status_bar.ValueToItem(1,::TimeToString(::TimeLocal(),TIME_DATE|TIME_SECONDS));
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ������� ������� �� ������ ����
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
  }
//+------------------------------------------------------------------+
//| ������ ���������� ������                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(void)
  {
//--- �������� ����� ��� ��������� ����������
   if(!CreateWindow1("EXPERT PANEL"))
      return(false);
//--- �������� ��������� ����������:
//    ������� ����
   if(!CreateMenuBar())
      return(false);
//--- ����������� ����
   if(!CreateMBContextMenu1())
      return(false);
   if(!CreateMBContextMenu2())
      return(false);
   if(!CreateMBContextMenu3())
      return(false);
   if(!CreateMBContextMenu4())
      return(false);
//--- ��������� ������
   if(!CreateStatusBar())
      return(false);

//--- ��������
   if(!CreateSlider1("Iterations total:"))
      return(false);
//---
   if(!CreateProgressBar1())
      return(false);
   if(!CreateProgressBar2())
      return(false);
   if(!CreateProgressBar3())
      return(false);
   if(!CreateProgressBar4())
      return(false);
   if(!CreateProgressBar5())
      return(false);
   if(!CreateProgressBar6())
      return(false);
   if(!CreateProgressBar7())
      return(false);
   if(!CreateProgressBar8())
      return(false);
      
//--- ����������� �������
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� ��������� ����������                           |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow1(const string caption_text)
  {
//--- ������� ��������� ���� � ������ ����
   CWndContainer::AddWindow(m_window1);
//--- ����������
   int x=(m_window1.X()>0) ? m_window1.X() : 1;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 1;
//--- ��������
   m_window1.Movable(true);
   m_window1.XSize(237);
   m_window1.YSize(325);
   m_window1.WindowBgColor(clrWhiteSmoke);
   m_window1.WindowBorderColor(clrLightSteelBlue);
   m_window1.CaptionBgColor(clrLightSteelBlue);
   m_window1.CaptionBgColorHover(clrLightSteelBlue);
//--- �������� �����
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ����                                             |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuBar(void)
  {
//--- ��� ������ � ������� ����
#define MENUBAR_TOTAL 3
//--- �������� ��������� �� ����
   m_menubar.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+MENUBAR_GAP_X;
   int y=m_window1.Y()+MENUBAR_GAP_Y;
//--- ������� � ����������� ���������� �������
   int    width[MENUBAR_TOTAL] ={50,55,53};
   string text[MENUBAR_TOTAL]  ={"File","View","Help"};
//--- ��������
   m_menubar.MenuBackColor(C'225,225,225');
   m_menubar.MenuBorderColor(C'225,225,225');
   m_menubar.ItemBackColor(C'225,225,225');
   m_menubar.ItemBorderColor(C'225,225,225');
//--- �������� ������ � ������� ����
   for(int i=0; i<MENUBAR_TOTAL; i++)
      m_menubar.AddItem(width[i],text[i]);
//--- �������� ������� ����������
   if(!m_menubar.CreateMenuBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_menubar);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����������� ����                                         |
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
//--- ����� ������� � ����������� ����
#define CONTEXTMENU_ITEMS1 3
//--- �������� ��������� �� ����
   m_mb_contextmenu1.WindowPointer(m_window1);
//--- �������� ��������� �� ���������� ����
   m_mb_contextmenu1.PrevNodePointer(m_menubar.ItemPointerByIndex(0));
//--- ���������� ����������� ���� � ���������� ������ ����
   m_menubar.AddContextMenuPointer(0,m_mb_contextmenu1);
//--- ������ �������� �������
   string items_text[CONTEXTMENU_ITEMS1]=
     {
      "ContextMenu 1 Item 1",
      "ContextMenu 1 Item 2",
      "ContextMenu 1 Item 3..."
     };
//--- ������ ������� ��� ���������� ������
   string items_bmp_on[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- ������ ������� ��� ���������������� ������
   string items_bmp_off[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp"
     };
//--- ������ ����� �������
   ENUM_TYPE_MENU_ITEM items_type[]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE
     };
//--- ��������� �������� ����� ���������
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
//--- �������� ������ � ����������� ����
   for(int i=0; i<CONTEXTMENU_ITEMS1; i++)
      m_mb_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- �������������� ����� ����� ������� ������
   m_mb_contextmenu1.AddSeparateLine(1);
//--- �������������� ������ �����
   m_mb_contextmenu1.ItemPointerByIndex(1).ItemState(false);
//--- ������� ����������� ����
   if(!m_mb_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����������� ����                                         |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu2(void)
  {
//--- ����� ������� � ����������� ����
#define CONTEXTMENU_ITEMS2 3
//--- �������� ��������� �� ����
   m_mb_contextmenu2.WindowPointer(m_window1);
//--- �������� ��������� �� ���������� ����
   m_mb_contextmenu2.PrevNodePointer(m_menubar.ItemPointerByIndex(1));
//--- ���������� ����������� ���� � ���������� ������ ����
   m_menubar.AddContextMenuPointer(1,m_mb_contextmenu2);
//--- ������ �������� �������
   string items_text[CONTEXTMENU_ITEMS2]=
     {
      "ContextMenu 2 Item 1",
      "ContextMenu 2 Item 2",
      "ContextMenu 2 Item 3"
     };
//--- ������ ������� ��� ���������� ������
   string items_bmp_on[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- ������ ������� ��� ���������������� ������
   string items_bmp_off[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- ������ ����� �������
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS2]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- ��������� �������� ����� ���������
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
//--- �������� ������ � ����������� ����
   for(int i=0; i<CONTEXTMENU_ITEMS2; i++)
      m_mb_contextmenu2.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- �������������� ����� ����� ������� ������
   m_mb_contextmenu2.AddSeparateLine(1);
//--- ������� ����������� ����
   if(!m_mb_contextmenu2.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu2);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����������� ����                                         |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp"
//---
bool CProgram::CreateMBContextMenu3(void)
  {
//--- ���� ������� � ����������� ����
#define CONTEXTMENU_ITEMS3 5
//--- �������� ��������� �� ����
   m_mb_contextmenu3.WindowPointer(m_window1);
//--- �������� ��������� �� ���������� ����
   m_mb_contextmenu3.PrevNodePointer(m_menubar.ItemPointerByIndex(2));
//--- ���������� ����������� ���� � ���������� ������ ����
   m_menubar.AddContextMenuPointer(2,m_mb_contextmenu3);
//--- ������ �������� �������
   string items_text[CONTEXTMENU_ITEMS3]=
     {
      "ContextMenu 3 Item 1",
      "ContextMenu 3 Item 2",
      "ContextMenu 3 Item 3...",
      "ContextMenu 3 Item 4",
      "ContextMenu 3 Item 5"
     };
//--- ������ ������� ��� ���������� ������
   string items_bmp_on[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp",
      "",""
     };
//--- ������ ������� ��� ���������������� ������ 
   string items_bmp_off[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- ������ ����� �������
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS3]=
     {
      MI_SIMPLE,
      MI_HAS_CONTEXT_MENU,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- ��������� �������� ����� ���������
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
//--- �������� ������ � ����������� ����
   for(int i=0; i<CONTEXTMENU_ITEMS3; i++)
      m_mb_contextmenu3.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- �������������� ����� ����� �������� ������
   m_mb_contextmenu3.AddSeparateLine(2);
//--- ������� ����������� ����
   if(!m_mb_contextmenu3.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu3);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����������� ����                                         |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu4(void)
  {
//--- ����� ������� � ����������� ����
#define CONTEXTMENU_ITEMS4 3
//--- �������� ��������� �� ����
   m_mb_contextmenu4.WindowPointer(m_window1);
//--- �������� ��������� �� ���������� ����
   m_mb_contextmenu4.PrevNodePointer(m_mb_contextmenu3.ItemPointerByIndex(1));
//--- ������ �������� �������
   string items_text[CONTEXTMENU_ITEMS4]=
     {
      "ContextMenu 4 Item 1",
      "ContextMenu 4 Item 2",
      "ContextMenu 4 Item 3"
     };
//--- ������ ������� ��� ���������� ������
   string items_bmp_on[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- ������ ������� ��� ���������������� ������
   string items_bmp_off[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- ������ ����� �������
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS4]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- ��������� �������� ����� ���������
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
//--- �������� ������ � ����������� ����
   for(int i=0; i<CONTEXTMENU_ITEMS4; i++)
      m_mb_contextmenu4.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- �������������� ����� ����� ������� ������
   m_mb_contextmenu4.AddSeparateLine(1);
//--- ������� ����������� ����
   if(!m_mb_contextmenu4.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu4);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ������                                         |
//+------------------------------------------------------------------+
bool CProgram::CreateStatusBar(void)
  {
#define STATUS_LABELS_TOTAL 2
//--- �������� ��������� �� ����
   m_status_bar.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+STATUSBAR1_GAP_X;
   int y=m_window1.Y()+STATUSBAR1_GAP_Y;
//--- ������
   int width[]={0,110};
//--- ��������� �������� ����� ���������
   m_status_bar.YSize(24);
   m_status_bar.AreaColor(C'225,225,225');
   m_status_bar.AreaBorderColor(C'225,225,225');
//--- ������ ������� ������ ���� ������ � ��������� �� ��������
   for(int i=0; i<STATUS_LABELS_TOTAL; i++)
      m_status_bar.AddItem(width[i]);
//--- �������� ������� ����������
   if(!m_status_bar.CreateStatusBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ��������� ������ � ������ ����� ��������� ������
   m_status_bar.ValueToItem(0,"For Help, press F1");
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� 1                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateSlider1(const string text)
  {
//--- �������� ��������� �� ����
   m_slider1.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+SLIDER1_GAP_X;
   int y=m_window1.Y()+SLIDER1_GAP_Y;
//--- ��������
   double v=(m_slider1.GetValue()==WRONG_VALUE) ? 1000 : m_slider1.GetValue();
//--- ��������� �������� ����� ���������
   m_slider1.XSize(223);
   m_slider1.YSize(40);
   m_slider1.EditXSize(87);
   m_slider1.MaxValue(5000);
   m_slider1.StepValue(1);
   m_slider1.MinValue(100);
   m_slider1.SetDigits(0);
   m_slider1.SetValue(v);
   m_slider1.AreaColor(clrWhiteSmoke);
   m_slider1.LabelColor(clrBlack);
   m_slider1.LabelColorLocked(clrSilver);
   m_slider1.EditColorLocked(clrWhiteSmoke);
   m_slider1.EditBorderColor(clrSilver);
   m_slider1.EditBorderColorLocked(clrSilver);
   m_slider1.EditTextColorLocked(clrSilver);
   m_slider1.SlotLineDarkColor(clrSilver);
   m_slider1.SlotLineLightColor(clrWhite);
   m_slider1.SlotYSize(4);
   m_slider1.ThumbColorLocked(clrLightGray);
   m_slider1.ThumbColorPressed(clrSilver);
   m_slider1.SlotIndicatorColor(C'85,170,255');
   m_slider1.SlotIndicatorColorLocked(clrLightGray);
//--- �������� ��������
   if(!m_slider1.CreateSlider(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_slider1);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 1                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar1(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar1.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR1_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR1_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar1.XSize(220);
   m_progress_bar1.YSize(15);
   m_progress_bar1.BarXSize(123);
   m_progress_bar1.BarYSize(11);
   m_progress_bar1.BarXOffset(65);
   m_progress_bar1.BarYOffset(2);
   m_progress_bar1.LabelText("Progress 01:");
//--- �������� ��������
   if(!m_progress_bar1.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar1);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 2                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar2(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar2.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR2_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR2_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar2.XSize(220);
   m_progress_bar2.YSize(15);
   m_progress_bar2.BarXSize(123);
   m_progress_bar2.BarYSize(11);
   m_progress_bar2.BarXOffset(65);
   m_progress_bar2.BarYOffset(2);
   m_progress_bar2.BarBorderWidth(0);
   m_progress_bar2.LabelText("Progress 02:");
//--- �������� ��������
   if(!m_progress_bar2.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar2);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 3                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar3(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar3.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR3_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR3_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar3.XSize(220);
   m_progress_bar3.YSize(15);
   m_progress_bar3.BarXSize(123);
   m_progress_bar3.BarYSize(11);
   m_progress_bar3.BarXOffset(65);
   m_progress_bar3.BarYOffset(2);
   m_progress_bar3.BarBorderWidth(0);
   m_progress_bar3.LabelText("Progress 03:");
//--- �������� ��������
   if(!m_progress_bar3.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar3);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 4                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar4(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar4.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR4_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR4_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar4.XSize(220);
   m_progress_bar4.YSize(15);
   m_progress_bar4.BarXSize(123);
   m_progress_bar4.BarYSize(11);
   m_progress_bar4.BarXOffset(65);
   m_progress_bar4.BarYOffset(2);
   m_progress_bar4.BarBorderWidth(0);
   m_progress_bar4.LabelText("Progress 04:");
//--- �������� ��������
   if(!m_progress_bar4.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar4);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 5                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar5(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar5.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR5_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR5_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar5.XSize(220);
   m_progress_bar5.YSize(15);
   m_progress_bar5.BarXSize(123);
   m_progress_bar5.BarYSize(11);
   m_progress_bar5.BarXOffset(65);
   m_progress_bar5.BarYOffset(2);
   m_progress_bar5.BarBorderWidth(0);
   m_progress_bar5.LabelText("Progress 05:");
//--- �������� ��������
   if(!m_progress_bar5.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar5);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 6                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar6(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar6.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR6_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR6_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar6.XSize(220);
   m_progress_bar6.YSize(15);
   m_progress_bar6.BarXSize(123);
   m_progress_bar6.BarYSize(11);
   m_progress_bar6.BarXOffset(65);
   m_progress_bar6.BarYOffset(2);
   m_progress_bar6.BarBorderWidth(0);
   m_progress_bar6.LabelText("Progress 06:");
//--- �������� ��������
   if(!m_progress_bar6.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar6);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 7                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar7(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar7.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR7_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR7_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar7.XSize(220);
   m_progress_bar7.YSize(15);
   m_progress_bar7.BarXSize(123);
   m_progress_bar7.BarYSize(11);
   m_progress_bar7.BarXOffset(65);
   m_progress_bar7.BarYOffset(2);
   m_progress_bar7.BarBorderWidth(0);
   m_progress_bar7.LabelText("Progress 07:");
//--- �������� ��������
   if(!m_progress_bar7.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar7);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��� 8                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar8(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar8.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR8_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR8_GAP_Y;
//--- ��������� �������� ����� ���������
   m_progress_bar8.XSize(220);
   m_progress_bar8.YSize(15);
   m_progress_bar8.BarXSize(123);
   m_progress_bar8.BarYSize(11);
   m_progress_bar8.BarXOffset(65);
   m_progress_bar8.BarYOffset(2);
   m_progress_bar8.BarBorderWidth(0);
   m_progress_bar8.LabelText("Progress 08:");
//--- �������� ��������
   if(!m_progress_bar8.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar8);
   return(true);
  }
//+------------------------------------------------------------------+
