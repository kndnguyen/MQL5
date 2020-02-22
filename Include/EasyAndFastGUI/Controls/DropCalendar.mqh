//+------------------------------------------------------------------+
//|                                                 DropCalendar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Calendar.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ����������� ���������                         |
//+------------------------------------------------------------------+
class CDropCalendar : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� � �������� ��� �������� ��������
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_field;
   CEdit             m_drop_button;
   CBmpLabel         m_drop_button_icon;
   CCalendar         m_calendar;
   //--- ���� ����
   color             m_area_color;
   //--- ������������ �������� ��������
   string            m_label_text;
   //--- ����� ��������� ����� � ������ ����������
   color             m_label_color;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- ����� ���� ����� � ������ ����������
   color             m_edit_color;
   color             m_edit_color_locked;
   //--- ����� ����� �����-����� � ������ ����������
   color             m_border_color;
   color             m_border_color_hover;
   color             m_border_color_locked;
   color             m_border_color_array[];
   //--- ������� �����-�����
   int               m_combobox_x_size;
   int               m_combobox_y_size;
   //--- ������� ������ �����-�����
   int               m_button_x_size;
   int               m_button_y_size;
   //--- ����� ������ � ������ ����������
   color             m_button_color;
   color             m_button_color_hover;
   color             m_button_color_locked;
   color             m_button_color_pressed;
   color             m_button_color_array[];
   //--- ���� ������ � ���� �����-�����
   color             m_combobox_text_color;
   color             m_combobox_text_color_locked;
   //--- �������� ��� ������
   string            m_icon_file_on;
   string            m_icon_file_off;
   string            m_icon_file_locked;
   //--- ���������� �� ������� ����� ������ ����
   int               m_area_zorder;
   int               m_combobox_zorder;
   int               m_zorder;
   //--- ��������/������������
   bool              m_drop_calendar_state;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //---
public:
                     CDropCalendar(void);
                    ~CDropCalendar(void);
   //--- ������ ��� �������� ����������� ���������
   bool              CreateDropCalendar(const long chart_id,const int subwin,const string text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateEditBox(void);
   bool              CreateDropButton(void);
   bool              CreateDropButtonIcon(void);
   bool              CreateCalendar(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ��������� ���������, (3) �����������/��������� ��������� ��������
   void              WindowPointer(CWindow &object)          { m_wnd=::GetPointer(object);       }
   CCalendar        *GetCalendarPointer(void)                { return(::GetPointer(m_calendar)); }
   bool              DropCalendarState(void)           const { return(m_drop_calendar_state);    }
   void              DropCalendarState(const bool state);
   //--- (1) ������ ������ �����-����� �� ��� X, (2) ������� �����-�����
   void              ButtonXSize(const int x_size)           { m_button_x_size=x_size;           }
   void              ComboboxXSize(const int x_size)         { m_combobox_x_size=x_size;         }
   void              ComboboxYSize(const int y_size)         { m_combobox_y_size=y_size;         }
   //--- ��������� � ��������� ������������� ������ �������� ��������
   void              LabelText(const string text)            { m_label_text=text;                }
   string            LabelText(void)                   const { return(m_label.Description());    }
   //--- (1) ��������� ����� ����, (2) ����� ��������� ����� � ������ ����������
   void              AreaBackColor(const color clr)          { m_area_color=clr;                 }
   void              LabelColor(const color clr)             { m_label_color=clr;                }
   void              LabelColorHover(const color clr)        { m_label_color_hover=clr;          }
   void              LabelColorLocked(const color clr)       { m_label_color_locked=clr;         }
   //--- ����� ���� ����� � ������ ����������
   void              EditColor(const color clr)              { m_edit_color=clr;                 }
   void              EditColorLocked(const color clr)        { m_edit_color_locked=clr;          }
   //--- (1) ���� ������ �����-����� � ������ ����������, (2) ���� ������ � ���� �����-�����
   void              ButtonColor(const color clr)            { m_button_color=clr;               }
   void              ButtonColorHover(const color clr)       { m_button_color_hover=clr;         }
   void              ButtonColorLocked(const color clr)      { m_button_color_locked=clr;        }
   void              ButtonColorPressed(const color clr)     { m_button_color_pressed=clr;       }
   void              ComboboxTextColor(const color clr)      { m_combobox_text_color=clr;        }
   //--- (1) ���� ����� ������ �����-����� � ������ ����������
   void              BorderColor(const color clr)            { m_border_color=clr;               }
   void              BorderColorHover(const color clr)       { m_border_color_hover=clr;         }
   void              BorderColorLocked(const color clr)      { m_border_color_locked=clr;        }
   //--- ��������� ������� ��� ������ � �������� � ��������������� ����������
   void              IconFileOn(const string file_path)      { m_icon_file_on=file_path;         }
   void              IconFileOff(const string file_path)     { m_icon_file_off=file_path;        }
   void              IconFileLocked(const string file_path)  { m_icon_file_locked=file_path;     }
   //--- (1) ���������� (��������) � (2) �������� ���������� ����
   void              SelectedDate(const datetime date);
   datetime          SelectedDate(void) { return(m_calendar.SelectedDate()); }
   //--- ��������� ����� ��������
   void              ChangeObjectsColor(void);
   //--- ��������� ��������� ��������� ��������� �� ���������������
   void              ChangeComboBoxCalendarState(void);
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
   //--- ��������� ������� �� ������ �����-�����
   bool              OnClickButton(const string clicked_object);
   //--- �������� ������� ����� ������ ���� ��� ������� �����-�����
   void              CheckPressedOverButton(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CDropCalendar::CDropCalendar(void) : m_drop_calendar_state(true),
                                     m_button_x_size(32),
                                     m_button_y_size(20),
                                     m_combobox_x_size(100),
                                     m_combobox_y_size(20),
                                     m_area_color(C'15,15,15'),
                                     m_label_text("Drop calendar: "),
                                     m_label_color(clrBlack),
                                     m_label_color_hover(C'85,170,255'),
                                     m_label_color_locked(clrSilver),
                                     m_edit_color(clrWhite),
                                     m_edit_color_locked(clrWhiteSmoke),
                                     m_border_color(clrSilver),
                                     m_border_color_hover(C'85,170,255'),
                                     m_border_color_locked(clrSilver),
                                     m_button_color(C'220,220,220'),
                                     m_button_color_hover(C'193,218,255'),
                                     m_button_color_locked(C'230,230,230'),
                                     m_button_color_pressed(C'153,178,215'),
                                     m_combobox_text_color(clrBlack),
                                     m_combobox_text_color_locked(clrSilver),
                                     m_icon_file_on(""),
                                     m_icon_file_off(""),
                                     m_icon_file_locked("")

  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_area_zorder     =1;
   m_combobox_zorder =2;
   m_zorder          =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CDropCalendar::~CDropCalendar(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CDropCalendar::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_drop_button.MouseFocus(x>m_drop_button.X() && x<m_drop_button.X2() && 
                               y>m_drop_button.Y() && y<m_drop_button.Y2());
      //--- �������� ������� ����� ������ ���� ��� ������� �����-�����
      CheckPressedOverButton();
      return;
     }
//--- ��������� ������� ������ ����� ���� � ���������
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_DATE)
     {
      //--- �����, ���� �������������� ��������� �� ���������
      if(lparam!=CElement::Id())
         return;
      //--- ��������� ����� ���� � ���� �����-�����
      m_field.Description(::TimeToString((datetime)dparam,TIME_DATE));
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ������� �� ������ �����-�����
      if(OnClickButton(sparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CDropCalendar::OnEventTimer(void)
  {
//--- ���� ������� ����������
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- ����������� ��������� �����, ������ ���� ����� �� �������������
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ���������� ���������                                     |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateDropCalendar(const long chart_id,const int subwin,const string text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ����������� ��������� ������ ����� �������� "
              "��������� �� �����: CDropCalendar::WindowPointer(CWindow &object).");
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
   if(!CreateEditBox())
      return(false);
   if(!CreateDropButton())
      return(false);
   if(!CreateDropButtonIcon())
      return(false);
   if(!CreateCalendar())
      return(false);
//--- ������ ���������
   m_calendar.Hide();
//--- ���������� ���������� ���� � ���������
   m_field.Description(::TimeToString((datetime)m_calendar.SelectedDate(),TIME_DATE));
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� �����-�����                                      |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_dc_combobox_area_"+(string)CElement::Id();
//--- ��������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_button_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
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
//| ������ ����� �����-�����                                        |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_dc_combobox_lable_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X();
   int y=CElement::Y()+2;
//--- ��������� ������
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
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
//| ������ ���� ����� ���� � �������                                |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateEditBox(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_dc_combobox_edit_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X()+CElement::XSize()-m_combobox_x_size;
   int y =CElement::Y()-1;
//--- ��������� ������
   if(!m_field.Create(m_chart_id,name,m_subwin,x,y,m_combobox_x_size,m_combobox_y_size))
      return(false);
//--- ��������� �������
   m_field.Font(FONT);
   m_field.FontSize(FONT_SIZE);
   m_field.Color(m_combobox_text_color);
   m_field.Description("");
   m_field.BorderColor(m_border_color);
   m_field.BackColor(m_edit_color);
   m_field.Corner(m_corner);
   m_field.Anchor(m_anchor);
   m_field.Selectable(false);
   m_field.Z_Order(m_combobox_zorder);
   m_field.ReadOnly(true);
   m_field.Tooltip("\n");
//--- �������� ����������
   m_field.X(x);
   m_field.Y(y);
//--- �������� �������
   m_field.XSize(m_combobox_x_size);
   m_field.YSize(m_combobox_y_size);
//--- ������� �� ������� �����
   m_field.XGap(x-m_wnd.X());
   m_field.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_field);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ �����-�����                                       |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateDropButton(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_dc_combobox_button_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X()+CElement::XSize()-m_button_x_size;
   int y =CElement::Y()-1;
//--- ��������� ������
   if(!m_drop_button.Create(m_chart_id,name,m_subwin,x,y,m_button_x_size,m_combobox_y_size))
      return(false);
//--- ��������� �������
   m_drop_button.Font(FONT);
   m_drop_button.FontSize(FONT_SIZE);
   m_drop_button.Color(m_combobox_text_color);
   m_drop_button.Description("");
   m_drop_button.BorderColor(m_border_color);
   m_drop_button.BackColor(m_button_color);
   m_drop_button.Corner(m_corner);
   m_drop_button.Anchor(m_anchor);
   m_drop_button.Selectable(false);
   m_drop_button.Z_Order(m_combobox_zorder);
   m_drop_button.ReadOnly(true);
   m_drop_button.Tooltip("\n");
//--- �������� ����������
   m_drop_button.X(x);
   m_drop_button.Y(y);
//--- �������� �������
   m_drop_button.XSize(m_button_x_size);
   m_drop_button.YSize(m_combobox_y_size);
//--- ������� �� ������� �����
   m_drop_button.XGap(x-m_wnd.X());
   m_drop_button.YGap(y-m_wnd.Y());
//--- ������������� �������� ���������
   CElement::InitColorArray(m_border_color,m_border_color_hover,m_border_color_array);
   CElement::InitColorArray(m_button_color,m_button_color_hover,m_button_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_drop_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� �� ������ �����-�����                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_drop_on.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_drop_off.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_drop_locked.bmp"
//---
bool CDropCalendar::CreateDropButtonIcon(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_dc_combobox_icon_"+(string)CElement::Id();
//--- ����������
   int x=m_drop_button.X()+m_button_x_size-25;
   int y=CElement::Y()+1;
//--- ���� �������� �� ����������, ��������� �� ���������
   if(m_icon_file_on=="")
      m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\calendar_drop_on.bmp";
   if(m_icon_file_off=="")
      m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\calendar_drop_off.bmp";
   if(m_icon_file_locked=="")
      m_icon_file_locked="Images\\EasyAndFastGUI\\Controls\\calendar_drop_locked.bmp";
//--- ��������� ������
   if(!m_drop_button_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
   m_drop_button_icon.BmpFileOn("::"+m_icon_file_on);
   m_drop_button_icon.BmpFileOff("::"+m_icon_file_off);
   m_drop_button_icon.Corner(m_corner);
   m_drop_button_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_drop_button_icon.Selectable(false);
   m_drop_button_icon.Z_Order(m_zorder);
   m_drop_button_icon.Tooltip("\n");
//--- �������� ������� (� �������)
   m_drop_button_icon.XSize(m_drop_button_icon.X_Size());
   m_drop_button_icon.YSize(m_drop_button_icon.Y_Size());
//--- �������� ����������
   m_drop_button_icon.X(x);
   m_drop_button_icon.Y(y);
//--- ������� �� ������� �����
   m_drop_button_icon.XGap(x-m_wnd.X());
   m_drop_button_icon.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_drop_button_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������                                                   |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateCalendar(void)
  {
//--- �������� ������ ������
   m_calendar.WindowPointer(m_wnd);
//--- ����������
   int x=m_field.X();
   int y=m_field.Y2();
//--- ��������� ��������� ������� ����������� ��������
   m_calendar.IsDropdown(true);
//--- �������� ������� ����������
   if(!m_calendar.CreateCalendar(m_chart_id,m_subwin,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ���� � ���������                                 |
//+------------------------------------------------------------------+
void CDropCalendar::SelectedDate(const datetime date)
  {
//--- ��������� � �������� ����
   m_calendar.SelectedDate(date);
//--- ��������� ���� � ���� ����� �����-�����
   m_field.Description(::TimeToString(date,TIME_DATE));
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CDropCalendar::ChangeObjectsColor(void)
  {
//--- �����, ���� ������� ������������
   if(!m_drop_calendar_state)
      return;
//---
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_field.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
   CElement::ChangeObjectColor(m_drop_button.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
   CElement::ChangeObjectColor(m_drop_button.Name(),m_drop_button.MouseFocus(),OBJPROP_BGCOLOR,m_button_color,m_button_color_hover,m_button_color_array);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ��������                                     |
//+------------------------------------------------------------------+
void CDropCalendar::DropCalendarState(const bool state)
  {
   m_drop_calendar_state=state;
//--- ��������
   m_drop_button_icon.BmpFileOff((state)? "::"+m_icon_file_on : "::"+m_icon_file_locked);
//--- ���� ��������� �����
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- ����� ���� �����
   m_field.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_field.Color((state)? m_combobox_text_color : m_combobox_text_color_locked);
   m_field.BorderColor((state)? m_border_color : m_border_color_locked);
//--- ����� ������ �����-�����
   m_drop_button.BackColor((state)? m_button_color : m_button_color_locked);
   m_drop_button.BorderColor((state)? m_border_color : m_border_color_locked);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CDropCalendar::Moving(const int x,const int y)
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
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_field.X(x+m_field.XGap());
   m_field.Y(y+m_field.YGap());
   m_drop_button.X(x+m_drop_button.XGap());
   m_drop_button.Y(y+m_drop_button.YGap());
   m_drop_button_icon.X(x+m_drop_button_icon.XGap());
   m_drop_button_icon.Y(y+m_drop_button_icon.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_field.X_Distance(m_field.X());
   m_field.Y_Distance(m_field.Y());
   m_drop_button.X_Distance(m_drop_button.X());
   m_drop_button.Y_Distance(m_drop_button.Y());
   m_drop_button_icon.X_Distance(m_drop_button_icon.X());
   m_drop_button_icon.Y_Distance(m_drop_button_icon.Y());
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CDropCalendar::Show(void)
  {
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_label.Timeframes(OBJ_ALL_PERIODS);
   m_field.Timeframes(OBJ_ALL_PERIODS);
   m_drop_button.Timeframes(OBJ_ALL_PERIODS);
   m_drop_button_icon.Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CDropCalendar::Hide(void)
  {
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_label.Timeframes(OBJ_NO_PERIODS);
   m_field.Timeframes(OBJ_NO_PERIODS);
   m_drop_button.Timeframes(OBJ_NO_PERIODS);
   m_drop_button_icon.Timeframes(OBJ_NO_PERIODS);
   m_calendar.Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CDropCalendar::Reset(void)
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
void CDropCalendar::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   m_label.Delete();
   m_field.Delete();
   m_drop_button.Delete();
   m_drop_button_icon.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CDropCalendar::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_zorder);
   m_field.Z_Order(m_combobox_zorder);
   m_drop_button.Z_Order(m_combobox_zorder);
   m_drop_button_icon.Z_Order(m_zorder);
   m_calendar.SetZorders();
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CDropCalendar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_field.Z_Order(0);
   m_drop_button.Z_Order(0);
   m_drop_button_icon.Z_Order(0);
   m_calendar.ResetZorders();
  }
//+------------------------------------------------------------------+
//| ����� ����� � ���� ��������                                      |
//+------------------------------------------------------------------+
void CDropCalendar::ResetColors(void)
  {
   m_label.Color(m_label_color);
   m_field.BorderColor(m_border_color);
   m_drop_button.BackColor(m_button_color);
   m_drop_button.BorderColor(m_border_color);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ��������� ��������� �� ���������������       |
//+------------------------------------------------------------------+
void CDropCalendar::ChangeComboBoxCalendarState(void)
  {
//--- ���� ��������� ������
   if(m_calendar.IsVisible())
     {
      //--- ������� ��� � ��������� ��������������� �������� ��������� ������
      m_calendar.Hide();
      m_drop_button_icon.State(false);
      m_label.Color(m_label_color_hover);
      m_field.BorderColor(m_border_color_hover);
      m_drop_button.BorderColor(m_border_color_hover);
      m_drop_button.BackColor(m_button_color_hover);
      //--- �������������� �����
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
//--- ���� ��������� �����
   else
     {
      //--- ������� ��� � ��������� ��������������� �������� ��������� ������
      m_calendar.Show();
      m_drop_button_icon.State(true);
      m_drop_button.BackColor(m_button_color_pressed);
      //--- ������������� �����
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
     }
  }
//+------------------------------------------------------------------+
//| ������� �� ������ �����-�����                                    |
//+------------------------------------------------------------------+
bool CDropCalendar::OnClickButton(const string clicked_object)
  {
//--- �����, ���� ������ �� �� ������ �����-�����
   if(clicked_object!=m_drop_button.Name())
      return(false);
//--- �����, ���� ����� ������������� � �������������� �� ���������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- �����, ���� ������� ������������
   if(!m_drop_calendar_state)
      return(false);
//--- �������� ��������� ��������� ��������� �� ���������������
   ChangeComboBoxCalendarState();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_COMBOBOX_BUTTON,CElement::Id(),0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| �������� ������� ����� ������ ���� ��� �������                   |
//+------------------------------------------------------------------+
void CDropCalendar::CheckPressedOverButton(void)
  {
//--- �����, ���� ����� ������ ���� ������
   if(!m_mouse_state)
      return;
//--- �����, ���� ������� ������������
   if(!m_drop_calendar_state)
      return;
//--- ���� ���� ����� �� ��������
   if(CElement::MouseFocus())
     {
      //--- �����, ���� ����� ������������� � �������������� �� ���������
      if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
         return;
      //--- ���� ��������� �����
      if(!m_calendar.IsVisible())
        {
         //--- ���������� ���� ������ ������������ ������� ����
         if(m_drop_button.MouseFocus())
            m_drop_button.BackColor(m_button_color_pressed);
         else
            m_drop_button.BackColor(m_button_color);
        }
     }
//--- ���� ��� ������ �� ��������
   else
     {
      //--- �����, ���� ����� �� ���������
      if(m_calendar.MouseFocus())
         return;
      //--- �����, ���� ������ ��������� ������ ������� ��������� � ��������
      if(m_calendar.GetScrollVPointer().ScrollState())
         return;
      //--- ������ ��������� � �������� ����� ��������
      m_calendar.Hide();
      m_drop_button_icon.State(false);
      //--- �������� �����
      ResetColors();
      //--- �������������� �����, ���� �������������� �������� � ���������� ���������
      if(m_wnd.IdActivatedElement()==CElement::Id())
         m_wnd.IsLocked(false);
     }
  }
//+------------------------------------------------------------------+
