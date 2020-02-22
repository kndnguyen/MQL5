//+------------------------------------------------------------------+
//|                                                     Calendar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "SpinEdit.mqh"
#include "ComboBox.mqh"
#include "IconButton.mqh"
#include <Tools\DateTime.mqh>
//+------------------------------------------------------------------+
//| ����� ��� �������� ���������                                     |
//+------------------------------------------------------------------+
class CCalendar : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� � �������� ��� �������� ���������
   CRectLabel        m_area;
   CBmpLabel         m_month_dec;
   CBmpLabel         m_month_inc;
   CComboBox         m_months;
   CSpinEdit         m_years;
   CEdit             m_days_week[7];
   CRectLabel        m_sep_line;
   CEdit             m_days[42];
   CIconButton       m_button_today;
   //--- ��������� ��������� ��� ������ � ������ � ��������:
   CDateTime         m_date;      // ���������� ������������� ����
   CDateTime         m_today;     // ������� (��������� �� ���������� ������������) ����
   CDateTime         m_temp_date; // ��������� ��� �������� � ��������
   //--- ���� ����
   color             m_area_color;
   //--- ���� ����� ����
   color             m_area_border_color;
   //--- ����� ������� ��������� (���� ������) � ������ ����������
   color             m_item_back_color;
   color             m_item_back_color_off;
   color             m_item_back_color_hover;
   color             m_item_back_color_selected;
   //--- ����� ����� ������� ��������� � ������ ����������
   color             m_item_border_color;
   color             m_item_border_color_hover;
   color             m_item_border_color_selected;
   //--- ����� ������ ������� ��������� � ������ ����������
   color             m_item_text_color;
   color             m_item_text_color_off;
   color             m_item_text_color_hover;
   //--- ���� �������������� �����
   color             m_sepline_color;
   //--- ������ ������ (� ��������/��������������� ���������) ��� �������� � �����������/���������� ������
   string            m_left_arrow_file_on;
   string            m_left_arrow_file_off;
   string            m_right_arrow_file_on;
   string            m_right_arrow_file_off;
   //--- ���������� �� ������� ����� ������ ����
   int               m_area_zorder;
   int               m_button_zorder;
   int               m_zorder;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //--- ������� ������� ��� ��������� ������
   int               m_timer_counter;
   //---
public:
                     CCalendar(void);
                    ~CCalendar(void);
   //--- ������ ��� �������� ���������
   bool              CreateCalendar(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateMonthDecArrow(void);
   bool              CreateMonthIncArrow(void);
   bool              CreateMonthsList(void);
   bool              CreateYearsSpinEdit(void);
   bool              CreateDaysWeek(void);
   bool              CreateSeparateLine(void);
   bool              CreateDaysMonth(void);
   bool              CreateButtonToday(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ��������� �����-�����, 
   //    (3) ��������� ��������� ������, (4) ��������� ��������� ������ ��������� ������, 
   //    (5) ��������� ��������� ���� �����, (6) ��������� ��������� ������
   void              WindowPointer(CWindow &object)             { m_wnd=::GetPointer(object);            }
   CComboBox        *GetComboBoxPointer(void)                   { return(::GetPointer(m_months));        }
   CListView        *GetListViewPointer(void)                   { return(m_months.GetListViewPointer()); }
   CScrollV         *GetScrollVPointer(void)                    { return(m_months.GetScrollVPointer());  }
   CSpinEdit        *GetSpinEditPointer(void)                   { return(::GetPointer(m_years));         }
   CIconButton      *GetIconButtonPointer(void)                 { return(::GetPointer(m_button_today));  }
   //--- ��������� ����� (1) ����, (2) ����� ����, (3) ���� �������������� �����
   void              AreaBackColor(const color clr)             { m_area_color=clr;                      }
   void              AreaBorderColor(const color clr)           { m_area_border_color=clr;               }
   void              SeparateLineColor(const color clr)         { m_sepline_color=clr;                   }
   //--- ����� ������� ��������� (���� ������) � ������ ����������
   void              ItemBackColor(const color clr)             { m_item_back_color=clr;                 }
   void              ItemBackColorOff(const color clr)          { m_item_back_color_off=clr;             }
   void              ItemBackColorHover(const color clr)        { m_item_back_color_hover=clr;           }
   void              ItemBackColorSelected(const color clr)     { m_item_back_color_selected=clr;        }
   //--- ����� ����� ������� ��������� � ������ ����������
   void              ItemBorderColor(const color clr)           { m_item_border_color=clr;               }
   void              ItemBorderColorHover(const color clr)      { m_item_border_color_hover=clr;         }
   void              ItemBorderColorSelected(const color clr)   { m_item_border_color_selected=clr;      }
   //--- ����� ������ ������� ��������� � ������ ����������
   void              ItemTextColor(const color clr)             { m_item_text_color=clr;                 }
   void              ItemTextColorOff(const color clr)          { m_item_text_color_off=clr;             }
   void              ItemTextColorHover(const color clr)        { m_item_text_color_hover=clr;           }
   //--- ��������� ������� ������ (� ��������/��������������� ���������) ��� �������� � �����������/���������� ������
   void              LeftArrowFileOn(const string file_path)    { m_left_arrow_file_on=file_path;        }
   void              LeftArrowFileOff(const string file_path)   { m_left_arrow_file_off=file_path;       }
   void              RightArrowFileOn(const string file_path)   { m_right_arrow_file_on=file_path;       }
   void              RightArrowFileOff(const string file_path)  { m_right_arrow_file_off=file_path;      }
   //--- (1) ���������� (��������) � (2) �������� ���������� ����, (3) �������� ������� ���� � ���������
   void              SelectedDate(const datetime date);
   datetime          SelectedDate(void)                         { return(m_date.DateTime());             }
   datetime          Today(void)                                { return(m_today.DateTime());            }
   //--- ��������� ����� ��������
   void              ChangeObjectsColor(void);
   //--- ��������� ����� �������� � ������� ��������� ��� ��������� �������
   void              ChangeObjectsColor(const int x,const int y);
   //--- ����������� ��������� ��������� � ���������
   void              UpdateCalendar(void);
   //--- ���������� ������� ����
   void              UpdateCurrentDate(void);
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
   virtual void      ResetColors(void) {}
   //---
private:
   //--- ��������� ������� �� ������ �������� � ����������� ������
   bool              OnClickMonthDec(const string clicked_object);
   //--- ��������� ������� �� ������ �������� � ���������� ������
   bool              OnClickMonthInc(const string clicked_object);
   //--- ��������� ������ ������ � ������
   bool              OnClickMonthList(const long id);
   //--- ��������� ����� �������� � ���� ����� ���
   bool              OnEndEnterYear(const string edited_object);
   //--- ��������� ������� �� ������ �������� � ���������� ����
   bool              OnClickYearInc(const long id);
   //--- ��������� ������� �� ������ �������� � ����������� ����
   bool              OnClickYearDec(const long id);
   //--- ��������� ������� �� ��� ������
   bool              OnClickDayOfMonth(const string clicked_object);
   //--- ��������� ������� �� ������ �������� � ������� ����
   bool              OnClickTodayButton(const long id);

   //--- ��������� �������������� �� ����� �������
   int               IdFromObjectName(const string object_name);
   //--- ������������� ����������� ��� �� ���������� ���� � ������
   void              CorrectingSelectedDay(void);
   //--- ����������� ������� �� ������� ������ ������� ��������� �� ������ ������� ��� �������� ������
   int               OffsetFirstDayOfMonth(void);
   //--- ���������� ��������� ��������� � ������� ���������
   void              SetCalendar(void);
   //--- ���������� ��������� �������� ���������
   void              FastSwitching(void);
   //--- ��������� �������� ��� � ���������� ������������� ���
   void              HighlightDate(void);
   //--- ����� ������� �� ������ �����
   void              ResetTime(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCalendar::CCalendar(void) : m_area_color(clrWhite),
                             m_area_border_color(clrSilver),
                             m_sepline_color(clrBlack),
                             m_item_back_color(clrWhite),
                             m_item_back_color_off(clrWhite),
                             m_item_back_color_hover(C'235,245,255'),
                             m_item_back_color_selected(C'193,218,255'),
                             m_item_border_color(clrWhite),
                             m_item_border_color_hover(C'160,220,255'),
                             m_item_border_color_selected(C'85,170,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_off(C'200,200,200'),
                             m_item_text_color_hover(C'0,102,204'),
                             m_left_arrow_file_on(""),
                             m_left_arrow_file_off(""),
                             m_right_arrow_file_on(""),
                             m_right_arrow_file_off("")
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder        =0;
   m_area_zorder   =1;
   m_button_zorder =2;
//--- ������������� �������� �������
   m_date.DateTime(::TimeLocal());
   m_today.DateTime(::TimeLocal());
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCalendar::~CCalendar(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CCalendar::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- �����, ���� ������� �� ���������� � ����� �������������
      if(!CElement::IsDropdown() && m_wnd.IsLocked())
         return;
      //--- ���������� � ��������� ����� ������ ����
      int x=(int)lparam;
      int y=(int)dparam;
      m_mouse_state=(bool)int(sparam);
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_month_dec.MouseFocus(x>m_month_dec.X() && x<m_month_dec.X2() && 
                             y>m_month_dec.Y() && y<m_month_dec.Y2());
      m_month_inc.MouseFocus(x>m_month_inc.X() && x<m_month_inc.X2() && 
                             y>m_month_inc.Y() && y<m_month_inc.Y2());
      //--- �����, ���� ������ ������� �������
      if(m_months.GetListViewPointer().IsVisible())
         return;
      //--- ���� ������ ��������� � ����� ������ ���� ������...
      else if(m_mouse_state)
        {
         //--- ...���������� ��������������� ����� (� ������ �������� ������) ��������,
         //       ���� ���� �� ��� ��� �� �������������
         if(!m_button_today.ButtonState())
           {
            m_years.SpinEditState(true);
            m_button_today.ButtonState(true);
           }
        }
      //--- ��������� ����� ��������
      ChangeObjectsColor(x,y);
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- �����, ���� ����� ������������� � �������������� �� ���������
      if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
         return;
      //--- �����, ���� ������ ������� �����������
      if(m_months.GetListViewPointer().IsVisible())
         return;
      //--- ������������ �������� (������ � ���� �����), ���� ����� ������ ���� ������ 
      if(m_mouse_state)
        {
         m_years.SpinEditState(true);
         m_button_today.ButtonState(true);
        }
      //--- ��������� ������� �� ������� ������������ �������
      if(OnClickMonthDec(sparam))
         return;
      if(OnClickMonthInc(sparam))
         return;
      //--- ��������� ������� �� ��� ���������
      if(OnClickDayOfMonth(sparam))
         return;
     }
//--- ��������� ������� ������� �� ������ �����-�����
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_BUTTON)
     {
      //--- �����, ���� �������������� ��������� �� ���������
      if(lparam!=CElement::Id())
         return;
      //--- ������������ ��� ������������� �������� � ����������� �� �������� ��������� ��������� ������
      m_years.SpinEditState(!m_months.GetListViewPointer().IsVisible());
      m_button_today.ButtonState(!m_months.GetListViewPointer().IsVisible());
     }
//--- ��������� ������� ������� �� ������ ������ �����-�����
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      //--- ��������� ������ ������ � ������
      if(!OnClickMonthList(lparam))
         return;
      //---
      return;
     }
//--- ��������� ������� ������� �� ������ ����������
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC)
     {
      //--- ��������� ������� �� ������ �������� � ���������� ����
      if(!OnClickYearInc(lparam))
         return;
      //---
      return;
     }
//--- ��������� ������� ������� �� ������ ����������
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      //--- ��������� ������� �� ������ �������� � ����������� ����
      if(!OnClickYearDec(lparam))
         return;
      //---
      return;
     }
//--- ��������� ������� ����� �������� � ���� �����
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      //--- ��������� ����� �������� � ���� ����� ���
      if(OnEndEnterYear(sparam))
         return;
      //---
      return;
     }
//--- ��������� ������� ������� �� ������
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      //--- ��������� ������� �� ������ �������� � ������� ����
      if(!OnClickTodayButton(lparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CCalendar::OnEventTimer(void)
  {
//--- ���� ������� ���������� � ������ �����
   if(CElement::IsDropdown() && !m_months.GetListViewPointer().IsVisible())
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
//--- ���������� ������� ���� ���������
   UpdateCurrentDate();
  }
//+------------------------------------------------------------------+
//| ������ ����������� ����                                         |
//+------------------------------------------------------------------+
bool CCalendar::CreateCalendar(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ��������� ������ ����� �������� "
              "��������� �� �����: CCalendar::WindowPointer(CWindow &object).");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
   m_x_size   =161;
   m_y_size   =158;
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������
   if(!CreateArea())
      return(false);
   if(!CreateMonthDecArrow())
      return(false);
   if(!CreateMonthIncArrow())
      return(false);
   if(!CreateMonthsList())
      return(false);
   if(!CreateYearsSpinEdit())
      return(false);
   if(!CreateDaysWeek())
      return(false);
   if(!CreateSeparateLine())
      return(false);
   if(!CreateDaysMonth())
      return(false);
   if(!CreateButtonToday())
      return(false);
//--- �������� ���������
   UpdateCalendar();
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ������� ���������                                  |
//+------------------------------------------------------------------+
bool CCalendar::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_calendar_bg_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X();
   int y=CElement::Y();
//--- ������� �� ������� �����
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- ��������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������� ������� �����                              |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_blue.bmp"
//---
bool CCalendar::CreateMonthDecArrow(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_calendar_left_arrow_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X();
   int y =CElement::Y()+5;
//--- ���� �� ������� �������� ��� �������, ������ ��������� �� ���������
   if(m_left_arrow_file_on=="")
      m_left_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\LeftTransp_blue.bmp";
   if(m_left_arrow_file_off=="")
      m_left_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\LeftTransp_black.bmp";
//--- ��������� ������
   if(!m_month_dec.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
   m_month_dec.BmpFileOn("::"+m_left_arrow_file_on);
   m_month_dec.BmpFileOff("::"+m_left_arrow_file_off);
   m_month_dec.Corner(m_corner);
   m_month_dec.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_month_dec.Selectable(false);
   m_month_dec.Z_Order(m_button_zorder);
   m_month_dec.Tooltip("\n");
//--- �������� ������� (� �������)
   m_month_dec.XSize(m_month_dec.X_Size());
   m_month_dec.YSize(m_month_dec.Y_Size());
//--- �������� ����������
   m_month_dec.X(x);
   m_month_dec.Y(y);
//--- ������� �� ������� �����
   m_month_dec.XGap(x-m_wnd.X());
   m_month_dec.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_month_dec);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������� ������� ������                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_blue.bmp"
//---
bool CCalendar::CreateMonthIncArrow(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_calendar_right_arrow_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X()+CElement::XSize()-17;
   int y =CElement::Y()+5;
//--- ���� �� ������� �������� ��� �������, ������ ��������� �� ���������
   if(m_right_arrow_file_on=="")
      m_right_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_blue.bmp";
   if(m_right_arrow_file_off=="")
      m_right_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp";
//--- ��������� ������
   if(!m_month_inc.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
   m_month_inc.BmpFileOn("::"+m_right_arrow_file_on);
   m_month_inc.BmpFileOff("::"+m_right_arrow_file_off);
   m_month_inc.Corner(m_corner);
   m_month_inc.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_month_inc.Selectable(false);
   m_month_inc.Z_Order(m_button_zorder);
   m_month_inc.Tooltip("\n");
//--- �������� ������� (� �������)
   m_month_inc.XSize(m_month_inc.X_Size());
   m_month_inc.YSize(m_month_inc.Y_Size());
//--- �������� ����������
   m_month_inc.X(x);
   m_month_inc.Y(y);
//--- ������� �� ������� �����
   m_month_inc.XGap(x-m_wnd.X());
   m_month_inc.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_month_inc);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �����-���� � ��������                                    |
//+------------------------------------------------------------------+
bool CCalendar::CreateMonthsList(void)
  {
//--- �������� ��������� �� ����
   m_months.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X()+17;
   int y=CElement::Y()+4;
//--- ��������� �������� ����� ���������
   m_months.XSize(75);
   m_months.YSize(19);
   m_months.LabelText("");
   m_months.ButtonXSize(75);
   m_months.ButtonYSize(19);
   m_months.AreaColor(m_area_color);
   m_months.ButtonBackColor(C'230,230,230');
   m_months.ButtonBackColorHover(C'193,218,255');
   m_months.ButtonBorderColor(C'200,200,200');
   m_months.ButtonBorderColorHover(C'85,170,255');
   m_months.ItemsTotal(12);
   m_months.VisibleItemsTotal(5);
   m_months.IsDropdown(CElement::IsDropdown());
//--- ������� ��������� �� ������
   CListView *lv=m_months.GetListViewPointer();
//--- ��������� �������� ������
   lv.LightsHover(true);
//--- ������ �������� � ������ (�������� �������)
   for(int i=0; i<12; i++)
      m_months.ValueToList(i,m_date.MonthName(i+1));
//--- ������� � ������ ������� �����
   m_months.SelectedItemByIndex(m_date.mon-1);
//--- �������� ������� ����������
   if(!m_months.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� ����                                          |
//+------------------------------------------------------------------+
bool CCalendar::CreateYearsSpinEdit(void)
  {
//--- �������� ��������� �� ����
   m_years.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X()+96;
   int y=CElement::Y()+4;
//--- ��������� �������� ����� ���������
   m_years.XSize(50);
   m_years.YSize(18);
   m_years.EditXSize(35);
   m_years.EditYSize(19);
   m_years.MaxValue(2099);
   m_years.MinValue(1970);
   m_years.StepValue(1);
   m_years.SetDigits(0);
   m_years.SetValue(m_date.year);
   m_years.AreaColor(m_area_color);
   m_years.LabelColor(clrBlack);
   m_years.LabelColorLocked(clrBlack);
   m_years.EditColorLocked(clrWhite);
   m_years.EditTextColor(clrBlack);
   m_years.EditTextColorLocked(clrBlack);
   m_years.EditBorderColor(clrSilver);
   m_years.EditBorderColorLocked(clrSilver);
   m_years.IsDropdown(CElement::IsDropdown());
//--- �������� ������� ����������
   if(!m_years.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ���� ������                                     |
//+------------------------------------------------------------------+
bool CCalendar::CreateDaysWeek(void)
  {
//--- ����������
   int x =CElement::X()+9;
   int y =CElement::Y()+26;
//--- �������
   int x_size =21;
   int y_size =16;
//--- ������� ���� ������ (��� ������� ��������)
   int w=0;
//--- ��������� ������� ������������ ����������� �������� ���� ������
   for(int i=1; i<7; i++,w++)
     {
      //--- ������������ ����� �������
      string name=CElement::ProgramName()+"_calendar_days_week_"+string(w)+"__"+(string)CElement::Id();
      //--- ������ ���������� X
      x=(w>0)? x+x_size : x;
      //--- ��������� ������
      if(!m_days_week[w].Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
         return(false);
      //--- ��������� �������
      m_days_week[w].Description(m_date.ShortDayName(i));
      m_days_week[w].TextAlign(ALIGN_CENTER);
      m_days_week[w].Font(FONT);
      m_days_week[w].FontSize(FONT_SIZE);
      m_days_week[w].Color(m_item_text_color);
      m_days_week[w].BorderColor(m_area_color);
      m_days_week[w].BackColor(m_area_color);
      m_days_week[w].Corner(m_corner);
      m_days_week[w].Anchor(m_anchor);
      m_days_week[w].Selectable(false);
      m_days_week[w].Z_Order(m_zorder);
      m_days_week[w].ReadOnly(true);
      m_days_week[w].Tooltip("\n");
      //--- ��������� �������� ����� ���������
      m_days_week[w].XSize(x_size);
      m_days_week[w].YSize(y_size);
      //--- ������� �� ������� ����� ������
      m_days_week[w].XGap(x-m_wnd.X());
      m_days_week[w].YGap(y-m_wnd.Y());
      //--- �������� ��������� �������
      CElement::AddToArray(m_days_week[w]);
      //--- ���� ��� �����, �����
      if(i==0)
         break;
      //--- �����, ���� ������ ��� ��� ������
      if(i>=6)
         i=-1;
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������������� ����� ��� ���������� ���� ������          |
//+------------------------------------------------------------------+
bool CCalendar::CreateSeparateLine(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_calendar_separate_line_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X()+7;
   int y =CElement::Y()+42;
//--- �������
   int x_size =147;
   int y_size =1;
//--- �������� ������� ����������
   if(!m_sep_line.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- ��������� �������
   m_sep_line.BorderType(BORDER_FLAT);
   m_sep_line.Color(clrLightGray);
//--- ������� �� ������� ����� ������
   m_sep_line.XGap(x-m_wnd.X());
   m_sep_line.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_sep_line);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ���� ������                                      |
//+------------------------------------------------------------------+
bool CCalendar::CreateDaysMonth(void)
  {
//--- ����������
   int x =CElement::X()+9;
   int y =CElement::Y()+44;
//--- �������
   int x_size =21;
   int y_size =15;
//--- ������� ����
   int i=0;
//--- ��������� ������� ������� ���� ���������
   for(int r=0; r<6; r++)
     {
      //--- ������ ���������� Y
      y=(r>0)? y+y_size : y;
      //---
      for(int c=0; c<7; c++)
        {
         //--- ������������ ����� �������
         string name=CElement::ProgramName()+"_calendar_day_"+string(c)+"_"+string(r)+"__"+(string)CElement::Id();
         //--- ������ ���������� X
         x=(c==0)? CElement::X()+9 : x+x_size;
         //--- ��������� ������
         if(!m_days[i].Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
            return(false);
         //--- ��������� �������
         m_days[i].Description(string(i));
         m_days[i].TextAlign(ALIGN_RIGHT);
         m_days[i].Font(FONT);
         m_days[i].FontSize(8);
         m_days[i].Color(clrBlack);
         m_days[i].BorderColor(m_area_color);
         m_days[i].BackColor(m_area_color);
         m_days[i].Corner(m_corner);
         m_days[i].Anchor(m_anchor);
         m_days[i].Selectable(false);
         m_days[i].Z_Order(m_button_zorder);
         m_days[i].ReadOnly(true);
         m_days[i].Tooltip("\n");
         //--- ��������� �������� ����� ���������
         m_days[i].XSize(x_size);
         m_days[i].YSize(y_size);
         //--- ������� �� ������� ����� ������
         m_days[i].XGap(x-m_wnd.X());
         m_days[i].YGap(y-m_wnd.Y());
         //--- �������� ��������� �������
         CElement::AddToArray(m_days[i]);
         i++;
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ��� �������� �� ������� ����                      |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_today.bmp"
//---
bool CCalendar::CreateButtonToday(void)
  {
//--- �������� ��������� �� ����
   m_button_today.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X()+20;
   int y=CElement::Y()+134;
//--- ��������� �������� ����� ���������
   m_button_today.TwoState(false);
   m_button_today.ButtonXSize(123);
   m_button_today.ButtonYSize(21);
   m_button_today.LabelXGap(30);
   m_button_today.LabelYGap(5);
   m_button_today.LabelColor(m_item_text_color);
   m_button_today.LabelColorOff(m_item_text_color);
   m_button_today.LabelColorHover(C'0,102,250');
   m_button_today.LabelColorPressed(C'0,102,250');
   m_button_today.BackColor(m_area_color);
   m_button_today.BackColorOff(m_area_color);
   m_button_today.BackColorHover(m_area_color);
   m_button_today.BackColorPressed(m_area_color);
   m_button_today.BorderColor(m_area_color);
   m_button_today.BorderColorOff(m_area_color);
   m_button_today.IconFileOn("Images\\EasyAndFastGUI\\Controls\\calendar_today.bmp");
   m_button_today.IconFileOff("Images\\EasyAndFastGUI\\Controls\\calendar_today.bmp");
   m_button_today.IsDropdown(CElement::IsDropdown());
//--- �������� ������� ����������
   if(!m_button_today.CreateIconButton(m_chart_id,m_subwin,"Today: "+::TimeToString(::TimeLocal(),TIME_DATE),x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ����� ����� ����                                                 |
//+------------------------------------------------------------------+
void CCalendar::SelectedDate(const datetime date)
  {
//--- ���������� ���� � ��������� � ���� ������
   m_date.DateTime(date);
//--- ����������� ��������� ��������� � ���������
   UpdateCalendar();
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CCalendar::ChangeObjectsColor(void)
  {
   m_month_dec.State(m_month_dec.MouseFocus());
   m_month_inc.State(m_month_inc.MouseFocus());
  }
//+------------------------------------------------------------------+
//| ��������� ����� �������� � ������� ���������                     |
//| ��� ��������� �������                                            |
//+------------------------------------------------------------------+
void CCalendar::ChangeObjectsColor(const int x,const int y)
  {
//--- ����������� ������� �� ������� ������ ������� ��������� �� ������ ������� ��� �������� ������
   OffsetFirstDayOfMonth();
//--- �������� � ����� �� ������� ������� ���������
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ����� ������ ��������� � ������� ������� � 
      //    ���� ������ ��������� � ���������� ���
      if(m_temp_date.mon==m_date.mon &&
         m_temp_date.day==m_date.day)
        {
         //--- ������� � ���������� ������ �������
         m_temp_date.DayInc();
         continue;
        }
      //--- ���� ���/�����/���� ������ ��������� � �����/�������/��� ������� ���� (�������)
      if(m_temp_date.year==m_today.year && 
         m_temp_date.mon==m_today.mon &&
         m_temp_date.day==m_today.day)
        {
         //--- ������� � ���������� ������ �������
         m_temp_date.DayInc();
         continue;
        }
      //--- ���� ������ ���� ��������� ��� ���� �������
      if(x>m_days[i].X() && x<m_days[i].X2() &&
         y>m_days[i].Y() && y<m_days[i].Y2())
        {
         m_days[i].BackColor(m_item_back_color_hover);
         m_days[i].BorderColor(m_item_border_color_hover);
         m_days[i].Color((m_temp_date.mon==m_date.mon)? m_item_text_color_hover : m_item_text_color_off);
        }
      else
        {
         m_days[i].BackColor(m_item_back_color);
         m_days[i].BorderColor(m_item_border_color);
         m_days[i].Color((m_temp_date.mon==m_date.mon)? m_item_text_color : m_item_text_color_off);
        }
      //--- ������� � ���������� ������ �������
      m_temp_date.DayInc();
     }
  }
//+------------------------------------------------------------------+
//| ����������� ��������� ��������� � ���������                      |
//+------------------------------------------------------------------+
void CCalendar::UpdateCalendar(void)
  {
//--- ���������� ��������� � ������� ���������
   SetCalendar();
//--- ��������� �������� ��� � ���������� ������������� ���
   HighlightDate();
//--- ��������� ��� � ���� �����
   m_years.ChangeValue(m_date.year);
//--- ��������� ����� � ������ �����-�����
   m_months.SelectedItemByIndex(m_date.mon-1);
  }
//+------------------------------------------------------------------+
//| ���������� ������� ����                                          |
//+------------------------------------------------------------------+
void CCalendar::UpdateCurrentDate(void)
  {
//--- �������
   static int count=0;
//--- �����, ���� ������ ������ �������
   if(count<1000)
     {
      count+=TIMER_STEP_MSC;
      return;
     }
//--- �������� �������
   count=0;
//--- ������� ������� (���������) �����
   MqlDateTime local_time;
   ::TimeToStruct(::TimeLocal(),local_time);
//--- ���� �������� ����� ����
   if(local_time.day!=m_today.day)
     {
      //--- �������� ���� � ���������
      m_today.DateTime(::TimeLocal());
      m_button_today.Object(2).Description(::TimeToString(m_today.DateTime()));
      //--- ���������� ��������� ��������� � ���������
      UpdateCalendar();
      return;
     }
//--- �������� ���� � ���������
   m_today.DateTime(::TimeLocal());
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CCalendar::Moving(const int x,const int y)
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
   m_month_dec.X(x+m_month_dec.XGap());
   m_month_dec.Y(y+m_month_dec.YGap());
   m_month_inc.X(x+m_month_inc.XGap());
   m_month_inc.Y(y+m_month_inc.YGap());
   m_sep_line.X(x+m_sep_line.XGap());
   m_sep_line.Y(y+m_sep_line.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_month_dec.X_Distance(m_month_dec.X());
   m_month_dec.Y_Distance(m_month_dec.Y());
   m_month_inc.X_Distance(m_month_inc.X());
   m_month_inc.Y_Distance(m_month_inc.Y());
   m_sep_line.X_Distance(m_sep_line.X());
   m_sep_line.Y_Distance(m_sep_line.Y());
//--- ������� �������� ���� ������
   for(int i=0; i<7; i++)
     {
      //--- ���������� ��������� � ����� ��������
      m_days_week[i].X(x+m_days_week[i].XGap());
      m_days_week[i].Y(y+m_days_week[i].YGap());
      //--- ���������� ��������� ����������� ��������
      m_days_week[i].X_Distance(m_days_week[i].X());
      m_days_week[i].Y_Distance(m_days_week[i].Y());
     }
//--- ������� ���� ���������
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- ���������� ��������� � ����� ��������
      m_days[i].X(x+m_days[i].XGap());
      m_days[i].Y(y+m_days[i].YGap());
      //--- ���������� ��������� ����������� ��������
      m_days[i].X_Distance(m_days[i].X());
      m_days[i].Y_Distance(m_days[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| ���������� ���������                                             |
//+------------------------------------------------------------------+
void CCalendar::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- �������� ��� ��������
   m_years.Show();
   m_months.Show();
   m_button_today.Show();
//--- ��������� ���������
   CElement::IsVisible(true);
//--- ���� ��� ���������� ���������, �� ������� ������� ��� ��������� ����������� �� ������� ������ ���������
   if(CElement::IsDropdown())
      ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,CElement::Id(),0.0,"");
  }
//+------------------------------------------------------------------+
//| �������� ���������                                               |
//+------------------------------------------------------------------+
void CCalendar::Hide(void)
  {
//--- �����, ���� ������� ��� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ ��� ��������
   m_years.Hide();
   m_months.Hide();
   m_button_today.Hide();
//---
   m_years.SpinEditState(true);
   m_button_today.ButtonState(true);
//--- ��������� ���������
   CElement::IsVisible(false);
//--- ������� ������� ��� �������������� ����������� �� ������� ��������
   ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CCalendar::Reset(void)
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
void CCalendar::Delete(void)
  {
//--- �������� �������� ���������
   m_area.Delete();
   m_month_dec.Delete();
   m_month_inc.Delete();
//---
   for(int i=0; i<7; i++)
      m_days_week[i].Delete();
//---
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
      m_days[i].Delete();
//---
   m_sep_line.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CCalendar::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_month_dec.Z_Order(m_button_zorder);
   m_month_inc.Z_Order(m_button_zorder);
//---
   for(int i=0; i<7; i++)
      m_days_week[i].Z_Order(m_zorder);
//---
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
      m_days[i].Z_Order(m_button_zorder);
//---
   m_button_today.SetZorders();
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CCalendar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_month_dec.Z_Order(0);
   m_month_inc.Z_Order(0);
//---
   for(int i=0; i<7; i++)
      m_days_week[i].Z_Order(0);
//---
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
      m_days[i].Z_Order(0);
//---
   m_button_today.ResetZorders();
  }
//+------------------------------------------------------------------+
//| ������� �� ������� �����. ������� � ����������� ������.          |
//+------------------------------------------------------------------+
bool CCalendar::OnClickMonthDec(const string clicked_object)
  {
//--- �����, ���� ����� ��� �������
   if(::StringFind(clicked_object,m_month_dec.Name(),0)<0)
      return(false);
//--- ���� ������� ��� � ��������� ����� ������������ ���������� �
//    ������� ����� "������"
   if(m_date.year==m_years.MinValue() && m_date.mon==1)
     {
      //--- ���������� �������� � �����
      m_years.HighlightLimit();
      return(true);
     }
//--- ��������� ��������� On
   m_month_dec.State(true);
//--- ������� � ����������� ������
   m_date.MonDec();
//--- ���������� ������ ����� ������
   m_date.day=1;
//--- ���������� ����� �� ������ �����
   ResetTime();
//--- ����������� ��������� ��������� � ���������
   UpdateCalendar();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������� �����. ������� � ���������� ������.           |
//+------------------------------------------------------------------+
bool CCalendar::OnClickMonthInc(const string clicked_object)
  {
//--- �����, ���� ����� ��� �������
   if(::StringFind(clicked_object,m_month_inc.Name(),0)<0)
      return(false);
//--- ���� ������� ��� � ��������� ����� ������������� ���������� �
//    ������� ����� "�������"
   if(m_date.year==m_years.MaxValue() && m_date.mon==12)
     {
      //--- ���������� �������� � �����
      m_years.HighlightLimit();
      return(true);
     }
//--- ��������� ��������� On
   m_month_inc.State(true);
//--- ������� � ���������� ������
   m_date.MonInc();
//--- ���������� ������ ����� ������
   m_date.day=1;
//--- ���������� ����� �� ������ �����
   ResetTime();
//--- ����������� ��������� ��������� � ���������
   UpdateCalendar();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������ ������ � ������                                 |
//+------------------------------------------------------------------+
bool CCalendar::OnClickMonthList(const long id)
  {
//--- �����, ���� �������������� ��������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- �������������� ��������
   m_years.SpinEditState(true);
   m_button_today.ButtonState(true);
//--- ������� ��������� ����� � ������
   int month=m_months.GetListViewPointer().SelectedItemIndex()+1;
   m_date.Mon(month);
//--- ������������� ����������� ��� �� ���������� ���� � ������
   CorrectingSelectedDay();
//--- ���������� ����� �� ������ �����
   ResetTime();
//--- ���������� ��������� � ������� ���������
   UpdateCalendar();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ����� �������� � ���� ����� ���                        |
//+------------------------------------------------------------------+
bool CCalendar::OnEndEnterYear(const string edited_object)
  {
//--- ������, ���� ����� ��� �������
   if(::StringFind(edited_object,m_years.Object(2).Name(),0)<0)
      return(false);
//--- ������, ���� �������� �� ����������
   string value=m_years.Object(2).Description();
   if(m_date.year==(int)value)
      return(false);
//--- ������������� �������� � ������ ������ �� ������������� �����������
   if((int)value<m_years.MinValue())
     {
      value=(string)int(m_years.MinValue());
      //--- ���������� ��������
      m_years.HighlightLimit();
     }
   if((int)value>m_years.MaxValue())
     {
      value=(string)int(m_years.MaxValue());
      //--- ���������� ��������
      m_years.HighlightLimit();
     }
//--- ��������� ���������� ���� � ������� ������
   string year  =value;
   string month =string(m_date.mon);
   string day   =string(1);
   m_temp_date.DateTime(::StringToTime(year+"."+month+"."+day));
//--- ���� �������� ����������� ��� ������, ��� ���������� ���� � ������,
//    ���������� ������� ���������� ���� � ������ � �������� ����������� ���
   if(m_date.day>m_temp_date.DaysInMonth())
      m_date.day=m_temp_date.DaysInMonth();
//--- ��������� ���� � ���������
   m_date.DateTime(::StringToTime(year+"."+month+"."+string(m_date.day)));
//--- ��������� ��������� � ������� ���������
   UpdateCalendar();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ �������� � ���������� ����           |
//+------------------------------------------------------------------+
bool CCalendar::OnClickYearInc(const long id)
  {
//--- ���� ������ ������� ������, ������� ���
   if(m_months.GetListViewPointer().IsVisible())
      m_months.ChangeComboBoxListState();
//--- �����, ���� �������������� ��������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ���� ��� ������ ������������� ����������, ��������� �������� �� ����
   if(m_date.year<m_years.MaxValue())
      m_date.YearInc();
//--- ������������� ����������� ��� �� ���������� ���� � ������
   CorrectingSelectedDay();
//--- ���������� ��������� � ������� ���������
   UpdateCalendar();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ �������� � ����������� ����          |
//+------------------------------------------------------------------+
bool CCalendar::OnClickYearDec(const long id)
  {
//--- ���� ������ ������� ������, ������� ���
   if(m_months.GetListViewPointer().IsVisible())
      m_months.ChangeComboBoxListState();
//--- �����, ���� �������������� ��������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ���� ��� ������ ������������ ����������, ��������� �������� �� ����
   if(m_date.year>m_years.MinValue())
      m_date.YearDec();
//--- ������������� ����������� ��� �� ���������� ���� � ������  
   CorrectingSelectedDay();
//--- ���������� ��������� � ������� ���������
   UpdateCalendar();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ��� ������ ���������                        |
//+------------------------------------------------------------------+
bool CCalendar::OnClickDayOfMonth(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ��� ���������
   if(::StringFind(clicked_object,CElement::ProgramName()+"_calendar_day_",0)<0)
      return(false);
//--- ������� ������������� � ������ �� ����� �������
   int id=IdFromObjectName(clicked_object);
//--- �����, ���� ������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ����������� ������� �� ������� ������ ������� ��������� �� ������ ������� ��� �������� ������
   OffsetFirstDayOfMonth();
//--- �������� � ����� �� ������� ������� ���������
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ���� �������� ������ ������, ��� ������������� � ������� �������
      if(m_temp_date.DateTime()<datetime(D'01.01.1970'))
        {
         //--- ���� ��� ������, �� ������� ������
         if(m_days[i].Name()==clicked_object)
           {
            //--- ���������� �������� � �����
            m_years.HighlightLimit();
            return(false);
           }
         //--- ������� � ��������� ����
         m_temp_date.DayInc();
         continue;
        }
      //--- ���� ��� ������, �� ������� ������
      if(m_days[i].Name()==clicked_object)
        {
         //--- �������� ����
         m_date.DateTime(m_temp_date.DateTime());
         //--- ����������� ��������� ��������� � ���������
         UpdateCalendar();
         break;
        }
      //--- ������� � ��������� ����
      m_temp_date.DayInc();
      //--- �������� ������ �� ������������� � ������� ��������
      if(m_temp_date.year>m_years.MaxValue())
        {
         //--- ���������� �������� � �����
         m_years.HighlightLimit();
         return(false);
        }
     }
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ �������� � ������� ����              |
//+------------------------------------------------------------------+
bool CCalendar::OnClickTodayButton(const long id)
  {
//--- ���� ������ ������� ������, ������� ���
   if(m_months.GetListViewPointer().IsVisible())
      m_months.ChangeComboBoxListState();
//--- �����, ���� �������������� ��������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ���������� ������� ����
   m_date.DateTime(::TimeLocal());
//--- ����������� ��������� ��������� � ���������
   UpdateCalendar();
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CCalendar::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
//| ����������� ������� ��� ������                                   |
//+------------------------------------------------------------------+
void CCalendar::CorrectingSelectedDay(void)
  {
//--- ���������� ������� ���������� ���� � ������, ���� �������� ����������� ��� ������
   if(m_date.day>m_date.DaysInMonth())
      m_date.day=m_date.DaysInMonth();
  }
//+------------------------------------------------------------------+
//| ����������� ������� �� ������� ������ ������� ���������          |
//| �� ������ ������� ��� �������� ������                            |
//+------------------------------------------------------------------+
int CCalendar::OffsetFirstDayOfMonth(void)
  {
//--- ������� ���� ������� ��� ����������� ���� � ������ � ���� ������
   string date=string(m_date.year)+"."+string(m_date.mon)+"."+string(1);
//--- ��������� ��� ���� � ��������� ��� ��������
   m_temp_date.DateTime(::StringToTime(date));
//--- ���� ��������� ��������� ������� �� �������� ������ ��� ������ ������ ���� ����� ����,
//    ������� ���������, ����� ������� �������� 6
   int diff=(m_temp_date.day_of_week-1>=0) ? m_temp_date.day_of_week-1 : 6;
//--- �������� ����, ������� ���������� �� ������ ����� �������
   m_temp_date.DayDec(diff);
   return(diff);
  }
//+------------------------------------------------------------------+
//| ��������� �������� ���������                                     |
//+------------------------------------------------------------------+
void CCalendar::SetCalendar(void)
  {
//--- ����������� ������� �� ������� ������ ������� ��������� �� ������ ������� ��� �������� ������
   int diff=OffsetFirstDayOfMonth();
//--- �������� � ����� �� ���� ������� ������� ���������
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- ��������� ��� � ������� ����� �������
      m_days[i].Description(string(m_temp_date.day));
      //--- ������� � ��������� ����
      m_temp_date.DayInc();
     }
  }
//+------------------------------------------------------------------+
//| ���������� �������� ���������                                    |
//+------------------------------------------------------------------+
void CCalendar::FastSwitching(void)
  {
//--- ������, ���� ��� ������ �� ��������
   if(!CElement::MouseFocus())
      return;
//--- �����, ���� ����� ������������� � �������������� �� ���������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
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
      //--- ���� ����� ������� ������
      if(m_month_dec.State())
        {
         //--- ���� ������� ��� � ��������� ������/����� ������������ ����������
         if(m_date.year>=m_years.MinValue())
           {
            //--- ���� ������� ��� � ��������� ��� ����� ������������ ���������� �
            //    ������� ����� "������"
            if(m_date.year==m_years.MinValue() && m_date.mon==1)
              {
               //--- ���������� �������� � �����
               m_years.HighlightLimit();
               return;
              }
            //--- ������� � ���������� ������ (� ������� ����������)
            m_date.MonDec();
            //--- ���������� ������ ����� ������
            m_date.day=1;
           }
        }
      //--- ���� ������ ������� ������
      else if(m_month_inc.State())
        {
         //--- ���� ������� � ��������� ��� ������/����� ������������� ����������
         if(m_date.year<=m_years.MaxValue())
           {
            //--- ���� ������� ��� � ��������� ��� ����� ������������� ���������� �
            //    ������� ����� "�������"
            if(m_date.year==m_years.MaxValue() && m_date.mon==12)
              {
               //--- ���������� �������� � �����
               m_years.HighlightLimit();
               return;
              }
            //--- ������� � ���������� ������ (� ������� ����������)
            m_date.MonInc();
            //--- ���������� ������ ����� ������
            m_date.day=1;
           }
        }
      //--- ���� ������ ���������� ���� ����� ��� ������
      else if(m_years.StateInc())
        {
         //--- ���� ������ ������������� ���������� ����,
         //    ������� � ���������� ���� (� ������� ����������)
         if(m_date.year<m_years.MaxValue())
            m_date.YearInc();
         else
           {
            //--- ���������� �������� � �����
            m_years.HighlightLimit();
            return;
           }
        }
      //--- ���� ������ ���������� ���� ����� ��� ������
      else if(m_years.StateDec())
        {
         //--- ���� ������ ������������ ���������� ����,
         //    ������� � ���������� ���� (� ������� ����������)
         if(m_date.year>m_years.MinValue())
            m_date.YearDec();
         else
           {
            //--- ���������� �������� � �����
            m_years.HighlightLimit();
            return;
           }
        }
      else
         return;
      //--- ����������� ��������� ��������� � ���������
      UpdateCalendar();
      //--- �������� ��������� �� ����
      ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
     }
  }
//+------------------------------------------------------------------+
//| ��������� �������� ��� � ���������� ������������� ���            |
//+------------------------------------------------------------------+
void CCalendar::HighlightDate(void)
  {
//--- ����������� ������� �� ������� ������ ������� ��������� �� ������ ������� ��� �������� ������
   OffsetFirstDayOfMonth();
//--- �������� � ����� �� ������� ������� ���������
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ����� ������ ��������� � ������� ������� � 
      //    ���� ������ ��������� � ���������� ���
      if(m_temp_date.mon==m_date.mon &&
         m_temp_date.day==m_date.day)
        {
         m_days[i].Color(m_item_text_color);
         m_days[i].BackColor(m_item_back_color_selected);
         m_days[i].BorderColor(m_item_border_color_selected);
         //--- ������� � ���������� ������ �������
         m_temp_date.DayInc();
         continue;
        }
      //--- ���� ��� ������� ���� (�������)
      if(m_temp_date.year==m_today.year && 
         m_temp_date.mon==m_today.mon &&
         m_temp_date.day==m_today.day)
        {
         m_days[i].BackColor(m_item_back_color);
         m_days[i].BorderColor(m_item_text_color_hover);
         m_days[i].Color(m_item_text_color_hover);
         //--- ������� � ���������� ������ �������
         m_temp_date.DayInc();
         continue;
        }
      //---
      m_days[i].BackColor(m_item_back_color);
      m_days[i].BorderColor(m_item_border_color);
      m_days[i].Color((m_temp_date.mon==m_date.mon)? m_item_text_color : m_item_text_color_off);
      //--- ������� � ���������� ������ �������
      m_temp_date.DayInc();
     }
  }
//+------------------------------------------------------------------+
//| ����� ������� �� ������ �����                                    |
//+------------------------------------------------------------------+
void CCalendar::ResetTime(void)
  {
   m_date.hour =0;
   m_date.min  =0;
   m_date.sec  =0;
  }
//+------------------------------------------------------------------+
