//+------------------------------------------------------------------+
//|                                                      Tooltip.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ����������� ���������                         |
//+------------------------------------------------------------------+
class CTooltip : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ��������� �� �������, � �������� ������������ ����������� ���������
   CElement         *m_element;
   //--- ������� ��� �������� ����������� ���������
   CRectCanvas       m_canvas;
   //--- ��������:
   //    ���������
   string            m_header;
   //--- ������ ����� ������ ���������
   string            m_tooltip_lines[];
   //--- �������� �����-������ (������������ ���������)
   uchar             m_alpha;
   //--- ����� (1) ������, (2) ��������� � (3) ����� ����
   color             m_text_color;
   color             m_header_color;
   color             m_border_color;
   //--- ����� ��������� ����
   color             m_gradient_top_color;
   color             m_gradient_bottom_color;
   //--- ������ ��������� ����
   color             m_array_color[];
   //---
public:
                     CTooltip(void);
                    ~CTooltip(void);
   //--- ������ ��� �������� ����������� ���������
   bool              CreateTooltip(const long chart_id,const int subwin);
   //---
private:
   //--- ������ ����� ��� ��������� ���������
   bool              CreateCanvas(void);
   //--- (1) ������ ������������ �������� � (2) �����
   void              VerticalGradient(const uchar alpha);
   void              Border(const uchar alpha);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ��������� ��������, (3) ��������� ����������� ���������
   void              WindowPointer(CWindow &object)   { m_wnd=::GetPointer(object);     }
   void              ElementPointer(CElement &object) { m_element=::GetPointer(object); }
   void              Header(const string text)        { m_header=text;                  }
   //--- ��������� ������ ��� ���������
   void              AddString(const string text);

   //--- (1) ���������� � (2) �������� ����������� ���������
   void              ShowTooltip(void);
   void              FadeOutTooltip(void);
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
CTooltip::CTooltip(void) : m_header(""),
                           m_alpha(0),
                           m_text_color(clrDimGray),
                           m_header_color(C'50,50,50'),
                           m_border_color(C'118,118,118'),
                           m_gradient_top_color(clrWhite),
                           m_gradient_bottom_color(C'208,208,235')
  {
//--- �������� ��� ������ �������� � ������� ������  
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTooltip::~CTooltip(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CTooltip::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- �����, ���� ������ ����������� ��������� �� ����� ���������
      if(!m_wnd.TooltipBmpState())
         return;
      //--- ���� ����� �������������
      if(m_wnd.IsLocked())
        {
         //--- ������ ���������
         FadeOutTooltip();
         return;
        }
      //--- ���� ���� ����� �� ��������
      if(m_element.MouseFocus())
         //--- �������� ���������
         ShowTooltip();
      //--- ���� ��� ������
      else
      //--- ������ ���������
         FadeOutTooltip();
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������ ������ Tooltip                                           |
//+------------------------------------------------------------------+
bool CTooltip::CreateTooltip(const long chart_id,const int subwin)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ����������� ��������� ������ ����� �������� "
              "��������� �� �����: CTooltip::WindowPointer(CWindow &object).");
      return(false);
     }
//--- �����, ���� ��� ��������� �� �������
   if(::CheckPointer(m_element)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ����������� ��������� ������ ����� �������� "
              "��������� �� �������: CTooltip::ElementPointer(CElement &object).");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =m_element.X();
   m_y        =m_element.Y2()+1;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- ������ ����������� ���������
   if(!CreateCanvas())
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� ���������                                      |
//+------------------------------------------------------------------+
bool CTooltip::CreateCanvas(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_help_tooltip_"+(string)CElement::Id();
//--- �������� ����������� ���������
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,m_x,m_y,m_x_size,m_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
      return(false);
//--- ���������� � �������
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- ��������� ��������
   m_canvas.Background(false);
   m_canvas.Tooltip("\n");
//--- ������� �� ������� �����
   m_canvas.XGap(m_x-m_wnd.X());
   m_canvas.YGap(m_y-m_wnd.Y());
//--- ��������� ������� ������� ��������� ��� ���� ���������
   CElement::GradientColorsTotal(m_y_size);
   ::ArrayResize(m_array_color,m_y_size);
//--- ������������� ������� ���������
   CElement::InitColorArray(m_gradient_top_color,m_gradient_bottom_color,m_array_color);
//--- ������� ������ ��� ���������
   m_canvas.Erase(::ColorToARGB(clrNONE,0));
   m_canvas.Update();
   m_alpha=0;
//--- �������� ��������� �������
   CElement::AddToArray(m_canvas);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������                                                 |
//+------------------------------------------------------------------+
void CTooltip::AddString(const string text)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_tooltip_lines);
   ::ArrayResize(m_tooltip_lines,array_size+1);
//--- �������� �������� ���������� ����������
   m_tooltip_lines[array_size]=text;
  }
//+------------------------------------------------------------------+
//| ������������ ��������                                            |
//+------------------------------------------------------------------+
void CTooltip::VerticalGradient(const uchar alpha)
  {
//--- ���������� X
   int x1=0;
   int x2=m_x_size;
//--- ������ ��������
   for(int y=0; y<m_y_size; y++)
      m_canvas.Line(x1,y,x2,y,::ColorToARGB(m_array_color[y],alpha));
  }
//+------------------------------------------------------------------+
//| �����                                                            |
//+------------------------------------------------------------------+
void CTooltip::Border(const uchar alpha)
  {
//--- ���� �����
   color clr=m_border_color;
//--- �������
   int x_size =m_canvas.X_Size()-1;
   int y_size =m_canvas.Y_Size()-1;
//--- ����������: ������/������/�����/�����
   int x1[4]; x1[0]=0;      x1[1]=x_size; x1[2]=0;      x1[3]=0;
   int y1[4]; y1[0]=0;      y1[1]=0;      y1[2]=y_size; y1[3]=0;
   int x2[4]; x2[0]=x_size; x2[1]=x_size; x2[2]=x_size; x2[3]=0;
   int y2[4]; y2[0]=0;      y2[1]=y_size; y2[2]=y_size; y2[3]=y_size;
//--- ������ ����� �� ��������� �����������
   for(int i=0; i<4; i++)
      m_canvas.Line(x1[i],y1[i],x2[i],y2[i],::ColorToARGB(clr,alpha));
//--- ���������� �� ����� �� ���� �������
   clr=clrBlack;
   m_canvas.PixelSet(0,0,::ColorToARGB(clr,0));
   m_canvas.PixelSet(0,m_y_size-1,::ColorToARGB(clr,0));
   m_canvas.PixelSet(m_x_size-1,0,::ColorToARGB(clr,0));
   m_canvas.PixelSet(m_x_size-1,m_y_size-1,::ColorToARGB(clr,0));
//--- ��������� �������� �� ��������� �����������
   clr=C'180,180,180';
   m_canvas.PixelSet(1,1,::ColorToARGB(clr,alpha));
   m_canvas.PixelSet(1,m_y_size-2,::ColorToARGB(clr,alpha));
   m_canvas.PixelSet(m_x_size-2,1,::ColorToARGB(clr,alpha));
   m_canvas.PixelSet(m_x_size-2,m_y_size-2,::ColorToARGB(clr,alpha));
  }
//+------------------------------------------------------------------+
//| ���������� ����������� ���������                                 |
//+------------------------------------------------------------------+
void CTooltip::ShowTooltip(void)
  {
//--- �����, ���� ��������� ����� �� 100%
   if(m_alpha>=255)
      return;
//--- ���������� � ������ ��� ���������
   int  x        =5;
   int  y        =5;
   int  y_offset =15;
//--- ������ ��������
   VerticalGradient(255);
//--- ������ �����
   Border(255);
//--- ������ ��������� (���� ����������)
   if(m_header!="")
     {
      //--- ��������� ��������� ������
      m_canvas.FontSet(FONT,-80,FW_BLACK);
      //--- ������ ����� ���������
      m_canvas.TextOut(x,y,m_header,::ColorToARGB(m_header_color),TA_LEFT|TA_TOP);
     }
//--- ���������� ��� ��������� ������ ��������� (� ������ ������� ���������)
   x=(m_header!="")? 15 : 5;
   y=(m_header!="")? 25 : 5;
//--- ��������� ��������� ������
   m_canvas.FontSet(FONT,-80,FW_THIN);
//--- ������ �������� ����� ���������
   int lines_total=::ArraySize(m_tooltip_lines);
   for(int i=0; i<lines_total; i++)
     {
      m_canvas.TextOut(x,y,m_tooltip_lines[i],::ColorToARGB(m_text_color),TA_LEFT|TA_TOP);
      y=y+y_offset;
     }
//--- �������� �����
   m_canvas.Update();
//--- ������� ��������� ������� ���������
   m_alpha=255;
  }
//+------------------------------------------------------------------+
//| ������� ������������ ����������� ���������                       |
//+------------------------------------------------------------------+
void CTooltip::FadeOutTooltip(void)
  {
//--- �����, ���� ��������� ������ �� 100%
   if(m_alpha<1)
      return;
//--- ������ ��� ���������
   int y_offset=15;
//--- ��� ������������
   uchar fadeout_step=7;
//--- ������� ������������ ���������
   for(uchar a=m_alpha; a>=0; a-=fadeout_step)
     {
      //--- ���� ��������� ��� � �����, ��������� ����
      if(a-fadeout_step<0)
        {
         a=0;
         m_canvas.Erase(::ColorToARGB(clrNONE,0));
         m_canvas.Update();
         m_alpha=0;
         break;
        }
      //--- ���������� ��� ���������
      int x =5;
      int y =5;
      //--- ������ �������� � �����
      VerticalGradient(a);
      Border(a);
      //--- ������ ��������� (���� ����������)
      if(m_header!="")
        {
         //--- ��������� ��������� ������
         m_canvas.FontSet(FONT,-80,FW_BLACK);
         //--- ������ ����� ���������
         m_canvas.TextOut(x,y,m_header,::ColorToARGB(m_header_color,a),TA_LEFT|TA_TOP);
        }
      //--- ���������� ��� ��������� ������ ��������� (� ������ ������� ���������)
      x=(m_header!="")? 15 : 5;
      y=(m_header!="")? 25 : 5;
      //--- ��������� ��������� ������
      m_canvas.FontSet(FONT,-80,FW_THIN);
      //--- ������ �������� ����� ���������
      int lines_total=::ArraySize(m_tooltip_lines);
      for(int i=0; i<lines_total; i++)
        {
         m_canvas.TextOut(x,y,m_tooltip_lines[i],::ColorToARGB(m_text_color,a),TA_LEFT|TA_TOP);
         y=y+y_offset;
        }
      //--- �������� �����
      m_canvas.Update();
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CTooltip::Moving(const int x,const int y)
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
void CTooltip::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CTooltip::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   m_canvas.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CTooltip::Reset(void)
  {
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| ��������                                                         |
//+------------------------------------------------------------------+
void CTooltip::Delete(void)
  {
//--- �������� ��������
   m_canvas.Delete();
//--- ������������ �������� ��������
   ::ArrayFree(m_tooltip_lines);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
  }
//+------------------------------------------------------------------+
