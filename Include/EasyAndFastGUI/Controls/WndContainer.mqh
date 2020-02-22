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
//| ����� ��� �������� ���� �������� ����������                      |
//+------------------------------------------------------------------+
class CWndContainer
  {
private:
   //--- ������� ���������
   int               m_counter_element_id;
   //---
protected:
   //--- ������ ����
   CWindow          *m_windows[];
   //--- ��������� �������� ���������
   struct WindowElements
     {
      //--- ����� ������ ���� ��������
      CChartObject     *m_objects[];
      //--- ����� ������ ���� ���������
      CElement         *m_elements[];

      //--- ������������ ������� ���������:
      //    ������ ����������� ����
      CContextMenu     *m_context_menus[];
      //--- ������ ������� ����
      CMenuBar         *m_menu_bars[];
      //--- ����������� ���������
      CTooltip         *m_tooltips[];
      //--- ������ ���������� ������� ������ �����
      CElement         *m_drop_lists[];
      //--- ������ ����� ���������
      CElement         *m_scrolls[];
      //--- ������ ������ �� ��������� �����
      CElement         *m_labels_tables[];
      //--- ������ ������ �� ����� �����
      CElement         *m_tables[];
      //--- ������ ������������ ������
      CElement         *m_canvas_tables[];
      //--- ������ �������
      CTabs            *m_tabs[];
      //--- ������ ����������
      CCalendar        *m_calendars[];
      //--- ������ ���������� ����������
      CDropCalendar    *m_drop_calendars[];
      //--- ����������� ������
      CTreeView        *m_treeview_lists[];
      //--- �������� ����������
      CFileNavigator   *m_file_navigators[];
     };
   //--- ������ �������� ��������� ��� ������� ����
   WindowElements    m_wnd[];
   //---
protected:
                     CWndContainer(void);
                    ~CWndContainer(void);
   //---
public:
   //--- ���������� ���� � ����������
   int               WindowsTotal(void) { return(::ArraySize(m_windows)); }
   //--- ���������� �������� ���� ���������
   int               ObjectsElementsTotal(const int window_index);
   //--- ���������� ���������
   int               ElementsTotal(const int window_index);
   //--- ���������� ����������� ����
   int               ContextMenusTotal(const int window_index);
   //--- ���������� ������� ����
   int               MenuBarsTotal(const int window_index);
   //--- ���������� ����������� ���������
   int               TooltipsTotal(const int window_index);
   //--- ���������� ���������� �������
   int               DropListsTotal(const int window_index);
   //--- ���������� ����� ���������
   int               ScrollsTotal(const int window_index);
   //--- ���������� ������ �� ��������� �����
   int               LabelsTablesTotal(const int window_index);
   //--- ���������� ������ �� ����� �����
   int               TablesTotal(const int window_index);
   //--- ���������� ������������ ������
   int               CanvasTablesTotal(const int window_index);
   //--- ���������� �������
   int               TabsTotal(const int window_index);
   //--- ���������� ����������
   int               CalendarsTotal(const int window_index);
   //--- ���������� ���������� ����������
   int               DropCalendarsTotal(const int window_index);
   //--- ���������� ����������� �������
   int               TreeViewListsTotal(const int window_index);
   //--- ���������� �������� �����������
   int               FileNavigatorsTotal(const int window_index);
   //---
protected:
   //--- ��������� ��������� ���� � ���� ��������� ����������
   void              AddWindow(CWindow &object);
   //--- ��������� ��������� �������� �������� � ����� ������
   template<typename T>
   void              AddToObjectsArray(const int window_index,T &object);
   //--- ��������� ��������� ������� � ������
   void              AddToArray(const int window_index,CChartObject &object);
   //--- ��������� ��������� � ������ ���������
   void              AddToElementsArray(const int window_index,CElement &object);
   //--- ��������� ����� ��� ���������� ���������� � ���������� �� ������ ������
   template<typename T1,typename T2>
   void              AddToRefArray(T1 &object,T2 &ref_array[]);
   //---
private:
   //--- ��������� ��������� �� �������� ������������ ����
   bool              AddContextMenuElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� �������� ����
   bool              AddMenuBarElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ��������� ������
   bool              AddSplitButtonElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ����������� ���������
   bool              AddTooltipElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� ������� ������
   bool              AddListViewElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ���������� ������� (�����-����)
   bool              AddComboBoxElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ���������� ������� (�����-���� � ���-������)
   bool              AddCheckComboBoxElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ������� �� ��������� �����
   bool              AddLabelsTableElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ������� �� ����� �����
   bool              AddTableElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ������������ �������
   bool              AddCanvasTableElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� ������� � ������������ ������
   bool              AddTabsElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ���������
   bool              AddCalendarElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ����������� ���������
   bool              AddDropCalendarElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ����������� �������
   bool              AddTreeViewListsElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� ������������ ������
   bool              AddFileNavigatorElements(const int window_index,CElement &object);
   //--- ��������� ��������� �� �������� �������� �������
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
//| ���������� ���-�� �������� �� ���������� ������� ����            |
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
//| ���������� ���-�� ��������� �� ���������� ������� ����           |
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
//| ���������� ���-�� ����������� ���� �� ���������� ������� ����    |
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
//| ���������� ���-�� ������� ���� �� ���������� ������� ����        |
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
//| ���������� ���-�� ��������� �� ���������� ������� ����           |
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
//| ���������� ���-�� ���������� ������� �� ���������� ������� ����  |
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
//| ���������� ���-�� ����� ��������� �� ���������� ������� ����     |
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
//| ���������� ���-�� ������ �� ��������� �����                      |
//| �� ���������� ������� ����                                       |
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
//| ���������� ���-�� ������ �� ���������� ������� ����              |
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
//| ���������� ���-�� ������������ ������ �� ���������� ������� ���� |
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
//| ���������� ���-�� ����� ������� �� ���������� ������� ����       |
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
//| ���������� ���-�� ���������� �� ���������� ������� ����          |
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
//| ���������� ���-�� ���������� ����������                          |
//| �� ���������� ������� ����                                       |
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
//| ���������� ���-�� ����������� ������� �� ���������� ������� ���� |
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
//| ���������� ���-�� �������� �����������                           |
//| �� ���������� ������� ����                                       |
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
//| ��������� ��������� ���� � ���� ��������� ����������             |
//+------------------------------------------------------------------+
void CWndContainer::AddWindow(CWindow &object)
  {
   int windows_total=::ArraySize(m_windows);
//--- ���� ���� ���, ������� ������� ���������
   if(windows_total<1)
      m_counter_element_id=0;
//--- ������� ��������� � ������ ����
   ::ArrayResize(m_wnd,windows_total+1);
   ::ArrayResize(m_windows,windows_total+1);
   m_windows[windows_total]=::GetPointer(object);
//--- ������� ��������� � ����� ������ ���������
   int elements_total=::ArraySize(m_wnd[windows_total].m_elements);
   ::ArrayResize(m_wnd[windows_total].m_elements,elements_total+1);
   m_wnd[windows_total].m_elements[elements_total]=::GetPointer(object);
//--- ������� ������� �������� � ����� ������ ��������
   AddToObjectsArray(windows_total,object);
//--- ��������� ������������� � �������� id ���������� ��������
   m_windows[windows_total].Id(m_counter_element_id);
   m_windows[windows_total].LastId(m_counter_element_id);
//--- �������� ������� ��������������� ���������
   m_counter_element_id++;
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �������� �������� � ����� ������             |
//+------------------------------------------------------------------+
template<typename T>
void CWndContainer::AddToObjectsArray(const int window_index,T &object)
  {
   int total=object.ObjectsElementTotal();
   for(int i=0; i<total; i++)
      AddToArray(window_index,object.Object(i));
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������� � ������                             |
//+------------------------------------------------------------------+
void CWndContainer::AddToArray(const int window_index,CChartObject &object)
  {
   int size=::ArraySize(m_wnd[window_index].m_objects);
   ::ArrayResize(m_wnd[window_index].m_objects,size+1);
   m_wnd[window_index].m_objects[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� � ������ ���������                           |
//+------------------------------------------------------------------+
void CWndContainer::AddToElementsArray(const int window_index,CElement &object)
  {
//--- ���� � ���� ��� ���� ��� ��������� ����������
   if(::ArraySize(m_windows)<1)
     {
      ::Print(__FUNCTION__," > ����� ��������� �������� ���������� ����� ������� ����� "
              "� �������� � � ���� � ������� ������ CWndContainer::AddWindow(CWindow &object).");
      return;
     }
//--- ���� ������ �� �������������� �����
   if(window_index>=::ArraySize(m_windows))
     {
      Print(PREVENTING_OUT_OF_RANGE," window_index: ",window_index,"; ArraySize(m_windows): ",::ArraySize(m_windows));
      return;
     }
//--- ������� � ����� ������ ���������
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
   m_wnd[window_index].m_elements[size]=::GetPointer(object);
//--- ������� ������� �������� � ����� ������ ��������
   AddToObjectsArray(window_index,object);
//--- �������� �� ���� ������ id ���������� ��������
   int windows_total=::ArraySize(m_windows);
   for(int w=0; w<windows_total; w++)
      m_windows[w].LastId(m_counter_element_id);
//--- �������� ������� ��������������� ���������
   m_counter_element_id++;
//--- ��������� ��������� �� ������� ������������ ����
   if(AddContextMenuElements(window_index,object))
      return;
//--- ��������� ��������� �� ������� �������� ����
   if(AddMenuBarElements(window_index,object))
      return;
//--- ��������� ��������� �� ������� ��������� ������
   if(AddSplitButtonElements(window_index,object))
      return;
//--- ��������� ��������� �� ������� ����������� ���������
   if(AddTooltipElements(window_index,object))
      return;
//--- ��������� ��������� �� ������� ������ � ����
   if(AddListViewElements(window_index,object))
      return;
//--- ��������� ��������� �� ������� �������� �����-�����
   if(AddComboBoxElements(window_index,object))
      return;
//--- ��������� ��������� �� ������� �������� �����-����� � ���-������
   if(AddCheckComboBoxElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� ������� �� ��������� �����
   if(AddLabelsTableElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� ������� �� ����� �����
   if(AddTableElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� ������������ �������
   if(AddCanvasTableElements(window_index,object))
      return;
//--- ��������� ��������� �� ������� � ������������ ������
   if(AddTabsElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� ���������
   if(AddCalendarElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� ����������� ���������
   if(AddDropCalendarElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� ����������� �������
   if(AddTreeViewListsElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� ��������� ����������
   if(AddFileNavigatorElements(window_index,object))
      return;
//--- ��������� ��������� �� �������� �������� �������
   if(AddColorPickersElements(window_index,object))
      return;
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������� ������������ ���� � ����          |
//+------------------------------------------------------------------+
bool CWndContainer::AddContextMenuElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ����������� ����
   if(object.ClassName()!="CContextMenu")
      return(false);
//--- ������� ��������� �� ����������� ����
   CContextMenu *cm=::GetPointer(object);
//--- �������� ��������� �� ��� ������� � ����
   int items_total=cm.ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���������� ������� ���������
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- ��������� ��������� �� ����� ����
      CMenuItem *mi=cm.ItemPointerByIndex(i);
      //--- ��������� ��������� � ������
      m_wnd[window_index].m_elements[size]=mi;
      //--- ��������� ��������� �� ��� ������� ������ ���� � ����� ������
      AddToObjectsArray(window_index,mi);
     }
//--- ������� ��������� � ������������ ������
   AddToRefArray(cm,m_wnd[window_index].m_context_menus);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������� �������� ���� � ����              |
//+------------------------------------------------------------------+
bool CWndContainer::AddMenuBarElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ������� ����
   if(object.ClassName()!="CMenuBar")
      return(false);
//--- ������� ��������� �� ������� ����
   CMenuBar *mb=::GetPointer(object);
//--- �������� ��������� �� ��� ������� � ����
   int items_total=mb.ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���������� ������� ���������
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- ��������� ��������� �� ����� ����
      CMenuItem *mi=mb.ItemPointerByIndex(i);
      //--- ��������� ��������� � ������
      m_wnd[window_index].m_elements[size]=mi;
      //--- ��������� ��������� �� ��� ������� ������ ���� � ����� ������
      AddToObjectsArray(window_index,mi);
     }
//--- ������� ��������� � ������������ ������
   AddToRefArray(mb,m_wnd[window_index].m_menu_bars);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������� ��������� ������ � ����           |
//+------------------------------------------------------------------+
bool CWndContainer::AddSplitButtonElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ��������� ������
   if(object.ClassName()!="CSplitButton")
      return(false);
//--- ������� ��������� �� ��������� ������
   CSplitButton *sb=::GetPointer(object);
//--- ���������� ������� ���������
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
//--- ������� ��������� ������������ ����
   CContextMenu *cm=sb.GetContextMenuPointer();
//--- �������� ������� � ������� � ����
   m_wnd[window_index].m_elements[size]=cm;
   AddToObjectsArray(window_index,cm);
//--- �������� ��������� �� ��� ������� � ����
   int items_total=cm.ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���������� ������� ���������
      size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- ��������� ��������� �� ����� ����
      CMenuItem *mi=cm.ItemPointerByIndex(i);
      //--- ��������� ��������� � ������
      m_wnd[window_index].m_elements[size]=mi;
      //--- ��������� ��������� �� ��� ������� ������ ���� � ����� ������
      AddToObjectsArray(window_index,mi);
     }
//--- ������� ��������� � ������������ ������
   AddToRefArray(cm,m_wnd[window_index].m_context_menus);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ��������� � ������������ ������           |
//+------------------------------------------------------------------+
bool CWndContainer::AddTooltipElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ����������� ���������
   if(object.ClassName()!="CTooltip")
      return(false);
//--- ������� ��������� �� ����������� ���������
   CTooltip *t=::GetPointer(object);
//--- ������� ��������� � ������������ ������
   AddToRefArray(t,m_wnd[window_index].m_tooltips);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������� ������ � ����                     |
//+------------------------------------------------------------------+
bool CWndContainer::AddListViewElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ������
   if(object.ClassName()!="CListView")
      return(false);
//--- ������� ��������� �� ������
   CListView *lv=::GetPointer(object);
//--- ���������� ������� ���������
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
//--- ������� ��������� ������ ���������
   CScrollV *sv=lv.GetScrollVPointer();
//--- �������� ������� � ����
   m_wnd[window_index].m_elements[size]=sv;
   AddToObjectsArray(window_index,sv);
//--- ������� ��������� � ������������ ������
   AddToRefArray(sv,m_wnd[window_index].m_scrolls);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ���������� ������ � ������������ ������   |
//| (�����-����)                                                     |
//+------------------------------------------------------------------+
bool CWndContainer::AddComboBoxElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ���������
   if(object.ClassName()!="CComboBox")
      return(false);
//--- ������� ��������� �� �����-����
   CComboBox *cb=::GetPointer(object);
//---
   for(int i=0; i<2; i++)
     {
      //--- ���������� ������� ���������
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //--- ������� ������ � ����
      if(i==0)
        {
         CListView *lv=cb.GetListViewPointer();
         m_wnd[window_index].m_elements[size]=lv;
         AddToObjectsArray(window_index,lv);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(lv,m_wnd[window_index].m_drop_lists);
        }
      //--- ������� ������ ��������� � ����
      else if(i==1)
        {
         CScrollV *sv=cb.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ���������� ������ � ������������ ������   |
//| (�����-���� � ���-������)                                        |
//+------------------------------------------------------------------+
bool CWndContainer::AddCheckComboBoxElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ��������� � ���������
   if(object.ClassName()!="CCheckComboBox")
      return(false);
//--- ������� ��������� �� ���������� ������
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
         //--- ������� ��������� � ������������ ������
         AddToRefArray(lv,m_wnd[window_index].m_drop_lists);
        }
      else if(i==1)
        {
         CScrollV *sv=ccb.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� �������� ������� �� ��������� �����       |
//+------------------------------------------------------------------+
bool CWndContainer::AddLabelsTableElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ������� �� ��������� �����
   if(object.ClassName()!="CLabelsTable")
      return(false);
//--- ������� ��������� �� ������� �� ��������� �����
   CLabelsTable *lt=::GetPointer(object);
   for(int i=0; i<2; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      if(i==0)
        {
         //--- ������� ��������� ������ ���������
         CScrollV *sv=lt.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
      else if(i==1)
        {
         CScrollH *sh=lt.GetScrollHPointer();
         m_wnd[window_index].m_elements[size]=sh;
         AddToObjectsArray(window_index,sh);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sh,m_wnd[window_index].m_scrolls);
        }
     }
//--- ������� ��������� � ������������ ������
   AddToRefArray(lt,m_wnd[window_index].m_labels_tables);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� �������� ������� �� ����� �����           |
//+------------------------------------------------------------------+
bool CWndContainer::AddTableElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ������� �� ��������� �����
   if(object.ClassName()!="CTable")
      return(false);
//--- ������� ��������� �� ������� �� ��������� �����
   CTable *te=::GetPointer(object);
   for(int i=0; i<2; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      if(i==0)
        {
         //--- ������� ��������� ������ ���������
         CScrollV *sv=te.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
      else if(i==1)
        {
         CScrollH *sh=te.GetScrollHPointer();
         m_wnd[window_index].m_elements[size]=sh;
         AddToObjectsArray(window_index,sh);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sh,m_wnd[window_index].m_scrolls);
        }
     }
//--- ������� ��������� � ������������ ������
   AddToRefArray(te,m_wnd[window_index].m_tables);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� �������� ������������ �������             |
//+------------------------------------------------------------------+
bool CWndContainer::AddCanvasTableElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ������������ �������
   if(object.ClassName()!="CCanvasTable")
      return(false);
//--- ������� ��������� �� ������������ �������
   CCanvasTable *ct=::GetPointer(object);
   for(int i=0; i<2; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      if(i==0)
        {
         //--- ������� ��������� ������ ���������
         CScrollV *sv=ct.GetScrollVPointer();
         m_wnd[window_index].m_elements[size]=sv;
         AddToObjectsArray(window_index,sv);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sv,m_wnd[window_index].m_scrolls);
        }
      else if(i==1)
        {
         CScrollH *sh=ct.GetScrollHPointer();
         m_wnd[window_index].m_elements[size]=sh;
         AddToObjectsArray(window_index,sh);
         //--- ������� ��������� � ������������ ������
         AddToRefArray(sh,m_wnd[window_index].m_scrolls);
        }
     }
//--- ������� ��������� � ������������ ������
   AddToRefArray(ct,m_wnd[window_index].m_canvas_tables);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������� � ������������ ������             |
//+------------------------------------------------------------------+
bool CWndContainer::AddTabsElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ������� ����
   if(object.ClassName()!="CTabs")
      return(false);
//--- ������� ��������� �� ������� "�������"
   CTabs *tabs=::GetPointer(object);
//--- ������� ��������� � ������������ ������
   AddToRefArray(tabs,m_wnd[window_index].m_tabs);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������� ��������� � ����                  |
//+------------------------------------------------------------------+
bool CWndContainer::AddCalendarElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ���������
   if(object.ClassName()!="CCalendar")
      return(false);
//--- ������� ��������� �� ������� "���������"
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
            //--- ������� ��������� � ������������ ������
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
//--- ������� ��������� � ������������ ������
   AddToRefArray(cal,m_wnd[window_index].m_calendars);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������� ����������� ��������� � ����      |
//+------------------------------------------------------------------+
bool CWndContainer::AddDropCalendarElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ���������
   if(object.ClassName()!="CDropCalendar")
      return(false);
//--- ������� ��������� �� ������� "���������� ���������"
   CDropCalendar *dc=::GetPointer(object);
//--- ������� ��������� � ������������ ������
   AddToRefArray(dc,m_wnd[window_index].m_drop_calendars);
//--- ������� ��������� �� ������� "���������"
   CCalendar *cal=dc.GetCalendarPointer();
//--- ���������� ������� ���������
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
//--- �������� ������� � ������� � ����
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
            //--- ������� ��������� � ������������ ������
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
//--- ������� ��������� � ������������ ������
   AddToRefArray(cal,m_wnd[window_index].m_calendars);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� �������� ������������ ������              |
//+------------------------------------------------------------------+
bool CWndContainer::AddTreeViewListsElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� ����������� ������
   if(object.ClassName()!="CTreeView")
      return(false);
//--- ������� ��������� �� ������� "����������� ������"
   CTreeView *tv=::GetPointer(object);
//--- ������� ��������� � ������������ ������
   AddToRefArray(tv,m_wnd[window_index].m_treeview_lists);
//--- ������ �������
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
            //--- ������ ��������� �������
            CScrollV *sv=tv.GetScrollVPointer();
            m_wnd[window_index].m_elements[size]=sv;
            AddToObjectsArray(window_index,sv);
            //--- ������� ��������� � ������������ ������
            AddToRefArray(sv,m_wnd[window_index].m_scrolls);
            break;
           }
         case 3 :
           {
            CScrollV *csv=tv.GetContentScrollVPointer();
            m_wnd[window_index].m_elements[size]=csv;
            AddToObjectsArray(window_index,csv);
            //--- ������� ��������� � ������������ ������
            AddToRefArray(csv,m_wnd[window_index].m_scrolls);
            break;
           }
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� �������� ��������� ����������             |
//+------------------------------------------------------------------+
bool CWndContainer::AddFileNavigatorElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� �������� ���������
   if(object.ClassName()!="CFileNavigator")
      return(false);
//--- ������� ��������� ��������� ����������
   CFileNavigator *fn=::GetPointer(object);
//--- ������� ��������� � ������������ ������
   AddToRefArray(fn,m_wnd[window_index].m_file_navigators);
//--- �������� ��������� �� ����������� ������
   int size=::ArraySize(m_wnd[window_index].m_elements);
   ::ArrayResize(m_wnd[window_index].m_elements,size+1);
   CTreeView *tv=fn.TreeViewPointer();
   m_wnd[window_index].m_elements[size]=tv;
   AddToObjectsArray(window_index,tv);
//--- ������� ��������� � ������������ ������
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
            //--- �������� ������ ������������ ������
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
            //--- �������� ������ ������ ����������
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
            //--- ������ ��������� �������
            CScrollV *sv=tv.GetScrollVPointer();
            m_wnd[window_index].m_elements[size]=sv;
            AddToObjectsArray(window_index,sv);
            //--- ������� ��������� � ������������ ������
            AddToRefArray(sv,m_wnd[window_index].m_scrolls);
            break;
           }
         case 3 :
           {
            CScrollV *csv=tv.GetContentScrollVPointer();
            m_wnd[window_index].m_elements[size]=csv;
            AddToObjectsArray(window_index,csv);
            //--- ������� ��������� � ������������ ������
            AddToRefArray(csv,m_wnd[window_index].m_scrolls);
            break;
           }
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� �������� �������� �������                 |
//+------------------------------------------------------------------+
bool CWndContainer::AddColorPickersElements(const int window_index,CElement &object)
  {
//--- ������, ���� ��� �� �������� �������
   if(object.ClassName()!="CColorPicker")
      return(false);
//--- ������� ��������� �� �������
   CColorPicker *cp=::GetPointer(object);
//---
   for(int i=0; i<12; i++)
     {
      int size=::ArraySize(m_wnd[window_index].m_elements);
      ::ArrayResize(m_wnd[window_index].m_elements,size+1);
      //---
      switch(i)
        {
         //--- ������� � ����� ������ ������ �����-������
         case 0 :
           {
            CRadioButtons *rb=cp.GetRadioButtonsHslPointer();
            m_wnd[window_index].m_elements[size]=rb;
            AddToObjectsArray(window_index,rb);
            break;
           }
         //--- ������� � ����� ������ ������ ����� ����� (1 - 9)
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
         //--- ������� � ����� ������ ������ 'OK' � 'Cancel' (10 - 11)
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
//| ��������� ��������� (T1) � ���������� �� ������ ������ (T2)      |
//+------------------------------------------------------------------+
template<typename T1,typename T2>
void CWndContainer::AddToRefArray(T1 &object,T2 &array[])
  {
   int size=::ArraySize(array);
   ::ArrayResize(array,size+1);
   array[size]=object;
  }
//+------------------------------------------------------------------+
