//+------------------------------------------------------------------+
//|                                                    StatusBar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ��������� ������                              |
//+------------------------------------------------------------------+
class CStatusBar : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������
   CRectLabel        m_area;
   CEdit             m_items[];
   CSeparateLine     m_sep_line[];
   //--- ��������:
   //    ������� ��� ���������� �������
   int               m_width[];
   //--- (1) ���� ���� � (2) ����� ����
   color             m_area_color;
   color             m_area_border_color;
   //--- ���� ������
   color             m_label_color;
   //--- ��������� �� ������� ����� ������ ����
   int               m_zorder;
   //--- ����� ��� �������������� �����
   color             m_sepline_dark_color;
   color             m_sepline_light_color;
   //---
public:
                     CStatusBar(void);
                    ~CStatusBar(void);
   //--- ������ ��� �������� ��������� ������
   bool              CreateStatusBar(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   bool              CreateSeparateLine(const int line_number,const int x,const int y);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� �������
   void              WindowPointer(CWindow &object)                   { m_wnd=::GetPointer(object);   }
   int               ItemsTotal(void)                           const { return(::ArraySize(m_items)); }
   //--- ���� (1) ����, (2) ����� ���� � (3) ������
   void              AreaColor(const color clr)                       { m_area_color=clr;             }
   void              AreaBorderColor(const color clr)                 { m_area_border_color=clr;      }
   void              LabelColor(const color clr)                      { m_label_color=clr;            }
   //--- ����� �������������� �����
   void              SeparateLineDarkColor(const color clr)           { m_sepline_dark_color=clr;     }
   void              SeparateLineLightColor(const color clr)          { m_sepline_light_color=clr;    }

   //--- ��������� ����� � ���������� ���������� �� �������� ��������� ������
   void              AddItem(const int width);
   //--- ��������� �������� �� ���������� �������
   void              ValueToItem(const int index,const string value);
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
CStatusBar::CStatusBar(void) : m_area_color(C'240,240,240'),
                               m_area_border_color(clrSilver),
                               m_label_color(clrBlack),
                               m_sepline_dark_color(C'160,160,160'),
                               m_sepline_light_color(clrWhite)
  {
//--- �������� ��� ������ �������� � ������� ������  
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder=2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CStatusBar::~CStatusBar(void)
  {
  }
//+------------------------------------------------------------------+
//| ������ ��������� ������                                         |
//+------------------------------------------------------------------+
bool CStatusBar::CreateStatusBar(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ��������� ������ ������ ����� �������� "
              "��������� �� �����: CStatusBar::WindowPointer(CWindow &object).");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- ������ ��������� ������
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- ������ �������, ���� ���� ��������������
   if(m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� �������                                            |
//+------------------------------------------------------------------+
bool CStatusBar::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_statusbar_bg_"+(string)CElement::Id();
//--- ���������� � ������ ����
   int x=m_x;
   int y=m_y;
   m_x_size=(m_x_size<1)? m_wnd.XSize()-2 : m_x_size;
//--- ��������� ��� ��������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- ��������� ��������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ������� ��������� ������                          |
//+------------------------------------------------------------------+
bool CStatusBar::CreateItems(void)
  {
   int l_w=0;
   int l_x=m_x+1;
   int l_y=m_y+1;
//--- ������� ���������� �������
   int items_total=ItemsTotal();
//--- ���� ��� �� ������ ������ � ������, �������� �� ���� � �����
   if(items_total<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� �����! �������������� ������� CStatusBar::AddItem()");
      return(false);
     }
//--- ���� ������ ������� ������ �� ������, ��...
   if(m_width[0]<1)
     {
      //--- ...���������� � ������������ ����� ������ ������ �������
      for(int i=1; i<items_total; i++)
         l_w+=m_width[i];
      //---
      m_width[0]=m_wnd.XSize()-l_w-(items_total+2);
     }
//--- �������� ��������� ���������� �������
   for(int i=0; i<items_total; i++)
     {
      //--- ������������ ����� �������
      string name=CElement::ProgramName()+"_statusbar_edit_"+string(i)+"__"+(string)CElement::Id();
      //--- ���������� X
      l_x=(i>0)? l_x+m_width[i-1]: l_x;
      //--- �������� �������
      if(!m_items[i].Create(m_chart_id,name,m_subwin,l_x,l_y,m_width[i],m_y_size-2))
         return(false);
      //--- ��������� �������
      m_items[i].Description("");
      m_items[i].TextAlign(ALIGN_LEFT);
      m_items[i].Font(FONT);
      m_items[i].FontSize(FONT_SIZE);
      m_items[i].Color(m_label_color);
      m_items[i].BorderColor(m_area_color);
      m_items[i].BackColor(m_area_color);
      m_items[i].Corner(m_corner);
      m_items[i].Anchor(m_anchor);
      m_items[i].Selectable(false);
      m_items[i].Z_Order(m_zorder);
      m_items[i].ReadOnly(true);
      m_items[i].Tooltip("\n");
      //--- ������� �� ������� ����� ������
      m_items[i].XGap(l_x-m_wnd.X());
      m_items[i].YGap(l_y-m_wnd.Y());
      //--- ����������
      m_items[i].X(l_x);
      m_items[i].Y(l_y);
      //--- �������
      m_items[i].XSize(m_width[i]);
      m_items[i].YSize(m_y_size-2);
      //--- �������� ��������� �������
      CElement::AddToArray(m_items[i]);
     }
//--- �������� �������������� �����
   for(int i=1; i<items_total; i++)
     {
      //--- ���������� X
      l_x=m_items[i].X();
      //--- �������� �����
      CreateSeparateLine(i,l_x,l_y+2);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������������� �����                                     |
//+------------------------------------------------------------------+
bool CStatusBar::CreateSeparateLine(const int line_number,const int x,const int y)
  {
//--- ����� ��������������� �� ������� (1) ������
   if(line_number<1)
      return(false);
//--- ������������� �������
   int i=line_number-1;
//--- ���������� ������� ����� �� ���� �������
   int array_size=::ArraySize(m_sep_line);
   ::ArrayResize(m_sep_line,array_size+1);
//--- �������� ��������� �� ����
   m_sep_line[i].WindowPointer(m_wnd);
//--- ��������� �������
   m_sep_line[i].TypeSepLine(V_SEP_LINE);
   m_sep_line[i].DarkColor(m_sepline_dark_color);
   m_sep_line[i].LightColor(m_sepline_light_color);
//--- �������� �����
   if(!m_sep_line[i].CreateSeparateLine(m_chart_id,m_subwin,line_number,x,y,2,m_y_size-6))
      return(false);
//--- ������� �� ������� ����� ������
   m_sep_line[i].XGap(x-m_wnd.X());
   m_sep_line[i].YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_sep_line[i].Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ����                                             |
//+------------------------------------------------------------------+
void CStatusBar::AddItem(const int width)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_width,array_size+1);
//--- �������� �������� ���������� ����������
   m_width[array_size]=width;
  }
//+------------------------------------------------------------------+
//| ������������� �������� �� ���������� �������                     |
//+------------------------------------------------------------------+
void CStatusBar::ValueToItem(const int index,const string value)
  {
//--- �������� �� ����� �� ���������
   int array_size=::ArraySize(m_items);
   if(array_size<1 || index<0 || index>=array_size)
      return;
//--- ��������� ����������� ������
   m_items[index].Description(value);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CStatusBar::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���������� ��������� � ����� ��������
      m_items[i].X(x+m_items[i].XGap());
      m_items[i].Y(y+m_items[i].YGap());
      //--- ���������� ��������� ����������� ��������
      m_items[i].X_Distance(m_items[i].X());
      m_items[i].Y_Distance(m_items[i].Y());
     }
//--- ����������� �������������� �����
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CStatusBar::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- �������� �������������� �����
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Show();
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CStatusBar::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ �������������� �����
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CStatusBar::Reset(void)
  {
//--- �����, ���� ��� ���������� ������� 
   if(CElement::IsDropdown())
      return;
//--- ������ � ��������
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| ��������                                                         |
//+------------------------------------------------------------------+
void CStatusBar::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
//--- ������������ �������� ��������
   ::ArrayFree(m_items);
   ::ArrayFree(m_sep_line);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CStatusBar::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CStatusBar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
