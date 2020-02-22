//+------------------------------------------------------------------+
//|                                                     CheckBox.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ���-�����                                     |
//+------------------------------------------------------------------+
class CCheckBox : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ���-�����
   CRectLabel        m_area;
   CBmpLabel         m_check;
   CLabel            m_label;
   //--- ���� ���� ��������
   color             m_area_color;
   //--- ������ �������� � �������� � ��������������� ���������
   string            m_check_bmp_file_on;
   string            m_check_bmp_file_off;
   string            m_check_bmp_file_on_locked;
   string            m_check_bmp_file_off_locked;
   //--- ��������� ������ ���-�����
   bool              m_check_button_state;
   //--- ����� ���-�����
   string            m_label_text;
   //--- ������� ��������� �����
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ����� ��������� ����� � ������ ����������
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   int               m_area_zorder;
   //--- ��������� �������� (��������/������������)
   bool              m_checkbox_state;
   //---
public:
                     CCheckBox(void);
                    ~CCheckBox(void);
   //--- ������ ��� �������� ���-�����
   bool              CreateCheckBox(const long chart_id,const int subwin,const string text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCheck(void);
   bool              CreateLabel(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) �����������/��������� ��������� ���-�����
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);            }
   bool              CheckBoxState(void)                      const { return(m_checkbox_state);              }
   void              CheckBoxState(const bool state);
   //--- ��������� ������� ��� ������ � �������� � ��������������� ����������
   void              CheckFileOn(const string file_path)            { m_check_bmp_file_on=file_path;         }
   void              CheckFileOff(const string file_path)           { m_check_bmp_file_off=file_path;        }
   void              CheckFileOnLocked(const string file_path)      { m_check_bmp_file_on_locked=file_path;  }
   void              CheckFileOffLocked(const string file_path)     { m_check_bmp_file_off_locked=file_path; }
   //--- (1) ���� ����, (2) ������� ��������� �����
   void              AreaColor(const color clr)                     { m_area_color=clr;                      }
   void              LabelXGap(const int x_gap)                     { m_label_x_gap=x_gap;                   }
   void              LabelYGap(const int y_gap)                     { m_label_y_gap=y_gap;                   }
   //--- ����� ������ � ������ ����������
   void              LabelColor(const color clr)                    { m_label_color=clr;                     }
   void              LabelColorOff(const color clr)                 { m_label_color_off=clr;                 }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;               }
   void              LabelColorLocked(const color clr)              { m_label_color_locked=clr;              }
   //--- (1) �������� ���-�����, (2) �����������/��������� ��������� ������ ���-�����
   string            LabelText(void)                          const { return(m_label.Description());         }
   bool              CheckButtonState(void)                   const { return(m_check.State());               }
   void              CheckButtonState(const bool state);
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
   //--- ��������� ������� �� �������
   bool              OnClickLabel(const string clicked_object);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCheckBox::CCheckBox(void) : m_checkbox_state(true),
                             m_check_button_state(false),
                             m_area_color(C'15,15,15'),
                             m_label_x_gap(20),
                             m_label_y_gap(2),
                             m_label_color(clrWhite),
                             m_label_color_off(clrSilver),
                             m_label_color_locked(clrGray),
                             m_label_color_hover(C'85,170,255'),
                             m_check_bmp_file_on(""),
                             m_check_bmp_file_off(""),
                             m_check_bmp_file_on_locked(""),
                             m_check_bmp_file_off_locked("")

  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder      =0;
   m_area_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCheckBox::~CCheckBox(void)
  {
  }
//+------------------------------------------------------------------+
//| ��������� �������                                                |
//+------------------------------------------------------------------+
void CCheckBox::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ������� �� ���-�����
      if(OnClickLabel(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CCheckBox::OnEventTimer(void)
  {
//--- ���� ����� �� �������������
   if(!m_wnd.IsLocked())
      //--- �������� ����� �������� ��������
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| ������ ������ �������� �������                                  |
//+------------------------------------------------------------------+
bool CCheckBox::CreateCheckBox(const long chart_id,const int subwin,const string text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ���-����� ������ ����� �������� "
              "��������� �� �����: CCheckBox::WindowPointer(CWindow &object)");
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
   if(!CreateCheck())
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
//| ������ ������� ��������                                         |
//+------------------------------------------------------------------+
bool CCheckBox::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkbox_area_"+(string)CElement::Id();
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
//--- ������� �� ������� �����
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������                                                  |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp"
//---
bool CCheckBox::CreateCheck(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkbox_bmp_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+2;
   int y=CElement::Y()+2;
//--- ���� �� ������� �������� ��� ������ ���-�����, ������ ��������� �� ���������
   if(m_check_bmp_file_on=="")
      m_check_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp";
   if(m_check_bmp_file_off=="")
      m_check_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp";
//---
   if(m_check_bmp_file_on_locked=="")
      m_check_bmp_file_on_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp";
   if(m_check_bmp_file_off_locked=="")
      m_check_bmp_file_off_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp";
//--- ��������� ������
   if(!m_check.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_check.BmpFileOn("::"+m_check_bmp_file_on);
   m_check.BmpFileOff("::"+m_check_bmp_file_off);
   m_check.State(m_check_button_state);
   m_check.Corner(m_corner);
   m_check.Selectable(false);
   m_check.Z_Order(m_zorder);
   m_check.Tooltip("\n");
//--- ������� �� ������� �����
   m_check.XGap(x-m_wnd.X());
   m_check.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_check);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ��������                                           |
//+------------------------------------------------------------------+
bool CCheckBox::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkbox_lable_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X()+m_label_x_gap;
   int y =CElement::Y()+m_label_y_gap;
//--- ���� ������ ������������ ���������
   color label_color=(m_check_button_state) ? m_label_color : m_label_color_off;
//--- ��������� ������
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
//--- ������������� ������� ���������
   CElement::InitColorArray(label_color,m_label_color_hover,m_label_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CCheckBox::Moving(const int x,const int y)
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
   m_check.X(x+m_check.XGap());
   m_check.Y(y+m_check.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_check.X_Distance(m_check.X());
   m_check.Y_Distance(m_check.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CCheckBox::ChangeObjectsColor(void)
  {
//--- �����, ���� ������� ������������
   if(!m_checkbox_state)
      return;
//---
   color label_color=(m_check_button_state) ? m_label_color : m_label_color_off;
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,label_color,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| ���������� �����-����                                            |
//+------------------------------------------------------------------+
void CCheckBox::Show(void)
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
//| �������� �����-����                                              |
//+------------------------------------------------------------------+
void CCheckBox::Hide(void)
  {
//--- �����, ���� ������� ��� �����
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
void CCheckBox::Reset(void)
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
void CCheckBox::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   m_check.Delete();
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
void CCheckBox::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_check.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CCheckBox::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_check.Z_Order(-1);
   m_label.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ����� ����� �������� ��������                                    |
//+------------------------------------------------------------------+
void CCheckBox::ResetColors(void)
  {
//--- �����, ���� ������� ������������
   if(!m_checkbox_state)
      return;
//--- �������� ����
   m_label.Color((m_check_button_state)? m_label_color : m_label_color_off);
//--- ������� �����
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������ ���-�����                             |
//+------------------------------------------------------------------+
void CCheckBox::CheckButtonState(const bool state)
  {
//--- �����, ���� ������� ������������
   if(!m_checkbox_state)
      return;
//--- ��������� ��������� ������
   m_check.State(state);
   m_check_button_state=state;
//--- ������� ����� ������������ ���������
   m_label.Color((state)? m_label_color : m_label_color_off);
   CElement::InitColorArray((state)? m_label_color : m_label_color_off,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ��������                                     |
//+------------------------------------------------------------------+
void CCheckBox::CheckBoxState(const bool state)
  {
//--- ��������� ��������
   m_checkbox_state=state;
//--- ��������
   m_check.BmpFileOn((state)? "::"+m_check_bmp_file_on : "::"+m_check_bmp_file_on_locked);
   m_check.BmpFileOff((state)? "::"+m_check_bmp_file_off : "::"+m_check_bmp_file_off_locked);
//--- ���� ��������� �����
   m_label.Color((state)? m_label_color : m_label_color_locked);
  }
//+------------------------------------------------------------------+
//| ������� �� ��������� ��������                                    |
//+------------------------------------------------------------------+
bool CCheckBox::OnClickLabel(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������
   if(m_area.Name()!=clicked_object)
      return(false);
//--- �����, ���� ������� ������������
   if(!m_checkbox_state)
      return(false);
//--- ����������� �� ��������������� �����
   CheckButtonState(!m_check.State());
//--- ������ ���� ������ ��� ���������
   m_label.Color(m_label_color_hover);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,CElement::Id(),0,m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
