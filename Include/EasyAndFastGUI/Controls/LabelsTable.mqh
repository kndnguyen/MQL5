//+------------------------------------------------------------------+
//|                                                  LabelsTable.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������� �� ��������� �����                    |
//+------------------------------------------------------------------+
class CLabelsTable : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� �������
   CRectLabel        m_area;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   //--- ������ �������� ������� ����� �������
   struct LTLabels
     {
      CLabel            m_rows[];
     };
   LTLabels          m_columns[];
   //--- ������� �������� � ������� �������
   struct LTOptions
     {
      string            m_vrows[];
      color             m_colors[];
     };
   LTOptions         m_vcolumns[];
   //--- ���������� �������� � ����� (����� � ������� �����) �������
   int               m_rows_total;
   int               m_columns_total;
   int               m_visible_rows_total;
   int               m_visible_columns_total;
   //--- ������ ����
   int               m_row_y_size;
   //--- ���� ���� �������
   color             m_area_color;
   //--- ���� ������ � ������� �� ���������
   color             m_text_color;
   //--- ���������� ����� ������ �������� ������� ������� � ����� ����� ��������
   int               m_x_offset;
   //--- ���������� ����� ������� �������� ��������
   int               m_column_x_offset;
   //--- ����� �������� ������ ������
   bool              m_fix_first_row;
   //--- ����� �������� ������� �������
   bool              m_fix_first_column;
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   int               m_area_zorder;
   //--- ��������� ������ ���� (������/������)
   ENUM_THUMB_MOUSE_STATE m_clamping_area_mouse;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //--- ������� ������� ��� ��������� ������
   int               m_timer_counter;
   //---
public:
                     CLabelsTable(void);
                    ~CLabelsTable(void);
   //--- ������ ��� �������� �������
   bool              CreateLabelsTable(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabels(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ��������� �� ������ ���������
   void              WindowPointer(CWindow &object)               { m_wnd=::GetPointer(object);      }
   CScrollV         *GetScrollVPointer(void)                      { return(::GetPointer(m_scrollv)); }
   CScrollH         *GetScrollHPointer(void)                      { return(::GetPointer(m_scrollh)); }
   //--- ���������� ����� ���������� (1) ����� � (2) ��������
   int               RowsTotal(void)                        const { return(m_rows_total);            }
   int               ColumnsTotal(void)                     const { return(m_columns_total);         }
   //--- ���������� ���������� (1) ����� � (2) �������� ������� ����� �������
   int               VisibleRowsTotal(void)                 const { return(m_visible_rows_total);    }
   int               VisibleColumnsTotal(void)              const { return(m_visible_columns_total); }
   //--- (1) ���� ����, (2) ���� ������
   void              AreaColor(const color clr)                   { m_area_color=clr;                }
   void              TextColor(const color clr)                   { m_text_color=clr;                }
   //--- (1) ������ ����, (2) ������������� ���������� ����� ������ �������� ������� ������� � ����� ����� �������,
   //    (3) ������������� ���������� ����� ������� �������� ��������
   void              RowYSize(const int y_size)                   { m_row_y_size=y_size;             }
   void              XOffset(const int x_offset)                  { m_x_offset=x_offset;             }
   void              ColumnXOffset(const int x_offset)            { m_column_x_offset=x_offset;      }
   //--- (1) ���������� � (2) ������������� ����� �������� ������ ������
   bool              FixFirstRow(void)                      const { return(m_fix_first_row);         }
   void              FixFirstRow(const bool flag)                 { m_fix_first_row=flag;            }
   //--- (1) ���������� � (2) ������������� ����� �������� ������� �������
   bool              FixFirstColumn(void)                   const { return(m_fix_first_column);      }
   void              FixFirstColumn(const bool flag)              { m_fix_first_column=flag;         }

   //--- ������������� (1) ������ ������� � (2) ������ ������� � ����� 
   void              TableSize(const int columns_total,const int rows_total);
   void              VisibleTableSize(const int visible_columns_total,const int visible_rows_total);
   //--- ������������� �������� � ��������� ������ �������
   void              SetValue(const int column_index,const int row_index,const string value);
   //--- �������� �������� �� ��������� ������ �������
   string            GetValue(const int column_index,const int row_index);
   //--- �������� ���� ������ � ��������� ������ �������
   void              TextColor(const int column_index,const int row_index,const color clr);
   //--- ���������� ������ ������� � ������ ��������� ���������
   void              UpdateTable(void);
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
   //--- ���������� ��������� ������
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CLabelsTable::CLabelsTable(void) : m_fix_first_row(false),
                                   m_fix_first_column(false),
                                   m_row_y_size(18),
                                   m_x_offset(30),
                                   m_column_x_offset(60),
                                   m_area_color(clrWhiteSmoke),
                                   m_text_color(clrBlack),
                                   m_rows_total(2),
                                   m_columns_total(1),
                                   m_visible_rows_total(2),
                                   m_visible_columns_total(1)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder      =0;
   m_area_zorder =1;
//--- ��������� ������ ������� � � ������� �����
   TableSize(m_columns_total,m_rows_total);
   VisibleTableSize(m_visible_columns_total,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CLabelsTable::~CLabelsTable(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CLabelsTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- �������� ������ ��� ��������
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- ������� ������, ���� ���������� ��������� ������ ��������� � ��������
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state) || m_scrollh.ScrollBarControl(x,y,m_mouse_state))
         UpdateTable();
      //---
      return;
     }
//--- ��������� ������� �� ��������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ���� ���� ������� �� ����� �� ������ ����� ��������� �������
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
         //--- �������� ������� ������������ ������ ���������
         UpdateTable();
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CLabelsTable::OnEventTimer(void)
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
//| ������ ������� �� ��������� �����                               |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateLabelsTable(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������� �� ����� ������ ����� �������� "
              "��������� �� �����: CLabelsTable::WindowPointer(CWindow &object).");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
   m_y_size   =m_row_y_size*m_visible_rows_total-(m_visible_rows_total-1)+2;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� �������
   if(!CreateArea())
      return(false);
   if(!CreateLabels())
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
//| ������ ��� �������                                              |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_labelstable_area_"+(string)CElement::Id();
//--- ������� �� ������� �����
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- ���� ���� �������������� ������ ���������, �� ��������������� ������ ������� �� ��� Y
   m_y_size=(m_columns_total>m_visible_columns_total) ? m_y_size+m_scrollh.ScrollWidth()-1 : m_y_size;
//--- �������� �������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- �������� �������
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
//--- �������� ����������
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ��������� �����                                   |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateLabels(void)
  {
//--- ���������� � ������
   int x      =CElement::X();
   int y      =0;
   int offset =0;
//--- �������
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- ������ ������� �������
      offset=(c>0) ? m_column_x_offset : m_x_offset;
      //--- ������ ���������� X
      x=x+offset;
      //--- ����
      for(int r=0; r<m_visible_rows_total; r++)
        {
         //--- ������������ ����� �������
         string name=CElement::ProgramName()+"_labelstable_label_"+(string)c+"_"+(string)r+"__"+(string)CElement::Id();
         //--- ������ ���������� Y
         y=(r>0) ? y+m_row_y_size-1 : CElement::Y()+10;
         //--- �������� �������
         if(!m_columns[c].m_rows[r].Create(m_chart_id,name,m_subwin,x,y))
            return(false);
         //--- ��������� �������
         m_columns[c].m_rows[r].Description(m_vcolumns[c].m_vrows[r]);
         m_columns[c].m_rows[r].Font(FONT);
         m_columns[c].m_rows[r].FontSize(FONT_SIZE);
         m_columns[c].m_rows[r].Color(m_text_color);
         m_columns[c].m_rows[r].Corner(m_corner);
         m_columns[c].m_rows[r].Anchor(ANCHOR_CENTER);
         m_columns[c].m_rows[r].Selectable(false);
         m_columns[c].m_rows[r].Z_Order(m_zorder);
         m_columns[c].m_rows[r].Tooltip("\n");
         //--- ������� �� ������� ����� �����
         m_columns[c].m_rows[r].XGap(x-m_wnd.X());
         m_columns[c].m_rows[r].YGap(y-m_wnd.Y());
         //--- ����������
         m_columns[c].m_rows[r].X(x);
         m_columns[c].m_rows[r].Y(y);
         //--- �������� ��������� �������
         CElement::AddToArray(m_columns[c].m_rows[r]);
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������ ������ ���������                            |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateScrollV(void)
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
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(CElement::YSize()-m_scrollv.ScrollWidth()+1);
//--- �������� ������ ���������
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_rows_total,m_visible_rows_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������������� ������ ���������                          |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateScrollH(void)
  {
//--- ���� ����� ���������� �������� ������, ��� ������� ����� �������, ��
//    ��������� �������������� ������ ���������
   if(m_columns_total<=m_visible_columns_total)
      return(true);
//--- ��������� ��������� �����
   m_scrollh.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X();
   int y=CElement::Y2()-m_scrollh.ScrollWidth();
//--- ��������� ��������
   m_scrollh.Id(CElement::Id());
   m_scrollh.XSize(CElement::XSize()-m_scrollh.ScrollWidth()+1);
   m_scrollh.YSize(m_scrollh.ScrollWidth());
//--- �������� ������ ���������
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_columns_total,m_visible_columns_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������������� ������ �������                                     |
//+------------------------------------------------------------------+
void CLabelsTable::TableSize(const int columns_total,const int rows_total)
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
      ::ArrayResize(m_vcolumns[i].m_colors,m_rows_total);
      //--- ������������� ������� ����� ������ ��������� �� ���������
      ::ArrayInitialize(m_vcolumns[i].m_colors,m_text_color);
     }
  }
//+------------------------------------------------------------------+
//| ������������� ������ ������� ����� �������                       |
//+------------------------------------------------------------------+
void CLabelsTable::VisibleTableSize(const int visible_columns_total,const int visible_rows_total)
  {
//--- ������ ���� �� ����� ������ �������
   m_visible_columns_total=(visible_columns_total<1) ? 1 : visible_columns_total;
//--- ������ ���� �� ����� ���� �����
   m_visible_rows_total=(visible_rows_total<2) ? 2 : visible_rows_total;
//--- ���������� ������ ������� ��������
   ::ArrayResize(m_columns,m_visible_columns_total);
//--- ���������� ������ �������� �����
   for(int i=0; i<m_visible_columns_total; i++)
      ::ArrayResize(m_columns[i].m_rows,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| ������������� �������� �� ��������� ��������                     |
//+------------------------------------------------------------------+
void CLabelsTable::SetValue(const int column_index,const int row_index,const string value)
  {
//--- �������� �� ����� �� ��������� ��������
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- �������� �� ����� �� ��������� �����
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- ���������� ��������
   m_vcolumns[column_index].m_vrows[row_index]=value;
  }
//+------------------------------------------------------------------+
//| ���������� �������� �� ��������� ��������                        |
//+------------------------------------------------------------------+
string CLabelsTable::GetValue(const int column_index,const int row_index)
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
//| �������� ���� �� ��������� ��������                              |
//+------------------------------------------------------------------+
void CLabelsTable::TextColor(const int column_index,const int row_index,const color clr)
  {
//--- �������� �� ����� �� ��������� ��������
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- �������� �� ����� �� ��������� �����
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- ���������� ����
   m_vcolumns[column_index].m_colors[row_index]=clr;
  }
//+------------------------------------------------------------------+
//| ���������� ������ ������� � ������ ��������� ���������           |
//+------------------------------------------------------------------+
void CLabelsTable::UpdateTable(void)
  {
//--- �������� �� ���� ������, ���� ������� ����� ����������� ����������
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- ������� ������� ������� ��������� �������������� � ������������ ����� ���������
   int h=m_scrollh.CurrentPos()+l;
   int v=m_scrollv.CurrentPos()+t;
//--- �������� ���������� � ����� �������
   if(m_fix_first_column)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      //--- ����
      for(int r=t; r<m_visible_rows_total; r++)
        {
         if(r>=t && r<m_rows_total)
            m_columns[0].m_rows[r].Description(m_vcolumns[0].m_vrows[v]);
         //---
         v++;
        }
     }
//--- �������� ���������� � ������� ����
   if(m_fix_first_row)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      //--- �������
      for(int c=l; c<m_visible_columns_total; c++)
        {
         if(h>=l && h<m_columns_total)
            m_columns[c].m_rows[0].Description(m_vcolumns[h].m_vrows[0]);
         //---
         h++;
        }
     }
//--- ������� ������� ������� �������� �������������� ������ ���������
   h=m_scrollh.CurrentPos()+l;
//--- �������
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- ������� ������� ������� �������� ������������ ������ ���������
      v=m_scrollv.CurrentPos()+t;
      //--- ����
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- �������� ������ �������
         if(v>=t && v<m_rows_total && h>=l && h<m_columns_total)
           {
            //--- ������������� �����
            m_columns[c].m_rows[r].Color(m_vcolumns[h].m_colors[v]);
            //--- ������������� ��������
            m_columns[c].m_rows[r].Description(m_vcolumns[h].m_vrows[v]);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| ����������� ��������                                             |
//+------------------------------------------------------------------+
void CLabelsTable::Moving(const int x,const int y)
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
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//--- �������
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- ����
      for(int r=0; r<m_visible_rows_total; r++)
        {
         //--- ���������� ��������� � ����� ��������
         m_columns[c].m_rows[r].X(x+m_columns[c].m_rows[r].XGap());
         m_columns[c].m_rows[r].Y(y+m_columns[c].m_rows[r].YGap());
         //--- ���������� ��������� ����������� ��������
         m_columns[c].m_rows[r].X_Distance(m_columns[c].m_rows[r].X());
         m_columns[c].m_rows[r].Y_Distance(m_columns[c].m_rows[r].Y());
        }
     }
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CLabelsTable::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- �������� ������ ���������
   m_scrollv.Show();
   m_scrollh.Show();
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CLabelsTable::Hide(void)
  {
//--- �����, ���� ������� ��� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ ������ ���������
   m_scrollv.Hide();
   m_scrollh.Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CLabelsTable::Reset(void)
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
void CLabelsTable::Delete(void)
  {
//--- �������� ����������� ��������
   m_area.Delete();
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Delete();
      //---
      ::ArrayFree(m_columns[c].m_rows);
     }
//--- ������������ �������� ��������
   for(int c=0; c<m_columns_total; c++)
     {
      ::ArrayFree(m_vcolumns[c].m_vrows);
      ::ArrayFree(m_vcolumns[c].m_colors);
     }
//---
   ::ArrayFree(m_columns);
   ::ArrayFree(m_vcolumns);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CLabelsTable::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(m_zorder);
     }
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CLabelsTable::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_scrollv.ResetZorders();
   m_scrollh.ResetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(0);
     }
  }
//+------------------------------------------------------------------+
//| ���������� ��������                                              |
//+------------------------------------------------------------------+
void CLabelsTable::FastSwitching(void)
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
      //--- ������� ������
      UpdateTable();
     }
  }
//+------------------------------------------------------------------+
