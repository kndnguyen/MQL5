//+------------------------------------------------------------------+
//|                                                    WndEvents.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Defines.mqh"
#include "WndContainer.mqh"
#include <Charts\Chart.mqh>
//+------------------------------------------------------------------+
//| Класс для обработки событий                                      |
//+------------------------------------------------------------------+
class CWndEvents : public CWndContainer
  {
protected:
   CChart            m_chart;
   //--- Идентификатор и номер окна графика
   long              m_chart_id;
   int               m_subwin;
   //--- Имя программы
   string            m_program_name;
   //--- Короткое имя индикатора
   string            m_indicator_shortname;
   //--- Индекс активного окна
   int               m_active_window_index;
   //---
private:
   //--- Параметры событий
   int               m_id;
   long              m_lparam;
   double            m_dparam;
   string            m_sparam;
   //---
protected:
                     CWndEvents(void);
                    ~CWndEvents(void);
   //--- Виртуальный обработчик события графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- Таймер
   void              OnTimerEvent(void);
   //---
public:
   //--- Обработчики событий графика
   void              ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
private:
   void              ChartEventCustom(void);
   void              ChartEventClick(void);
   void              ChartEventMouseMove(void);
   void              ChartEventObjectClick(void);
   void              ChartEventEndEdit(void);
   void              ChartEventChartChange(void);
   //--- Проверка событий в элементах управления
   void              CheckElementsEvents(void);
   //--- Определение номера подокна
   void              DetermineSubwindow(void);
   //--- Проверка событий элементов управления
   void              CheckSubwindowNumber(void);
   //--- Инициализация параметров событий
   void              InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam);
   //--- Перемещение окна
   void              MovingWindow(void);
   //--- Проверка событий всех элементов по таймеру
   void              CheckElementsEventsTimer(void);
   //--- Установка состояния графика
   void              SetChartState(void);
   //---
protected:
   //--- Удаление интерфейса
   void              Destroy(void);
   //---
private:
   //--- Сворачивание/разворачивание формы
   bool              OnWindowRollUp(void);
   bool              OnWindowUnroll(void);
   //--- Скрытие всех контекстных меню от пункта инициатора
   bool              OnHideBackContextMenus(void);
   //--- Скрытие всех контекстных меню
   bool              OnHideContextMenus(void);

   //--- Открытие диалогового окна
   bool              OnOpenDialogBox(void);
   //--- Закрытие диалогового окна
   bool              OnCloseDialogBox(void);
   //--- Сброс цвета формы и её элементов
   bool              OnResetWindowColors(void);
   //--- Сброс приоритетов на нажатие левой кнопкой мыши
   bool              OnZeroPriorities(void);
   //--- Восстановление приоритетов на нажатие левой кнопкой мыши
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
//--- Включим таймер
   if(!::MQLInfoInteger(MQL_TESTER))
      ::EventSetMillisecondTimer(TIMER_STEP_MSC);
//--- Получим ID текущего графика
   m_chart.Attach();
//--- Включим слежение за событиями мыши
   m_chart.EventMouseMove(true);
//--- Определение номера подокна
   DetermineSubwindow();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CWndEvents::~CWndEvents(void)
  {
//--- Удалить таймер
   ::EventKillTimer();
//--- Включим управление
   m_chart.MouseScroll(true);
   m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
//--- Отключим слежение за событиями мыши
   m_chart.EventMouseMove(false);
//--- Отсоединиться от графика
   m_chart.Detach();
//--- Стереть коммент   
   ::Comment("");
  }
//+------------------------------------------------------------------+
//| Инициализация событийных переменных                              |
//+------------------------------------------------------------------+
void CWndEvents::InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam)
  {
   m_id     =id;
   m_lparam =lparam;
   m_dparam =dparam;
   m_sparam =sparam;
  }
//+------------------------------------------------------------------+
//| Обработка событий программы                                      |
//+------------------------------------------------------------------+
void CWndEvents::ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Если массив пуст, выйдем
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- Инициализация полей параметров событий
   InitChartEventsParams(id,lparam,dparam,sparam);
//--- Пользовательские события
   ChartEventCustom();
//--- Проверка событий элементов интерфейса
   CheckElementsEvents();
//--- Событие перемещения мыши
   ChartEventMouseMove();
//--- Событие изменения свойств графика
   ChartEventChartChange();
  }
//+------------------------------------------------------------------+
//| Проверка событий элементов управления                            |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEvents(void)
  {
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
//--- Направление события в файл приложения
   OnEvent(m_id,m_lparam,m_dparam,m_sparam);
  }
//+------------------------------------------------------------------+
//| Событие CHARTEVENT_CUSTOM                                        |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventCustom(void)
  {
//--- Если сигнал свернуть форму
   if(OnWindowRollUp())
      return;
//--- Если сигнал развернуть форму
   if(OnWindowUnroll())
      return;
//--- Если сигнал на скрытие контекстных меню от пункта инициатора
   if(OnHideBackContextMenus())
      return;
//--- Если сигнал на скрытие всех контекстных меню
   if(OnHideContextMenus())
      return;

//--- Если сигнал на открытие диалогового окна
   if(OnOpenDialogBox())
      return;
//--- Если сигнал на закрытие диалогового окна
   if(OnCloseDialogBox())
      return;
//--- Если сигнал на сброс цвета элементов на указанной форме
   if(OnResetWindowColors())
      return;
//--- Если сигнал на сброс приоритетов на нажатие левой кнопкой мыши
   if(OnZeroPriorities())
      return;
//--- Если сигнал на восстановление приоритетов на нажатие левой кнопкой мыши
   if(OnSetPriorities())
      return;
  }
//+------------------------------------------------------------------+
//| Событие ON_WINDOW_ROLLUP                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowRollUp(void)
  {
//--- Если сигнал свернуть форму
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_ROLLUP)
      return(false);
//--- Если идентификатор окна и номер подокна совпадают
   if(m_lparam==m_windows[0].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(0);
      for(int e=0; e<elements_total; e++)
        {
         //--- Скрыть все элементы кроме формы
         if(m_wnd[0].m_elements[e].ClassName()!="CWindow")
            m_wnd[0].m_elements[e].Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие ON_WINDOW_UNROLL                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowUnroll(void)
  {
//--- Если сигнал "Развернуть форму"
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
      return(false);
//--- Индекс активного окна
   int awi=m_active_window_index;
//--- Если идентификатор окна и номер подокна совпадают
   if(m_lparam==m_windows[awi].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(awi);
      for(int e=0; e<elements_total; e++)
        {
         //--- Сделать видимыми все элементы кроме формы и ...
         if(m_wnd[awi].m_elements[e].ClassName()!="CWindow")
           {
            //--- ... тех элементов, которые являются выпадающими
            if(!m_wnd[awi].m_elements[e].IsDropdown())
               m_wnd[awi].m_elements[e].Show();
           }
        }
      //--- Если есть вкладки, то показать элементы только выделенной
      int tabs_total=CWndContainer::TabsTotal(awi);
      for(int t=0; t<tabs_total; t++)
         m_wnd[awi].m_tabs[t].ShowTabElements();
      //--- Если есть древовидные списки, то показать элементы только выделенного пункта-вкладки
      int treeview_total=CWndContainer::TreeViewListsTotal(awi);
      for(int tv=0; tv<treeview_total; tv++)
         m_wnd[awi].m_treeview_lists[tv].ShowTabElements();
     }
//--- Обновить расположение всех элементов
   MovingWindow();
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие ON_HIDE_BACK_CONTEXTMENUS                                |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideBackContextMenus(void)
  {
//--- Если сигнал на скрытие контекстных меню от пункта инициатора
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_BACK_CONTEXTMENUS)
      return(false);
//--- Пройдём по всем меню от последнего вызванного
   int awi=m_active_window_index;
   int context_menus_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=context_menus_total-1; i>=0; i--)
     {
      //--- Указатели контекстного меню и его предыдущего узла
      CContextMenu *cm=m_wnd[awi].m_context_menus[i];
      CMenuItem    *mi=cm.PrevNodePointer();
      //--- Если дальше этого пункта больше ничего нет, то...
      if(::CheckPointer(mi)==POINTER_INVALID)
         continue;
      //--- Если дошли до пункта инициатора сигнала, то...
      if(mi.Id()==m_lparam)
        {
         //--- ...в случае, если его контекстное меню без фокуса, скроем его
         if(!cm.MouseFocus())
            cm.Hide();
         //--- Если дальше этого пункта больше ничего нет, то...
         if(::CheckPointer(mi.PrevNodePointer())==POINTER_INVALID)
           {
            //--- ...разблокируем окно
            m_windows[awi].IsLocked(false);
           }
         //--- Завершим цикл
         break;
        }
      else
        {
         //--- Скрыть контекстное меню
         cm.Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие ON_HIDE_CONTEXTMENUS                                     |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideContextMenus(void)
  {
//--- Если сигнал на скрытие всех контекстных меню
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_CONTEXTMENUS)
      return(false);
//--- Скрыть все контекстные меню
   int awi=m_active_window_index;
   int cm_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=0; i<cm_total; i++)
      m_wnd[awi].m_context_menus[i].Hide();
//--- Отключить главные меню
   int menu_bars_total=CWndContainer::MenuBarsTotal(awi);
   for(int i=0; i<menu_bars_total; i++)
      m_wnd[awi].m_menu_bars[i].State(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие ON_OPEN_DIALOG_BOX                                       |
//+------------------------------------------------------------------+
bool CWndEvents::OnOpenDialogBox(void)
  {
//--- Если сигнал на открытие диалогового окна
   if(m_id!=CHARTEVENT_CUSTOM+ON_OPEN_DIALOG_BOX)
      return(false);
//--- Выйти, если сообщение от другой программы
   if(m_sparam!=m_program_name)
      return(true);
//--- Пройдёмся по массиву окон
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- Если идентификаторы совпадают
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Запомним в этой форме индекс окна, с которого она была вызвана
         m_windows[w].PrevActiveWindowIndex(m_active_window_index);
         //--- Активируем форму
         m_windows[w].State(true);
         //--- Восстановим объектам формы приоритеты на нажатие левой кнопкой мыши
         m_windows[w].SetZorders();
         //--- Запомним индекс активированного окна
         m_active_window_index=w;
         //--- Сделать видимыми все элементы активированного окна
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
           {
            //--- Пропускаем формы и выпадающие элементы
            if(m_wnd[w].m_elements[e].ClassName()=="CWindow" || 
               m_wnd[w].m_elements[e].IsDropdown())
               continue;
            //--- Сделать видимым элемент
            m_wnd[w].m_elements[e].Show();
            //--- Восстановить элементу приоритет на нажатие левой кнопкой мыши
            m_wnd[w].m_elements[e].SetZorders();
           }
         //--- Скрытие всплывающих подсказок
         int tooltips_total=CWndContainer::TooltipsTotal(m_windows[w].PrevActiveWindowIndex());
         for(int t=0; t<tooltips_total; t++)
            m_wnd[m_windows[w].PrevActiveWindowIndex()].m_tooltips[t].FadeOutTooltip();
         //--- Если есть вкладки, то показать элементы только выделенной
         int tabs_total=CWndContainer::TabsTotal(w);
         for(int t=0; t<tabs_total; t++)
            m_wnd[w].m_tabs[t].ShowTabElements();
         //--- Если есть древовидные списки, то показать элементы только выделенного пункта-вкладки
         int treeview_total=CWndContainer::TreeViewListsTotal(w);
         for(int tv=0; tv<tabs_total; tv++)
            m_wnd[w].m_treeview_lists[tv].ShowTabElements();
        }
      //--- Другие формы будут заблокированы, пока не закроется активированное окно
      else
        {
         //--- Заблокируем форму
         m_windows[w].State(false);
         //--- Обнулим приоритеты элементов формы на нажатие левой кнопкой мыши
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].ResetZorders();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие ON_CLOSE_DIALOG_BOX                                      |
//+------------------------------------------------------------------+
bool CWndEvents::OnCloseDialogBox(void)
  {
//--- Если сигнал на закрытие диалогового окна
   if(m_id!=CHARTEVENT_CUSTOM+ON_CLOSE_DIALOG_BOX)
      return(false);
//--- Пройдёмся по массиву окон
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- Если идентификаторы совпадают
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Заблокируем форму
         m_windows[w].State(false);
         //--- Спрячем форму
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].Hide();
         //--- Активируем предыдущую форму
         m_windows[int(m_dparam)].State(true);
         //--- Перерисовка графика
         m_chart.Redraw();
         break;
        }
     }
//--- Установка индекса предыдущего окна
   m_active_window_index=int(m_dparam);
//--- Восстановление приоритетов на нажатие левой кнопкой мыши у активированного окна
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].SetZorders();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие ON_RESET_WINDOW_COLORS                                   |
//+------------------------------------------------------------------+
bool CWndEvents::OnResetWindowColors(void)
  {
//--- Если сигнал на сброс цвета окна
   if(m_id!=CHARTEVENT_CUSTOM+ON_RESET_WINDOW_COLORS)
      return(false);
//--- Для определения индекса формы, от которого пришло сообщение
   int index=WRONG_VALUE;
//--- Пройдёмся по массиву окон
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- Если идентификаторы совпадают
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Запомним индекс
         index=w;
         //--- Сбросим цвет формы
         m_windows[w].ResetColors();
         break;
        }
     }
//--- Выйдем, если индекс не определён
   if(index==WRONG_VALUE)
      return(true);
//--- Сбросим цвета у всех элементов формы
   int elements_total=CWndContainer::ElementsTotal(index);
   for(int e=0; e<elements_total; e++)
      m_wnd[index].m_elements[e].ResetColors();
//--- Перерисовка графика
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие ON_ZERO_PRIORITIES                                       |
//+------------------------------------------------------------------+
bool CWndEvents::OnZeroPriorities(void)
  {
//--- Если сигнал на обнуление приоритетов на нажатие левой кнопкой мыши
   if(m_id!=CHARTEVENT_CUSTOM+ON_ZERO_PRIORITIES)
      return(false);
//---
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
     {
      //--- Обнулить приоритеты всех элементов кроме того, чей id был передан в событии и ...
      if(m_lparam!=m_wnd[m_active_window_index].m_elements[e].Id())
        {
         //--- ... кроме контекстных меню
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
//| Событие ON_SET_PRIORITIES                                        |
//+------------------------------------------------------------------+
bool CWndEvents::OnSetPriorities(void)
  {
//--- Если сигнал на восстановление приоритетов на нажатие левой кнопкой мыши
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
//| Событие CHARTEVENT CLICK                                         |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventClick(void)
  {
  }
//+------------------------------------------------------------------+
//| Событие CHARTEVENT MOUSE MOVE                                    |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventMouseMove(void)
  {
//--- Выйти, если это не событие перемещения курсора
   if(m_id!=CHARTEVENT_MOUSE_MOVE)
      return;
//--- Перемещение окна
   MovingWindow();
//--- Установка состояния графика
   SetChartState();
//--- Перерисуем график
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Событие CHARTEVENT OBJECT CLICK                                  |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventObjectClick(void)
  {
  }
//+------------------------------------------------------------------+
//| Событие CHARTEVENT OBJECT ENDEDIT                                |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventEndEdit(void)
  {
  }
//+------------------------------------------------------------------+
//| Событие CHARTEVENT CHART CHANGE                                  |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventChartChange(void)
  {
//--- Событие изменения свойств графика
   if(m_id!=CHARTEVENT_CHART_CHANGE)
      return;
//--- Проверка и обновление номера окна программы
   CheckSubwindowNumber();
//--- Перемещение окна
   MovingWindow();
//--- Перерисуем график
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CWndEvents::OnTimerEvent(void)
  {
//--- Если массив пуст, выйдем  
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- Проверка событий всех элементов по таймеру
   CheckElementsEventsTimer();
//--- Перерисуем график
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Перемещение окна                                                 |
//+------------------------------------------------------------------+
void CWndEvents::MovingWindow(void)
  {
   int awi=m_active_window_index;
//--- Перемещение окна
   int x=m_windows[awi].X();
   int y=m_windows[awi].Y();
   m_windows[awi].Moving(x,y);
//--- Перемещение элементов управления
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| Проверка событий всех элементов по таймеру                       |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEventsTimer(void)
  {
   int awi=m_active_window_index;
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].OnEventTimer();
  }
//+------------------------------------------------------------------+
//| Определение номера подокна                                       |
//+------------------------------------------------------------------+
void CWndEvents::DetermineSubwindow(void)
  {
//--- Если тип программы не индикатор, выйдем
   if(PROGRAM_TYPE!=PROGRAM_INDICATOR)
      return;
//--- Сброс последней ошибки
   ::ResetLastError();
//--- Определение номера окна индикатора
   m_subwin=::ChartWindowFind();
//--- Если не получилось определить номер, выйдем
   if(m_subwin<0)
     {
      ::Print(__FUNCTION__," > Ошибка при определении номера подокна: ",::GetLastError());
      return;
     }
//--- Если это не главное окно графика
   if(m_subwin>0)
     {
      //--- Получим общее количество индикаторов в указанном подокне
      int total=::ChartIndicatorsTotal(m_chart_id,m_subwin);
      //--- Получим короткое имя последнего индикатора в списке
      string indicator_name=::ChartIndicatorName(m_chart_id,m_subwin,total-1);
      //--- Если в подокне уже есть индикатор, то удалить программу с графика
      if(total!=1)
        {
         ::Print(__FUNCTION__," > В этом подокне уже есть индикатор.");
         ::ChartIndicatorDelete(m_chart_id,m_subwin,indicator_name);
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| Проверка и обновление номера окна программы                      |
//+------------------------------------------------------------------+
void CWndEvents::CheckSubwindowNumber(void)
  {
//--- Если программа в подокне и номера не совпадают
   if(m_subwin!=0 && m_subwin!=::ChartWindowFind())
     {
      //--- Определить номер подокна
      DetermineSubwindow();
      //--- Сохранить во всех элементах
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
//| Удаление всех объектов                                           |
//+------------------------------------------------------------------+
void CWndEvents::Destroy(void)
  {
//--- Установим индекс главного окна
   m_active_window_index=0;
//--- Получим количество окон
   int window_total=CWndContainer::WindowsTotal();
//--- Пройдёмся по массиву окон
   for(int w=0; w<window_total; w++)
     {
      //--- Активируем главное окно
      if(m_windows[w].WindowType()==W_MAIN)
         m_windows[w].State(true);
      //--- Заблокируем диалоговые окна
      else
         m_windows[w].State(false);
     }
//--- Освободим массивы элементов
   for(int w=0; w<window_total; w++)
     {
      int elements_total=CWndContainer::ElementsTotal(w);
      for(int e=0; e<elements_total; e++)
        {
         //--- Если указатель невалидный, перейти к следующему
         if(::CheckPointer(m_wnd[w].m_elements[e])==POINTER_INVALID)
            continue;
         //--- Удалить объекты элемента
         m_wnd[w].m_elements[e].Delete();
        }
      //--- Освободить массивы элементов
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
//--- Освободить массивы форм
   ::ArrayFree(m_wnd);
   ::ArrayFree(m_windows);
  }
//+------------------------------------------------------------------+
//| Устанавливает состояние графика                                  |
//+------------------------------------------------------------------+
void CWndEvents::SetChartState(void)
  {
   int awi=m_active_window_index;
//--- Для определения события, когда нужно отключить управление
   bool condition=false;
//--- Проверим окна
   int windows_total=CWndContainer::WindowsTotal();
   for(int i=0; i<windows_total; i++)
     {
      //--- Перейти к следующей, если эта форма скрыта
      if(!m_windows[i].IsVisible())
         continue;
      //--- Проверить условия во внутреннем обработчике формы
      m_windows[i].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
      //--- Если есть фокус, отметим это
      if(m_windows[i].MouseFocus())
        {
         condition=true;
         break;
        }
     }
//--- Проверим выпадающие списки
   if(!condition)
     {
      //--- Получим общее количество выпадающих списков
      int drop_lists_total=CWndContainer::DropListsTotal(awi);
      for(int i=0; i<drop_lists_total; i++)
        {
         //--- Получим указатель на выпадающий список
         CListView *lv=m_wnd[awi].m_drop_lists[i];
         //--- Если список активирован (открыт)
         if(lv.IsVisible())
           {
            //--- Проверим фокус над списком и состояние его полосы прокрутки
            if(m_wnd[awi].m_drop_lists[i].MouseFocus() || lv.ScrollState())
              {
               condition=true;
               break;
              }
           }
        }
     }
//--- Проверим календари
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
//--- Проверим фокус контекстных меню
   if(!condition)
     {
      //--- Получим общее количество выпадающих контекстных меню
      int context_menus_total=CWndContainer::ContextMenusTotal(awi);
      for(int i=0; i<context_menus_total; i++)
        {
         //--- Если фокус над контексным меню
         if(m_wnd[awi].m_context_menus[i].MouseFocus())
           {
            condition=true;
            break;
           }
        }
     }
//--- Проверим состояние полос прокрутки
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
//--- Устанавливаем состояние графика во всех формах
   for(int i=0; i<windows_total; i++)
      m_windows[i].CustomEventChartState(condition);
  }
//+------------------------------------------------------------------+
