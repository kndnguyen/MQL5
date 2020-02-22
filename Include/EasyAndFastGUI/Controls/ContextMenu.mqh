//+------------------------------------------------------------------+
//|                                                  ContextMenu.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "MenuItem.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������������ ����                             |
//+------------------------------------------------------------------+
class CContextMenu : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������ ����
   CRectLabel        m_area;
   CMenuItem         m_items[];
   CSeparateLine     m_sep_line[];
   //--- ��������� �� ���������� ����
   CMenuItem        *m_prev_node;
   //--- �������� ����
   int               m_area_zorder;
   color             m_area_color;
   color             m_area_border_color;
   color             m_area_color_hover;
   color             m_area_color_array[];
   //--- �������� ������ ����
   int               m_item_y_size;
   color             m_item_back_color;
   color             m_item_border_color;
   color             m_item_back_color_hover;
   color             m_item_back_color_hover_off;
   color             m_label_color;
   color             m_label_color_hover;
   string            m_right_arrow_file_on;
   string            m_right_arrow_file_off;
   //--- �������� �������������� �����
   color             m_sepline_dark_color;
   color             m_sepline_light_color;
   //--- ������� ������� ������� ����:
   //    (1) �����, (2) ����� ���������� ������, (3) ����� ���������������� ������
   string            m_label_text[];
   string            m_path_bmp_on[];
   string            m_path_bmp_off[];
   //--- ������ ������� �������� ������� ����, ����� ������� ����� ���������� �������������� �����
   int               m_sep_line_index[];
   //--- ��������� ������������ ����
   bool              m_context_menu_state;
   //--- ������� �������� ������������ ����
   ENUM_FIX_CONTEXT_MENU m_fix_side;
   //--- ����� ���������� ������������ ����. �� ����, ��� �������� � ����������� ����.
   bool              m_free_context_menu;
   //---
public:
                     CContextMenu(void);
                    ~CContextMenu(void);
   //--- ������ ��� �������� ������������ ����
   bool              CreateContextMenu(const long chart_id,const int window,const int x=0,const int y=0);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   bool              CreateSeparateLine(const int line_number,const int x,const int y);
   //---
public:
   //--- (1) ��������� ��������� �����,
   //    (2) ��������� � (3) ���������� ��������� ����������� ����, (4) ��������� ������ ���������� ������������ ����
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);           }
   CMenuItem        *PrevNodePointer(void)                    const { return(m_prev_node);                  }
   void              PrevNodePointer(CMenuItem &object)             { m_prev_node=::GetPointer(object);     }
   void              FreeContextMenu(const bool flag)               { m_free_context_menu=flag;             }
   //--- ���������� ��������� ������ �� ������������ ����
   CMenuItem        *ItemPointerByIndex(const int index);

   //--- ������ ��� ��������� �������� ���� ������������ ����:
   //    ���� ���� ������������ ����
   void              AreaBackColor(const color clr)                 { m_area_color=clr;                     }
   void              AreaBorderColor(const color clr)               { m_area_border_color=clr;              }

   //--- (1) ���������� ������� ����, (2) ������, (3) ���� ���� � (4) ���� ����� ������ ���� 
   int               ItemsTotal(void)                         const { return(::ArraySize(m_items));         }
   void              ItemYSize(const int y_size)                    { m_item_y_size=y_size;                 }
   void              ItemBackColor(const color clr)                 { m_item_back_color=clr;                }
   void              ItemBorderColor(const color clr)               { m_item_border_color=clr;              }
   //--- ���� ���� (1) ���������� � (2) ���������������� ������ ���� ��� ��������� ������� ����
   void              ItemBackColorHover(const color clr)            { m_item_back_color_hover=clr;          }
   void              ItemBackColorHoverOff(const color clr)         { m_item_back_color_hover_off=clr;      }
   //--- ���� ������ (1) ������� � (2) � ������
   void              LabelColor(const color clr)                    { m_label_color=clr;                    }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;              }
   //--- ����������� �������� ��� �������� ������� ������������ ���� � ������
   void              RightArrowFileOn(const string file_path)       { m_right_arrow_file_on=file_path;      }
   void              RightArrowFileOff(const string file_path)      { m_right_arrow_file_off=file_path;     }
   //--- (1) Ҹ���� � (2) ������� ���� �������������� �����
   void              SeparateLineDarkColor(const color clr)         { m_sepline_dark_color=clr;             }
   void              SeparateLineLightColor(const color clr)        { m_sepline_light_color=clr;            }

   //--- ��������� ����� ���� � ���������� ���������� �� �������� ������������ ����
   void              AddItem(const string text,const string path_bmp_on,const string path_bmp_off,const ENUM_TYPE_MENU_ITEM type);
   //--- ��������� �������������� ����� ����� ���������� ������ �� �������� ������������ ����
   void              AddSeparateLine(const int item_index);

   //--- ���������� �������� (������������ �����)
   string            DescriptionByIndex(const int index);
   //--- ���������� ��� ������ ����
   ENUM_TYPE_MENU_ITEM TypeMenuItemByIndex(const int index);

   //--- (1) ��������� � (2) ��������� ��������� ��������
   bool              CheckBoxStateByIndex(const int index);
   void              CheckBoxStateByIndex(const int index,const bool state);
   //--- (1) ���������� � (2) ������������� id �����-������ �� �������
   int               RadioItemIdByIndex(const int index);
   void              RadioItemIdByIndex(const int item_index,const int radio_id);
   //--- (1) ���������� ���������� �����-�����, (2) ����������� �����-�����
   int               SelectedRadioItem(const int radio_id);
   void              SelectedRadioItem(const int radio_index,const int radio_id);

   //--- (1) ��������� � (2) ��������� ��������� ������������ ����, (3) ��������� ������ �������� ������������ ����
   bool              ContextMenuState(void)                   const { return(m_context_menu_state);         }
   void              ContextMenuState(const bool flag)              { m_context_menu_state=flag;            }
   void              FixSide(const ENUM_FIX_CONTEXT_MENU side)      { m_fix_side=side;                      }

   //--- �������� ���� ������� ���� ��� ��������� �������
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
   //--- �������� ������� �� �������� ���� ����������� ����
   void              CheckHideContextMenus(void);
   //--- �������� ������� �� �������� ���� ����������� ����, ������� ���� ������� ����� �����
   void              CheckHideBackContextMenus(void);
   //--- ��������� ������� �� ������, � �������� ��� ����������� ���� ���������
   bool              OnClickMenuItem(const string clicked_object);
   //--- ���� ��������� �� ������ ���� ��� ���������
   void              ReceiveMessageFromMenuItem(const int id_item,const int index_item,const string message_item);
   //--- ��������� (1) �������������� � (2) ������� �� ����� ������ ����
   int               IdFromObjectName(const string object_name);
   int               IndexFromObjectName(const string object_name);
   //--- ��������� (1) �������������� � (2) ������� �� ��������� �����-������
   int               RadioIdFromMessage(const string message);
   int               RadioIndexByItemIndex(const int index);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CContextMenu::CContextMenu(void) : m_context_menu_state(false),
                                   m_free_context_menu(false),
                                   m_fix_side(FIX_RIGHT),
                                   m_item_y_size(24),
                                   m_area_color(C'15,15,15'),
                                   m_area_color_hover(C'51,153,255'),
                                   m_area_border_color(clrWhiteSmoke),
                                   m_label_color(clrWhite),
                                   m_label_color_hover(clrWhite),
                                   m_sepline_dark_color(clrBlack),
                                   m_sepline_light_color(clrDimGray),
                                   m_right_arrow_file_on(""),
                                   m_right_arrow_file_off("")
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_area_zorder=0;
//--- ����������� ���� �������� ���������� ���������
   CElement::IsDropdown(true);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CContextMenu::~CContextMenu(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CContextMenu::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ���������� ������� ����
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- ������� �����
      int x=(int)lparam;
      int y=(int)dparam;
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- �����, ���� ��� ��������� ����������� ����
      if(m_free_context_menu)
         return;
      //--- ���� ����������� ���� �������� � ����� ������ ���� ������
      if(m_context_menu_state && sparam=="1")
        {
         //--- �������� ������� �� �������� ���� ����������� ����
         CheckHideContextMenus();
         return;
        }
      //--- �������� ������� �� �������� ���� ����������� ����, ������� ���� ������� ����� �����
      CheckHideBackContextMenus();
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
//--- ��������� ������� ON_CLICK_MENU_ITEM
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_MENU_ITEM)
     {
      //--- �����, ���� ��� ��������� ����������� ����
      if(m_free_context_menu)
         return;
      //---
      int    item_id      =int(lparam);
      int    item_index   =int(dparam);
      string item_message =sparam;
      //--- ���� ��������� �� ������ ���� ��� ���������
      ReceiveMessageFromMenuItem(item_id,item_index,item_message);
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CContextMenu::OnEventTimer(void)
  {
//--- ��������� ����� ������� ���� ��� ��������� �������
   ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| ������ ����������� ����                                         |
//+------------------------------------------------------------------+
bool CContextMenu::CreateContextMenu(const long chart_id,const int subwin,const int x=0,const int y=0)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������������ ���� ��� ����� �������� "
              "������ ���� � ������� ������ WindowPointer(CWindow &object).");
      return(false);
     }
//--- ���� ��� ����������� ����������� ����
   if(!m_free_context_menu)
     {
      //--- �����, ���� ��� ��������� �� ���������� ���� 
      if(::CheckPointer(m_prev_node)==POINTER_INVALID)
        {
         ::Print(__FUNCTION__," > ����� ��������� ������������ ���� ��� ����� �������� "
                 "��������� �� ���������� ���� � ������� ������ CContextMenu::PrevNodePointer(CMenuItem &object).");
         return(false);
        }
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
//--- ���� ���������� �� �������
   if(x==0 || y==0)
     {
      m_x =(m_fix_side==FIX_RIGHT)? m_prev_node.X2()-3 : m_prev_node.X()+1;
      m_y =(m_fix_side==FIX_RIGHT)? m_prev_node.Y()-1  : m_prev_node.Y2()-1;
     }
//--- ���� ���������� �������
   else
     {
      m_x =x;
      m_y =y;
     }
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ������������ ����
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- ������ �������
   Hide();
//--- �������� ���� ��������
   ResetColors();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ������� ������������ ����                          |
//+------------------------------------------------------------------+
bool CContextMenu::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_contextmenu_bg_"+(string)CElement::Id();
//--- ������ ������ ������������ ���� ������� �� ���������� ������� ���� � �������������� �����
   int items_total =ItemsTotal();
   int sep_y_size  =::ArraySize(m_sep_line)*9;
   m_y_size        =(m_item_y_size*items_total+2)+sep_y_size-(items_total-1);
//--- ��������� ��� ������������ ����
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� ��������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- ������� ����
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ������� ����                                      |
//+------------------------------------------------------------------+
bool CContextMenu::CreateItems(void)
  {
   int s =0;     // ��� ����������� ��������� �������������� �����
   int x =m_x+1; // ���������� X
   int y =m_y+1; // ���������� Y. ����� �������������� � ����� ��� ������� ������ ����.
//--- ���������� �������������� �����
   int sep_lines_total=::ArraySize(m_sep_line_index);
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ������ ���������� Y
      y=(i>0)? y+m_item_y_size-1 : y;
      //--- �������� ��������� �����
      m_items[i].WindowPointer(m_wnd);
      //--- ���� ����������� ���� � ���������, �� ������� ��������� �� ���������� ����
      if(!m_free_context_menu)
         m_items[i].PrevNodePointer(m_prev_node);
      //--- ��������� ��������
      m_items[i].XSize(m_x_size-2);
      m_items[i].YSize(m_item_y_size);
      m_items[i].IconFileOn(m_path_bmp_on[i]);
      m_items[i].IconFileOff(m_path_bmp_off[i]);
      m_items[i].AreaBackColor(m_area_color);
      m_items[i].AreaBackColorHoverOff(m_item_back_color_hover_off);
      m_items[i].AreaBorderColor(m_area_color);
      m_items[i].LabelColor(m_label_color);
      m_items[i].LabelColorHover(m_label_color_hover);
      m_items[i].RightArrowFileOn(m_right_arrow_file_on);
      m_items[i].RightArrowFileOff(m_right_arrow_file_off);
      m_items[i].IsDropdown(m_is_dropdown);
      //--- ������� �� ������� ����� ������
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- �������� ������ ����
      if(!m_items[i].CreateMenuItem(m_chart_id,m_subwin,i,m_label_text[i],x,y))
         return(false);
      //--- �������� �����
      CElement::MouseFocus(false);
      //--- ������� � ����������, ���� ��� �������������� ����� �����������
      if(s>=sep_lines_total)
         continue;
      //--- ���� ������� �������, ������ ����� ����� ������ ����� ���������� �������������� �����
      if(i==m_sep_line_index[s])
        {
         //--- ����������
         int l_x=x+5;
         y=y+m_item_y_size+2;
         //--- ��������� �������������� �����
         if(!CreateSeparateLine(s,l_x,y))
            return(false);
         //--- ������������� ���������� Y ��� ���������� ������
         y=y-m_item_y_size+7;
         //--- ���������� �������� �������������� �����
         s++;
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������������� �����                                     |
//+------------------------------------------------------------------+
bool CContextMenu::CreateSeparateLine(const int line_number,const int x,const int y)
  {
//--- �������� ��������� �����
   m_sep_line[line_number].WindowPointer(m_wnd);
//--- ��������� ��������
   m_sep_line[line_number].TypeSepLine(H_SEP_LINE);
   m_sep_line[line_number].DarkColor(m_sepline_dark_color);
   m_sep_line[line_number].LightColor(m_sepline_light_color);
//--- �������� �������������� �����
   if(!m_sep_line[line_number].CreateSeparateLine(m_chart_id,m_subwin,line_number,x,y,m_x_size-10,2))
      return(false);
//--- �������� ��������� �������
   CElement::AddToArray(m_sep_line[line_number].Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������ ���� �� �������                      |
//+------------------------------------------------------------------+
CMenuItem *CContextMenu::ItemPointerByIndex(const int index)
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
//| ��������� ����� ����                                             |
//+------------------------------------------------------------------+
void CContextMenu::AddItem(const string text,const string path_bmp_on,const string path_bmp_off,const ENUM_TYPE_MENU_ITEM type)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_label_text,array_size+1);
   ::ArrayResize(m_path_bmp_on,array_size+1);
   ::ArrayResize(m_path_bmp_off,array_size+1);
//--- �������� �������� ���������� ����������
   m_label_text[array_size]   =text;
   m_path_bmp_on[array_size]  =path_bmp_on;
   m_path_bmp_off[array_size] =path_bmp_off;
//--- ��������� ���� ������ ����
   m_items[array_size].TypeMenuItem(type);
  }
//+------------------------------------------------------------------+
//| ��������� �������������� �����                                   |
//+------------------------------------------------------------------+
void CContextMenu::AddSeparateLine(const int item_index)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_sep_line);
   ::ArrayResize(m_sep_line,array_size+1);
   ::ArrayResize(m_sep_line_index,array_size+1);
//--- �������� ����� �������
   m_sep_line_index[array_size]=item_index;
  }
//+------------------------------------------------------------------+
//| ���������� �������� ������ �� �������                            |
//+------------------------------------------------------------------+
string CContextMenu::DescriptionByIndex(const int index)
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
//--- ������� �������� ������
   return(m_items[i].LabelText());
  }
//+------------------------------------------------------------------+
//| ���������� ��� ������ �� �������                                 |
//+------------------------------------------------------------------+
ENUM_TYPE_MENU_ITEM CContextMenu::TypeMenuItemByIndex(const int index)
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
//--- ������� ��� ������
   return(m_items[i].TypeMenuItem());
  }
//+------------------------------------------------------------------+
//| ���������� ��������� �������� �� �������                         |
//+------------------------------------------------------------------+
bool CContextMenu::CheckBoxStateByIndex(const int index)
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
//--- ������� ��������� ������
   return(m_items[i].CheckBoxState());
  }
//+------------------------------------------------------------------+
//| ������������� ��������� �������� �� �������                      |
//+------------------------------------------------------------------+
void CContextMenu::CheckBoxStateByIndex(const int index,const bool state)
  {
//--- �������� �� ����� �� ���������
   int size=::ArraySize(m_items);
   if(size<1 || index<0 || index>=size)
      return;
//--- ���������� ���������
   m_items[index].CheckBoxState(state);
  }
//+------------------------------------------------------------------+
//| ���������� id �����-������ �� �������                            |
//+------------------------------------------------------------------+
int CContextMenu::RadioItemIdByIndex(const int index)
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
//--- ������� �������������
   return(m_items[i].RadioButtonID());
  }
//+------------------------------------------------------------------+
//| ������������� id ��� �����-������ �� �������                     |
//+------------------------------------------------------------------+
void CContextMenu::RadioItemIdByIndex(const int index,const int id)
  {
//--- �������� �� ����� �� ���������
   int array_size=::ArraySize(m_items);
   if(array_size<1 || index<0 || index>=array_size)
      return;
//--- ���������� �������������
   m_items[index].RadioButtonID(id);
  }
//+------------------------------------------------------------------+
//| ���������� ������ �����-������ �� id                             |
//+------------------------------------------------------------------+
int CContextMenu::SelectedRadioItem(const int radio_id)
  {
//--- ������� �����-�������
   int count_radio_id=0;
//--- �������� � ����� �� ������ ������� ������������ ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ������� � ����������, ���� �� �����-�����
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- ���� �������������� ���������
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- ���� ��� �������� �����-�����, ������� �� �����
         if(m_items[i].RadioButtonState())
            break;
         //--- ��������� ������� �����-�������
         count_radio_id++;
        }
     }
//--- ������� ������
   return(count_radio_id);
  }
//+------------------------------------------------------------------+
//| ����������� �����-����� �� ������� � id                          |
//+------------------------------------------------------------------+
void CContextMenu::SelectedRadioItem(const int radio_index,const int radio_id)
  {
//--- ������� �����-�������
   int count_radio_id=0;
//--- �������� � ����� �� ������ ������� ������������ ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ������� � ����������, ���� �� �����-�����
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- ���� �������������� ���������
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- ����������� �����-�����
         if(count_radio_id==radio_index)
            m_items[i].RadioButtonState(true);
         else
            m_items[i].RadioButtonState(false);
         //--- ��������� ������� �����-�������
         count_radio_id++;
        }
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CContextMenu::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//--- ����������� ������� ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Moving(x,y);
//--- ����������� �������������� �����
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| ���������� ����������� ����                                      |
//+------------------------------------------------------------------+
void CContextMenu::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- �������� ������� ������������ ����
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- �������� ������ ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Show();
//--- �������� �������������� �����
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Show();
//--- �������� ���� ��������
   ResetColors();
//--- ��������� ������ �������� ��������
   CElement::IsVisible(true);
//--- ��������� ������������ ����
   m_context_menu_state=true;
//--- �������� ��������� � ���������� ����
   if(!m_free_context_menu)
      m_prev_node.ContextMenuState(true);
//--- ����������� �����
   m_wnd.IsLocked(true);
//--- �������� ������ �� ��������� ����������� �� ������� ����� ������� ����
   ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,CElement::Id(),0.0,"");
  }
//+------------------------------------------------------------------+
//| �������� ����������� ����                                        |
//+------------------------------------------------------------------+
void CContextMenu::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ������� ������������ ����
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ ������ ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- ������ �������������� �����
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Hide();
//--- �������� �����
   CElement::MouseFocus(false);
//--- ��������� ������ �������� ��������
   CElement::IsVisible(false);
//--- ��������� ������������ ����
   m_context_menu_state=false;
//--- �������� ��������� � ���������� ����
   if(!m_free_context_menu)
      m_prev_node.ContextMenuState(false);
//--- �������� ������ �� �������������� ����������� �� ������� ����� ������� ����
   ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CContextMenu::Reset(void)
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
void CContextMenu::Delete(void)
  {
//--- �������� ��������  
   m_area.Delete();
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Delete();
//--- �������� �������������� �����
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Delete();
//--- ������������ �������� ��������
   ::ArrayFree(m_items);
   ::ArrayFree(m_sep_line);
   ::ArrayFree(m_sep_line_index);
   ::ArrayFree(m_label_text);
   ::ArrayFree(m_path_bmp_on);
   ::ArrayFree(m_path_bmp_off);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   m_context_menu_state=false;
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CContextMenu::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CContextMenu::ResetZorders(void)
  {
   m_area.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ����� ����� �������� ��������                                    |
//+------------------------------------------------------------------+
void CContextMenu::ResetColors(void)
  {
//--- �������� �� ���� ������� ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- �������� ���� ������ ����
      m_items[i].ResetColors();
     }
  }
//+------------------------------------------------------------------+
//| �������� ������� �� �������� ���� ����������� ����               |
//+------------------------------------------------------------------+
void CContextMenu::CheckHideContextMenus(void)
  {
//--- �����, ���� ������ � ������� ������������ ���� ��� � ������� ����������� ����
   if(CElement::MouseFocus() || m_prev_node.MouseFocus())
      return;
//--- ���� �� ������ ��� ������� ���� ���������, �� ...
//    ... ����� ���������, ���� �� �������� ����������� ����, ������� ���� ������������ ����� �����
//--- ��� ����� �������� � ����� �� ������ ����� ������������ ���� ...
//    ... ��� ����������� ������� ������, ������� �������� � ���� ����������� ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ����� ����� �������, �� ����� ���������, ������� �� ��� ����������� ����.
      //    ���� ��� �������, �� �� ����� �������� ������ �� �������� ���� ����������� ���� �� ����� ��������, ��� ���...
      //    ... ��������, ��� ������ ��������� � ������� ���������� � ����� ��������� ���.
      if(m_items[i].TypeMenuItem()==MI_HAS_CONTEXT_MENU)
         if(m_items[i].ContextMenuState())
            return;
     }
//--- ������������ �����
   m_wnd.IsLocked(false);
//--- ������� ������ �� ������� ���� ����������� ����
   ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
  }
//+------------------------------------------------------------------+
//| �������� ������� �� �������� ���� ����������� ����,              |
//| ������� ���� ������� ����� �����                                 |
//+------------------------------------------------------------------+
void CContextMenu::CheckHideBackContextMenus(void)
  {
//--- �������� �� ���� ������� ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ����� �������� ����������� ���� � ��� ��������
      if(m_items[i].TypeMenuItem()==MI_HAS_CONTEXT_MENU && m_items[i].ContextMenuState())
        {
         //--- ���� ����� � ����������� ����, �� �� � ���� ������
         if(CElement::MouseFocus() && !m_items[i].MouseFocus())
           {
            //--- ��������� ������ �� ������� ���� ����������� ����, ������� ���� ������� ����� �����
            ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CContextMenu::ChangeObjectsColor(void)
  {
//--- �����, ���� ����������� ���� ���������
   if(!m_context_menu_state)
      return;
//--- �������� �� ���� ������� ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- �������� ���� ������ ����
      m_items[i].ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ����� ����                                  |
//+------------------------------------------------------------------+
bool CContextMenu::OnClickMenuItem(const string clicked_object)
  {
//--- ������, ���� ��� ����������� ���� ����� ���������� ���� � ��� �������
   if(!m_free_context_menu && m_context_menu_state)
      return(true);
//--- ������, ���� ������� ���� �� �� ������ ����
   if(::StringFind(clicked_object,CElement::ProgramName()+"_menuitem_",0)<0)
      return(false);
//--- ������� ������������� � ������ �� ����� �������
   int id    =IdFromObjectName(clicked_object);
   int index =IndexFromObjectName(clicked_object);
//--- ���� ����������� ���� ����� ���������� ����
   if(!m_free_context_menu)
     {
      //--- ������, ���� ������ �� �� ������, � �������� ��� ����������� ���� ���������
      if(id!=m_prev_node.Id() || index!=m_prev_node.Index())
         return(false);
      //--- �������� ����������� ����
      Show();
     }
//--- ���� ��� ��������� ����������� ����
   else
     {
      //--- ����� � ����� ����� ����, �� ������� ������
      int total=ItemsTotal();
      for(int i=0; i<total; i++)
        {
         if(m_items[i].Object(0).Name()!=clicked_object)
            continue;
         //--- �������� ��������� �� ����
         ::EventChartCustom(m_chart_id,ON_CLICK_FREEMENU_ITEM,CElement::Id(),i,DescriptionByIndex(i));
         break;
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ���� ��������� �� ������ ���� ��� ���������                     |
//+------------------------------------------------------------------+
void CContextMenu::ReceiveMessageFromMenuItem(const int id_item,const int index_item,const string message_item)
  {
//--- ���� ���� ������� ��������� ���� ��������� � id �������� ���������
   if(::StringFind(message_item,CElement::ProgramName(),0)>-1 && id_item==CElement::Id())
     {
      //--- ���� ������� ���� �� �����-������
      if(::StringFind(message_item,"radioitem",0)>-1)
        {
         //--- ������� id �����-������ �� ����������� ���������
         int radio_id=RadioIdFromMessage(message_item);
         //--- ������� ������ �����-������ �� ������ �������
         int radio_index=RadioIndexByItemIndex(index_item);
         //--- ����������� �����-�����
         SelectedRadioItem(radio_index,radio_id);
        }
      //--- �������� ��������� �� ����
      ::EventChartCustom(m_chart_id,ON_CLICK_CONTEXTMENU_ITEM,id_item,index_item,DescriptionByIndex(index_item));
     }
//--- ������� ������������ ����
   Hide();
//--- ������������ �����
   m_wnd.IsLocked(false);
//--- ������� ������ �� ������� ���� ����������� ����
   ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CContextMenu::IdFromObjectName(const string object_name)
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
int CContextMenu::IndexFromObjectName(const string object_name)
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
//| ��������� ������������� �� ��������� ��� �����-������            |
//+------------------------------------------------------------------+
int CContextMenu::RadioIdFromMessage(const string message)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- ������� ��� �����������
   u_sep=::StringGetCharacter("_",0);
//--- �������� ������
   ::StringSplit(message,u_sep,result);
   array_size=::ArraySize(result);
//--- ���� ��������� ��������� ���������� �� ���������
   if(array_size!=3)
     {
      ::Print(__FUNCTION__," > ������������ ��������� � ��������� ��� �����-������! message: ",message);
      return(WRONG_VALUE);
     }
//--- �������������� ������ �� ������� �������
   if(array_size<3)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- ������� id �����-������
   return((int)result[2]);
  }
//+------------------------------------------------------------------+
//| ���������� ������ �����-������ �� ������ �������                 |
//+------------------------------------------------------------------+
int CContextMenu::RadioIndexByItemIndex(const int index)
  {
   int radio_index=0;
//--- �������� ID �����-������ �� ������ �������
   int radio_id=RadioItemIdByIndex(index);
//--- ������� ������� �� ������ ������
   int count_radio_id=0;
//--- �������� � ����� �� ������
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ��� �� �����-�����, ������� � ����������
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- ���� �������������� ���������
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- ���� ������� �������, �� 
         //    �������� ������� �������� �������� � �������� ����
         if(m_items[i].Index()==index)
           {
            radio_index=count_radio_id;
            break;
           }
         //--- ���������� ��������
         count_radio_id++;
        }
     }
//--- ������� ������
   return(radio_index);
  }
//+------------------------------------------------------------------+
