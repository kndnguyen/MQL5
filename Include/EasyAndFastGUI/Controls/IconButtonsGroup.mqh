//+------------------------------------------------------------------+
//|                                             IconButtonsGroup.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������ �����-������                           |
//+------------------------------------------------------------------+
class CIconButtonsGroup : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������
   CButton           m_buttons[];
   CBmpLabel         m_icons[];
   CLabel            m_labels[];
   //--- ��������� ��������� �����
   struct IconButtonsGradients
     {
      color             m_back_color_array[];
      color             m_label_color_array[];
     };
   IconButtonsGradients   m_icon_buttons_total[];
   //--- �������� ������:
   //    ������� ��� ���������� ������� ������
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   string            m_buttons_text[];
   int               m_buttons_width[];
   string            m_icon_file_on[];
   string            m_icon_file_off[];
   //--- ������ ������
   int               m_buttons_y_size;
   //--- ���� ���� � ��������� �������
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   //--- ���� �����
   color             m_border_color;
   color             m_border_color_off;
   //--- ������� ������
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- ������� ��������� �����
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ���� ��������� ����� � ��������� �������
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   //--- (1) ����� � (2) ������ ���������� ������
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- ����� ��������� ��� �������������� ��������
   int               m_zorder;
   //--- ��������� �� ������� ����� ������� ����
   int               m_buttons_zorder;
   //--- ��������/������������
   bool              m_icon_buttons_state;
   //---
public:
                     CIconButtonsGroup(void);
                    ~CIconButtonsGroup(void);
   //--- ������ ��� �������� ������
   bool              CreateIconButtonsGroup(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateButton(const int index);
   bool              CreateIcon(const int index);
   bool              CreateLabel(const int index);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ������ ������, (3) ���������� ������,
   //    (4) ����� ��������� ������ (��������/������������)
   void              WindowPointer(CWindow &object)               { m_wnd=::GetPointer(object);      }
   void              ButtonsYSize(const int y_size)               { m_buttons_y_size=y_size;         }
   int               IconButtonsTotal(void)                 const { return(::ArraySize(m_icons));    }
   bool              IconButtonsState(void)                 const { return(m_icon_buttons_state);    }
   void              IconButtonsState(const bool state);
   //--- ����� ���� ������
   void              BackColor(const color clr)                   { m_back_color=clr;                }
   void              BackColorOff(const color clr)                { m_back_color_off=clr;            }
   void              BackColorHover(const color clr)              { m_back_color_hover=clr;          }
   void              BackColorPressed(const color clr)            { m_back_color_pressed=clr;        }
   //--- ��������� ����� ����� ������
   void              BorderColor(const color clr)                 { m_border_color=clr;              }
   void              BorderColorOff(const color clr)              { m_border_color_off=clr;          }
   //--- ������� ������
   void              IconXGap(const int x_gap)                    { m_icon_x_gap=x_gap;              }
   void              IconYGap(const int y_gap)                    { m_icon_y_gap=y_gap;              }
   //--- ������� ��������� �����
   void              LabelXGap(const int x_gap)                   { m_label_x_gap=x_gap;             }
   void              LabelYGap(const int y_gap)                   { m_label_y_gap=y_gap;             }
   //--- ���������� (1) ����� � (2) ������ ���������� ������
   string            SelectedButtonText(void)               const { return(m_selected_button_text);  }
   int               SelectedButtonIndex(void)              const { return(m_selected_button_index); }
   //--- ����������� �����-������ �� ���������� �������
   void              SelectedRadioButton(const int index);

   //--- ��������� ������ � ���������� ���������� �� ��������
   void              AddButton(const int x_gap,const int y_gap,const string text,
                               const int width,const string icon_file_on,const string icon_file_off);
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
   bool              OnClickButton(const string pressed_object);
   //--- �������� ������� ����� ������ ���� ��� �������� ������
   void              CheckPressedOverButton(void);
   //--- ��������� �������������� �� ����� �����-������
   int               IdFromObjectName(const string object_name);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CIconButtonsGroup::CIconButtonsGroup(void) : m_icon_buttons_state(true),
                                             m_buttons_y_size(22),
                                             m_selected_button_text(""),
                                             m_selected_button_index(0),
                                             m_icon_x_gap(4),
                                             m_icon_y_gap(3),
                                             m_label_x_gap(25),
                                             m_label_y_gap(4),
                                             m_back_color(clrLightGray),
                                             m_back_color_off(clrLightGray),
                                             m_back_color_hover(clrSilver),
                                             m_back_color_pressed(clrBlack),
                                             m_border_color(clrWhite),
                                             m_border_color_off(clrDarkGray),
                                             m_label_color(clrBlack),
                                             m_label_color_off(clrDarkGray),
                                             m_label_color_hover(clrBlack),
                                             m_label_color_pressed(clrBlack)
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder         =0;
   m_buttons_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIconButtonsGroup::~CIconButtonsGroup(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CIconButtonsGroup::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- �����, ���� ������ �������������
      if(!m_icon_buttons_state)
         return;
      //--- ��������� �����
      int x=(int)lparam;
      int y=(int)dparam;
      int icon_buttons_total=IconButtonsTotal();
      for(int i=0; i<icon_buttons_total; i++)
         m_buttons[i].MouseFocus(x>m_buttons[i].X() && x<m_buttons[i].X2() && y>m_buttons[i].Y() && y<m_buttons[i].Y2());
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
      //--- ����������� ������
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CIconButtonsGroup::OnEventTimer(void)
  {
//--- ������� ����, ���� ����� �� �������������
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| ������ ������ �������� "������ � ����������"                    |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateIconButtonsGroup(const long chart_id,const int window,const int x,const int y)
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
   m_subwin   =window;
   m_x        =x;
   m_y        =y;
//--- ��������� ������
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      CreateButton(i);
      CreateIcon(i);
      CreateLabel(i);
      //---
      m_buttons[i].MouseFocus(false);
     }
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ������                                           |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateButton(const int index)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icon_button_"+(string)index+"__"+(string)CElement::Id();
//--- ������ ���������
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index];
//--- ��������� ������
   if(!m_buttons[index].Create(m_chart_id,name,m_subwin,x,y,m_buttons_width[index],m_buttons_y_size))
      return(false);
//--- ��������� ��������
   m_buttons[index].Font(FONT);
   m_buttons[index].FontSize(FONT_SIZE);
   m_buttons[index].Color(m_back_color);
   m_buttons[index].Description("");
   m_buttons[index].BackColor(m_back_color);
   m_buttons[index].BorderColor(m_border_color);
   m_buttons[index].Corner(m_corner);
   m_buttons[index].Anchor(m_anchor);
   m_buttons[index].Selectable(false);
   m_buttons[index].Z_Order(m_buttons_zorder);
   m_buttons[index].Tooltip("\n");
//--- �������� �������
   m_buttons[index].XSize(m_buttons_width[index]);
   m_buttons[index].YSize(m_buttons_width[index]);
//--- ������� �� ������� �����
   m_buttons[index].XGap(x-m_wnd.X());
   m_buttons[index].YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_icon_buttons_total[index].m_back_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_buttons[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������                                                 |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateIcon(const int index)
  {
//--- ���� ����� ��� ������ �� �����, �����
   if(m_icon_file_on[index]=="" || m_icon_file_off[index]=="")
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icon_button_bmp_"+(string)index+"__"+(string)CElement::Id();
//--- ������ ���������
   int x=m_x+m_buttons_x_gap[index]+m_icon_x_gap;
   int y=m_y+m_buttons_y_gap[index]+m_icon_y_gap;
//--- ��������� ��������
   if(!m_icons[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
   m_icons[index].BmpFileOn("::"+m_icon_file_on[index]);
   m_icons[index].BmpFileOff("::"+m_icon_file_off[index]);
   m_icons[index].State(true);
   m_icons[index].Corner(m_corner);
   m_icons[index].GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icons[index].Selectable(false);
   m_icons[index].Z_Order(m_zorder);
   m_icons[index].Tooltip("\n");
//--- ������� �� ������� �����
   m_icons[index].XGap(x-m_wnd.X());
   m_icons[index].YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_icons[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� �����                                          |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateLabel(const int index)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_icon_button_lable_"+(string)index+"__"+(string)CElement::Id();
//--- ����������
   int x=m_x+m_buttons_x_gap[index]+m_label_x_gap;
   int y=m_y+m_buttons_y_gap[index]+m_label_y_gap;
//--- ��������� ��������� �����
   if(!m_labels[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_labels[index].Description(m_buttons_text[index]);
   m_labels[index].Font(FONT);
   m_labels[index].FontSize(FONT_SIZE);
   m_labels[index].Color(m_label_color);
   m_labels[index].Corner(m_corner);
   m_labels[index].Anchor(m_anchor);
   m_labels[index].Selectable(false);
   m_labels[index].Z_Order(m_zorder);
   m_labels[index].Tooltip("\n");
//--- ������� �� ������� �����
   m_labels[index].XGap(x-m_wnd.X());
   m_labels[index].YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_label_color,m_label_color_hover,m_icon_buttons_total[index].m_label_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_labels[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������                                                 |
//+------------------------------------------------------------------+
void CIconButtonsGroup::AddButton(const int x_gap,const int y_gap,const string text,
                                  const int width,const string icon_file_on,const string icon_file_off)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_buttons_text);
   ::ArrayResize(m_buttons,array_size+1);
   ::ArrayResize(m_icons,array_size+1);
   ::ArrayResize(m_labels,array_size+1);
   ::ArrayResize(m_buttons_x_gap,array_size+1);
   ::ArrayResize(m_buttons_y_gap,array_size+1);
   ::ArrayResize(m_buttons_state,array_size+1);
   ::ArrayResize(m_buttons_text,array_size+1);
   ::ArrayResize(m_buttons_width,array_size+1);
   ::ArrayResize(m_icon_file_on,array_size+1);
   ::ArrayResize(m_icon_file_off,array_size+1);
   ::ArrayResize(m_icon_buttons_total,array_size+1);
//--- �������� �������� ���������� ����������
   m_buttons_x_gap[array_size] =x_gap;
   m_buttons_y_gap[array_size] =y_gap;
   m_buttons_text[array_size]  =text;
   m_buttons_width[array_size] =width;
   m_icon_file_on[array_size]  =icon_file_on;
   m_icon_file_off[array_size] =icon_file_off;
   m_buttons_state[array_size] =false;
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].X(x+m_buttons[i].XGap());
      m_buttons[i].Y(y+m_buttons[i].YGap());
      m_icons[i].X(x+m_icons[i].XGap());
      m_icons[i].Y(y+m_icons[i].YGap());
      m_labels[i].X(x+m_labels[i].XGap());
      m_labels[i].Y(y+m_labels[i].YGap());
     }
//--- ���������� ��������� ����������� ��������
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].X_Distance(m_buttons[i].X());
      m_buttons[i].Y_Distance(m_buttons[i].Y());
      m_icons[i].X_Distance(m_icons[i].X());
      m_icons[i].Y_Distance(m_icons[i].Y());
      m_labels[i].X_Distance(m_labels[i].X());
      m_labels[i].Y_Distance(m_labels[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CIconButtonsGroup::ChangeObjectsColor(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      color label_color=(m_buttons_state[i]) ? m_label_color : m_label_color_off;
      ChangeObjectColor(m_labels[i].Name(),m_buttons[i].MouseFocus(),
                        OBJPROP_COLOR,label_color,m_label_color_pressed,m_icon_buttons_total[i].m_label_color_array);
      ChangeObjectColor(m_buttons[i].Name(),m_buttons[i].MouseFocus(),
                        OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_icon_buttons_total[i].m_back_color_array);
     }
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CIconButtonsGroup::SetZorders(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Z_Order(m_buttons_zorder);
      m_icons[i].Z_Order(m_zorder);
      m_labels[i].Z_Order(m_zorder);
     }
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CIconButtonsGroup::ResetZorders(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Z_Order(-1);
      m_icons[i].Z_Order(-1);
      m_labels[i].Z_Order(-1);
     }
  }
//+------------------------------------------------------------------+
//| ���������� ������                                                |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Show(void)
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
//| �������� ������                                                  |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Hide(void)
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
void CIconButtonsGroup::Reset(void)
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
void CIconButtonsGroup::Delete(void)
  {
//--- �������� ��������
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Delete();
      m_icons[i].Delete();
      m_labels[i].Delete();
     }
//--- ������������ �������� ��������
   ::ArrayFree(m_buttons_x_gap);
   ::ArrayFree(m_buttons_y_gap);
   ::ArrayFree(m_buttons_width);
   ::ArrayFree(m_buttons_state);
   ::ArrayFree(m_buttons_text);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������                                       |
//+------------------------------------------------------------------+
void CIconButtonsGroup::IconButtonsState(const bool state)
  {
   m_icon_buttons_state=state;
//---
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_icons[i].State(state && i==m_selected_button_index);
      m_labels[i].Color((state && i==m_selected_button_index)? m_label_color_pressed : m_label_color_off);
      m_buttons[i].BackColor((state && i==m_selected_button_index)? m_back_color_pressed : m_back_color_off);
     }
  }
//+------------------------------------------------------------------+
//| ���������, ����� �����-������ ������ ���� ��������               |
//+------------------------------------------------------------------+
void CIconButtonsGroup::SelectedRadioButton(const int index)
  {
//--- ������� ���������� ������
   int icon_buttons_total=IconButtonsTotal();
//--- ���� ��� �� ����� �����-������ � ������, �������� �� ����
   if(icon_buttons_total<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� ������! �������������� ������� CIconButtonsGroup::AddButton()");
     }
//--- ��������������� �������� �������, ���� ������� �� ���������
   int correct_index=(index>=icon_buttons_total)? icon_buttons_total-1 : (index<0)? 0 : index;
//--- ����������� ������
   for(int i=0; i<icon_buttons_total; i++)
     {
      if(i==correct_index)
        {
         m_buttons_state[i]=true;
         m_icons[i].State(true);
         m_labels[i].Color(m_label_color_hover);
         m_buttons[i].BackColor(m_back_color_pressed);
         CElement::InitColorArray(m_label_color,m_label_color_hover,m_icon_buttons_total[i].m_label_color_array);
        }
      else
        {
         m_buttons_state[i]=false;
         m_icons[i].State(false);
         m_labels[i].Color(m_label_color_off);
         m_buttons[i].BackColor(m_back_color_off);
         CElement::InitColorArray(m_label_color_off,m_label_color_hover,m_icon_buttons_total[i].m_label_color_array);
        }
      //---
      m_buttons[i].State(false);
     }
//--- �������� � ����� � ������
   m_selected_button_index =correct_index;
   m_selected_button_text  =m_buttons_text[correct_index];
  }
//+------------------------------------------------------------------+
//| ������� �� �����-������                                          |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::OnClickButton(const string pressed_object)
  {
//--- ������, ���� ������� ���� �� �� ������ ����
   if(::StringFind(pressed_object,CElement::ProgramName()+"_icon_button_",0)<0)
      return(false);
//--- ������� ������������� � ������ �� ����� �������
   int id=IdFromObjectName(pressed_object);
//--- ������, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ��� �������� �������
   int check_index=WRONG_VALUE;
//--- ������� ���������� ������
   int icon_buttons_total=IconButtonsTotal();
//--- �����, ���� ������ �������������
   if(!m_icon_buttons_state)
     {
      for(int i=0; i<icon_buttons_total; i++)
         m_buttons[i].State(false);
      //---
      return(false);
     }
//--- ���� ������� ����, �� �������� ������
   for(int i=0; i<icon_buttons_total; i++)
     {
      if(m_buttons[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- ������, ���� �� ���� ������� �� ������ � ���� ������ ���
//    ���� ��� ��� ���������� ������
   if(check_index==WRONG_VALUE || check_index==m_selected_button_index)
     {
      m_buttons[check_index].State(false);
      return(false);
     }
//--- ����������� ������
   SelectedRadioButton(check_index);
//--- ��������� ������ �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),m_selected_button_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| �������� ������� ����� ������ ���� ��� �������� ������           |
//+------------------------------------------------------------------+
void CIconButtonsGroup::CheckPressedOverButton(void)
  {
   int buttons_total=IconButtonsTotal();
//--- ���������� ���� � ����������� �� �������������� ������� ����� ������ ����
   for(int i=0; i<buttons_total; i++)
     {
      //--- ���� ���� �����, �� ���� ������� ������
      if(m_buttons[i].MouseFocus())
         m_buttons[i].BackColor(m_back_color_pressed);
      //--- ���� ������ ���, ��...
      else
        {
         //--- ...���� ������ ������ �� ������, ��������� ���� ����
         if(!m_buttons_state[i])
            m_buttons[i].BackColor(m_back_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CIconButtonsGroup::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
