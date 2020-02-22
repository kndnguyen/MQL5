//+------------------------------------------------------------------+
//|                                                   IconButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������ � ���������                            |
//+------------------------------------------------------------------+
class CIconButton : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������
   CButton           m_button;
   CBmpLabel         m_icon;
   CLabel            m_label;
   //--- �������� ������:
   //    ������ � ��������� �� ������� ����� ������� ����
   int               m_button_x_size;
   int               m_button_y_size;
   int               m_button_zorder;
   //--- ���� ���� � ��������� �������
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   color             m_back_color_array[];
   //--- ���� �����
   color             m_border_color;
   color             m_border_color_off;
   //--- ������ ������ � �������� � ��������������� ���������
   string            m_icon_file_on;
   string            m_icon_file_off;
   //--- ������� ������
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- ����� � ������� ��������� �����
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ���� ��������� ����� � ��������� �������
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   color             m_label_color_array[];
   //--- ����� ��������� ��� �������������� ��������
   int               m_zorder;
   //--- ����� ���� ��������� ������
   bool              m_two_state;
   //--- ��������/������������
   bool              m_button_state;
   //--- ����� "������ ��������", ����� ������ ������� ������ �� ������� BmpLabel
   bool              m_only_icon;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //---
public:
                     CIconButton(void);
                    ~CIconButton(void);
   //--- ������ ��� �������� ������
   bool              CreateIconButton(const long chart_id,const int subwin,const string button_text,const int x,const int y);
   //---
private:
   bool              CreateButton(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ������ ������, (3) ��������� ������ "������ ��������"
   //    (4) ����� ��������� ������ (��������/������������)
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);     }
   void              TwoState(const bool flag)                { m_two_state=flag;               }
   void              OnlyIcon(const bool flag)                { m_only_icon=flag;               }
   bool              IsPressed(void)                    const { return(m_button.State());       }
   bool              ButtonState(void)                  const { return(m_button_state);         }
   void              ButtonState(const bool state);
   //--- (1) ��������� ������ ������, (2) ������ ������
   string            Text(void)                         const { return(m_label_text);           }
   void              ButtonXSize(const int x_size)            { m_button_x_size=x_size;         }
   void              ButtonYSize(const int y_size)            { m_button_y_size=y_size;         }
   //--- ��������� ������� ��� ������ � �������� � ��������������� ����������
   void              IconFileOn(const string file_path)       { m_icon_file_on=file_path;       }
   void              IconFileOff(const string file_path)      { m_icon_file_off=file_path;      }
   //--- ������� ������
   void              IconXGap(const int x_gap)                { m_icon_x_gap=x_gap;             }
   void              IconYGap(const int y_gap)                { m_icon_y_gap=y_gap;             }
   //--- ����� ���� ������
   void              BackColor(const color clr)               { m_back_color=clr;               }
   void              BackColorOff(const color clr)            { m_back_color_off=clr;           }
   void              BackColorHover(const color clr)          { m_back_color_hover=clr;         }
   void              BackColorPressed(const color clr)        { m_back_color_pressed=clr;       }
   //--- ��������� ����� ����� ������
   void              BorderColor(const color clr)             { m_border_color=clr;             }
   void              BorderColorOff(const color clr)          { m_border_color_off=clr;         }
   //--- ������� ��������� �����
   void              LabelXGap(const int x_gap)               { m_label_x_gap=x_gap;            }
   void              LabelYGap(const int y_gap)               { m_label_y_gap=y_gap;            }
   //--- ��������� ����� ������ ������
   void              LabelColor(const color clr)              { m_label_color=clr;              }
   void              LabelColorOff(const color clr)           { m_label_color_off=clr;          }
   void              LabelColorHover(const color clr)         { m_label_color_hover=clr;        }
   void              LabelColorPressed(const color clr)       { m_label_color_pressed=clr;      }
   //--- ��������� ����� ��������
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
   //--- ��������� ������� �� ������
   bool              OnClickButton(const string clicked_object);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CIconButton::CIconButton(void) : m_icon_x_gap(4),
                                 m_icon_y_gap(3),
                                 m_label_x_gap(25),
                                 m_label_y_gap(4),
                                 m_icon_file_on(""),
                                 m_icon_file_off(""),
                                 m_button_state(true),
                                 m_two_state(false),
                                 m_only_icon(false),
                                 m_button_y_size(18),
                                 m_back_color(clrLightGray),
                                 m_back_color_off(clrLightGray),
                                 m_back_color_hover(clrSilver),
                                 m_back_color_pressed(clrBlack),
                                 m_border_color(clrWhite),
                                 m_border_color_off(clrDarkGray),
                                 m_label_color(clrBlack),
                                 m_label_color_off(clrDarkGray),
                                 m_label_color_hover(clrBlack),
                                 m_label_color_pressed(clrBlack)
  {
//--- �������� ��� ������ �������� � ������� ������  
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder        =0;
   m_button_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIconButton::~CIconButton(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CIconButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_icon.MouseFocus(x>m_icon.X() && x<m_icon.X2() && y>m_icon.Y() && y<m_icon.Y2());
      //--- �����, ���� ����� �������������
      if(m_wnd.IsLocked())
         return;
      //--- �����, ���� ����� ������ ���� ������
      if(!m_mouse_state)
         return;
      //--- �����, ���� ������ �������������
      if(!m_button_state)
         return;
      //--- ���� ��� ������
      if(!CElement::MouseFocus())
        {
         //--- ���� ������ ������
         if(!m_button.State())
            m_button.BackColor(m_back_color);
         //---
         return;
        }
      //--- ���� ���� �����
      else
        {
         m_label.Color(m_label_color_pressed);
         m_button.BackColor(m_back_color_pressed);
         return;
        }
      //---
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CIconButton::OnEventTimer(void)
  {
//--- ���� ������� �������� ����������
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- ���� ����� � ������ �� �������������
      if(!m_wnd.IsLocked() && m_button_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� "������"                                         |
//+------------------------------------------------------------------+
bool CIconButton::CreateIconButton(const long chart_id,const int subwin,const string button_text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ������ ����� �������� "
              "��������� �� �����: CIconButton::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =x;
   m_y          =y;
   m_label_text =button_text;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ������
   if(!CreateButton())
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
//| ������ ��� ������                                               |
//+------------------------------------------------------------------+
bool CIconButton::CreateButton(void)
  {
//--- ������, ���� ������� ����� "������ ��������"
   if(m_only_icon)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icon_button_"+(string)CElement::Id();
//--- ��������� ������
   if(!m_button.Create(m_chart_id,name,m_subwin,m_x,m_y,m_button_x_size,m_button_y_size))
      return(false);
//--- ��������� ��������
   m_button.Font(FONT);
   m_button.FontSize(FONT_SIZE);
   m_button.Color(m_back_color);
   m_button.Description("");
   m_button.BorderColor(m_border_color);
   m_button.BackColor(m_back_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_button_zorder);
   m_button.Tooltip("\n");
//--- �������� �������
   CElement::XSize(m_button_x_size);
   CElement::YSize(m_button_y_size);
//--- ������� �� ������� �����
   m_button.XGap(m_x-m_wnd.X());
   m_button.YGap(m_y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ������                                          |
//+------------------------------------------------------------------+
bool CIconButton::CreateIcon(void)
  {
//--- ���� ����� "������ ��������" ��������
   if(!m_only_icon)
     {
      //--- ���� ����� ��� ������ �� �����, �����
      if(m_icon_file_on=="" || m_icon_file_off=="")
         return(true);
     }
//--- ���� ������� ����� "������ ��������" 
   else
     {
      //--- ���� ����� �� ��� ��������, ������� ��������� � �����
      if(m_icon_file_on=="" || m_icon_file_off=="")
        {
         ::Print(__FUNCTION__," > � ������ \"Only icon\" ����������� �������� �����������.");
         return(false);
        }
     }
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icon_button_bmp_"+(string)CElement::Id();
//--- ����������
   int x =(!m_only_icon)? m_x+m_icon_x_gap : m_x;
   int y =(!m_only_icon)? m_y+m_icon_y_gap : m_y;
//--- ��������� �����
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_icon.BmpFileOn("::"+m_icon_file_on);
   m_icon.BmpFileOff("::"+m_icon_file_off);
   m_icon.State(true);
   m_icon.Corner(m_corner);
   m_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon.Selectable(false);
   m_icon.Z_Order((!m_only_icon)? m_zorder : m_button_zorder);
   m_icon.Tooltip((!m_only_icon)? "\n" : m_label_text);
//--- �������� ����������
   m_icon.X(x);
   m_icon.Y(y);
//--- �������� �������
   m_icon.XSize(m_icon.X_Size());
   m_icon.YSize(m_icon.Y_Size());
//--- ������� �� ������� �����
   m_icon.XGap(x-m_wnd.X());
   m_icon.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ������                                           |
//+------------------------------------------------------------------+
bool CIconButton::CreateLabel(void)
  {
//--- ������, ���� ������� ����� "������ ��������"
   if(m_only_icon)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icon_button_lable_"+(string)CElement::Id();
//--- ����������
   int x =m_x+m_label_x_gap;
   int y =m_y+m_label_y_gap;
//--- ��������� ��������� �����
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_label.Description(m_label_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(m_label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.Tooltip("\n");
//--- ������� �� ������� �����
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CIconButton::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_button.X(x+m_button.XGap());
   m_button.Y(y+m_button.YGap());
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
//--- ���������� ��������� ����������� ��������
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
  }
//+------------------------------------------------------------------+
//| ���������� ������                                                |
//+------------------------------------------------------------------+
void CIconButton::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ������                                                  |
//+------------------------------------------------------------------+
void CIconButton::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CIconButton::Reset(void)
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
void CIconButton::Delete(void)
  {
//--- �������� ��������
   m_button.Delete();
   m_icon.Delete();
   m_label.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CIconButton::SetZorders(void)
  {
   m_label.Z_Order(m_zorder);
   m_button.Z_Order(m_button_zorder);
   m_icon.Z_Order((!m_only_icon)? m_zorder : m_button_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CIconButton::ResetZorders(void)
  {
   m_button.Z_Order(-1);
   m_icon.Z_Order(-1);
   m_label.Z_Order(-1);
//--- 
   m_icon.MouseFocus(false);
   ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| ���������� ����                                                  |
//+------------------------------------------------------------------+
void CIconButton::ResetColors(void)
  {
//--- �����, ���� ����� ���� ��������� � ������ ������
   if(m_two_state && m_button_state)
      return;
//--- �������� ����
   m_button.BackColor(m_back_color);
//--- ������� �����
   m_button.MouseFocus(false);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CIconButton::ChangeObjectsColor(void)
  {
   if(m_only_icon)
      m_icon.State(m_icon.MouseFocus());
//--- �����, ���� ������� ������������
   if(!m_button_state)
      return;
//---
   ChangeObjectColor(m_button.Name(),MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
   ChangeObjectColor(m_label.Name(),MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������                                       |
//+------------------------------------------------------------------+
void CIconButton::ButtonState(const bool state)
  {
   m_button_state=state;
//--- ���������� ����� �������� �������� �������� ���������
   m_icon.State(state);
   m_label.Color((state)? m_label_color : m_label_color_off);
   m_button.State(false);
   m_button.BackColor((state)? m_back_color : m_back_color_off);
   m_button.BorderColor((state)? m_border_color : m_border_color_off);
  }
//+------------------------------------------------------------------+
//| ������� �� ������                                                |
//+------------------------------------------------------------------+
bool CIconButton::OnClickButton(const string clicked_object)
  {
//--- ���� �������� ����� "������ ��������"
   if(!m_only_icon)
     {
      //--- ������, ���� ����� ��� �������
      if(m_button.Name()!=clicked_object)
         return(false);
      //--- �����, ���� ������ �������������
      if(!m_button_state)
        {
         m_button.State(false);
         return(false);
        }
      //--- ���� ��� ���������������� ������
      if(!m_two_state)
        {
         m_button.State(false);
         m_button.BackColor(m_back_color);
         m_label.Color(m_label_color);
        }
      //--- ���� ��� ������ � ����� �����������
      else
        {
         if(m_button.State())
           {
            m_button.State(true);
            m_label.Color(m_label_color_pressed);
            m_button.BackColor(m_back_color_pressed);
            CElement::InitColorArray(m_back_color_pressed,m_back_color_pressed,m_back_color_array);
           }
         else
           {
            m_button.State(false);
            m_label.Color(m_label_color);
            m_button.BackColor(m_back_color);
            CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
           }
        }
     }
//--- ���� ����� "������ ��������" �������  
   else
     {
      //--- ������, ���� ����� ��� �������
      if(m_icon.Name()!=clicked_object)
         return(false);
      //--- ��������� ��������� On
      m_icon.State(true);
     }
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),CElement::Index(),m_label_text);
   return(true);
  }
//+------------------------------------------------------------------+
