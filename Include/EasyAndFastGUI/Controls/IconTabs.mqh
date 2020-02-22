//+------------------------------------------------------------------+
//|                                                     IconTabs.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������� � ����������                          |
//+------------------------------------------------------------------+
class CIconTabs : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ��������
   CRectLabel        m_main_area;
   CRectLabel        m_tabs_area;
   CEdit             m_tabs[];
   CBmpLabel         m_icons[];
   CLabel            m_labels[];
   //--- ��������� ������� � �������� ��������� ����������� �� ������ ��������
   struct ITElements
     {
      CElement         *elements[];
      string            m_text;
      int               m_width;
      string            m_icon_file_on;
      string            m_icon_file_off;
     };
   ITElements        m_tab[];
   //--- ���������� �������
   int               m_tabs_total;
   //--- ���� ���� ����� �������
   int               m_area_color;
   //--- ���������������� �������
   ENUM_TABS_POSITION m_position_mode;
   //--- ������ ���������� �������
   int               m_selected_tab;
   //--- ������ ������� ��� Y
   int               m_tab_y_size;
   //--- ����� ������� � ������ ����������
   color             m_tab_color;
   color             m_tab_color_hover;
   color             m_tab_color_selected;
   color             m_tab_color_array[];
   //--- ���� ������ ������� � ������ ���������
   color             m_tab_text_color;
   color             m_tab_text_color_selected;
   //--- ���� ����� �������
   color             m_tab_border_color;
   //--- ������� ������
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- ������� ��������� �����
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   int               m_tab_zorder;
   //---
public:
                     CIconTabs(void);
                    ~CIconTabs(void);
   //--- ������ ��� �������� �������
   bool              CreateTabs(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateMainArea(void);
   bool              CreateTabsArea(void);
   bool              CreateButton(const int index);
   bool              CreateIcon(const int index);
   bool              CreateLabel(const int index);
   //---
public:
   //--- (1) ��������� ��������� �����, 
   //    (2) �������������/�������� ������������ ������� (������/�����/�����/������), (3) ������������� ������ ������� �� ��� Y
   void              WindowPointer(CWindow &object)                  { m_wnd=::GetPointer(object);    }
   void              PositionMode(const ENUM_TABS_POSITION mode)     { m_position_mode=mode;          }
   ENUM_TABS_POSITION PositionMode(void)                       const { return(m_position_mode);       }
   void              TabYSize(const int y_size)                      { m_tab_y_size=y_size;           }
   //--- ���� (1) ������ ����, (2) ����� ������� � ������ ���������, (3) ���� ����� �������
   void              AreaColor(const color clr)                      { m_area_color=clr;              }
   void              TabBackColor(const color clr)                   { m_tab_color=clr;               }
   void              TabBackColorHover(const color clr)              { m_tab_color_hover=clr;         }
   void              TabBackColorSelected(const color clr)           { m_tab_color_selected=clr;      }
   void              TabBorderColor(const color clr)                 { m_tab_border_color=clr;        }
   //--- ���� ������ ������� � ������ ���������
   void              TabTextColor(const color clr)                   { m_tab_text_color=clr;          }
   void              TabTextColorSelected(const color clr)           { m_tab_text_color_selected=clr; }
   //--- ������� ������
   void              IconXGap(const int x_gap)                       { m_icon_x_gap=x_gap;            }
   void              IconYGap(const int y_gap)                       { m_icon_y_gap=y_gap;            }
   //--- ������� ��������� �����
   void              LabelXGap(const int x_gap)                      { m_label_x_gap=x_gap;           }
   void              LabelYGap(const int y_gap)                      { m_label_y_gap=y_gap;           }
   //--- (1) ��������� � (2) ���������� ������ ���������� �������
   void              SelectedTab(const int index)                    { m_selected_tab=index;          }
   int               SelectedTab(void)                         const { return(m_selected_tab);        }

   //--- ��������� ������� � ������ �������
   void              AddToElementsArray(const int tab_index,CElement &object);
   //--- ��������� ������� � ���������� ����������
   void              AddTab(const string tab_text="",const int tab_width=50,
                            const string icon_file_on="",const string icon_file_off="");
   //--- ��������� �����
   void              ChangeObjectsColor(void);
   //--- �������� �������� ������ ���������� �������
   void              ShowTabElements(void);
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
   //--- ��������� ������� �� �������
   bool              OnClickTab(const string pressed_object);
   //--- ��������� �������������� �� ����� �������
   int               IdFromObjectName(const string object_name);
   //--- ������ ���� �������
   int               SumWidthTabs(void);
   //--- �������� ������� ���������� �������
   void              CheckTabIndex();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CIconTabs::CIconTabs(void) : m_tab_y_size(22),
                             m_position_mode(TABS_TOP),
                             m_selected_tab(WRONG_VALUE),
                             m_area_color(C'15,15,15'),
                             m_tab_color(C'80,120,180'),
                             m_tab_color_hover(C'120,160,220'),
                             m_tab_color_selected(C'225,225,225'),
                             m_tab_text_color(clrGray),
                             m_tab_text_color_selected(clrBlack),
                             m_tab_border_color(clrWhite),
                             m_icon_x_gap(4),
                             m_icon_y_gap(3),
                             m_label_x_gap(25),
                             m_label_y_gap(5)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder     =0;
   m_tab_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIconTabs::~CIconTabs(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CIconTabs::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      for(int i=0; i<m_tabs_total; i++)
         m_tabs[i].MouseFocus(x>m_tabs[i].X() && x<m_tabs[i].X2() && y>m_tabs[i].Y() && y<m_tabs[i].Y2());
      //---
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ������� �� �������
      if(OnClickTab(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CIconTabs::OnEventTimer(void)
  {
//--- ���� ������� �������� ����������
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- ���� ����� �� �������������
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� "�������"                                        |
//+------------------------------------------------------------------+
bool CIconTabs::CreateTabs(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ������� ��� ����� �������� "
              "������������ ������ � ������� ������ WindowPointer(CWindow &object).");
      return(false);
     }
//--- ���� ��� �� ����� ������� � ������, �������� �� ����
   if(m_tabs_total<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� �������! �������������� ������� CIconTabs::AddTab()");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- �������� ��������
   if(!CreateMainArea())
      return(false);
   if(!CreateTabsArea())
      return(false);
//--- �������� ������� ���������� �������
   CheckTabIndex();
//--- ��������� �������
   for(int i=0; i<m_tabs_total; i++)
     {
      CreateButton(i);
      CreateIcon(i);
      CreateLabel(i);
      //---
      m_tabs[i].MouseFocus(false);
     }
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ����� �������                                        |
//+------------------------------------------------------------------+
bool CIconTabs::CreateMainArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icontabs_main_area_"+(string)CElement::Id();
//--- ����������
   int x=0;
   int y=0;
//--- �������
   int x_size=0;
   int y_size=0;
//--- ������ ��������� � �������� ������������ ���������������� �������
   switch(m_position_mode)
     {
      case TABS_TOP :
         x      =CElement::X();
         y      =CElement::Y()+m_tab_y_size-1;
         x_size =m_x_size;
         y_size =m_y_size-m_tab_y_size;
         break;
      case TABS_BOTTOM :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =m_x_size;
         y_size =m_y_size-m_tab_y_size;
         break;
      case TABS_RIGHT :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =m_x_size-SumWidthTabs()+1;
         y_size =m_y_size;
         break;
      case TABS_LEFT :
         x      =CElement::X()+SumWidthTabs()-1;
         y      =CElement::Y();
         x_size =m_x_size-SumWidthTabs()+1;
         y_size =m_y_size;
         break;
     }
//--- �������� �������
   if(!m_main_area.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- ��������� �������
   m_main_area.BackColor(m_area_color);
   m_main_area.Color(m_tab_border_color);
   m_main_area.BorderType(BORDER_FLAT);
   m_main_area.Corner(m_corner);
   m_main_area.Selectable(false);
   m_main_area.Z_Order(m_zorder);
   m_main_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_main_area.XGap(x-m_wnd.X());
   m_main_area.YGap(y-m_wnd.Y());
//--- �������� �������
   m_main_area.XSize(x_size);
   m_main_area.YSize(y_size);
//--- �������� ����������
   m_main_area.X(x);
   m_main_area.Y(y);
//--- �������� ��������� �������
   CElement::AddToArray(m_main_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ��� �������                                          |
//+------------------------------------------------------------------+
bool CIconTabs::CreateTabsArea(void)
  {
//--- ����������
   int x=CElement::X();
   int y=CElement::Y();
//--- �������
   int x_size=SumWidthTabs();
   int y_size=0;
//--- ������ �������� ������������ ���������������� �������
   if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
     {
      y_size=m_tab_y_size;
     }
   else
     {
      y_size=m_tab_y_size*m_tabs_total-(m_tabs_total-1);
     }
//--- ��������������� ���������� ��� ���������������� ������� ����� � ������
   if(m_position_mode==TABS_BOTTOM)
     {
      y=CElement::Y2()-m_tab_y_size-1;
     }
   else if(m_position_mode==TABS_RIGHT)
     {
      x=CElement::X2()-x_size;
     }
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icontabs_area_"+(string)CElement::Id();
//--- �������� �������
   if(!m_tabs_area.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- ��������� �������
   m_tabs_area.BackColor(m_tab_border_color);
   m_tabs_area.Color(m_tab_border_color);
   m_tabs_area.BorderType(BORDER_FLAT);
   m_tabs_area.Corner(m_corner);
   m_tabs_area.Selectable(false);
   m_tabs_area.Z_Order(m_zorder);
   m_tabs_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_tabs_area.XGap(x-m_wnd.X());
   m_tabs_area.YGap(y-m_wnd.Y());
//--- �������� �������
   m_tabs_area.XSize(x_size);
   m_tabs_area.YSize(y_size);
//--- �������� ����������
   m_tabs_area.X(x);
   m_tabs_area.Y(y);
//--- �������� ��������� �������
   CElement::AddToArray(m_tabs_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������                                                  |
//+------------------------------------------------------------------+
bool CIconTabs::CreateButton(const int index)
  {
//--- ����������
   int x =CElement::X();
   int y =CElement::Y();
//--- ������ ��������� ������������ ���������������� �������
   if(m_position_mode==TABS_BOTTOM)
      y=CElement::Y2()-m_tab_y_size-1;
   else if(m_position_mode==TABS_RIGHT)
      x=CElement::X2()-SumWidthTabs();
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icontabs_edit_"+(string)index+"__"+(string)CElement::Id();
//--- ������ ��������� ������������ ���������������� ������� ��� ������ ������� ��������
   if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
      x=(index>0) ? m_tabs[index-1].X()+m_tab[index-1].m_width-1 : CElement::X();
   else
      y=(index>0) ? m_tabs[index-1].Y()+m_tab_y_size-1 : CElement::Y();
//--- �������� �������
   if(!m_tabs[index].Create(m_chart_id,name,m_subwin,x,y,m_tab[index].m_width,m_tab_y_size))
      return(false);
//--- ��������� �������
   m_tabs[index].Font(FONT);
   m_tabs[index].FontSize(FONT_SIZE);
   m_tabs[index].Color(m_tab_text_color);
   m_tabs[index].Description("");
   m_tabs[index].BorderColor(m_tab_border_color);
   m_tabs[index].BackColor((SelectedTab()==index) ? m_tab_color_selected : m_tab_color);
   m_tabs[index].Corner(m_corner);
   m_tabs[index].Anchor(m_anchor);
   m_tabs[index].Selectable(false);
   m_tabs[index].TextAlign(ALIGN_CENTER);
   m_tabs[index].Z_Order(m_tab_zorder);
   m_tabs[index].ReadOnly(true);
   m_tabs[index].Tooltip("\n");
//--- ������� �� ������� ����� ������
   m_tabs[index].XGap(x-m_wnd.X());
   m_tabs[index].YGap(y-m_wnd.Y());
//--- ����������
   m_tabs[index].X(x);
   m_tabs[index].Y(y);
//--- �������
   m_tabs[index].XSize(m_tab[index].m_width);
   m_tabs[index].YSize(m_tab_y_size);
//--- ������������� ������� ���������
   CElement::InitColorArray(m_tab_color,m_tab_color_hover,m_tab_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_tabs[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� �����                                          |
//+------------------------------------------------------------------+
bool CIconTabs::CreateIcon(const int index)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icontabs_icon_"+(string)index+"__"+(string)CElement::Id();
//--- ����������
   int x=m_tabs[index].X()+m_icon_x_gap;
   int y=m_tabs[index].Y()+m_icon_y_gap;
//--- ��������� ��������� �����
   if(!m_icons[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_icons[index].BmpFileOn((SelectedTab()==index) ? "::"+m_tab[index].m_icon_file_on : "::"+m_tab[index].m_icon_file_off);
   m_icons[index].BmpFileOff((SelectedTab()==index) ? "::"+m_tab[index].m_icon_file_on : "::"+m_tab[index].m_icon_file_off);
   m_icons[index].State(true);
   m_icons[index].Corner(m_corner);
   m_icons[index].GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icons[index].Selectable(false);
   m_icons[index].Z_Order(m_zorder);
   m_icons[index].Tooltip("\n");
//--- ������� �� ������� �����
   m_icons[index].XGap(x-m_wnd.X());
   m_icons[index].YGap(y-m_wnd.Y());
//--- ����������
   m_icons[index].X(x);
   m_icons[index].Y(y);
//--- �������� ��������� �������
   CElement::AddToArray(m_icons[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� �����                                          |
//+------------------------------------------------------------------+
bool CIconTabs::CreateLabel(const int index)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icontabs_lable_"+(string)index+"__"+(string)CElement::Id();
//--- ����������
   int x=m_tabs[index].X()+m_label_x_gap;
   int y=m_tabs[index].Y()+m_label_y_gap;
//--- ��������� ��������� �����
   if(!m_labels[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_labels[index].Description(m_tab[index].m_text);
   m_labels[index].Font(FONT);
   m_labels[index].FontSize(FONT_SIZE);
   m_labels[index].Color((SelectedTab()==index) ? m_tab_text_color_selected : m_tab_text_color);
   m_labels[index].Corner(m_corner);
   m_labels[index].Anchor(m_anchor);
   m_labels[index].Selectable(false);
   m_labels[index].Z_Order(m_zorder);
   m_labels[index].Tooltip("\n");
//--- ������� �� ������� �����
   m_labels[index].XGap(x-m_wnd.X());
   m_labels[index].YGap(y-m_wnd.Y());
//--- ����������
   m_labels[index].X(x);
   m_labels[index].Y(y);
//--- �������� ��������� �������
   CElement::AddToArray(m_labels[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������ � ������ ����� ��������                         |
//+------------------------------------------------------------------+
void CIconTabs::AddToElementsArray(const int tab_index,CElement &object)
  {
//--- �������� �� ����� �� ���������
   int array_size=::ArraySize(m_tab);
   if(array_size<1 || tab_index<0 || tab_index>=array_size)
      return;
//--- ������� ��������� ����������� �������� � ������ ��������� �������
   int size=::ArraySize(m_tab[tab_index].elements);
   ::ArrayResize(m_tab[tab_index].elements,size+1);
   m_tab[tab_index].elements[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| ��������� �������                                                |
//+------------------------------------------------------------------+
void CIconTabs::AddTab(const string tab_text,const int tab_width,const string icon_file_on="",const string icon_file_off="")
  {
//--- ���������� ������ �������� �������
   int array_size=::ArraySize(m_tabs);
   ::ArrayResize(m_tab,array_size+1);
   ::ArrayResize(m_tabs,array_size+1);
   ::ArrayResize(m_icons,array_size+1);
   ::ArrayResize(m_labels,array_size+1);
//--- ��������� ���������� ��������
   m_tab[array_size].m_text          =tab_text;
   m_tab[array_size].m_width         =tab_width;
   m_tab[array_size].m_icon_file_on  =icon_file_on;
   m_tab[array_size].m_icon_file_off =icon_file_off;
//--- �������� ���������� �������
   m_tabs_total=array_size+1;
  }
//+------------------------------------------------------------------+
//| ���������� �������� ������ ���������� �������                    |
//+------------------------------------------------------------------+
void CIconTabs::ShowTabElements(void)
  {
//--- �����, ���� ������� ������
   if(!CElement::IsVisible())
      return;
//--- �������� ������� ���������� �������
   CheckTabIndex();
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- ������� ���������� ��������� ������������� � �������
      int tab_elements_total=::ArraySize(m_tab[i].elements);
      //--- ���� �������� ��� �������
      if(i==m_selected_tab)
        {
         //--- �������� �������� �������
         for(int j=0; j<tab_elements_total; j++)
            m_tab[i].elements[j].Show();
        }
      //--- ������ �������� ���������� �������
      else
        {
         for(int j=0; j<tab_elements_total; j++)
            m_tab[i].elements[j].Hide();
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������ ������ ��� ��������� �������              |
//+------------------------------------------------------------------+
void CIconTabs::ChangeObjectsColor(void)
  {
   for(int i=0; i<m_tabs_total; i++)
      CElement::ChangeObjectColor(m_tabs[i].Name(),m_tabs[i].MouseFocus(),
                                  OBJPROP_BGCOLOR,m_tab_color,m_tab_color_hover,m_tab_color_array);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CIconTabs::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� �������� � ����� ��������
   CElement::X(x+CElement::XGap());
   CElement::Y(y+CElement::YGap());
//--- ���������� ��������� � ����� ��������
   m_main_area.X(x+m_main_area.XGap());
   m_main_area.Y(y+m_main_area.YGap());
   m_tabs_area.X(x+m_tabs_area.XGap());
   m_tabs_area.Y(y+m_tabs_area.YGap());
//--- ���������� ��������� ����������� ��������
   m_main_area.X_Distance(m_main_area.X());
   m_main_area.Y_Distance(m_main_area.Y());
   m_tabs_area.X_Distance(m_tabs_area.X());
   m_tabs_area.Y_Distance(m_tabs_area.Y());
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- ���������� ��������� � ����� ��������
      m_tabs[i].X(x+m_tabs[i].XGap());
      m_tabs[i].Y(y+m_tabs[i].YGap());
      m_icons[i].X(x+m_icons[i].XGap());
      m_icons[i].Y(y+m_icons[i].YGap());
      m_labels[i].X(x+m_labels[i].XGap());
      m_labels[i].Y(y+m_labels[i].YGap());
      //--- ���������� ��������� ����������� ��������
      m_tabs[i].X_Distance(m_tabs[i].X());
      m_tabs[i].Y_Distance(m_tabs[i].Y());
      m_icons[i].X_Distance(m_icons[i].X());
      m_icons[i].Y_Distance(m_icons[i].Y());
      m_labels[i].X_Distance(m_labels[i].X());
      m_labels[i].Y_Distance(m_labels[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CIconTabs::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CIconTabs::Hide(void)
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
void CIconTabs::Reset(void)
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
void CIconTabs::Delete(void)
  {
//--- �������� ����������� �������� ��������
   m_main_area.Delete();
   m_tabs_area.Delete();
   for(int i=0; i<m_tabs_total; i++)
     {
      m_tabs[i].Delete();
      m_icons[i].Delete();
      m_labels[i].Delete();
     }
//--- ������������ �������� ��������
   for(int i=0; i<m_tabs_total; i++)
      ::ArrayFree(m_tab[i].elements);
//--- 
   ::ArrayFree(m_tab);
   ::ArrayFree(m_tabs);
   ::ArrayFree(m_icons);
   ::ArrayFree(m_labels);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   m_tabs_total=0;
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CIconTabs::SetZorders(void)
  {
   m_main_area.Z_Order(m_zorder);
   m_tabs_area.Z_Order(m_zorder);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(m_tab_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CIconTabs::ResetZorders(void)
  {
   m_main_area.Z_Order(0);
   m_tabs_area.Z_Order(0);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ������� �� ������� � ������                                      |
//+------------------------------------------------------------------+
bool CIconTabs::OnClickTab(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ������ �������
   if(::StringFind(clicked_object,CElement::ProgramName()+"_icontabs_edit_",0)<0)
      return(false);
//--- ������� ������������� �� ����� �������
   int id=IdFromObjectName(clicked_object);
//--- �����, ���� ������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- ���� ������� ��� �������
      if(m_tabs[i].Name()==clicked_object)
        {
         //--- ��������� ������ ���������� �������
         SelectedTab(i);
         //--- ���������� �����
         m_tabs[i].BackColor(m_tab_color_selected);
         m_labels[i].Color(m_tab_text_color_selected);
         m_icons[i].BmpFileOn("::"+m_tab[i].m_icon_file_on);
         m_icons[i].BmpFileOff("::"+m_tab[i].m_icon_file_on);
        }
      else
        {
         //--- ���������� ����� ��� ���������� �������
         m_tabs[i].BackColor(m_tab_color);
         m_labels[i].Color(m_tab_text_color);
         m_icons[i].BmpFileOn("::"+m_tab[i].m_icon_file_off);
         m_icons[i].BmpFileOff("::"+m_tab[i].m_icon_file_off);
        }
     }
//--- �������� �������� ������ ���������� �������
   ShowTabElements();
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CIconTabs::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
//| ����� ������ ���� �������                                        |
//+------------------------------------------------------------------+
int CIconTabs::SumWidthTabs(void)
  {
   int width=0;
//--- ���� ���������������� ������� ������ ��� �����, ������� ������ ������ �������
   if(m_position_mode==TABS_LEFT || m_position_mode==TABS_RIGHT)
      return(m_tab[0].m_width);
//--- ��������� ������ ���� �������
   for(int i=0; i<m_tabs_total; i++)
      width=width+m_tab[i].m_width;
//--- � ������ ��������� �� ���� �������
   width=width-(m_tabs_total-1);
   return(width);
  }
//+------------------------------------------------------------------+
//| �������� ������� ���������� �������                              |
//+------------------------------------------------------------------+
void CIconTabs::CheckTabIndex(void)
  {
//--- �������� �� ����� �� ���������
   int array_size=::ArraySize(m_tab);
   if(m_selected_tab<0)
      m_selected_tab=0;
   if(m_selected_tab>=array_size)
      m_selected_tab=array_size-1;
  }
//+------------------------------------------------------------------+
