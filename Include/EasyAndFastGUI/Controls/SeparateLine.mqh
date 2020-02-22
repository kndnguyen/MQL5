//+------------------------------------------------------------------+
//|                                                 SeparateLine.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� �������������� �����                          |
//+------------------------------------------------------------------+
class CSeparateLine : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������ ��� �������� �������������� �����
   CRectCanvas       m_canvas;
   //--- ��������
   ENUM_TYPE_SEP_LINE m_type_sep_line;   
   color             m_dark_color;
   color             m_light_color;
   //---
public:
                     CSeparateLine(void);
                    ~CSeparateLine(void);
   //--- ��������� ��������� ���������� �����
   void              WindowPointer(CWindow &object) { m_wnd=::GetPointer(object); }
   //--- �������� �������������� �����
   bool              CreateSeparateLine(const long chart_id,const int subwin,const int index,
                                        const int x,const int y,const int x_size,const int y_size);
   //---
private:
   //--- ������ ����� ��� ��������� �������������� �����
   bool              CreateSepLine(void);
   //--- ������ �������������� �����
   void              DrawSeparateLine(void);
   //---
public:
   //--- (1) ��� �����, (2) ����� �����
   void              TypeSepLine(const ENUM_TYPE_SEP_LINE type) { m_type_sep_line=type; }
   void              DarkColor(const color clr)                 { m_dark_color=clr;     }
   void              LightColor(const color clr)                { m_light_color=clr;    }
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
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
CSeparateLine::CSeparateLine(void) : m_type_sep_line(H_SEP_LINE),
                                     m_dark_color(clrBlack),
                                     m_light_color(clrDimGray)
  {
//--- �������� ��� ������ �������� � ������� ������  
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSeparateLine::~CSeparateLine(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CSeparateLine::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
  }
//+------------------------------------------------------------------+
//| ������ �������������� �����                                     |
//+------------------------------------------------------------------+
bool CSeparateLine::CreateSeparateLine(const long chart_id,const int subwin,const int index,
                                       const int x,const int y,const int x_size,const int y_size)
  {
//--- �����, ���� ��� ��������� �� �����  
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� �������� ������ ����� �������� "
              "��������� �� �����: CSeparateLine::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_index    =index;
   m_x        =x;
   m_y        =y;
   m_x_size   =x_size;
   m_y_size   =y_size;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ��������
   if(!CreateSepLine())
      return(false);
//--- ���� ����� �������, �� �������� ������� ����� ��������
   if(m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� ��������� �������������� �����                 |
//+------------------------------------------------------------------+
bool CSeparateLine::CreateSepLine(void)
  {
//--- ������������ ����� �������  
   string name=CElement::ProgramName()+"_separate_line_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- �������� �������
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,m_x,m_y,m_x_size,m_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
      return(false);
//--- ���������� � �������
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- ��������
   m_canvas.Background(false);
//--- ������� �� ������� �����
   m_canvas.XGap(m_x-m_wnd.X());
   m_canvas.YGap(m_y-m_wnd.Y());
//--- ���������� �������������� �����
   DrawSeparateLine();
//--- �������� � ������
   CElement::AddToArray(m_canvas);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������������� �����                                      |
//+------------------------------------------------------------------+
void CSeparateLine::DrawSeparateLine(void)
  {
//--- ���������� ��� �����
   int x1=0,x2=0,y1=0,y2=0;
//--- ������� ������
   int   x_size =m_canvas.X_Size()-1;
   int   y_size =m_canvas.Y_Size()-1;
//--- �������� �����
   m_canvas.Erase(::ColorToARGB(clrNONE,0));
//--- ���� ����� ��������������
   if(m_type_sep_line==H_SEP_LINE)
     {
      //--- ������ ����� �����
      x1=0;
      y1=0;
      x2=x_size;
      y2=0;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_dark_color));
      //--- ����� ������� �����
      x1=0;
      x2=x_size;
      y1=y_size;
      y2=y_size;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_light_color));
     }
//--- ���� ����� ������������
   else
     {
      //--- ����� ����� �����
      x1=0;
      x2=0;
      y1=0;
      y2=y_size;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_dark_color));
      //--- ������ ������� �����
      x1=x_size;
      y1=0;
      x2=x_size;
      y2=y_size;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_light_color));
     }
//--- ���������� ������
   m_canvas.Update();
  }
//+------------------------------------------------------------------+
//| ����������� ��������                                             |
//+------------------------------------------------------------------+
void CSeparateLine::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_canvas.X(x+m_canvas.XGap());
   m_canvas.Y(y+m_canvas.YGap());
//--- ���������� ��������� ����������� ��������
   m_canvas.X_Distance(m_canvas.X());
   m_canvas.Y_Distance(m_canvas.Y());
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CSeparateLine::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������  
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
//--- ������������� ����������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CSeparateLine::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ �������
   m_canvas.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ������ �������� ��������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CSeparateLine::Reset(void)
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
void CSeparateLine::Delete(void)
  {
//--- �������� ��������
   m_canvas.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
