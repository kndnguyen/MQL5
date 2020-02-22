//+------------------------------------------------------------------+
//|                                                  SplitButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "ContextMenu.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ��������� ������                              |
//+------------------------------------------------------------------+
class CSplitButton : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������
   CButton           m_button;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CEdit             m_drop_button;
   CBmpLabel         m_drop_arrow;
   CContextMenu      m_drop_menu;
   //--- �������� ������:
   //    ������ � ��������� ������ �� ������� ����� ������� ����
   int               m_button_x_size;
   int               m_button_y_size;
   int               m_button_zorder;
   //--- ����� ����
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_pressed;
   color             m_back_color_hover;
   color             m_back_color_array[];
   //--- ����� �����
   color             m_border_color;
   color             m_border_color_off;
   color             m_border_color_hover;
   color             m_border_color_array[];
   //--- ������ � ��������� ������ � ���������� ���� �� ������� ����� ������� ����
   int               m_drop_button_x_size;
   int               m_drop_button_zorder;
   //--- ������� ������
   int               m_drop_arrow_x_gap;
   int               m_drop_arrow_y_gap;
   //--- ������ ������ � ���������� ���� � �������� � ��������������� ���������
   string            m_drop_arrow_file_on;
   string            m_drop_arrow_file_off;
   //--- ������� ������
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- ������ ������ � �������� � ��������������� ���������
   string            m_icon_file_on;
   string            m_icon_file_off;
   //--- ����� � ������� ��������� �����
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- ����� ��������� �����
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   color             m_label_color_array[];
   //--- ����� ��������� ��� �������������� ��������
   int               m_zorder;
   //--- ��������/������������
   bool              m_button_state;
   //--- ��������� ������������ ���� 
   bool              m_drop_menu_state;
   //---
public:
                     CSplitButton(void);
                    ~CSplitButton(void);
   //--- ������ ��� �������� ������
   bool              CreateSplitButton(const long chart_id,const string button_text,const int window,const int x,const int y);
   //---
private:
   bool              CreateButton(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   bool              CreateDropButton(void);
   bool              CreateDropIcon(void);
   bool              CreateDropMenu(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ��������� ��������� ������������ ����,
   //    (3) ����� ��������� ������ (��������/������������)
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);         }
   CContextMenu     *GetContextMenuPointer(void)              { return(::GetPointer(m_drop_menu));  }
   bool              ButtonState(void)                  const { return(m_button_state);             }
   void              ButtonState(const bool state);
   //--- ������ ������� ������ � ������ � ���������� ����
   void              ButtonXSize(const int x_size)            { m_button_x_size=x_size;             }
   void              ButtonYSize(const int y_size)            { m_button_y_size=y_size;             }
   void              DropButtonXSize(const int x_size)        { m_drop_button_x_size=x_size;        }
   //--- ��������� ����� ����� ������
   void              BorderColor(const color clr)             { m_border_color=clr;                 }
   void              BorderColorOff(const color clr)          { m_border_color_off=clr;             }
   void              BorderColorHover(const color clr)        { m_border_color_hover=clr;           }
   //--- ��������� ������� ��� ������ � �������� � ��������������� ����������
   void              IconFileOn(const string file_path)       { m_icon_file_on=file_path;           }
   void              IconFileOff(const string file_path)      { m_icon_file_off=file_path;          }
   //--- ������� ������
   void              IconXGap(const int x_gap)                { m_icon_x_gap=x_gap;                 }
   void              IconYGap(const int y_gap)                { m_icon_y_gap=y_gap;                 }
   //--- ����� ����
   void              BackColor(const color clr)               { m_back_color=clr;                   }
   void              BackColorOff(const color clr)            { m_back_color_off=clr;               }
   void              BackColorHover(const color clr)          { m_back_color_hover=clr;             }
   void              BackColorPressed(const color clr)        { m_back_color_pressed=clr;           }
   //--- (1) ����� � (2) ������� ��������� �����
   string            Text(void)                         const { return(m_label.Description());      }
   void              LabelXGap(const int x_gap)               { m_label_x_gap=x_gap;                }
   void              LabelYGap(const int y_gap)               { m_label_y_gap=y_gap;                }
   //--- ����� ��������� �����
   void              LabelColor(const color clr)              { m_label_color=clr;                  }
   void              LabelColorOff(const color clr)           { m_label_color_off=clr;              }
   void              LabelColorHover(const color clr)         { m_label_color_hover=clr;            }
   void              LabelColorPressed(const color clr)       { m_label_color_pressed=clr;          }
   //--- ��������� ������� ��� ������ � ���������� ���� � �������� � ��������������� ����������
   void              DropArrowFileOn(const string file_path)  { m_drop_arrow_file_on=file_path;     }
   void              DropArrowFileOff(const string file_path) { m_drop_arrow_file_off=file_path;    }
   //--- ������� ������
   void              DropArrowXGap(const int x_gap)           { m_drop_arrow_x_gap=x_gap;           }
   void              DropArrowYGap(const int y_gap)           { m_drop_arrow_y_gap=y_gap;           }
   //--- ��������� ����� ���� � ���������� ���������� �� �������� ������������ ����
   void              AddItem(const string text,const string path_bmp_on,const string path_bmp_off);
   //--- ��������� �������������� ����� ����� ���������� ������ �� �������� ������������ ����
   void              AddSeparateLine(const int item_index);
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
   //--- ��������� ������� �� ������ � ���������� ����
   bool              OnClickDropButton(const string clicked_object);
   //--- �������� ������� ����� ������ ���� ��� ��������� �������
   void              CheckPressedOverButton(const bool mouse_state);
   //--- �������� ���������� ����
   void              HideDropDownMenu(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CSplitButton::CSplitButton(void) : m_drop_menu_state(false),
                                   m_button_state(true),
                                   m_icon_x_gap(4),
                                   m_icon_y_gap(3),
                                   m_label_x_gap(25),
                                   m_label_y_gap(4),
                                   m_drop_arrow_x_gap(0),
                                   m_drop_arrow_y_gap(3),
                                   m_drop_arrow_file_on(""),
                                   m_drop_arrow_file_off(""),
                                   m_icon_file_on(""),
                                   m_icon_file_off(""),
                                   m_button_y_size(18),
                                   m_border_color(clrWhite),
                                   m_border_color_off(clrWhite),
                                   m_border_color_hover(clrWhite),
                                   m_back_color(clrSilver),
                                   m_back_color_off(clrLightGray),
                                   m_back_color_hover(C'193,218,255'),
                                   m_back_color_pressed(clrBlack),
                                   m_label_color(clrBlack),
                                   m_label_color_off(clrDarkGray),
                                   m_label_color_hover(clrBlack),
                                   m_label_color_pressed(clrBlack)
  {
//--- �������� ��� ������ �������� � ������� ������  
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder             =0;
   m_button_zorder      =1;
   m_drop_button_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSplitButton::~CSplitButton(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CSplitButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- ��������� �����
      int x=(int)lparam;
      int y=(int)dparam;
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_drop_button.MouseFocus(x>m_drop_button.X() && x<m_drop_button.X2() && 
                               y>m_drop_button.Y() && y<m_drop_button.Y2());
      //--- �����, ���� ������ �������������
      if(!m_button_state)
         return;
      //--- ��� ������� �������� � � ������� ������� ����
      if(!CElement::MouseFocus() && sparam=="1")
        {
         //--- �����, ���� ����� � ����������� ����
         if(m_drop_menu.MouseFocus())
            return;
         //--- ������ ���������� ����
         HideDropDownMenu();
         return;
        }
      //--- �������� ������� ����� ������ ���� ��� ��������� �������
      CheckPressedOverButton(bool((int)sparam));
      return;
     }
//--- ��������� ������� ������� �� ������ ���������� ����
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_FREEMENU_ITEM)
     {
      //--- �����, ���� �������������� �� ���������
      if(CElement::Id()!=lparam)
         return;
      //--- ������ ���������� ����
      HideDropDownMenu();
      //--- �������� ���������
      ::EventChartCustom(m_chart_id,ON_CLICK_CONTEXTMENU_ITEM,lparam,dparam,sparam);
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ������� �� �������� ������
      if(OnClickButton(sparam))
         return;
      //--- ������� �� ������ � ���������� ����
      if(OnClickDropButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CSplitButton::OnEventTimer(void)
  {
//--- ���� ������� �������� ����������
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- ���� ����� � ������ �� �������������
      if(!m_wnd.IsLocked() && m_button_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� "������"                                         |
//+------------------------------------------------------------------+
bool CSplitButton::CreateSplitButton(const long chart_id,const string button_text,const int window,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ������ ������ ����� �������� "
              "��������� �� �����: CSplitButton::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =window;
   m_x          =x;
   m_y          =y;
   m_label_text =button_text;
//--- ������� �� ������� �����
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- �������� ������
   if(!CreateButton())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateDropButton())
      return(false);
   if(!CreateDropIcon())
      return(false);
   if(!CreateDropMenu())
      return(false);
//--- ������ ������
   m_drop_menu.Hide();
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ������                                               |
//+------------------------------------------------------------------+
bool CSplitButton::CreateButton(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_split_button_"+(string)CElement::Id();
//--- ��������� ���
   if(!m_button.Create(m_chart_id,name,m_subwin,m_x,m_y,m_button_x_size,m_button_y_size))
      return(false);
//--- ��������� ��������
   m_button.Font(FONT);
   m_button.FontSize(FONT_SIZE);
   m_button.Color(m_back_color);
   m_button.Description("");
   m_button.BorderColor(m_border_color);
   m_button.BackColor(m_back_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_button_zorder);
   m_button.Tooltip("\n");
//--- �������� �������
   CElement::XSize(m_button_x_size);
   CElement::YSize(m_button_y_size);
//--- ������� �� ������� �����
   m_button.XGap(m_x-m_wnd.X());
   m_button.YGap(m_y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ������                                          |
//+------------------------------------------------------------------+
bool CSplitButton::CreateIcon(void)
  {
//--- ������, ���� ����� �� �����
   if(m_icon_file_on=="" || m_icon_file_off=="")
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_split_button_bmp_"+(string)CElement::Id();
//--- ����������
   int x =m_x+m_icon_x_gap;
   int y =m_y+m_icon_y_gap;
//--- ��������� ��������
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_icon.BmpFileOn("::"+m_icon_file_on);
   m_icon.BmpFileOff("::"+m_icon_file_off);
   m_icon.State(true);
   m_icon.Corner(m_corner);
   m_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon.Selectable(false);
   m_icon.Z_Order(m_zorder);
   m_icon.Tooltip("\n");
//--- ������� �� ������� �����
   m_icon.XGap(x-m_wnd.X());
   m_icon.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ������                                           |
//+------------------------------------------------------------------+
bool CSplitButton::CreateLabel(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_split_button_lable_"+(string)CElement::Id();
//--- ����������
   int x =m_x+m_label_x_gap;
   int y =m_y+m_label_y_gap;
//--- ��������� ��������� �����
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_label.Description(m_label_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(m_label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.Tooltip("\n");
//--- ������� �� ������� �����
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ �����-�����                                       |
//+------------------------------------------------------------------+
bool CSplitButton::CreateDropButton(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_split_button_drop_button_"+(string)CElement::Id();
//--- ����������
   int x =m_x+m_x_size-m_drop_button_x_size;
   int y =m_y;
//--- ��������� ������
   if(!m_drop_button.Create(m_chart_id,name,m_subwin,x,y,m_drop_button_x_size,m_button_y_size))
      return(false);
//--- ��������� ��������
   m_drop_button.Font(FONT);
   m_drop_button.FontSize(FONT_SIZE);
   m_drop_button.Color(clrNONE);
   m_drop_button.Description("");
   m_drop_button.BackColor(m_back_color);
   m_drop_button.BorderColor(m_border_color);
   m_drop_button.Corner(m_corner);
   m_drop_button.Anchor(m_anchor);
   m_drop_button.Selectable(false);
   m_drop_button.Z_Order(m_drop_button_zorder);
   m_drop_button.ReadOnly(true);
   m_drop_button.Tooltip("\n");
//--- �������� ����������
   m_drop_button.X(x);
   m_drop_button.Y(y);
//--- �������� �������
   m_drop_button.XSize(m_drop_button_x_size);
   m_drop_button.YSize(m_button_y_size);
//--- ������� �� ������� �����
   m_drop_button.XGap(x-m_wnd.X());
   m_drop_button.YGap(y-m_wnd.Y());
//--- ������������� �������� ���������
   CElement::InitColorArray(m_border_color,m_border_color_hover,m_border_color_array);
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_drop_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� �� �����-�����                                  |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
//---
bool CSplitButton::CreateDropIcon(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_split_button_combobox_icon_"+(string)CElement::Id();
//--- ����������
   int x =m_drop_button.X()+m_drop_arrow_x_gap;
   int y =m_drop_button.Y()+m_drop_arrow_y_gap;
//--- ���� �� ������� �������� ��� �������, ������ ��������� �� ���������
   if(m_drop_arrow_file_on=="")
      m_drop_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp";
   if(m_drop_arrow_file_off=="")
      m_drop_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\DropOff.bmp";
//--- ��������� ��������
   if(!m_drop_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_drop_arrow.BmpFileOn("::"+m_drop_arrow_file_on);
   m_drop_arrow.BmpFileOff("::"+m_drop_arrow_file_off);
   m_drop_arrow.State(true);
   m_drop_arrow.Corner(m_corner);
   m_drop_arrow.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_drop_arrow.Selectable(false);
   m_drop_arrow.Z_Order(m_zorder);
   m_drop_arrow.Tooltip("\n");
//--- �������� ������� (� �������)
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
//| ������ ���������� ����                                          |
//+------------------------------------------------------------------+
bool CSplitButton::CreateDropMenu(void)
  {
//--- �������� ������ ������
   m_drop_menu.WindowPointer(m_wnd);
//--- ��������� ����������� ����
   m_drop_menu.FreeContextMenu(true);
//--- ����������
   int x=m_x;
   int y=m_y+m_y_size;
//--- ��������� ��������
   m_drop_menu.Id(CElement::Id());
   m_drop_menu.XSize((m_drop_menu.XSize()>0)? m_drop_menu.XSize() : m_button_x_size);
//--- ��������� ����������� ����
   if(!m_drop_menu.CreateContextMenu(m_chart_id,m_subwin,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ����                                             |
//+------------------------------------------------------------------+
void CSplitButton::AddItem(const string text,const string path_bmp_on,const string path_bmp_off)
  {
   m_drop_menu.AddItem(text,path_bmp_on,path_bmp_off,MI_SIMPLE);
  }
//+------------------------------------------------------------------+
//| ��������� �������������� �����                                   |
//+------------------------------------------------------------------+
void CSplitButton::AddSeparateLine(const int item_index)
  {
   m_drop_menu.AddSeparateLine(item_index);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CSplitButton::SetZorders(void)
  {
   m_icon.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_drop_arrow.Z_Order(m_zorder);
   m_drop_button.Z_Order(m_drop_button_zorder);
   m_button.Z_Order(m_button_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CSplitButton::ResetZorders(void)
  {
   m_button.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
   m_drop_button.Z_Order(0);
   m_drop_arrow.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ���������� ������                                                |
//+------------------------------------------------------------------+
void CSplitButton::Show(void)
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
void CSplitButton::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ ������
   m_drop_menu.Hide();
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CSplitButton::Reset(void)
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
void CSplitButton::Delete(void)
  {
//--- �������� ��������
   m_button.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_drop_button.Delete();
   m_drop_arrow.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CSplitButton::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
   m_button.X(x+m_button.XGap());
   m_button.Y(y+m_button.YGap());
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_drop_button.X(x+m_drop_button.XGap());
   m_drop_button.Y(y+m_drop_button.YGap());
   m_drop_arrow.X(x+m_drop_arrow.XGap());
   m_drop_arrow.Y(y+m_drop_arrow.YGap());
//--- ���������� ��������� ����������� ��������
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_drop_button.X_Distance(m_drop_button.X());
   m_drop_button.Y_Distance(m_drop_button.Y());
   m_drop_arrow.X_Distance(m_drop_arrow.X());
   m_drop_arrow.Y_Distance(m_drop_arrow.Y());
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CSplitButton::ChangeObjectsColor(void)
  {
   ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
   ChangeObjectColor(m_drop_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
   ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
   ChangeObjectColor(m_drop_button.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������                                       |
//+------------------------------------------------------------------+
void CSplitButton::ButtonState(const bool state)
  {
   m_button_state=state;
//--- ���������� ����� �������� �������� �������� ���������
   m_icon.State(state);
   m_label.Color((state)? m_label_color : m_label_color_off);
   m_button.State(false);
   m_button.BackColor((state)? m_back_color : m_back_color_off);
   m_button.BorderColor((state)? m_border_color : m_border_color_off);
   m_drop_button.BackColor((state)? m_back_color : m_back_color_off);
   m_drop_button.BorderColor((state)? m_border_color : m_border_color_off);
   m_drop_arrow.State(state);
  }
//+------------------------------------------------------------------+
//| ������� �� ������                                                |
//+------------------------------------------------------------------+
bool CSplitButton::OnClickButton(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������  
   if(clicked_object!=m_button.Name())
      return(false);
//--- �����, ���� ������ �������������
   if(!m_button_state)
     {
      //--- ������ ������
      m_button.State(false);
      return(false);
     }
//--- ������ ����
   m_drop_menu.Hide();
   m_drop_menu_state=false;
//--- ������ ������ � ��������� ���� ������
   m_button.State(false);
   m_button.BackColor(m_back_color_hover);
   m_drop_button.BackColor(m_back_color_hover);
//--- ������������ �����
   m_wnd.IsLocked(false);
   m_wnd.IdActivatedElement(WRONG_VALUE);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| ������� �� ������ � ���������� ����                              |
//+------------------------------------------------------------------+
bool CSplitButton::OnClickDropButton(const string clicked_object)
  {
//--- ������, ���� ����� ��� �������  
   if(clicked_object!=m_drop_button.Name())
      return(false);
//--- �����, ���� ������ �������������
   if(!m_button_state)
     {
      //--- ������ ������
      m_button.State(false);
      return(false);
     }
//--- ���� ������ ������, ������ ���
   if(m_drop_menu_state)
     {
      m_drop_menu_state=false;
      m_drop_menu.Hide();
      m_button.BackColor(m_back_color_hover);
      m_drop_button.BackColor(m_back_color_hover);
      //--- ������������ ����� � ������� id ��������-����������
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
//--- ���� ������ �����, ������� ���
   else
     {
      m_drop_menu_state=true;
      m_drop_menu.Show();
      m_button.BackColor(m_back_color_hover);
      m_drop_button.BackColor(m_back_color_pressed);
      //--- ����������� ����� � �������� id ��������-����������
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| �������� ������� ����� ������ ���� ��� ��������� �������         |
//+------------------------------------------------------------------+
void CSplitButton::CheckPressedOverButton(const bool mouse_state)
  {
//--- �����, ���� ��� ������� ��������
   if(!CElement::MouseFocus())
      return;
//--- �����, ���� ����� ������������� � �������������� ����� � ����� �������� �� ���������
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- ������ ���� ������
   if(mouse_state)
     {
      //--- � ���� ������ ����
      if(m_drop_button.MouseFocus())
        {
         m_button.BackColor(m_back_color_hover);
         m_drop_button.BackColor(m_back_color_pressed);
        }
      else
        {
         m_button.BackColor(m_back_color_pressed);
         m_drop_button.BackColor(m_back_color_pressed);
        }
     }
//--- ������ ���� ������
   else
     {
      if(m_drop_menu_state)
        {
         m_button.BackColor(m_back_color_hover);
         m_drop_button.BackColor(m_back_color_pressed);
        }
     }
  }
//+------------------------------------------------------------------+
//| �������� ���������� ����                                         |
//+------------------------------------------------------------------+
void CSplitButton::HideDropDownMenu(void)
  {
//--- ������ ���� � ���������� ��������������� ��������
   m_drop_menu.Hide();
   m_drop_menu_state=false;
   m_button.BackColor(m_back_color);
   m_drop_button.BackColor(m_back_color);
//--- ������������ �����, ���� �������������� ����� � ����� �������� ���������
   if(m_wnd.IdActivatedElement()==CElement::Id())
     {
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
  }
//+------------------------------------------------------------------+
