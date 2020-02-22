//+------------------------------------------------------------------+
//|                                                     TreeView.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "TreeItem.mqh"
#include "Scrolls.mqh"
#include "Pointer.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������������ ������                           |
//+------------------------------------------------------------------+
class CTreeView : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ��������
   CRectLabel        m_area;
   CRectLabel        m_content_area;
   CTreeItem         m_items[];
   CTreeItem         m_content_items[];
   CScrollV          m_scrollv;
   CScrollV          m_content_scrollv;
   CPointer          m_x_resize;
   //--- ��������� ��������� ����������� �� ������ �������-��������
   struct TVElements
     {
      CElement         *elements[];
      int               list_index;
     };
   TVElements        m_tab_items[];
   //--- ������� ��� ���� ������� ������������ ������ (������ ������)
   int               m_t_list_index[];
   int               m_t_prev_node_list_index[];
   string            m_t_item_text[];
   string            m_t_path_bmp[];
   int               m_t_item_index[];
   int               m_t_node_level[];
   int               m_t_prev_node_item_index[];
   int               m_t_items_total[];
   int               m_t_folders_total[];
   bool              m_t_item_state[];
   bool              m_t_is_folder[];
   //--- ������� ��� ������ ������������ ������� ������������ ������
   int               m_td_list_index[];
   //--- ������� ��� ������ ���������� ������� ���������� � ����������� ������ (������ ������)
   int               m_c_list_index[];
   int               m_c_tree_list_index[];
   string            m_c_item_text[];
   //--- ������� ��� ������ ������������ ������� � ������ ����������
   int               m_cd_list_index[];
   int               m_cd_tree_list_index[];
   string            m_cd_item_text[];
   //--- ����� ���������� ������� � ���������� � ������� ����� �������
   int               m_items_total;
   int               m_content_items_total;
   int               m_visible_items_total;
   //--- ������� ���������� ������� � �������
   int               m_selected_item_index;
   int               m_selected_content_item_index;
   //--- ����� ����������� ������ � ������. 
   //    ������ ��� ������ � ������ ������������� ������ ��� �������� ��������� ����������.
   //    ���� � ������ ������ �� ����, �� � ���� ���� ������ ���� ������ ������ "".
   string            m_selected_item_file_name;
   //--- ������ ������� ������������ ������
   int               m_treeview_area_width;
   //--- ���� ���� � ����� ����
   color             m_area_color;
   color             m_area_border_color;
   //--- ������ ������� ����������
   int               m_content_area_width;
   //--- ������ �������
   int               m_item_y_size;
   //--- ����� ������� � ������ ����������
   color             m_item_back_color_hover;
   color             m_item_back_color_selected;
   //--- ����� ������ � ������ ����������
   color             m_item_text_color;
   color             m_item_text_color_hover;
   color             m_item_text_color_selected;
   //--- �������� ��� �������
   string            m_item_arrow_file_on;
   string            m_item_arrow_file_off;
   string            m_item_arrow_selected_file_on;
   string            m_item_arrow_selected_file_off;
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   //--- ����� ��������� ����������
   ENUM_FILE_NAVIGATOR_MODE m_file_navigator_mode;
   //--- ����� ��������� ��� ��������� �������
   bool              m_lights_hover;
   //--- ����� ������ ���������� ������ � ������� �������
   bool              m_show_item_content;
   //--- ����� ��������� ������ �������
   bool              m_resize_list_area_mode;
   //--- ����� �������-�������
   bool              m_tab_items_mode;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //--- ������� ������� ��� ��������� ������
   int               m_timer_counter;
   //--- (1) ����������� � (2) ������������ ������� ����
   int               m_min_node_level;
   int               m_max_node_level;
   //--- ���������� ������� � �������� ��������
   int               m_root_items_total;
   //---
public:
                     CTreeView(void);
                    ~CTreeView(void);
   //--- ������ ��� �������� ������������ ������
   bool              CreateTreeView(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateContentArea(void);
   bool              CreateItems(void);
   bool              CreateScrollV(void);
   bool              CreateContentItems(void);
   bool              CreateContentScrollV(void);
   bool              CreateXResizePointer(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ����� ��������� �������
   void              WindowPointer(CWindow &object)                     { m_wnd=::GetPointer(object);               }
   CScrollV         *GetScrollVPointer(void)                            { return(::GetPointer(m_scrollv));          }
   CScrollV         *GetContentScrollVPointer(void)                     { return(::GetPointer(m_content_scrollv));  }
   //--- ���������� (1) ��������� ������ ������������ ������, (2) ��������� ������ ������ ����������, 
   CTreeItem        *ItemPointer(const int index);
   CTreeItem        *ContentItemPointer(const int index);
   //--- (1) ����� ��������� ����������, (2) ����� ��������� ��� ��������� ������� ����, 
   //    (3) ����� ������ ���������� ������, (4) ����� ��������� ������ �������, (5) ����� �������-�������
   void              NavigatorMode(const ENUM_FILE_NAVIGATOR_MODE mode) { m_file_navigator_mode=mode;               }
   void              LightsHover(const bool state)                      { m_lights_hover=state;                     }
   void              ShowItemContent(const bool state)                  { m_show_item_content=state;                }
   void              ResizeListAreaMode(const bool state)               { m_resize_list_area_mode=state;            }
   void              TabItemsMode(const bool state)                     { m_tab_items_mode=state;                   }
   //--- ���������� ������� (1) � ����������� ������, (2) � ������ ���������� � (3) ������� ���������� �������
   int               ItemsTotal(void)                             const { return(::ArraySize(m_items));             }
   int               ContentItemsTotal(void)                      const { return(::ArraySize(m_content_items));     }
   void              VisibleItemsTotal(const int total)                 { m_visible_items_total=total;              }
   //--- (1) ������ ������, (2) ������ ������������ ������ � (3) ������ ����������
   void              ItemYSize(const int y_size)                        { m_item_y_size=y_size;                     }
   void              TreeViewAreaWidth(const int x_size)                { m_treeview_area_width=x_size;             }
   void              ContentAreaWidth(const int x_size)                 { m_content_area_width=x_size;              }
   //--- ���� ���� � ����� ���� ��������
   void              AreaBackColor(const color clr)                     { m_area_color=clr;                         }
   void              AreaBorderColor(const color clr)                   { m_area_border_color=clr;                  }
   //--- ����� ������� � ������ ����������
   void              ItemBackColorHover(const color clr)                { m_item_back_color_hover=clr;              }
   void              ItemBackColorSelected(const color clr)             { m_item_back_color_selected=clr;           }
   //--- ����� ������ � ������ ����������
   void              ItemTextColor(const color clr)                     { m_item_text_color=clr;                    }
   void              ItemTextColorHover(const color clr)                { m_item_text_color_hover=clr;              }
   void              ItemTextColorSelected(const color clr)             { m_item_text_color_selected=clr;           }
   //--- �������� ��� ������� ������
   void              ItemArrowFileOn(const string file_path)            { m_item_arrow_file_on=file_path;           }
   void              ItemArrowFileOff(const string file_path)           { m_item_arrow_file_off=file_path;          }
   void              ItemArrowSelectedFileOn(const string file_path)    { m_item_arrow_selected_file_on=file_path;  }
   void              ItemArrowSelectedFileOff(const string file_path)   { m_item_arrow_selected_file_off=file_path; }
   //--- (1) �������� ����� �� ������� � (2) ���������� ������ ����������� ������, (3) ���������� �������� �����
   void              SelectedItemIndex(const int index)                 { m_selected_item_index=index;              }
   int               SelectedItemIndex(void)                      const { return(m_selected_item_index);            }
   string            SelectedItemFileName(void)                   const { return(m_selected_item_file_name);        }

   //--- ��������� ����� � ����������� ������
   void              AddItem(const int list_index,const int list_id,const string item_name,const string path_bmp,const int item_index,
                             const int node_number,const int item_number,const int items_total,const int folders_total,const bool item_state,const bool is_folder=true);
   //--- ��������� ������� � ������ ������-�������
   void              AddToElementsArray(const int item_index,CElement &object);
   //--- �������� �������� ������ ����������� ������-�������
   void              ShowTabElements(void);
   //--- ���������� ������ ���� ����������� ������
   string            CurrentFullPath(void);
   //--- ��������� �����
   void              ChangeObjectsColor(void);
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- ������
   virtual void      OnEventTimer(void);
   //--- ����������� ��������
   virtual void      Moving(const int x,const int y);
   //--- (1) �����, (2) �������, (3) �����, (4) ��������
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- (1) ���������, (2) ����� ����������� �� ������� ����� ������ ����
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- �������� ����
   virtual void      ResetColors(void);
   //---
private:
   //--- ��������� ������� �� ������ ������������/�������������� ������ ������
   bool              OnClickItemArrow(const string clicked_object);
   //--- ��������� ������� �� ������ ������������ ������
   bool              OnClickItem(const string clicked_object);
   //--- ��������� ������� �� ������ � ������ ����������
   bool              OnClickContentListItem(const string clicked_object);
   //--- ��������� (1) �������������� � (2) ������� �� ����� ������ ����
   int               IdFromObjectName(const string object_name);
   int               IndexFromObjectName(const string object_name);

   //--- ��������� ������ �������-�������
   void              GenerateTabItemsArray(void);
   //--- ����������� � ��������� (1) ������ ����� � (2) ������� ��������� ��������
   void              SetNodeLevelBoundaries(void);
   void              SetRootItemsTotal(void);
   //--- �������� �������
   void              ShiftTreeList(void);
   void              ShiftContentList(void);
   //--- ���������� ��������� ������
   void              FastSwitching(void);

   //--- ��������� ������� �������
   void              ResizeListArea(const int x,const int y);
   //--- �������� ���������� ��� ��������� ������ �������
   void              CheckXResizePointer(const int x,const int y);
   //--- �������� �� ����� �� �����������
   bool              CheckOutOfArea(const int x,const int y);
   //--- ���������� ������ ������������ ������
   void              UpdateTreeListWidth(const int x);
   //--- ���������� ������ ������ � ������� ����������
   void              UpdateContentListWidth(const int x);

   //--- ��������� ����� � ������ � ������� ����������
   void              AddDisplayedTreeItem(const int list_index);
   //--- ��������� (1) ����������� ������ � (2) ������ ����������
   void              UpdateTreeViewList(void);
   void              UpdateContentList(void);
   //--- ����������� ������������ ������
   void              RedrawTreeList(void);

   //--- �������� ������� ����������� ������ �� ����� �� ���������
   void              CheckSelectedItemIndex(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTreeView::CTreeView(void) : m_treeview_area_width(180),
                             m_content_area_width(WRONG_VALUE),
                             m_item_y_size(20),
                             m_visible_items_total(13),
                             m_tab_items_mode(false),
                             m_lights_hover(false),
                             m_show_item_content(true),
                             m_resize_list_area_mode(false),
                             m_selected_item_index(WRONG_VALUE),
                             m_selected_content_item_index(WRONG_VALUE),
                             m_area_color(clrWhite),
                             m_area_border_color(clrLightGray),
                             m_item_back_color_hover(C'240,240,240'),
                             m_item_back_color_selected(C'51,153,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_hover(clrBlack),
                             m_item_text_color_selected(clrWhite),
                             m_item_arrow_file_on(""),
                             m_item_arrow_file_off(""),
                             m_item_arrow_selected_file_on(""),
                             m_item_arrow_selected_file_off("")
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder=0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTreeView::~CTreeView(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CTreeView::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- ���������� � ��������� ����� ������ ����
      int x=(int)lparam;
      int y=(int)dparam;
      m_mouse_state=(bool)int(sparam);
      //--- �������� ������ ��� �������
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- ������� ����������� ������, ���� ���������� ��������� ������ ��������� � ��������
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state))
        {
         ShiftTreeList();
         return;
        }
      //--- �������, ������ ���� ���� ������
      if(m_t_items_total[m_selected_item_index]>0)
        {
         //--- ������� ������ ����������, ���� ���������� ��������� ������ ��������� � ��������
         if(m_content_scrollv.ScrollBarControl(x,y,m_mouse_state))
           {
            ShiftContentList();
            return;
           }
        }
      //--- ���������� ������� ������� ����������
      ResizeListArea(x,y);
      //--- �����, ���� ����� �������������
      if(m_wnd.IsLocked())
         return;
      //--- ��������� ����� �� ��������� ������� ����
      ChangeObjectsColor();
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- �����, ���� � ������ ����������� ������� ������� ������ ����������
      if(m_x_resize.IsVisible() || m_x_resize.State())
         return;
      //--- ��������� ������� �� ������� ������
      if(OnClickItemArrow(sparam))
         return;
      //--- ��������� ������� �� ������ ������������ ������
      if(OnClickItem(sparam))
         return;
      //--- ��������� ������� �� ������ � ������ ����������
      if(OnClickContentListItem(sparam))
         return;
      //--- �������� ������ ������������ ������ ���������
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam))
         ShiftTreeList();
      if(m_content_scrollv.OnClickScrollInc(sparam) || m_content_scrollv.OnClickScrollDec(sparam))
         ShiftContentList();
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CTreeView::OnEventTimer(void)
  {
//--- ���� ������� ����������
   if(CElement::IsDropdown())
     {
      ChangeObjectsColor();
      FastSwitching();
     }
   else
     {
      //--- ����������� ��������� ����� � ��������� ��������, 
      //    ������ ���� ����� �� �������������
      if(!m_wnd.IsLocked())
        {
         ChangeObjectsColor();
         FastSwitching();
        }
     }
  }
//+------------------------------------------------------------------+
//| ������ ����������� ����                                         |
//+------------------------------------------------------------------+
bool CTreeView::CreateTreeView(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������������ ������ ��� ����� �������� "
              "��������� �� �����: CTreeView::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
   m_y_size   =m_item_y_size*m_visible_items_total+2-(m_visible_items_total-1);
//--- �������� ������� ����������� ������ �� ����� �� ���������
   CheckSelectedItemIndex();
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������
   if(!CreateArea())
      return(false);
   if(!CreateContentArea())
      return(false);
   if(!CreateItems())
      return(false);
   if(!CreateScrollV())
      return(false);
   if(!CreateContentItems())
      return(false);
   if(!CreateContentScrollV())
      return(false);
   if(!CreateXResizePointer())
      return(false);
//--- ���������� ������ �������-�������
   GenerateTabItemsArray();
//--- ����������� � ��������� (1) ������ ����� � (2) ������� ��������� ��������
   SetNodeLevelBoundaries();
   SetRootItemsTotal();
//--- �������� ������
   UpdateTreeViewList();
   UpdateContentList();
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//--- ��������� ��������� ��� ������������ ���������� � �������� ���������
   ::EventChartCustom(m_chart_id,ON_CHANGE_TREE_PATH,0,0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ��� ������                                           |
//+------------------------------------------------------------------+
bool CTreeView::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_treeview_area_"+(string)CElement::Id();
//--- �������� �������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_treeview_area_width,m_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- �������� �������
   m_area.XSize(m_treeview_area_width);
   m_area.YSize(CElement::YSize());
//--- �������� ����������
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      m_area.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ��� ���������� ������                                |
//+------------------------------------------------------------------+
bool CTreeView::CreateContentArea(void)
  {
//--- �����, ���� ������� ���������� �� �����
   if(m_content_area_width<0)
     {
      //--- �������� ����� ������ �������� � ������
      CElement::XSize(m_treeview_area_width);
      return(true);
     }
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_treeview_content_area_"+(string)CElement::Id();
//--- ����������
   int x=m_area.X2()-1;
   int y=CElement::Y();
//--- ������ �� ��� X
   m_content_area_width=(m_content_area_width!=0)? m_content_area_width : m_wnd.X2()-m_area.X2()-1;
//--- �������� ����� ������ ��������
   CElement::XSize(m_treeview_area_width+m_content_area_width-1);
//--- �������� �������
   if(!m_content_area.Create(m_chart_id,name,m_subwin,x,y,m_content_area_width,m_y_size))
      return(false);
//--- ��������� �������
   m_content_area.BackColor(m_area_color);
   m_content_area.Color(m_area_border_color);
   m_content_area.BorderType(BORDER_FLAT);
   m_content_area.Corner(m_corner);
   m_content_area.Selectable(false);
   m_content_area.Z_Order(m_zorder);
   m_content_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_content_area.XGap(x-m_wnd.X());
   m_content_area.YGap(CElement::Y()-m_wnd.Y());
//--- �������� �������
   m_content_area.XSize(m_content_area_width);
   m_content_area.YSize(CElement::YSize());
//--- �������� ����������
   m_content_area.X(x);
   m_content_area.Y(CElement::Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_content_area);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      m_content_area.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����������� ������                                       |
//+------------------------------------------------------------------+
bool CTreeView::CreateItems(void)
  {
//--- ����������
   int x =CElement::X()+1;
   int y =CElement::Y()+1;
//---
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- ������ ���������� Y
      y=(i>0)? y+m_item_y_size-1 : y;
      //--- ��������� ��������� �����
      m_items[i].WindowPointer(m_wnd);
      //--- ��������� �������� ����� ���������
      m_items[i].Index(0);
      m_items[i].Id(CElement::Id());
      m_items[i].XSize(CElement::XSize());
      m_items[i].YSize(m_item_y_size);
      m_items[i].IconFile(m_t_path_bmp[i]);
      m_items[i].ItemBackColor(m_area_color);
      m_items[i].ItemBackColorHover(m_item_back_color_hover);
      m_items[i].ItemBackColorSelected(m_item_back_color_selected);
      m_items[i].ItemTextColor(m_item_text_color);
      m_items[i].ItemTextColorHover(m_item_text_color_hover);
      m_items[i].ItemTextColorSelected(m_item_text_color_selected);
      m_items[i].ItemArrowFileOn(m_item_arrow_file_on);
      m_items[i].ItemArrowFileOff(m_item_arrow_file_off);
      m_items[i].ItemArrowSelectedFileOn(m_item_arrow_selected_file_on);
      m_items[i].ItemArrowSelectedFileOff(m_item_arrow_selected_file_off);
      //--- ��������� ��� ������
      ENUM_TYPE_TREE_ITEM type=TI_SIMPLE;
      if(m_file_navigator_mode==FN_ALL)
         type=(m_t_items_total[i]>0)? TI_HAS_ITEMS : TI_SIMPLE;
      else // FN_ONLY_FOLDERS
      type=(m_t_folders_total[i]>0)? TI_HAS_ITEMS : TI_SIMPLE;
      //--- ������������� ���������� ��������� ������
      m_t_item_state[i]=(type==TI_HAS_ITEMS)? m_t_item_state[i]: false;
      //--- ������� �� ������� ����� ������
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- �������� ��������
      if(!m_items[i].CreateTreeItem(m_chart_id,m_subwin,x,y,type,
         m_t_list_index[i],m_t_node_level[i],m_t_item_text[i],m_t_item_state[i]))
         return(false);
      //--- ���������� ���� ����������� ������
      if(i==m_selected_item_index)
         m_items[i].HighlightItemState(true);
      //--- ������ �������
      m_items[i].Hide();
      //--- ����� ����� ���������� ���������
      m_items[i].IsDropdown(true);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������ ������                                      |
//+------------------------------------------------------------------+
bool CTreeView::CreateScrollV(void)
  {
//--- ��������� ��������� �����
   m_scrollv.WindowPointer(m_wnd);
//--- ����������
   int x=m_area.X2()-m_scrollv.ScrollWidth();
   int y=CElement::Y();
   m_scrollv.XDistance(x);
//--- ��������� ��������
   m_scrollv.Index(0);
   m_scrollv.Id(CElement::Id());
   m_scrollv.XGap(x-m_wnd.X());
   m_scrollv.YGap(y-m_wnd.Y());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(m_item_y_size*m_visible_items_total+2-(m_visible_items_total-1));
//--- �������� ������ ���������
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_items_total,m_visible_items_total))
      return(false);
//--- ������ �������
   m_scrollv.Hide();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ���������� ����������� ������                     |
//+------------------------------------------------------------------+
bool CTreeView::CreateContentItems(void)
  {
//--- �����, ���� ���������� ������ �� ����� ���������� ���
//    ���� ������� ���������� ���������
   if(!m_show_item_content || m_content_area_width<0)
      return(true);
//--- ���������� � ������
   int x =m_content_area.X()+1;
   int y =CElement::Y()+1;
   int w =m_content_area.X2()-x-1;
//--- ������� ���������� �������
   int c=0;
//--- 
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- � ���� ������ �� ������ ������� ������ �� ��������� ��������, 
      //    �������, ���� ������� ���� ������ 1, ������� � ����������
      if(m_t_node_level[i]<1)
         continue;
      //--- ��������� ������� �������� �� ���� �������
      int new_size=c+1;
      ::ArrayResize(m_content_items,new_size);
      ::ArrayResize(m_c_item_text,new_size);
      ::ArrayResize(m_c_tree_list_index,new_size);
      ::ArrayResize(m_c_list_index,new_size);
      //--- ������ ���������� Y
      y=(c>0)? y+m_item_y_size-1 : y;
      //--- ��������� ������ ������
      m_content_items[c].WindowPointer(m_wnd);
      //--- ��������� �������� ����� ���������
      m_content_items[c].Index(1);
      m_content_items[c].Id(CElement::Id());
      m_content_items[c].XSize(w);
      m_content_items[c].YSize(m_item_y_size);
      m_content_items[c].IconFile(m_t_path_bmp[i]);
      m_content_items[c].ItemBackColor(m_area_color);
      m_content_items[c].ItemBackColorHover(m_item_back_color_hover);
      m_content_items[c].ItemBackColorSelected(m_item_back_color_selected);
      m_content_items[c].ItemTextColor(m_item_text_color);
      m_content_items[c].ItemTextColorHover(m_item_text_color_hover);
      m_content_items[c].ItemTextColorSelected(m_item_text_color_selected);
      //--- ����������
      m_content_items[c].X(x);
      m_content_items[c].Y(y);
      //--- ������� �� ������� ����� ������
      m_content_items[c].XGap(x-m_wnd.X());
      m_content_items[c].YGap(y-m_wnd.Y());
      //--- �������� �������
      if(!m_content_items[c].CreateTreeItem(m_chart_id,m_subwin,x,y,TI_SIMPLE,c,0,m_t_item_text[i],false))
         return(false);
      //--- ������ �������
      m_content_items[c].Hide();
      //--- ����� ����� ���������� ���������
      m_content_items[c].IsDropdown(true);
      //--- ��������� (1) ������ ������ ������ ����������, (2) ������ ������������ ������ � (3) ����� ������
      m_c_list_index[c]      =c;
      m_c_tree_list_index[c] =m_t_list_index[i];
      m_c_item_text[c]       =m_t_item_text[i];
      //---
      c++;
     }
//--- ��������� ������ ������
   m_content_items_total=::ArraySize(m_content_items);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������ ������ ��� ������� �������                  |
//+------------------------------------------------------------------+
bool CTreeView::CreateContentScrollV(void)
  {
//--- �����, ���� ���������� ������ �� ����� ���������� ���
//    ���� ������� ���������� ���������
   if(!m_show_item_content || m_content_area_width<0)
      return(true);
//--- ��������� ��������� �����
   m_content_scrollv.WindowPointer(m_wnd);
//--- ����������
   int x=m_content_area.X()+m_content_area.X_Size()-m_content_scrollv.ScrollWidth();
   int y=CElement::Y();
//--- ��������� �������
   m_content_scrollv.Index(1);
   m_content_scrollv.Id(CElement::Id());
   m_content_scrollv.XGap(x-m_wnd.X());
   m_content_scrollv.YGap(y-m_wnd.Y());
   m_content_scrollv.XSize(m_content_scrollv.ScrollWidth());
   m_content_scrollv.YSize(m_item_y_size*m_visible_items_total+2-(m_visible_items_total-1));
//--- �������� ������ ���������
   if(!m_content_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_content_items_total,m_visible_items_total))
      return(false);
//--- ������ �������
   m_content_scrollv.Hide();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ������� ��������� ������                       |
//+------------------------------------------------------------------+
bool CTreeView::CreateXResizePointer(void)
  {
//--- �����, ���� ������ ������� ���������� �� ����� �������� ���
//    ������� ����� �������-�������
   if(!m_resize_list_area_mode || m_tab_items_mode)
      return(true);
//--- ��������� �������
   m_x_resize.XGap(12);
   m_x_resize.YGap(9);
   m_x_resize.Id(CElement::Id());
   m_x_resize.Type(MP_X_RESIZE);
//--- �������� ��������
   if(!m_x_resize.CreatePointer(m_chart_id,m_subwin))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������ ������������ ������ �� �������       |
//+------------------------------------------------------------------+
CTreeItem *CTreeView::ItemPointer(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- ���� ��� �� ������ ������ � ����������� ����, �������� �� ����
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ����������� ���� ���� ���� �� ���� �����!");
     }
//--- ������������� � ������ ������ �� ���������
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- ������� ���������
   return(::GetPointer(m_items[i]));
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������ ������� ���������� �� �������        |
//+------------------------------------------------------------------+
CTreeItem *CTreeView::ContentItemPointer(const int index)
  {
   int array_size=::ArraySize(m_content_items);
//--- ���� ��� �� ������ ������ � ����������� ����, �������� �� ����
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ����������� ���� ���� ���� �� ���� �����!");
     }
//--- ������������� � ������ ������ �� ���������
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- ������� ���������
   return(::GetPointer(m_content_items[i]));
  }
//+------------------------------------------------------------------+
//| ��������� ����� � ����� ������ ������������ ������               |
//+------------------------------------------------------------------+
void CTreeView::AddItem(const int list_index,const int prev_node_list_index,const string item_text,const string path_bmp,const int item_index,
                        const int node_level,const int prev_node_item_index,const int items_total,const int folders_total,const bool item_state,const bool is_folder)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size =::ArraySize(m_items);
   m_items_total  =array_size+1;
   ::ArrayResize(m_items,m_items_total);
   ::ArrayResize(m_t_list_index,m_items_total);
   ::ArrayResize(m_t_prev_node_list_index,m_items_total);
   ::ArrayResize(m_t_item_text,m_items_total);
   ::ArrayResize(m_t_path_bmp,m_items_total);
   ::ArrayResize(m_t_item_index,m_items_total);
   ::ArrayResize(m_t_node_level,m_items_total);
   ::ArrayResize(m_t_prev_node_item_index,m_items_total);
   ::ArrayResize(m_t_items_total,m_items_total);
   ::ArrayResize(m_t_folders_total,m_items_total);
   ::ArrayResize(m_t_item_state,m_items_total);
   ::ArrayResize(m_t_is_folder,m_items_total);
//--- �������� �������� ���������� ����������
   m_t_list_index[array_size]           =list_index;
   m_t_prev_node_list_index[array_size] =prev_node_list_index;
   m_t_item_text[array_size]            =item_text;
   m_t_path_bmp[array_size]             =path_bmp;
   m_t_item_index[array_size]           =item_index;
   m_t_node_level[array_size]           =node_level;
   m_t_prev_node_item_index[array_size] =prev_node_item_index;
   m_t_items_total[array_size]          =items_total;
   m_t_folders_total[array_size]        =folders_total;
   m_t_item_state[array_size]           =item_state;
   m_t_is_folder[array_size]            =is_folder;
  }
//+------------------------------------------------------------------+
//| ��������� ������� � ������ ��������� �������                     |
//+------------------------------------------------------------------+
void CTreeView::AddToElementsArray(const int tab_index,CElement &object)
  {
//--- �������� �� ����� �� ���������
   int array_size=::ArraySize(m_tab_items);
   if(array_size<1 || tab_index<0 || tab_index>=array_size)
      return;
//--- ������� ��������� ����������� �������� � ������ ��������� �������
   int size=::ArraySize(m_tab_items[tab_index].elements);
   ::ArrayResize(m_tab_items[tab_index].elements,size+1);
   m_tab_items[tab_index].elements[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| ���������� �������� ������ ����������� ������-�������            |
//+------------------------------------------------------------------+
void CTreeView::ShowTabElements(void)
  {
//--- �����, ���� ������� ����� ��� ����� �������-������� ��������
   if(!CElement::IsVisible() || !m_tab_items_mode)
      return;
//--- ������ ���������� �������
   int tab_index=WRONG_VALUE;
//--- ��������� ������ ���������� �������
   int tab_items_total=::ArraySize(m_tab_items);
   for(int i=0; i<tab_items_total; i++)
     {
      if(m_tab_items[i].list_index==m_selected_item_index)
        {
         tab_index=i;
         break;
        }
     }
//--- ������� �������� ������ ���������� �������
   for(int i=0; i<tab_items_total; i++)
     {
      //--- ������� ���������� ��������� ������������� � �������
      int tab_elements_total=::ArraySize(m_tab_items[i].elements);
      //--- ���� ������� ���� �����-�������
      if(i==tab_index)
        {
         //--- �������� ��������
         for(int j=0; j<tab_elements_total; j++)
            m_tab_items[i].elements[j].Reset();
        }
      else
        {
         //--- ������ ��������
         for(int j=0; j<tab_elements_total; j++)
            m_tab_items[i].elements[j].Hide();
        }
     }
  }
//+------------------------------------------------------------------+
//| ���������� ������ ������� ����                                   |
//+------------------------------------------------------------------+
string CTreeView::CurrentFullPath(void)
  {
//--- ��� ������������ ���������� � ����������� ������
   string path="";
//--- ������ ����������� ������
   int li=m_selected_item_index;
//--- ������ ��� ������������ ����������
   string path_parts[];
//--- ������� �������� (�����) ����������� ������ ������������ ������,
//    �� ������, ���� ��� �����
   if(m_t_is_folder[li])
     {
      ::ArrayResize(path_parts,1);
      path_parts[0]=m_t_item_text[li];
     }
//--- �������� �� ����� ������
   int total=::ArraySize(m_t_list_index);
   for(int i=0; i<total; i++)
     {
      //--- ������������� ������ �����.
      //    ���� ����, ��������� � ���������� ������.
      if(!m_t_is_folder[i])
         continue;
      //--- ���� (1) ������ ������ ������ ��������� � �������� ������ ������ ����������� ���� �
      //    (2) ������ ������ ���������� ������ ��������� � �������� ������ ����������� ���� �
      //    (3) ����������� ������������������ ������� �����
      if(m_t_list_index[i]==m_t_prev_node_list_index[li] &&
         m_t_item_index[i]==m_t_prev_node_item_index[li] &&
         m_t_node_level[i]==m_t_node_level[li]-1)
        {
         //--- �������� ������ �� ���� ������� � �������� �������� ������
         int sz=::ArraySize(path_parts);
         ::ArrayResize(path_parts,sz+1);
         path_parts[sz]=m_t_item_text[i];
         //--- �������� ������ ��� ��������� ��������
         li=i;
         //--- ���� ����� �� �������� ������ ����, ������� �� �����
         if(m_t_node_level[i]==0 || i<=0)
            break;
         //--- �������� ������� �����
         i=-1;
        }
     }
//--- ������������ ������ - ������ ���� � ����������� ������ � ����������� ������
   total=::ArraySize(path_parts);
   for(int i=total-1; i>=0; i--)
      ::StringAdd(path,path_parts[i]+"\\");
//--- ���� ���������� � ����������� ������ ����� - �����
   if(m_t_is_folder[m_selected_item_index])
     {
      m_selected_item_file_name="";
      //--- ���� ����� � ������� ���������� �������
      if(m_selected_content_item_index>0)
        {
         //--- ���� ���������� ����� - ����, �������� ��� ��������
         if(!m_t_is_folder[m_c_tree_list_index[m_selected_content_item_index]])
            m_selected_item_file_name=m_c_item_text[m_selected_content_item_index];
        }
     }
//--- ���� ���������� � ����������� ������ ����� - ����
   else
//--- �������� ��� ��������
      m_selected_item_file_name=m_t_item_text[m_selected_item_index];
//--- ������� ����������
   return(path);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CTreeView::ChangeObjectsColor(void)
  {
//--- �����, ���� �������� ����� ��������� �� ��������� ������� ���� ���
//    ����� ������ ���� ������
   if(!m_lights_hover || m_mouse_state)
      return;
//--- ���� ����� �� ������� ��������� ������ ����������
   if(m_x_resize.IsVisible())
     {
      //--- �������� ����� ������� � �����
      ResetColors();
      return;
     }
//--- ���� ������� � ����������� ������
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
     {
      int li=m_td_list_index[i];
      if(li!=m_selected_item_index)
         m_items[li].ChangeObjectsColor();
     }
//--- �����, ���� ������� ���������� �� �����
   if(m_content_area_width<0)
      return;
//--- ���� ������� � ������ ����������
   int cd_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<cd_items_total; i++)
     {
      int li=m_cd_list_index[i];
      if(li!=m_selected_content_item_index)
         m_content_items[li].ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CTreeView::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� �������� � ����� ��������
   CElement::X(x+CElement::XGap());
   CElement::Y(y+CElement::YGap());
//--- ���������� ��������� � ����� ��������
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
   m_content_area.X(x+m_content_area.XGap());
   m_content_area.Y(y+m_content_area.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_content_area.X_Distance(m_content_area.X());
   m_content_area.Y_Distance(m_content_area.Y());
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CTreeView::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ��������� ���������
   CElement::IsVisible(true);
//--- �������� ���������� ��������
   CTreeView::Moving(m_wnd.X(),m_wnd.Y());
//--- ������� �������� ��� �������
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_content_area.Timeframes(OBJ_ALL_PERIODS);
//--- �������� ������ ���������, ���� ���������� ������� ������ �� ����������
   if(m_items_total>m_visible_items_total)
      m_scrollv.Show();
//--- �������� ���������� � ������� �������
   ShiftTreeList();
   ShiftContentList();
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CTreeView::Hide(void)
  {
//--- �����, ���� ������� ��� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_content_area.Timeframes(OBJ_NO_PERIODS);
//--- ������ ������ ������������ ������
   int total=::ArraySize(m_items);
   for(int i=0; i<total; i++)
      m_items[i].Hide();
//--- ������ ������ ������ ����������
   total=::ArraySize(m_content_items);
   for(int i=0; i<total; i++)
      m_content_items[i].Hide();
//--- ������ ������ ���������
   m_scrollv.Hide();
   m_content_scrollv.Hide();
//--- ������������� ������ ������ ���������
   m_scrollv.ChangeThumbSize(m_items_total,m_visible_items_total);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CTreeView::Reset(void)
  {
//--- ������, ���� ������� ����������
   if(CElement::IsDropdown())
      return;
//--- ������ � ��������
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| ��������                                                         |
//+------------------------------------------------------------------+
void CTreeView::Delete(void)
  {
//--- �������� ����������� ��������
   m_area.Delete();
   m_content_area.Delete();
//---
   int total=::ArraySize(m_items);
   for(int i=0; i<total; i++)
      m_items[i].Delete();
//---
   total=::ArraySize(m_content_items);
   for(int i=0; i<total; i++)
      m_content_items[i].Delete();
//---
   m_x_resize.Delete();
//--- ������������ �������� ��������
   ::ArrayFree(m_items);
   ::ArrayFree(m_content_items);
//---
   total=::ArraySize(m_tab_items);
   for(int i=0; i<total; i++)
      ::ArrayFree(m_tab_items[i].elements);
   ::ArrayFree(m_tab_items);
//---
   ::ArrayFree(m_t_prev_node_list_index);
   ::ArrayFree(m_t_list_index);
   ::ArrayFree(m_t_item_text);
   ::ArrayFree(m_t_path_bmp);
   ::ArrayFree(m_t_item_index);
   ::ArrayFree(m_t_node_level);
   ::ArrayFree(m_t_prev_node_item_index);
   ::ArrayFree(m_t_items_total);
   ::ArrayFree(m_t_folders_total);
   ::ArrayFree(m_t_item_state);
   ::ArrayFree(m_t_is_folder);
//---
   ::ArrayFree(m_td_list_index);
//---
   ::ArrayFree(m_c_list_index);
   ::ArrayFree(m_c_item_text);
//---
   ::ArrayFree(m_cd_item_text);
   ::ArrayFree(m_cd_list_index);
   ::ArrayFree(m_cd_tree_list_index);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
   m_selected_item_index =WRONG_VALUE;
   m_selected_content_item_index =WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CTreeView::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
      m_items[i].SetZorders();
//--- �����, ���� ���������� ������ �� ����� ���������� ���
//    ���� ������� ���������� ���������
   if(!m_show_item_content || m_content_area_width<0)
      return;
//---
   int content_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<content_items_total; i++)
      m_content_items[i].SetZorders();
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CTreeView::ResetZorders(void)
  {
   m_area.Z_Order(0);
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
      m_items[i].ResetZorders();
//--- �����, ���� ������ ���������� �����������
   if(!m_show_item_content)
      return;
//---
   int content_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<content_items_total; i++)
      m_content_items[i].ResetZorders();
  }
//+------------------------------------------------------------------+
//| ����� �����                                                      |
//+------------------------------------------------------------------+
void CTreeView::ResetColors(void)
  {
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
     {
      int li=m_td_list_index[i];
      if(li!=m_selected_item_index)
         m_items[li].ResetColors();
     }
//--- �����, ���� ���������� ������ �� ����� ���������� ���
//    ���� ������� ���������� ���������
   if(!m_show_item_content || m_content_area_width<0)
      return;
//---
   int content_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<content_items_total; i++)
     {
      int li=m_cd_list_index[i];
      if(li!=m_selected_content_item_index)
         m_content_items[li].ResetColors();
     }
  }
//+------------------------------------------------------------------+
//| ������� �� ������ ������������/�������������� ������ ������      |
//+------------------------------------------------------------------+
bool CTreeView::OnClickItemArrow(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������
   if(::StringFind(clicked_object,CElement::ProgramName()+"_0_treeitem_arrow_",0)<0)
      return(false);
//--- ������� ������������� �� ����� �������
   int id=IdFromObjectName(clicked_object);
//--- �����, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ������� ������ ������ � ����� ������
   int list_index=IndexFromObjectName(clicked_object);
//--- ������� ��������� ������� ������ � ��������� ���������������
   m_t_item_state[list_index]=!m_t_item_state[list_index];
   ((CChartObjectBmpLabel*)m_items[list_index].Object(1)).State(m_t_item_state[list_index]);
//--- �������� ����������� ������
   UpdateTreeViewList();
//--- ���������� ��������� �������� ������ ���������
   m_scrollv.CalculateThumbY();
//--- �������� �������� ����������� ������-�������
   ShowTabElements();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������ � ����������� ������                           |
//+------------------------------------------------------------------+
bool CTreeView::OnClickItem(const string clicked_object)
  {
//--- ������, ���� ������ ��������� � �������� ������
   if(m_scrollv.ScrollState() || m_content_scrollv.ScrollState())
      return(false);
//--- ������, ���� ����� ��� �������
   if(::StringFind(clicked_object,CElement::ProgramName()+"_0_treeitem_area_",0)<0)
      return(false);
//--- ������� ������������� �� ����� �������
   int id=IdFromObjectName(clicked_object);
//--- �����, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ������� ������� ������� �������� ������ ���������
   int v=m_scrollv.CurrentPos();
//--- �������� �� ������
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- �������� ��� �������������� ������ �� ���������
      if(v>=0 && v<m_items_total)
        {
         //--- ������� ����� ������ ������
         int li=m_td_list_index[v];
         //--- ���� ������ ���� ����� � ������
         if(m_items[li].Object(0).Name()==clicked_object)
           {
            //--- ������, ���� ���� ����� ��� �������
            if(li==m_selected_item_index)
               return(false);
            //--- ���� ������� ����� �������-������� � �������� ����� ������ ����������,
            //    �� ����� �������� ������ ��� ������
            if(m_tab_items_mode && !m_show_item_content)
              {
               //--- ���� ������� ����� �� �������� � ���� ������, ��������� ����
               if(m_t_items_total[li]>0)
                  break;
              }
            //--- ��������� ���� ����������� ����������� ������
            m_items[m_selected_item_index].HighlightItemState(false);
            //--- �������� ������ ��� �������� � ������� ��� ����
            m_selected_item_index=li;
            m_items[li].HighlightItemState(true);
            break;
           }
         v++;
        }
     }
//--- �������� ����� � ������� ����������
   if(m_selected_content_item_index>=0)
      m_content_items[m_selected_content_item_index].HighlightItemState(false);
//--- ����� ����������� ������
   m_selected_content_item_index=WRONG_VALUE;
//--- �������� ������ ����������
   UpdateContentList();
//--- ���������� ��������� �������� ������ ���������
   m_content_scrollv.CalculateThumbY();
//--- ��������������� ������ ����������
   ShiftContentList();
//--- �������� �������� ����������� ������-�������
   ShowTabElements();
//--- ��������� ��������� � ������ ����� ���������� � ����������� ������
   ::EventChartCustom(m_chart_id,ON_CHANGE_TREE_PATH,0,0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������ � ������ ����������                            |
//+------------------------------------------------------------------+
bool CTreeView::OnClickContentListItem(const string clicked_object)
  {
//--- �����, ���� ������� ���������� ���������
   if(m_content_area_width<0)
      return(false);
//--- ������, ���� ������ ��������� � �������� ������
   if(m_scrollv.ScrollState() || m_content_scrollv.ScrollState())
      return(false);
//--- ������, ���� ����� ��� �������
   if(::StringFind(clicked_object,CElement::ProgramName()+"_1_treeitem_area_",0)<0)
      return(false);
//--- ������� ������������� �� ����� �������
   int id=IdFromObjectName(clicked_object);
//--- �����, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ������� ���������� ������� � ������ ����������
   int content_items_total=::ArraySize(m_cd_list_index);
//--- ������� ������� ������� �������� ������ ���������
   int v=m_content_scrollv.CurrentPos();
//--- �������� �� ������
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- �������� ��� �������������� ������ �� ���������
      if(v>=0 && v<content_items_total)
        {
         //--- ������� ����� ������ ������
         int li=m_cd_list_index[v];
         //--- ���� ������ ���� ����� � ������
         if(m_content_items[li].Object(0).Name()==clicked_object)
           {
            //--- ���������� ���� ����������� ����������� ������
            if(m_selected_content_item_index>=0)
               m_content_items[m_selected_content_item_index].HighlightItemState(false);
            //--- �������� ������ ��� �������� � ������� ����
            m_selected_content_item_index=li;
            m_content_items[li].HighlightItemState(true);
           }
         v++;
        }
     }
//--- ��������� ��������� � ������ ����� ���������� � ����������� ������
   ::EventChartCustom(m_chart_id,ON_CHANGE_TREE_PATH,0,0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CTreeView::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
//| ��������� ������ �� ����� �������                                |
//+------------------------------------------------------------------+
int CTreeView::IndexFromObjectName(const string object_name)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- ������� ��� �����������
   u_sep=::StringGetCharacter("_",0);
//--- �������� ������
   ::StringSplit(object_name,u_sep,result);
   array_size=::ArraySize(result)-1;
//--- �������� ������ �� �������� �������
   if(array_size-2<0)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- ������� ������ ������
   return((int)result[array_size-2]);
  }
//+------------------------------------------------------------------+
//| ��������� ������ �������-�������                                 |
//+------------------------------------------------------------------+
void CTreeView::GenerateTabItemsArray(void)
  {
//--- �����, ���� ����� �������-������� ��������
   if(!m_tab_items_mode)
      return;
//--- ������� � ������ �������-������� ������ ������ ������
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- ���� � ���� ������ ���� ������ ������, ������� � ����������
      if(m_t_items_total[i]>0)
         continue;
      //--- �������� ������ ������� �������-������� �� ���� �������
      int array_size=::ArraySize(m_tab_items);
      ::ArrayResize(m_tab_items,array_size+1);
      //--- �������� ����� ������ ������
      m_tab_items[array_size].list_index=i;
     }
//--- ���� �������� ����� ���������� �������
   if(!m_show_item_content)
     {
      //--- ������� ������ ������� �������-�������
      int tab_items_total=::ArraySize(m_tab_items);
      //--- ������������� ������, ���� ����� �� ���������
      if(m_selected_item_index>=tab_items_total)
         m_selected_item_index=tab_items_total-1;
      //--- �������� ��������� �������� ������ � ������
      m_items[m_selected_item_index].HighlightItemState(false);
      //--- ������ ���������� �������
      int tab_index=m_tab_items[m_selected_item_index].list_index;
      m_selected_item_index=tab_index;
      //--- ������� ���� �����
      m_items[tab_index].HighlightItemState(true);
     }
  }
//+------------------------------------------------------------------+
//| ����������� � ��������� ������ �����                             |
//+------------------------------------------------------------------+
void CTreeView::SetNodeLevelBoundaries(void)
  {
//--- ��������� ����������� � ������������ ������� �����
   m_min_node_level =m_t_node_level[::ArrayMinimum(m_t_node_level)];
   m_max_node_level =m_t_node_level[::ArrayMaximum(m_t_node_level)];
  }
//+------------------------------------------------------------------+
//| ����������� � ��������� ������� ��������� ��������               |
//+------------------------------------------------------------------+
void CTreeView::SetRootItemsTotal(void)
  {
//--- ��������� ���������� ������� � �������� ��������
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ��� ����������� �������, �������� �������
      if(m_t_node_level[i]==m_min_node_level)
         m_root_items_total++;
     }
  }
//+------------------------------------------------------------------+
//| �������� ����������� ������ ������������ ������ ���������        |
//+------------------------------------------------------------------+
void CTreeView::ShiftTreeList(void)
  {
//--- ������ ��� ������ � ����������� ������
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- ���� ����� ������ ���������
   bool is_scroll=m_items_total>m_visible_items_total;
//--- ������ ������ ������� ������
   int w=(is_scroll)? m_area.XSize()-m_scrollv.ScrollWidth()-1 : m_area.XSize()-2;
//--- ����������� ������� �������
   int v=(is_scroll)? m_scrollv.CurrentPos() : 0;
   m_scrollv.CurrentPos(v);
//--- ���������� Y ������� ������ ������������ ������
   int y=CElement::Y()+1;
//---
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- �������� ��� �������������� ������ �� ���������
      if(v>=0 && v<m_items_total)
        {
         //--- ���������� ���������� Y
         y=(r>0)? y+m_item_y_size-1 : y;
         //--- ������� ����� ������ ������ ������������ ������
         int li=m_td_list_index[v];
         //--- ���������� ���������� � ������
         m_items[li].UpdateX(m_area.X()+1);
         m_items[li].UpdateY(y);
         m_items[li].UpdateWidth(w);
         //--- �������� �����
         m_items[li].Show();
         v++;
        }
     }
//--- ������������ ������ ���������
   if(is_scroll)
      m_scrollv.Reset();
  }
//+------------------------------------------------------------------+
//| �������� ������ ���������� ������������ ������ ���������         |
//+------------------------------------------------------------------+
void CTreeView::ShiftContentList(void)
  {
//--- �����, ���� (1) ���������� ������ �� ����� ���������� ���
//    (2) ���� ������� ���������� ���������
   if(!m_show_item_content || m_content_area_width<0)
      return;
//--- ������ ��� ������ � ������ ����������
   m_content_items_total=ContentItemsTotal();
   for(int i=0; i<m_content_items_total; i++)
      m_content_items[i].Hide();
//--- ������������ ��� ������� ����������
   m_content_area.Timeframes(OBJ_NO_PERIODS);
   m_content_area.Timeframes(OBJ_ALL_PERIODS);
//--- ������� ���������� ������������ ������� � ������ ����������
   int total=::ArraySize(m_cd_list_index);
//--- ���� ����� ������ ���������
   bool is_scroll=total>m_visible_items_total;
//--- ������ ������ ������� ������
   int w=(is_scroll) ? m_content_area.XSize()-m_content_scrollv.ScrollWidth()-1 : m_content_area.XSize()-2;
//--- ����������� ������� �������
   int v=(is_scroll) ?  m_content_scrollv.CurrentPos() : 0;
   m_content_scrollv.CurrentPos(v);
//--- ���������� Y ������� ������ ������������ ������
   int y=CElement::Y()+1;
//--- 
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- �������� ��� �������������� ������ �� ���������
      if(v>=0 && v<total)
        {
         //--- ���������� ���������� Y
         y=(r>0)? y+m_item_y_size-1 : y;
         //--- ������� ����� ������ ������ ������������ ������
         int li=m_cd_list_index[v];
         //--- ���������� ���������� � ������
         m_content_items[li].UpdateX(m_content_area.X()+1);
         m_content_items[li].UpdateY(y);
         m_content_items[li].UpdateWidth(w);
         //--- �������� �����
         m_content_items[li].Show();
         v++;
        }
     }
//--- ������������ ������ ���������
   if(is_scroll)
      m_content_scrollv.Reset();
  }
//+------------------------------------------------------------------+
//| ���������� ��������� �������                                     |
//+------------------------------------------------------------------+
void CTreeView::FastSwitching(void)
  {
//--- �����, ���� ��� ������� �������� ��� ����������� ����� ��������� ������ ������� ����������
   if(!CElement::MouseFocus() || m_x_resize.State())
      return;
//--- ����� ������� � ��������������� ��������, ���� ������ ���� ������
   if(!m_mouse_state)
      m_timer_counter=SPIN_DELAY_MSC;
//--- ���� �� ������ ���� ������
   else
     {
      //--- �������� ������� �� ������������� ��������
      m_timer_counter+=TIMER_STEP_MSC;
      //--- ������, ���� ������ ����
      if(m_timer_counter<0)
         return;
      //--- ���� ��������� �����
      if(m_scrollv.ScrollIncState())
        {
         m_scrollv.OnClickScrollInc(m_scrollv.ScrollIncName());
         ShiftTreeList();
        }
      //--- ���� ��������� ����
      else if(m_scrollv.ScrollDecState())
        {
         m_scrollv.OnClickScrollDec(m_scrollv.ScrollDecName());
         ShiftTreeList();
        }
      //--- �����, ���� ������� ���������� ���������
      if(m_content_area_width<0)
         return;
      //--- ���� ��������� �����
      if(m_content_scrollv.ScrollIncState())
        {
         m_content_scrollv.OnClickScrollInc(m_content_scrollv.ScrollIncName());
         ShiftContentList();
        }
      //--- ���� ��������� ����
      else if(m_content_scrollv.ScrollDecState())
        {
         m_content_scrollv.OnClickScrollDec(m_content_scrollv.ScrollDecName());
         ShiftContentList();
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������� �������                                        |
//+------------------------------------------------------------------+
void CTreeView::ResizeListArea(const int x,const int y)
  {
//--- �����, (1) ���� ������ ������� ���������� �� ����� �������� ���
//    (2) ���� ������� ���������� ��������� ��� (3) ������� ����� �������-�������
   if(!m_resize_list_area_mode || m_content_area_width<0 || m_tab_items_mode)
      return;
//--- �����, ���� ������ ��������� �������
   if(m_scrollv.ScrollState())
      return;
//--- �������� ���������� ��� ��������� ������ �������
   CheckXResizePointer(x,y);
//--- ���� ������ ��������, �������������� �����
   if(!m_x_resize.State())
     {
      //--- �������������� ����� ����� ������ ���, ��� � ������������
      if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()==CElement::Id())
        {
         m_wnd.IsLocked(false);
         m_wnd.IdActivatedElement(WRONG_VALUE);
         return;
        }
     }
   else
     {
      //--- �������� �� ����� �� ������������� ����������� 
      if(!CheckOutOfArea(x,y))
         return;
      //--- ����������� ����� � �������� ������������� ��������� ��������
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
      //--- ��������� X-���������� ������� �� ������ ������� ����
      m_x_resize.UpdateX(x-m_x_resize.XGap());
      //--- Y-���������� �������������, ������ ���� �� ����� �� ������� ��������
      if(y>m_area.Y() && y<m_area.Y2())
         m_x_resize.UpdateY(y-m_x_resize.YGap());
      //--- ���������� ������ ������������ ������
      UpdateTreeListWidth(x);
      //--- ���������� ������ ������ ����������
      UpdateContentListWidth(x);
      //--- �������� ���������� � ������� �������
      ShiftTreeList();
      ShiftContentList();
      //--- ������������ ���������
      m_x_resize.Reset();
     }
  }
//+------------------------------------------------------------------+
//| �������� ���������� ��� ��������� ������ �������                 |
//+------------------------------------------------------------------+
void CTreeView::CheckXResizePointer(const int x,const int y)
  {
//--- ���� ��������� �� �����������, �� ������ ���� � ��� �������
   if(!m_x_resize.State() && 
      y>m_area.Y() && y<m_area.Y2() && x>m_area.X2()-2 && x<m_area.X2()+3)
     {
      //--- �������� ���������� ��������� � ������� ��� �������
      int l_x=x-m_x_resize.XGap();
      int l_y=y-m_x_resize.YGap();
      m_x_resize.Moving(l_x,l_y);
      m_x_resize.Show();
      //--- ���������� ���� ���������
      m_x_resize.IsVisible(true);
      //--- ���� ����� ������ ���� ������
      if(m_mouse_state)
         //--- ���������� ���������
         m_x_resize.State(true);
     }
   else
     {
      //--- ���� ����� ������ ���� ������
      if(!m_mouse_state)
        {
         //--- ��������������� � ������ ���������
         m_x_resize.State(false);
         m_x_resize.Hide();
         //--- ����� ���� ���������
         m_x_resize.IsVisible(false);
        }
     }
  }
//+------------------------------------------------------------------+
//| �������� �� ����� �� �����������                                 |
//+------------------------------------------------------------------+
bool CTreeView::CheckOutOfArea(const int x,const int y)
  {
//--- �����������
   int area_limit=80;
//--- ���� ������� �� ������� �������� �� ����������� ...
   if(x<m_area.X()+area_limit || x>m_content_area.X2()-area_limit)
     {
      // ... ���������� ��������� ������ �� ���������, �� ������ �� �������
      if(y>m_area.Y() && y<m_area.Y2())
         m_x_resize.UpdateY(y-m_x_resize.YGap());
      //--- �� �������� ������ �������
      return(false);
     }
//--- �������� ������ �������
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� ������ ������������ ������                            |
//+------------------------------------------------------------------+
void CTreeView::UpdateTreeListWidth(const int x)
  {
//--- ���������� � ��������� ������ ������� ������������ ������
   m_area.X_Size(x-m_area.X());
   m_area.XSize(m_area.X_Size());
//--- ���������� � ��������� ������ ��� ������� � ����������� ������ � ������ ������ ���������
   int l_w=(m_items_total>m_visible_items_total) ? m_area.XSize()-m_scrollv.ScrollWidth()-4 : m_area.XSize()-1;
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
      m_items[i].UpdateWidth(l_w);
//--- ���������� � ��������� ���������� ��� ������ ��������� ������������ ������
   m_scrollv.X(m_area.X2()-m_scrollv.ScrollWidth());
   m_scrollv.XDistance(m_scrollv.X());
  }
//+------------------------------------------------------------------+
//| ���������� ������ ������ � ������� ����������                    |
//+------------------------------------------------------------------+
void CTreeView::UpdateContentListWidth(const int x)
  {
//--- ���������� � ��������� ���������� X, ������ � ������ ��� ������� ����������
   int l_x=m_area.X2()-1;
   m_content_area.X(l_x);
   m_content_area.X_Distance(l_x);
   m_content_area.XGap(l_x-m_wnd.X());
   m_content_area.XSize(CElement::X2()-m_content_area.X());
   m_content_area.X_Size(m_content_area.XSize());
//--- ���������� � ��������� ���������� X � ������ ��� ������� � ������ ����������
   l_x=m_content_area.X()+1;
   int l_w=(m_content_items_total>m_visible_items_total) ? m_content_area.XSize()-m_content_scrollv.ScrollWidth()-4 : m_content_area.XSize()-2;
   int total=::ArraySize(m_content_items);
   for(int i=0; i<total; i++)
     {
      m_content_items[i].UpdateX(l_x);
      m_content_items[i].UpdateWidth(l_w);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� � ������ ������������ �������                    |
//| � ����������� ������                                             |
//+------------------------------------------------------------------+
void CTreeView::AddDisplayedTreeItem(const int list_index)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_td_list_index);
   ::ArrayResize(m_td_list_index,array_size+1);
//--- �������� �������� ���������� ����������
   m_td_list_index[array_size]=list_index;
  }
//+------------------------------------------------------------------+
//| ��������� ����������� ������                                     |
//+------------------------------------------------------------------+
void CTreeView::UpdateTreeViewList(void)
  {
//--- ������� ��� �������� ������������������ �������:
   int l_prev_node_list_index[]; // ����� ������ ������ ����������� ����
   int l_item_index[];           // ��������� ������ ������
   int l_items_total[];          // ���������� ������� � ����
   int l_folders_total[];        // ���������� ����� � ����
//--- ������� ��������� ������ ��������
   int begin_size=m_max_node_level+2;
   ::ArrayResize(l_prev_node_list_index,begin_size);
   ::ArrayResize(l_item_index,begin_size);
   ::ArrayResize(l_items_total,begin_size);
   ::ArrayResize(l_folders_total,begin_size);
//--- ������������� ��������
   ::ArrayInitialize(l_prev_node_list_index,-1);
   ::ArrayInitialize(l_item_index,-1);
   ::ArrayInitialize(l_items_total,-1);
   ::ArrayInitialize(l_folders_total,-1);
//--- ����������� ������ ������������ ������� ������������ ������
   ::ArrayFree(m_td_list_index);
//--- ������� ��������� �������� �������
   int ii=0;
//--- ��� ��������� ����� ���������� ������ � �������� ��������
   bool end_list=false;
//--- �������� ������������ ������ � ������. ���� ����� �������� �� ��� ���, ����: 
//    1: ������� ����� �� ������ �������������;
//    2: �� ����� �� ���������� ������ (����� �������� ���� ��������� � ���� �������);
//    3: ��������� �� ������ ������������.
   int items_total=::ArraySize(m_items);
   for(int nl=m_min_node_level; nl<=m_max_node_level && !end_list; nl++)
     {
      for(int i=0; i<items_total && !::IsStopped(); i++)
        {
         //--- ���� ������� ����� "���������� ������ �����"
         if(m_file_navigator_mode==FN_ONLY_FOLDERS)
           {
            //--- ���� ��� ����, ������� � ���������� ������
            if(!m_t_is_folder[i])
               continue;
           }
         //--- ���� (1) ��� �� ��� ���� ��� (2) ���������������� ��������� �������� ������� �� �����������,
         //    ������� � ����������
         if(nl!=m_t_node_level[i] || m_t_item_index[i]<=l_item_index[nl])
            continue;
         //--- ������� � ���������� ������, ���� (1) ������ �� � �������� �������� � 
         //    (2) ����� ������ ������ ����������� ���� �� ����� ������������ � ������
         if(nl>m_min_node_level && m_t_prev_node_list_index[i]!=l_prev_node_list_index[nl])
            continue;
         //--- �������� ��������� ������ ������, ���� ��������� ����� �� ������ ������� ���������� ������
         if(m_t_item_index[i]+1>=l_items_total[nl])
            ii=m_t_item_index[i];
         //--- ���� ������ �������� ������ ��������
         if(m_t_item_state[i])
           {
            //--- ������� ����� � ������ ������������ ������� � ����������� ������
            AddDisplayedTreeItem(i);
            //--- �������� ������� �������� � ������� � ���������� ����
            int n=nl+1;
            l_prev_node_list_index[n] =m_t_list_index[i];
            l_item_index[nl]          =m_t_item_index[i];
            l_items_total[n]          =m_t_items_total[i];
            l_folders_total[n]        =m_t_folders_total[i];
            //--- ������� ������� ��������� �������� �������
            ii=0;
            //--- ������� � ���������� ����
            break;
           }
         //--- ������� ����� � ������ ������������ ������� � ����������� ������
         AddDisplayedTreeItem(i);
         //--- �������� ������� ��������� �������� �������
         ii++;
         //--- ���� ����� �� ���������� ������ � �������� ��������
         if(nl==m_min_node_level && ii>=m_root_items_total)
           {
            //--- ��������� ���� � �������� ������� ����
            end_list=true;
            break;
           }
         //--- ���� �� ���������� ������ � �������� �������� ��� �� �����
         else if(nl>m_min_node_level)
           {
            //--- ������� ���������� ������� � ������� ����
            int total=(m_file_navigator_mode==FN_ONLY_FOLDERS)? l_folders_total[nl]: l_items_total[nl];
            //--- ���� ��� �� ��������� ��������� ������ ������, ������� � ����������
            if(ii<total)
               continue;
            //--- ���� ����� �� ���������� ���������� �������, �� 
            //    ����� ��������� �� ���������� ���� � ���������� � ������, �� ������� ������������
            while(true)
              {
               //--- ������� �������� �������� ���� � ������������� ���� ��������
               l_prev_node_list_index[nl] =-1;
               l_item_index[nl]           =-1;
               l_items_total[nl]          =-1;
               //--- ��������� ������� �����, ���� ����������� ��������� � ���������� ������� � ��������� ������� 
               //    ��� �� ����� �� ��������� ��������
               if(l_item_index[nl-1]+1>=l_items_total[nl-1])
                 {
                  if(nl-1==m_min_node_level)
                     break;
                  //---
                  nl--;
                  continue;
                 }
               //---
               break;
              }
            //--- ������� �� ���������� ����
            nl=nl-2;
            //--- ������� ������� ��������� �������� ������� � ������� � ���������� ����
            ii=0;
            break;
           }
        }
     }
//--- ����������� ��������:
   RedrawTreeList();
  }
//+------------------------------------------------------------------+
//| ��������� ������ ����������                                      |
//+------------------------------------------------------------------+
void CTreeView::UpdateContentList(void)
  {
//--- ������ ����������� ������
   int li=m_selected_item_index;
//--- ��������� ������� ������ ����������
   ::ArrayFree(m_cd_item_text);
   ::ArrayFree(m_cd_list_index);
   ::ArrayFree(m_cd_tree_list_index);
//--- ���������� ������ ����������
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ��������� (1) ������ ����� � (2) ��������� ������� �������, � �����
      //    (3) ������ ����������� ���� � �������� ����������� ������
      if(m_t_node_level[i]==m_t_node_level[li]+1 && 
         m_t_prev_node_item_index[i]==m_t_item_index[li] &&
         m_t_prev_node_list_index[i]==li)
        {
         //--- �������� ������� ������������ ������� ������ ����������
         int size     =::ArraySize(m_cd_list_index);
         int new_size =size+1;
         ::ArrayResize(m_cd_item_text,new_size);
         ::ArrayResize(m_cd_list_index,new_size);
         ::ArrayResize(m_cd_tree_list_index,new_size);
         //--- �������� � �������� ����� ������ � ����� ������ ������������ ������
         m_cd_item_text[size]       =m_t_item_text[i];
         m_cd_tree_list_index[size] =m_t_list_index[i];
        }
     }
//--- ���� � ����� ������ �� ������, �������� ������ ����� �������� ������ ����������
   int cd_items_total=::ArraySize(m_cd_list_index);
   if(cd_items_total>0)
     {
      //--- ������� �������
      int c=0;
      //--- �������� �� ������
      int c_items_total=::ArraySize(m_c_list_index);
      for(int i=0; i<c_items_total; i++)
        {
         //--- ���� �������� � ����� ������� ������� ������������ ������ ���������
         if(m_c_item_text[i]==m_cd_item_text[c] && 
            m_c_tree_list_index[i]==m_cd_tree_list_index[c])
           {
            //--- �������� ����� ������ ������ ���������� � ������� � ����������
            m_cd_list_index[c]=m_c_list_index[i];
            c++;
            //--- ����� �� �����, ���� ����� ����� ������������� ������
            if(c>=cd_items_total)
               break;
           }
        }
     }
//--- ��������������� ������ �������� ������ ���������
   m_content_scrollv.ChangeThumbSize(cd_items_total,m_visible_items_total);
//--- ��������������� ������ ���������� ������
   ShiftContentList();
  }
//+------------------------------------------------------------------+
//| ����������� ��������                                             |
//+------------------------------------------------------------------+
void CTreeView::RedrawTreeList(void)
  {
//--- ������ �������
   Hide();
//--- ���������� Y ������� ������ ������������ ������
   int y=CElement::Y()+1;
//--- ������� ���������� �������
   m_items_total=::ArraySize(m_td_list_index);
//--- ������������� ������ ������ ���������
   m_scrollv.ChangeThumbSize(m_items_total,m_visible_items_total);
//--- ������ ������ ������� ������������ ������
   int w=(m_items_total>m_visible_items_total) ? CElement::XSize()-m_scrollv.ScrollWidth() : CElement::XSize()-2;
//--- ��������� ����� ��������
   for(int i=0; i<m_items_total; i++)
     {
      //--- ������ ���������� Y ��� ������� ������
      y=(i>0)? y+m_item_y_size-1 : y;
      //--- ������� ����� ������ ������ � ������
      int li=m_td_list_index[i];
      //--- ������� ���������� � ������
      m_items[li].UpdateY(y);
      m_items[li].UpdateWidth(w);
     }
//--- �������� �������
   Show();
  }
//+------------------------------------------------------------------+
//| �������� ������� ����������� ������ �� ����� �� ���������        |
//+------------------------------------------------------------------+
void CTreeView::CheckSelectedItemIndex(void)
  {
//--- ���� ������ �� ��������
   if(m_selected_item_index==WRONG_VALUE)
     {
      //--- ����� ������� ������ ����� � ������
      m_selected_item_index=0;
      return;
     }
//--- �������� �� ����� �� ���������
   int array_size=::ArraySize(m_items);
   if(array_size<1 || m_selected_item_index<0 || m_selected_item_index>=array_size)
     {
      //--- ����� ������� ������ ����� � ������
      m_selected_item_index=0;
      return;
     }
  }
//+------------------------------------------------------------------+
