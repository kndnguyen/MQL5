//+------------------------------------------------------------------+
//|                                                 SimpleButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������� ������                                |
//+------------------------------------------------------------------+
class CSimpleButton : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������ ��� �������� ������
   CButton           m_button;
   //--- �������� ������:
   //    (1) �����, (2) �������
   string            m_button_text;
   int               m_button_x_size;
   int               m_button_y_size;
   //--- ���� ����
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   color             m_back_color_array[];
   //--- ���� �����
   color             m_border_color;
   color             m_border_color_off;
   //--- ���� ������
   color             m_text_color;
   color             m_text_color_off;
   color             m_text_color_pressed;
   //--- ��������� �� ������� ����� ������� ����
   int               m_button_zorder;
   //--- ����� ���� ��������� ������
   bool              m_two_state;
   //--- ��������/������������
   bool              m_button_state;
   //---
public:
                     CSimpleButton(void);
                    ~CSimpleButton(void);
   //--- ������ ��� �������� ������� ������
   bool              CreateSimpleButton(const long chart_id,const int subwin,const string button_text,const int x,const int y);
   //---
private:
   bool              CreateButton(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ������ ������,
   //    (3) ����� ��������� ������ (��������/������������)
   void              WindowPointer(CWindow &object)          { m_wnd=::GetPointer(object);     }
   void              TwoState(const bool flag)               { m_two_state=flag;               }
   bool              IsPressed(void)                   const { return(m_button.State());       }
   bool              ButtonState(void)                 const { return(m_button_state);         }
   void              ButtonState(const bool state);
   //--- ������ ������
   void              ButtonXSize(const int x_size)           { m_button_x_size=x_size;         }
   void              ButtonYSize(const int y_size)           { m_button_y_size=y_size;         }
   //--- (1) ���������� ����� ������, (2) ��������� ����� ������ ������
   string            Text(void)                        const { return(m_button.Description()); }
   void              TextColor(const color clr)              { m_text_color=clr;               }
   void              TextColorOff(const color clr)           { m_text_color_off=clr;           }
   void              TextColorPressed(const color clr)       { m_text_color_pressed=clr;       }
   //--- ��������� ����� ���� ������
   void              BackColor(const color clr)              { m_back_color=clr;               }
   void              BackColorOff(const color clr)           { m_back_color_off=clr;           }
   void              BackColorHover(const color clr)         { m_back_color_hover=clr;         }
   void              BackColorPressed(const color clr)       { m_back_color_pressed=clr;       }
   //--- ��������� ����� ����� ������
   void              BorderColor(const color clr)            { m_border_color=clr;             }
   void              BorderColorOff(const color clr)         { m_border_color_off=clr;         }

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
CSimpleButton::CSimpleButton(void) : m_button_state(true),
                                     m_two_state(false),
                                     m_button_x_size(50),
                                     m_button_y_size(22),
                                     m_text_color(clrBlack),
                                     m_text_color_off(clrDarkGray),
                                     m_text_color_pressed(clrWhite),
                                     m_back_color(clrSilver),
                                     m_back_color_off(clrLightGray),
                                     m_back_color_hover(clrLightGray),
                                     m_back_color_pressed(C'153,178,215'),
                                     m_border_color(clrWhite),
                                     m_border_color_off(clrWhite)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ��������� �� ������� ����� ������ ����
   m_button_zorder=1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSimpleButton::~CSimpleButton(void)
  {
  }
//+------------------------------------------------------------------+
//| ��������� �������                                                |
//+------------------------------------------------------------------+
void CSimpleButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- �����, ���� ����� �������������
      if(m_wnd.IsLocked())
         return;
      //--- �����, ���� ������ ���� ������
      if(sparam=="0")
         return;
      //--- �����, ���� ������ �������������
      if(!m_button_state)
         return;
      //--- ���� ��� ������
      if(!CElement::MouseFocus())
        {
         //--- ���� ������ ������
         if(!m_button.State())
           {
            m_button.Color(m_text_color);
            m_button.BackColor(m_back_color);
           }
         //---
         return;
        }
      //--- ���� ���� �����
      else
        {
         m_button.Color(m_text_color_pressed);
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
void CSimpleButton::OnEventTimer(void)
  {
//--- ���� ������� �������� ����������
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- ���� ����� �� �������������
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������ ������                                            |
//+------------------------------------------------------------------+
bool CSimpleButton::CreateSimpleButton(const long chart_id,const int subwin,const string button_text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ������ ����� �������� "
              "��������� �� �����: CSimpleButton::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id          =m_wnd.LastId()+1;
   m_chart_id    =chart_id;
   m_subwin      =subwin;
   m_x           =x;
   m_y           =y;
   m_button_text =button_text;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ������
   if(!CreateButton())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������                                                   |
//+------------------------------------------------------------------+
bool CSimpleButton::CreateButton(void)
  {
//--- ������������ ����� �������
   string name="";
//--- ���� ������ �� �����
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_simple_button_"+(string)CElement::Id();
//--- ���� ������ �����
   else
      name=CElement::ProgramName()+"_simple_button_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ��������� ������
   if(!m_button.Create(m_chart_id,name,m_subwin,m_x,m_y,m_button_x_size,m_button_y_size))
      return(false);
//--- ��������� ��������
   m_button.Font(FONT);
   m_button.FontSize(FONT_SIZE);
   m_button.Color(m_text_color);
   m_button.Description(m_button_text);
   m_button.BackColor(m_back_color);
   m_button.BorderColor(m_border_color);
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
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CSimpleButton::ChangeObjectsColor(void)
  {
   ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
  }
//+------------------------------------------------------------------+
//| ���������� ����                                                  |
//+------------------------------------------------------------------+
void CSimpleButton::ResetColors(void)
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
//| ��������� ��������� ������                                       |
//+------------------------------------------------------------------+
void CSimpleButton::ButtonState(const bool state)
  {
   m_button_state=state;
   m_button.State(false);
   m_button.Color((state)? m_text_color : m_text_color_off);
   m_button.BackColor((state)? m_back_color : m_back_color_off);
   m_button.BorderColor((state)? m_border_color : m_border_color_off);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CSimpleButton::Moving(const int x,const int y)
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
//--- ���������� ��������� ����������� ��������
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CSimpleButton::SetZorders(void)
  {
   m_button.Z_Order(m_button_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CSimpleButton::ResetZorders(void)
  {
   m_button.Z_Order(-1);
  }
//+------------------------------------------------------------------+
//| ���������� ������                                                |
//+------------------------------------------------------------------+
void CSimpleButton::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   m_button.Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ������                                                  |
//+------------------------------------------------------------------+
void CSimpleButton::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   m_button.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CSimpleButton::Reset(void)
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
void CSimpleButton::Delete(void)
  {
//--- �������� ��������
   m_button.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������                                      |
//+------------------------------------------------------------------+
bool CSimpleButton::OnClickButton(const string clicked_object)
  {
//--- �������� �� ����� �������
   if(m_button.Name()!=clicked_object)
      return(false);
//--- ���� ������ �������������
   if(!m_button_state)
     {
      m_button.State(false);
      return(false);
     }
//--- ���� ����� ������ � ����� ����������
   if(!m_two_state)
     {
      m_button.State(false);
      m_button.Color(m_text_color);
      m_button.BackColor(m_back_color);
     }
//--- ���� ����� ������ � ����� �����������
   else
     {
      //--- ���� ������ ������
      if(m_button.State())
        {
         //--- ������� ����� ������ 
         m_button.State(true);
         m_button.Color(m_text_color_pressed);
         m_button.BackColor(m_back_color_pressed);
         CElement::InitColorArray(m_back_color_pressed,m_back_color_pressed,m_back_color_array);
        }
      //--- ���� ������ ������
      else
        {
         //--- ������� ����� ������ 
         m_button.State(false);
         m_button.Color(m_text_color);
         m_button.BackColor(m_back_color);
         CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
        }
     }
//--- ��������� ������ �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),CElement::Index(),m_button.Description());
   return(true);
  }
//+------------------------------------------------------------------+
