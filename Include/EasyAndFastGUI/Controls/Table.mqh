//+------------------------------------------------------------------+
//|                                                        Table.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������� �� ����� �����                        |
//+------------------------------------------------------------------+
class CTable : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� �������
   CRectLabel        m_area;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   //--- ������ �������� ������� ����� �������
   struct TEdits
     {
      CEdit             m_rows[];
     };
   TEdits            m_columns[];
   //--- ������� �������� � ������� �������
   struct TOptions
     {
      string            m_vrows[];
      ENUM_ALIGN_MODE   m_text_align[];
      color             m_text_color[];
      color             m_cell_color[];
     };
   TOptions          m_vcolumns[];
   //--- ���������� �������� � ����� (����� � ������� �����) �������
   int               m_rows_total;
   int               m_columns_total;
   int               m_visible_rows_total;
   int               m_visible_columns_total;
   //--- ������ ����� �������
   int               m_row_y_size;
   //--- (1) ���� ���� � (2) ����� ���� �������
   color             m_area_color;
   color             m_area_border_color;
   //--- ���� �����
   color             m_grid_color;
   //--- ���� ���� ����������
   color             m_headers_color;
   //--- ���� ������ ����������
   color             m_headers_text_color;
   //--- ���� ����� � ������ ����������
   color             m_cell_color;
   color             m_cell_color_hover;
   //--- ���� ������ � ������� �� ���������
   color             m_cell_text_color;
   //--- ���� (1) ���� � (2) ������ ���������� ������
   color             m_selected_row_color;
   color             m_selected_row_text_color;
   //--- (1) ������ � (2) ����� ���������� ������
   int               m_selected_item;
   string            m_selected_item_text;
   //--- ����� ������������� �������
   bool              m_read_only;
   //--- ����� ��������� ������ ��� ��������� ������� ����
   bool              m_lights_hover;
   //--- ����� ���������� ������
   bool              m_selectable_row;
   //--- ����� �������� ������ ������
   bool              m_fix_first_row;
   //--- ����� �������� ������� �������
   bool              m_fix_first_column;
   //--- ������ ������������ ������ � ����� ����� �� ���������
   ENUM_ALIGN_MODE   m_align_mode;
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
                     CTable(void);
                    ~CTable(void);
   //--- ������ ��� �������� �������
   bool              CreateTable(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCells(void);
   bool              CreateCanvasCells(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ��������� �� ������ ���������
   void              WindowPointer(CWindow &object)                    { m_wnd=::GetPointer(object);      }
   CScrollV         *GetScrollVPointer(void)                           { return(::GetPointer(m_scrollv)); }
   CScrollH         *GetScrollHPointer(void)                           { return(::GetPointer(m_scrollh)); }
   //--- ���� (1) ���� � (2) ����� �������
   void              AreaColor(const color clr)                        { m_area_color=clr;                }
   void              BorderColor(const color clr)                      { m_area_border_color=clr;         }
   //--- (1) ���������� � (2) ������������� ����� �������� ������ ������
   bool              FixFirstRow(void)                           const { return(m_fix_first_row);         }
   void              FixFirstRow(const bool flag)                      { m_fix_first_row=flag;            }
   //--- (1) ���������� � (2) ������������� ����� �������� ������� �������
   bool              FixFirstColumn(void)                        const { return(m_fix_first_column);      }
   void              FixFirstColumn(const bool flag)                   { m_fix_first_column=flag;         }
   //--- ���� (1) ���� ����������, (2) ������ ���������� � (3) ����� �������
   void              HeadersColor(const color clr)                     { m_headers_color=clr;             }
   void              HeadersTextColor(const color clr)                 { m_headers_text_color=clr;        }
   void              GridColor(const color clr)                        { m_grid_color=clr;                }
   //--- ������ ����� �� ��� Y
   void              RowYSize(const int y_size)                        { m_row_y_size=y_size;             }
   void              CellColor(const color clr)                        { m_cell_color=clr;                }
   void              CellColorHover(const color clr)                   { m_cell_color_hover=clr;          }
   //--- ������ (1) "������ ������", (2) ��������� ���� ��� ��������� ������� ����, (3) ��������� ����
   void              ReadOnly(const bool flag)                         { m_read_only=flag;                }
   void              LightsHover(const bool flag)                      { m_lights_hover=flag;             }
   void              SelectableRow(const bool flag)                    { m_selectable_row=flag;           }
   //--- ���������� ����� ���������� (1) ����� � (2) ��������, (3) ��������� ������ ���������
   int               RowsTotal(void)                             const { return(m_rows_total);            }
   int               ColumnsTotal(void)                          const { return(m_columns_total);         }
   //--- ���������� ���������� (1) ����� � (2) �������� ������� ����� �������
   int               VisibleRowsTotal(void)                      const { return(m_visible_rows_total);    }
   int               VisibleColumnsTotal(void)                   const { return(m_visible_columns_total); }
   //--- ���������� (1) ������ � (2) ����� ����������� ���� � �������, (3) ������ ������������ ������ � �������
   int               SelectedItem(void)                          const { return(m_selected_item);         }
   string            SelectedItemText(void)                      const { return(m_selected_item_text);    }
   void              TextAlign(const ENUM_ALIGN_MODE align_mode)       { m_align_mode=align_mode;         }

   //--- ������������� (1) ������ ������� � (2) ������ ������� � �����
   void              TableSize(const int columns_total,const int rows_total);
   void              VisibleTableSize(const int visible_columns_total,const int visible_rows_total);
   //--- ��������� (1) ������� ������������ ������, (2) ����� ������, (3) ����� ���� ������
   void              TextAlign(const int column_index,const int row_index,const ENUM_ALIGN_MODE mode);
   void              TextColor(const int column_index,const int row_index,const color clr);
   void              CellColor(const int column_index,const int row_index,const color clr);
   //--- ������������� �������� � ��������� ������ �������
   void              SetValue(const int column_index,const int row_index,const string value);
   //--- �������� �������� �� ��������� ������ �������
   string            GetValue(const int column_index,const int row_index);
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
   virtual void      ResetColors(void);
   //---
private:
   //--- ��������� ������� �� ���� �������
   bool              OnClickTableRow(const string clicked_object);
   //--- ��������� ����� �������� � ������ �������
   bool              OnEndEditCell(const string edited_object);
   //--- ��������� �������������� �� ����� �������
   int               IdFromObjectName(const string object_name);
   //--- ��������� ������ ������� �� ����� �������
   int               ColumnIndexFromObjectName(const string object_name);
   //--- ��������� ������ ���� �� ����� �������
   int               RowIndexFromObjectName(const string object_name);
   //--- ��������� ����������� ����
   void              HighlightSelectedItem(void);
   //--- ��������� ����� ���� ������� ��� ��������� ������� ����
   void              RowColorByHover(const int x,const int y);
   //--- ���������� ��������� ������ �������
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTable::CTable(void) : m_row_y_size(18),
                       m_fix_first_row(false),
                       m_fix_first_column(false),
                       m_read_only(true),
                       m_lights_hover(false),
                       m_selectable_row(false),
                       m_align_mode(ALIGN_LEFT),
                       m_rows_total(2),
                       m_columns_total(1),
                       m_visible_rows_total(2),
                       m_visible_columns_total(1),
                       m_selected_item(WRONG_VALUE),
                       m_selected_item_text(""),
                       m_headers_color(C'103,116,141'),
                       m_headers_text_color(clrWhite),
                       m_area_color(clrLightGray),
                       m_area_border_color(C'240,240,240'),
                       m_grid_color(clrWhite),
                       m_cell_color(clrWhite),
                       m_cell_color_hover(C'240,240,240'),
                       m_cell_text_color(clrBlack),
                       m_selected_row_color(C'51,153,255'),
                       m_selected_row_text_color(clrWhite)
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
CTable::~CTable(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
         //--- ������� �������
         UpdateTable();
      //--- ��������� ����������� ����
      HighlightSelectedItem();
      //--- �������� ���� ���� ������� ��� ��������� ������� ����
      RowColorByHover(x,y);
      return;
     }
//--- ��������� ������� �� ��������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- �����, ���� ����� �������������
      if(m_wnd.IsLocked())
         return;
      //--- ���� ������ �� ���� �������
      if(OnClickTableRow(sparam))
        {
         //--- ��������� ����������� ����
         HighlightSelectedItem();
         return;
        }
      //--- ���� ������ �� ������ ������ ���������
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
        {
         //--- ���������� ������ ������� � ������ ��������� ���������
         UpdateTable();
         //--- ��������� ����������� ����
         HighlightSelectedItem();
         return;
        }
      return;
     }
//--- ��������� ������� ��������� �������� � ���� �����
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      OnEndEditCell(sparam);
      //--- �������� ����� �������
      ResetColors();
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CTable::OnEventTimer(void)
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
//| ������ ������� �� ����� �����                                   |
//+------------------------------------------------------------------+
bool CTable::CreateTable(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������� ������ ����� �������� "
              "��������� �� �����: CTable::WindowPointer(CWindow &object).");
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
bool CTable::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_table_area_"+(string)CElement::Id();
//--- ���� ���� �������������� ������ ���������, �� ��������������� ������ ������� �� ��� Y
   m_y_size=(m_columns_total>m_visible_columns_total) ? m_y_size+m_scrollh.ScrollWidth()-1 : m_y_size;
//--- �������� �������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
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
//| ������ ����� ����� �������                                      |
//+------------------------------------------------------------------+
bool CTable::CreateCells(void)
  {
//--- ���������� � ������ ����� �������
   int x =CElement::X()+1;
   int y =0;
   int w =0;
//--- �������� �� ������� ������������ ������ ���������
   bool is_scrollv=m_rows_total>m_visible_rows_total;
//--- ������ ������ ��������. 
//    ������ ������� �� ���-�� ������� �������� � ������� ������������ ������ ���������.
   if(m_visible_columns_total==1)
      w=(is_scrollv) ? m_x_size-m_scrollv.ScrollWidth() : m_x_size-2;
   else
      w=(is_scrollv) ?(m_x_size-m_scrollv.ScrollWidth())/m_visible_columns_total : m_x_size/m_visible_columns_total+1;
//--- �������
   for(int c=0; c<m_visible_columns_total && c<m_columns_total; c++)
     {
      //--- ������ ���������� X
      x=(c>0) ? x+w-1 : CElement::X()+1;
      //--- ������������� ������ ���������� �������
      if(c+1>=m_visible_columns_total)
         w=(is_scrollv) ? CElement::X2()-x-m_scrollv.ScrollWidth() : CElement::X2()-x-1;
      //--- ����
      for(int r=0; r<m_visible_rows_total && r<m_rows_total; r++)
        {
         //--- ������������ ����� �������
         string name=CElement::ProgramName()+"_table_edit_"+(string)c+"_"+(string)r+"__"+(string)CElement::Id();
         //--- ������ ���������� Y
         y=(r>0) ? y+m_row_y_size-1 : CElement::Y()+1;
         //--- �������� �������
         if(!m_columns[c].m_rows[r].Create(m_chart_id,name,m_subwin,x,y,w,m_row_y_size))
            return(false);
         //--- ��������� �������
         m_columns[c].m_rows[r].Description("");
         m_columns[c].m_rows[r].TextAlign(m_align_mode);
         m_columns[c].m_rows[r].Font(FONT);
         m_columns[c].m_rows[r].FontSize(FONT_SIZE);
         m_columns[c].m_rows[r].Color(m_cell_text_color);
         m_columns[c].m_rows[r].BackColor(m_cell_color);
         m_columns[c].m_rows[r].BorderColor(m_grid_color);
         m_columns[c].m_rows[r].Corner(m_corner);
         m_columns[c].m_rows[r].Anchor(m_anchor);
         m_columns[c].m_rows[r].Selectable(false);
         m_columns[c].m_rows[r].Z_Order(m_cell_zorder);
         m_columns[c].m_rows[r].ReadOnly(m_read_only);
         m_columns[c].m_rows[r].Tooltip("\n");
         //--- ����������
         m_columns[c].m_rows[r].X(x);
         m_columns[c].m_rows[r].Y(y);
         //--- ������� �� ������� ����� ������
         m_columns[c].m_rows[r].XGap(x-m_wnd.X());
         m_columns[c].m_rows[r].YGap(y-m_wnd.Y());
         //--- �������
         m_columns[c].m_rows[r].XSize(w);
         m_columns[c].m_rows[r].YSize(m_row_y_size);
         //--- �������� ��������� �������
         CElement::AddToArray(m_columns[c].m_rows[r]);
        }
     }
//--- ��������� ���������� ������
   HighlightSelectedItem();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������ ������ ���������                            |
//+------------------------------------------------------------------+
bool CTable::CreateScrollV(void)
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
//--- ��������� �������
   m_scrollv.Id(CElement::Id());
   m_scrollv.IsDropdown(CElement::IsDropdown());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize((m_columns_total>m_visible_columns_total)? CElement::YSize()-m_scrollv.ScrollWidth()+1 : CElement::YSize());
//--- �������� ������ ���������
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_rows_total,m_visible_rows_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������������� ������ ���������                          |
//+------------------------------------------------------------------+
bool CTable::CreateScrollH(void)
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
//--- ��������� �������
   m_scrollh.Id(CElement::Id());
   m_scrollh.IsDropdown(CElement::IsDropdown());
   m_scrollh.XSize((m_rows_total>m_visible_rows_total)? m_area.XSize()-m_scrollh.ScrollWidth()+1 : m_area.XSize());
   m_scrollh.YSize(m_scrollh.ScrollWidth());
//--- �������� ������ ���������
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_columns_total,m_visible_columns_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������ �� ��������� ��������                           |
//+------------------------------------------------------------------+
void CTable::SetValue(const int column_index,const int row_index,const string value)
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
string CTable::GetValue(const int column_index,const int row_index)
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
//| ��������� ������ ������� ������������ ������                     |
//+------------------------------------------------------------------+
void CTable::TextAlign(const int column_index,const int row_index,const ENUM_ALIGN_MODE mode)
  {
//--- �������� �� ����� �� ��������� ��������
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- �������� �� ����� �� ��������� �����
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- ���������� ���� ������ � ����� ������
   m_vcolumns[column_index].m_text_align[row_index]=mode;
  }
//+------------------------------------------------------------------+
//| ��������� ������ ������ ������                                   |
//+------------------------------------------------------------------+
void CTable::TextColor(const int column_index,const int row_index,const color clr)
  {
//--- �������� �� ����� �� ��������� ��������
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- �������� �� ����� �� ��������� �����
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- ���������� ���� ������ � ����� ������
   m_vcolumns[column_index].m_text_color[row_index]=clr;
  }
//+------------------------------------------------------------------+
//| ��������� ������ ������ �����                                    |
//+------------------------------------------------------------------+
void CTable::CellColor(const int column_index,const int row_index,const color clr)
  {
//--- �������� �� ����� �� ��������� ��������
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- �������� �� ����� �� ��������� �����
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- ���������� ���� ���� ������ � ����� ������
   m_vcolumns[column_index].m_cell_color[row_index]=clr;
  }
//+------------------------------------------------------------------+
//| ������������� ������ �������                                     |
//+------------------------------------------------------------------+
void CTable::TableSize(const int columns_total,const int rows_total)
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
      ::ArrayResize(m_vcolumns[i].m_text_align,m_rows_total);
      ::ArrayResize(m_vcolumns[i].m_text_color,m_rows_total);
      ::ArrayResize(m_vcolumns[i].m_cell_color,m_rows_total);
      //--- ������������� ������� ����� ���� ����� ��������� �� ���������
      ::ArrayInitialize(m_vcolumns[i].m_text_align,m_align_mode);
      ::ArrayInitialize(m_vcolumns[i].m_text_color,m_cell_text_color);
      ::ArrayInitialize(m_vcolumns[i].m_cell_color,m_cell_color);
     }
  }
//+------------------------------------------------------------------+
//| ������������� ������ ������� ����� �������                       |
//+------------------------------------------------------------------+
void CTable::VisibleTableSize(const int visible_columns_total,const int visible_rows_total)
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
//| ���������� ������ ������� � ������ ��������� ���������           |
//+------------------------------------------------------------------+
void CTable::UpdateTable(void)
  {
//--- �������� �� ���� ������, ���� ������� ����� ����������� ����������
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- ������� ������� ������� ��������� �������������� � ������������ ����� ���������
   int h=m_scrollh.CurrentPos()+l;
   int v=m_scrollv.CurrentPos()+t;
//--- ��������� ������� ��� ������ ������, ���� �������� ������ �������� ����������
   if(m_fix_first_column && m_fix_first_row)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      m_columns[0].m_rows[0].BackColor(m_headers_color);
      m_columns[0].m_rows[0].Color(m_headers_text_color);
      m_columns[0].m_rows[0].TextAlign(m_vcolumns[0].m_text_align[0]);
     }
//--- �������� ���������� � ����� �������
   if(m_fix_first_column)
     {
      //--- ����
      for(int r=t; r<m_visible_rows_total; r++)
        {
         if(r>=t && r<m_rows_total)
           {
            //--- ������������� ��������
            m_columns[0].m_rows[r].Description(m_vcolumns[0].m_vrows[v]);
            //--- ������������� ����� ���� ������
            m_columns[0].m_rows[r].BackColor(m_headers_color);
            //--- ������������� ����� ������ ������
            m_columns[0].m_rows[r].Color(m_headers_text_color);
            //--- ������������� ������������ ������ � �������
            m_columns[0].m_rows[r].TextAlign(m_vcolumns[0].m_text_align[v]);
           }
         //---
         v++;
        }
     }
//--- �������� ���������� � ������� ����
   if(m_fix_first_row)
     {
      //--- �������
      for(int c=l; c<m_visible_columns_total; c++)
        {
         if(h>=l && h<m_columns_total)
           {
            //--- ������������� ��������
            m_columns[c].m_rows[0].Description(m_vcolumns[h].m_vrows[0]);
            //--- ������������� ����� ���� ������
            m_columns[c].m_rows[0].BackColor(m_headers_color);
            //--- ������������� ����� ������ ������
            m_columns[c].m_rows[0].Color(m_headers_text_color);
            //--- ������������� ������������ ������ � �������
            m_columns[c].m_rows[0].TextAlign(m_vcolumns[h].m_text_align[0]);
           }
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
            //--- ������������� ��������
            m_columns[c].m_rows[r].Description(m_vcolumns[h].m_vrows[v]);
            //--- ������������� ����� ���� ������
            m_columns[c].m_rows[r].BackColor(m_vcolumns[h].m_cell_color[v]);
            //--- ������������� ����� ������ ������
            m_columns[c].m_rows[r].Color(m_vcolumns[h].m_text_color[v]);
            //--- ������������� ������������ ������ � �������
            m_columns[c].m_rows[r].TextAlign(m_vcolumns[h].m_text_align[v]);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CTable::Moving(const int x,const int y)
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
void CTable::Show(void)
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
void CTable::Hide(void)
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
void CTable::Reset(void)
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
void CTable::Delete(void)
  {
//--- �������� ����������� ��������
   m_area.Delete();
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Delete();
      //--- ������������ �������� ��������
      ::ArrayFree(m_columns[c].m_rows);
     }
//--- ������������ �������� ��������
   for(int c=0; c<m_columns_total; c++)
     {
      ::ArrayFree(m_vcolumns[c].m_vrows);
      ::ArrayFree(m_vcolumns[c].m_text_align);
      ::ArrayFree(m_vcolumns[c].m_text_color);
      ::ArrayFree(m_vcolumns[c].m_cell_color);
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
void CTable::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(m_cell_zorder);
     }
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CTable::ResetZorders(void)
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
//| ����� ����� �������� ��������                                    |
//+------------------------------------------------------------------+
void CTable::ResetColors(void)
  {
//--- �������� �� ���� ������, ���� ������� ����� ����������� ����������
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- ������� ������� ������� �������� �������������� ������ ���������
   int h=m_scrollh.CurrentPos()+l;
//--- �������
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- ������� ������� ������� �������� ������������ ������ ���������
      int v=m_scrollv.CurrentPos()+t;
      //--- ����
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- �������� ��� �������������� ������ �� ���������
         if(v>=t && v<m_rows_total)
           {
            //--- ����������, ���� ����� �� ���������� ������ � ��� ���� � ������ "������ ������"
            if(m_selected_item==v && m_read_only)
              {
               v++;
               continue;
              }
            //--- ������������� ����� ���� ������
            m_columns[c].m_rows[r].BackColor(m_vcolumns[h].m_cell_color[v]);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ���� �������                                |
//+------------------------------------------------------------------+
bool CTable::OnClickTableRow(const string clicked_object)
  {
//--- �����, ���� ������� ����� ������������� �������
   if(!m_read_only)
      return(false);
//--- �����, ���� ������ ��������� � ��������
   if(m_scrollv.ScrollState() || m_scrollh.ScrollState())
      return(false);
//--- ������, ���� ������� ���� �� �� ������ �������
   if(::StringFind(clicked_object,CElement::ProgramName()+"_table_edit_",0)<0)
      return(false);
//--- ������� ������������� ����� �������
   int id=IdFromObjectName(clicked_object);
//--- �����, ���� ������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ��� ������ ������� ����
   int row_index=0;
//--- �������� �� ���� ������, ���� ������� ����� ����������� ����������
   int t=(m_fix_first_row) ? 1 : 0;
//--- �������
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- ������� ������� ������� �������� ������������ ������ ���������
      int v=m_scrollv.CurrentPos()+t;
      //--- ����
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- ���� ������� ���� �� ���� ������
         if(m_columns[c].m_rows[r].Name()==clicked_object)
           {
            //--- �������� ������ ����
            m_selected_item=row_index=v;
            //--- �������� ������ ������
            m_selected_item_text=m_columns[c].m_rows[r].Description();
            break;
           }
         //--- �������� ������� ����
         if(v>=t && v<m_rows_total)
            v++;
        }
     }
//--- �����, ���� ������ �� ���������
   if(m_fix_first_row && row_index<1)
      return(false);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_LIST_ITEM,CElement::Id(),m_selected_item,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� ��������� �������������� �������� � ������               |
//+------------------------------------------------------------------+
bool CTable::OnEndEditCell(const string edited_object)
  {
//--- �����, ���� �������� ����� ������������� �������
   if(m_read_only)
      return(false);
//--- ������, ���� ������� ���� �� �� ������ �������
   if(::StringFind(edited_object,CElement::ProgramName()+"_table_edit_",0)<0)
      return(false);
//--- ������� ������������� �� ����� �������
   int id=IdFromObjectName(edited_object);
//--- �����, ���� ������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ������� ������� ������� � ���� ������
   int c =ColumnIndexFromObjectName(edited_object);
   int r =RowIndexFromObjectName(edited_object);
//--- ������� ������� ������� � ���� � ������� ������
   int vc =c+m_scrollh.CurrentPos();
   int vr =r+m_scrollv.CurrentPos();
//--- ��������������� ������ ����, ���� ������� ���� �� ���������
   if(m_fix_first_row && r==0)
      vr=0;
//--- ������� �������� ��������
   string cell_text=m_columns[c].m_rows[r].Description();
//--- ���� �������� � ������ ���� ��������
   if(cell_text!=m_vcolumns[vc].m_vrows[vr])
     {
      //--- �������� ����� �������� � �������
      SetValue(vc,vr,cell_text);
      //--- �������� ��������� �� ����
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),0,string(vc)+"_"+string(vr)+"_"+cell_text);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CTable::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
//| ��������� ������ ������� �� ����� �������                        |
//+------------------------------------------------------------------+
int CTable::ColumnIndexFromObjectName(const string object_name)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- ������� ��� �����������
   u_sep=::StringGetCharacter("_",0);
//--- �������� ������
   ::StringSplit(object_name,u_sep,result);
   array_size=::ArraySize(result)-1;
//--- �������� ������ �� �������� �������
   if(array_size-3<0)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- ������� ������ ������
   return((int)result[array_size-3]);
  }
//+------------------------------------------------------------------+
//| ��������� ������ ���� �� ����� �������                           |
//+------------------------------------------------------------------+
int CTable::RowIndexFromObjectName(const string object_name)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- ������� ��� �����������
   u_sep=::StringGetCharacter("_",0);
//--- �������� ������
   ::StringSplit(object_name,u_sep,result);
   array_size=::ArraySize(result)-1;
//--- �������� ������ �� �������� �������
   if(array_size-2<0)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- ������� ������ ������
   return((int)result[array_size-2]);
  }
//+------------------------------------------------------------------+
//| ��������� ����������� ����                                       |
//+------------------------------------------------------------------+
void CTable::HighlightSelectedItem(void)
  {
//--- �����, ���� ���� �� ������� ("������ ������", "��������� ������") ��������
   if(!m_read_only || !m_selectable_row)
      return;
//--- �������� �� ���� ������, ���� ������� ����� ����������� ����������
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- ������� ������� ������� �������� �������������� ������ ���������
   int h=m_scrollh.CurrentPos()+l;
//--- �������
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- ������� ������� ������� �������� ������������ ������ ���������
      int v=m_scrollv.CurrentPos()+t;
      //--- ����
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- �������� ������ �������
         if(v>=t && v<m_rows_total)
           {
            //--- ������������� � ������ ���������� ������
            color back_color=(m_selected_item==v) ? m_selected_row_color : m_vcolumns[h].m_cell_color[v];
            color text_color=(m_selected_item==v) ? m_selected_row_text_color : m_vcolumns[h].m_text_color[v];
            //--- ������������� ����� ������ � ���� ������
            m_columns[c].m_rows[r].Color(text_color);
            m_columns[c].m_rows[r].BackColor(back_color);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ���� ������� ��� ��������� ������� ����          |
//+------------------------------------------------------------------+
void CTable::RowColorByHover(const int x,const int y)
  {
//--- �����, ���� ��������� ���������� ���� ��� ��������� ������� ���� ��� ����� �������������
   if(!m_lights_hover || !m_read_only || m_wnd.IsLocked())
      return;
//--- �����, ���� ������ ��������� � �������� �����������
   if(m_scrollv.ScrollState() || m_scrollh.ScrollState())
      return;
//--- �������� �� ���� ������, ���� ������� ����� ����������� ����������
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- ������� ������� ������� �������� �������������� ������ ���������
   int h=m_scrollh.CurrentPos()+l;
//--- �������
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- ������� ������� ������� �������� ������������ ������ ���������
      int v=m_scrollv.CurrentPos()+t;
      //--- ����
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- �������� ��� �������������� ������ �� ���������
         if(v>=t && v<m_rows_total)
           {
            //--- ����������, ���� � ������ "������ ������", �������� ��������� ���� � ����� �� ���������� ������
            if(m_selected_item==v && m_read_only && m_selectable_row)
              {
               v++;
               continue;
              }
            //--- ���������� ���, ���� ������ ��� ���
            if(x>m_columns[0].m_rows[r].X() && x<m_columns[m_visible_columns_total-1].m_rows[r].X2() &&
               y>m_columns[c].m_rows[r].Y() && y<m_columns[c].m_rows[r].Y2())
              {
               m_columns[c].m_rows[r].BackColor(m_cell_color_hover);
              }
            //--- ������� ���� �� ���������, ���� ������ ��� ������� ����� ����
            else
              {
               if(v>=t && v<m_rows_total)
                  m_columns[c].m_rows[r].BackColor(m_vcolumns[h].m_cell_color[v]);
              }
            //---
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������ �������                              |
//+------------------------------------------------------------------+
void CTable::FastSwitching(void)
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
      //--- ���������� ������ � �������
      UpdateTable();
      //--- ��������� ������
      HighlightSelectedItem();
     }
  }
//+------------------------------------------------------------------+
