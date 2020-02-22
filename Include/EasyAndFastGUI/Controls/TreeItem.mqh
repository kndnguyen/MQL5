//+------------------------------------------------------------------+
//|                                                     TreeItem.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������ ������������ ������                    |
//+------------------------------------------------------------------+
class CTreeItem : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������ ������������ ������
   CRectLabel        m_area;
   CBmpLabel         m_arrow;
   CBmpLabel         m_icon;
   CEdit             m_label;
   //--- ����� ���� � ������ ����������
   color             m_item_back_color;
   color             m_item_back_color_hover;
   color             m_item_back_color_selected;
   //--- ������ ��� ������� (�������� ������� ������)
   int               m_arrow_x_offset;
   //--- �������� ��� ������� ������
   string            m_item_arrow_file_on;
   string            m_item_arrow_file_off;
   string            m_item_arrow_selected_file_on;
   string            m_item_arrow_selected_file_off;
   //--- ����� ������
   string            m_icon_file;
   //--- ������� ��������� �����
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ����� ������ � ������ ���������� ������
   color             m_item_text_color;
   color             m_item_text_color_hover;
   color             m_item_text_color_selected;
   //--- ���������� �� ������� ����� ������ ����
   int               m_area_zorder;
   int               m_arrow_zorder;
   int               m_zorder;
   //--- ��� ������
   ENUM_TYPE_TREE_ITEM m_item_type;
   //--- ������ ������ � ����� ������
   int               m_list_index;
   //--- ������� ����
   int               m_node_level;
   //--- ������������ ����� ������
   string            m_item_text;
   //--- ��������� ������ ������ (������/������)
   bool              m_item_state;
   //---
public:
                     CTreeItem(void);
                    ~CTreeItem(void);
   //--- ������ ��� �������� ������ ������������ ������
   bool              CreateTreeItem(const long chart_id,const int subwin,const int x,const int y,const ENUM_TYPE_TREE_ITEM type,
                                    const int list_index,const int node_level,const string item_text,const bool item_state);
   //---
private:
   bool              CreateArea(void);
   bool              CreateArrow(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ����� ���� ������
   void              WindowPointer(CWindow &object)                   { m_wnd=::GetPointer(object);               }
   void              ItemBackColor(const color clr)                   { m_item_back_color=clr;                    }
   void              ItemBackColorHover(const color clr)              { m_item_back_color_hover=clr;              }
   void              ItemBackColorSelected(const color clr)           { m_item_back_color_selected=clr;           }
   //--- (1) ��������� ������ ��� ������, (2) ��������� �������� ��� ������� ������
   void              IconFile(const string file_path)                 { m_icon_file=file_path;                    }
   void              ItemArrowFileOn(const string file_path)          { m_item_arrow_file_on=file_path;           }
   void              ItemArrowFileOff(const string file_path)         { m_item_arrow_file_off=file_path;          }
   void              ItemArrowSelectedFileOn(const string file_path)  { m_item_arrow_selected_file_on=file_path;  }
   void              ItemArrowSelectedFileOff(const string file_path) { m_item_arrow_selected_file_off=file_path; }
   //--- (1) ���������� ����� ������, (2) ��������� �������� ��� ��������� �����
   string            LabelText(void)                            const { return(m_label.Description());            }
   void              LabelXGap(const int x_gap)                       { m_label_x_gap=x_gap;                      }
   void              LabelYGap(const int y_gap)                       { m_label_y_gap=y_gap;                      }
   //--- ����� ������ � ������ ����������
   void              ItemTextColor(const color clr)                   { m_item_text_color=clr;                    }
   void              ItemTextColorHover(const color clr)              { m_item_text_color_hover=clr;              }
   void              ItemTextColorSelected(const color clr)           { m_item_text_color_selected=clr;           }
   //--- ���������� ��������� � ������
   void              UpdateX(const int x);
   void              UpdateY(const int y);
   void              UpdateWidth(const int width);
   //--- ��������� ����� ������ ������������ ���������� ���������
   void              HighlightItemState(const bool state);
   //--- ��������� ����� �� ��������� ������� ����
   void              ChangeObjectsColor(void);
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- ������
   virtual void      OnEventTimer(void) {}
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
CTreeItem::CTreeItem(void) : m_node_level(0),
                             m_arrow_x_offset(5),
                             m_item_type(TI_SIMPLE),
                             m_item_state(false),
                             m_label_x_gap(16),
                             m_label_y_gap(2),
                             m_item_back_color(clrWhite),
                             m_item_back_color_hover(C'240,240,240'),
                             m_item_back_color_selected(C'51,153,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_hover(clrBlack),
                             m_item_text_color_selected(clrWhite),
                             m_icon_file(""),
                             m_item_arrow_file_on(""),
                             m_item_arrow_file_off(""),
                             m_item_arrow_selected_file_on(""),
                             m_item_arrow_selected_file_off("")
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_area_zorder  =1;
   m_arrow_zorder =2;
   m_zorder       =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTreeItem::~CTreeItem(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CTreeItem::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- ����������
      int x=(int)lparam;
      int y=(int)dparam;
      //--- �������� ������ ��� ���������
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������ ����� ������������ ������                                |
//+------------------------------------------------------------------+
bool CTreeItem::CreateTreeItem(const long chart_id,const int subwin,const int x,const int y,const ENUM_TYPE_TREE_ITEM type,
                               const int list_index,const int node_level,const string item_text,const bool item_state)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ������ ������ ����� �������� "
              "��������� �� �����: CTreeItem::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id             =m_wnd.LastId()+1;
   m_chart_id       =chart_id;
   m_subwin         =subwin;
   m_x              =x;
   m_y              =y;
   m_item_type      =type;
   m_list_index     =list_index;
   m_node_level     =node_level;
   m_item_text      =item_text;
   m_item_state     =item_state;
   m_arrow_x_offset =(m_node_level>0)? (12*m_node_level)+5 : 5;
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ������ ����
   if(!CreateArea())
      return(false);
   if(!CreateArrow())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateLabel())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ������ ������������ ������                       |
//+------------------------------------------------------------------+
bool CTreeItem::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_area_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- ��������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� ��������
   m_area.BackColor(m_item_back_color);
   m_area.Color(m_item_back_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- �������
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
   CElement::XSize(CElement::XSize());
   CElement::YSize(CElement::YSize());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� (������� ����������� ������)                     |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_white.bmp"
//---
bool CTreeItem::CreateArrow(void)
  {
//--- ���������� ����������
   int x =CElement::X()+m_arrow_x_offset;
   int y =CElement::Y()+2;
//--- �������� ���������� ��� ������� ��������� ��������� � ������� �������� �������� ��������
   m_arrow.X(x);
   m_arrow.Y(y);
//--- ������, ���� ����� �� ����� ����������� ������
   if(m_item_type!=TI_HAS_ITEMS)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_arrow_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- ���������� �������� �� ���������
   if(m_item_arrow_file_on=="")
      m_item_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_black.bmp";
   if(m_item_arrow_file_off=="")
      m_item_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp";
   if(m_item_arrow_selected_file_on=="")
      m_item_arrow_selected_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_white.bmp";
   if(m_item_arrow_selected_file_off=="")
      m_item_arrow_selected_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp";
//--- ��������� ������
   if(!m_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_arrow.BmpFileOn("::"+m_item_arrow_file_on);
   m_arrow.BmpFileOff("::"+m_item_arrow_file_off);
   m_arrow.State(m_item_state);
   m_arrow.Corner(m_corner);
   m_arrow.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_arrow.Selectable(false);
   m_arrow.Z_Order(m_arrow_zorder);
   m_arrow.Tooltip("\n");
//--- ������� �� ������� �����
   m_arrow.XGap(x-m_wnd.X());
   m_arrow.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_arrow);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ������                                          |
//+------------------------------------------------------------------+
bool CTreeItem::CreateIcon(void)
  {
//--- ���������� ����������
   int x =m_arrow.X()+17;
   int y =CElement::Y()+2;
//--- �������� ����������
   m_icon.X(x);
   m_icon.Y(y);
//--- �����, ���� ����� �� �����
   if(m_icon_file=="")
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_icon_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- ��������� ������
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_icon.BmpFileOn("::"+m_icon_file);
   m_icon.BmpFileOff("::"+m_icon_file);
   m_icon.State(true);
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
//| ������ ��������� ����� ������                                   |
//+------------------------------------------------------------------+
bool CTreeItem::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_lable_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- ���������� ���������� � ������
   int x=(m_icon_file=="")? m_icon.X() : m_icon.X()+m_label_x_gap;
   int y=CElement::Y()+m_label_y_gap;
   int w=CElement::X2()-x-1;
//--- ��������� ������
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y,w,15))
      return(false);
//--- ��������� �������
   m_label.Description(m_item_text);
   m_label.TextAlign(ALIGN_LEFT);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(m_item_text_color);
   m_label.BackColor(m_item_back_color);
   m_label.BorderColor(m_item_back_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.ReadOnly(true);
   m_label.Tooltip("\n");
//--- ����������
   m_label.X(x);
   m_label.Y(y);
//--- ������� �� ������� �����
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� ���������� X                                          |
//+------------------------------------------------------------------+
void CTreeItem::UpdateX(const int x)
  {
//--- ���������� ����� ��������� � ������� �� ������� �����
   CElement::X(x);
   CElement::XGap(CElement::X()-m_wnd.X());
//--- ���������� � ������ ����
   m_area.X_Distance(CElement::X());
   m_area.XGap(CElement::X()-m_wnd.X());
//--- ���������� � ������ �������
   int l_x=CElement::X()+m_arrow_x_offset;
   m_arrow.X(l_x);
   m_arrow.X_Distance(l_x);
   m_arrow.XGap(l_x-m_wnd.X());
//--- ���������� � ������ ��������
   l_x=m_arrow.X()+17;
   m_icon.X(l_x);
   m_icon.X_Distance(l_x);
   m_icon.XGap(l_x-m_wnd.X());
//--- ���������� � ������ ��������� �����
   l_x=(m_icon_file=="")? m_icon.X() : m_icon.X()+m_label_x_gap;
   m_label.X(l_x);
   m_label.X_Distance(l_x);
   m_label.XGap(l_x-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| ���������� ���������� Y                                          |
//+------------------------------------------------------------------+
void CTreeItem::UpdateY(const int y)
  {
//--- ���������� ����� ��������� � ������� �� ������� �����
   CElement::Y(y);
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- ���������� � ������ ����
   m_area.Y_Distance(CElement::Y());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- ���������� � ������ �������
   int l_y=CElement::Y()+2;
   m_arrow.Y(l_y);
   m_arrow.Y_Distance(l_y);
   m_arrow.YGap(l_y-m_wnd.Y());
//--- ���������� � ������ ��������
   l_y=CElement::Y()+2;
   m_icon.Y(l_y);
   m_icon.Y_Distance(l_y);
   m_icon.YGap(l_y-m_wnd.Y());
//--- ���������� � ������ ��������� �����
   l_y=CElement::Y()+m_label_y_gap;
   m_label.Y(l_y);
   m_label.Y_Distance(l_y);
   m_label.YGap(l_y-m_wnd.Y());
  }
//+------------------------------------------------------------------+
//| ���������� ������                                                |
//+------------------------------------------------------------------+
void CTreeItem::UpdateWidth(const int width)
  {
//--- ������ ����
   CElement::XSize(width);
   m_area.XSize(width);
   m_area.X_Size(width);
//--- ������ ��������� �����
   int w=CElement::X2()-m_label.X()-1;
   m_label.XSize(w);
   m_label.X_Size(w);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������ ������������ ���������� ���������         |
//+------------------------------------------------------------------+
void CTreeItem::HighlightItemState(const bool state)
  {
   m_area.BackColor((state)? m_item_back_color_selected : m_item_back_color);
   m_label.BackColor((state)? m_item_back_color_selected : m_item_back_color);
   m_label.BorderColor((state)? m_item_back_color_selected : m_item_back_color);
   m_label.Color((state)? m_item_text_color_selected : m_item_text_color);
   m_arrow.BmpFileOn((state)? "::"+m_item_arrow_selected_file_on : "::"+m_item_arrow_file_on);
   m_arrow.BmpFileOff((state)? "::"+m_item_arrow_selected_file_off : "::"+m_item_arrow_file_off);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CTreeItem::ChangeObjectsColor(void)
  {
   if(CElement::MouseFocus())
     {
      m_area.BackColor(m_item_back_color_hover);
      m_label.BackColor(m_item_back_color_hover);
      m_label.BorderColor(m_item_back_color_hover);
      m_label.Color(m_item_text_color_hover);
     }
   else
     {
      m_area.BackColor(m_item_back_color);
      m_label.BackColor(m_item_back_color);
      m_label.BorderColor(m_item_back_color);
      m_label.Color(m_item_text_color);
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CTreeItem::Moving(const int x,const int y)
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
   m_arrow.X(x+m_arrow.XGap());
   m_arrow.Y(y+m_arrow.YGap());
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_arrow.X_Distance(m_arrow.X());
   m_arrow.Y_Distance(m_arrow.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CTreeItem::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_arrow.Timeframes(OBJ_ALL_PERIODS);
   m_icon.Timeframes(OBJ_ALL_PERIODS);
   m_label.Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CTreeItem::Hide(void)
  {
//--- �����, ���� ������� ��� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_arrow.Timeframes(OBJ_NO_PERIODS);
   m_icon.Timeframes(OBJ_NO_PERIODS);
   m_label.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CTreeItem::Reset(void)
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
void CTreeItem::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   m_arrow.Delete();
   m_icon.Delete();
   m_label.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CTreeItem::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_arrow.Z_Order(m_arrow_zorder);
   m_icon.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CTreeItem::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_arrow.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ����� �����                                                      |
//+------------------------------------------------------------------+
void CTreeItem::ResetColors(void)
  {
   m_area.BackColor(m_item_back_color);
   m_label.BackColor(m_item_back_color);
   m_label.BorderColor(m_item_back_color);
//--- ����� ������
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
