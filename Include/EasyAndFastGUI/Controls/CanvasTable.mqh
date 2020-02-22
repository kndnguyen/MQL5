//+------------------------------------------------------------------+
//|                                                  CanvasTable.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������������ �������                          |
//+------------------------------------------------------------------+
class CCanvasTable : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� �������
   CRectLabel        m_area;
   CRectCanvas       m_canvas;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   //--- ������ �������� � �������� �������
   struct CTOptions
     {
      string            m_vrows[];
      int               m_width;
      ENUM_ALIGN_MODE   m_text_align;
     };
   CTOptions         m_vcolumns[];
   //--- 
   int               m_rows_total;
   int               m_columns_total;
   int               m_visible_rows_total;
   int               m_visible_columns_total;
   //--- ����� ������ � ������ ������� ����� �������
   int               m_table_x_size;
   int               m_table_y_size;
   int               m_table_visible_x_size;
   int               m_table_visible_y_size;
   //--- ���� ����
   color             m_area_color;
   //--- ���� �����
   color             m_grid_color;
   //--- ������ (������) �����
   int               m_cell_y_size;
   //--- ���� �����
   color             m_cell_color;
   //--- ���� ������
   color             m_cell_text_color;
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   int               m_cell_zorder;
   //--- ��������� ������ ���� (������/������)
   ENUM_THUMB_MOUSE_STATE m_clamping_area_mouse;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //--- ������� ������� ��� ��������� ������
   int               m_timer_counter;
   //---
public:
                     CCanvasTable(void);
                    ~CCanvasTable(void);
   //--- ������ ��� �������� �������
   bool              CreateTable(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCells(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ��������� �� ������ ���������
   void              WindowPointer(CWindow &object)       { m_wnd=::GetPointer(object);      }
   CScrollV         *GetScrollVPointer(void)              { return(::GetPointer(m_scrollv)); }
   CScrollH         *GetScrollHPointer(void)              { return(::GetPointer(m_scrollh)); }
   //--- ���� (1) ����, (2) ����� � (3) ������ �������
   void              AreaColor(const color clr)           { m_cell_color=clr;                }
   void              GridColor(const color clr)           { m_grid_color=clr;                }
   void              TextColor(const color clr)           { m_cell_text_color=clr;           }
   //--- (1) ������ �����, ���������� ����� ���������� (2) ����� � (3) ��������
   void              CellYSize(const int y_size)          { m_cell_y_size=y_size;            }
   int               RowsTotal(void)                const { return(m_rows_total);            }
   int               ColumnsTotal(void)             const { return(m_columns_total);         }
   //--- ���������� ���������� (1) ����� � (2) �������� ������� ����� �������
   int               VisibleRowsTotal(void)         const { return(m_visible_rows_total);    }
   int               VisibleColumnsTotal(void)      const { return(m_visible_columns_total); }
   //--- ������������� (1) �������� ������ ������� � (2) ������ ������� � �����
   void              TableSize(const int columns_total,const int rows_total);
   void              VisibleTableSize(const int visible_columns_total,const int visible_rows_total);
   //--- ��������� (1) ������ ������������ ������ � (2) ������ ��� ������� �������
   void              TextAlign(const ENUM_ALIGN_MODE &array[]);
   void              ColumnsWidth(const int &array[]);
   //--- ������������� �������� � ��������� ������ �������
   void              SetValue(const int column_index,const int row_index,const string value);
   //--- �������� �������� �� ��������� ������ �������
   string            GetValue(const int column_index,const int row_index);
   //--- �������� ������� ������������ ������� ����� ���������
   void              ShiftTable(void);
   //--- ������ ������� � ������ ��������� �������� ���������
   void              DrawTable(void);
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
   //--- ������������ ������� �������
   void              CalculateTableSize(void);
   //--- ������ �����
   void              DrawGrid(void);
   //--- ������ �����
   void              DrawText(void);
   //--- ���������� ��������� �������
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCanvasTable::CCanvasTable(void) : m_cell_y_size(18),
                                   m_rows_total(2),
                                   m_columns_total(1),
                                   m_visible_rows_total(2),
                                   m_visible_columns_total(1),
                                   m_grid_color(clrWhite),
                                   m_cell_color(clrWhite),
                                   m_cell_text_color(clrBlack)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder      =1;
   m_cell_zorder =2;
//--- ��������� ������ ������� � � ������� �����
   TableSize(m_columns_total,m_rows_total);
   VisibleTableSize(m_visible_columns_total,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCanvasTable::~CCanvasTable(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CCanvasTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- ���� ������ ��������� � ��������
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state) || m_scrollh.ScrollBarControl(x,y,m_mouse_state))
         ShiftTable();
      //---
      return;
     }
//--- ��������� ������� �� ��������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ���� ������ �� ������ ������ ���������
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
        {
         //--- �������� �������
         ShiftTable();
        }
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CCanvasTable::OnEventTimer(void)
  {
//--- ���� ������� �������� ����������
   if(CElement::IsDropdown())
      FastSwitching();
//--- ���� ������� �� ����������, �� ��������� ����������� ����� � ������� ������
   else
     {
      //--- ����������� ��������� �������, ������ ���� ����� �� �������������
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������������ �������                                     |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateTable(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������� ������ ����� �������� "
              "��������� �� �����: CCanvasTable::WindowPointer(CWindow &object).");
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
//--- ���������� ������� �������
   CalculateTableSize();
//--- �������� �������
   if(!CreateArea())
      return(false);
   if(!CreateCells())
      return(false);
   if(!CreateScrollV())
      return(false);
   if(!CreateScrollH())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ��� �������                                          |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_table_area_"+(string)CElement::Id();
//--- �������� �������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_cell_color);
   m_area.Color(m_cell_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- �������� �������
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- �������� ����������
   m_area.X(m_x);
   m_area.Y(m_y);
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ����� �������                                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateCells(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_table_canvas_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X()+1;
   int y =CElement::Y()+1;
//--- �������� �������
   ::ResetLastError();
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,m_table_x_size,m_table_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > �� ������� ������� ����� ��� ��������� �������: ",::GetLastError());
      return(false);
     }
//--- ���������� � �������
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- ��������� ��������
   m_canvas.Tooltip("\n");
//--- ����������
   m_canvas.X(x);
   m_canvas.Y(y);
//--- ������� �� ������� ����� ������
   m_canvas.XGap(x-m_wnd.X());
   m_canvas.YGap(y-m_wnd.Y());
//--- �������� �������
   m_canvas.XSize(m_table_x_size);
   m_canvas.YSize(m_table_y_size);
//--- �������� ��������� �������
   CElement::AddToArray(m_canvas);
//--- ��������� ������� ������� �������
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_XSIZE,m_table_visible_x_size);
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_YSIZE,m_table_visible_y_size);
//--- ������� �������� ������ ������ ����������� �� ���� X � Y
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_XOFFSET,0);
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_YOFFSET,0);
//--- �������� �������
   DrawTable();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������ ������                                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateScrollV(void)
  {
//--- ���� ����� ���������� ����� ������, ��� ������� ����� �������, ��
//    ��������� ������������ ������ ���������
   if(m_rows_total<=m_visible_rows_total)
      return(true);
//--- ��������� ��������� �����
   m_scrollv.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X2()-m_scrollv.ScrollWidth();
   int y=CElement::Y();
//--- ��������� ��������
   m_scrollv.Id(CElement::Id());
   m_scrollv.IsDropdown(CElement::IsDropdown());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(m_cell_y_size*m_visible_rows_total+2-(m_visible_rows_total-1));
//--- �������� ������ ���������
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_rows_total,m_visible_rows_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������������� ������                                    |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateScrollH(void)
  {
//--- ���� ����� ������ ������� ������, ��� ������� � �����, ��
//    ��������� �������������� ������ ���������
   if(m_table_x_size<=m_table_visible_x_size)
      return(true);
//--- ��������� ��������� �����
   m_scrollh.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X();
   int y=CElement::Y2()-m_scrollh.ScrollWidth();
//--- ��������� ��������
   m_scrollh.Id(CElement::Id());
   m_scrollh.IsDropdown(CElement::IsDropdown());
   m_scrollh.XSize(m_area.XSize()-m_scrollh.ScrollWidth()+1);
   m_scrollh.YSize(m_scrollh.ScrollWidth());
//--- �������� ������ ���������
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_table_x_size,m_table_visible_x_size))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������ ������� ������������ ������                     |
//+------------------------------------------------------------------+
void CCanvasTable::TextAlign(const ENUM_ALIGN_MODE &array[])
  {
   int total=0;
   int array_size=::ArraySize(array);
//--- �����, ���� ������� ������ �������� �������
   if(array_size<1)
      return;
//--- ��������������� �������� ��� �������������� ������ �� ��������� ������� 
   total=(array_size<m_columns_total)? array_size : m_columns_total;
//--- ��������� �������� � ���������
   for(int c=0; c<total; c++)
      m_vcolumns[c].m_text_align=array[c];
  }
//+------------------------------------------------------------------+
//| ��������� ������ ������ ��������                                 |
//+------------------------------------------------------------------+
void CCanvasTable::ColumnsWidth(const int &array[])
  {
   int total=0;
   int array_size=::ArraySize(array);
//--- �����, ���� ������� ������ �������� �������
   if(array_size<1)
      return;
//--- ��������������� �������� ��� �������������� ������ �� ��������� ������� 
   total=(array_size<m_columns_total)? array_size : m_columns_total;
//--- ��������� �������� � ���������
   for(int c=0; c<total; c++)
      m_vcolumns[c].m_width=array[c];
  }
//+------------------------------------------------------------------+
//| ��������� ������ �� ��������� ��������                           |
//+------------------------------------------------------------------+
void CCanvasTable::SetValue(const int column_index,const int row_index,const string value)
  {
//--- �������� �� ����� �� ��������� ��������
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- �������� �� ����� �� ��������� �����
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- ���������� �������� � ������
   m_vcolumns[column_index].m_vrows[row_index]=value;
  }
//+------------------------------------------------------------------+
//| ���������� �������� �� ��������� ��������                        |
//+------------------------------------------------------------------+
string CCanvasTable::GetValue(const int column_index,const int row_index)
  {
//--- �������� �� ����� �� ��������� ��������
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return("");
//--- �������� �� ����� �� ��������� �����
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return("");
//--- ������� ��������
   return(m_vcolumns[column_index].m_vrows[row_index]);
  }
//+------------------------------------------------------------------+
//| ������������� ������ �������                                     |
//+------------------------------------------------------------------+
void CCanvasTable::TableSize(const int columns_total,const int rows_total)
  {
//--- ������ ���� �� ����� ������ �������
   m_columns_total=(columns_total<1) ? 1 : columns_total;
//--- ������ ���� �� ����� ���� �����
   m_rows_total=(rows_total<2) ? 2 : rows_total;
//--- ���������� ������ ������� ��������
   ::ArrayResize(m_vcolumns,m_columns_total);
//--- ���������� ������ �������� �����
   for(int i=0; i<m_columns_total; i++)
     {
      ::ArrayResize(m_vcolumns[i].m_vrows,m_rows_total);
      //--- ������������� ������� �������� ���������� �� ���������
      m_vcolumns[i].m_width      =100;
      m_vcolumns[i].m_text_align =ALIGN_CENTER;
     }
  }
//+------------------------------------------------------------------+
//| ������������� ������ ������� ����� �������                       |
//+------------------------------------------------------------------+
void CCanvasTable::VisibleTableSize(const int visible_columns_total,const int visible_rows_total)
  {
//--- ������ ���� �� ����� ������ �������
   m_visible_columns_total=(visible_columns_total<1) ? 1 : visible_columns_total;
//--- ������ ���� �� ����� ���� �����
   m_visible_rows_total=(visible_rows_total<2) ? 2 : visible_rows_total;
  }
//+------------------------------------------------------------------+
//| ������������ ������� �������                                     |
//+------------------------------------------------------------------+
void CCanvasTable::CalculateTableSize(void)
  {
//--- ���������� ����� ������ �������
   m_table_x_size=0;
   for(int c=0; c<m_columns_total; c++)
      m_table_x_size=m_table_x_size+m_vcolumns[c].m_width;
//--- ������ ������� � ������ ������� ������������ ������ ���������
   int x_size=(m_rows_total>m_visible_rows_total) ? m_x_size-m_scrollh.ScrollWidth() : m_x_size-2;
//--- ���� ������ ���� �������� ������ ������ �������, �� ����� ������������ ������ �������
   if(m_table_x_size<m_x_size)
      m_table_x_size=x_size;
//--- ���������� ����� ������ �������
   m_table_y_size=m_cell_y_size*m_rows_total-(m_rows_total-1);
//--- ������� ������ ������ ��� ������ ��������� ����������� (������� ����� ������� �������)
   m_table_visible_x_size=x_size;
   m_table_visible_y_size=m_cell_y_size*m_visible_rows_total-(m_visible_rows_total-1);
//--- ���� ���� �������������� ������ ���������, �� ��������������� ������ �������� �� ��� Y
   int y_size=m_cell_y_size*m_visible_rows_total+2-(m_visible_rows_total-1);
   m_y_size=(m_table_x_size>m_table_visible_x_size) ? y_size+m_scrollh.ScrollWidth()-1 : y_size;
  }
//+------------------------------------------------------------------+
//| ������ �����                                                     |
//+------------------------------------------------------------------+
void CCanvasTable::DrawGrid(void)
  {
//--- ���� �����
   uint clr=::ColorToARGB(m_grid_color,255);
//--- ������ ������ ��� ���������
   int x_size =m_canvas.XSize()-1;
   int y_size =m_canvas.YSize()-1;
//--- ����������
   int x1=0,x2=0,y1=0,y2=0;
//--- �������������� �����
   x1=0;
   y1=0;
   x2=x_size;
   y2=0;
   for(int i=0; i<=m_rows_total; i++)
     {
      m_canvas.Line(x1,y1,x2,y2,clr);
      y2=y1+=m_cell_y_size-1;
     }
//--- ������������ �����
   x1=0;
   y1=0;
   x2=0;
   y2=y_size;
   for(int i=0; i<m_columns_total; i++)
     {
      m_canvas.Line(x1,y1,x2,y2,clr);
      x2=x1+=m_vcolumns[i].m_width;
     }
//--- ������
   x1=x_size;
   y1=0;
   x2=x_size;
   y2=y_size;
   m_canvas.Line(x1,y1,x2,y2,clr);
  }
//+------------------------------------------------------------------+
//| ������ �����                                                     |
//+------------------------------------------------------------------+
void CCanvasTable::DrawText(void)
  {
//--- ��� ������� ��������� � ��������
   int  x             =0;
   int  y             =0;
   uint text_align    =0;
   int  column_offset =0;
   int  cell_x_offset =10;
   int  cell_y_offset =3;
//--- ���� ������
   uint clr=::ColorToARGB(m_cell_text_color,255);
//--- �������� ������
   m_canvas.FontSet(FONT,-80,FW_NORMAL);
//--- �������
   for(int c=0; c<m_columns_total; c++)
     {
      //--- ������� ������� ��� ������� �������
      if(c==0)
        {
         //--- ������������ ������ � ������� �� �������������� ������ ��� ������� �������
         switch(m_vcolumns[0].m_text_align)
           {
            //--- �� ������
            case ALIGN_CENTER :
               column_offset=column_offset+m_vcolumns[0].m_width/2;
               x=column_offset;
               break;
               //--- C�����
            case ALIGN_RIGHT :
               column_offset=column_offset+m_vcolumns[0].m_width;
               x=column_offset-cell_x_offset;
               break;
               //--- �����
            case ALIGN_LEFT :
               x=column_offset+cell_x_offset;
               break;
           }
        }
      //--- ������� �������� ��� ���� �������� ����� �������
      else
        {
         //--- ������������ ������ � ������� �� �������������� ������ ��� ������� �������
         switch(m_vcolumns[c].m_text_align)
           {
            //--- �� ������
            case ALIGN_CENTER :
               //--- ������ ������� ������������ ������������ � ���������� �������
               switch(m_vcolumns[c-1].m_text_align)
                 {
                  case ALIGN_CENTER :
                     column_offset=column_offset+(m_vcolumns[c-1].m_width/2)+(m_vcolumns[c].m_width/2);
                     break;
                  case ALIGN_RIGHT :
                     column_offset=column_offset+(m_vcolumns[c].m_width/2);
                     break;
                  case ALIGN_LEFT :
                     column_offset=column_offset+m_vcolumns[c-1].m_width+(m_vcolumns[c].m_width/2);
                     break;
                 }
               //---
               x=column_offset;
               break;
               //--- ������
            case ALIGN_RIGHT :
               //--- ������ ������� ������������ ������������ � ���������� �������
               switch(m_vcolumns[c-1].m_text_align)
                 {
                  case ALIGN_CENTER :
                     column_offset=column_offset+(m_vcolumns[c-1].m_width/2)+m_vcolumns[c].m_width;
                     x=column_offset-cell_x_offset;
                     break;
                  case ALIGN_RIGHT :
                     column_offset=column_offset+m_vcolumns[c].m_width;
                     x=column_offset-cell_x_offset;
                     break;
                  case ALIGN_LEFT :
                     column_offset=column_offset+m_vcolumns[c-1].m_width+m_vcolumns[c].m_width;
                     x=column_offset-cell_x_offset;
                     break;
                 }
               //---
               break;
               //--- �����
            case ALIGN_LEFT :
               //--- ������ ������� ������������ ������������ � ���������� �������
               switch(m_vcolumns[c-1].m_text_align)
                 {
                  case ALIGN_CENTER :
                     column_offset=column_offset+(m_vcolumns[c-1].m_width/2);
                     x=column_offset+cell_x_offset;
                     break;
                  case ALIGN_RIGHT :
                     x=column_offset+cell_x_offset;
                     break;
                  case ALIGN_LEFT :
                     column_offset=column_offset+m_vcolumns[c-1].m_width;
                     x=column_offset+cell_x_offset;
                     break;
                 }
               //---
               break;
           }
        }
      //--- ����
      for(int r=0; r<m_rows_total; r++)
        {
         //---
         y+=(r>0) ? m_cell_y_size-1 : cell_y_offset;
         //---
         switch(m_vcolumns[c].m_text_align)
           {
            case ALIGN_CENTER :
               text_align=TA_CENTER|TA_TOP;
               break;
            case ALIGN_RIGHT :
               text_align=TA_RIGHT|TA_TOP;
               break;
            case ALIGN_LEFT :
               text_align=TA_LEFT|TA_TOP;
               break;
           }
         //--- ���������� �����
         m_canvas.TextOut(x,y,m_vcolumns[c].m_vrows[r],clr,text_align);
        }
      //--- �������� ���������� Y ��� ���������� �����
      y=0;
     }
  }
//+------------------------------------------------------------------+
//| ������ �������                                                   |
//+------------------------------------------------------------------+
void CCanvasTable::DrawTable(void)
  {
//--- ������� ��� ����������
   m_canvas.Erase(::ColorToARGB(clrNONE,0));
//--- ���������� �����
   DrawGrid();
//--- ���������� �����
   DrawText();
//--- ���������� ��������� ������������ ���������
   m_canvas.Update();
//--- �������� ������� ������������ ����� ���������
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| �������� ������� ������������ ����� ���������                    |
//+------------------------------------------------------------------+
void CCanvasTable::ShiftTable(void)
  {
//--- ������� ������� ������� ��������� �������������� � ������������ ����� ���������
   int h=m_scrollh.CurrentPos();
   int v=m_scrollv.CurrentPos();
//--- ������ ��������� ������� ������������ ��������� ����� ���������
   long c=h;
   long r=v*(m_cell_y_size-1);
//--- �������� �������
   ::ObjectSetInteger(m_chart_id,m_canvas.Name(),OBJPROP_XOFFSET,c);
   ::ObjectSetInteger(m_chart_id,m_canvas.Name(),OBJPROP_YOFFSET,r);
  }
//+------------------------------------------------------------------+
//| ����������� ��������                                             |
//+------------------------------------------------------------------+
void CCanvasTable::Moving(const int x,const int y)
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
   m_canvas.X(x+m_canvas.XGap());
   m_canvas.Y(y+m_canvas.YGap());
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_canvas.X_Distance(m_canvas.X());
   m_canvas.Y_Distance(m_canvas.Y());
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CCanvasTable::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
   m_scrollv.Show();
   m_scrollh.Show();
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CCanvasTable::Hide(void)
  {
//--- �����, ���� ������� ��� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_canvas.Timeframes(OBJ_NO_PERIODS);
   m_scrollv.Hide();
   m_scrollh.Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CCanvasTable::Reset(void)
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
void CCanvasTable::Delete(void)
  {
//--- �������� ����������� ��������
   m_area.Delete();
   m_canvas.Delete();
//--- ������������ �������� ��������
   for(int c=0; c<m_columns_total; c++)
      ::ArrayFree(m_vcolumns[c].m_vrows);
//---
   ::ArrayFree(m_vcolumns);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CCanvasTable::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_canvas.Z_Order(m_cell_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CCanvasTable::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_canvas.Z_Order(0);
   m_scrollv.ResetZorders();
   m_scrollh.ResetZorders();
  }
//+------------------------------------------------------------------+
//| ���������� �������� ������ ���������                             |
//+------------------------------------------------------------------+
void CCanvasTable::FastSwitching(void)
  {
//--- ������, ���� ��� ������ �� ������
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
      //--- ���� ��������� �����
      if(m_scrollv.ScrollIncState())
         m_scrollv.OnClickScrollInc(m_scrollv.ScrollIncName());
      //--- ���� ��������� ����
      else if(m_scrollv.ScrollDecState())
         m_scrollv.OnClickScrollDec(m_scrollv.ScrollDecName());
      //--- ���� ��������� �����
      else if(m_scrollh.ScrollIncState())
         m_scrollh.OnClickScrollInc(m_scrollh.ScrollIncName());
      //--- ���� ��������� ������
      else if(m_scrollh.ScrollDecState())
         m_scrollh.OnClickScrollDec(m_scrollh.ScrollDecName());
      //--- ������� �������
      ShiftTable();
     }
  }
//+------------------------------------------------------------------+
