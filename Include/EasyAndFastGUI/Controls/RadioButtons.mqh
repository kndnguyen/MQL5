//+------------------------------------------------------------------+
//|                                                 RadioButtons.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ������ �����-������                           |
//+------------------------------------------------------------------+
class CRadioButtons : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������
   CRectLabel        m_area[];
   CBmpLabel         m_icon[];
   CLabel            m_label[];
   //--- ��������� ��������� �����
   struct LabelsGradients
     {
      color             m_labels_color_array[];
     };
   LabelsGradients   m_labels_total[];
   //--- �������� ������:
   //    (1) ���� � (2) ��������� ���� �� ������� ����� ������� ����
   color             m_area_color;
   int               m_area_zorder;
   //--- ������� ��� ���������� ������� ������
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   int               m_buttons_width[];
   string            m_buttons_text[];
   //--- ������ ������
   int               m_button_y_size;
   //--- ������ ������ � ��������, ����������� � ��������������� ���������
   string            m_icon_file_on;
   string            m_icon_file_off;
   string            m_icon_file_on_locked;
   string            m_icon_file_off_locked;
   //--- ������� ������
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ����� ������
   color             m_text_color;
   color             m_text_color_off;
   color             m_text_color_hover;
   //--- (1) ����� � (2) ������ ���������� ������
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- ��������� �� ������� ����� ������� ����
   int               m_buttons_zorder;
   //--- ��������/������������
   bool              m_radio_buttons_state;
   //---
public:
                     CRadioButtons(void);
                    ~CRadioButtons(void);
   //--- ������ ��� �������� ������
   bool              CreateRadioButtons(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateArea(const int index);
   bool              CreateRadio(const int index);
   bool              CreateLabel(const int index);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ������,
   //    (3) ����� ��������� ������ (��������/������������)
   void              WindowPointer(CWindow &object)               { m_wnd=::GetPointer(object);       }
   int               RadioButtonsTotal(void)                const { return(::ArraySize(m_icon));      }
   bool              RadioButtonsState(void)                const { return(m_radio_buttons_state);    }
   void              RadioButtonsState(const bool state);
   //--- ��������� ������� ��� ������ � ��������, ����������� � ��������������� ����������
   void              IconFileOn(const string file_path)           { m_icon_file_on=file_path;         }
   void              IconFileOff(const string file_path)          { m_icon_file_off=file_path;        }
   void              IconFileOnLocked(const string file_path)     { m_icon_file_on_locked=file_path;  }
   void              IconFileOffLocked(const string file_path)    { m_icon_file_off_locked=file_path; }
   //--- ������� ������
   void              LabelXGap(const int x_gap)                   { m_label_x_gap=x_gap;              }
   void              LabelYGap(const int y_gap)                   { m_label_y_gap=y_gap;              }
   //--- (1) ���� ����, (2) ����� ������
   void              AreaColor(const color clr)                   { m_area_color=clr;                 }
   void              TextColor(const color clr)                   { m_text_color=clr;                 }
   void              TextColorOff(const color clr)                { m_text_color_off=clr;             }
   void              TextColorHover(const color clr)              { m_text_color_hover=clr;           }
   //--- ���������� (1) ����� � (2) ������ ���������� ������
   string            SelectedButtonText(void)               const { return(m_selected_button_text);   }
   int               SelectedButtonIndex(void)              const { return(m_selected_button_index);  }
   //--- ����������� �����-������ �� ���������� �������
   void              SelectionRadioButton(const int index);

   //--- ��������� ������ � ���������� ���������� �� ��������
   void              AddButton(const int x_gap,const int y_gap,const string text,const int width);
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
   //--- ��������� �������������� �� ����� �����-������
   int               IdFromObjectName(const string object_name);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CRadioButtons::CRadioButtons(void) : m_radio_buttons_state(true),
                                     m_button_y_size(18),
                                     m_area_color(C'15,15,15'),
                                     m_icon_file_on(""),
                                     m_icon_file_off(""),
                                     m_icon_file_on_locked(""),
                                     m_icon_file_off_locked(""),
                                     m_selected_button_text(""),
                                     m_selected_button_index(0),
                                     m_label_x_gap(20),
                                     m_label_y_gap(3),
                                     m_text_color(clrWhite),
                                     m_text_color_off(clrGray),
                                     m_text_color_hover(C'85,170,255')
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_area_zorder    =1;
   m_buttons_zorder =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CRadioButtons::~CRadioButtons(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CRadioButtons::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- �����, ���� ������ �������������
      if(!m_radio_buttons_state)
         return;
      //--- ��������� �����
      int x=(int)lparam;
      int y=(int)dparam;
      int radio_buttons_total=RadioButtonsTotal();
      for(int i=0; i<radio_buttons_total; i++)
         m_area[i].MouseFocus(x>m_area[i].X() && x<m_area[i].X2() && y>m_area[i].Y() && y<m_area[i].Y2());
      //---
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
void CRadioButtons::OnEventTimer(void)
  {
//--- ������� ����, ���� ����� �� �������������
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| ������ ������ �������� ������                                   |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateRadioButtons(const long chart_id,const int window,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ �����-������ ������ ����� �������� "
              "��������� �� �����: CButtonsGroup::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =window;
   m_x        =x;
   m_y        =y;
//--- ������� ���������� ������ � ������
   int radio_buttons_total=RadioButtonsTotal();
//--- ���� ��� �� ����� ������ � ������, �������� �� ����
   if(radio_buttons_total<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� ������! �������������� ������� CRadioButtons::AddButton()");
      return(false);
     }
//--- ��������� ������ ������
   for(int i=0; i<radio_buttons_total; i++)
     {
      CreateArea(i);
      CreateRadio(i);
      CreateLabel(i);
      //--- ��������� ������
      m_area[i].MouseFocus(false);
     }
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� �����-������                                     |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateArea(const int index)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_radio_area_"+(string)index+"__"+(string)CElement::Id();
//--- ������ ���������
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index];
//--- ��������� ���
   if(!m_area[index].Create(m_chart_id,name,m_subwin,x,y,m_buttons_width[index],m_button_y_size))
      return(false);
//--- ��������� �������
   m_area[index].BackColor(m_area_color);
   m_area[index].Color(m_area_color);
   m_area[index].BorderType(BORDER_FLAT);
   m_area[index].Corner(m_corner);
   m_area[index].Selectable(false);
   m_area[index].Z_Order(m_area_zorder);
   m_area[index].Tooltip("\n");
//--- ����������
   m_area[index].X(x);
   m_area[index].Y(y);
//--- �������
   m_area[index].XSize(m_buttons_width[index]);
   m_area[index].YSize(m_button_y_size);
//--- ������� �� ������� �����
   m_area[index].XGap(x-m_wnd.X());
   m_area[index].YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_area[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������                                                 |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_on.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_off.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_on_locked.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_off_locked.bmp"
//---
bool CRadioButtons::CreateRadio(const int index)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_radio_bmp_"+(string)index+"__"+(string)CElement::Id();
//--- ������ ���������
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index]+3;
//--- ���� �� ������� �������� ��� �����-������, ������ ��������� �� ���������
   if(m_icon_file_on=="")
      m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\radio_button_on.bmp";
   if(m_icon_file_off=="")
      m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\radio_button_off.bmp";
   if(m_icon_file_on_locked=="")
      m_icon_file_on_locked="Images\\EasyAndFastGUI\\Controls\\radio_button_on_locked.bmp";
   if(m_icon_file_off_locked=="")
      m_icon_file_off_locked="Images\\EasyAndFastGUI\\Controls\\radio_button_off_locked.bmp";
//--- ��������� ��������
   if(!m_icon[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� �������
   m_icon[index].BmpFileOn("::"+m_icon_file_on);
   m_icon[index].BmpFileOff("::"+m_icon_file_off);
   m_icon[index].State((index==m_selected_button_index) ? true : false);
   m_icon[index].Corner(m_corner);
   m_icon[index].GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon[index].Selectable(false);
   m_icon[index].Z_Order(m_buttons_zorder);
   m_icon[index].Tooltip("\n");
//--- ������� �� ������� �����
   m_icon[index].XGap(x-m_wnd.X());
   m_icon[index].YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_icon[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� �����                                          |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateLabel(const int index)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_radio_lable_"+(string)index+"__"+(string)CElement::Id();
//--- ������ ���������
   int x =CElement::X()+m_buttons_x_gap[index]+m_label_x_gap;
   int y =CElement::Y()+m_buttons_y_gap[index]+m_label_y_gap;
//--- ��������� ��������� �����
   if(!m_label[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//---
   color label_color=(index==m_selected_button_index) ? m_text_color : m_text_color_off;
//--- ��������� �������
   m_label[index].Description(m_buttons_text[index]);
   m_label[index].Font(FONT);
   m_label[index].FontSize(FONT_SIZE);
   m_label[index].Color(label_color);
   m_label[index].Corner(m_corner);
   m_label[index].Anchor(m_anchor);
   m_label[index].Selectable(false);
   m_label[index].Z_Order(m_buttons_zorder);
   m_label[index].Tooltip("\n");
//--- ������� �� ������� �����
   m_label[index].XGap(x-m_wnd.X());
   m_label[index].YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(label_color,m_text_color_hover,m_labels_total[index].m_labels_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_label[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������                                                 |
//+------------------------------------------------------------------+
void CRadioButtons::AddButton(const int x_gap,const int y_gap,const string text,const int width)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size=::ArraySize(m_buttons_text);
   ::ArrayResize(m_area,array_size+1);
   ::ArrayResize(m_icon,array_size+1);
   ::ArrayResize(m_label,array_size+1);
   ::ArrayResize(m_labels_total,array_size+1);
   ::ArrayResize(m_buttons_x_gap,array_size+1);
   ::ArrayResize(m_buttons_y_gap,array_size+1);
   ::ArrayResize(m_buttons_state,array_size+1);
   ::ArrayResize(m_buttons_text,array_size+1);
   ::ArrayResize(m_buttons_width,array_size+1);
//--- �������� �������� ���������� ����������
   m_buttons_x_gap[array_size] =x_gap;
   m_buttons_y_gap[array_size] =y_gap;
   m_buttons_text[array_size]  =text;
   m_buttons_width[array_size] =width;
   m_buttons_state[array_size] =false;
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CRadioButtons::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
     return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].X(x+m_area[i].XGap());
      m_area[i].Y(y+m_area[i].YGap());
      m_icon[i].X(x+m_icon[i].XGap());
      m_icon[i].Y(y+m_icon[i].YGap());
      m_label[i].X(x+m_label[i].XGap());
      m_label[i].Y(y+m_label[i].YGap());
     }
//--- ���������� ��������� ����������� ��������
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].X_Distance(m_area[i].X());
      m_area[i].Y_Distance(m_area[i].Y());
      m_icon[i].X_Distance(m_icon[i].X());
      m_icon[i].Y_Distance(m_icon[i].Y());
      m_label[i].X_Distance(m_label[i].X());
      m_label[i].Y_Distance(m_label[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CRadioButtons::ChangeObjectsColor(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      color label_color=(m_buttons_state[i]) ? m_text_color : m_text_color_off;
      ChangeObjectColor(m_label[i].Name(),m_area[i].MouseFocus(),
                        OBJPROP_COLOR,label_color,m_text_color_hover,m_labels_total[i].m_labels_color_array);
     }
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CRadioButtons::SetZorders(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Z_Order(m_area_zorder);
      m_icon[i].Z_Order(m_buttons_zorder);
      m_label[i].Z_Order(m_buttons_zorder);
     }
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CRadioButtons::ResetZorders(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Z_Order(-1);
      m_icon[i].Z_Order(-1);
      m_label[i].Z_Order(-1);
     }
  }
//+------------------------------------------------------------------+
//| ���������� ������                                                |
//+------------------------------------------------------------------+
void CRadioButtons::Show(void)
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
void CRadioButtons::Hide(void)
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
void CRadioButtons::Reset(void)
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
void CRadioButtons::Delete(void)
  {
//--- �������� ��������
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Delete();
      m_icon[i].Delete();
      m_label[i].Delete();
     }
//--- ������������ �������� ��������
   ::ArrayFree(m_labels_total);
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
void CRadioButtons::RadioButtonsState(const bool state)
  {
   m_radio_buttons_state=state;
//---
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_icon[i].BmpFileOn((state)? "::"+m_icon_file_on : "::"+m_icon_file_on_locked);
      m_icon[i].BmpFileOff((state)? "::"+m_icon_file_off : "::"+m_icon_file_off_locked);
      m_label[i].Color((state && i==m_selected_button_index)? m_text_color : m_text_color_off);
     }
  }
//+------------------------------------------------------------------+
//| ���������, ����� �����-������ ������ ���� ��������               |
//+------------------------------------------------------------------+
void CRadioButtons::SelectionRadioButton(const int index)
  {
//--- ������� ���������� ������
   int radio_buttons_total=RadioButtonsTotal();
//--- ���� ��� �� ����� �����-������ � ������, �������� �� ����
   if(radio_buttons_total<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������ ���� ���� �� ���� �����-������! �������������� ������� CRadioButtons::AddButton()");
     }
//--- ��������������� �������� �������, ���� ������� �� ���������
   int correct_index=(index>=radio_buttons_total)? radio_buttons_total-1 :(index<0)? 0 : index;
//--- ����������� ������
   for(int i=0; i<radio_buttons_total; i++)
     {
      if(i==correct_index)
        {
         m_buttons_state[i]=true;
         m_icon[i].State(true);
         m_label[i].Color(m_text_color_hover);
         InitColorArray(m_text_color,m_text_color_hover,m_labels_total[i].m_labels_color_array);
        }
      else
        {
         m_buttons_state[i]=false;
         m_icon[i].State(false);
         m_label[i].Color(m_text_color_off);
         InitColorArray(m_text_color_off,m_text_color_hover,m_labels_total[i].m_labels_color_array);
        }
     }
//--- �������� � ����� � ������
   m_selected_button_index =correct_index;
   m_selected_button_text  =m_buttons_text[correct_index];
  }
//+------------------------------------------------------------------+
//| ������� �� �����-������                                          |
//+------------------------------------------------------------------+
bool CRadioButtons::OnClickButton(const string pressed_object)
  {
//--- ������, ���� ������� ���� �� �� ������ ����
   if(::StringFind(pressed_object,CElement::ProgramName()+"_radio_area_",0)<0)
      return(false);
//--- ������� ������������� � ������ �� ����� �������
   int id=IdFromObjectName(pressed_object);
//--- ������, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ��� �������� �������
   int check_index=WRONG_VALUE;
//--- �����, ���� ������ �������������
   if(!m_radio_buttons_state)
      return(false);
//--- ���� ������� ����, �� �������� ������
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      if(m_area[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- ������, ���� �� ���� ������� �� ������ � ���� ������ ���
//    ���� ��� ��� ���������� �����-������
   if(check_index==WRONG_VALUE || check_index==m_selected_button_index)
      return(false);
//--- ����������� ������
   SelectionRadioButton(check_index);
//--- ��������� ������ �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,CElement::Id(),check_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CRadioButtons::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
