//+------------------------------------------------------------------+
//|                                                 WndContainer.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property strict
#include "Window.mqh"
#include "MenuBar.mqh"
#include "MenuItem.mqh"
#include "ContextMenu.mqh"
#include "SeparateLine.mqh"
#include "SimpleButton.mqh"
#include "IconButton.mqh"
#include "SplitButton.mqh"
#include "ButtonsGroup.mqh"
#include "IconButtonsGroup.mqh"
#include "RadioButtons.mqh"
#include "StatusBar.mqh"
#include "Tooltip.mqh"
#include "ListView.mqh"
#include "ComboBox.mqh"
#include "CheckBox.mqh"
#include "SpinEdit.mqh"
#include "CheckBoxEdit.mqh"
#include "CheckComboBox.mqh"
#include "Slider.mqh"
#include "DualSlider.mqh"
#include "LabelsTable.mqh"
#include "Table.mqh"
#include "CanvasTable.mqh"
#include "Tabs.mqh"
#include "IconTabs.mqh"
#include "Calendar.mqh"
#include "DropCalendar.mqh"
#include "TreeItem.mqh"
#include "TreeView.mqh"
#include "FileNavigator.mqh"
#include "ColorButton.mqh"
#include "ColorPicker.mqh"
#include "ProgressBar.mqh"
#include "LineGraph.mqh"
//+------------------------------------------------------------------+
//| Класс для хранения всех объектов интерфейса                      |
//+------------------------------------------------------------------+
class CWndContainer
  {
private:
   //--- Счётчик элементов
   int               m_counter_element_id;
   //---
protected:
   //--- Массив окон
   CWindow          *m_windows[];
   //--- Структура массивов элементов
   struct WindowElements
     {
      //--- Общий массив всех объектов
      CChartObject     *m_objects[];
      //--- Общий массив всех элементов
      CElement         *m_elements[];

      //--- Персональные массивы элементов:
      //    Массив контекстных меню
      CContextMenu     *m_context_menus[];
      //--- Массив главных меню
      CMenuBar         *m_menu_bars[];
      //--- Всплывающие подсказки
      CTooltip         *m_tooltips[];
      //--- Массив выпадающих списков разных типов
      CElement         *m_drop_lists[];
      //--- Массив полос прокрутки
      CElement         *m_scrolls[];
      //--- Массив таблиц из текстовых меток
      CElement         *m_labels_tables[];
      //--- Массив таблиц из полей ввода
      CElement         *m_tables[];
      //--- Массив нарисованных таблиц
      CElement         *m_canvas_tables[];
      //--- Массив вкладок
      CTabs            *m_tabs[];
      //--- Массив календарей
      CCalendar        *m_calendars[];
      //--- Массив выпадающих календарей
      CDropCalendar    *m_drop_calendars[];
      //--- Древовидные списки
      CTreeView        *m_treeview_lists[];
      //--- Файловые навигаторы
      CFileNavigator   *m_file_navigators[];
     };
   //--- Массив массивов элементов для каждого окна
   WindowElements    m_wnd[];
   //---
protected:
                     CWndContainer(void);
                    ~CWndContainer(void);
   //---
public:
   //--- Количество окон в интерфейсе
   int               WindowsTotal(void) { return(::ArraySize(m_windows)); }
   //--- Количество объектов всех элементов
   int               ObjectsElementsTotal(const int window_index);
   //--- Количество элементов
   int               ElementsTotal(const int window_index);
   //--- Количество контекстных меню
   int               ContextMenusTotal(const int window_index);
   //--- Количество главных меню
   int               MenuBarsTotal(const int window_index);
   //--- Количество всплывающих подсказок
   int               TooltipsTotal(const int window_index);
   //--- Количество выпадающих списков
   int               DropListsTotal(const int window_index);
   //--- Количество полос прокрутки
   int               ScrollsTotal(const int window_index);
   //--- Количество таблиц из текстовых меток
   int               LabelsTablesTotal(const int window_index);
   //--- Количество таблиц из полей ввода
   int               TablesTotal(const int window_index);
   //--- Количество нарисованных таблиц
   int               CanvasTablesTotal(const int window_index);
   //--- Количество вкладок
   int               TabsTotal(const int window_index);
   //--- Количество календарей
   int               CalendarsTotal(const int window_index);
   //--- Количество выпадающих календарей
   int               DropCalendarsTotal(const int window_index);
   //--- Количество древовидных списков
   int               TreeViewListsTotal(const int window_index);
   //--- Количество файловых навигаторов
   int               FileNavigatorsTotal(const int window_index);
   //---
protected:
   //--- Добавляет указатель окна в базу элементов интерфейса
   void              AddWindow(CWindow &object);
   //--- Добавляет указатели объектов элемента в общий массив
   template<typename T>
   void              AddToObjectsArray(const int window_index,T &object);
   //--- Добавляет указатель объекта в массив
   void              AddToArray(const int window_index,CChartObject &object);
   //--- Добавляет указатель в массив элементов
   void              AddToElementsArray(const int window_index,CElement &object);
   //--- Шаблонный метод для добавления указателей в переданный по ссылке массив
   template<typename T1,typename T2>
   void              AddToRefArray(T1 &object,T2 &ref_array[]);
   //---
private:
   //--- Сохраняет указатели на элементы контекстного меню
   bool              AddContextMenuElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы главного меню
   bool              AddMenuBarElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы сдвоенной кнопки
   bool              AddSplitButtonElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы всплывающих подсказок
   bool              AddTooltipElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на объекты списка
   bool              AddListViewElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы выпадающих списков (комбо-бокс)
   bool              AddComboBoxElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы выпадающих списков (комбо-бокс с чек-боксом)
   bool              AddCheckComboBoxElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы таблицы из текстовых меток
   bool              AddLabelsTableElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы таблицы из полей ввода
   bool              AddTableElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы нарисованной таблицы
   bool              AddCanvasTableElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на вкладки в персональный массив
   bool              AddTabsElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы календаря
   bool              AddCalendarElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы выпадающего календаря
   bool              AddDropCalendarElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы древовидных списков
   bool              AddTreeViewListsElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы древовидного списка
   bool              AddFileNavigatorElements(const int window_index,CElement &object);
   //--- Сохраняет указатели на элементы цветовой палитры
   bool              AddColorPickersElements(const int window_index,CElement &object);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CWndContainer::CWndContainer(void) : m_counter_element_id(0)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CWndContainer::~CWndContainer(void)
  {
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во объектов по указанному индексу окна            |
//+------------------------------------------------------------------+
int CWndContainer::ObjectsElementsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_objects));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во элементов по указанному индексу окна           |
//+------------------------------------------------------------------+
int CWndContainer::ElementsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_elements));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во контекстных меню по указанному индексу окна    |
//+------------------------------------------------------------------+
int CWndContainer::ContextMenusTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_context_menus));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во главных меню по указанному индексу окна        |
//+------------------------------------------------------------------+
int CWndContainer::MenuBarsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_menu_bars));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во подсказок по указанному индексу окна           |
//+------------------------------------------------------------------+
int CWndContainer::TooltipsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_tooltips));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во выпадающих списков по указанному индексу окна  |
//+------------------------------------------------------------------+
int CWndContainer::DropListsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_drop_lists));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во полос прокрутки по указанному индексу окна     |
//+------------------------------------------------------------------+
int CWndContainer::ScrollsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_scrolls));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во таблиц из текстовых меток                      |
//| по указанному индексу окна                                       |
//+------------------------------------------------------------------+
int CWndContainer::LabelsTablesTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_labels_tables));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во таблиц по указанному индексу окна              |
//+------------------------------------------------------------------+
int CWndContainer::TablesTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_tables));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во нарисованных таблиц по указанному индексу окна |
//+------------------------------------------------------------------+
int CWndContainer::CanvasTablesTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_canvas_tables));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во групп вкладок по указанному индексу окна       |
//+------------------------------------------------------------------+
int CWndContainer::TabsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_tabs));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во календарей по указанному индексу окна          |
//+------------------------------------------------------------------+
int CWndContainer::CalendarsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_calendars));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во выпадающих календарей                          |
//| по указанному индексу окна                                       |
//+------------------------------------------------------------------+
int CWndContainer::DropCalendarsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_drop_calendars));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во древовидных списков по указанному индексу окна |
//+------------------------------------------------------------------+
int CWndContainer::TreeViewListsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_treeview_lists));
  }
//+------------------------------------------------------------------+
//| Возвращает кол-во файловых навигаторов                           |
//| по указанному индексу окна                                       |
//+------------------------------------------------------------------+
int CWndContainer::FileNavigatorsTotal(const int window_index)
  {
   if(window_index>=::ArraySize(m_wnd))
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//---
   return(::ArraySize(m_wnd[window_index].m_file_navigators));
  }
//+------------------------------------------------------------------+
//| Добавляет указатель окна в базу элементов интерфейса             |
//+------------------------------------------------------------------+
void CWndContainer::AddWindow(CWindow &object)
  {
   int windows_total=::ArraySize(m_windows);
//--- Если окон нет, обнулим счётчик элементов
   if(windows_total<1)
      m_counter_element_id=0;
//--- Добавим указатель в массив окон
   ::ArrayResize(m_wnd,windows_total+1);
   ::ArrayResize(m_windows,windows_total+1);
   m_windows[windows_total]=::GetPointer(object);
//--- Добавим указатель в общий массив элементов
   int elements_total=::ArraySize(m_wnd[windows_total].m_elements);
   ::ArrayResize(m_wnd[windows_total].m_elements,elements_total+1);
   m_wnd[windows_total].m_elements[elements_total]=::GetPointer(object);
//--- Добавим объекты элемента в общий массив объектов
   AddToObjectsArray(windows_total,object);
//--- Установим идентификатор и запомним id последнего элемента
   m_windows[windows_total].Id(m_counter_element_id);
   m_windows[windows_total].LastId(m_counter_element_id);
//--- Увеличим счётчик идентификаторов элементов
   m_counter_element_id++;
  }
//+------------------------------------------------------------------+
//| Добавляет указатели объектов элемента в общий массив             |
//+------------------------------------------------------------------+
template<typename T>
void CWndContainer::AddToObjectsArray(const int window_index,T &object)
  {
   int total=object.ObjectsElementTotal();
   for(int i=0; i<total; i++)
      AddToArray(window_index,object.Object(i));
  }
//+------------------------------------------------------------------+
//| Добавляет указатель объекта в массив                             |
//+------------------------------------------------------------------+
void CWndContainer::AddToArray(const int window_index,CChartObject &object)
  {
   int size=::ArraySize(m_wnd[window_index].m_objects);
   ::ArrayResize(m_wnd[window_index].m_objects,size+1);
   m_wnd[window_index].m_objects[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| Добавляет указатель в массив элементов                           |
//+------------------------------------------------------------------+
void CWndContainer::AddToElementsArray(const int window_index,CElement &object)
  {
//--- Если в базе нет форм для элементов управления
   if(::ArraySize(m_windows)<1)
     {
      ::Print(__FUNCTION__," > Перед созданием элемента управления нужно создать форму "
              "и добавить её в базу с помощью метода CWndContainer::AddWindow(CWindow &object).");
      return;
     }
//--- Если запрос на несуществующую форму
   if(window_index>=::ArraySize(m_windows))
     {
      Print(PREVENTING_OUT_OF_RANGE," window_index: ",window_index,"; ArraySize(m_windows): ",::ArraySize(m_windows));
      return;
     }
//--- Добавим в общий массив элементов
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
   m_wnd[window_index].m_elements[size]=::GetPointer(object);
//--- Добавим объекты элемента в общий массив объектов
   AddToObjectsArray(window_index,object);
//--- Запомним во всех формах id последнего элемента
   int windows_total=::ArraySize(m_windows);
   for(int w=0; w<windows_total; w++)
      m_windows[w].LastId(m_counter_element_id);
//--- Увеличим счётчик идентификаторов элементов
   m_counter_element_id++;
//--- Сохраняет указатели на объекты контекстного меню
   if(AddContextMenuElements(window_index,object))
      return;
//--- Сохраняет указатели на объекты главного меню
   if(AddMenuBarElements(window_index,object))
      return;
//--- Сохраняет указатели на объекты сдвоенной кнопки
   if(AddSplitButtonElements(window_index,object))
      return;
//--- Сохраняет указатели на объекты всплывающей подсказки
   if(AddTooltipElements(window_index,object))
      return;
//--- Сохраняет указатели на объекты списка в базу
   if(AddListViewElements(window_index,object))
      return;
//--- Сохраняет указатели на объекты элемента комбо-бокса
   if(AddComboBoxElements(window_index,object))
      return;
//--- Сохраняет указатели на объекты элемента комбо-бокса с чек-боксом
   if(AddCheckComboBoxElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы таблицы из текстовых меток
   if(AddLabelsTableElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы таблицы из полей ввода
   if(AddTableElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы нарисованной таблицы
   if(AddCanvasTableElements(window_index,object))
      return;
//--- Сохраняет указатели на вкладки в персональный массив
   if(AddTabsElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы календаря
   if(AddCalendarElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы выпадающего календаря
   if(AddDropCalendarElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы древовидных списков
   if(AddTreeViewListsElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы файлового навигатора
   if(AddFileNavigatorElements(window_index,object))
      return;
//--- Сохраняет указатели на элементы цветовой палитры
   if(AddColorPickersElements(window_index,object))
      return;
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на объекты контекстного меню в базу          |
//+------------------------------------------------------------------+
bool CWndContainer::AddContextMenuElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не контекстное меню
   if(object.ClassName()!="CContextMenu")
      return(false);
//--- Получим указатель на контекстное меню
   CContextMenu *cm=::GetPointer(object);
//--- Сохраним указатели на его объекты в базе
   int items_total=cm.ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Увеличение массива элементов
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- Получение указателя на пункт меню
      CMenuItem *mi=cm.ItemPointerByIndex(i);
      //--- Сохраняем указатель в массив
      m_wnd[window_index].m_elements[size]=mi;
      //--- Добавляем указатели на все объекты пункта меню в общий массив
      AddToObjectsArray(window_index,mi);
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(cm,m_wnd[window_index].m_context_menus);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на объекты главного меню в базу              |
//+------------------------------------------------------------------+
bool CWndContainer::AddMenuBarElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не главное меню
   if(object.ClassName()!="CMenuBar")
      return(false);
//--- Получим указатель на главное меню
   CMenuBar *mb=::GetPointer(object);
//--- Сохраним указатели на его объекты в базе
   int items_total=mb.ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Увеличение массива элементов
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- Получение указателя на пункт меню
      CMenuItem *mi=mb.ItemPointerByIndex(i);
      //--- Сохраняем указатель в массив
      m_wnd[window_index].m_elements[size]=mi;
      //--- Добавляем указатели на все объекты пункта меню в общий массив
      AddToObjectsArray(window_index,mi);
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(mb,m_wnd[window_index].m_menu_bars);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на объекты сдвоенной кнопки в базу           |
//+------------------------------------------------------------------+
bool CWndContainer::AddSplitButtonElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не сдвоенная кнопка
   if(object.ClassName()!="CSplitButton")
      return(false);
//--- Получим указатель на сдвоенную кнопку
   CSplitButton *sb=::GetPointer(object);
//--- Увеличение массива элементов
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
//--- Получим указатель контекстного меню
   CContextMenu *cm=sb.GetContextMenuPointer();
//--- Сохраним элемент и объекты в базу
   m_wnd[window_index].m_elements[size]=cm;
   AddToObjectsArray(window_index,cm);
//--- Сохраним указатели на его объекты в базе
   int items_total=cm.ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Увеличение массива элементов
      size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- Получение указателя на пункт меню
      CMenuItem *mi=cm.ItemPointerByIndex(i);
      //--- Сохраняем указатель в массив
      m_wnd[window_index].m_elements[size]=mi;
      //--- Добавляем указатели на все объекты пункта меню в общий массив
      AddToObjectsArray(window_index,mi);
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(cm,m_wnd[window_index].m_context_menus);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатель на подсказку в персональный массив           |
//+------------------------------------------------------------------+
bool CWndContainer::AddTooltipElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не всплывающая подсказка
   if(object.ClassName()!="CTooltip")
      return(false);
//--- Получим указатель на всплывающую подсказку
   CTooltip *t=::GetPointer(object);
//--- Добавим указатель в персональный массив
   AddToRefArray(t,m_wnd[window_index].m_tooltips);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на объекты списка в базу                     |
//+------------------------------------------------------------------+
bool CWndContainer::AddListViewElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не список
   if(object.ClassName()!="CListView")
      return(false);
//--- Получим указатель на список
   CListView *lv=::GetPointer(object);
//--- Увеличение массива элементов
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
//--- Получим указатель полосы прокрутки
   CScrollV *sv=lv.GetScrollVPointer();
//--- Сохраним элемент в базу
   m_wnd[window_index].m_elements[size]=sv;
   AddToObjectsArray(window_index,sv);
//--- Добавим указатель в персональный массив
   AddToRefArray(sv,m_wnd[window_index].m_scrolls);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатель на выпадающий список в персональный массив   |
//| (комбо-бокс)                                                     |
//+------------------------------------------------------------------+
bool CWndContainer::AddComboBoxElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не комбобокс
   if(object.ClassName()!="CComboBox")
      return(false);
//--- Получим указатель на комбо-бокс
   CComboBox *cb=::GetPointer(object);
//---
   for(int i=0; i<2; i++)
     {
      //--- Увеличение массива элементов
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- Добавим список в базу
      if(i==0)
        {
         CListView *lv=cb.GetListViewPointer();
         m_wnd[window_index].m_elements[size]=lv;
         AddToObjectsArray(window_index,lv);
         //--- Добавим указатель в персональный массив
         AddToRefArray(lv,m_wnd[window_index].m_drop_lists);
        }
      //--- Добавим полосу прокрутки в базу
      else if(i==1)
        {
         CScrollV *sv=cb.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатель на выпадающий список в персональный массив   |
//| (комбо-бокс с чек-боксом)                                        |
//+------------------------------------------------------------------+
bool CWndContainer::AddCheckComboBoxElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не комбобокс с чекбоксом
   if(object.ClassName()!="CCheckComboBox")
      return(false);
//--- Получим указатель на выпадающий список
   CCheckComboBox *ccb=::GetPointer(object);
//---
   for(int i=0; i<2; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      if(i==0)
        {
         CListView *lv=ccb.GetListViewPointer();
         m_wnd[window_index].m_elements[size]=lv;
         AddToObjectsArray(window_index,lv);
         //--- Добавим указатель в персональный массив
         AddToRefArray(lv,m_wnd[window_index].m_drop_lists);
        }
      else if(i==1)
        {
         CScrollV *sv=ccb.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на элементы таблицы из текстовых меток       |
//+------------------------------------------------------------------+
bool CWndContainer::AddLabelsTableElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не таблица из текстовых меток
   if(object.ClassName()!="CLabelsTable")
      return(false);
//--- Получим указатель на таблицу из текстовых меток
   CLabelsTable *lt=::GetPointer(object);
   for(int i=0; i<2; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      if(i==0)
        {
         //--- Получим указатель полосы прокрутки
         CScrollV *sv=lt.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
      else if(i==1)
        {
         CScrollH *sh=lt.GetScrollHPointer();
         m_wnd[window_index].m_elements[size]=sh;
         AddToObjectsArray(window_index,sh);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sh,m_wnd[window_index].m_scrolls);
        }
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(lt,m_wnd[window_index].m_labels_tables);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на элементы таблицы из полей ввода           |
//+------------------------------------------------------------------+
bool CWndContainer::AddTableElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не таблица из текстовых меток
   if(object.ClassName()!="CTable")
      return(false);
//--- Получим указатель на таблицу из текстовых меток
   CTable *te=::GetPointer(object);
   for(int i=0; i<2; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      if(i==0)
        {
         //--- Получим указатель полосы прокрутки
         CScrollV *sv=te.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
      else if(i==1)
        {
         CScrollH *sh=te.GetScrollHPointer();
         m_wnd[window_index].m_elements[size]=sh;
         AddToObjectsArray(window_index,sh);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sh,m_wnd[window_index].m_scrolls);
        }
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(te,m_wnd[window_index].m_tables);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на элементы нарисованной таблицы             |
//+------------------------------------------------------------------+
bool CWndContainer::AddCanvasTableElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не нарисованная таблица
   if(object.ClassName()!="CCanvasTable")
      return(false);
//--- Получим указатель на нарисованную таблицу
   CCanvasTable *ct=::GetPointer(object);
   for(int i=0; i<2; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      if(i==0)
        {
         //--- Получим указатель полосы прокрутки
         CScrollV *sv=ct.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
      else if(i==1)
        {
         CScrollH *sh=ct.GetScrollHPointer();
         m_wnd[window_index].m_elements[size]=sh;
         AddToObjectsArray(window_index,sh);
         //--- Добавим указатель в персональный массив
         AddToRefArray(sh,m_wnd[window_index].m_scrolls);
        }
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(ct,m_wnd[window_index].m_canvas_tables);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на вкладки в персональный массив             |
//+------------------------------------------------------------------+
bool CWndContainer::AddTabsElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не главное меню
   if(object.ClassName()!="CTabs")
      return(false);
//--- Получим указатель на элемент "Вкладки"
   CTabs *tabs=::GetPointer(object);
//--- Добавим указатель в персональный массив
   AddToRefArray(tabs,m_wnd[window_index].m_tabs);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на объекты календаря в базу                  |
//+------------------------------------------------------------------+
bool CWndContainer::AddCalendarElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не календарь
   if(object.ClassName()!="CCalendar")
      return(false);
//--- Получим указатель на элемент "Календарь"
   CCalendar *cal=::GetPointer(object);
//---
   for(int i=0; i<5; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //---
      switch(i)
        {
         case 0 :
           {
            CComboBox *cb=cal.GetComboBoxPointer();
            m_wnd[window_index].m_elements[size]=cb;
            AddToObjectsArray(window_index,cb);
            break;
           }
         case 1 :
           {
            CSpinEdit *se=cal.GetSpinEditPointer();
            m_wnd[window_index].m_elements[size]=se;
            AddToObjectsArray(window_index,se);
            break;
           }
         case 2 :
           {
            CListView *lv=cal.GetListViewPointer();
            m_wnd[window_index].m_elements[size]=lv;
            AddToObjectsArray(window_index,lv);
            break;
           }
         case 3 :
           {
            CScrollV *sv=cal.GetScrollVPointer();
            m_wnd[window_index].m_elements[size]=sv;
            AddToObjectsArray(window_index,sv);
            //--- Добавим указатель в персональный массив
            AddToRefArray(sv,m_wnd[window_index].m_scrolls);
            break;
           }
         case 4 :
           {
            CIconButton *ib=cal.GetIconButtonPointer();
            m_wnd[window_index].m_elements[size]=ib;
            AddToObjectsArray(window_index,ib);
            break;
           }
        }
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(cal,m_wnd[window_index].m_calendars);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на объекты выпадающего календаря в базу      |
//+------------------------------------------------------------------+
bool CWndContainer::AddDropCalendarElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не календарь
   if(object.ClassName()!="CDropCalendar")
      return(false);
//--- Получим указатель на элемент "Выпадающий календарь"
   CDropCalendar *dc=::GetPointer(object);
//--- Добавим указатель в персональный массив
   AddToRefArray(dc,m_wnd[window_index].m_drop_calendars);
//--- Получим указатель на элемент "Календарь"
   CCalendar *cal=dc.GetCalendarPointer();
//--- Увеличение массива элементов
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
//--- Сохраним элемент и объекты в базу
   m_wnd[window_index].m_elements[size]=cal;
   AddToObjectsArray(window_index,cal);
//---
   for(int i=0; i<5; i++)
     {
      size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //---
      switch(i)
        {
         case 0 :
           {
            CComboBox *cb=cal.GetComboBoxPointer();
            m_wnd[window_index].m_elements[size]=cb;
            AddToObjectsArray(window_index,cb);
            break;
           }
         case 1 :
           {
            CSpinEdit *se=cal.GetSpinEditPointer();
            m_wnd[window_index].m_elements[size]=se;
            AddToObjectsArray(window_index,se);
            break;
           }
         case 2 :
           {
            CListView *lv=cal.GetListViewPointer();
            m_wnd[window_index].m_elements[size]=lv;
            AddToObjectsArray(window_index,lv);
            break;
           }
         case 3 :
           {
            CScrollV *sv=cal.GetScrollVPointer();
            m_wnd[window_index].m_elements[size]=sv;
            AddToObjectsArray(window_index,sv);
            //--- Добавим указатель в персональный массив
            AddToRefArray(sv,m_wnd[window_index].m_scrolls);
            break;
           }
         case 4 :
           {
            CIconButton *ib=cal.GetIconButtonPointer();
            m_wnd[window_index].m_elements[size]=ib;
            AddToObjectsArray(window_index,ib);
            break;
           }
        }
     }
//--- Добавим указатель в персональный массив
   AddToRefArray(cal,m_wnd[window_index].m_calendars);
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на элементы древовидного списка              |
//+------------------------------------------------------------------+
bool CWndContainer::AddTreeViewListsElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не древовидный список
   if(object.ClassName()!="CTreeView")
      return(false);
//--- Получим указатель на элемент "Древовидный список"
   CTreeView *tv=::GetPointer(object);
//--- Добавим указатель в персональный массив
   AddToRefArray(tv,m_wnd[window_index].m_treeview_lists);
//--- Размер массива
   int size=0;
//---
   for(int i=0; i<4; i++)
     {
      if(i>1)
        {
         size=::ArraySize(m_wnd[window_index].m_elements);
         ::ArrayResize(m_wnd[window_index].m_elements,size+1);
        }
      //---
      switch(i)
        {
         case 0 :
           {
            for(int j=0; j<tv.ItemsTotal(); j++)
              {
               size=::ArraySize(m_wnd[window_index].m_elements);
               ::ArrayResize(m_wnd[window_index].m_elements,size+1);
               CTreeItem *ti=tv.ItemPointer(j);
               m_wnd[window_index].m_elements[size]=ti;
               AddToObjectsArray(window_index,ti);
              }
            break;
           }
         case 1 :
           {
            for(int j=0; j<tv.ContentItemsTotal(); j++)
              {
               size=::ArraySize(m_wnd[window_index].m_elements);
               ::ArrayResize(m_wnd[window_index].m_elements,size+1);
               CTreeItem *ti=tv.ContentItemPointer(j);
               m_wnd[window_index].m_elements[size]=ti;
               AddToObjectsArray(window_index,ti);
              }
            break;
           }
         case 2 :
           {
            //--- Полосы прокрутки списков
            CScrollV *sv=tv.GetScrollVPointer();
            m_wnd[window_index].m_elements[size]=sv;
            AddToObjectsArray(window_index,sv);
            //--- Добавим указатель в персональный массив
            AddToRefArray(sv,m_wnd[window_index].m_scrolls);
            break;
           }
         case 3 :
           {
            CScrollV *csv=tv.GetContentScrollVPointer();
            m_wnd[window_index].m_elements[size]=csv;
            AddToObjectsArray(window_index,csv);
            //--- Добавим указатель в персональный массив
            AddToRefArray(csv,m_wnd[window_index].m_scrolls);
            break;
           }
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на элементы файлового навигатора             |
//+------------------------------------------------------------------+
bool CWndContainer::AddFileNavigatorElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не файловый навигатор
   if(object.ClassName()!="CFileNavigator")
      return(false);
//--- Получим указатель файлового навигатора
   CFileNavigator *fn=::GetPointer(object);
//--- Добавим указатель в персональный массив
   AddToRefArray(fn,m_wnd[window_index].m_file_navigators);
//--- Сохраним указатель на древовидный список
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
   CTreeView *tv=fn.TreeViewPointer();
   m_wnd[window_index].m_elements[size]=tv;
   AddToObjectsArray(window_index,tv);
//--- Добавим указатель в персональный массив
   AddToRefArray(tv,m_wnd[window_index].m_treeview_lists);
//---
   for(int i=0; i<4; i++)
     {
      if(i>1)
        {
         size=::ArraySize(m_wnd[window_index].m_elements);
         ::ArrayResize(m_wnd[window_index].m_elements,size+1);
        }
      //---
      switch(i)
        {
         case 0 :
           {
            //--- Добавить пункты древовидного списка
            for(int j=0; j<tv.ItemsTotal(); j++)
              {
               size=::ArraySize(m_wnd[window_index].m_elements);
               ::ArrayResize(m_wnd[window_index].m_elements,size+1);
               CTreeItem *ti=tv.ItemPointer(j);
               m_wnd[window_index].m_elements[size]=ti;
               AddToObjectsArray(window_index,ti);
              }
            break;
           }
         case 1 :
           {
            //--- Добавить пункты списка содержания
            for(int j=0; j<tv.ContentItemsTotal(); j++)
              {
               size=::ArraySize(m_wnd[window_index].m_elements);
               ::ArrayResize(m_wnd[window_index].m_elements,size+1);
               CTreeItem *ti=tv.ContentItemPointer(j);
               m_wnd[window_index].m_elements[size]=ti;
               AddToObjectsArray(window_index,ti);
              }
            break;
           }
         case 2 :
           {
            //--- Полосы прокрутки списков
            CScrollV *sv=tv.GetScrollVPointer();
            m_wnd[window_index].m_elements[size]=sv;
            AddToObjectsArray(window_index,sv);
            //--- Добавим указатель в персональный массив
            AddToRefArray(sv,m_wnd[window_index].m_scrolls);
            break;
           }
         case 3 :
           {
            CScrollV *csv=tv.GetContentScrollVPointer();
            m_wnd[window_index].m_elements[size]=csv;
            AddToObjectsArray(window_index,csv);
            //--- Добавим указатель в персональный массив
            AddToRefArray(csv,m_wnd[window_index].m_scrolls);
            break;
           }
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатели на элементы цветовой палитры                 |
//+------------------------------------------------------------------+
bool CWndContainer::AddColorPickersElements(const int window_index,CElement &object)
  {
//--- Выйдем, если это не цветовая палитра
   if(object.ClassName()!="CColorPicker")
      return(false);
//--- Получим указатель на элемент
   CColorPicker *cp=::GetPointer(object);
//---
   for(int i=0; i<12; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //---
      switch(i)
        {
         //--- Добавим в общий массив группу радио-кнопок
         case 0 :
           {
            CRadioButtons *rb=cp.GetRadioButtonsHslPointer();
            m_wnd[window_index].m_elements[size]=rb;
            AddToObjectsArray(window_index,rb);
            break;
           }
         //--- Добавим в общий массив группу полей ввода (1 - 9)
         case 1 :
           {
            CSpinEdit *se1=cp.GetSpinEditHslHPointer();
            m_wnd[window_index].m_elements[size]=se1;
            AddToObjectsArray(window_index,se1);
            break;
           }
         case 2 :
           {
            CSpinEdit *se2=cp.GetSpinEditHslSPointer();
            m_wnd[window_index].m_elements[size]=se2;
            AddToObjectsArray(window_index,se2);
            break;
           }
         case 3 :
           {
            CSpinEdit *se3=cp.GetSpinEditHslLPointer();
            m_wnd[window_index].m_elements[size]=se3;
            AddToObjectsArray(window_index,se3);
            break;
           }
         case 4 :
           {
            CSpinEdit *se4=cp.GetSpinEditRgbRPointer();
            m_wnd[window_index].m_elements[size]=se4;
            AddToObjectsArray(window_index,se4);
            break;
           }
         case 5 :
           {
            CSpinEdit *se5=cp.GetSpinEditRgbGPointer();
            m_wnd[window_index].m_elements[size]=se5;
            AddToObjectsArray(window_index,se5);
            break;
           }
         case 6 :
           {
            CSpinEdit *se6=cp.GetSpinEditRgbBPointer();
            m_wnd[window_index].m_elements[size]=se6;
            AddToObjectsArray(window_index,se6);
            break;
           }
         case 7 :
           {
            CSpinEdit *se7=cp.GetSpinEditLabLPointer();
            m_wnd[window_index].m_elements[size]=se7;
            AddToObjectsArray(window_index,se7);
            break;
           }
         case 8 :
           {
            CSpinEdit *se8=cp.GetSpinEditLabAPointer();
            m_wnd[window_index].m_elements[size]=se8;
            AddToObjectsArray(window_index,se8);
            break;
           }
         case 9 :
           {
            CSpinEdit *se9=cp.GetSpinEditLabBPointer();
            m_wnd[window_index].m_elements[size]=se9;
            AddToObjectsArray(window_index,se9);
            break;
           }
         //--- Добавим в общий массив кнопки 'OK' и 'Cancel' (10 - 11)
         case 10 :
           {
            CSimpleButton *sb1=cp.GetSimpleButtonOKPointer();
            m_wnd[window_index].m_elements[size]=sb1;
            AddToObjectsArray(window_index,sb1);
            break;
           }
         case 11 :
           {
            CSimpleButton *sb2=cp.GetSimpleButtonCancelPointer();
            m_wnd[window_index].m_elements[size]=sb2;
            AddToObjectsArray(window_index,sb2);
            break;
           }
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатель (T1) в переданный по ссылке массив (T2)      |
//+------------------------------------------------------------------+
template<typename T1,typename T2>
void CWndContainer::AddToRefArray(T1 &object,T2 &array[])
  {
   int size=::ArraySize(array);
   ::ArrayResize(array,size+1);
   array[size]=object;
  }
//+------------------------------------------------------------------+
