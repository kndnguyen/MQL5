//+------------------------------------------------------------------+
//|                                                     MenuItem.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� �������� ������ ����                                       |
//+------------------------------------------------------------------+
class CMenuItem : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������ ����
   CRectLabel        m_area;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CBmpLabel         m_arrow;
   //--- ��������� �� ���������� ����
   CMenuItem        *m_prev_node;
   //--- ��� ������ ����
   ENUM_TYPE_MENU_ITEM m_type_menu_item;
   //--- �������� ����
   int               m_area_zorder;
   color             m_area_border_color;
   color             m_area_color;
   color             m_area_color_hover;
   color             m_area_color_hover_off;
   //--- �������� ������
   string            m_icon_file_on;
   string            m_icon_file_off;
   //--- �������� ��������� �����
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   //--- �������� �������� ������������ ����
   bool              m_show_right_arrow;
   string            m_right_arrow_file_on;
   string            m_right_arrow_file_off;
   //--- ����� ��������� �� �������
   int               m_zorder;
   //--- ��������/������������
   bool              m_item_state;
   //--- ��������� ��������
   bool              m_checkbox_state;
   //--- ��������� �����-������ � � �������������
   bool              m_radiobutton_state;
   int               m_radiobutton_id;
   //--- ��������� ������������ ����
   bool              m_context_menu_state;
   //---
public:
                     CMenuItem(void);
                    ~CMenuItem(void);
   //--- ������ ��� �������� ������ ����
   bool              CreateMenuItem(const long chart_id,const int subwin,const int index_number,const string label_text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   bool              CreateArrow(void);
   //--- ������� �� ������ ����
   bool              OnClickMenuItem(const string clicked_object);
   //---
public:
   //--- (1) ��������� ��������� �����
   //    (2) ��������� � (3) ���������� ��������� ����������� ����
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);            }
   CMenuItem        *PrevNodePointer(void)                    const { return(m_prev_node);                   }
   void              PrevNodePointer(CMenuItem &object)             { m_prev_node=::GetPointer(object);      }
   //--- (1) ��������� � ��������� ����, (2) ����� �������
   void              TypeMenuItem(const ENUM_TYPE_MENU_ITEM type)   { m_type_menu_item=type;                 }
   ENUM_TYPE_MENU_ITEM TypeMenuItem(void)                     const { return(m_type_menu_item);              }
   //--- ������ ����
   void              AreaBackColor(const color clr)                 { m_area_color=clr;                      }
   void              AreaBackColorHover(const color clr)            { m_area_color_hover=clr;                }
   void              AreaBackColorHoverOff(const color clr)         { m_area_color_hover_off=clr;            }
   void              AreaBorderColor(const color clr)               { m_area_border_color=clr;               }
   //--- ������ ������
   void              IconFileOn(const string file_path)             { m_icon_file_on=file_path;              }
   void              IconFileOff(const string file_path)            { m_icon_file_off=file_path;             }
   //--- ������ ��������� �����
   string            LabelText(void)                          const { return(m_label.Description());         }
   void              LabelXGap(const int x_gap)                     { m_label_x_gap=x_gap;                   }
   void              LabelYGap(const int y_gap)                     { m_label_y_gap=y_gap;                   }
   void              LabelColor(const color clr)                    { m_label_color=clr;                     }
   void              LabelColorOff(const color clr)                 { m_label_color_off=clr;                 }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;               }
   //--- ������ �������� ������� ������������ ����
   void              ShowRightArrow(const bool flag)                { m_show_right_arrow=flag;               }
   void              RightArrowFileOn(const string file_path)       { m_right_arrow_file_on=file_path;       }
   void              RightArrowFileOff(const string file_path)      { m_right_arrow_file_off=file_path;      }
   //--- ����� (1) ��������� ������ � (2) ������-��������
   void              ItemState(const bool state);
   bool              ItemState(void)                          const { return(m_item_state);                  }
   void              CheckBoxState(const bool flag)                 { m_checkbox_state=flag;                 }
   bool              CheckBoxState(void)                      const { return(m_checkbox_state);              }
   //--- ������������� �����-������
   void              RadioButtonID(const int id)                    { m_radiobutton_id=id;                   }
   int               RadioButtonID(void)                      const { return(m_radiobutton_id);              }
   //--- ��������� �����-������
   void              RadioButtonState(const bool flag)              { m_radiobutton_state=flag;              }
   bool              RadioButtonState(void)                   const { return(m_radiobutton_state);           }
   //--- ��������� ������������ ���� ������������ �� ���� �������
   bool              ContextMenuState(void)                   const { return(m_context_menu_state);          }
   void              ContextMenuState(const bool flag)              { m_context_menu_state=flag;             }

   //--- ��������� ����� ������ ������������ ���������� ���������
   void              HighlightItemState(const bool state);
   //--- ��������� ����� �������� ��������
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
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMenuItem::CMenuItem(void) : m_type_menu_item(MI_SIMPLE),
                             m_context_menu_state(false),
                             m_item_state(true),
                             m_checkbox_state(true),
                             m_radiobutton_id(0),
                             m_radiobutton_state(false),
                             m_icon_file_on(""),
                             m_icon_file_off(""),
                             m_show_right_arrow(true),
                             m_right_arrow_file_on(""),
                             m_right_arrow_file_off(""),
                             m_area_color(C'15,15,15'),
                             m_area_color_hover(C'51,153,255'),
                             m_area_color_hover_off(C'70,80,90'),
                             m_area_border_color(C'15,15,15'),
                             m_label_x_gap(32),
                             m_label_y_gap(5),
                             m_label_color(clrWhite),
                             m_label_color_off(clrGray),
                             m_label_color_hover(C'85,170,255')
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ������� ������������������ �����������
   m_area_zorder =2;
   m_zorder      =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMenuItem::~CMenuItem(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CMenuItem::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������  
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- ��������� �����
      int x=(int)lparam;
      int y=(int)dparam;
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CMenuItem::OnEventTimer(void)
  {
//--- ���� ���� ��������
   if(!m_wnd.IsLocked())
     {
      //--- ���� ������ ������������ ������������ ����
      if(!m_context_menu_state)
         //--- ��������� ����� �������� �����
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� "����� ����"                                     |
//+------------------------------------------------------------------+
bool CMenuItem::CreateMenuItem(const long chart_id,const int subwin,const int index_number,const string label_text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ���� ������ ����� �������� "
              "��������� �� �����: CMenuItem::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ���� ��������� �� ���������� ���� ���, ��
//    �������������� ����������� ����� ����, �� ���� �����, ������� �� �������� ����� ������������ ����
   if(::CheckPointer(m_prev_node)==POINTER_INVALID)
     {
      //--- �����, ���� ������������� ��� �� �������������
      if(m_type_menu_item!=MI_SIMPLE && m_type_menu_item!=MI_HAS_CONTEXT_MENU)
        {
         ::Print(__FUNCTION__," > ��� ������������ ������ ���� ����� ���� ������ MI_SIMPLE ��� MI_HAS_CONTEXT_MENU, ",
                 "�� ����, � �������� ������������ ����.\n",
                 __FUNCTION__," > ���������� ��� ������ ���� ����� � ������� ������ CMenuItem::TypeMenuItem()");
         return(false);
        }
     }
//--- ������������� ����������
   m_id           =m_wnd.LastId()+1;
   m_index        =index_number;
   m_chart_id     =chart_id;
   m_subwin       =subwin;
   m_label_text   =label_text;
   m_x            =x;
   m_y            =y;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ������ ����
   if(!CreateArea())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateArrow())
      return(false);
//--- ���� ����� �������, �� ������ ������� ����� ��������
   if(m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ������ ����                                      |
//+------------------------------------------------------------------+
bool CMenuItem::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_menuitem_area_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ��������� ��� ������ ����
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
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ������                                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_white.bmp"
//---
bool CMenuItem::CreateIcon(void)
  {
//--- ���� ��� ������� ����� ��� ����� ���������� � ���� ����������� ����
   if(m_type_menu_item==MI_SIMPLE || m_type_menu_item==MI_HAS_CONTEXT_MENU)
     {
      //--- ���� ����� �� ����� (�������� �� ����������), ������
      if(m_icon_file_on=="" || m_icon_file_off=="")
         return(true);
     }
//--- ���� ��� �������
   else if(m_type_menu_item==MI_CHECKBOX)
     {
      //--- ���� �������� �� ����������, ��������� �� ���������
      if(m_icon_file_on=="")
         m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_white.bmp";
      if(m_icon_file_off=="")
         m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_gray.bmp";
     }
//--- ���� ��� �����-�����     
   else if(m_type_menu_item==MI_RADIOBUTTON)
     {
      //--- ���� �������� �� ����������, ��������� �� ���������
      if(m_icon_file_on=="")
         m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_white.bmp";
      if(m_icon_file_off=="")
         m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_gray.bmp";
     }
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_menuitem_icon_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ���������� �������
   int x =m_x+7;
   int y =m_y+4;
//--- ��������� �����
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_icon.BmpFileOn("::"+m_icon_file_on);
   m_icon.BmpFileOff("::"+m_icon_file_off);
   m_icon.State(m_item_state);
   m_icon.Corner(m_corner);
   m_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon.Selectable(false);
   m_icon.Z_Order(m_zorder);
   m_icon.Tooltip("\n");
//--- ������� �� ������� �����
   m_icon.XGap(x-m_wnd.X());
   m_icon.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ����� ������ ����                              |
//+------------------------------------------------------------------+
bool CMenuItem::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_menuitem_lable_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ���������� �������
   int x =m_x+m_label_x_gap;
   int y =m_y+m_label_y_gap;
//--- ���� ������ ������� �� �������� ��������� (��������/������������)
   color label_color=(m_item_state)? m_label_color : m_label_color_off;
//--- ��������� ��������� �����
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_label.Description(m_label_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.Tooltip("\n");
//--- ������� �� ������� �����
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� (������� ����������� ������������ ����)          |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp"
//---
bool CMenuItem::CreateArrow(void)
  {
//--- ������, ���� ����� �� ����� ����������� ���� ��� ������� �� �����
   if(m_type_menu_item!=MI_HAS_CONTEXT_MENU || !m_show_right_arrow)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_menuitem_arrow_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ���������� �������
   int x =m_x+CElement::XSize()-16;
   int y =m_y+4;
//--- ���� �� ������� �������� ��� �������, ������ ��������� �� ���������
   if(m_right_arrow_file_on=="")
      m_right_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp";
   if(m_right_arrow_file_off=="")
      m_right_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp.bmp";
//--- ��������� �������
   if(!m_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_arrow.BmpFileOn("::"+m_right_arrow_file_on);
   m_arrow.BmpFileOff("::"+m_right_arrow_file_off);
   m_arrow.State(false);
   m_arrow.Corner(m_corner);
   m_arrow.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_arrow.Selectable(false);
   m_arrow.Z_Order(m_zorder);
   m_arrow.Tooltip("\n");
//--- ������� �� ������� �����
   m_arrow.XGap(x-m_wnd.X());
   m_arrow.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_arrow);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CMenuItem::ChangeObjectsColor(void)
  {
//--- �����, ���� � ����� ������ ���� ����������� ���� � ��� ��������
   if(m_type_menu_item==MI_HAS_CONTEXT_MENU && m_context_menu_state)
      return;
//--- ���� ���� ��� ������� ������� � ������� ���������� � ���� ����������� ����
   if(m_type_menu_item==MI_HAS_CONTEXT_MENU || m_type_menu_item==MI_SIMPLE)
     {
      //--- ���� ���� �����
      if(CElement::MouseFocus())
        {
         //Print(__FUNCSIG__," >>> index: ",m_index,"; text: ",m_label_text);
         m_icon.State(m_item_state);
         m_area.BackColor((m_item_state)? m_area_color_hover : m_area_color_hover_off);
         m_label.Color((m_item_state)? m_label_color_hover : m_label_color_off);
         if(m_item_state)
            m_arrow.State(true);
        }
      //--- ���� ��� ������
      else
        {
         m_arrow.State(false);
         m_area.BackColor(m_area_color);
         m_label.Color((m_item_state)? m_label_color : m_label_color_off);
        }
     }
//--- ���� ��� ��� �������-��������� � �����-�������
   else if(m_type_menu_item==MI_CHECKBOX || m_type_menu_item==MI_RADIOBUTTON)
     {
      m_icon.State(CElement::MouseFocus());
      m_area.BackColor((CElement::MouseFocus())? m_area_color_hover : m_area_color);
      m_label.Color((CElement::MouseFocus())? m_label_color_hover : m_label_color);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������ ����                                  |
//+------------------------------------------------------------------+
void CMenuItem::ItemState(const bool state)
  {
   m_item_state=state;
   m_icon.State(state);
   m_label.Color((state)? m_label_color : m_label_color_off);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������ ������������ ���������� ���������         |
//+------------------------------------------------------------------+
void CMenuItem::HighlightItemState(const bool state)
  {
   m_area.BackColor((state)? m_area_color_hover : m_area_color);
   m_label.Color((state)? m_label_color_hover : m_label_color);
   m_arrow.State(state);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CMenuItem::Moving(const int x,const int y)
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
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_arrow.X(x+m_arrow.XGap());
   m_arrow.Y(y+m_arrow.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_arrow.X_Distance(m_arrow.X());
   m_arrow.Y_Distance(m_arrow.Y());
  }
//+------------------------------------------------------------------+
//| ������ ������� ����� ����                                        |
//+------------------------------------------------------------------+
void CMenuItem::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ��������� ��������� ����������� ������
   HighlightItemState(false);
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- ���� ��� �������, �� � ������ ��� ���������
   if(m_type_menu_item==MI_CHECKBOX)
      m_icon.Timeframes((m_checkbox_state)? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
//--- ���� ��� �����-�����, �� � ������ ��� ���������
   else if(m_type_menu_item==MI_RADIOBUTTON)
      m_icon.Timeframes((m_radiobutton_state)? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
//--- ��������� ����������
   CElement::IsVisible(true);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CMenuItem::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ��������� ����������
   m_context_menu_state=false;
   CElement::IsVisible(false);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CMenuItem::Reset(void)
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
void CMenuItem::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_arrow.Delete();
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
void CMenuItem::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_icon.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_arrow.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CMenuItem::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
   m_arrow.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ����� ����� ������                                               |
//+------------------------------------------------------------------+
void CMenuItem::ResetColors(void)
  {
   m_area.BackColor(m_area_color);
   m_label.Color(m_label_color);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ ����                                 |
//+------------------------------------------------------------------+
bool CMenuItem::OnClickMenuItem(const string clicked_object)
  {
//--- �������� �� ����� �������
   if(m_area.Name()!=clicked_object)
      return(false);
//--- ������, ���� ����� �������������
   if(!m_item_state)
      return(false);
//--- ���� ���� ����� �������� ����������� ����
   if(m_type_menu_item==MI_HAS_CONTEXT_MENU)
     {
      //--- ���� ���������� ���� ����� ������ �� ������������
      if(!m_context_menu_state)
        {
         //--- �������� ������ ����������� ������������ ����
         m_context_menu_state=true;
        }
      else
        {
         //--- �������� ������ ������������ ������������ ����
         m_context_menu_state=false;
         //--- �������� ������ ��� �������� ����������� ����, ������� ������ ����� ������
         ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
        }
      return(true);
     }
//--- ���� ���� ����� �� �������� ����������� ����, �� �������� ������ ������������ ����
   else
     {
      //--- ������� ��������� � ������ ���������
      string message=CElement::ProgramName();
      //--- ���� ��� �������, ������� ��� ���������
      if(m_type_menu_item==MI_CHECKBOX)
        {
         m_checkbox_state=(m_checkbox_state)? false : true;
         m_icon.Timeframes((m_checkbox_state)? OBJ_NO_PERIODS : OBJ_ALL_PERIODS);
         //--- ������� � ���������, ��� ��� �������
         message+="_checkbox";
        }
      //--- ���� ��� �����-�����, ������� ��� ���������
      else if(m_type_menu_item==MI_RADIOBUTTON)
        {
         m_radiobutton_state=(m_radiobutton_state)? false : true;
         m_icon.Timeframes((m_radiobutton_state)? OBJ_NO_PERIODS : OBJ_ALL_PERIODS);
         //--- ������� � ���������, ��� ��� �����-�����
         message+="_radioitem_"+(string)m_radiobutton_id;
        }
      //--- �������� ��������� �� ����
      ::EventChartCustom(m_chart_id,ON_CLICK_MENU_ITEM,CElement::Id(),CElement::Index(),message);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
