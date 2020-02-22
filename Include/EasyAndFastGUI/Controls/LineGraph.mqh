//+------------------------------------------------------------------+
//|                                                    LineGraph.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ��������� �������                             |
//+------------------------------------------------------------------+
class CLineGraph : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ��������
   CLineChartObject  m_line_chart;
   //--- ����� ���������
   color             m_bg_color;
   color             m_bg_color2;
   //--- ���� �����
   color             m_border_color;
   //--- ���� �����
   color             m_grid_color;
   //--- ���� ������
   color             m_text_color;
   //--- ���������� ������ ����� �������
   int               m_digits;
   //---
public:
                     CLineGraph(void);
                    ~CLineGraph(void);
   //--- ������ ��� �������� ��������
   bool              CreateLineGraph(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateGraph(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ������ ����� �������, (3) ������������ ���������� ����� ������
   void              WindowPointer(CWindow &object)    { m_wnd=::GetPointer(object);  }
   void              SetDigits(const int digits)       { m_digits=::fabs(digits);     }
   void              MaxData(const int total)          { m_line_chart.MaxData(total); }
   //--- ��� ����� ��� ���������
   void              BackgroundColor(const color clr)  { m_bg_color=clr;              }
   void              BackgroundColor2(const color clr) { m_bg_color2=clr;             }
   //--- ����� (1) �����, (2) ����� � (3) ������
   void              BorderColor(const color clr)      { m_border_color=clr;          }
   void              GridColor(const color clr)        { m_grid_color=clr;            }
   void              TextColor(const color clr)        { m_text_color=clr;            }
   //--- ��������� ���������� ������������ �����
   void              VScaleParams(const double max,const double min,const int num_grid);
   //--- ���������� ���� �� ������
   void              SeriesAdd(double &data[],const string descr,const color clr);
   //--- ���������� ���� �� �������
   void              SeriesUpdate(const uint pos,const double &data[],const string descr,const color clr);
   //--- �������� ���� � �������
   void              SeriesDelete(const uint pos);
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
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CLineGraph::CLineGraph(void) : m_digits(2),
                               m_bg_color(clrBlack),
                               m_bg_color2(C'0,80,95'),
                               m_border_color(clrDimGray),
                               m_grid_color(C'50,55,60'),
                               m_text_color(clrLightSlateGray)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CLineGraph::~CLineGraph(void)
  {
  }
//+------------------------------------------------------------------+
//| ������ ������                                                   |
//+------------------------------------------------------------------+
bool CLineGraph::CreateLineGraph(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������� ������ ����� �������� "
              "��������� �� �����: CLineGraph::WindowPointer(CWindow &object).");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- �������� ��������
   if(!CreateGraph())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� ���������                                      |
//+------------------------------------------------------------------+
bool CLineGraph::CreateGraph(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_line_graph_"+(string)CElement::Id();
//--- �������� �������
   if(!m_line_chart.CreateBitmapLabel(m_chart_id,m_subwin,name,m_x,m_y,m_x_size,m_y_size,COLOR_FORMAT_XRGB_NOALPHA))
      return(false);
//--- ���������� ������ � ������� ���������
   if(!m_line_chart.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- ��������
   m_line_chart.FontSet(FONT,-80,FW_NORMAL);
   m_line_chart.ScaleDigits(m_digits);
   m_line_chart.ColorBackground(m_bg_color);
   m_line_chart.ColorBackground2(m_bg_color2);
   m_line_chart.ColorBorder(m_border_color);
   m_line_chart.ColorGrid(::ColorToARGB(m_grid_color));
   m_line_chart.ColorText(::ColorToARGB(m_text_color));
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ������� (� ������)
   CElement::XSize(CElement::XSize());
   CElement::YSize(CElement::YSize());
//--- ������� �� ������� �����
   m_line_chart.XGap(CElement::X()-m_wnd.X());
   m_line_chart.YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_line_chart);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ���������� ��� Y                                       |
//+------------------------------------------------------------------+
void CLineGraph::VScaleParams(const double max,const double min,const int num_grid)
  {
   m_line_chart.VScaleParams(max,min,num_grid);
  }
//+------------------------------------------------------------------+
//| ���������� ����� �� ������                                       |
//+------------------------------------------------------------------+
void CLineGraph::SeriesAdd(double &data[],const string descr,const color clr)
  {
   m_line_chart.SeriesAdd(data,descr,::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| ���������� ����� �� �������                                      |
//+------------------------------------------------------------------+
void CLineGraph::SeriesUpdate(const uint pos,const double &data[],const string descr,const color clr)
  {
   m_line_chart.SeriesUpdate(pos,data,descr,::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| �������� ����� � �������                                         |
//+------------------------------------------------------------------+
void CLineGraph::SeriesDelete(const uint pos)
  {
   m_line_chart.SeriesDelete(pos);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CLineGraph::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_line_chart.X(x+m_line_chart.XGap());
   m_line_chart.Y(y+m_line_chart.YGap());
//--- ���������� ��������� ����������� ��������
   m_line_chart.X_Distance(m_line_chart.X());
   m_line_chart.Y_Distance(m_line_chart.Y());
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CLineGraph::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   m_line_chart.Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CLineGraph::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   m_line_chart.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CLineGraph::Reset(void)
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
void CLineGraph::Delete(void)
  {
   m_line_chart.DeleteAll();
   m_line_chart.Destroy();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
