//+------------------------------------------------------------------+
//|                                                     ListView.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������                                        |
//+------------------------------------------------------------------+
class CListView : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ��������� �� �������, ����������� ���������� ������
   CElement         *m_combobox;
   //--- ������� ��� �������� ������
   CRectLabel        m_area;
   CEdit             m_items[];
   CScrollV          m_scrollv;
   //--- ������ �������� ������
   string            m_value_items[];
   //--- ������ ������ � ��� ������� �����
   int               m_items_total;
   int               m_visible_items_total;
   //--- (1) ������ � (2) ����� ���������� ������
   int               m_selected_item_index;
   string            m_selected_item_text;
   //--- �������� ���� ������
   int               m_area_zorder;
   color             m_area_border_color;
   //--- �������� ������� ������
   int               m_item_zorder;
   int               m_item_y_size;
   color             m_item_color;
   color             m_item_color_hover;
   color             m_item_color_selected;
   color             m_item_text_color;
   color             m_item_text_color_hover;
   color             m_item_text_color_selected;
   //--- ����� ������������ ������ � ������
   ENUM_ALIGN_MODE   m_align_mode;
   //--- ����� ��������� ��� ��������� �������
   bool              m_lights_hover;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //--- ������� ������� ��� ��������� ������
   int               m_timer_counter;
   //---
public:
                     CListView(void);
                    ~CListView(void);
   //--- ������ ��� �������� ������
   bool              CreateListView(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateList(void);
   bool              CreateScrollV(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ��������� �� �����-����, (3) ���������� ��������� �� ������ ���������
   void              WindowPointer(CWindow &object)                      { m_wnd=::GetPointer(object);      }
   void              ComboBoxPointer(CElement &object)                   { m_combobox=::GetPointer(object); }
   CScrollV         *GetScrollVPointer(void)                             { return(::GetPointer(m_scrollv)); }
   //--- (1) ������ ������, ���������� (2) ������ ������ � (3) ������� ��� �����
   void              ItemYSize(const int y_size)                         { m_item_y_size=y_size;            }
   int               ItemsTotal(void)                              const { return(m_items_total);           }
   int               VisibleItemsTotal(void)                       const { return(m_visible_items_total);   }
   //--- ��������� ������ ���������
   bool              ScrollState(void)                             const { return(m_scrollv.ScrollState()); }
   //--- (1) ���� ����� ����, (2) ����� ��������� ������� ��� ���������, (3) ����� ������������ ������
   void              AreaBorderColor(const color clr)                    { m_area_border_color=clr;         }
   void              LightsHover(const bool state)                       { m_lights_hover=state;            }
   void              TextAlign(const ENUM_ALIGN_MODE align_mode)         { m_align_mode=align_mode;         }
   //--- ����� ������� ������ � ������ ����������
   void              ItemColor(const color clr)                          { m_item_color=clr;                }
   void              ItemColorHover(const color clr)                     { m_item_color_hover=clr;          }
   void              ItemColorSelected(const color clr)                  { m_item_color_selected=clr;       }
   void              ItemTextColor(const color clr)                      { m_item_text_color=clr;           }
   void              ItemTextColorHover(const color clr)                 { m_item_text_color_hover=clr;     }
   void              ItemTextColorSelected(const color clr)              { m_item_text_color_selected=clr;  }
   //--- ����������/c�������� (1) ������ � (2) ����� ����������� ������ � ������
   void              SelectedItemByIndex(const int index);
   int               SelectedItemIndex(void)                       const { return(m_selected_item_index);   }
   string            SelectedItemText(void)                        const { return(m_selected_item_text);    }
   //--- ��������� �������� � ������ �� ���������� ������� ����
   void              ValueToList(const int item_index,const string value);
   //--- ��������� (1) ������� ������ � (2) ������� ��� �����
   void              ListSize(const int items_total);
   void              VisibleListSize(const int visible_items_total);
   //--- (1) ����� ����� ������� ������, (2) ��������� ����� ������� ������ ��� ���������
   void              ResetItemsColor(void);
   void              ChangeItemsColor(const int x,const int y);
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
   //---
private:
   //--- ��������� ������� �� ������ ������
   bool              OnClickListItem(const string clicked_object);
   //--- ��������� �������������� �� ����� ������ ������
   int               IdFromObjectName(const string object_name);
   //--- �������� ������
   void              ShiftList(void);
   //--- ��������� ���������� ������
   void              HighlightSelectedItem(void);
   //--- ���������� ��������� ������
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CListView::CListView(void) : m_item_y_size(18),
                             m_mouse_state(false),
                             m_lights_hover(false),
                             m_align_mode(ALIGN_LEFT),
                             m_items_total(2),
                             m_visible_items_total(2),
                             m_selected_item_index(WRONG_VALUE),
                             m_selected_item_text(""),
                             m_area_border_color(C'235,235,235'),
                             m_item_color(clrWhite),
                             m_item_color_hover(C'240,240,240'),
                             m_item_color_selected(C'51,153,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_hover(clrBlack),
                             m_item_text_color_selected(clrWhite)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_area_zorder =1;
   m_item_zorder =2;
//--- ��������� ������ ������ � ��� ������� �����
   ListSize(m_items_total);
   VisibleListSize(m_visible_items_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CListView::~CListView(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CListView::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- �������� ������ ��� �������
      CElement::MouseFocus(x>CElement::X() && x<CElement::X2() && 
                           y>CElement::Y() && y<CElement::Y2());
      //--- ���� ��� ���������� ������ � ������ ���� ������
      if(CElement::IsDropdown() && m_mouse_state)
        {
         //--- ���� ������ ��� �����-�����, ������ ��� ������ � �� � ������ �������
         if(!m_combobox.MouseFocus() && !CElement::MouseFocus() && !m_scrollv.ScrollState())
           {
            //--- �������� ������
            Hide();
            return;
           }
        }
      //--- ������� ������, ���� ���������� ��������� ������ ��������� � ��������
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state))
         ShiftList();
      //--- �������� ���� ����� ������ ��� ���������
      ChangeItemsColor(x,y);
      return;
     }
//--- ��������� ������� �� ��������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ���� ���� ������� �� �������� ������
      if(OnClickListItem(sparam))
        {
         //--- ��������� ������
         HighlightSelectedItem();
         return;
        }
      //--- ���� ���� ������� �� ������� ������ ��������� ������
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam))
        {
         //--- �������� ������ ������������ ������ ���������
         ShiftList();
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CListView::OnEventTimer(void)
  {
//--- ���� ������� ����������
   if(CElement::IsDropdown())
      //--- ��������� ������
      FastSwitching();
//--- ���� ������� �� ����������, �� ��������� ����������� ����� � ������� ������
   else
     {
      //--- ����������� ��������� ������, ������ ���� ����� �� �������������
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������                                                   |
//+------------------------------------------------------------------+
bool CListView::CreateListView(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ������ ����� �������� "
              "��������� �� �����: CListView::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ���� ������ ����������, ������ ����� ��������� �� �����-����, � �������� �� ����� ��������
   if(CElement::IsDropdown())
     {
      //--- �����, ���� ��� ��������� �� �����-����
      if(::CheckPointer(m_combobox)==POINTER_INVALID)
        {
         ::Print(__FUNCTION__," > ����� ��������� ����������� ������ ������ ����� �������� "
                 "��������� �� �����-����: CListView::ComboBoxPointer(CElement &object)");
         return(false);
        }
     }
//--- ������������� ����������
   m_id                  =m_wnd.LastId()+1;
   m_chart_id            =chart_id;
   m_subwin              =subwin;
   m_x                   =x;
   m_y                   =y;
   m_y_size              =m_item_y_size*m_visible_items_total-(m_visible_items_total-1)+2;
   m_selected_item_index =(m_selected_item_index==WRONG_VALUE) ? 0 : m_selected_item_index;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ������
   if(!CreateArea())
      return(false);
   if(!CreateList())
      return(false);
   if(!CreateScrollV())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ��� ������                                           |
//+------------------------------------------------------------------+
bool CListView::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_listview_area_"+(string)CElement::Id();
//--- �������� �������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- ��������� �������
   m_area.BackColor(m_item_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- �������� ����������
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- �������� �������
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
//--- ������� �� ������� �����
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ������                                            |
//+------------------------------------------------------------------+
bool CListView::CreateList(void)
  {
//--- ����������
   int x =CElement::X()+1;
   int y =0;
//--- ������ ������ ������� ������
   int w=(m_items_total>m_visible_items_total) ? CElement::XSize()-m_scrollv.ScrollWidth() : CElement::XSize()-2;
//---
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- ������������ ����� �������
      string name=CElement::ProgramName()+"_listview_edit_"+(string)i+"__"+(string)CElement::Id();
      //--- ������ ���������� Y
      y=(i>0) ? y+m_item_y_size-1 : CElement::Y()+1;
      //--- �������� �������
      if(!m_items[i].Create(m_chart_id,name,m_subwin,x,y,w,m_item_y_size))
         return(false);
      //--- ��������� �������
      m_items[i].Description(m_value_items[i]);
      m_items[i].TextAlign(m_align_mode);
      m_items[i].Font(FONT);
      m_items[i].FontSize(FONT_SIZE);
      m_items[i].Color(m_item_text_color);
      m_items[i].BackColor(m_item_color);
      m_items[i].BorderColor(m_item_color);
      m_items[i].Corner(m_corner);
      m_items[i].Anchor(m_anchor);
      m_items[i].Selectable(false);
      m_items[i].Z_Order(m_item_zorder);
      m_items[i].ReadOnly(true);
      m_items[i].Tooltip("\n");
      //--- ����������
      m_items[i].X(x);
      m_items[i].Y(y);
      //--- �������
      m_items[i].XSize(w);
      m_items[i].YSize(m_item_y_size);
      //--- ������� �� ������� ����� ������
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- �������� ��������� �������
      CElement::AddToArray(m_items[i]);
     }
//--- ��������� ����������� ������
   HighlightSelectedItem();
//--- �������� ������ ������������ ������ ���������
   ShiftList();
//--- �������� ����� ����������� ������
   m_selected_item_text=m_value_items[m_selected_item_index];
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������������ ������                                      |
//+------------------------------------------------------------------+
bool CListView::CreateScrollV(void)
  {
//--- ���� ���������� ������� ������, ��� ������ ������, ��
//    ��������� ������������ ���������
   if(m_items_total<=m_visible_items_total)
      return(true);
//--- ��������� ��������� �����
   m_scrollv.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X()+m_area.X_Size()-m_scrollv.ScrollWidth();
   int y=CElement::Y();
//--- ��������� ��������
   m_scrollv.Id(CElement::Id());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(CElement::YSize());
   m_scrollv.AreaBorderColor(m_area_border_color);
   m_scrollv.IsDropdown(CElement::IsDropdown());
//--- �������� ������ ���������
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_items_total,m_visible_items_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CListView::SelectedItemByIndex(const int index)
  {
//--- ������������� � ������ ������ �� ���������
   m_selected_item_index=(index>=m_items_total)? m_items_total-1 :(index<0)? 0 : index;
//--- ��������� ����������� ������
   HighlightSelectedItem();
//--- �������� ������ ������������ ������ ���������
   ShiftList();
//--- �������� ����� ����������� ������
   m_selected_item_text=m_value_items[m_selected_item_index];
  }
//+------------------------------------------------------------------+
//| ��������� ���������� �������� � ������ �� ���������� �������     |
//+------------------------------------------------------------------+
void CListView::ValueToList(const int item_index,const string value)
  {
   int array_size=::ArraySize(m_value_items);
//--- ���� ��� �� ������ ������ � ����������� ����, �������� �� ����
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� �����!");
     }
//--- ������������� � ������ ������ �� ���������
   int i=(item_index>=array_size)? array_size-1 :(item_index<0)? 0 : item_index;
//--- �������� �������� � ������
   m_value_items[i]=value;
  }
//+------------------------------------------------------------------+
//| ������������� ������ ������                                      |
//+------------------------------------------------------------------+
void CListView::ListSize(const int items_total)
  {
//--- �� ����� ������ ������ ������ ����� ���� �������
   m_items_total=(items_total<2) ? 2 : items_total;
   ::ArrayResize(m_value_items,m_items_total);
  }
//+------------------------------------------------------------------+
//| ������������� ������ ������� ����� ������                        |
//+------------------------------------------------------------------+
void CListView::VisibleListSize(const int visible_items_total)
  {
//--- �� ����� ������ ������ ������ ����� ���� �������
   m_visible_items_total=(visible_items_total<2) ? 2 : visible_items_total;
   ::ArrayResize(m_items,m_visible_items_total);
  }
//+------------------------------------------------------------------+
//| ����� ����� ������� ������                                       |
//+------------------------------------------------------------------+
void CListView::ResetItemsColor(void)
  {
//--- ������� ������� ������� �������� ������ ���������
   int v=m_scrollv.CurrentPos();
//--- ��� � ����� �� ������� ����� ������
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- �������� �������, ���� ������ ��������� ������
      if(v>=0 && v<m_items_total)
         v++;
      //--- ���������� ���������� �����
      if(m_selected_item_index==v-1)
         continue;
      //--- ��������� ����� (���, �����)
      m_items[i].BackColor(m_item_color);
      m_items[i].Color(m_item_text_color);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������ ������ ��� ��������� �������              |
//+------------------------------------------------------------------+
void CListView::ChangeItemsColor(const int x,const int y)
  {
//--- ������, ���� ��������� ��������� ��� ��������� ������� ��� ��������� ������ �������
   if(!m_lights_hover || m_scrollv.ScrollState())
      return;
//--- ������, ���� ������� �� ���������� � ����� �������������
   if(!CElement::IsDropdown() && m_wnd.IsLocked())
      return;
//--- ������� ������� ������� �������� ������ ���������
   int v=m_scrollv.CurrentPos();
//--- ���������, ��� ����� ������� ������ ��������� ������ � ��������� ���
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- �������� �������, ���� ������ ��������� ������
      if(v>=0 && v<m_items_total)
         v++;
      //--- ���������� ���������� �����
      if(m_selected_item_index==v-1)
        {
         m_items[i].BackColor(m_item_color_selected);
         m_items[i].Color(m_item_text_color_selected);
         continue;
        }
      //--- ���� ������ ��� ���� �������, �� ��������� ���
      if(x>m_items[i].X() && x<m_items[i].X2() && y>m_items[i].Y() && y<m_items[i].Y2())
        {
         m_items[i].BackColor(m_item_color_hover);
         m_items[i].Color(m_item_text_color_hover);
        }
      //--- ���� ������ �� ��� ���� �������, �� ������� ��������������� ����� ��������� ����
      else
        {
         m_items[i].BackColor(m_item_color);
         m_items[i].Color(m_item_text_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| �������� ������ ������������ ������ ���������                    |
//+------------------------------------------------------------------+
void CListView::ShiftList(void)
  {
//--- ������� ������� ������� �������� ������ ���������
   int v=m_scrollv.CurrentPos();
//--- ��� � ����� �� ������� ����� ������
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- ���� ������ ��������� ������
      if(v>=0 && v<m_items_total)
        {
         //--- �������� ������, ����� ���� � ����� ������
         m_items[i].Description(m_value_items[v]);
         m_items[i].BackColor((m_selected_item_index==v) ? m_item_color_selected : m_item_color);
         m_items[i].Color((m_selected_item_index==v) ? m_item_text_color_selected : m_item_text_color);
         //--- �������� �������
         v++;
        }
     }
  }
//+------------------------------------------------------------------+
//| �������� ��������� �����                                         |
//+------------------------------------------------------------------+
void CListView::HighlightSelectedItem(void)
  {
//--- ������, ���� ������ ��������� � �������� ������
   if(m_scrollv.ScrollState())
      return;
//--- ������� ������� ������� �������� ������ ���������
   int v=m_scrollv.CurrentPos();
//--- ��� � ����� �� ������� ����� ������
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- ���� ������ ��������� ������
      if(v>=0 && v<m_items_total)
        {
         //--- ��������� ����� ���� � ����� ������
         m_items[i].BackColor((m_selected_item_index==v) ? m_item_color_selected : m_item_color);
         m_items[i].Color((m_selected_item_index==v) ? m_item_text_color_selected : m_item_text_color);
         //--- �������� �������
         v++;
        }
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CListView::Moving(const int x,const int y)
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
//--- ���������� ��������� ����������� ��������   
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//---
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- ���������� ��������� � ����� ��������
      m_items[r].X(x+m_items[r].XGap());
      m_items[r].Y(y+m_items[r].YGap());
      //--- ���������� ��������� ����������� ��������
      m_items[r].X_Distance(m_items[r].X());
      m_items[r].Y_Distance(m_items[r].Y());
     }
  }
//+------------------------------------------------------------------+
//| ���������� ������                                                |
//+------------------------------------------------------------------+
void CListView::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- �������� ������ ���������
   m_scrollv.Show();
//--- ��������� ���������
   CElement::IsVisible(true);
//--- �������� ������ �� ��������� ����������� �� ������� ����� ������� ����
   if(CElement::IsDropdown())
      ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,m_id,0.0,"");
  }
//+------------------------------------------------------------------+
//| �������� ������                                                  |
//+------------------------------------------------------------------+
void CListView::Hide(void)
  {
   if(!m_wnd.IsMinimized())
      if(!CElement::IsDropdown())
         if(!CElement::IsVisible())
            return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ ������ ���������
   m_scrollv.Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
//--- �������� ������ �� �������������� ����������� �� ������� ����� ������� ����
   if(!m_wnd.IsMinimized())
      ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CListView::Reset(void)
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
void CListView::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   for(int r=0; r<m_visible_items_total; r++)
      m_items[r].Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CListView::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_scrollv.SetZorders();
   for(int i=0; i<m_visible_items_total; i++)
      m_items[i].Z_Order(m_item_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CListView::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_scrollv.ResetZorders();
   for(int i=0; i<m_visible_items_total; i++)
      m_items[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ ������                               |
//+------------------------------------------------------------------+
bool CListView::OnClickListItem(const string clicked_object)
  {
//--- �����, ���� ����� ������������� � �������������� �� ���������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- ������, ���� ������ ��������� � �������� ������
   if(m_scrollv.ScrollState())
      return(false);
//--- ������, ���� ������� ���� �� �� ������ ����
   if(::StringFind(clicked_object,CElement::ProgramName()+"_listview_edit_",0)<0)
      return(false);
//--- ������� ������������� � ������ �� ����� �������
   int id=IdFromObjectName(clicked_object);
//--- �����, ���� ������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ������� ������� ������� �������� ������ ���������
   int v=m_scrollv.CurrentPos();
//--- �������� �� ������� ����� ������
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- ���� ������ ���� ����� � ������
      if(m_items[i].Name()==clicked_object)
        {
         m_selected_item_index =v;
         m_selected_item_text  =m_value_items[v];
        }
      //--- ���� ������ ��������� ������
      if(v>=0 && v<m_items_total)
         //--- �������� �������
         v++;
     }
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_LIST_ITEM,CElement::Id(),0,m_selected_item_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CListView::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������                                      |
//+------------------------------------------------------------------+
void CListView::FastSwitching(void)
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
      //--- ������� ������
      ShiftList();
     }
  }
//+------------------------------------------------------------------+
