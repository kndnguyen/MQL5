//+------------------------------------------------------------------+
//|                                                    WndEvents.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Defines.mqh"
#include "WndContainer.mqh"
#include <Charts\Chart.mqh>
//+------------------------------------------------------------------+
//| Êëàññ äëÿ îáðàáîòêè ñîáûòèé                                      |
//+------------------------------------------------------------------+
class CWndEvents : public CWndContainer
  {
protected:
   CChart            m_chart;
   //--- Èäåíòèôèêàòîð è íîìåð îêíà ãðàôèêà
   long              m_chart_id;
   int               m_subwin;
   //--- Èìÿ ïðîãðàììû
   string            m_program_name;
   //--- Êîðîòêîå èìÿ èíäèêàòîðà
   string            m_indicator_shortname;
   //--- Èíäåêñ àêòèâíîãî îêíà
   int               m_active_window_index;
   //---
private:
   //--- Ïàðàìåòðû ñîáûòèé
   int               m_id;
   long              m_lparam;
   double            m_dparam;
   string            m_sparam;
   //---
protected:
                     CWndEvents(void);
                    ~CWndEvents(void);
   //--- Âèðòóàëüíûé îáðàáîò÷èê ñîáûòèÿ ãðàôèêà
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- Òàéìåð
   void              OnTimerEvent(void);
   //---
public:
   //--- Îáðàáîò÷èêè ñîáûòèé ãðàôèêà
   void              ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
private:
   void              ChartEventCustom(void);
   void              ChartEventClick(void);
   void              ChartEventMouseMove(void);
   void              ChartEventObjectClick(void);
   void              ChartEventEndEdit(void);
   void              ChartEventChartChange(void);
   //--- Ïðîâåðêà ñîáûòèé â ýëåìåíòàõ óïðàâëåíèÿ
   void              CheckElementsEvents(void);
   //--- Îïðåäåëåíèå íîìåðà ïîäîêíà
   void              DetermineSubwindow(void);
   //--- Ïðîâåðêà ñîáûòèé ýëåìåíòîâ óïðàâëåíèÿ
   void              CheckSubwindowNumber(void);
   //--- Èíèöèàëèçàöèÿ ïàðàìåòðîâ ñîáûòèé
   void              InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam);
   //--- Ïåðåìåùåíèå îêíà
   void              MovingWindow(void);
   //--- Ïðîâåðêà ñîáûòèé âñåõ ýëåìåíòîâ ïî òàéìåðó
   void              CheckElementsEventsTimer(void);
   //--- Óñòàíîâêà ñîñòîÿíèÿ ãðàôèêà
   void              SetChartState(void);
   //---
protected:
   //--- Óäàëåíèå èíòåðôåéñà
   void              Destroy(void);
   //---
private:
   //--- Ñâîðà÷èâàíèå/ðàçâîðà÷èâàíèå ôîðìû
   bool              OnWindowRollUp(void);
   bool              OnWindowUnroll(void);
   //--- Ñêðûòèå âñåõ êîíòåêñòíûõ ìåíþ îò ïóíêòà èíèöèàòîðà
   bool              OnHideBackContextMenus(void);
   //--- Ñêðûòèå âñåõ êîíòåêñòíûõ ìåíþ
   bool              OnHideContextMenus(void);

   //--- Îòêðûòèå äèàëîãîâîãî îêíà
   bool              OnOpenDialogBox(void);
   //--- Çàêðûòèå äèàëîãîâîãî îêíà
   bool              OnCloseDialogBox(void);
   //--- Ñáðîñ öâåòà ôîðìû è å¸ ýëåìåíòîâ
   bool              OnResetWindowColors(void);
   //--- Ñáðîñ ïðèîðèòåòîâ íà íàæàòèå ëåâîé êíîïêîé ìûøè
   bool              OnZeroPriorities(void);
   //--- Âîññòàíîâëåíèå ïðèîðèòåòîâ íà íàæàòèå ëåâîé êíîïêîé ìûøè
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
//--- Âêëþ÷èì òàéìåð
   if(!::MQLInfoInteger(MQL_TESTER))
      ::EventSetMillisecondTimer(TIMER_STEP_MSC);
//--- Ïîëó÷èì ID òåêóùåãî ãðàôèêà
   m_chart.Attach();
//--- Âêëþ÷èì ñëåæåíèå çà ñîáûòèÿìè ìûøè
   m_chart.EventMouseMove(true);
//--- Îïðåäåëåíèå íîìåðà ïîäîêíà
   DetermineSubwindow();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CWndEvents::~CWndEvents(void)
  {
//--- Óäàëèòü òàéìåð
   ::EventKillTimer();
//--- Âêëþ÷èì óïðàâëåíèå
   m_chart.MouseScroll(true);
   m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
//--- Îòêëþ÷èì ñëåæåíèå çà ñîáûòèÿìè ìûøè
   m_chart.EventMouseMove(false);
//--- Îòñîåäèíèòüñÿ îò ãðàôèêà
   m_chart.Detach();
//--- Ñòåðåòü êîììåíò   
   ::Comment("");
  }
//+------------------------------------------------------------------+
//| Èíèöèàëèçàöèÿ ñîáûòèéíûõ ïåðåìåííûõ                              |
//+------------------------------------------------------------------+
void CWndEvents::InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam)
  {
   m_id     =id;
   m_lparam =lparam;
   m_dparam =dparam;
   m_sparam =sparam;
  }
//+------------------------------------------------------------------+
//| Îáðàáîòêà ñîáûòèé ïðîãðàììû                                      |
//+------------------------------------------------------------------+
void CWndEvents::ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Åñëè ìàññèâ ïóñò, âûéäåì
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- Èíèöèàëèçàöèÿ ïîëåé ïàðàìåòðîâ ñîáûòèé
   InitChartEventsParams(id,lparam,dparam,sparam);
//--- Ïîëüçîâàòåëüñêèå ñîáûòèÿ
   ChartEventCustom();
//--- Ïðîâåðêà ñîáûòèé ýëåìåíòîâ èíòåðôåéñà
   CheckElementsEvents();
//--- Ñîáûòèå ïåðåìåùåíèÿ ìûøè
   ChartEventMouseMove();
//--- Ñîáûòèå èçìåíåíèÿ ñâîéñòâ ãðàôèêà
   ChartEventChartChange();
  }
//+------------------------------------------------------------------+
//| Ïðîâåðêà ñîáûòèé ýëåìåíòîâ óïðàâëåíèÿ                            |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEvents(void)
  {
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
//--- Íàïðàâëåíèå ñîáûòèÿ â ôàéë ïðèëîæåíèÿ
   OnEvent(m_id,m_lparam,m_dparam,m_sparam);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå CHARTEVENT_CUSTOM                                        |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventCustom(void)
  {
//--- Åñëè ñèãíàë ñâåðíóòü ôîðìó
   if(OnWindowRollUp())
      return;
//--- Åñëè ñèãíàë ðàçâåðíóòü ôîðìó
   if(OnWindowUnroll())
      return;
//--- Åñëè ñèãíàë íà ñêðûòèå êîíòåêñòíûõ ìåíþ îò ïóíêòà èíèöèàòîðà
   if(OnHideBackContextMenus())
      return;
//--- Åñëè ñèãíàë íà ñêðûòèå âñåõ êîíòåêñòíûõ ìåíþ
   if(OnHideContextMenus())
      return;

//--- Åñëè ñèãíàë íà îòêðûòèå äèàëîãîâîãî îêíà
   if(OnOpenDialogBox())
      return;
//--- Åñëè ñèãíàë íà çàêðûòèå äèàëîãîâîãî îêíà
   if(OnCloseDialogBox())
      return;
//--- Åñëè ñèãíàë íà ñáðîñ öâåòà ýëåìåíòîâ íà óêàçàííîé ôîðìå
   if(OnResetWindowColors())
      return;
//--- Åñëè ñèãíàë íà ñáðîñ ïðèîðèòåòîâ íà íàæàòèå ëåâîé êíîïêîé ìûøè
   if(OnZeroPriorities())
      return;
//--- Åñëè ñèãíàë íà âîññòàíîâëåíèå ïðèîðèòåòîâ íà íàæàòèå ëåâîé êíîïêîé ìûøè
   if(OnSetPriorities())
      return;
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_WINDOW_ROLLUP                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowRollUp(void)
  {
//--- Åñëè ñèãíàë ñâåðíóòü ôîðìó
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_ROLLUP)
      return(false);
//--- Åñëè èäåíòèôèêàòîð îêíà è íîìåð ïîäîêíà ñîâïàäàþò
   if(m_lparam==m_windows[0].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(0);
      for(int e=0; e<elements_total; e++)
        {
         //--- Ñêðûòü âñå ýëåìåíòû êðîìå ôîðìû
         if(m_wnd[0].m_elements[e].ClassName()!="CWindow")
            m_wnd[0].m_elements[e].Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_WINDOW_UNROLL                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowUnroll(void)
  {
//--- Åñëè ñèãíàë "Ðàçâåðíóòü ôîðìó"
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
      return(false);
//--- Èíäåêñ àêòèâíîãî îêíà
   int awi=m_active_window_index;
//--- Åñëè èäåíòèôèêàòîð îêíà è íîìåð ïîäîêíà ñîâïàäàþò
   if(m_lparam==m_windows[awi].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(awi);
      for(int e=0; e<elements_total; e++)
        {
         //--- Ñäåëàòü âèäèìûìè âñå ýëåìåíòû êðîìå ôîðìû è ...
         if(m_wnd[awi].m_elements[e].ClassName()!="CWindow")
           {
            //--- ... òåõ ýëåìåíòîâ, êîòîðûå ÿâëÿþòñÿ âûïàäàþùèìè
            if(!m_wnd[awi].m_elements[e].IsDropdown())
               m_wnd[awi].m_elements[e].Show();
           }
        }
      //--- Åñëè åñòü âêëàäêè, òî ïîêàçàòü ýëåìåíòû òîëüêî âûäåëåííîé
      int tabs_total=CWndContainer::TabsTotal(awi);
      for(int t=0; t<tabs_total; t++)
         m_wnd[awi].m_tabs[t].ShowTabElements();
      //--- Åñëè åñòü äðåâîâèäíûå ñïèñêè, òî ïîêàçàòü ýëåìåíòû òîëüêî âûäåëåííîãî ïóíêòà-âêëàäêè
      int treeview_total=CWndContainer::TreeViewListsTotal(awi);
      for(int tv=0; tv<treeview_total; tv++)
         m_wnd[awi].m_treeview_lists[tv].ShowTabElements();
     }
//--- Îáíîâèòü ðàñïîëîæåíèå âñåõ ýëåìåíòîâ
   MovingWindow();
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_HIDE_BACK_CONTEXTMENUS                                |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideBackContextMenus(void)
  {
//--- Åñëè ñèãíàë íà ñêðûòèå êîíòåêñòíûõ ìåíþ îò ïóíêòà èíèöèàòîðà
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_BACK_CONTEXTMENUS)
      return(false);
//--- Ïðîéä¸ì ïî âñåì ìåíþ îò ïîñëåäíåãî âûçâàííîãî
   int awi=m_active_window_index;
   int context_menus_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=context_menus_total-1; i>=0; i--)
     {
      //--- Óêàçàòåëè êîíòåêñòíîãî ìåíþ è åãî ïðåäûäóùåãî óçëà
      CContextMenu *cm=m_wnd[awi].m_context_menus[i];
      CMenuItem    *mi=cm.PrevNodePointer();
      //--- Åñëè äàëüøå ýòîãî ïóíêòà áîëüøå íè÷åãî íåò, òî...
      if(::CheckPointer(mi)==POINTER_INVALID)
         continue;
      //--- Åñëè äîøëè äî ïóíêòà èíèöèàòîðà ñèãíàëà, òî...
      if(mi.Id()==m_lparam)
        {
         //--- ...â ñëó÷àå, åñëè åãî êîíòåêñòíîå ìåíþ áåç ôîêóñà, ñêðîåì åãî
         if(!cm.MouseFocus())
            cm.Hide();
         //--- Åñëè äàëüøå ýòîãî ïóíêòà áîëüøå íè÷åãî íåò, òî...
         if(::CheckPointer(mi.PrevNodePointer())==POINTER_INVALID)
           {
            //--- ...ðàçáëîêèðóåì îêíî
            m_windows[awi].IsLocked(false);
           }
         //--- Çàâåðøèì öèêë
         break;
        }
      else
        {
         //--- Ñêðûòü êîíòåêñòíîå ìåíþ
         cm.Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_HIDE_CONTEXTMENUS                                     |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideContextMenus(void)
  {
//--- Åñëè ñèãíàë íà ñêðûòèå âñåõ êîíòåêñòíûõ ìåíþ
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_CONTEXTMENUS)
      return(false);
//--- Ñêðûòü âñå êîíòåêñòíûå ìåíþ
   int awi=m_active_window_index;
   int cm_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=0; i<cm_total; i++)
      m_wnd[awi].m_context_menus[i].Hide();
//--- Îòêëþ÷èòü ãëàâíûå ìåíþ
   int menu_bars_total=CWndContainer::MenuBarsTotal(awi);
   for(int i=0; i<menu_bars_total; i++)
      m_wnd[awi].m_menu_bars[i].State(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_OPEN_DIALOG_BOX                                       |
//+------------------------------------------------------------------+
bool CWndEvents::OnOpenDialogBox(void)
  {
//--- Åñëè ñèãíàë íà îòêðûòèå äèàëîãîâîãî îêíà
   if(m_id!=CHARTEVENT_CUSTOM+ON_OPEN_DIALOG_BOX)
      return(false);
//--- Âûéòè, åñëè ñîîáùåíèå îò äðóãîé ïðîãðàììû
   if(m_sparam!=m_program_name)
      return(true);
//--- Ïðîéä¸ìñÿ ïî ìàññèâó îêîí
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- Åñëè èäåíòèôèêàòîðû ñîâïàäàþò
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Çàïîìíèì â ýòîé ôîðìå èíäåêñ îêíà, ñ êîòîðîãî îíà áûëà âûçâàíà
         m_windows[w].PrevActiveWindowIndex(m_active_window_index);
         //--- Àêòèâèðóåì ôîðìó
         m_windows[w].State(true);
         //--- Âîññòàíîâèì îáúåêòàì ôîðìû ïðèîðèòåòû íà íàæàòèå ëåâîé êíîïêîé ìûøè
         m_windows[w].SetZorders();
         //--- Çàïîìíèì èíäåêñ àêòèâèðîâàííîãî îêíà
         m_active_window_index=w;
         //--- Ñäåëàòü âèäèìûìè âñå ýëåìåíòû àêòèâèðîâàííîãî îêíà
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
           {
            //--- Ïðîïóñêàåì ôîðìû è âûïàäàþùèå ýëåìåíòû
            if(m_wnd[w].m_elements[e].ClassName()=="CWindow" || 
               m_wnd[w].m_elements[e].IsDropdown())
               continue;
            //--- Ñäåëàòü âèäèìûì ýëåìåíò
            m_wnd[w].m_elements[e].Show();
            //--- Âîññòàíîâèòü ýëåìåíòó ïðèîðèòåò íà íàæàòèå ëåâîé êíîïêîé ìûøè
            m_wnd[w].m_elements[e].SetZorders();
           }
         //--- Ñêðûòèå âñïëûâàþùèõ ïîäñêàçîê
         int tooltips_total=CWndContainer::TooltipsTotal(m_windows[w].PrevActiveWindowIndex());
         for(int t=0; t<tooltips_total; t++)
            m_wnd[m_windows[w].PrevActiveWindowIndex()].m_tooltips[t].FadeOutTooltip();
         //--- Åñëè åñòü âêëàäêè, òî ïîêàçàòü ýëåìåíòû òîëüêî âûäåëåííîé
         int tabs_total=CWndContainer::TabsTotal(w);
         for(int t=0; t<tabs_total; t++)
            m_wnd[w].m_tabs[t].ShowTabElements();
         //--- Åñëè åñòü äðåâîâèäíûå ñïèñêè, òî ïîêàçàòü ýëåìåíòû òîëüêî âûäåëåííîãî ïóíêòà-âêëàäêè
         int treeview_total=CWndContainer::TreeViewListsTotal(w);
         for(int tv=0; tv<tabs_total; tv++)
            m_wnd[w].m_treeview_lists[tv].ShowTabElements();
        }
      //--- Äðóãèå ôîðìû áóäóò çàáëîêèðîâàíû, ïîêà íå çàêðîåòñÿ àêòèâèðîâàííîå îêíî
      else
        {
         //--- Çàáëîêèðóåì ôîðìó
         m_windows[w].State(false);
         //--- Îáíóëèì ïðèîðèòåòû ýëåìåíòîâ ôîðìû íà íàæàòèå ëåâîé êíîïêîé ìûøè
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].ResetZorders();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_CLOSE_DIALOG_BOX                                      |
//+------------------------------------------------------------------+
bool CWndEvents::OnCloseDialogBox(void)
  {
//--- Åñëè ñèãíàë íà çàêðûòèå äèàëîãîâîãî îêíà
   if(m_id!=CHARTEVENT_CUSTOM+ON_CLOSE_DIALOG_BOX)
      return(false);
//--- Ïðîéä¸ìñÿ ïî ìàññèâó îêîí
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- Åñëè èäåíòèôèêàòîðû ñîâïàäàþò
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Çàáëîêèðóåì ôîðìó
         m_windows[w].State(false);
         //--- Ñïðÿ÷åì ôîðìó
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].Hide();
         //--- Àêòèâèðóåì ïðåäûäóùóþ ôîðìó
         m_windows[int(m_dparam)].State(true);
         //--- Ïåðåðèñîâêà ãðàôèêà
         m_chart.Redraw();
         break;
        }
     }
//--- Óñòàíîâêà èíäåêñà ïðåäûäóùåãî îêíà
   m_active_window_index=int(m_dparam);
//--- Âîññòàíîâëåíèå ïðèîðèòåòîâ íà íàæàòèå ëåâîé êíîïêîé ìûøè ó àêòèâèðîâàííîãî îêíà
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].SetZorders();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_RESET_WINDOW_COLORS                                   |
//+------------------------------------------------------------------+
bool CWndEvents::OnResetWindowColors(void)
  {
//--- Åñëè ñèãíàë íà ñáðîñ öâåòà îêíà
   if(m_id!=CHARTEVENT_CUSTOM+ON_RESET_WINDOW_COLORS)
      return(false);
//--- Äëÿ îïðåäåëåíèÿ èíäåêñà ôîðìû, îò êîòîðîãî ïðèøëî ñîîáùåíèå
   int index=WRONG_VALUE;
//--- Ïðîéä¸ìñÿ ïî ìàññèâó îêîí
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- Åñëè èäåíòèôèêàòîðû ñîâïàäàþò
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Çàïîìíèì èíäåêñ
         index=w;
         //--- Ñáðîñèì öâåò ôîðìû
         m_windows[w].ResetColors();
         break;
        }
     }
//--- Âûéäåì, åñëè èíäåêñ íå îïðåäåë¸í
   if(index==WRONG_VALUE)
      return(true);
//--- Ñáðîñèì öâåòà ó âñåõ ýëåìåíòîâ ôîðìû
   int elements_total=CWndContainer::ElementsTotal(index);
   for(int e=0; e<elements_total; e++)
      m_wnd[index].m_elements[e].ResetColors();
//--- Ïåðåðèñîâêà ãðàôèêà
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå ON_ZERO_PRIORITIES                                       |
//+------------------------------------------------------------------+
bool CWndEvents::OnZeroPriorities(void)
  {
//--- Åñëè ñèãíàë íà îáíóëåíèå ïðèîðèòåòîâ íà íàæàòèå ëåâîé êíîïêîé ìûøè
   if(m_id!=CHARTEVENT_CUSTOM+ON_ZERO_PRIORITIES)
      return(false);
//---
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
     {
      //--- Îáíóëèòü ïðèîðèòåòû âñåõ ýëåìåíòîâ êðîìå òîãî, ÷åé id áûë ïåðåäàí â ñîáûòèè è ...
      if(m_lparam!=m_wnd[m_active_window_index].m_elements[e].Id())
        {
         //--- ... êðîìå êîíòåêñòíûõ ìåíþ
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
//| Ñîáûòèå ON_SET_PRIORITIES                                        |
//+------------------------------------------------------------------+
bool CWndEvents::OnSetPriorities(void)
  {
//--- Åñëè ñèãíàë íà âîññòàíîâëåíèå ïðèîðèòåòîâ íà íàæàòèå ëåâîé êíîïêîé ìûøè
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
//| Ñîáûòèå CHARTEVENT CLICK                                         |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventClick(void)
  {
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå CHARTEVENT MOUSE MOVE                                    |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventMouseMove(void)
  {
//--- Âûéòè, åñëè ýòî íå ñîáûòèå ïåðåìåùåíèÿ êóðñîðà
   if(m_id!=CHARTEVENT_MOUSE_MOVE)
      return;
//--- Ïåðåìåùåíèå îêíà
   MovingWindow();
//--- Óñòàíîâêà ñîñòîÿíèÿ ãðàôèêà
   SetChartState();
//--- Ïåðåðèñóåì ãðàôèê
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå CHARTEVENT OBJECT CLICK                                  |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventObjectClick(void)
  {
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå CHARTEVENT OBJECT ENDEDIT                                |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventEndEdit(void)
  {
  }
//+------------------------------------------------------------------+
//| Ñîáûòèå CHARTEVENT CHART CHANGE                                  |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventChartChange(void)
  {
//--- Ñîáûòèå èçìåíåíèÿ ñâîéñòâ ãðàôèêà
   if(m_id!=CHARTEVENT_CHART_CHANGE)
      return;
//--- Ïðîâåðêà è îáíîâëåíèå íîìåðà îêíà ïðîãðàììû
   CheckSubwindowNumber();
//--- Ïåðåìåùåíèå îêíà
   MovingWindow();
//--- Ïåðåðèñóåì ãðàôèê
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Òàéìåð                                                           |
//+------------------------------------------------------------------+
void CWndEvents::OnTimerEvent(void)
  {
//--- Åñëè ìàññèâ ïóñò, âûéäåì  
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- Ïðîâåðêà ñîáûòèé âñåõ ýëåìåíòîâ ïî òàéìåðó
   CheckElementsEventsTimer();
//--- Ïåðåðèñóåì ãðàôèê
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Ïåðåìåùåíèå îêíà                                                 |
//+------------------------------------------------------------------+
void CWndEvents::MovingWindow(void)
  {
   int awi=m_active_window_index;
//--- Ïåðåìåùåíèå îêíà
   int x=m_windows[awi].X();
   int y=m_windows[awi].Y();
   m_windows[awi].Moving(x,y);
//--- Ïåðåìåùåíèå ýëåìåíòîâ óïðàâëåíèÿ
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| Ïðîâåðêà ñîáûòèé âñåõ ýëåìåíòîâ ïî òàéìåðó                       |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEventsTimer(void)
  {
   int awi=m_active_window_index;
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].OnEventTimer();
  }
//+------------------------------------------------------------------+
//| Îïðåäåëåíèå íîìåðà ïîäîêíà                                       |
//+------------------------------------------------------------------+
void CWndEvents::DetermineSubwindow(void)
  {
//--- Åñëè òèï ïðîãðàììû íå èíäèêàòîð, âûéäåì
   if(PROGRAM_TYPE!=PROGRAM_INDICATOR)
      return;
//--- Ñáðîñ ïîñëåäíåé îøèáêè
   ::ResetLastError();
//--- Îïðåäåëåíèå íîìåðà îêíà èíäèêàòîðà
   m_subwin=::ChartWindowFind();
//--- Åñëè íå ïîëó÷èëîñü îïðåäåëèòü íîìåð, âûéäåì
   if(m_subwin<0)
     {
      ::Print(__FUNCTION__," > Îøèáêà ïðè îïðåäåëåíèè íîìåðà ïîäîêíà: ",::GetLastError());
      return;
     }
//--- Åñëè ýòî íå ãëàâíîå îêíî ãðàôèêà
   if(m_subwin>0)
     {
      //--- Ïîëó÷èì îáùåå êîëè÷åñòâî èíäèêàòîðîâ â óêàçàííîì ïîäîêíå
      int total=::ChartIndicatorsTotal(m_chart_id,m_subwin);
      //--- Ïîëó÷èì êîðîòêîå èìÿ ïîñëåäíåãî èíäèêàòîðà â ñïèñêå
      string indicator_name=::ChartIndicatorName(m_chart_id,m_subwin,total-1);
      //--- Åñëè â ïîäîêíå óæå åñòü èíäèêàòîð, òî óäàëèòü ïðîãðàììó ñ ãðàôèêà
      if(total!=1)
        {
         ::Print(__FUNCTION__," > Â ýòîì ïîäîêíå óæå åñòü èíäèêàòîð.");
         ::ChartIndicatorDelete(m_chart_id,m_subwin,indicator_name);
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| Ïðîâåðêà è îáíîâëåíèå íîìåðà îêíà ïðîãðàììû                      |
//+------------------------------------------------------------------+
void CWndEvents::CheckSubwindowNumber(void)
  {
//--- Åñëè ïðîãðàììà â ïîäîêíå è íîìåðà íå ñîâïàäàþò
   if(m_subwin!=0 && m_subwin!=::ChartWindowFind())
     {
      //--- Îïðåäåëèòü íîìåð ïîäîêíà
      DetermineSubwindow();
      //--- Ñîõðàíèòü âî âñåõ ýëåìåíòàõ
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
//| Óäàëåíèå âñåõ îáúåêòîâ                                           |
//+------------------------------------------------------------------+
void CWndEvents::Destroy(void)
  {

   m_active_window_index=0;

   int window_total=CWndContainer::WindowsTotal();

   for(int w=0; w<window_total; w++)
     {

      if(m_windows[w].WindowType()==W_MAIN)
         m_windows[w].State(true);

      else
         m_windows[w].State(false);
     }

   for(int w=0; w<window_total; w++)
     {
      int elements_total=CWndContainer::ElementsTotal(w);
      for(int e=0; e<elements_total; e++)
        {

         if(::CheckPointer(m_wnd[w].m_elements[e])==POINTER_INVALID)
            continue;

         m_wnd[w].m_elements[e].Delete();
        }

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

   ::ArrayFree(m_wnd);
   ::ArrayFree(m_windows);
  }
//+------------------------------------------------------------------+
//| Óñòàíàâëèâàåò ñîñòîÿíèå ãðàôèêà                                  |
//+------------------------------------------------------------------+
void CWndEvents::SetChartState(void)
  {
   int awi=m_active_window_index;
//--- Äëÿ îïðåäåëåíèÿ ñîáûòèÿ, êîãäà íóæíî îòêëþ÷èòü óïðàâëåíèå
   bool condition=false;
//--- Ïðîâåðèì îêíà
   int windows_total=CWndContainer::WindowsTotal();
   for(int i=0; i<windows_total; i++)
     {
      //--- Ïåðåéòè ê ñëåäóþùåé, åñëè ýòà ôîðìà ñêðûòà
      if(!m_windows[i].IsVisible())
         continue;
      //--- Ïðîâåðèòü óñëîâèÿ âî âíóòðåííåì îáðàáîò÷èêå ôîðìû
      m_windows[i].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
      //--- Åñëè åñòü ôîêóñ, îòìåòèì ýòî
      if(m_windows[i].MouseFocus())
        {
         condition=true;
         break;
        }
     }
//--- Ïðîâåðèì âûïàäàþùèå ñïèñêè
   if(!condition)
     {
      //--- Ïîëó÷èì îáùåå êîëè÷åñòâî âûïàäàþùèõ ñïèñêîâ
      int drop_lists_total=CWndContainer::DropListsTotal(awi);
      for(int i=0; i<drop_lists_total; i++)
        {
         //--- Ïîëó÷èì óêàçàòåëü íà âûïàäàþùèé ñïèñîê
         CListView *lv=m_wnd[awi].m_drop_lists[i];
         //--- Åñëè ñïèñîê àêòèâèðîâàí (îòêðûò)
         if(lv.IsVisible())
           {
            //--- Ïðîâåðèì ôîêóñ íàä ñïèñêîì è ñîñòîÿíèå åãî ïîëîñû ïðîêðóòêè
            if(m_wnd[awi].m_drop_lists[i].MouseFocus() || lv.ScrollState())
              {
               condition=true;
               break;
              }
           }
        }
     }
//--- Ïðîâåðèì êàëåíäàðè
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
//--- Ïðîâåðèì ôîêóñ êîíòåêñòíûõ ìåíþ
   if(!condition)
     {
      //--- Ïîëó÷èì îáùåå êîëè÷åñòâî âûïàäàþùèõ êîíòåêñòíûõ ìåíþ
      int context_menus_total=CWndContainer::ContextMenusTotal(awi);
      for(int i=0; i<context_menus_total; i++)
        {
         //--- Åñëè ôîêóñ íàä êîíòåêñíûì ìåíþ
         if(m_wnd[awi].m_context_menus[i].MouseFocus())
           {
            condition=true;
            break;
           }
        }
     }
//--- Ïðîâåðèì ñîñòîÿíèå ïîëîñ ïðîêðóòêè
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
//--- Óñòàíàâëèâàåì ñîñòîÿíèå ãðàôèêà âî âñåõ ôîðìàõ
   for(int i=0; i<windows_total; i++)
      m_windows[i].CustomEventChartState(condition);
  }
//+------------------------------------------------------------------+
