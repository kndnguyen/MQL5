//+------------------------------------------------------------------+
//|                                                CheckComboBox.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "ListView.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� �����-����� � ���-������                      |
//+------------------------------------------------------------------+
class CCheckComboBox : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� �����-�����
   CRectLabel        m_area;
   CBmpLabel         m_check;
   CLabel            m_label;
   CEdit             m_button;
   CBmpLabel         m_drop_arrow;
   CListView         m_listview;
   //--- ���� ������ ����
   color             m_area_color;
   //--- ������ �������� � �������� � ��������������� ���������
   string            m_check_bmp_file_on;
   string            m_check_bmp_file_off;
   string            m_check_bmp_file_on_locked;
   string            m_check_bmp_file_off_locked;
   //--- ��������� ������ ���-�����
   bool              m_check_button_state;
   //--- ����� ���-�����
   string            m_label_text;
   //--- ������� ��������� �����
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ����� ��������� ����� � ������ ����������
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- (1) ����� ������ � (2) � �������
   string            m_button_text;
   int               m_button_x_size;
   int               m_button_y_size;
   //--- ����� ������ � ������ ����������
   color             m_button_color;
   color             m_button_color_hover;
   color             m_button_color_locked;
   color             m_button_color_pressed;
   color             m_button_color_array[];
   //--- ����� ����� ������ � ������ ���������
   color             m_button_border_color;
   color             m_button_border_color_locked;
   //--- ���� ������ ������ � ������ ���������
   color             m_button_text_color;
   color             m_button_text_color_locked;
   //--- ������� ������
   int               m_drop_arrow_x_gap;
   int               m_drop_arrow_y_gap;
   //--- ������ ������ � ���������� ���� � �������� � ��������������� ���������
   string            m_drop_arrow_file_on;
   string            m_drop_arrow_file_locked;
   //--- ���������� �� ������� ����� ������� ����
   int               m_zorder;
   int               m_area_zorder;
   int               m_combobox_zorder;
   //--- ��������� �������� (��������/������������)
   bool              m_checkcombobox_state;
   //---
public:
                     CCheckComboBox(void);
                    ~CCheckComboBox(void);
   //--- ������ ��� �������� �����-�����
   bool              CreateCheckComboBox(const long chart_id,const int subwin,const string text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCheck(void);
   bool              CreateLabel(void);
   bool              CreateButton(void);
   bool              CreateDropArrow(void);
   bool              CreateList(void);
   //---
public:
   //--- (1) ��������� ��������� �����, ���������� ��������� �� (2) ������ � (3) ������ ���������
   void              WindowPointer(CWindow &object)                           { m_wnd=::GetPointer(object);                      }
   CListView        *GetListViewPointer(void)                                 { return(::GetPointer(m_listview));                }
   CScrollV         *GetScrollVPointer(void)                                  { return(m_listview.GetScrollVPointer());          }
   //--- ��������� (1) ������� ������ (���������� �������) � (2) ������� ��� �����, (3) ��������� � ��������� ��������� ��������
   void              ItemsTotal(const int items_total)                        { m_listview.ListSize(items_total);                }
   void              VisibleItemsTotal(const int visible_items_total)         { m_listview.VisibleListSize(visible_items_total); }
   bool              CheckComboBoxState(void)                           const { return(m_checkcombobox_state);                   }
   void              CheckComboBoxState(const bool state);
   //--- (1) ���� ����, (2) ����������/������������� �������� ��������� �����, (3) ��������/���������� ��������� ������ ���-�����
   void              AreaColor(const color clr)                               { m_area_color=clr;                                }
   string            LabelText(void)                                    const { return(m_label.Description());                   }
   void              LabelText(const string text)                             { m_label_text=text;                               }
   bool              CheckButtonState(void)                             const { return(m_check.State());                         }
   void              CheckButtonState(const bool state)                       { m_check_button_state=state;                      }
   //--- ������� ��������� �����
   void              LabelXGap(const int x_gap)                               { m_label_x_gap=x_gap;                             }
   void              LabelYGap(const int y_gap)                               { m_label_y_gap=y_gap;                             }
   //--- ����� ��������� �����
   void              LabelColor(const color clr)                              { m_label_color=clr;                               }
   void              LabelColorOff(const color clr)                           { m_label_color_off=clr;                           }
   void              LabelColorHover(const color clr)                         { m_label_color_hover=clr;                         }
   void              LabelColorLocked(const color clr)                        { m_label_color_locked=clr;                        }
   //--- (1) ���������� ����� ������, (2) ��������� �������� ������
   string            ButtonText(void)                                   const { return(m_button_text);                           }
   void              ButtonXSize(const int x_size)                            { m_button_x_size=x_size;                          }
   void              ButtonYSize(const int y_size)                            { m_button_y_size=y_size;                          }
   //--- ����� ������
   void              ButtonBackColor(const color clr)                         { m_button_color=clr;                              }
   void              ButtonBackColorHover(const color clr)                    { m_button_color_hover=clr;                        }
   void              ButtonBackColorLocked(const color clr)                   { m_button_color_locked=clr;                       }
   void              ButtonBackColorPressed(const color clr)                  { m_button_color_pressed=clr;                      }
   //--- ����� ����� ������
   void              ButtonBorderColor(const color clr)                       { m_button_border_color=clr;                       }
   void              ButtonBorderColorLocked(const color clr)                 { m_button_border_color_locked=clr;                }
   //--- ����� ������ ������ 
   void              ButtonTextColor(const color clr)                         { m_button_text_color=clr;                         }
   void              ButtonTextColorLocked(const color clr)                   { m_button_text_color_locked=clr;                  }
   //--- ��������� ������� ��� ������ � ���������� ���� � �������� � ��������������� ����������
   void              DropArrowFileOn(const string file_path)                  { m_drop_arrow_file_on=file_path;                  }
   void              DropArrowFileLocked(const string file_path)              { m_drop_arrow_file_locked=file_path;              }
   //--- ������� ������
   void              DropArrowXGap(const int x_gap)                           { m_drop_arrow_x_gap=x_gap;                        }
   void              DropArrowYGap(const int y_gap)                           { m_drop_arrow_y_gap=y_gap;                        }

   //--- ��������� ���������� �������� � ������ �� ���������� �������
   void              ValueToList(const int item_index,const string item_text);
   //--- ��������� ������ �� ���������� �������
   void              SelectedItemByIndex(const int value);
   //--- ��������� ����� ������� ��� ��������� �������
   void              ChangeObjectsColor(void);
   //--- �������� ������� ��������� �����-����� �� ���������������
   void              ChangeComboBoxListState(void);
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
   //--- ��������� ������� �� ������ ���-�����
   bool              OnClickLabel(const string clicked_object);
   //--- ��������� ������� �� ������ �����-�����
   bool              OnClickButton(const string clicked_object);
   //--- �������� ������� ����� ������ ���� ��� ������� �����-�����
   void              CheckPressedOverButton(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCheckComboBox::CCheckComboBox(void) : m_checkcombobox_state(true),
                                       m_check_button_state(false),
                                       m_area_color(C'15,15,15'),
                                       m_check_bmp_file_on(""),
                                       m_check_bmp_file_off(""),
                                       m_check_bmp_file_on_locked(""),
                                       m_check_bmp_file_off_locked(""),
                                       m_label_text("check_combobox: "),
                                       m_label_x_gap(20),
                                       m_label_y_gap(2),
                                       m_label_color(clrWhite),
                                       m_label_color_off(clrGray),
                                       m_label_color_locked(clrGray),
                                       m_label_color_hover(C'85,170,255'),
                                       m_button_y_size(18),
                                       m_button_text(""),
                                       m_button_text_color(clrBlack),
                                       m_button_text_color_locked(clrDarkGray),
                                       m_button_color(clrGainsboro),
                                       m_button_color_hover(C'193,218,255'),
                                       m_button_color_locked(clrLightGray),
                                       m_button_color_pressed(C'153,178,215'),
                                       m_button_border_color(clrWhite),
                                       m_button_border_color_locked(clrWhite),
                                       m_drop_arrow_x_gap(16),
                                       m_drop_arrow_y_gap(1),
                                       m_drop_arrow_file_on(""),
                                       m_drop_arrow_file_locked("")
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ����� ����������� ������
   m_listview.IsDropdown(true);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder          =0;
   m_area_zorder     =1;
   m_combobox_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCheckComboBox::~CCheckComboBox(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CCheckComboBox::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- ����������
      int x=(int)lparam;
      int y=(int)dparam;
      //--- �������� ������ ��� ����������
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_button.MouseFocus(x>m_button.X() && x<m_button.X2() && 
                          y>m_button.Y() && y<m_button.Y2());
      //--- �����, ���� ������� ������������
      if(!m_checkcombobox_state)
         return;
      //--- �����, ���� ����� ������ ���� ������
      if(sparam=="0")
         return;
      //--- �������� ������� ����� ������ ���� ��� ��������� �������
      CheckPressedOverButton();
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LIST_ITEM)
     {
      //--- ���� �������������� ����� ���������
      if(lparam==CElement::Id())
        {
         //--- ��������� � ���������� ����� � ������
         m_button_text=m_listview.SelectedItemText();
         m_button.Description(m_listview.SelectedItemText());
         //--- ������� ��������� ������
         ChangeComboBoxListState();
         //--- �������� ��������� �� ����
         ::EventChartCustom(m_chart_id,ON_CLICK_COMBOBOX_ITEM,CElement::Id(),0,m_label_text);
        }
      //---
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- �����, ���� ������� ������������
      if(!m_checkcombobox_state)
         return;
      //--- ������� �� ������ ���-�����
      if(OnClickLabel(sparam))
         return;
      //--- ������� �� ������ �����-�����
      if(OnClickButton(sparam))
         return;
      //---
      return;
     }
//--- ��������� ������� ��������� ������� �������
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      //--- �����, ���� ������� ������������
      if(!m_checkcombobox_state)
         return;
      //--- ������ ������
      m_listview.Hide();
      //--- ������������ �����
      ResetColors();
      //--- �������������� �����
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CCheckComboBox::OnEventTimer(void)
  {
//--- ���� ������� ���������� � ������ �����
   if(CElement::IsDropdown() && !m_listview.IsVisible())
      ChangeObjectsColor();
   else
     {
      //--- ���� ����� � ������� �� �������������
      if(!m_wnd.IsLocked() && m_checkcombobox_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� "�����-���� � �������"                           |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateCheckComboBox(const long chart_id,const int subwin,const string text,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ���-���������� ������ ����� �������� "
              "��������� �� �����: CCheckComboBox::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_label_text =text;
   m_x          =x;
   m_y          =y;
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������
   if(!CreateArea())
      return(false);
   if(!CreateCheck())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateButton())
      return(false);
   if(!CreateDropArrow())
      return(false);
   if(!CreateList())
      return(false);
//--- ��������� � ���������� ����� � ������
   m_button_text=m_listview.SelectedItemText();
   m_button.Description(m_listview.SelectedItemText());
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� �����-�����                                      |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkcombobox_area_"+(string)CElement::Id();
//--- ��������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_button_y_size))
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
//| ������ �������                                                  |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp"
//---
bool CCheckComboBox::CreateCheck(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkbox_bmp_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+2;
   int y=CElement::Y()+2;
//--- ���� �� ������� �������� ��� ������ ���-�����, ������ ��������� �� ���������
   if(m_check_bmp_file_on=="")
      m_check_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp";
   if(m_check_bmp_file_off=="")
      m_check_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp";
//---
   if(m_check_bmp_file_on_locked=="")
      m_check_bmp_file_on_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp";
   if(m_check_bmp_file_off_locked=="")
      m_check_bmp_file_off_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp";
//--- ��������� ������
   if(!m_check.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_check.BmpFileOn("::"+m_check_bmp_file_on);
   m_check.BmpFileOff("::"+m_check_bmp_file_off);
   m_check.State(m_check_button_state);
   m_check.Corner(m_corner);
   m_check.Selectable(false);
   m_check.Z_Order(m_zorder);
   m_check.Tooltip("\n");
//--- ������� �� ������� �����
   m_check.XGap(x-m_wnd.X());
   m_check.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_check);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ����� (������� �������� ��������)              |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkcombobox_lable_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+m_label_x_gap;
   int y=CElement::Y()+m_label_y_gap;
//--- ���� ������ ������������ ���������
   color label_color=(m_check_button_state)? m_label_color : m_label_color_off;
//--- ��������� ������
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_label.Description(m_label_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.Tooltip("\n");
//--- ������� �� ������� �����
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(label_color,m_label_color_hover,m_label_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������                                                   |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateButton(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkcombobox_button_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X()+CElement::XSize()-m_button_x_size;
   int y =CElement::Y()-1;
//--- ��������� ������
   if(!m_button.Create(m_chart_id,name,m_subwin,x,y,m_button_x_size,m_button_y_size))
      return(false);
//--- ��������� ��������
   m_button.Font(FONT);
   m_button.FontSize(FONT_SIZE);
   m_button.Color(m_button_text_color);
   m_button.Description(m_button_text);
   m_button.BackColor(m_button_color);
   m_button.BorderColor(m_button_border_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_combobox_zorder);
   m_button.ReadOnly(true);
   m_button.Tooltip("\n");
//--- �������� ����������
   m_button.X(x);
   m_button.Y(y);
//--- �������� �������
   m_button.XSize(m_button_x_size);
   m_button.YSize(m_button_y_size);
//--- ������� �� ������� �����
   m_button.XGap(x-m_wnd.X());
   m_button.YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_button_color,m_button_color_hover,m_button_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� �� �����-�����                                   |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
//---
bool CCheckComboBox::CreateDropArrow(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_checkcombobox_drop_"+(string)CElement::Id();
//--- ����������
   int x =m_button.X()+m_button.XSize()-m_drop_arrow_x_gap;
   int y =m_button.Y()+m_drop_arrow_y_gap;
//--- ���� �� ������� �������� ��� �������, ������ ��������� �� ���������
   if(m_drop_arrow_file_on=="")
      m_drop_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp";
   if(m_drop_arrow_file_locked=="")
      m_drop_arrow_file_locked="Images\\EasyAndFastGUI\\Controls\\DropOff.bmp";
//--- ��������� ������
   if(!m_drop_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_drop_arrow.BmpFileOn("::"+m_drop_arrow_file_on);
   m_drop_arrow.BmpFileOff("::"+m_drop_arrow_file_locked);
   m_drop_arrow.State(true);
   m_drop_arrow.Corner(m_corner);
   m_drop_arrow.Selectable(false);
   m_drop_arrow.Z_Order(m_zorder);
   m_drop_arrow.Tooltip("\n");
//--- �������� �������
   m_drop_arrow.XSize(m_drop_arrow.X_Size());
   m_drop_arrow.YSize(m_drop_arrow.Y_Size());
//--- �������� ����������
   m_drop_arrow.X(x);
   m_drop_arrow.Y(y);
//--- ������� �� ������� �����
   m_drop_arrow.XGap(x-m_wnd.X());
   m_drop_arrow.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_drop_arrow);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������                                                   |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateList(void)
  {
//--- �������� ��������� �� ����� � ���� �������
   m_listview.WindowPointer(m_wnd);
   m_listview.ComboBoxPointer(this);
//--- ����������
   int x=CElement::X2()-m_button_x_size;
   int y=CElement::Y()+m_button_y_size;
//--- ��������� �������� ����� ���������
   m_listview.Id(CElement::Id());
//--- ��������� ������ ������
   m_listview.XSize(m_button_x_size);
//--- �������� ������� ����������
   if(!m_listview.CreateListView(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������ ������
   m_listview.Hide();
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� ������                                         |
//+------------------------------------------------------------------+
void CCheckComboBox::ValueToList(const int item_index,const string item_text)
  {
   m_listview.ValueToList(item_index,item_text);
  }
//+------------------------------------------------------------------+
//| ��������� ������ �� ���������� �������                           |
//+------------------------------------------------------------------+
void CCheckComboBox::SelectedItemByIndex(const int index)
  {
//--- ������� ����� � ������
   m_listview.SelectedItemByIndex(index);
//--- ��������� � ���������� ����� � ������
   m_button_text=m_listview.SelectedItemText();
   m_button.Description(m_listview.SelectedItemText());
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CCheckComboBox::ChangeObjectsColor(void)
  {
//--- �����, ���� ������� ������������
   if(!m_checkcombobox_state)
      return;
//---
   color label_color=(m_check_button_state) ? m_label_color : m_label_color_off;
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_button_color,m_button_color_hover,m_button_color_array);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �����-�����                                  |
//+------------------------------------------------------------------+
void CCheckComboBox::CheckComboBoxState(const bool state)
  {
//--- ��������� ��������
   m_checkcombobox_state=state;
//--- �������� ���-�����
   m_check.BmpFileOn((state)? "::"+m_check_bmp_file_on : "::"+m_check_bmp_file_on_locked);
   m_check.BmpFileOff((state)? "::"+m_check_bmp_file_off : "::"+m_check_bmp_file_off_locked);
//--- ���� ��������� �����
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- ����� ������
   m_button.Color((state)? m_button_text_color : m_button_text_color_locked);
   m_button.BackColor((state)? m_button_color : m_button_color_locked);
   m_button.BorderColor((state)? m_button_border_color : m_button_border_color_locked);
//--- �������� ������� �� ������
   m_drop_arrow.State(state);
  }
//+------------------------------------------------------------------+
//| �������� ������� ��������� �����-����� �� ���������������        |
//+------------------------------------------------------------------+
void CCheckComboBox::ChangeComboBoxListState(void)
  {
//--- �����, ���� ������� ������������
   if(!m_checkcombobox_state)
      return;
//--- ���� ������ �����
   if(m_listview.IsVisible())
     {
      //--- ������ ������
      m_listview.Hide();
      //--- ���������� �����
      m_label.Color(m_label_color_hover);
      m_button.BackColor(m_button_color_hover);
      //--- ���� ������� �� ����������
      if(!CElement::IsDropdown())
        {
         //--- �������������� �����
         m_wnd.IsLocked(false);
         m_wnd.IdActivatedElement(WRONG_VALUE);
        }
     }
   else
     {
      //--- �������� ������
      m_listview.Show();
      //--- ���������� �����
      m_label.Color(m_label_color_hover);
      m_button.BackColor(m_button_color_pressed);
      //--- ������������� �����
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
     }
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CCheckComboBox::Moving(const int x,const int y)
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
   m_check.X(x+m_check.XGap());
   m_check.Y(y+m_check.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_button.X(x+m_button.XGap());
   m_button.Y(y+m_button.YGap());
   m_drop_arrow.X(x+m_drop_arrow.XGap());
   m_drop_arrow.Y(y+m_drop_arrow.YGap());
//--- ���������� ��������� ����������� ��������  
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_check.X_Distance(m_check.X());
   m_check.Y_Distance(m_check.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_drop_arrow.X_Distance(m_drop_arrow.X());
   m_drop_arrow.Y_Distance(m_drop_arrow.Y());
  }
//+------------------------------------------------------------------+
//| ���������� �����-����                                            |
//+------------------------------------------------------------------+
void CCheckComboBox::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- �������� ������
   m_listview.Hide();
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �����-����                                              |
//+------------------------------------------------------------------+
void CCheckComboBox::Hide(void)
  {
//--- �����, ���� ������� ��� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ ������
   m_listview.Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CCheckComboBox::Reset(void)
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
void CCheckComboBox::Delete(void)
  {
//--- �������� ��������  
   m_area.Delete();
   m_check.Delete();
   m_label.Delete();
   m_button.Delete();
   m_drop_arrow.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CCheckComboBox::SetZorders(void)
  {
//--- �����, ���� ������� ������������
   if(!m_checkcombobox_state)
      return;
//--- ��������� �������� �� ���������
   m_area.Z_Order(m_area_zorder);
   m_check.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_button.Z_Order(m_combobox_zorder);
   m_drop_arrow.Z_Order(m_zorder);
   m_listview.SetZorders();
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CCheckComboBox::ResetZorders(void)
  {
//--- �����, ���� ������� ������������
   if(!m_checkcombobox_state)
      return;
//--- ��������� �����������
   m_area.Z_Order(0);
   m_check.Z_Order(0);
   m_label.Z_Order(0);
   m_button.Z_Order(0);
   m_drop_arrow.Z_Order(0);
   m_listview.ResetZorders();
  }
//+------------------------------------------------------------------+
//| ����� ����� �������� ��������                                    |
//+------------------------------------------------------------------+
void CCheckComboBox::ResetColors(void)
  {
//--- �����, ���� ������� ������������
   if(!m_checkcombobox_state)
      return;
//--- �������� ����
   m_label.Color((m_check_button_state)? m_label_color : m_label_color_off);
   m_button.BackColor(m_button_color);
//--- ������� �����
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ������� �� ��������� ��������                                    |
//+------------------------------------------------------------------+
bool CCheckComboBox::OnClickLabel(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������
   if(m_area.Name()!=clicked_object)
      return(false);
//--- �����, ���� ������� ������������
   if(!m_checkcombobox_state)
      return(false);
//--- �������� ��������� ���-������ �� ���������������
   if(!m_check.State())
     {
      m_check.State(true);
      m_check_button_state=true;
      m_label.Color(m_label_color_hover);
      CElement::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
     }
   else
     {
      m_check.State(false);
      m_check_button_state=false;
      m_label.Color(m_label_color_hover);
      CElement::InitColorArray(m_label_color_off,m_label_color_hover,m_label_color_array);
     }
//--- ���� ������ ������
   if(m_listview.IsVisible())
     {
      //--- ������ ������
      m_listview.Hide();
      //--- �������� ���� ������
      m_button.BackColor(m_button_color_hover);
      //--- �������������� �����
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);

     }
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,(long)CElement::Id(),0,m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������ �����-�����                                    |
//+------------------------------------------------------------------+
bool CCheckComboBox::OnClickButton(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������  
   if(clicked_object!=m_button.Name())
      return(false);
//--- �������� ��������� ������
   ChangeComboBoxListState();
   return(true);
  }
//+------------------------------------------------------------------+
//| �������� ������� ����� ������ ���� ��� �������                   |
//+------------------------------------------------------------------+
void CCheckComboBox::CheckPressedOverButton(void)
  {
//--- �����, ���� ����� ������������� � �������������� �� ���������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- ���� ������ ���
   if(!CElement::MouseFocus())
     {
      //--- �����, ���� ����� �� �� ������ ��� ������ ��������� ������ � ��������
      if(m_listview.MouseFocus() || m_listview.ScrollState())
         return;
      //--- ������ ������
      m_listview.Hide();
      //--- ������������ �����
      ResetColors();
      //--- ���� �������������� ��������� � ������� �� ����������
      if(m_wnd.IdActivatedElement()==CElement::Id() && !CElement::IsDropdown())
         //--- �������������� �����
         m_wnd.IsLocked(false);
     }
//--- ���� ����� ����
   else
     {
      //--- �����, ���� ������ �����
      if(m_listview.IsVisible())
         return;
      //--- ���������� ���� � ������ ������
      if(m_button.MouseFocus())
         m_button.BackColor(m_button_color_pressed);
      else
         m_button.BackColor(m_button_color_hover);
     }
  }
//+------------------------------------------------------------------+
