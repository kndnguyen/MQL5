//+------------------------------------------------------------------+
//|                                                    WndEvents.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Defines.mqh"
#include "WndContainer.mqh"
#include <Charts\Chart.mqh>
//+------------------------------------------------------------------+
//| ����� ��� ��������� �������                                      |
//+------------------------------------------------------------------+
class CWndEvents : public CWndContainer
  {
protected:
   CChart            m_chart;
   //--- ������������� � ����� ���� �������
   long              m_chart_id;
   int               m_subwin;
   //--- ��� ���������
   string            m_program_name;
   //--- �������� ��� ����������
   string            m_indicator_shortname;
   //--- ������ ��������� ����
   int               m_active_window_index;
   //---
private:
   //--- ��������� �������
   int               m_id;
   long              m_lparam;
   double            m_dparam;
   string            m_sparam;
   //---
protected:
                     CWndEvents(void);
                    ~CWndEvents(void);
   //--- ����������� ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- ������
   void              OnTimerEvent(void);
   //---
public:
   //--- ����������� ������� �������
   void              ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
private:
   void              ChartEventCustom(void);
   void              ChartEventClick(void);
   void              ChartEventMouseMove(void);
   void              ChartEventObjectClick(void);
   void              ChartEventEndEdit(void);
   void              ChartEventChartChange(void);
   //--- �������� ������� � ��������� ����������
   void              CheckElementsEvents(void);
   //--- ����������� ������ �������
   void              DetermineSubwindow(void);
   //--- �������� ������� ��������� ����������
   void              CheckSubwindowNumber(void);
   //--- ������������� ���������� �������
   void              InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam);
   //--- ����������� ����
   void              MovingWindow(void);
   //--- �������� ������� ���� ��������� �� �������
   void              CheckElementsEventsTimer(void);
   //--- ��������� ��������� �������
   void              SetChartState(void);
   //---
protected:
   //--- �������� ����������
   void              Destroy(void);
   //---
private:
   //--- ������������/�������������� �����
   bool              OnWindowRollUp(void);
   bool              OnWindowUnroll(void);
   //--- ������� ���� ����������� ���� �� ������ ����������
   bool              OnHideBackContextMenus(void);
   //--- ������� ���� ����������� ����
   bool              OnHideContextMenus(void);

   //--- �������� ����������� ����
   bool              OnOpenDialogBox(void);
   //--- �������� ����������� ����
   bool              OnCloseDialogBox(void);
   //--- ����� ����� ����� � � ���������
   bool              OnResetWindowColors(void);
   //--- ����� ����������� �� ������� ����� ������� ����
   bool              OnZeroPriorities(void);
   //--- �������������� ����������� �� ������� ����� ������� ����
   bool              OnSetPriorities(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CWndEvents::CWndEvents(void) : m_chart_id(0),
                               m_subwin(0),
                               m_active_window_index(0),
                               m_indicator_shortname(""),
                               m_program_name(PROGRAM_NAME)

  {
//--- ������� ������
   if(!::MQLInfoInteger(MQL_TESTER))
      ::EventSetMillisecondTimer(TIMER_STEP_MSC);
//--- ������� ID �������� �������
   m_chart.Attach();
//--- ������� �������� �� ��������� ����
   m_chart.EventMouseMove(true);
//--- ����������� ������ �������
   DetermineSubwindow();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CWndEvents::~CWndEvents(void)
  {
//--- ������� ������
   ::EventKillTimer();
//--- ������� ����������
   m_chart.MouseScroll(true);
   m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
//--- �������� �������� �� ��������� ����
   m_chart.EventMouseMove(false);
//--- ������������� �� �������
   m_chart.Detach();
//--- ������� �������   
   ::Comment("");
  }
//+------------------------------------------------------------------+
//| ������������� ���������� ����������                              |
//+------------------------------------------------------------------+
void CWndEvents::InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam)
  {
   m_id     =id;
   m_lparam =lparam;
   m_dparam =dparam;
   m_sparam =sparam;
  }
//+------------------------------------------------------------------+
//| ��������� ������� ���������                                      |
//+------------------------------------------------------------------+
void CWndEvents::ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ���� ������ ����, ������
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- ������������� ����� ���������� �������
   InitChartEventsParams(id,lparam,dparam,sparam);
//--- ���������������� �������
   ChartEventCustom();
//--- �������� ������� ��������� ����������
   CheckElementsEvents();
//--- ������� ����������� ����
   ChartEventMouseMove();
//--- ������� ��������� ������� �������
   ChartEventChartChange();
  }
//+------------------------------------------------------------------+
//| �������� ������� ��������� ����������                            |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEvents(void)
  {
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
//--- ����������� ������� � ���� ����������
   OnEvent(m_id,m_lparam,m_dparam,m_sparam);
  }
//+------------------------------------------------------------------+
//| ������� CHARTEVENT_CUSTOM                                        |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventCustom(void)
  {
//--- ���� ������ �������� �����
   if(OnWindowRollUp())
      return;
//--- ���� ������ ���������� �����
   if(OnWindowUnroll())
      return;
//--- ���� ������ �� ������� ����������� ���� �� ������ ����������
   if(OnHideBackContextMenus())
      return;
//--- ���� ������ �� ������� ���� ����������� ����
   if(OnHideContextMenus())
      return;

//--- ���� ������ �� �������� ����������� ����
   if(OnOpenDialogBox())
      return;
//--- ���� ������ �� �������� ����������� ����
   if(OnCloseDialogBox())
      return;
//--- ���� ������ �� ����� ����� ��������� �� ��������� �����
   if(OnResetWindowColors())
      return;
//--- ���� ������ �� ����� ����������� �� ������� ����� ������� ����
   if(OnZeroPriorities())
      return;
//--- ���� ������ �� �������������� ����������� �� ������� ����� ������� ����
   if(OnSetPriorities())
      return;
  }
//+------------------------------------------------------------------+
//| ������� ON_WINDOW_ROLLUP                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowRollUp(void)
  {
//--- ���� ������ �������� �����
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_ROLLUP)
      return(false);
//--- ���� ������������� ���� � ����� ������� ���������
   if(m_lparam==m_windows[0].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(0);
      for(int e=0; e<elements_total; e++)
        {
         //--- ������ ��� �������� ����� �����
         if(m_wnd[0].m_elements[e].ClassName()!="CWindow")
            m_wnd[0].m_elements[e].Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_WINDOW_UNROLL                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowUnroll(void)
  {
//--- ���� ������ "���������� �����"
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
      return(false);
//--- ������ ��������� ����
   int awi=m_active_window_index;
//--- ���� ������������� ���� � ����� ������� ���������
   if(m_lparam==m_windows[awi].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(awi);
      for(int e=0; e<elements_total; e++)
        {
         //--- ������� �������� ��� �������� ����� ����� � ...
         if(m_wnd[awi].m_elements[e].ClassName()!="CWindow")
           {
            //--- ... ��� ���������, ������� �������� �����������
            if(!m_wnd[awi].m_elements[e].IsDropdown())
               m_wnd[awi].m_elements[e].Show();
           }
        }
      //--- ���� ���� �������, �� �������� �������� ������ ����������
      int tabs_total=CWndContainer::TabsTotal(awi);
      for(int t=0; t<tabs_total; t++)
         m_wnd[awi].m_tabs[t].ShowTabElements();
      //--- ���� ���� ����������� ������, �� �������� �������� ������ ����������� ������-�������
      int treeview_total=CWndContainer::TreeViewListsTotal(awi);
      for(int tv=0; tv<treeview_total; tv++)
         m_wnd[awi].m_treeview_lists[tv].ShowTabElements();
     }
//--- �������� ������������ ���� ���������
   MovingWindow();
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_HIDE_BACK_CONTEXTMENUS                                |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideBackContextMenus(void)
  {
//--- ���� ������ �� ������� ����������� ���� �� ������ ����������
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_BACK_CONTEXTMENUS)
      return(false);
//--- ������ �� ���� ���� �� ���������� ����������
   int awi=m_active_window_index;
   int context_menus_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=context_menus_total-1; i>=0; i--)
     {
      //--- ��������� ������������ ���� � ��� ����������� ����
      CContextMenu *cm=m_wnd[awi].m_context_menus[i];
      CMenuItem    *mi=cm.PrevNodePointer();
      //--- ���� ������ ����� ������ ������ ������ ���, ��...
      if(::CheckPointer(mi)==POINTER_INVALID)
         continue;
      //--- ���� ����� �� ������ ���������� �������, ��...
      if(mi.Id()==m_lparam)
        {
         //--- ...� ������, ���� ��� ����������� ���� ��� ������, ������ ���
         if(!cm.MouseFocus())
            cm.Hide();
         //--- ���� ������ ����� ������ ������ ������ ���, ��...
         if(::CheckPointer(mi.PrevNodePointer())==POINTER_INVALID)
           {
            //--- ...������������ ����
            m_windows[awi].IsLocked(false);
           }
         //--- �������� ����
         break;
        }
      else
        {
         //--- ������ ����������� ����
         cm.Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_HIDE_CONTEXTMENUS                                     |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideContextMenus(void)
  {
//--- ���� ������ �� ������� ���� ����������� ����
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_CONTEXTMENUS)
      return(false);
//--- ������ ��� ����������� ����
   int awi=m_active_window_index;
   int cm_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=0; i<cm_total; i++)
      m_wnd[awi].m_context_menus[i].Hide();
//--- ��������� ������� ����
   int menu_bars_total=CWndContainer::MenuBarsTotal(awi);
   for(int i=0; i<menu_bars_total; i++)
      m_wnd[awi].m_menu_bars[i].State(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_OPEN_DIALOG_BOX                                       |
//+------------------------------------------------------------------+
bool CWndEvents::OnOpenDialogBox(void)
  {
//--- ���� ������ �� �������� ����������� ����
   if(m_id!=CHARTEVENT_CUSTOM+ON_OPEN_DIALOG_BOX)
      return(false);
//--- �����, ���� ��������� �� ������ ���������
   if(m_sparam!=m_program_name)
      return(true);
//--- �������� �� ������� ����
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- ���� �������������� ���������
      if(m_windows[w].Id()==m_lparam)
        {
         //--- �������� � ���� ����� ������ ����, � �������� ��� ���� �������
         m_windows[w].PrevActiveWindowIndex(m_active_window_index);
         //--- ���������� �����
         m_windows[w].State(true);
         //--- ����������� �������� ����� ���������� �� ������� ����� ������� ����
         m_windows[w].SetZorders();
         //--- �������� ������ ��������������� ����
         m_active_window_index=w;
         //--- ������� �������� ��� �������� ��������������� ����
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
           {
            //--- ���������� ����� � ���������� ��������
            if(m_wnd[w].m_elements[e].ClassName()=="CWindow" || 
               m_wnd[w].m_elements[e].IsDropdown())
               continue;
            //--- ������� ������� �������
            m_wnd[w].m_elements[e].Show();
            //--- ������������ �������� ��������� �� ������� ����� ������� ����
            m_wnd[w].m_elements[e].SetZorders();
           }
         //--- ������� ����������� ���������
         int tooltips_total=CWndContainer::TooltipsTotal(m_windows[w].PrevActiveWindowIndex());
         for(int t=0; t<tooltips_total; t++)
            m_wnd[m_windows[w].PrevActiveWindowIndex()].m_tooltips[t].FadeOutTooltip();
         //--- ���� ���� �������, �� �������� �������� ������ ����������
         int tabs_total=CWndContainer::TabsTotal(w);
         for(int t=0; t<tabs_total; t++)
            m_wnd[w].m_tabs[t].ShowTabElements();
         //--- ���� ���� ����������� ������, �� �������� �������� ������ ����������� ������-�������
         int treeview_total=CWndContainer::TreeViewListsTotal(w);
         for(int tv=0; tv<tabs_total; tv++)
            m_wnd[w].m_treeview_lists[tv].ShowTabElements();
        }
      //--- ������ ����� ����� �������������, ���� �� ��������� �������������� ����
      else
        {
         //--- ����������� �����
         m_windows[w].State(false);
         //--- ������� ���������� ��������� ����� �� ������� ����� ������� ����
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].ResetZorders();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_CLOSE_DIALOG_BOX                                      |
//+------------------------------------------------------------------+
bool CWndEvents::OnCloseDialogBox(void)
  {
//--- ���� ������ �� �������� ����������� ����
   if(m_id!=CHARTEVENT_CUSTOM+ON_CLOSE_DIALOG_BOX)
      return(false);
//--- �������� �� ������� ����
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- ���� �������������� ���������
      if(m_windows[w].Id()==m_lparam)
        {
         //--- ����������� �����
         m_windows[w].State(false);
         //--- ������� �����
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].Hide();
         //--- ���������� ���������� �����
         m_windows[int(m_dparam)].State(true);
         //--- ����������� �������
         m_chart.Redraw();
         break;
        }
     }
//--- ��������� ������� ����������� ����
   m_active_window_index=int(m_dparam);
//--- �������������� ����������� �� ������� ����� ������� ���� � ��������������� ����
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].SetZorders();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_RESET_WINDOW_COLORS                                   |
//+------------------------------------------------------------------+
bool CWndEvents::OnResetWindowColors(void)
  {
//--- ���� ������ �� ����� ����� ����
   if(m_id!=CHARTEVENT_CUSTOM+ON_RESET_WINDOW_COLORS)
      return(false);
//--- ��� ����������� ������� �����, �� �������� ������ ���������
   int index=WRONG_VALUE;
//--- �������� �� ������� ����
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- ���� �������������� ���������
      if(m_windows[w].Id()==m_lparam)
        {
         //--- �������� ������
         index=w;
         //--- ������� ���� �����
         m_windows[w].ResetColors();
         break;
        }
     }
//--- ������, ���� ������ �� ��������
   if(index==WRONG_VALUE)
      return(true);
//--- ������� ����� � ���� ��������� �����
   int elements_total=CWndContainer::ElementsTotal(index);
   for(int e=0; e<elements_total; e++)
      m_wnd[index].m_elements[e].ResetColors();
//--- ����������� �������
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_ZERO_PRIORITIES                                       |
//+------------------------------------------------------------------+
bool CWndEvents::OnZeroPriorities(void)
  {
//--- ���� ������ �� ��������� ����������� �� ������� ����� ������� ����
   if(m_id!=CHARTEVENT_CUSTOM+ON_ZERO_PRIORITIES)
      return(false);
//---
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
     {
      //--- �������� ���������� ���� ��������� ����� ����, ��� id ��� ������� � ������� � ...
      if(m_lparam!=m_wnd[m_active_window_index].m_elements[e].Id())
        {
         //--- ... ����� ����������� ����
         if(m_wnd[m_active_window_index].m_elements[e].ClassName()=="CMenuItem" ||
            m_wnd[m_active_window_index].m_elements[e].ClassName()=="CContextMenu")
            continue;
         //---
         m_wnd[m_active_window_index].m_elements[e].ResetZorders();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ON_SET_PRIORITIES                                        |
//+------------------------------------------------------------------+
bool CWndEvents::OnSetPriorities(void)
  {
//--- ���� ������ �� �������������� ����������� �� ������� ����� ������� ����
   if(m_id!=CHARTEVENT_CUSTOM+ON_SET_PRIORITIES)
      return(false);
//---
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].SetZorders();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� CHARTEVENT CLICK                                         |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventClick(void)
  {
  }
//+------------------------------------------------------------------+
//| ������� CHARTEVENT MOUSE MOVE                                    |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventMouseMove(void)
  {
//--- �����, ���� ��� �� ������� ����������� �������
   if(m_id!=CHARTEVENT_MOUSE_MOVE)
      return;
//--- ����������� ����
   MovingWindow();
//--- ��������� ��������� �������
   SetChartState();
//--- ���������� ������
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| ������� CHARTEVENT OBJECT CLICK                                  |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventObjectClick(void)
  {
  }
//+------------------------------------------------------------------+
//| ������� CHARTEVENT OBJECT ENDEDIT                                |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventEndEdit(void)
  {
  }
//+------------------------------------------------------------------+
//| ������� CHARTEVENT CHART CHANGE                                  |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventChartChange(void)
  {
//--- ������� ��������� ������� �������
   if(m_id!=CHARTEVENT_CHART_CHANGE)
      return;
//--- �������� � ���������� ������ ���� ���������
   CheckSubwindowNumber();
//--- ����������� ����
   MovingWindow();
//--- ���������� ������
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CWndEvents::OnTimerEvent(void)
  {
//--- ���� ������ ����, ������  
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- �������� ������� ���� ��������� �� �������
   CheckElementsEventsTimer();
//--- ���������� ������
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| ����������� ����                                                 |
//+------------------------------------------------------------------+
void CWndEvents::MovingWindow(void)
  {
   int awi=m_active_window_index;
//--- ����������� ����
   int x=m_windows[awi].X();
   int y=m_windows[awi].Y();
   m_windows[awi].Moving(x,y);
//--- ����������� ��������� ����������
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| �������� ������� ���� ��������� �� �������                       |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEventsTimer(void)
  {
   int awi=m_active_window_index;
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].OnEventTimer();
  }
//+------------------------------------------------------------------+
//| ����������� ������ �������                                       |
//+------------------------------------------------------------------+
void CWndEvents::DetermineSubwindow(void)
  {
//--- ���� ��� ��������� �� ���������, ������
   if(PROGRAM_TYPE!=PROGRAM_INDICATOR)
      return;
//--- ����� ��������� ������
   ::ResetLastError();
//--- ����������� ������ ���� ����������
   m_subwin=::ChartWindowFind();
//--- ���� �� ���������� ���������� �����, ������
   if(m_subwin<0)
     {
      ::Print(__FUNCTION__," > ������ ��� ����������� ������ �������: ",::GetLastError());
      return;
     }
//--- ���� ��� �� ������� ���� �������
   if(m_subwin>0)
     {
      //--- ������� ����� ���������� ����������� � ��������� �������
      int total=::ChartIndicatorsTotal(m_chart_id,m_subwin);
      //--- ������� �������� ��� ���������� ���������� � ������
      string indicator_name=::ChartIndicatorName(m_chart_id,m_subwin,total-1);
      //--- ���� � ������� ��� ���� ���������, �� ������� ��������� � �������
      if(total!=1)
        {
         ::Print(__FUNCTION__," > � ���� ������� ��� ���� ���������.");
         ::ChartIndicatorDelete(m_chart_id,m_subwin,indicator_name);
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| �������� � ���������� ������ ���� ���������                      |
//+------------------------------------------------------------------+
void CWndEvents::CheckSubwindowNumber(void)
  {
//--- ���� ��������� � ������� � ������ �� ���������
   if(m_subwin!=0 && m_subwin!=::ChartWindowFind())
     {
      //--- ���������� ����� �������
      DetermineSubwindow();
      //--- ��������� �� ���� ���������
      int windows_total=CWndContainer::WindowsTotal();
      for(int w=0; w<windows_total; w++)
        {
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].SubwindowNumber(m_subwin);
        }
     }
  }
//+------------------------------------------------------------------+
//| �������� ���� ��������                                           |
//+------------------------------------------------------------------+
void CWndEvents::Destroy(void)
  {
//--- ��������� ������ �������� ����
   m_active_window_index=0;
//--- ������� ���������� ����
   int window_total=CWndContainer::WindowsTotal();
//--- �������� �� ������� ����
   for(int w=0; w<window_total; w++)
     {
      //--- ���������� ������� ����
      if(m_windows[w].WindowType()==W_MAIN)
         m_windows[w].State(true);
      //--- ����������� ���������� ����
      else
         m_windows[w].State(false);
     }
//--- ��������� ������� ���������
   for(int w=0; w<window_total; w++)
     {
      int elements_total=CWndContainer::ElementsTotal(w);
      for(int e=0; e<elements_total; e++)
        {
         //--- ���� ��������� ����������, ������� � ����������
         if(::CheckPointer(m_wnd[w].m_elements[e])==POINTER_INVALID)
            continue;
         //--- ������� ������� ��������
         m_wnd[w].m_elements[e].Delete();
        }
      //--- ���������� ������� ���������
      ::ArrayFree(m_wnd[w].m_objects);
      ::ArrayFree(m_wnd[w].m_elements);
      ::ArrayFree(m_wnd[w].m_menu_bars);
      ::ArrayFree(m_wnd[w].m_context_menus);
      ::ArrayFree(m_wnd[w].m_tooltips);
      ::ArrayFree(m_wnd[w].m_drop_lists);
      ::ArrayFree(m_wnd[w].m_scrolls);
      ::ArrayFree(m_wnd[w].m_labels_tables);
      ::ArrayFree(m_wnd[w].m_tables);
      ::ArrayFree(m_wnd[w].m_canvas_tables);
      ::ArrayFree(m_wnd[w].m_tabs);
      ::ArrayFree(m_wnd[w].m_calendars);
      ::ArrayFree(m_wnd[w].m_drop_calendars);
      ::ArrayFree(m_wnd[w].m_treeview_lists);
      ::ArrayFree(m_wnd[w].m_file_navigators);
     }
//--- ���������� ������� ����
   ::ArrayFree(m_wnd);
   ::ArrayFree(m_windows);
  }
//+------------------------------------------------------------------+
//| ������������� ��������� �������                                  |
//+------------------------------------------------------------------+
void CWndEvents::SetChartState(void)
  {
   int awi=m_active_window_index;
//--- ��� ����������� �������, ����� ����� ��������� ����������
   bool condition=false;
//--- �������� ����
   int windows_total=CWndContainer::WindowsTotal();
   for(int i=0; i<windows_total; i++)
     {
      //--- ������� � ���������, ���� ��� ����� ������
      if(!m_windows[i].IsVisible())
         continue;
      //--- ��������� ������� �� ���������� ����������� �����
      m_windows[i].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
      //--- ���� ���� �����, ������� ���
      if(m_windows[i].MouseFocus())
        {
         condition=true;
         break;
        }
     }
//--- �������� ���������� ������
   if(!condition)
     {
      //--- ������� ����� ���������� ���������� �������
      int drop_lists_total=CWndContainer::DropListsTotal(awi);
      for(int i=0; i<drop_lists_total; i++)
        {
         //--- ������� ��������� �� ���������� ������
         CListView *lv=m_wnd[awi].m_drop_lists[i];
         //--- ���� ������ ����������� (������)
         if(lv.IsVisible())
           {
            //--- �������� ����� ��� ������� � ��������� ��� ������ ���������
            if(m_wnd[awi].m_drop_lists[i].MouseFocus() || lv.ScrollState())
              {
               condition=true;
               break;
              }
           }
        }
     }
//--- �������� ���������
   if(!condition)
     {
      int drop_calendars_total=CWndContainer::DropCalendarsTotal(awi);
      for(int i=0; i<drop_calendars_total; i++)
        {
         if(m_wnd[awi].m_drop_calendars[i].GetCalendarPointer().MouseFocus())
           {
            condition=true;
            break;
           }
        }
     }
//--- �������� ����� ����������� ����
   if(!condition)
     {
      //--- ������� ����� ���������� ���������� ����������� ����
      int context_menus_total=CWndContainer::ContextMenusTotal(awi);
      for(int i=0; i<context_menus_total; i++)
        {
         //--- ���� ����� ��� ���������� ����
         if(m_wnd[awi].m_context_menus[i].MouseFocus())
           {
            condition=true;
            break;
           }
        }
     }
//--- �������� ��������� ����� ���������
   if(!condition)
     {
      int scrolls_total=CWndContainer::ScrollsTotal(awi);
      for(int i=0; i<scrolls_total; i++)
        {
         if(((CScroll*)m_wnd[awi].m_scrolls[i]).ScrollState())
           {
            condition=true;
            break;
           }
        }
     }
//--- ������������� ��������� ������� �� ���� ������
   for(int i=0; i<windows_total; i++)
      m_windows[i].CustomEventChartState(condition);
  }
//+------------------------------------------------------------------+
