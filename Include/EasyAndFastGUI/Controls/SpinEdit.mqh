//+------------------------------------------------------------------+
//|                                                     SpinEdit.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ���� �����                                    |
//+------------------------------------------------------------------+
class CSpinEdit : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ���� �����
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_edit;
   CBmpLabel         m_spin_inc;
   CBmpLabel         m_spin_dec;
   //--- ���� ���� ��������
   color             m_area_color;
   //--- ����� �������� ���� �����
   string            m_label_text;
   //--- ������� ��������� �����
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ����� ������ � ������ ����������
   color             m_label_color;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- ������� �������� � ���� �����
   double            m_edit_value;
   //--- ������� ���� �����
   int               m_edit_x_size;
   int               m_edit_y_size;
   //--- ������ ���� ����� �� ������� ����
   int               m_edit_x_gap;
   //--- ����� ���� ����� � ������ ���� ����� � ������ ����������
   color             m_edit_color;
   color             m_edit_color_locked;
   color             m_edit_text_color;
   color             m_edit_text_color_locked;
   color             m_edit_text_color_highlight;
   //--- ����� ����� ���� ����� � ������ ����������
   color             m_edit_border_color;
   color             m_edit_border_color_hover;
   color             m_edit_border_color_locked;
   color             m_edit_border_color_array[];
   //--- ������ �������������� � �������� � ��������������� ���������
   string            m_inc_bmp_file_on;
   string            m_inc_bmp_file_off;
   string            m_inc_bmp_file_locked;
   string            m_dec_bmp_file_on;
   string            m_dec_bmp_file_off;
   string            m_dec_bmp_file_locked;
   //--- ������� ������ (�� ������� ����)
   int               m_inc_x_gap;
   int               m_inc_y_gap;
   int               m_dec_x_gap;
   int               m_dec_y_gap;
   //--- ���������� �� ������� ����� ������ ����
   int               m_area_zorder;
   int               m_label_zorder;
   int               m_edit_zorder;
   int               m_spin_zorder;
   //--- ��������� �������� (��������/������������)
   bool              m_spin_edit_state;
   //--- ����� ������ �������� �� ������������
   bool              m_reset_mode;
   //--- �����������/������������ ��������
   double            m_min_value;
   double            m_max_value;
   //--- ��� ��� ��������� �������� � ���� �����
   double            m_step_value;
   //--- ����� ������������ ������
   ENUM_ALIGN_MODE   m_align_mode;
   //--- ������� ������� ��� ��������� ������
   int               m_timer_counter;
   //--- ���������� ������ ����� �������
   int               m_digits;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //---
public:
                     CSpinEdit(void);
                    ~CSpinEdit(void);
   //--- ������ ��� �������� ���� �����
   bool              CreateSpinEdit(const long chart_id,const int subwin,const string label_text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateEdit(void);
   bool              CreateSpinInc(void);
   bool              CreateSpinDec(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) �����������/��������� ��������� ����������� ���� �����
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);         }
   bool              SpinEditState(void)                      const { return(m_spin_edit_state);          }
   void              SpinEditState(const bool state);
   //--- (1) ���� ����, (2) ����� �������� ���� �����, (3) ������� ��������� �����
   void              AreaColor(const color clr)                     { m_area_color=clr;                   }
   string            LabelText(void)                          const { return(m_label.Description());      }
   void              LabelXGap(const int x_gap)                     { m_label_x_gap=x_gap;                }
   void              LabelYGap(const int y_gap)                     { m_label_y_gap=y_gap;                }
   //--- ����� ��������� ����� � ������ ����������
   void              LabelColor(const color clr)                    { m_label_color=clr;                  }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;            }
   void              LabelColorLocked(const color clr)              { m_label_color_locked=clr;           }
   //--- (1) ������� ���� �����, (2) ������ ���� ����� �� ������� ����
   void              EditXSize(const int x_size)                    { m_edit_x_size=x_size;               }
   void              EditYSize(const int y_size)                    { m_edit_y_size=y_size;               }
   void              EditXGap(const int x_gap)                      { m_edit_x_gap=x_gap;                 }
   //--- ����� ���� ����� � ������ ����������
   void              EditColor(const color clr)                     { m_edit_color=clr;                   }
   void              EditColorLocked(const color clr)               { m_edit_color_locked=clr;            }
   //--- ����� ������ ���� ����� � ������ ����������
   void              EditTextColor(const color clr)                 { m_edit_text_color=clr;              }
   void              EditTextColorLocked(const color clr)           { m_edit_text_color_locked=clr;       }
   void              EditTextColorHighlight(const color clr)        { m_edit_text_color_highlight=clr;    }
   //--- ����� ����� ���� ����� � ������ ����������
   void              EditBorderColor(const color clr)               { m_edit_border_color=clr;            }
   void              EditBorderColorHover(const color clr)          { m_edit_border_color_hover=clr;      }
   void              EditBorderColorLocked(const color clr)         { m_edit_border_color_locked=clr;     }
   //--- ��������� ������� ��� ������ � �������� � ��������������� ����������
   void              IncFileOn(const string file_path)              { m_inc_bmp_file_on=file_path;        }
   void              IncFileOff(const string file_path)             { m_inc_bmp_file_off=file_path;       }
   void              IncFileLocked(const string file_path)          { m_inc_bmp_file_locked=file_path;    }
   void              DecFileOn(const string file_path)              { m_dec_bmp_file_on=file_path;        }
   void              DecFileOff(const string file_path)             { m_dec_bmp_file_off=file_path;       }
   void              DecFileLocked(const string file_path)          { m_dec_bmp_file_locked=file_path;    }
   //--- ������� ��� ������ ���� �����
   void              IncXGap(const int x_gap)                       { m_inc_x_gap=x_gap;                  }
   void              IncYGap(const int y_gap)                       { m_inc_y_gap=y_gap;                  }
   void              DecXGap(const int x_gap)                       { m_dec_x_gap=x_gap;                  }
   void              DecYGap(const int y_gap)                       { m_dec_y_gap=y_gap;                  }
   //--- ��������� ������ ���� �����
   bool              StateInc(void)                           const { return(m_spin_inc.State());         }
   bool              StateDec(void)                           const { return(m_spin_dec.State());         }
   //--- ����� ������ ��� ������� �� ��������� �����
   bool              ResetMode(void)                                { return(m_reset_mode);               }
   void              ResetMode(const bool mode)                     { m_reset_mode=mode;                  }
   //--- ����������� ��������
   double            MinValue(void)                           const { return(m_min_value);                }
   void              MinValue(const double value)                   { m_min_value=value;                  }
   //--- ������������ ��������
   double            MaxValue(void)                           const { return(m_max_value);                }
   void              MaxValue(const double value)                   { m_max_value=value;                  }
   //--- ��� ��������
   double            StepValue(void)                          const { return(m_step_value);               }
   void              StepValue(const double value)                  { m_step_value=(value<=0)? 1 : value; }
   //--- (1) ���������� ������ ����� �������, (2) ����� ������������ ������, (3) ����������� � ��������� �������� ���� �����
   void              SetDigits(const int digits)                    { m_digits=::fabs(digits);            }
   void              AlignMode(ENUM_ALIGN_MODE mode)                { m_align_mode=mode;                  }
   double            GetValue(void)                           const { return(m_edit_value);               }
   bool              SetValue(const double value);
   //--- ��������� �������� � ���� �����
   void              ChangeValue(const double value);
   //--- ��������� ����� ��������
   void              ChangeObjectsColor(void);
   //--- ������������ ��� ���������� ������
   void              HighlightLimit(void);
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
   //--- ��������� ������� �� ��������� �����
   bool              OnClickLabel(const string clicked_object);
   //--- ��������� ����� �������� � ���� �����
   bool              OnEndEdit(const string edited_object);
   //--- ��������� ������� ������ ���� �����
   bool              OnClickSpinInc(const string clicked_object);
   bool              OnClickSpinDec(const string clicked_object);
   //--- ���������� ��������� �������� � ���� �����
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CSpinEdit::CSpinEdit(void) : m_digits(2),
                             m_edit_value(WRONG_VALUE),
                             m_min_value(DBL_MIN),
                             m_max_value(DBL_MAX),
                             m_step_value(1),
                             m_reset_mode(false),
                             m_align_mode(ALIGN_LEFT),
                             m_spin_edit_state(true),
                             m_timer_counter(SPIN_DELAY_MSC),
                             m_area_color(C'15,15,15'),
                             m_label_x_gap(0),
                             m_label_y_gap(2),
                             m_label_color(clrWhite),
                             m_label_color_hover(C'85,170,255'),
                             m_label_color_locked(clrGray),
                             m_edit_y_size(18),
                             m_edit_x_gap(15),
                             m_edit_color(clrWhite),
                             m_edit_color_locked(clrDimGray),
                             m_edit_text_color(clrBlack),
                             m_edit_text_color_locked(clrGray),
                             m_edit_text_color_highlight(clrRed),
                             m_edit_border_color(clrGray),
                             m_edit_border_color_hover(C'85,170,255'),
                             m_edit_border_color_locked(clrGray),
                             m_inc_x_gap(16),
                             m_inc_y_gap(0),
                             m_dec_x_gap(16),
                             m_dec_y_gap(8),
                             m_inc_bmp_file_on(""),
                             m_inc_bmp_file_off(""),
                             m_inc_bmp_file_locked(""),
                             m_dec_bmp_file_on(""),
                             m_dec_bmp_file_off(""),
                             m_dec_bmp_file_locked("")

  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_area_zorder  =1;
   m_label_zorder =0;
   m_edit_zorder  =2;
   m_spin_zorder  =3;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSpinEdit::~CSpinEdit(void)
  {
  }
//+------------------------------------------------------------------+
//| ��������� �������                                                |
//+------------------------------------------------------------------+
void CSpinEdit::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_spin_inc.MouseFocus(x>m_spin_inc.X() && x<m_spin_inc.X2() && y>m_spin_inc.Y() && y<m_spin_inc.Y2());
      m_spin_dec.MouseFocus(x>m_spin_dec.X() && x<m_spin_dec.X2() && y>m_spin_dec.Y() && y<m_spin_dec.Y2());
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- �����, ���� ������� ������������
      if(!m_spin_edit_state)
         return;
      //--- ��������� ������� �� ��������� �����
      if(OnClickLabel(sparam))
         return;
      //--- ��������� ������� ������ ���� �����
      if(OnClickSpinInc(sparam))
         return;
      if(OnClickSpinDec(sparam))
         return;
      //---
      return;
     }
//--- ��������� ������� ��������� �������� � ���� �����
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      //--- �����, ���� ������� ������������
      if(!m_spin_edit_state)
         return;
      //--- ��������� ����� ��������
      if(OnEndEdit(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CSpinEdit::OnEventTimer(void)
  {
//--- ���� ������� ����������
   if(CElement::IsDropdown())
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
  }
//+------------------------------------------------------------------+
//| ������ ������ �������� �������������� ���� �����                |
//+------------------------------------------------------------------+
bool CSpinEdit::CreateSpinEdit(const long chart_id,const int subwin,const string label_text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ���� ����� ������ ����� �������� "
              "��������� �� �����: CSpinEdit::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =x;
   m_y          =y;
   m_label_text =label_text;
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
   if(!CreateSpinInc())
      return(false);
   if(!CreateSpinDec())
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
bool CSpinEdit::CreateArea(void)
  {
//--- ������������ ����� �������
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_area_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_area_"+(string)CElement::Index()+"__"+(string)CElement::Id();
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
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� �������������� ���� �����                          |
//+------------------------------------------------------------------+
bool CSpinEdit::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_lable_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_lable_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+m_label_x_gap;
   int y=CElement::Y()+m_label_y_gap;
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
   m_label.Z_Order(m_label_zorder);
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
//| ������ ���� ����� � ���������������                             |
//+------------------------------------------------------------------+
bool CSpinEdit::CreateEdit(void)
  {
//--- ������������ ����� �������
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_edit_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_edit_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x =CElement::X2()-m_edit_x_size-m_edit_x_gap;
   int y =CElement::Y()-1;
//--- ��������� ������
   if(!m_edit.Create(m_chart_id,name,m_subwin,x,y,m_edit_x_size,m_edit_y_size))
      return(false);
//--- ��������� ��������
   m_edit.Font(FONT);
   m_edit.FontSize(FONT_SIZE);
   m_edit.TextAlign(m_align_mode);
   m_edit.Description(::DoubleToString(m_edit_value,m_digits));
   m_edit.Color(m_edit_text_color);
   m_edit.BackColor(m_edit_color);
   m_edit.BorderColor(m_edit_border_color);
   m_edit.Corner(m_corner);
   m_edit.Anchor(m_anchor);
   m_edit.Selectable(false);
   m_edit.Z_Order(m_edit_zorder);
   m_edit.Tooltip("\n");
//--- �������� ����������
   m_edit.X(x);
   m_edit.Y(y);
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
//| ������ ������������� �����                                      |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinInc_blue.bmp"
//---
bool CSpinEdit::CreateSpinInc(void)
  {
//--- ������������ ����� �������
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_spin_inc_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_spin_inc_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x =CElement::X2()-m_inc_x_gap;
   int y =CElement::Y()+m_inc_y_gap;
//--- ���� �� ������� �������� ��� �������������, ������ ��������� �� ���������
   if(m_inc_bmp_file_on=="")
      m_inc_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\SpinInc_blue.bmp";
   if(m_inc_bmp_file_off=="")
      m_inc_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp";
   if(m_inc_bmp_file_locked=="")
      m_inc_bmp_file_locked="Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp";
//--- ��������� ������
   if(!m_spin_inc.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_spin_inc.BmpFileOn("::"+m_inc_bmp_file_on);
   m_spin_inc.BmpFileOff("::"+m_inc_bmp_file_off);
   m_spin_inc.Corner(m_corner);
   m_spin_inc.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_spin_inc.Selectable(false);
   m_spin_inc.Z_Order(m_spin_zorder);
   m_spin_inc.Tooltip("\n");
//--- �������� ������� (� �������)
   m_spin_inc.XSize(m_spin_inc.X_Size());
   m_spin_inc.YSize(m_spin_inc.Y_Size());
//--- �������� ����������
   m_spin_inc.X(x);
   m_spin_inc.Y(y);
//--- ������� �� ������� �����
   m_spin_inc.XGap(x-m_wnd.X());
   m_spin_inc.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_spin_inc);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������� ����                                       |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinDec_blue.bmp"
//---
bool CSpinEdit::CreateSpinDec(void)
  {
//--- ������������ ����� �������
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_spin_dec_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_spin_dec_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ����������
   int x =CElement::X2()-m_dec_x_gap;
   int y =CElement::Y()+m_dec_y_gap;
//--- ���� �� ������� �������� ��� �������������, ������ ��������� �� ���������
   if(m_dec_bmp_file_on=="")
      m_dec_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\SpinDec_blue.bmp";
   if(m_dec_bmp_file_off=="")
      m_dec_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp";
   if(m_dec_bmp_file_locked=="")
      m_dec_bmp_file_locked="Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp";
//--- ��������� ������
   if(!m_spin_dec.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_spin_dec.BmpFileOn("::"+m_dec_bmp_file_on);
   m_spin_dec.BmpFileOff("::"+m_dec_bmp_file_off);
   m_spin_dec.Corner(m_corner);
   m_spin_dec.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_spin_dec.Selectable(false);
   m_spin_dec.Z_Order(m_spin_zorder);
   m_spin_dec.Tooltip("\n");
//--- �������� ������� (� �������)
   m_spin_dec.XSize(m_spin_dec.X_Size());
   m_spin_dec.YSize(m_spin_dec.Y_Size());
//--- �������� ����������
   m_spin_dec.X(x);
   m_spin_dec.Y(y);
//--- ������� �� ������� �����
   m_spin_dec.XGap(x-m_wnd.X());
   m_spin_dec.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_spin_dec);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� �������� � ���� �����                                  |
//+------------------------------------------------------------------+
void CSpinEdit::ChangeValue(const double value)
  {
//--- ��������, ������������� � �������� ����� ��������
   SetValue(value);
//--- ��������� ����� �������� � ���� �����
   m_edit.Description(::DoubleToString(GetValue(),m_digits));
  }
//+------------------------------------------------------------------+
//| �������� �������� ��������                                       |
//+------------------------------------------------------------------+
bool CSpinEdit::SetValue(double value)
  {
//--- ��� �������������
   double corrected_value =0.0;
//--- ������������� � ������ ����
   corrected_value=::MathRound(value/m_step_value)*m_step_value;
//--- �������� �� �������/��������
   if(corrected_value<m_min_value)
     {
      //--- ���������� ����������� ��������
      corrected_value=m_min_value;
      //--- ��������� ��������� On
      m_spin_dec.State(true);
      //--- ����������, ������� ���� � ���������� ������
      HighlightLimit();
     }
   if(corrected_value>m_max_value)
     {
      //--- ���������� ������������ ��������
      corrected_value=m_max_value;
      //--- ��������� ��������� On
      m_spin_inc.State(true);
      //--- ����������, ������� ���� � ���������� ������
      HighlightLimit();
     }
//--- ���� �������� ���� ��������
   if(m_edit_value!=corrected_value)
     {
      m_edit_value=corrected_value;
      m_edit.Color(m_edit_text_color);
      return(true);
     }
//--- �������� ��� ���������
   return(false);
  }
//+------------------------------------------------------------------+
//| ������������� ������                                             |
//+------------------------------------------------------------------+
void CSpinEdit::HighlightLimit(void)
  {
//--- �������� �������� ���� ������
   m_edit.Color(m_edit_text_color_highlight);
//--- ��������
   ::ChartRedraw();
//--- �������� ����� ������������ � ��������� �����
   ::Sleep(100);
//--- �������� ���� ������ �� ��������
   m_edit.Color(m_edit_text_color);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ��������                                     |
//+------------------------------------------------------------------+
void CSpinEdit::SpinEditState(const bool state)
  {
   m_spin_edit_state=state;
//--- ���� ��������� �����
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- ���� ���� �����
   m_edit.Color((state)? m_edit_text_color : m_edit_text_color_locked);
   m_edit.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_edit.BorderColor((state)? m_edit_border_color : m_edit_border_color_locked);
//--- �������� ��������������
   m_spin_inc.BmpFileOn((state)? "::"+m_inc_bmp_file_on : "::"+m_inc_bmp_file_locked);
   m_spin_dec.BmpFileOn((state)? "::"+m_dec_bmp_file_on : "::"+m_dec_bmp_file_locked);
//--- ��������� ������������ �������� ���������
   if(!m_spin_edit_state)
     {
      //--- ����������
      m_edit.Z_Order(-1);
      m_spin_inc.Z_Order(-1);
      m_spin_dec.Z_Order(-1);
      //--- ���� ����� � ����� "������ ������"
      m_edit.ReadOnly(true);
     }
   else
     {
      //--- ����������
      m_edit.Z_Order(m_edit_zorder);
      m_spin_inc.Z_Order(m_spin_zorder);
      m_spin_dec.Z_Order(m_spin_zorder);
      //--- ���� ����� � ����� ��������������
      m_edit.ReadOnly(false);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CSpinEdit::ChangeObjectsColor(void)
  {
//--- �����, ���� ������� ������������
   if(!m_spin_edit_state)
      return;
//--- ����� �� �������
   m_spin_inc.State(m_spin_inc.MouseFocus());
   m_spin_dec.State(m_spin_dec.MouseFocus());
//--- ����� �� ��������� ����� � ���� �����
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_edit.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CSpinEdit::Moving(const int x,const int y)
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
   m_spin_inc.X(x+m_spin_inc.XGap());
   m_spin_inc.Y(y+m_spin_inc.YGap());
   m_spin_dec.X(x+m_spin_dec.XGap());
   m_spin_dec.Y(y+m_spin_dec.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_edit.X_Distance(m_edit.X());
   m_edit.Y_Distance(m_edit.Y());
   m_spin_inc.X_Distance(m_spin_inc.X());
   m_spin_inc.Y_Distance(m_spin_inc.Y());
   m_spin_dec.X_Distance(m_spin_dec.X());
   m_spin_dec.Y_Distance(m_spin_dec.Y());
  }
//+------------------------------------------------------------------+
//| ���������� �����-����                                            |
//+------------------------------------------------------------------+
void CSpinEdit::Show(void)
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
void CSpinEdit::Hide(void)
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
void CSpinEdit::Reset(void)
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
void CSpinEdit::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   m_label.Delete();
   m_edit.Delete();
   m_spin_inc.Delete();
   m_spin_dec.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CSpinEdit::SetZorders(void)
  {
//--- �����, ���� ������� ������������
   if(!m_spin_edit_state)
      return;
//--- ���������� ����������
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_label_zorder);
   m_edit.Z_Order(m_edit_zorder);
   m_spin_inc.Z_Order(m_spin_zorder);
   m_spin_dec.Z_Order(m_spin_zorder);
//--- ���� ����� � ����� ��������������
   m_edit.ReadOnly(false);
//--- ������������ �������� � ��������������
   m_spin_inc.BmpFileOn("::"+m_inc_bmp_file_on);
   m_spin_dec.BmpFileOn("::"+m_dec_bmp_file_on);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CSpinEdit::ResetZorders(void)
  {
//--- �����, ���� ������� ������������
   if(!m_spin_edit_state)
      return;
//--- �������� ����������
   m_area.Z_Order(-1);
   m_label.Z_Order(-1);
   m_edit.Z_Order(-1);
   m_spin_inc.Z_Order(-1);
   m_spin_dec.Z_Order(-1);
//--- ���� ����� � ����� "������ ������"
   m_edit.ReadOnly(true);
//--- �������� �������� � ��������������
   m_spin_inc.BmpFileOn("::"+m_inc_bmp_file_off);
   m_spin_dec.BmpFileOn("::"+m_dec_bmp_file_off);
  }
//+------------------------------------------------------------------+
//| ����� ����� �������� ��������                                    |
//+------------------------------------------------------------------+
void CSpinEdit::ResetColors(void)
  {
//--- �����, ���� ������� ������������
   if(!m_spin_edit_state)
      return;
//--- �������� ����
   m_label.Color(m_label_color);
   m_edit.BorderColor(m_edit_border_color);
//--- ������� �����
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ��������� �����                             |
//+------------------------------------------------------------------+
bool CSpinEdit::OnClickLabel(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������
   if(m_area.Name()!=clicked_object)
      return(false);
//--- ���� ������� ����� ������ ��������
   if(m_reset_mode)
     {
      //--- ��������� ����������� ��������
      ChangeValue(MinValue());
     }
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ����� �������� � ���� �����                            |
//+------------------------------------------------------------------+
bool CSpinEdit::OnEndEdit(const string edited_object)
  {
//--- ������, ���� ����� ��� �������
   if(m_edit.Name()!=edited_object)
      return(false);
//--- ������� �������� ��������
   double entered_value=::StringToDouble(m_edit.Description());
//--- ��������, ������������� � �������� ����� ��������
   ChangeValue(entered_value);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������������� ����������                              |
//+------------------------------------------------------------------+
bool CSpinEdit::OnClickSpinInc(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������
   if(m_spin_inc.Name()!=clicked_object)
      return(false);
//--- ������� ������� ��������
   double value=GetValue();
//--- �������� �� ���� ��� � �������� �� ����� �� �����������
   ChangeValue(value+m_step_value);
//--- ��������� ��������� On
   m_spin_inc.State(true);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_INC,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������������� ����������                              |
//+------------------------------------------------------------------+
bool CSpinEdit::OnClickSpinDec(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������
   if(m_spin_dec.Name()!=clicked_object)
      return(false);
//--- ������� ������� ��������
   double value=GetValue();
//--- �������� �� ���� ��� � �������� �� ����� �� �����������
   ChangeValue(value-m_step_value);
//--- ��������� ��������� On
   m_spin_dec.State(true);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_DEC,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� �������� �������� � ���� �����                        |
//+------------------------------------------------------------------+
void CSpinEdit::FastSwitching(void)
  {
//--- ������, ���� ��� ������ �� ��������
   if(!CElement::MouseFocus())
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
      //--- ������� ������� �������� � ���� �����
      double current_value =::StringToDouble(m_edit.Description());
      //--- ���� ��������� 
      if(m_spin_inc.State())
         SetValue(current_value+m_step_value);
      //--- ���� ���������
      else if(m_spin_dec.State())
         SetValue(current_value-m_step_value);
      //--- ������� ��������, ���� ������-������������� �� ��� ������
      if(m_spin_inc.State() || m_spin_dec.State())
         m_edit.Description(::DoubleToString(GetValue(),m_digits));
     }
  }
//+------------------------------------------------------------------+
