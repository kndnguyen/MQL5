//+------------------------------------------------------------------+
//|                                                         Tabs.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� �������                                       |
//+------------------------------------------------------------------+
class CTabs : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ��������
   CRectLabel        m_main_area;
   CRectLabel        m_tabs_area;
   CEdit             m_tabs[];
   //--- ��������� ������� � �������� ��������� ����������� �� ������ ��������
   struct TElements
     {
      CElement         *elements[];
      string            text;
      int               width;
     };
   TElements         m_tab[];
   //--- ���������� �������
   int               m_tabs_total;
   //--- ���������������� �������
   ENUM_TABS_POSITION m_position_mode;
   //--- ���� ���� ����� �������
   int               m_area_color;
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
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   int               m_tab_zorder;
   //--- ������ ���������� �������
   int               m_selected_tab;
   //---
public:
                     CTabs(void);
                    ~CTabs(void);
   //--- ������ ��� �������� �������
   bool              CreateTabs(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateMainArea(void);
   bool              CreateTabsArea(void);
   bool              CreateButtons(void);
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
   //--- (1) ��������� � (2) ���������� ������ ���������� �������
   void              SelectedTab(const int index)                    { m_selected_tab=index;          }
   int               SelectedTab(void)                         const { return(m_selected_tab);        }

   //--- ��������� �������
   void              AddTab(const string tab_text="",const int tab_width=50);
   //--- ��������� ������� � ������ �������
   void              AddToElementsArray(const int tab_index,CElement &object);
   //--- �������� �������� ������ ���������� �������
   void              ShowTabElements(void);
   //--- ��������� �����
   void              ChangeObjectsColor(void);
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
CTabs::CTabs(void) : m_tab_y_size(20),
                     m_position_mode(TABS_TOP),
                     m_selected_tab(WRONG_VALUE),
                     m_area_color(C'15,15,15'),
                     m_tab_color(C'80,120,180'),
                     m_tab_color_hover(C'120,160,220'),
                     m_tab_color_selected(C'225,225,225'),
                     m_tab_text_color(clrGray),
                     m_tab_text_color_selected(clrBlack),
                     m_tab_border_color(clrWhite)
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
CTabs::~CTabs(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CTabs::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
void CTabs::OnEventTimer(void)
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
bool CTabs::CreateTabs(const long chart_id,const int subwin,const int x,const int y)
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
              "����� � ������ ���� ���� �� ���� �������! �������������� ������� CTabs::AddTab()");
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
   if(!CreateButtons())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ����� �������                                        |
//+------------------------------------------------------------------+
bool CTabs::CreateMainArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_tabs_main_area_"+(string)CElement::Id();
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
         x_size =CElement::XSize();
         y_size =CElement::YSize()-m_tab_y_size;
         break;
      case TABS_BOTTOM :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =CElement::XSize();
         y_size =CElement::YSize()-m_tab_y_size;
         break;
      case TABS_RIGHT :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =CElement::XSize()-SumWidthTabs()+1;
         y_size =CElement::YSize();
         break;
      case TABS_LEFT :
         x      =CElement::X()+SumWidthTabs()-1;
         y      =CElement::Y();
         x_size =CElement::XSize()-SumWidthTabs()+1;
         y_size =CElement::YSize();
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
bool CTabs::CreateTabsArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_tabs_area_"+(string)CElement::Id();
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
bool CTabs::CreateButtons(void)
  {
//--- ����������
   int x =CElement::X();
   int y =CElement::Y();
//--- ������ ��������� ������������ ���������������� �������
   if(m_position_mode==TABS_BOTTOM)
      y=CElement::Y2()-m_tab_y_size-1;
   else if(m_position_mode==TABS_RIGHT)
      x=CElement::X2()-SumWidthTabs();
//--- �������� ������� ���������� �������
   CheckTabIndex();
//--- �������� �������
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- ������������ ����� �������
      string name=CElement::ProgramName()+"_tabs_edit_"+(string)i+"__"+(string)CElement::Id();
      //--- ������ ��������� ������������ ���������������� ������� ��� ������ ������� ��������
      if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
         x=(i>0) ? x+m_tab[i-1].width-1 : CElement::X();
      else
         y=(i>0) ? y+m_tab_y_size-1 : CElement::Y();
      //--- �������� �������
      if(!m_tabs[i].Create(m_chart_id,name,m_subwin,x,y,m_tab[i].width,m_tab_y_size))
         return(false);
      //--- ��������� �������
      m_tabs[i].Font(FONT);
      m_tabs[i].FontSize(FONT_SIZE);
      m_tabs[i].Description(m_tab[i].text);
      m_tabs[i].BorderColor(m_tab_border_color);
      m_tabs[i].BackColor((SelectedTab()==i) ? m_tab_color_selected : m_tab_color);
      m_tabs[i].Color((SelectedTab()==i) ? m_tab_text_color_selected : m_tab_text_color);
      m_tabs[i].Corner(m_corner);
      m_tabs[i].Anchor(m_anchor);
      m_tabs[i].Selectable(false);
      m_tabs[i].TextAlign(ALIGN_CENTER);
      m_tabs[i].Z_Order(m_tab_zorder);
      m_tabs[i].ReadOnly(true);
      m_tabs[i].Tooltip("\n");
      //--- ������� �� ������� ����� ������
      m_tabs[i].XGap(x-m_wnd.X());
      m_tabs[i].YGap(y-m_wnd.Y());
      //--- ����������
      m_tabs[i].X(x);
      m_tabs[i].Y(y);
      //--- �������
      m_tabs[i].XSize(m_tab[i].width);
      m_tabs[i].YSize(m_tab_y_size);
      //--- ������������� ������� ���������
      CElement::InitColorArray(m_tab_color,m_tab_color_hover,m_tab_color_array);
      //--- �������� ��������� �������
      CElement::AddToArray(m_tabs[i]);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� �������                                                |
//+------------------------------------------------------------------+
void CTabs::AddTab(const string tab_text,const int tab_width)
  {
//--- ���������� ������ �������� �������
   int array_size=::ArraySize(m_tabs);
   ::ArrayResize(m_tabs,array_size+1);
   ::ArrayResize(m_tab,array_size+1);
//--- ��������� ���������� ��������
   m_tab[array_size].text  =tab_text;
   m_tab[array_size].width =tab_width;
//--- �������� ���������� �������
   m_tabs_total=array_size+1;
  }
//+------------------------------------------------------------------+
//| ��������� ������� � ������ ��������� �������                     |
//+------------------------------------------------------------------+
void CTabs::AddToElementsArray(const int tab_index,CElement &object)
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
//| ���������� �������� ������ ���������� �������                    |
//+------------------------------------------------------------------+
void CTabs::ShowTabElements(void)
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
void CTabs::ChangeObjectsColor(void)
  {
   for(int i=0; i<m_tabs_total; i++)
      CElement::ChangeObjectColor(m_tabs[i].Name(),m_tabs[i].MouseFocus(),
                                  OBJPROP_BGCOLOR,m_tab_color,m_tab_color_hover,m_tab_color_array);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CTabs::Moving(const int x,const int y)
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
      //--- ���������� ��������� ����������� ��������
      m_tabs[i].X_Distance(m_tabs[i].X());
      m_tabs[i].Y_Distance(m_tabs[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CTabs::Show(void)
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
void CTabs::Hide(void)
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
void CTabs::Reset(void)
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
void CTabs::Delete(void)
  {
//--- �������� ����������� �������� ��������
   m_main_area.Delete();
   m_tabs_area.Delete();
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Delete();
//--- ������������ �������� ��������
   for(int i=0; i<m_tabs_total; i++)
      ::ArrayFree(m_tab[i].elements);
//--- 
   ::ArrayFree(m_tab);
   ::ArrayFree(m_tabs);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   m_tabs_total=0;
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CTabs::SetZorders(void)
  {
   m_main_area.Z_Order(m_zorder);
   m_tabs_area.Z_Order(m_zorder);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(m_tab_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CTabs::ResetZorders(void)
  {
   m_main_area.Z_Order(0);
   m_tabs_area.Z_Order(0);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ������� �� ������� � ������                                      |
//+------------------------------------------------------------------+
bool CTabs::OnClickTab(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ������ �������
   if(::StringFind(clicked_object,CElement::ProgramName()+"_tabs_edit_",0)<0)
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
         m_tabs[i].Color(m_tab_text_color_selected);
         m_tabs[i].BackColor(m_tab_color_selected);
        }
      else
        {
         //--- ���������� ����� ��� ���������� �������
         m_tabs[i].Color(m_tab_text_color);
         m_tabs[i].BackColor(m_tab_color);
        }
     }
//--- �������� �������� ������ ���������� �������
   ShowTabElements();
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CTabs::IdFromObjectName(const string object_name)
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
int CTabs::SumWidthTabs(void)
  {
   int width=0;
//--- ���� ���������������� ������� ������ ��� �����, ������� ������ ������ �������
   if(m_position_mode==TABS_LEFT || m_position_mode==TABS_RIGHT)
      return(m_tab[0].width);
//--- ��������� ������ ���� �������
   for(int i=0; i<m_tabs_total; i++)
      width=width+m_tab[i].width;
//--- � ������ ��������� �� ���� �������
   width=width-(m_tabs_total-1);
   return(width);
  }
//+------------------------------------------------------------------+
//| �������� ������� ���������� �������                              |
//+------------------------------------------------------------------+
void CTabs::CheckTabIndex(void)
  {
//--- �������� �� ����� �� ���������
   int array_size=::ArraySize(m_tab);
   if(m_selected_tab<0)
      m_selected_tab=0;
   if(m_selected_tab>=array_size)
      m_selected_tab=array_size-1;
  }
//+------------------------------------------------------------------+
