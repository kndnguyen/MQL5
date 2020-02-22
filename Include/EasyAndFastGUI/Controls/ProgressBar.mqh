//+------------------------------------------------------------------+
//|                                                  ProgressBar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ���������� ����������                         |
//+------------------------------------------------------------------+
class CProgressBar : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ��������
   CRectLabel        m_area;
   CLabel            m_label;
   CRectLabel        m_bar_bg;
   CRectLabel        m_indicator;
   CLabel            m_percent;
   //--- ���� ���� ��������
   color             m_area_color;
   //--- �������� ������������� ��������
   string            m_label_text;
   //--- ���� ������
   color             m_label_color;
   //--- �������� ��������� ����� �� ���� ����
   int               m_label_x_offset;
   int               m_label_y_offset;
   //--- ����� ���� ��������-���� � ����� ����
   color             m_bar_area_color;
   color             m_bar_border_color;
   //--- ������� ��������-����
   int               m_bar_x_size;
   int               m_bar_y_size;
   //--- �������� ��������-���� �� ���� ����
   int               m_bar_x_offset;
   int               m_bar_y_offset;
   //--- ������� ����� ��������-����
   int               m_bar_border_width;
   //--- ���� ����������
   color             m_indicator_color;
   //--- �������� ����� ���������� ���������
   int               m_percent_x_offset;
   int               m_percent_y_offset;
   //--- ���������� ������ ����� �������
   int               m_digits;
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   //--- ���������� ����� ���������
   double            m_steps_total;
   //--- ������� ������� ����������
   double            m_current_index;
   //---
public:
                     CProgressBar(void);
                    ~CProgressBar(void);
   //--- ������ ��� �������� ��������
   bool              CreateProgressBar(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateBarArea(void);
   bool              CreateIndicator(void);
   bool              CreatePercent(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ������ ����� �������
   void              WindowPointer(CWindow &object)     { m_wnd=::GetPointer(object);      }
   void              SetDigits(const int digits)        { m_digits=::fabs(digits);         }
   //--- (1) ���� ����, (2) �������� �������� � (3) ���� ������
   void              AreaColor(const color clr)         { m_area_color=clr;                }
   void              LabelText(const string text)       { m_label_text=text;               }
   void              LabelColor(const color clr)        { m_label_color=clr;               }
   //--- �������� ��������� ����� (�������� ��������)
   void              LabelXOffset(const int x_offset)   { m_label_x_offset=x_offset;       }
   void              LabelYOffset(const int y_offset)   { m_label_y_offset=y_offset;       }
   //--- ���� (1) ���� � (2) ����� ��������-����, (3) ���� ����������
   void              BarAreaColor(const color clr)      { m_bar_area_color=clr;            }
   void              BarBorderColor(const color clr)    { m_bar_border_color=clr;          }
   void              IndicatorColor(const color clr)    { m_indicator_color=clr;           }
   //--- (1) ������� �����, (2) ������� ������� ����������
   void              BarBorderWidth(const int width)    { m_bar_border_width=width;        }
   void              BarXSize(const int x_size)         { m_bar_x_size=x_size;             }
   void              BarYSize(const int y_size)         { m_bar_y_size=y_size;             }
   //--- (1) �������� �������� ���� �� ���� ����, (2) �������� ����� ���������� ���������
   void              BarXOffset(const int x_offset)     { m_bar_x_offset=x_offset;         }
   void              BarYOffset(const int y_offset)     { m_bar_y_offset=y_offset;         }
   //--- �������� ��������� ����� (�������� ��������)
   void              PercentXOffset(const int x_offset) { m_percent_x_offset=x_offset;     }
   void              PercentYOffset(const int y_offset) { m_percent_y_offset=y_offset;     }
   
   //--- ���������� ���������� �� ��������� ���������
   void              Update(const int index,const int total);
   //---
private:
   //--- ��������� ����� �������� ��� ����������
   void              CurrentIndex(const int index);
   void              StepsTotal(const int total);
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
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
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgressBar::CProgressBar(void) : m_digits(0),
                                   m_steps_total(1),
                                   m_current_index(0),
                                   m_area_color(clrWhiteSmoke),
                                   m_label_x_offset(0),
                                   m_label_y_offset(1),
                                   m_bar_x_offset(0),
                                   m_bar_y_offset(0),
                                   m_bar_border_width(0),
                                   m_percent_x_offset(7),
                                   m_percent_y_offset(1),
                                   m_label_text("Progress:"),
                                   m_label_color(clrBlack),
                                   m_bar_area_color(C'225,225,225'),
                                   m_bar_border_color(C'225,225,225'),
                                   m_indicator_color(clrMediumSeaGreen)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder=0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CProgressBar::~CProgressBar(void)
  {
  }
//+------------------------------------------------------------------+
//| ������ ������� "��������� ���������"                            |
//+------------------------------------------------------------------+
bool CProgressBar::CreateProgressBar(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ���������� ���������� ������ ����� �������� "
              "��������� �� �����: CProgressBar::WindowPointer(CWindow &object).");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� �������� ��������
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateBarArea())
      return(false);
   if(!CreateIndicator())
      return(false);
   if(!CreatePercent())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� ��������                                       |
//+------------------------------------------------------------------+
bool CProgressBar::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_progress_area_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X();
   int y=CElement::Y();
//--- ��������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- ��������� ��������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- ����������
   m_area.X(x);
   m_area.Y(y);
//--- ����������
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- ������� �� ������� �����
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� � ��������� ��������                               |
//+------------------------------------------------------------------+
bool CProgressBar::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_progress_lable_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+m_label_x_offset;
   int y=CElement::Y()+m_label_y_offset;
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
//| ������ ��� �������� ����                                        |
//+------------------------------------------------------------------+
bool CProgressBar::CreateBarArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_progress_bar_area_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+m_bar_x_offset;
   int y=CElement::Y()+m_bar_y_offset;
//--- ��������� ������
   if(!m_bar_bg.Create(m_chart_id,name,m_subwin,x,y,m_bar_x_size,m_bar_y_size))
      return(false);
//--- ��������� ��������
   m_bar_bg.BackColor(m_bar_area_color);
   m_bar_bg.Color(m_bar_border_color);
   m_bar_bg.BorderType(BORDER_FLAT);
   m_bar_bg.Corner(m_corner);
   m_bar_bg.Selectable(false);
   m_bar_bg.Z_Order(m_zorder);
   m_bar_bg.Tooltip("\n");
//--- ����������
   m_bar_bg.X(x);
   m_bar_bg.Y(y);
//--- ����������
   m_bar_bg.XSize(m_bar_x_size);
   m_bar_bg.YSize(m_bar_y_size);
//--- ������� �� ������� �����
   m_bar_bg.XGap(x-m_wnd.X());
   m_bar_bg.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_bar_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ���������                                      |
//+------------------------------------------------------------------+
bool CProgressBar::CreateIndicator(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_progress_bar_indicator_"+(string)CElement::Id();
//--- ����������
   int x=m_bar_bg.X()+m_bar_border_width;
   int y=m_bar_bg.Y()+m_bar_border_width;
//--- �������
   int x_size=1;
   int y_size=m_bar_bg.YSize()-(m_bar_border_width*2);
//--- ��������� ������
   if(!m_indicator.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- ��������� ��������
   m_indicator.BackColor(m_indicator_color);
   m_indicator.Color(m_indicator_color);
   m_indicator.BorderType(BORDER_FLAT);
   m_indicator.Corner(m_corner);
   m_indicator.Selectable(false);
   m_indicator.Z_Order(m_zorder);
   m_indicator.Tooltip("\n");
//--- ����������
   m_indicator.X(x);
   m_indicator.Y(y);
//--- ����������
   m_indicator.XSize(x_size);
   m_indicator.YSize(y_size);
//--- ������� �� ������� �����
   m_indicator.XGap(x-m_wnd.X());
   m_indicator.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_indicator);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� � ����������� ��������� ���������                  |
//+------------------------------------------------------------------+
bool CProgressBar::CreatePercent(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_progress_percent_"+(string)CElement::Id();
//--- ����������
   int x=m_bar_bg.X2()+m_percent_x_offset;
   int y=CElement::Y()+m_percent_y_offset;
//--- ��������� ������
   if(!m_percent.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_percent.Description("0%");
   m_percent.Font(FONT);
   m_percent.FontSize(FONT_SIZE);
   m_percent.Color(m_label_color);
   m_percent.Corner(m_corner);
   m_percent.Anchor(m_anchor);
   m_percent.Selectable(false);
   m_percent.Z_Order(m_zorder);
   m_percent.Tooltip("\n");
//--- ������� �� ������� �����
   m_percent.XGap(x-m_wnd.X());
   m_percent.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_percent);
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� ����� �������� ����                                   |
//+------------------------------------------------------------------+
void CProgressBar::StepsTotal(const int total)
  {
//--- ���������������, ���� ������ 0
   m_steps_total=(total<1)? 1 : total;
//--- ��������������� ������, ���� ����� �� ���������
   if(m_current_index>m_steps_total)
      m_current_index=m_steps_total;
  }
//+------------------------------------------------------------------+
//| ������� ������� ����������                                       |
//+------------------------------------------------------------------+
void CProgressBar::CurrentIndex(const int index)
  {
//--- ���������������, ���� ������ 0
   if(index<0)
      m_current_index=1;
//--- ��������������� ������, ���� ����� �� ���������
   else
      m_current_index=(index>m_steps_total)? m_steps_total : index;
  }
//+------------------------------------------------------------------+
//| ��������� �������� ���                                           |
//+------------------------------------------------------------------+
void CProgressBar::Update(const int index,const int total)
  {
//--- ���������� ����� ������
   CurrentIndex(index);
//--- ���������� ����� ��������
   StepsTotal(total);
//--- ���������� ������ ����������
   double new_width=(m_current_index/m_steps_total)*m_bar_bg.XSize();
//--- ���������������, ���� ������ 1
   if((int)new_width<1)
      new_width=1;
   else
     {
      //--- ��������������� � ������ ������ �����
      int x_size=m_bar_bg.XSize()-(m_bar_border_width*2);
      //--- ���������������, ���� ����� �� �������
      if((int)new_width>=x_size)
         new_width=x_size;
     }
//--- ��������� ���������� ����� ������
   m_indicator.X_Size((int)new_width);
//--- ���������� ������� � ���������� ������
   double percent =m_current_index/m_steps_total*100;
   string desc    =::DoubleToString((percent>100)? 100 : percent,m_digits)+"%";
//--- ��������� ����� ��������
   m_percent.Description(desc);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CProgressBar::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� �������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_area.X(x+m_label.XGap());
   m_area.Y(y+m_label.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_bar_bg.X(x+m_bar_bg.XGap());
   m_bar_bg.Y(y+m_bar_bg.YGap());
   m_indicator.X(x+m_indicator.XGap());
   m_indicator.Y(y+m_indicator.YGap());
   m_percent.X(x+m_percent.XGap());
   m_percent.Y(y+m_percent.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_label.X());
   m_area.Y_Distance(m_label.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_bar_bg.X_Distance(m_bar_bg.X());
   m_bar_bg.Y_Distance(m_bar_bg.Y());
   m_indicator.X_Distance(m_indicator.X());
   m_indicator.Y_Distance(m_indicator.Y());
   m_percent.X_Distance(m_percent.X());
   m_percent.Y_Distance(m_percent.Y());
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CProgressBar::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
//--- �������� �������������� �������� �� �����
   Moving(m_wnd.X(),m_wnd.Y());
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CProgressBar::Hide(void)
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
void CProgressBar::Reset(void)
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
void CProgressBar::Delete(void)
  {
   m_area.Delete();
   m_label.Delete();
   m_bar_bg.Delete();
   m_indicator.Delete();
   m_percent.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CProgressBar::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_bar_bg.Z_Order(m_zorder);
   m_indicator.Z_Order(m_zorder);
   m_percent.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CProgressBar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_bar_bg.Z_Order(0);
   m_indicator.Z_Order(0);
   m_percent.Z_Order(0);
  }
//+------------------------------------------------------------------+
