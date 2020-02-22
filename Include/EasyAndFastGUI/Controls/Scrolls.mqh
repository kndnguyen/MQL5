//+------------------------------------------------------------------+
//|                                                      Scrolls.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//--- ������ ������� � ����� ��� �������� �������� (Alt+G)
class CScroll;
class CScrollV;
class CScrollH;
//+------------------------------------------------------------------+
//| ������� ����� ��� �������� ������ ���������                      |
//+------------------------------------------------------------------+
class CScroll : public CElement
  {
protected:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������ ���������
   CRectLabel        m_area;
   CRectLabel        m_bg;
   CBmpLabel         m_inc;
   CBmpLabel         m_dec;
   CRectLabel        m_thumb;
   //--- �������� ����� ������� ������ ���������
   int               m_area_width;
   int               m_area_length;
   color             m_area_color;
   color             m_area_border_color;
   //--- �������� ���� ��� ���������
   int               m_bg_length;
   color             m_bg_border_color;
   //--- �������� ��� ������
   string            m_inc_file_on;
   string            m_inc_file_off;
   string            m_dec_file_on;
   string            m_dec_file_off;
   //--- ����� �������� � ������ ����������
   color             m_thumb_color;
   color             m_thumb_color_hover;
   color             m_thumb_color_pressed;
   color             m_thumb_border_color;
   color             m_thumb_border_color_hover;
   color             m_thumb_border_color_pressed;
   //--- (1) ����� ���������� ������� � (2) �������
   int               m_items_total;
   int               m_visible_items_total;
   //--- (1) ������ ��������, (2) ����� �������� � (3) ��� ����������� �����
   int               m_thumb_width;
   int               m_thumb_length;
   int               m_thumb_min_length;
   //--- (1) ������ ���� �������� � (2) ���-�� �����
   double            m_thumb_step_size;
   double            m_thumb_steps_total;
   //--- ���������� �� ������� ����� ������� ����
   int               m_area_zorder;
   int               m_bg_zorder;
   int               m_arrow_zorder;
   int               m_thumb_zorder;
   //--- ���������� ��������� � ������������ ��������
   bool              m_scroll_state;
   int               m_thumb_size_fixing;
   int               m_thumb_point_fixing;
   //--- ������� ������� ��������
   int               m_current_pos;
   //--- ��� ����������� ������� ������� ����� ������ ����
   ENUM_THUMB_MOUSE_STATE m_clamping_area_mouse;
   //---
public:
                     CScroll(void);
                    ~CScroll(void);
   //--- ������ ��� �������� ������ ���������
   bool              CreateScroll(const long chart_id,const int subwin,const int x,const int y,const int items_total,const int visible_items_total);
   //---
private:
   bool              CreateArea(void);
   bool              CreateBg(void);
   bool              CreateInc(void);
   bool              CreateDec(void);
   bool              CreateThumb(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ������ ��������
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);       }
   void              ScrollWidth(const int width)             { m_area_width=width;               }
   int               ScrollWidth(void)                  const { return(m_area_width);             }
   //--- (1) ���� ����, (2) ����� ���� � (3) ���������� ����� ����
   void              AreaColor(const color clr)               { m_area_color=clr;                 }
   void              AreaBorderColor(const color clr)         { m_area_border_color=clr;          }
   void              BgBorderColor(const color clr)           { m_bg_border_color=clr;            }
   //--- ��������� �������� ��� ������
   void              IncFileOn(const string file_path)        { m_inc_file_on=file_path;          }
   void              IncFileOff(const string file_path)       { m_inc_file_off=file_path;         }
   void              DecFileOn(const string file_path)        { m_dec_file_on=file_path;          }
   void              DecFileOff(const string file_path)       { m_dec_file_off=file_path;         }
   //--- (1) ����� ���� �������� � (2) ����� ���� ��������
   void              ThumbColor(const color clr)              { m_thumb_border_color=clr;         }
   void              ThumbColorHover(const color clr)         { m_thumb_border_color_hover=clr;   }
   void              ThumbColorPressed(const color clr)       { m_thumb_border_color_pressed=clr; }
   void              ThumbBorderColor(const color clr)        { m_thumb_border_color=clr;         }
   void              ThumbBorderColorHover(const color clr)   { m_thumb_border_color_hover=clr;   }
   void              ThumbBorderColorPressed(const color clr) { m_thumb_border_color_pressed=clr; }
   //--- ����� �������� ������
   string            ScrollIncName(void)                const { return(m_inc.Name());             }
   string            ScrollDecName(void)                const { return(m_dec.Name());             }
   //--- ��������� ������
   bool              ScrollIncState(void)               const { return(m_inc.State());            }
   bool              ScrollDecState(void)               const { return(m_dec.State());            }
   //--- ��������� ������ ��������� (��������/� ������ ����������� ��������)
   void              ScrollState(const bool scroll_state)     { m_scroll_state=scroll_state;      }
   bool              ScrollState(void)                  const { return(m_scroll_state);           }
   //--- ������� ������� ��������
   void              CurrentPos(const int pos)                { m_current_pos=pos;                }
   int               CurrentPos(void)                   const { return(m_current_pos);            }
   //--- ���������� ������� ������� ����� ������ ����
   void              CheckMouseButtonState(const bool mouse_state);
   //--- ��������� ����������
   void              ZeroThumbVariables(void);
   //--- ��������� ������� �������� �� ����� ��������
   void              ChangeThumbSize(const int items_total,const int visible_items_total);
   //--- ������ ����� �������� ������ ���������
   bool              CalculateThumbSize(void);
   //--- ��������� ����� �������� ������ ���������
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
   virtual void      ResetColors(void) {}
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CScroll::CScroll(void) : m_current_pos(0),
                         m_area_width(15),
                         m_area_length(0),
                         m_inc_file_on(""),
                         m_inc_file_off(""),
                         m_dec_file_on(""),
                         m_dec_file_off(""),
                         m_thumb_width(0),
                         m_thumb_length(0),
                         m_thumb_min_length(15),
                         m_thumb_size_fixing(0),
                         m_thumb_point_fixing(0),
                         m_area_color(C'210,210,210'),
                         m_area_border_color(C'240,240,240'),
                         m_bg_border_color(C'210,210,210'),
                         m_thumb_color(C'190,190,190'),
                         m_thumb_color_hover(C'180,180,180'),
                         m_thumb_color_pressed(C'160,160,160'),
                         m_thumb_border_color(C'170,170,170'),
                         m_thumb_border_color_hover(C'160,160,160'),
                         m_thumb_border_color_pressed(C'140,140,140')
  {
//--- ��������� ���������� �� ������� ����� ������ ����
   m_area_zorder  =8;
   m_bg_zorder    =9;
   m_arrow_zorder =10;
   m_thumb_zorder =11;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CScroll::~CScroll(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CScroll::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //---
      int x=(int)lparam;
      int y=(int)dparam;
      //--- �������� ������ ��� ��������
      m_inc.MouseFocus(x>m_inc.X() && x<m_inc.X2() && y>m_inc.Y() && y<m_inc.Y2());
      m_dec.MouseFocus(x>m_dec.X() && x<m_dec.X2() && y>m_dec.Y() && y<m_dec.Y2());
     }
  }
//+------------------------------------------------------------------+
//| ������ ������ ���������                                         |
//+------------------------------------------------------------------+
bool CScroll::CreateScroll(const long chart_id,const int subwin,const int x,const int y,const int items_total,const int visible_items_total)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������� ������ ����� �������� "
              "��������� �� �����: CScroll::WindowPointer(CWindow &object)");
      return(false);
     }
//--- �����, ���� ������������ ������� ������������ ������� ����� ������ ���������
   if(CElement::ClassName()=="")
     {
      ::Print(__FUNCTION__," > ����������� ����������� ������ ������ ��������� (CScrollV ��� CScrollH).");
      return(false);
     }
//--- ������������� ����������
   m_chart_id            =chart_id;
   m_subwin              =subwin;
   m_x                   =x;
   m_y                   =y;
   m_area_width          =(CElement::ClassName()=="CScrollV")? CElement::XSize() : CElement::YSize();
   m_area_length         =(CElement::ClassName()=="CScrollV")? CElement::YSize() : CElement::XSize();
   m_items_total         =(items_total>0)? items_total : 1;
   m_visible_items_total =(visible_items_total>items_total)? items_total : visible_items_total;
   m_thumb_width         =m_area_width-2;
   m_thumb_steps_total   =m_items_total-m_visible_items_total+1;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ������
   if(!CreateArea())
      return(false);
   if(!CreateBg())
      return(false);
   if(!CreateInc())
      return(false);
   if(!CreateDec())
      return(false);
   if(!CreateThumb())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ������� �������                                    |
//+------------------------------------------------------------------+
bool CScroll::CreateArea(void)
  {
//--- ������������ ����� �������
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_area_" : "_scrollh_area_";
//--- ���� ������ �� �����
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- ���� ������ �����
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- �������� �������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- �������
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- ������� �� ������� �����
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� �������                                              |
//+------------------------------------------------------------------+
bool CScroll::CreateBg(void)
  {
//--- ������������ ����� �������
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_bg_" : "_scrollh_bg_";
//--- ���� ������ �� �����
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- ���� ������ �����
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x=0;
   int y=0;
//--- �������
   int x_size=0;
   int y_size=0;
//--- ��������� ������� � ������ ���� �������
   if(CElement::ClassName()=="CScrollV")
     {
      m_bg_length =CElement::YSize()-(m_thumb_width*2)-2;
      x           =CElement::X()+1;
      y           =CElement::Y()+m_thumb_width+1;
      x_size      =m_thumb_width;
      y_size      =m_bg_length;
     }
   else
     {
      m_bg_length =CElement::XSize()-(m_thumb_width*2)-2;
      x           =CElement::X()+m_thumb_width+1;
      y           =CElement::Y()+1;
      x_size      =m_bg_length;
      y_size      =m_thumb_width;
     }
//--- �������� �������
   if(!m_bg.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- ��������� �������
   m_bg.BackColor(m_area_color);
   m_bg.Color(m_bg_border_color);
   m_bg.BorderType(BORDER_FLAT);
   m_bg.Corner(m_corner);
   m_bg.Selectable(false);
   m_bg.Z_Order(m_bg_zorder);
   m_bg.Tooltip("\n");
//--- �������� ����������
   m_bg.X(x);
   m_bg.Y(y);
//--- �������� �������
   m_bg.XGap(x-m_wnd.X());
   m_bg.YGap(y-m_wnd.Y());
//--- �������� �������
   m_bg.XSize(x_size);
   m_bg.YSize(y_size);
//--- �������� ��������� �������
   CElement::AddToArray(m_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������� ������� ����� ��� �����                    |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\UpTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\UpTransp_min_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_min_dark.bmp"
//---
bool CScroll::CreateInc(void)
  {
//--- ������������ ����� �������
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_inc_" : "_scrollh_inc_";
//--- ���� ������ �� �����
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- ���� ������ �����
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x=m_x+1;
   int y=m_y+1;
//--- ��������� ������� � ������ ���� �������
   if(CElement::ClassName()=="CScrollV")
     {
      if(m_inc_file_on=="")
         m_inc_file_on="::Images\\EasyAndFastGUI\\Controls\\UpTransp_min_dark.bmp";
      if(m_inc_file_off=="")
         m_inc_file_off="::Images\\EasyAndFastGUI\\Controls\\UpTransp_min.bmp";
     }
   else
     {
      if(m_inc_file_on=="")
         m_inc_file_on="::Images\\EasyAndFastGUI\\Controls\\LeftTransp_min_dark.bmp";
      if(m_inc_file_off=="")
         m_inc_file_off="::Images\\EasyAndFastGUI\\Controls\\LeftTransp_min.bmp";
     }
//--- �������� �������
   if(!m_inc.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
   m_inc.BmpFileOn(m_inc_file_on);
   m_inc.BmpFileOff(m_inc_file_off);
   m_inc.Corner(m_corner);
   m_inc.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_inc.Selectable(false);
   m_inc.Z_Order(m_arrow_zorder);
   m_inc.Tooltip("\n");
//--- �������� ����������
   m_inc.X(x);
   m_inc.Y(y);
//--- �������� �������
   m_inc.XGap(x-m_wnd.X());
   m_inc.YGap(y-m_wnd.Y());
//--- �������� �������
   m_inc.XSize(m_inc.X_Size());
   m_inc.YSize(m_inc.Y_Size());
//--- �������� ��������� �������
   CElement::AddToArray(m_inc);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������� ������� ���� ��� ������                    |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DownTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DownTransp_min_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_min_dark.bmp"
//---
bool CScroll::CreateDec(void)
  {
//--- ������������ ����� �������
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_dec_" : "_scrollh_dec_";
//--- ���� ������ �� �����
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- ���� ������ �����
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x=m_x+1;
   int y=m_y+m_bg.YSize()+m_thumb_width+1;
//--- ��������� ������� � ������ ���� �������
   if(CElement::ClassName()=="CScrollV")
     {
      x =m_x+1;
      y =m_y+m_bg.YSize()+m_thumb_width+1;
      //--- ���� �������� �� ����������, ��������� �� ���������
      if(m_dec_file_on=="")
         m_dec_file_on="Images\\EasyAndFastGUI\\Controls\\DownTransp_min_dark.bmp";
      if(m_dec_file_off=="")
         m_dec_file_off="Images\\EasyAndFastGUI\\Controls\\DownTransp_min.bmp";
     }
   else
     {
      x =m_x+m_bg.XSize()+m_thumb_width+1;
      y =m_y+1;
      //--- ���� �������� �� ����������, ��������� �� ���������
      if(m_dec_file_on=="")
         m_dec_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_min_dark.bmp";
      if(m_dec_file_off=="")
         m_dec_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_min.bmp";
     }
//--- �������� �������
   if(!m_dec.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
   m_dec.BmpFileOn("::"+m_dec_file_on);
   m_dec.BmpFileOff("::"+m_dec_file_off);
   m_dec.Corner(m_corner);
   m_dec.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_dec.Selectable(false);
   m_dec.Z_Order(m_arrow_zorder);
   m_dec.Tooltip("\n");
//--- �������� ����������
   m_dec.X(x);
   m_dec.Y(y);
//--- �������� �������
   m_dec.XGap(x-m_wnd.X());
   m_dec.YGap(y-m_wnd.Y());
//--- �������� �������
   m_dec.XSize(m_dec.X_Size());
   m_dec.YSize(m_dec.Y_Size());
//--- �������� ��������� �������
   CElement::AddToArray(m_dec);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ������ ���������                                |
//+------------------------------------------------------------------+
bool CScroll::CreateThumb(void)
  {
//--- ������������ ����� �������  
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_thumb_" : "_scrollh_thumb_";
//--- ���� ������ �� �����
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- ���� ������ �����
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x=0;
   int y=0;
//--- �������
   int x_size=0;
   int y_size=0;
//--- ���������� ������ ������ ���������
   if(!CalculateThumbSize())
      return(true);
//--- ��������� �������� � ������ ���� �������
   if(CElement::ClassName()=="CScrollV")
     {
      x      =(m_thumb.X()>0) ? m_thumb.X() : m_x+1;
      y      =(m_thumb.Y()>0) ? m_thumb.Y() : m_y+m_thumb_width+1;
      x_size =m_thumb_width;
      y_size =m_thumb_length;
     }
   else
     {
      x      =(m_thumb.X()>0) ? m_thumb.X() : m_x+m_thumb_width+1;
      y      =(m_thumb.Y()>0) ? m_thumb.Y() : m_y+1;
      x_size =m_thumb_length;
      y_size =m_thumb_width;
     }
//--- �������� �������
   if(!m_thumb.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- ��������� �������
   m_thumb.BackColor(m_thumb_color);
   m_thumb.Color(m_thumb_border_color);
   m_thumb.BorderType(BORDER_FLAT);
   m_thumb.Corner(m_corner);
   m_thumb.Selectable(false);
   m_thumb.Z_Order(m_thumb_zorder);
   m_thumb.Tooltip("\n");
//--- �������� ����������
   m_thumb.X(x);
   m_thumb.Y(y);
//--- �������� �������
   m_thumb.XGap(x-m_wnd.X());
   m_thumb.YGap(y-m_wnd.Y());
//--- �������� �������
   m_thumb.XSize(x_size);
   m_thumb.YSize(y_size);
//--- �������� ��������� �������
   CElement::AddToArray(m_thumb);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ������ ���������                                  |
//+------------------------------------------------------------------+
bool CScroll::CalculateThumbSize(void)
  {
//--- ������ �� �����, ���� ����� ������� ��� ����������� �������� ������, ��� ����������� ����� ��������
   if(m_bg_length<m_thumb_min_length)
      return(false);
//--- ������� � ��������� ����� ����� ����������� ������� � �������
   double percentage_difference=1-(double)(m_items_total-m_visible_items_total)/m_items_total;
//--- ���������� ������ ���� ��������
   m_thumb_step_size=(double)(m_bg_length-(m_bg_length*percentage_difference))/m_thumb_steps_total;
//--- ���������� ������ ������� ������� ��� ����������� ��������
   double work_area=m_thumb_step_size*m_thumb_steps_total;
//--- ���� ������ ������� ������� ������ ������� ���� �������, ������� ������ ��������, ����� ��������� ����������� ������
   double thumb_size=(work_area<m_bg_length)? m_bg_length-work_area+m_thumb_step_size : m_thumb_min_length;
//--- �������� ������� �������� � ������ ���������� ����
   m_thumb_length=((int)thumb_size<m_thumb_min_length)? m_thumb_min_length :(int)thumb_size;
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� ������� ������� ����� ������ ����                     |
//+------------------------------------------------------------------+
void CScroll::CheckMouseButtonState(const bool mouse_state)
  {
//--- ���� ����� ������ ���� ������
   if(!mouse_state)
     {
      //--- ������� ����������
      ZeroThumbVariables();
      return;
     }
//--- ���� ������ ������
   if(mouse_state)
     {
      //--- ������, ���� ������ ��� ������ � �����-���� �������
      if(m_clamping_area_mouse!=THUMB_NOT_PRESSED)
         return;
      //--- ��� ������� �������� ������ ���������
      if(!m_thumb.MouseFocus())
         m_clamping_area_mouse=THUMB_PRESSED_OUTSIDE;
      //--- � ������� �������� ������ ���������
      else
        {
         m_clamping_area_mouse=THUMB_PRESSED_INSIDE;
         //--- ���� ������� �� ����������
         if(!CElement::IsDropdown())
           {
            //--- ����������� ����� � �������� ������������� ��������� ��������
            m_wnd.IsLocked(true);
            m_wnd.IdActivatedElement(CElement::Id());
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ���������� ��������� � ������������ ��������           |
//+------------------------------------------------------------------+
void CScroll::ZeroThumbVariables(void)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return;
//--- ���� ������� �� ����������
   if(!CElement::IsDropdown() && m_clamping_area_mouse==THUMB_PRESSED_INSIDE)
     {
      //--- ������������ ����� � ������� ������������� ��������� ��������
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
//--- �������� ����������
   m_thumb_size_fixing   =0;
   m_clamping_area_mouse =THUMB_NOT_PRESSED;
  }
//+------------------------------------------------------------------+
//| �������� ���� �������� ������ ��������� ������                   |
//+------------------------------------------------------------------+
void CScroll::ChangeObjectsColor(void)
  {
//--- �����, ���� ����� ������������� � ������������� ��������� � ������� ������ �������� ����������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- ���� ������ ������ ��������� ������
   if(!m_scroll_state)
     {
      m_inc.State(m_inc.MouseFocus());
      m_dec.State(m_dec.MouseFocus());
     }
//--- ���� ������ � ���� ������ ���������
   if(m_thumb.MouseFocus())
     {
      //--- ���� ����� ������ ���� ������
      if(m_clamping_area_mouse==THUMB_NOT_PRESSED)
        {
         m_scroll_state=false;
         m_thumb.BackColor(m_thumb_color_hover);
         m_thumb.Color(m_thumb_border_color_hover);
        }
      //--- ����� ������ ���� ������ �� ��������
      else if(m_clamping_area_mouse==THUMB_PRESSED_INSIDE)
        {
         m_scroll_state=true;
         m_thumb.BackColor(m_thumb_color_pressed);
         m_thumb.Color(m_thumb_border_color_pressed);
        }
     }
//--- ���� ������ ��� ���� ������ ���������
   else
     {
      //--- ����� ������ ���� ������
      if(m_clamping_area_mouse==THUMB_NOT_PRESSED)
        {
         m_scroll_state=false;
         m_thumb.BackColor(m_thumb_color);
         m_thumb.Color(m_thumb_border_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������� �������� �� ����� ��������                     |
//+------------------------------------------------------------------+
void CScroll::ChangeThumbSize(const int items_total,const int visible_items_total)
  {
   m_items_total         =items_total;
   m_visible_items_total =visible_items_total;
//--- ������, ���� ���������� ��������� ������ �� ������ ���������� ������� ����� ������
   if(items_total<=visible_items_total)
      return;
//--- ������� ���������� ����� ��� ��������
   m_thumb_steps_total=items_total-visible_items_total+1;
//--- ������� ������ ������ ���������
   if(!CalculateThumbSize())
      return;
//--- �������� �������
   if(CElement::ClassName()=="CScrollV")
     {
      CElement::YSize(m_thumb_length);
      m_thumb.YSize(m_thumb_length);
      m_thumb.Y_Size(m_thumb_length);
     }
   else
     {
      CElement::XSize(m_thumb_length);
      m_thumb.XSize(m_thumb_length);
      m_thumb.X_Size(m_thumb_length);
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CScroll::Moving(const int x,const int y)
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
   m_bg.X(x+m_bg.XGap());
   m_bg.Y(y+m_bg.YGap());
   m_inc.X(x+m_inc.XGap());
   m_inc.Y(y+m_inc.YGap());
   m_dec.X(x+m_dec.XGap());
   m_dec.Y(y+m_dec.YGap());
   m_thumb.X(x+m_thumb.XGap());
   m_thumb.Y(y+m_thumb.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_bg.X_Distance(m_bg.X());
   m_bg.Y_Distance(m_bg.Y());
   m_inc.X_Distance(m_inc.X());
   m_inc.Y_Distance(m_inc.Y());
   m_dec.X_Distance(m_dec.X());
   m_dec.Y_Distance(m_dec.Y());
   m_thumb.X_Distance(m_thumb.X());
   m_thumb.Y_Distance(m_thumb.Y());
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CScroll::Show(void)
  {
//--- ������, ���� ���������� ��������� ������ �� ������ ���������� ������� ����� ������
   if(m_items_total<=m_visible_items_total)
      return;
//---
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_bg.Timeframes(OBJ_ALL_PERIODS);
   m_inc.Timeframes(OBJ_ALL_PERIODS);
   m_dec.Timeframes(OBJ_ALL_PERIODS);
   m_thumb.Timeframes(OBJ_ALL_PERIODS);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CScroll::Hide(void)
  {
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_bg.Timeframes(OBJ_NO_PERIODS);
   m_inc.Timeframes(OBJ_NO_PERIODS);
   m_dec.Timeframes(OBJ_NO_PERIODS);
   m_thumb.Timeframes(OBJ_NO_PERIODS);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CScroll::Reset(void)
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
void CScroll::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   m_bg.Delete();
   m_inc.Delete();
   m_dec.Delete();
   m_thumb.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CScroll::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_bg.Z_Order(m_bg_zorder);
   m_inc.Z_Order(m_arrow_zorder);
   m_dec.Z_Order(m_arrow_zorder);
   m_thumb.Z_Order(m_thumb_zorder);
//--- ���� ������������ ������ ���������
   if(CElement::ClassName()=="CScrollV")
     {
      m_inc.BmpFileOn(m_inc_file_on);
      m_dec.BmpFileOn(m_dec_file_on);
      return;
     }
//--- ���� �������������� ������ ���������
   if(CElement::ClassName()=="CScrollH")
     {
      m_inc.BmpFileOn(m_inc_file_on);
      m_dec.BmpFileOn(m_dec_file_on);
      return;
     }
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CScroll::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_bg.Z_Order(0);
   m_inc.Z_Order(0);
   m_dec.Z_Order(0);
   m_thumb.Z_Order(0);
//--- ���� ������������ ������ ���������
   if(CElement::ClassName()=="CScrollV")
     {
      m_inc.BmpFileOn(m_inc_file_off);
      m_dec.BmpFileOn(m_dec_file_off);
      return;
     }
//--- ���� �������������� ������ ���������
   if(CElement::ClassName()=="CScrollH")
     {
      m_inc.BmpFileOn(m_inc_file_off);
      m_dec.BmpFileOn(m_dec_file_off);
      return;
     }
  }
//+------------------------------------------------------------------+
//| ����� ��� ���������� ������������ ������� ���������              |
//+------------------------------------------------------------------+
class CScrollV : public CScroll
  {
public:
                     CScrollV(void);
                    ~CScrollV(void);
   //--- ���������� ���������
   bool              ScrollBarControl(const int x,const int y,const bool mouse_state);
   //--- ������ ���������� Y ��������
   void              CalculateThumbY(void);
   //--- ���������� ����� ���������� ��� ������ ���������
   void              XDistance(const int x);
   //--- ��������� ������� �� ������� ������ ���������
   bool              OnClickScrollInc(const string clicked_object);
   bool              OnClickScrollDec(const string clicked_object);
   //---
private:
   //--- ������� ����������� ��������
   void              OnDragThumb(const int y);
   //--- ���������� ��������� ��������
   void              UpdateThumb(const int new_y_point);
   //--- ������������ ����� ������� ��������
   void              CalculateThumbPos(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CScrollV::CScrollV(void)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CScrollV::~CScrollV(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ���������                                             |
//+------------------------------------------------------------------+
bool CScrollV::ScrollBarControl(const int x,const int y,const bool mouse_state)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return(false);
//--- ���� ����� �� ������������� � �������������� ���������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- �������� ������ ��� ��������
   m_thumb.MouseFocus(x>m_thumb.X() && x<m_thumb.X2() && 
                      y>m_thumb.Y() && y<m_thumb.Y2());
//--- �������� � �������� ��������� ������ ����
   CScroll::CheckMouseButtonState(mouse_state);
//--- ������� ���� ��������
   CScroll::ChangeObjectsColor();
//--- ���� ���������� �������� ������ ���������, ��������� ��������� ��������
   if(CScroll::ScrollState())
     {
      //--- ����������� ��������
      OnDragThumb(y);
      //--- �������� ����� ������� ��������
      CalculateThumbPos();
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| ������ ���������� Y �������� ������ ���������                    |
//+------------------------------------------------------------------+
void CScrollV::CalculateThumbY(void)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return;
//--- ��������� ������� ���������� Y ��������
   int scroll_thumb_y=int(m_bg.Y()+(CScroll::CurrentPos()*CScroll::m_thumb_step_size));
//--- ���� ������� �� ������� ������� ������� �����
   if(scroll_thumb_y<=m_bg.Y())
      scroll_thumb_y=m_bg.Y();
//--- ���� ������� �� ������� ������� ������� ����
   if(scroll_thumb_y+CScroll::m_thumb_length>=m_bg.Y2() || 
      CScroll::CurrentPos()>=CScroll::m_thumb_steps_total-1)
     {
      scroll_thumb_y=int(m_bg.Y2()-CScroll::m_thumb_length);
     }
//--- ������� ���������� � ������ �� ��� Y
   m_thumb.Y(scroll_thumb_y);
   m_thumb.Y_Distance(scroll_thumb_y);
   m_thumb.YGap(m_thumb.Y()-m_wnd.Y());
  }
//+------------------------------------------------------------------+
//| ��������� ���������� X ��������                                  |
//+------------------------------------------------------------------+
void CScrollV::XDistance(const int x)
  {
//--- ������� ���������� X ��������...
   int l_x=x+1;
   CElement::X(x);
//--- ...� ���� �������� ������ ���������
   m_area.X(CElement::X());
   m_bg.X(l_x);
   m_thumb.X(l_x);
   m_inc.X(l_x);
   m_dec.X(l_x);
//--- ��������� ���������� ��������
   m_area.X_Distance(CElement::X());
   m_bg.X_Distance(l_x);
   m_thumb.X_Distance(l_x);
   m_inc.X_Distance(l_x);
   m_dec.X_Distance(l_x);
//--- ������� ������� � ���� �������� ��������
   l_x=l_x-m_wnd.X();
   m_area.XGap(CElement::X()-m_wnd.X());
   m_bg.XGap(l_x);
   m_thumb.XGap(l_x);
   m_inc.XGap(l_x);
   m_dec.XGap(l_x);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ �����/�����                          |
//+------------------------------------------------------------------+
bool CScrollV::OnClickScrollInc(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ���� ������ ��� ������ ������ ������� ��� ���-�� ����� ������������
   if(m_inc.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<1)
      return(false);
//--- �������� ����� ������� ������ ���������
   if(CScroll::CurrentPos()>0)
      CScroll::m_current_pos--;
//--- ������ ��������� Y ������ ���������
   CalculateThumbY();
//--- ��������� ��������� On
   m_inc.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ ����/������                          |
//+------------------------------------------------------------------+
bool CScrollV::OnClickScrollDec(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ���� ������ ��� ������ ������ ������� ��� ���-�� ����� ������������
   if(m_dec.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<1)
      return(false);
//--- �������� ����� ������� ������ ���������
   if(CScroll::CurrentPos()<CScroll::m_thumb_steps_total-1)
      CScroll::m_current_pos++;
//--- ������ ��������� Y ������ ���������
   CalculateThumbY();
//--- ��������� ��������� On
   m_dec.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| ����������� ��������                                             |
//+------------------------------------------------------------------+
void CScrollV::OnDragThumb(const int y)
  {
//--- ��� ����������� ����� Y ����������
   int new_y_point=0;
//--- ���� ������ ��������� ���������, ...
   if(!CScroll::ScrollState())
     {
      //--- ...������� ��������������� ���������� ��� ����������� ��������
      CScroll::m_thumb_size_fixing  =0;
      CScroll::m_thumb_point_fixing =0;
      return;
     }
//--- ���� ����� �������� �������, �� �������� ������� ���������� �������
   if(CScroll::m_thumb_point_fixing==0)
      CScroll::m_thumb_point_fixing=y;
//--- ���� �������� ���������� �� ������� ����� �������� �� ������� ���������� ������� �������, ���������� ���
   if(CScroll::m_thumb_size_fixing==0)
      CScroll::m_thumb_size_fixing=m_thumb.Y()-y;
//--- ���� � ������� ��������� ������ ����� ����
   if(y-CScroll::m_thumb_point_fixing>0)
     {
      //--- ���������� ���������� Y
      new_y_point=y+CScroll::m_thumb_size_fixing;
      //--- ������� ��������� ��������
      UpdateThumb(new_y_point);
      return;
     }
//--- ���� � ������� ��������� ������ ����� �����
   if(y-CScroll::m_thumb_point_fixing<0)
     {
      //--- ���������� ���������� Y
      new_y_point=y-::fabs(CScroll::m_thumb_size_fixing);
      //--- ������� ��������� ��������
      UpdateThumb(new_y_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ��������                                    |
//+------------------------------------------------------------------+
void CScrollV::UpdateThumb(const int new_y_point)
  {
   int y=new_y_point;
//--- ��������� ����� ��������
   CScroll::m_thumb_point_fixing=0;
//--- �������� �� ����� �� ������� ������� ���� � ������������� ��������
   if(new_y_point>m_bg.Y2()-CScroll::m_thumb_length)
     {
      y=m_bg.Y2()-CScroll::m_thumb_length;
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total));
     }
//--- �������� �� ����� �� ������� ������� ����� � ������������� ��������
   if(new_y_point<=m_bg.Y())
     {
      y=m_bg.Y();
      CScroll::CurrentPos(0);
     }
//--- ������� ���������� � �������
   m_thumb.Y(y);
   m_thumb.Y_Distance(y);
   m_thumb.YGap(m_thumb.Y()-(CElement::Y()-CElement::YGap()));
  }
//+------------------------------------------------------------------+
//| ������������ ����� ������� ��������                              |
//+------------------------------------------------------------------+
void CScrollV::CalculateThumbPos(void)
  {
//--- �����, ���� ��� ����� ����
   if(CScroll::m_thumb_step_size==0)
      return;
//--- ������������ ����� ������� ������ ���������
   CScroll::CurrentPos(int((m_thumb.Y()-m_bg.Y())/CScroll::m_thumb_step_size));
//--- �������� �� ����� �� ������� ������� ����/�����
   if(m_thumb.Y2()>=m_bg.Y2()-1)
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total-1));
   if(m_thumb.Y()<m_bg.Y())
      CScroll::CurrentPos(0);
  }
//+------------------------------------------------------------------+
//| ����� ��� ���������� �������������� ������� ���������            |
//+------------------------------------------------------------------+
class CScrollH : public CScroll
  {
public:
                     CScrollH(void);
                    ~CScrollH(void);
   //--- ���������� ���������
   bool              ScrollBarControl(const int x,const int y,const bool mouse_state);
   //--- ������ ���������� X ��������
   void              CalculateThumbX(void);
   //--- ��������� ������� �� ������� ������ ���������
   bool              OnClickScrollInc(const string clicked_object);
   bool              OnClickScrollDec(const string clicked_object);
   //---
private:
   //--- ����������� ��������
   void              OnDragThumb(const int x);
   //--- ���������� ��������� ��������
   void              UpdateThumb(const int new_x_point);
   //--- ������������ ����� ������� ��������
   void              CalculateThumbPos(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CScrollH::CScrollH(void)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CScrollH::~CScrollH(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ��������                                              |
//+------------------------------------------------------------------+
bool CScrollH::ScrollBarControl(const int x,const int y,const bool mouse_state)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return(false);
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- �������� ������ ��� ��������
   m_thumb.MouseFocus(x>m_thumb.X() && x<m_thumb.X2() && 
                      y>m_thumb.Y() && y<m_thumb.Y2());
//--- �������� � �������� ��������� ������ ����
   CScroll::CheckMouseButtonState(mouse_state);
//--- ������� ���� ������ ��������� ������
   CScroll::ChangeObjectsColor();
//--- ���� ���������� �������� ������ ���������, ��������� ��������� ��������
   if(CScroll::ScrollState())
     {
      //--- ����������� ��������
      OnDragThumb(x);
      //--- �������� ����� ������� ��������
      CalculateThumbPos();
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//| ������ ���������� X ��������                                     |
//+------------------------------------------------------------------+
void CScrollH::CalculateThumbX(void)
  {
//--- ��������� ������� ���������� X ��������
   int scroll_thumb_x=int(m_bg.X()+(CScroll::CurrentPos()*CScroll::m_thumb_step_size));
//--- ���� ������� �� ������� ������� ������� �����
   if(scroll_thumb_x<=m_bg.X())
      scroll_thumb_x=m_bg.X();
//--- ���� ������� �� ������� ������� ������� ������
   if(scroll_thumb_x+CScroll::m_thumb_length>=m_bg.X2() || 
      CScroll::CurrentPos()>=CScroll::m_thumb_steps_total-1)
     {
      scroll_thumb_x=int(m_bg.X2()-CScroll::m_thumb_length);
     }
//--- ������� ���������� � ������ �� ��� X
   m_thumb.X(scroll_thumb_x);
   m_thumb.X_Distance(scroll_thumb_x);
   m_thumb.XGap(m_thumb.X()-(m_x-CElement::XGap()));
  }
//+------------------------------------------------------------------+
//| ������� �� ������������� �����                                   |
//+------------------------------------------------------------------+
bool CScrollH::OnClickScrollInc(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ���� ������ ��� ������ ������ ������� ��� ���-�� ����� ������������
   if(m_inc.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<0)
      return(false);
//--- �������� ����� ������� ������ ���������
   if(CScroll::CurrentPos()>0)
      CScroll::m_current_pos--;
//--- ������ ��������� X ������ ���������
   CalculateThumbX();
//--- ��������� ��������� On
   m_inc.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������������� ������                                  |
//+------------------------------------------------------------------+
bool CScrollH::OnClickScrollDec(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ���� ������ ��� ������ ������ ������� ��� ���-�� ����� ������������
   if(m_dec.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<0)
      return(false);
//--- �������� ����� ������� ������ ���������
   if(CScroll::CurrentPos()<CScroll::m_thumb_steps_total-1)
      CScroll::m_current_pos++;
//--- ������ ���������� X ������ ���������
   CalculateThumbX();
//--- ��������� ��������� On
   m_dec.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| ����������� ��������                                             |
//+------------------------------------------------------------------+
void CScrollH::OnDragThumb(const int x)
  {
//--- ��� ����������� ����� X ����������
   int new_x_point=0;
//--- ���� ������ ��������� ���������, ...
   if(!CScroll::ScrollState())
     {
      //--- ...������� ��������������� ���������� ��� ����������� ��������
      CScroll::m_thumb_size_fixing  =0;
      CScroll::m_thumb_point_fixing =0;
      return;
     }
//--- ���� ����� �������� �������, �� �������� ������� ���������� �������
   if(CScroll::m_thumb_point_fixing==0)
      CScroll::m_thumb_point_fixing=x;
//--- ���� �������� ���������� �� ������� ����� �������� �� ������� ���������� ������� �������, ���������� ���
   if(CScroll::m_thumb_size_fixing==0)
      CScroll::m_thumb_size_fixing=m_thumb.X()-x;
//--- ���� � ������� ��������� ������ ����� ������
   if(x-CScroll::m_thumb_point_fixing>0)
     {
      //--- ���������� ���������� X
      new_x_point=x+CScroll::m_thumb_size_fixing;
      //--- ���������� ��������� ������ ���������
      UpdateThumb(new_x_point);
      return;
     }
//--- ���� � ������� ��������� ������ ����� �����
   if(x-CScroll::m_thumb_point_fixing<0)
     {
      //--- ���������� ���������� X
      new_x_point=x-::fabs(CScroll::m_thumb_size_fixing);
      //--- ���������� ��������� ������ ���������
      UpdateThumb(new_x_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������ ���������                            |
//+------------------------------------------------------------------+
void CScrollH::UpdateThumb(const int new_x_point)
  {
   int x=new_x_point;
//--- ��������� ����� ��������
   CScroll::m_thumb_point_fixing=0;
//--- �������� �� ����� �� ������� ������� ������ � ������������� ��������
   if(new_x_point>m_bg.X2()-CScroll::m_thumb_length)
     {
      x=m_bg.X2()-CScroll::m_thumb_length;
      CScroll::CurrentPos(0);
     }
//--- �������� �� ����� �� ������� ������� ����� � ������������� ��������
   if(new_x_point<=m_bg.X())
     {
      x=m_bg.X();
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total));
     }
//--- ������� ���������� � �������
   m_thumb.X(x);
   m_thumb.X_Distance(x);
   m_thumb.XGap(m_thumb.X()-(m_x-CElement::XGap()));
  }
//+------------------------------------------------------------------+
//| ������������ ����� ������� ��������                              |
//+------------------------------------------------------------------+
void CScrollH::CalculateThumbPos(void)
  {
//--- �����, ���� ��� ����� ����
   if(CScroll::m_thumb_step_size==0)
      return;
//--- ������������ ����� ������� ������ ���������
   CScroll::CurrentPos(int((m_thumb.X()-m_bg.X())/CScroll::m_thumb_step_size));
//--- �������� �� ����� �� ������� ������� �����/������
   if(m_thumb.X2()>=m_bg.X2()-1)
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total-1));
   if(m_thumb.X()<m_bg.X())
      CScroll::CurrentPos(0);
  }
//+------------------------------------------------------------------+
