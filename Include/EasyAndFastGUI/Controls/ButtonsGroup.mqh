//+------------------------------------------------------------------+
//|                                                 ButtonsGroup.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������ ������� ������                         |
//+------------------------------------------------------------------+
class CButtonsGroup : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������
   CButton           m_buttons[];
   //--- ��������� ������
   struct ButtonsGradients
     {
      color             m_buttons_color_array[];
     };
   ButtonsGradients  m_buttons_total[];
   //--- �������� ������:
   //    ����� �����-������
   bool              m_radio_buttons_mode;
   //--- ������� ��� ���������� ������� ������
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   string            m_buttons_text[];
   int               m_buttons_width[];
   color             m_buttons_color[];
   color             m_buttons_color_hover[];
   color             m_buttons_color_pressed[];
   //--- ������ ������
   int               m_button_y_size;
   //--- ���� ��������������� ������
   color             m_back_color_off;
   //--- ���� ����� � �������� � ��������������� �������
   color             m_border_color;
   color             m_border_color_off;
   //--- ����� ������
   color             m_text_color;
   color             m_text_color_off;
   color             m_text_color_pressed;
   //--- (1) ����� � (2) ������ ���������� ������
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- ��������� �� ������� ����� ������� ����
   int               m_buttons_zorder;
   //--- ��������/������������
   bool              m_buttons_group_state;
   //---
public:
                     CButtonsGroup(void);
                    ~CButtonsGroup(void);
   //--- ������ ��� �������� ������
   bool              CreateButtonsGroup(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateButtons(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ������,
   //    (3) ����� ��������� ������ ������ (��������/������������)
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);      }
   int               ButtonsTotal(void)                       const { return(::ArraySize(m_buttons));  }
   bool              ButtonsGroupState(void)                  const { return(m_buttons_group_state);   }
   void              ButtonsGroupState(const bool state);
   //--- (1) ������ ������, (2) ��������� ������ �����-������
   void              ButtonYSize(const int y_size)                  { m_button_y_size=y_size;          }
   void              RadioButtonsMode(const bool flag)              { m_radio_buttons_mode=flag;       }
   //--- (1) ����� ���� ��������������� ������ � ����� ((2) ��������/(3) ������������)
   void              BackColorOff(const color clr)                  { m_back_color_off=clr;            }
   void              BorderColor(const color clr)                   { m_border_color=clr;              }
   void              BorderColorOff(const color clr)                { m_border_color_off=clr;          }
   //--- ����� ������
   void              TextColor(const color clr)                     { m_text_color=clr;                }
   void              TextColorOff(const color clr)                  { m_text_color_off=clr;            }
   void              TextColorPressed(const color clr)              { m_text_color_pressed=clr;        }
   //--- ���������� (1) ����� � (2) ������ ���������� ������
   string            SelectedButtonText(void)                 const { return(m_selected_button_text);  }
   int               SelectedButtonIndex(void)                const { return(m_selected_button_index); }
   //--- ����������� ������ �� ���������� �������
   void              SelectionButton(const int index);

   //--- ��������� ������ � ���������� ���������� �� ��������
   void              AddButton(const int x_gap,const int y_gap,const string text,const int width,
                               const color button_color,const color button_color_hover,const color button_color_pressed);
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
   //---
private:
   //--- ��������� ������� �� ������
   bool              OnClickButton(const string clicked_object);
   //--- �������� ������� ����� ������ ���� ��� �������� ������
   void              CheckPressedOverButton(void);
   //--- ��������� �������������� �� ����� ������
   int               IdFromObjectName(const string object_name);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CButtonsGroup::CButtonsGroup(void) : m_radio_buttons_mode(false),
                                     m_buttons_group_state(true),
                                     m_button_y_size(22),
                                     m_selected_button_text(""),
                                     m_selected_button_index(WRONG_VALUE),
                                     m_text_color(clrBlack),
                                     m_text_color_off(clrDarkGray),
                                     m_text_color_pressed(clrWhite),
                                     m_back_color_off(clrLightGray),
                                     m_border_color(clrWhite),
                                     m_border_color_off(clrWhite)
  {
//--- �������� ��� ������ �������� � ������� ������  
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_buttons_zorder=1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CButtonsGroup::~CButtonsGroup(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CButtonsGroup::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- �����, ���� ������ �������������
      if(!m_buttons_group_state)
         return;
      //--- ��������� �����
      int x=(int)lparam;
      int y=(int)dparam;
      int buttons_total=ButtonsTotal();
      for(int i=0; i<buttons_total; i++)
        {
         m_buttons[i].MouseFocus(x>m_buttons[i].X() && x<m_buttons[i].X2() && 
                                 y>m_buttons[i].Y() && y<m_buttons[i].Y2());
        }
      //--- �����, ���� ����� �������������
      if(m_wnd.IsLocked())
         return;
      //--- �����, ���� ������ ���� �� ������
      if(sparam!="1")
         return;
      //--- �������� ������� ����� ������ ���� ��� �������� ������
      CheckPressedOverButton();
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CButtonsGroup::OnEventTimer(void)
  {
//--- ������� ����, ���� ����� �� �������������
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| ������ ������ ������                                            |
//+------------------------------------------------------------------+
bool CButtonsGroup::CreateButtonsGroup(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ������ ������ ����� �������� "
              "��������� �� �����: CButtonsGroup::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- ������ ������
   if(!CreateButtons())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������                                                   |
//+------------------------------------------------------------------+
bool CButtonsGroup::CreateButtons(void)
  {
//--- ����������
   int l_x =m_x;
   int l_y =m_y;
//--- ������� ���������� ������
   int buttons_total=ButtonsTotal();
//--- ���� ��� �� ����� ������ � ������, �������� �� ����
   if(buttons_total<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� ������! �������������� ������� CButtonsGroup::AddButton()");
      return(false);
     }
//--- �������� ��������� ���������� ������
   for(int i=0; i<buttons_total; i++)
     {
      //--- ������������ ����� �������
      string name=CElement::ProgramName()+"_buttons_"+(string)i+"__"+(string)CElement::Id();
      //--- ������ ���������
      l_x=m_x+m_buttons_x_gap[i];
      l_y=m_y+m_buttons_y_gap[i];
      //--- ��������� ������
      if(!m_buttons[i].Create(m_chart_id,name,m_subwin,l_x,l_y,m_buttons_width[i],m_button_y_size))
         return(false);
      //--- ��������� �������
      m_buttons[i].State(false);
      m_buttons[i].Font(FONT);
      m_buttons[i].FontSize(FONT_SIZE);
      m_buttons[i].Color(m_text_color);
      m_buttons[i].Description(m_buttons_text[i]);
      m_buttons[i].BorderColor(m_border_color);
      m_buttons[i].BackColor(m_buttons_color[i]);
      m_buttons[i].Corner(m_corner);
      m_buttons[i].Anchor(m_anchor);
      m_buttons[i].Selectable(false);
      m_buttons[i].Z_Order(m_buttons_zorder);
      m_buttons[i].Tooltip("\n");
      //--- �������� ������� �� ������� ����� ������, ���������� � �������
      m_buttons[i].XGap(l_x-m_wnd.X());
      m_buttons[i].YGap(l_y-m_wnd.Y());
      //--- ����������
      m_buttons[i].X(l_x);
      m_buttons[i].Y(l_y);
      //--- �������
      m_buttons[i].XSize(m_buttons_width[i]);
      m_buttons[i].YSize(m_button_y_size);
      //--- ������������� ������� ���������
      CElement::InitColorArray(m_buttons_color[i],m_buttons_color_hover[i],m_buttons_total[i].m_buttons_color_array);
      //--- �������� ��������� �������
      CElement::AddToArray(m_buttons[i]);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������                                                 |
//+------------------------------------------------------------------+
void CButtonsGroup::AddButton(const int x_gap,const int y_gap,const string text,const int width,
                              const color button_color,const color button_color_hover,const color pressed_button_color)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_buttons);
   ::ArrayResize(m_buttons,array_size+1);
   ::ArrayResize(m_buttons_total,array_size+1);
   ::ArrayResize(m_buttons_state,array_size+1);
   ::ArrayResize(m_buttons_x_gap,array_size+1);
   ::ArrayResize(m_buttons_y_gap,array_size+1);
   ::ArrayResize(m_buttons_text,array_size+1);
   ::ArrayResize(m_buttons_width,array_size+1);
   ::ArrayResize(m_buttons_color,array_size+1);
   ::ArrayResize(m_buttons_color_hover,array_size+1);
   ::ArrayResize(m_buttons_color_pressed,array_size+1);
//--- �������� �������� ���������� ����������
   m_buttons_x_gap[array_size]         =x_gap;
   m_buttons_y_gap[array_size]         =y_gap;
   m_buttons_text[array_size]          =text;
   m_buttons_width[array_size]         =width;
   m_buttons_color[array_size]         =button_color;
   m_buttons_color_hover[array_size]   =button_color_hover;
   m_buttons_color_pressed[array_size] =pressed_button_color;
   m_buttons_state[array_size]         =false;
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CButtonsGroup::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//---
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
     {
      //--- ���������� ��������� � ����� ��������
      m_buttons[i].X(x+m_buttons[i].XGap());
      m_buttons[i].Y(y+m_buttons[i].YGap());
      //--- ���������� ��������� ����������� ��������
      m_buttons[i].X_Distance(m_buttons[i].X());
      m_buttons[i].Y_Distance(m_buttons[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CButtonsGroup::ChangeObjectsColor(void)
  {
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
     {
      CElement::ChangeObjectColor(m_buttons[i].Name(),m_buttons[i].MouseFocus(),
                                  OBJPROP_BGCOLOR,m_buttons_color[i],m_buttons_color_hover[i],m_buttons_total[i].m_buttons_color_array);
     }
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CButtonsGroup::Show(void)
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
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CButtonsGroup::Hide(void)
  {
//--- �����, ���� ������� �����
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
void CButtonsGroup::Reset(void)
  {
//--- ������, ���� ������� ����������
   if(CElement::IsDropdown())
      return;
//--- ������ � ��������
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CButtonsGroup::SetZorders(void)
  {
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
      m_buttons[i].Z_Order(m_buttons_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CButtonsGroup::ResetZorders(void)
  {
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
      m_buttons[i].Z_Order(-1);
  }
//+------------------------------------------------------------------+
//| ��������                                                         |
//+------------------------------------------------------------------+
void CButtonsGroup::Delete(void)
  {
//--- �������� ��������
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
      m_buttons[i].Delete();
//--- ������������ �������� ��������
   ::ArrayFree(m_buttons);
   ::ArrayFree(m_buttons_total);
   ::ArrayFree(m_buttons_state);
   ::ArrayFree(m_buttons_x_gap);
   ::ArrayFree(m_buttons_y_gap);
   ::ArrayFree(m_buttons_text);
   ::ArrayFree(m_buttons_width);
   ::ArrayFree(m_buttons_color);
   ::ArrayFree(m_buttons_color_hover);
   ::ArrayFree(m_buttons_color_pressed);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������                                       |
//+------------------------------------------------------------------+
void CButtonsGroup::ButtonsGroupState(const bool state)
  {
   m_buttons_group_state=state;
//---
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
     {
      m_buttons[i].State(false);
      m_buttons[i].Color((state)? m_text_color : m_text_color_off);
      m_buttons[i].BackColor((state)? m_buttons_color[i]: m_back_color_off);
      m_buttons[i].BorderColor((state)? m_border_color : m_border_color_off);
     }
//--- ������ ������, ���� �� ���������� ���� �������
   if(m_buttons_group_state)
     {
      if(m_selected_button_index!=WRONG_VALUE)
        {
         m_buttons_state[m_selected_button_index]=true;
         m_buttons[m_selected_button_index].Color(m_text_color_pressed);
         m_buttons[m_selected_button_index].BackColor(m_buttons_color_pressed[m_selected_button_index]);
        }
     }
  }
//+------------------------------------------------------------------+
//| ����������� ������ �� ���������� �������                         |
//+------------------------------------------------------------------+
void CButtonsGroup::SelectionButton(const int index)
  {
//--- ��� �������� ������������� ������� � ������ ������
   bool check_pressed_button=false;
//--- ������� ���������� ������
   int buttons_total=ButtonsTotal();
//--- ���� ��� �� ����� ������ � ������, �������� �� ����
   if(buttons_total<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� ������! �������������� ������� CButtonsGroup::AddButton()");
     }
//--- ��������������� �������� �������, ���� ������� �� ���������
   int correct_index=(index>=buttons_total)? buttons_total-1 : (index<0)? 0 : index;
//--- �������� ��������� ������ �� ���������������
   m_buttons_state[correct_index]=(m_buttons_state[correct_index])? false : true;
//--- �������� � ����� �� ������ ������
   for(int i=0; i<buttons_total; i++)
     {
      //--- � ����������� �� ������ �������������� ��������������� ��������
      bool condition=(m_radio_buttons_mode)? (i==correct_index) : (i==correct_index && m_buttons_state[i]);
      //--- ���� ������� ���������, ������� ������ �������
      if(condition)
        {
         if(m_radio_buttons_mode)
            m_buttons_state[i]=true;
         //--- ���� ������� ������
         check_pressed_button=true;
         //--- ���������� �����
         m_buttons[i].Color(m_text_color_pressed);
         m_buttons[i].BackColor(m_buttons_color_pressed[i]);
         CElement::InitColorArray(m_buttons_color_pressed[i],m_buttons_color_pressed[i],m_buttons_total[i].m_buttons_color_array);
        }
      //--- ���� ������� �� �����������, ������� ������ �������
      else
        {
         //--- ���������� ����������� ��������� � �����
         m_buttons_state[i]=false;
         m_buttons[i].Color(m_text_color);
         m_buttons[i].BackColor(m_buttons_color[i]);
         CElement::InitColorArray(m_buttons_color[i],m_buttons_color_hover[i],m_buttons_total[i].m_buttons_color_array);
        }
      //--- �������� ������� ��������� ������
      m_buttons[i].State(false);
     }
//--- ���� ���� ������� ������, �������� � ����� � ������
   m_selected_button_text  =(check_pressed_button) ? m_buttons[correct_index].Description() : "";
   m_selected_button_index =(check_pressed_button) ? correct_index : WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| ������� �� ������ � ������                                       |
//+------------------------------------------------------------------+
bool CButtonsGroup::OnClickButton(const string pressed_object)
  {
//--- ������, ���� ������� ���� �� �� ������ ����
   if(::StringFind(pressed_object,CElement::ProgramName()+"_buttons_",0)<0)
      return(false);
//--- ������� ������������� �� ����� �������
   int id=IdFromObjectName(pressed_object);
//--- ������, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ��� �������� �������
   int check_index=WRONG_VALUE;
//--- ��������, ���� �� ������� �� ����� �� ������ ���� ������
   int buttons_total=ButtonsTotal();
//--- �����, ���� ������ �������������
   if(!m_buttons_group_state)
     {
      for(int i=0; i<buttons_total; i++)
         m_buttons[i].State(false);
      //---
      return(false);
     }
//--- ���� ������� ����, �� �������� ������
   for(int i=0; i<buttons_total; i++)
     {
      if(m_buttons[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- ������, ���� �� ���� ������� �� ������ � ���� ������
   if(check_index==WRONG_VALUE)
      return(false);
//--- ����������� ������
   SelectionButton(check_index);
//--- ��������� ������ �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),m_selected_button_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| �������� ������� ����� ������ ���� ��� �������� ������           |
//+------------------------------------------------------------------+
void CButtonsGroup::CheckPressedOverButton(void)
  {
   int buttons_total=ButtonsTotal();
//--- ���������� ���� � ����������� �� �������������� ������� ����� ������ ����
   for(int i=0; i<buttons_total; i++)
     {
      //--- ���� ���� �����, �� ���� ������� ������
      if(m_buttons[i].MouseFocus())
         m_buttons[i].BackColor(m_buttons_color_pressed[i]);
      //--- ���� ������ ���, ��...
      else
        {
         //--- ...���� ������ ������ �� ������, ��������� ���� ����
         if(!m_buttons_state[i])
            m_buttons[i].BackColor(m_buttons_color[i]);
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CButtonsGroup::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
