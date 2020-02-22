//+------------------------------------------------------------------+
//|                                                       Slider.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� �������� � ����� �����                        |
//+------------------------------------------------------------------+
class CSlider : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ��������
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_edit;
   CSeparateLine     m_slot;
   CRectLabel        m_indicator;
   CRectLabel        m_thumb;
   //--- ���� ������ ����
   color             m_area_color;
   //--- ����� ��� �������� ��������
   string            m_label_text;
   //--- ����� ��������� ����� � ������ ����������
   color             m_label_color;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- ������� �������� � ���� �����
   double            m_edit_value;
   //--- ������� ���� �����
   int               m_edit_x_size;
   int               m_edit_y_size;
   //--- ����� ���� ����� � ������ ����������
   color             m_edit_color;
   color             m_edit_color_locked;
   //--- ����� ������ ���� ����� � ������ ����������
   color             m_edit_text_color;
   color             m_edit_text_color_locked;
   //--- ����� ����� ���� ����� � ������ ����������
   color             m_edit_border_color;
   color             m_edit_border_color_hover;
   color             m_edit_border_color_locked;
   color             m_edit_border_color_array[];
   //--- ������ �������
   int               m_slot_y_size;
   //--- ����� �������
   color             m_slot_line_dark_color;
   color             m_slot_line_light_color;
   //--- ����� ���������� � ������ ����������
   color             m_slot_indicator_color;
   color             m_slot_indicator_color_locked;
   //--- ������� �������� ��������
   int               m_thumb_x_size;
   int               m_thumb_y_size;
   //--- ����� �������� ��������
   color             m_thumb_color;
   color             m_thumb_color_hover;
   color             m_thumb_color_locked;
   color             m_thumb_color_pressed;
   //--- ���������� �� ������� ����� ������� ����
   int               m_zorder;
   int               m_area_zorder;
   int               m_edit_zorder;
   //--- (1) ����������� � (2) ������������ ��������, (3) ��� ��������� ��������
   double            m_min_value;
   double            m_max_value;
   double            m_step_value;
   //--- ���������� ������ ����� �������
   int               m_digits;
   //--- ����� ������������ ������
   ENUM_ALIGN_MODE   m_align_mode;
   //--- ��������� �������� (��������/������������)
   bool              m_slider_state;
   //--- ������� ������� �������� ��������: (1) ��������, (2) ���������� X
   double            m_current_pos;
   double            m_current_pos_x;
   //--- ���������� �������� � ������� �������
   int               m_pixels_total;
   //--- ���������� ����� � ��������� �������� ������� �������
   int               m_value_steps_total;
   //--- ������ ���� ������������ ������ ������� �������
   double            m_position_step;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //--- ��������� ������ ���� (������/������)
   ENUM_THUMB_MOUSE_STATE m_clamping_area_mouse;
   //--- ��� ����������� ������ ����������� �������� ��������
   bool              m_slider_thumb_state;
   //--- ���������� ��������� � ������������ ��������
   int               m_slider_size_fixing;
   int               m_slider_point_fixing;
   //---
public:
                     CSlider(void);
                    ~CSlider(void);
   //--- ������ ��� �������� ��������
   bool              CreateSlider(const long chart_id,const int subwin,const string text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateEdit(void);
   bool              CreateSlot(void);
   bool              CreateIndicator(void);
   bool              CreateThumb(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) �����������/��������� ��������� ��������
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);         }
   bool              SliderState(void)                        const { return(m_slider_state);             }
   void              SliderState(const bool state);
   //--- (1) ���� ����, (2) ����� ��������� �����
   void              AreaColor(const color clr)                     { m_area_color=clr;                   }
   void              LabelColor(const color clr)                    { m_label_color=clr;                  }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;            }
   void              LabelColorLocked(const color clr)              { m_label_color_locked=clr;           }
   //--- ������� (1) ���� ����� � (2) �������
   void              EditXSize(const int x_size)                    { m_edit_x_size=x_size;               }
   void              EditYSize(const int y_size)                    { m_edit_y_size=y_size;               }
   void              SlotYSize(const int y_size)                    { m_slot_y_size=y_size;               }
   //--- ����� ���� ����� � ������ ����������
   void              EditColor(const color clr)                     { m_edit_color=clr;                   }
   void              EditColorLocked(const color clr)               { m_edit_color_locked=clr;            }
   //--- ����� ������ ���� ����� � ������ ����������
   void              EditTextColor(const color clr)                 { m_edit_text_color=clr;              }
   void              EditTextColorLocked(const color clr)           { m_edit_text_color_locked=clr;       }
   //--- ����� ����� ���� ����� � ������ ����������
   void              EditBorderColor(const color clr)               { m_edit_border_color=clr;            }
   void              EditBorderColorHover(const color clr)          { m_edit_border_color_hover=clr;      }
   void              EditBorderColorLocked(const color clr)         { m_edit_border_color_locked=clr;     }
   //--- (1) Ҹ���� � (2) ������� ���� �������������� ����� (�������)
   void              SlotLineDarkColor(const color clr)             { m_slot_line_dark_color=clr;         }
   void              SlotLineLightColor(const color clr)            { m_slot_line_light_color=clr;        }
   //--- ����� ���������� �������� � ������ ����������
   void              SlotIndicatorColor(const color clr)            { m_slot_indicator_color=clr;         }
   void              SlotIndicatorColorLocked(const color clr)      { m_slot_indicator_color_locked=clr;  }
   //--- ������� �������� ��������
   void              ThumbXSize(const int x_size)                   { m_thumb_x_size=x_size;              }
   void              ThumbYSize(const int y_size)                   { m_thumb_y_size=y_size;              }
   //--- ����� �������� ��������
   void              ThumbColor(const color clr)                    { m_thumb_color=clr;                  }
   void              ThumbColorHover(const color clr)               { m_thumb_color_hover=clr;            }
   void              ThumbColorLocked(const color clr)              { m_thumb_color_locked=clr;           }
   void              ThumbColorPressed(const color clr)             { m_thumb_color_pressed=clr;          }
   //--- ����������� ��������
   double            MinValue(void)                           const { return(m_min_value);                }
   void              MinValue(const double value)                   { m_min_value=value;                  }
   //--- ������������ ��������
   double            MaxValue(void)                           const { return(m_max_value);                }
   void              MaxValue(const double value)                   { m_max_value=value;                  }
   //--- ��� ��������� ��������
   double            StepValue(void)                          const { return(m_step_value);               }
   void              StepValue(const double value)                  { m_step_value=(value<=0)? 1 : value; }
   //--- (1) ���������� ������ ����� �������, (2) ����� ������������ ������, (3) ����������� � ��������� �������� ���� �����
   void              SetDigits(const int digits)                    { m_digits=::fabs(digits);            }
   void              AlignMode(ENUM_ALIGN_MODE mode)                { m_align_mode=mode;                  }
   double            GetValue(void)                           const { return(m_edit_value);               }
   bool              SetValue(const double value);
   //--- ��������� �������� � ���� �����
   void              ChangeValue(const double value);
   //--- ��������� ����� ������� ��� ��������� �������
   void              ChangeObjectsColor(void);
   //--- ��������� ����� �������� ��������
   void              ChangeThumbColor(void);
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
   //--- ��������� ����� �������� � ���� �����
   bool              OnEndEdit(const string object_name);
   //--- ������� ����������� �������� ��������
   void              OnDragThumb(const int x);
   //--- ���������� ��������� �������� ��������
   void              UpdateThumb(const int new_x_point);
   //--- ��������� ��������� ������ ����
   void              CheckMouseButtonState(void);
   //--- ��������� ���������� ��������� � ������������ �������� ��������
   void              ZeroThumbVariables(void);
   //--- ������ �������� (���� � ������������)
   bool              CalculateCoefficients(void);
   //--- ������ ���������� X �������� ��������
   void              CalculateThumbX(void);
   //--- �������� ������� �������� �������� ������������ �������� ��������
   void              CalculateThumbPos(void);
   //--- ���������� ���������� ��������
   void              UpdateIndicator(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CSlider::CSlider(void) : m_digits(2),
                         m_edit_value(WRONG_VALUE),
                         m_align_mode(ALIGN_LEFT),
                         m_slider_state(true),
                         m_slider_thumb_state(false),
                         m_slider_size_fixing(0),
                         m_slider_point_fixing(0),
                         m_min_value(0),
                         m_max_value(10),
                         m_step_value(1),
                         m_current_pos(WRONG_VALUE),
                         m_area_color(C'15,15,15'),
                         m_label_color(clrWhite),
                         m_label_color_hover(C'85,170,255'),
                         m_label_color_locked(clrGray),
                         m_edit_x_size(30),
                         m_edit_y_size(18),
                         m_edit_color(clrWhite),
                         m_edit_color_locked(clrDimGray),
                         m_edit_text_color(clrBlack),
                         m_edit_text_color_locked(clrGray),
                         m_edit_border_color(clrGray),
                         m_edit_border_color_hover(C'85,170,255'),
                         m_edit_border_color_locked(clrGray),
                         m_slot_y_size(3),
                         m_slot_line_dark_color(C'65,65,65'),
                         m_slot_line_light_color(clrGray),
                         m_slot_indicator_color(clrDodgerBlue),
                         m_slot_indicator_color_locked(clrDimGray),
                         m_thumb_x_size(6),
                         m_thumb_y_size(14),
                         m_thumb_color(C'170,170,170'),
                         m_thumb_color_hover(C'200,200,200'),
                         m_thumb_color_locked(clrGray),
                         m_thumb_color_pressed(C'230,230,230')
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder      =0;
   m_area_zorder =1;
   m_edit_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSlider::~CSlider(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CSlider::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- �������� ������ ��� ����������
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_thumb.MouseFocus(x>m_thumb.X() && x<m_thumb.X2() && 
                         y>m_thumb.Y() && y<m_thumb.Y2());
      //--- �����, ���� ������� ������������
      if(!m_slider_state)
         return;
      //--- �������� � �������� ��������� ������ ����
      CheckMouseButtonState();
      //--- ������� ���� �������� ��������
      ChangeThumbColor();
      //--- ���� ���������� �������� ������ ��������, ��������� � ���������
      if(m_clamping_area_mouse==THUMB_PRESSED_INSIDE)
        {
         //--- ����������� �������� ��������
         OnDragThumb(x);
         //--- ������ ������� �������� �������� � ��������� ��������
         CalculateThumbPos();
         //--- ��������� ������ �������� � ���� �����
         ChangeValue(m_current_pos);
         //--- ��������� ��������� ��������
         UpdateIndicator();
         return;
        }
     }
//--- ��������� ������� ��������� �������� � ���� �����
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      //--- ��������� ����� ��������
      if(OnEndEdit(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CSlider::OnEventTimer(void)
  {
//--- ���� ������� ����������
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- ���� ����� � ������� �� �������������
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� � ����� �����                                    |
//+------------------------------------------------------------------+
bool CSlider::CreateSlider(const long chart_id,const int subwin,const string text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� �������� ������ ����� �������� "
              "��������� �� �����: CSlider::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =x;
   m_y          =y;
   m_label_text =text;
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateEdit())
      return(false);
   if(!CreateSlot())
      return(false);
   if(!CreateIndicator())
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
//| ������ ������� �������������� ���� �����                        |
//+------------------------------------------------------------------+
bool CSlider::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_slider_area_"+(string)CElement::Id();
//--- ��������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� ��������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- �������� ����������
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- �������
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
//--- ������� �� ������� �����
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� �������������� ���� �����                          |
//+------------------------------------------------------------------+
bool CSlider::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_slider_lable_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X();
   int y=CElement::Y()+5;
//--- ��������� ������
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
//--- �������� ����������
   m_area.X(x);
   m_area.Y(y);
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
//| ������ ���� ����� � ���������������                             |
//+------------------------------------------------------------------+
bool CSlider::CreateEdit(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_slider_edit_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X2()-m_edit_x_size;
   int y=CElement::Y()+3;
//--- ��������� ������
   if(!m_edit.Create(m_chart_id,name,m_subwin,x,y,m_edit_x_size,m_edit_y_size))
      return(false);
//--- ��������� ��������
   m_edit.Font(FONT);
   m_edit.FontSize(FONT_SIZE);
   m_edit.TextAlign(m_align_mode);
   m_edit.Description(::DoubleToString(m_edit_value,m_digits));
   m_edit.Color(m_edit_text_color);
   m_edit.BorderColor(m_edit_border_color);
   m_edit.BackColor(m_edit_color);
   m_edit.Corner(m_corner);
   m_edit.Anchor(m_anchor);
   m_edit.Selectable(false);
   m_edit.Z_Order(m_edit_zorder);
   m_edit.Tooltip("\n");
//--- �������� ����������
   m_edit.X(x);
   m_edit.Y(y);
//--- �������
   m_edit.XSize(m_edit_x_size);
   m_edit.YSize(m_edit_y_size);
//--- ������� �� ������� �����
   m_edit.XGap(x-m_wnd.X());
   m_edit.YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ��� ������ ���������                             |
//+------------------------------------------------------------------+
bool CSlider::CreateSlot(void)
  {
//--- �������� ��������� �����
   m_slot.WindowPointer(m_wnd);
//--- ��������� ��������
   m_slot.TypeSepLine(H_SEP_LINE);
   m_slot.DarkColor(m_slot_line_dark_color);
   m_slot.LightColor(m_slot_line_light_color);
//--- �������� �������������� �����
   if(!m_slot.CreateSeparateLine(m_chart_id,m_subwin,0,CElement::X(),CElement::Y()+30,CElement::XSize(),m_slot_y_size))
      return(false);
//--- �������� ��������� �������
   CElement::AddToArray(m_slot.Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ������ ���������                               |
//+------------------------------------------------------------------+
bool CSlider::CreateIndicator(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_slider_indicator_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X();
   int y=m_slot.Y()+1;
//--- ������
   int y_size=m_slot_y_size-2;
//--- ��������� ������
   if(!m_indicator.Create(m_chart_id,name,m_subwin,x,y,m_x_size,y_size))
      return(false);
//--- ��������� ��������
   m_indicator.BackColor(m_slot_indicator_color);
   m_indicator.Color(m_slot_indicator_color);
   m_indicator.BorderType(BORDER_FLAT);
   m_indicator.Corner(m_corner);
   m_indicator.Selectable(false);
   m_indicator.Z_Order(m_zorder);
   m_indicator.Tooltip("\n");
//--- �������� ����������
   m_indicator.X(x);
   m_indicator.Y(y);
//--- �������
   m_indicator.XSize(CElement::XSize());
   m_indicator.YSize(y_size);
//--- ������� �� ������� �����
   m_indicator.XGap(x-m_wnd.X());
   m_indicator.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_indicator);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ��������                                        |
//+------------------------------------------------------------------+
bool CSlider::CreateThumb(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_slider_thumb_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X();
   int y=m_slot.Y()-((m_thumb_y_size-m_slot_y_size)/2);
//--- ��������� ������
   if(!m_thumb.Create(m_chart_id,name,m_subwin,x,y,m_thumb_x_size,m_thumb_y_size))
      return(false);
//--- ��������� ��������
   m_thumb.Color(m_thumb_color);
   m_thumb.BackColor(m_thumb_color);
   m_thumb.BorderType(BORDER_FLAT);
   m_thumb.Corner(m_corner);
   m_thumb.Selectable(false);
   m_thumb.Z_Order(m_zorder);
   m_thumb.Tooltip("\n");
//--- �������� ������� (� �������)
   m_thumb.XSize(m_thumb.X_Size());
   m_thumb.YSize(m_thumb.Y_Size());
//--- �������� ����������
   m_thumb.X(x);
   m_thumb.Y(y);
//--- ������� �� ������� �����
   m_thumb.XGap(x-m_wnd.X());
   m_thumb.YGap(y-m_wnd.Y());
//--- ������ �������� ��������������� ����������
   CalculateCoefficients();
//--- ������ ���������� X �������� ������������ �������� �������� � ���� �����
   CalculateThumbX();
//--- ������ ������� �������� �������� � ��������� ��������
   CalculateThumbPos();
//--- ��������� ��������� ��������
   UpdateIndicator();
//--- �������� ��������� �������
   CElement::AddToArray(m_thumb);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ��������                                     |
//+------------------------------------------------------------------+
void CSlider::SliderState(const bool state)
  {
//--- ��������� ��������
   m_slider_state=state;
//--- ���� ��������� �����
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- ���� ���� �����
   m_edit.Color((state)? m_edit_text_color : m_edit_text_color_locked);
   m_edit.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_edit.BorderColor((state)? m_edit_border_color : m_edit_border_color_locked);
//--- ���� ����������
   m_indicator.BackColor((state)? m_slot_indicator_color : m_slot_indicator_color_locked);
   m_indicator.Color((state)? m_slot_indicator_color : m_slot_indicator_color_locked);
//--- ���� �������� ��������
   m_thumb.BackColor((state)? m_thumb_color : m_thumb_color_locked);
   m_thumb.Color((state)? m_thumb_color : m_thumb_color_locked);
//--- ��������� ������������ �������� ���������
   if(!m_slider_state)
      //--- ���� ����� � ����� "������ ������"
      m_edit.ReadOnly(true);
   else
//--- ���� ����� � ����� ��������������
      m_edit.ReadOnly(false);
  }
//+------------------------------------------------------------------+
//| ��������� �������� ��������                                      |
//+------------------------------------------------------------------+
bool CSlider::SetValue(const double value)
  {
//--- ������������� � ������ ����
   double corrected_value=::MathRound(value/m_step_value)*m_step_value;
//--- �������� �� �������/��������
   if(corrected_value<=m_min_value)
      corrected_value=m_min_value;
   if(corrected_value>=m_max_value)
      corrected_value=m_max_value;
//--- ���� �������� ���� ��������
   if(m_edit_value!=corrected_value)
     {
      m_edit_value=corrected_value;
      return(true);
     }
//--- �������� ��� ���������
   return(false);
  }
//+------------------------------------------------------------------+
//| ��������� �������� � ���� �����                                  |
//+------------------------------------------------------------------+
void CSlider::ChangeValue(const double value)
  {
//--- ��������, ������������� � �������� ����� ��������
   SetValue(value);
//--- ��������� ����� �������� � ���� �����
   m_edit.Description(::DoubleToString(GetValue(),m_digits));
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CSlider::ChangeObjectsColor(void)
  {
//--- �����, ���� ������� ������������ ��� � ������ ����������� �������� ��������
   if(!m_slider_state || m_slider_thumb_state)
      return;
//---
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_edit.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������ ���������                                 |
//+------------------------------------------------------------------+
void CSlider::ChangeThumbColor(void)
  {
//--- �����, ���� ����� ������������� � ������������� ��������� � ������� ������ �������� ����������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- ���� ������ � ���� �������� ��������
   if(m_thumb.MouseFocus())
     {
      //--- ���� ����� ������ ���� ������
      if(m_clamping_area_mouse==THUMB_NOT_PRESSED)
        {
         m_slider_thumb_state=false;
         m_thumb.Color(m_thumb_color_hover);
         m_thumb.BackColor(m_thumb_color_hover);
        }
      //--- ����� ������ ���� ������
      else if(m_clamping_area_mouse==THUMB_PRESSED_INSIDE)
        {
         m_slider_thumb_state=true;
         m_thumb.Color(m_thumb_color_pressed);
         m_thumb.BackColor(m_thumb_color_pressed);
        }
     }
//--- ���� ������ ��� ���� ������ ���������
   else
     {
      //--- ����� ������ ���� ������
      if(!m_mouse_state)
        {
         m_slider_thumb_state=false;
         m_thumb.Color(m_thumb_color);
         m_thumb.BackColor(m_thumb_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CSlider::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� �������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_edit.X(x+m_edit.XGap());
   m_edit.Y(y+m_edit.YGap());
   m_indicator.X(x+m_indicator.XGap());
   m_indicator.Y(y+m_indicator.YGap());
   m_thumb.X(x+m_thumb.XGap());
   m_thumb.Y(y+m_thumb.YGap());
//--- ���������� ��������� ����������� ��������  
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_edit.X_Distance(m_edit.X());
   m_edit.Y_Distance(m_edit.Y());
   m_indicator.X_Distance(m_indicator.X());
   m_indicator.Y_Distance(m_indicator.Y());
   m_thumb.X_Distance(m_thumb.X());
   m_thumb.Y_Distance(m_thumb.Y());
//--- ����������� �������
   m_slot.Moving(x,y);
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CSlider::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- �������� �������
   m_slot.Show();
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CSlider::Hide(void)
  {
//--- �����, ���� ������� ��� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ �������
   m_slot.Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CSlider::Reset(void)
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
void CSlider::Delete(void)
  {
//--- �������� ��������  
   m_area.Delete();
   m_label.Delete();
   m_edit.Delete();
   m_slot.Delete();
   m_indicator.Delete();
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
void CSlider::SetZorders(void)
  {
//--- �����, ���� ������� ������������
   if(!m_slider_state)
      return;
//--- ��������� �������� �� ���������
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_zorder);
   m_edit.Z_Order(m_edit_zorder);
   m_indicator.Z_Order(m_zorder);
   m_thumb.Z_Order(m_zorder);
//--- ���� ����� � ����� ��������������
   m_edit.ReadOnly(false);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CSlider::ResetZorders(void)
  {
//--- �����, ���� ������� ������������
   if(!m_slider_state)
      return;
//--- ��������� �����������
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_edit.Z_Order(0);
   m_indicator.Z_Order(0);
   m_thumb.Z_Order(0);
//--- ���� ����� � ����� "������ ������"
   m_edit.ReadOnly(true);
  }
//+------------------------------------------------------------------+
//| ����� ����� �������� ��������                                    |
//+------------------------------------------------------------------+
void CSlider::ResetColors(void)
  {
//--- �����, ���� ������� ������������
   if(!m_slider_state)
      return;
//--- �������� ����
   m_label.Color(m_label_color);
   m_edit.BorderColor(m_edit_border_color);
//--- ������� �����
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ��������� ����� �������� � ���� �����                            |
//+------------------------------------------------------------------+
bool CSlider::OnEndEdit(const string object_name)
  {
//--- ������, ���� ����� ��� �������
   if(object_name!=m_edit.Name())
      return(false);
//--- ������� ������ ��� �������� ��������
   double entered_value=::StringToDouble(m_edit.Description());
//--- ��������, ������������� � �������� ����� ��������
   ChangeValue(entered_value);
//--- ���������� ���������� X ��������
   CalculateThumbX();
//--- ���������� ������� � ��������� ��������
   CalculateThumbPos();
//--- ��������� ��������� ��������
   UpdateIndicator();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ����������� �������� ��������                            |
//+------------------------------------------------------------------+
void CSlider::OnDragThumb(const int x)
  {
//--- ��� ����������� ����� X ����������
   int new_x_point=0;
//--- ���� �������� �������� ���������, ...
   if(!m_slider_thumb_state)
     {
      //--- ...������� ��������������� ���������� ��� ����������� ��������
      m_slider_point_fixing =0;
      m_slider_size_fixing  =0;
      return;
     }
//--- ���� ����� �������� �������, �� �������� ������� ���������� �������
   if(m_slider_point_fixing==0)
      m_slider_point_fixing=x;
//--- ���� �������� ���������� �� ������� ����� �������� �� ������� ���������� ������� �������, ���������� ���
   if(m_slider_size_fixing==0)
      m_slider_size_fixing=m_thumb.X()-x;
//--- ���� � ������� ��������� ������ ����� ������
   if(x-m_slider_point_fixing>0)
     {
      //--- ���������� ���������� X
      new_x_point=x+m_slider_size_fixing;
      //--- ���������� ��������� ������ ���������
      UpdateThumb(new_x_point);
      return;
     }
//--- ���� � ������� ��������� ������ ����� �����
   if(x-m_slider_point_fixing<0)
     {
      //--- ���������� ���������� X
      new_x_point=x-::fabs(m_slider_size_fixing);
      //--- ���������� ��������� ������ ���������
      UpdateThumb(new_x_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| ���������� ��������� �������� ��������                           |
//+------------------------------------------------------------------+
void CSlider::UpdateThumb(const int new_x_point)
  {
   int x=new_x_point;
//--- ��������� ����� ��������
   m_slider_point_fixing=0;
//--- �������� �� ����� �� ������� �������
   if(new_x_point>m_area.X2()-m_thumb.XSize())
      x=m_area.X2()-m_thumb.XSize();
   if(new_x_point<=m_area.X())
      x=m_area.X();
//--- ������� ������ � ������
   m_thumb.X(x);
   m_thumb.X_Distance(x);
//--- �������� �������
   m_thumb.XGap(m_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| ���������� ���������� ��������                                   |
//+------------------------------------------------------------------+
void CSlider::UpdateIndicator(void)
  {
//--- ���������� ������
   int x_size=m_thumb.X()-m_indicator.X();
//--- ������������� � ������ ������������ ��������
   if(x_size<=0)
      x_size=1;
//--- ��������� ������ �������
   m_indicator.X_Size(x_size);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������ ����                                  |
//+------------------------------------------------------------------+
void CSlider::CheckMouseButtonState(void)
  {
//--- ���� ����� ������ ���� ������
   if(!m_mouse_state)
     {
      //--- ������� ����������
      ZeroThumbVariables();
      return;
     }
//--- ���� ����� ������ ���� ������
   else
     {
      //--- ������, ���� ������ ��� ������ � �����-���� �������
      if(m_clamping_area_mouse!=THUMB_NOT_PRESSED)
         return;
      //--- ��� ������� �������� ��������
      if(!m_thumb.MouseFocus())
         m_clamping_area_mouse=THUMB_PRESSED_OUTSIDE;
      //--- � ������� �������� ��������
      else
        {
         m_clamping_area_mouse=THUMB_PRESSED_INSIDE;
         //--- ����������� ����� � �������� ������������� ��������� ��������
         m_wnd.IsLocked(true);
         m_wnd.IdActivatedElement(CElement::Id());
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ���������� ��������� � ������������ ������ ���������   |
//+------------------------------------------------------------------+
void CSlider::ZeroThumbVariables(void)
  {
//--- ���� ����� ����, �� ��� ������, ��� ����� ������ ���� ������.
//    ���� �� ����� ������� ����� ������ ���� ���� ������������ ��� ��������� ��������...
   if(m_clamping_area_mouse==THUMB_PRESSED_INSIDE)
     {
      //--- ... �������� ���������, ��� ��������� �������� � ���� ����� ����������� �������� ���������
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),CElement::Index(),m_label.Description());
     }
//---
   m_slider_size_fixing  =0;
   m_clamping_area_mouse =THUMB_NOT_PRESSED;
//--- ���� ������������� �������� ��������� � ��������������� �����������,
//    ������������ ����� � ������� ������������� ��������� ��������
   if(CElement::Id()==m_wnd.IdActivatedElement())
     {
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
  }
//+------------------------------------------------------------------+
//| ������ �������� (���� � ������������)                            |
//+------------------------------------------------------------------+
bool CSlider::CalculateCoefficients(void)
  {
//--- �����, ���� ������ �������� ������, ��� ������ �������� ��������
   if(CElement::XSize()<m_thumb_x_size)
      return(false);
//--- ���������� �������� � ������� �������
   m_pixels_total=CElement::XSize()-m_thumb_x_size;
//--- ���������� ����� � ��������� �������� ������� �������
   m_value_steps_total=int((m_max_value-m_min_value)/m_step_value);
//--- ������ ���� ������������ ������ ������� �������
   m_position_step=m_step_value*(double(m_value_steps_total)/double(m_pixels_total));
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���������� X �������� ��������                            |
//+------------------------------------------------------------------+
void CSlider::CalculateThumbX(void)
  {
//--- ������������� � ������ ����, ��� ����������� �������� ����� ���� �������������
   double neg_range=(m_min_value<0)? ::fabs(m_min_value/m_position_step) : 0;
//--- ���������� ���������� X ��� �������� ��������
   m_current_pos_x=m_area.X()+(m_edit_value/m_position_step)+neg_range;
//--- ���� ������� �� ������� ������� ������� �����
   if(m_current_pos_x<m_area.X())
      m_current_pos_x=m_area.X();
//--- ���� ������� �� ������� ������� ������� ������
   if(m_current_pos_x+m_thumb.XSize()>m_area.X2())
      m_current_pos_x=m_area.X2()-m_thumb.XSize();
//--- �������� � ��������� ����� ���������� X
   m_thumb.X(int(m_current_pos_x));
   m_thumb.X_Distance(int(m_current_pos_x));
   m_thumb.XGap(m_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| ������ ������� �������� �������� � ��������� ��������            |
//+------------------------------------------------------------------+
void CSlider::CalculateThumbPos(void)
  {
//--- ������� ����� ������� �������� ��������
   m_current_pos=(m_thumb.X()-m_area.X())*m_position_step;
//--- ������������� � ������ ����, ��� ����������� �������� ����� ���� �������������
   if(m_min_value<0 && m_current_pos_x!=WRONG_VALUE)
      m_current_pos+=int(m_min_value);
//--- �������� �� ����� �� ������� ������� ������/�����
   if(m_thumb.X2()>=m_area.X2())
      m_current_pos=int(m_max_value);
   if(m_thumb.X()<=m_area.X())
      m_current_pos=int(m_min_value);
  }
//+------------------------------------------------------------------+
