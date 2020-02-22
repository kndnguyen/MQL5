//+------------------------------------------------------------------+
//|                                                       Window.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include <Charts\Chart.mqh>
//--- ������� ��� ������ �� ������� ���� ����
#define CLOSE_BUTTON_OFFSET   (20)
#define ROLL_BUTTON_OFFSET    (36)
#define TOOLTIP_BUTTON_OFFSET (53)
//+------------------------------------------------------------------+
//| ����� �������� ����� ��� ��������� ����������                    |
//+------------------------------------------------------------------+
class CWindow : public CElement
  {
private:
   CChart            m_chart;
   //--- ������� ��� �������� �����
   CRectLabel        m_bg;
   CRectLabel        m_caption_bg;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CBmpLabel         m_button_tooltip;
   CBmpLabel         m_button_unroll;
   CBmpLabel         m_button_rollup;
   CBmpLabel         m_button_close;
   //--- ������������� ���������� �������� ����������
   int               m_last_id;
   //--- ������������� ��������������� �������� ����������
   int               m_id_activated_element;
   //--- ������ ����������� ��������� ����
   int               m_prev_active_window_index;
   //--- ����������� ���������� ���� �� �������
   bool              m_movable;
   //--- ������ ��������� ����
   bool              m_is_minimized;
   //--- ������ ���������������� ����
   bool              m_is_locked;
   //--- ��� ����
   ENUM_WINDOW_TYPE  m_window_type;
   //--- ����� ������������� ������ ������� (��� �����������)
   bool              m_height_subwindow_mode;
   //--- ����� ������������ ����� � ������� ����������
   bool              m_rollup_subwindow_mode;
   //--- ������ ������� ����������
   int               m_subwindow_height;
   //--- �������� ����
   color             m_bg_color;
   int               m_bg_full_height;
   //--- �������� ���������
   string            m_caption_text;
   int               m_caption_height;
   color             m_caption_bg_color;
   color             m_caption_bg_color_off;
   color             m_caption_bg_color_hover;
   color             m_caption_color_bg_array[];
   //--- ���� ����� ����� (����, ���������)
   color             m_border_color;
   //--- ����� �����
   string            m_icon_file;
   //--- ������� ������ ��� ������ ������ ����������� ���������
   bool              m_tooltips_button;

   //--- ������� �������
   int               m_chart_width;
   int               m_chart_height;

   //--- ��� ����������� ������ ������� ������� � ��������� ����
   int               m_right_limit;
   //--- ���������� ��������� � ������������
   int               m_prev_x;
   int               m_prev_y;
   int               m_size_fixing_x;
   int               m_size_fixing_y;
   //---
   int               m_bg_zorder;
   int               m_caption_zorder;
   int               m_button_zorder;

   //--- ��������� ������ ���� � ������, ��� ��� ���� ������
   ENUM_WMOUSE_STATE m_clamping_area_mouse;
   //--- ��� ���������� ���������� �������
   bool              m_custom_event_chart_state;
   //---
public:
                     CWindow(void);
                    ~CWindow(void);
   //--- ������ ��� �������� ����
   bool              CreateWindow(const long chart_id,const int window,const string caption_text,const int x,const int y);
   //---
private:
   bool              CreateBackground(void);
   bool              CreateCaption(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   bool              CreateButtonClose(void);
   bool              CreateButtonRollUp(void);
   bool              CreateButtonUnroll(void);
   bool              CreateButtonTooltip(void);
   //--- ��������� ����� �������� �����
   void              ChangeObjectsColor(void);
   //---
public:
   //--- ������ ��� ���������� � ��������� id ���������� ���������� ��������
   int               LastId(void)                                      const { return(m_last_id);                  }
   void              LastId(const int id)                                    { m_last_id=id;                       }
   //--- ������ ��� ���������� � ��������� id ��������������� ��������
   int               IdActivatedElement(void)                          const { return(m_id_activated_element);     }
   void              IdActivatedElement(const int id)                        { m_id_activated_element=id;          }
   //--- (1) ��������� � ���������� ������� ����������� ��������� ����
   int               PrevActiveWindowIndex(void)                       const { return(m_prev_active_window_index); }
   void              PrevActiveWindowIndex(const int index)                  { m_prev_active_window_index=index;   }
   //--- ��� ����
   ENUM_WINDOW_TYPE  WindowType(void)                                  const { return(m_window_type);              }
   void              WindowType(const ENUM_WINDOW_TYPE flag)                 { m_window_type=flag;                 }
   //--- ����� �� ���������
   string            DefaultIcon(void);
   //--- (1) ���������������� ����� ����, (2) ����������� ������� ������� ���������
   void              IconFile(const string file_path)                        { m_icon_file=file_path;              }
   void              RightLimit(const int value)                             { m_right_limit=value;                }
   //--- (1) ������������ ������ ���������, (2) �������� ������ ������ ����������� ���������
   void              UseTooltipsButton(void)                                 { m_tooltips_button=true;             }
   bool              TooltipBmpState(void)                             const { return(m_button_tooltip.State());   }
   
   //--- ����������� ����������� ����
   bool              Movable(void)                                     const { return(m_movable);                  }
   void              Movable(const bool flag)                                { m_movable=flag;                     }
   //--- ������ ��������� ����
   bool              IsMinimized(void)                                 const { return(m_is_minimized);             }
   void              IsMinimized(const bool flag)                            { m_is_minimized=flag;                }
   //--- ������ ���������������� ����
   bool              IsLocked(void)                                    const { return(m_is_locked);                }
   void              IsLocked(const bool flag)                               { m_is_locked=flag;                   }
   //--- �������� ���������
   void              CaptionText(const string text);
   string            CaptionText(void)                                 const { return(m_caption_text);             }
   void              CaptionHeight(const int height)                         { m_caption_height=height;            }
   int               CaptionHeight(void)                               const { return(m_caption_height);           }
   void              CaptionBgColor(const color clr)                         { m_caption_bg_color=clr;             }
   color             CaptionBgColor(void)                              const { return(m_caption_bg_color);         }
   void              CaptionBgColorOff(const color clr)                      { m_caption_bg_color_off=clr;         }
   void              CaptionBgColorHover(const color clr)                    { m_caption_bg_color_hover=clr;       }
   color             CaptionBgColorHover(void)                         const { return(m_caption_bg_color_hover);   }
   //--- �������� ����
   void              WindowBgColor(const color clr)                          { m_bg_color=clr;                     }
   color             WindowBgColor(void)                               const { return(m_bg_color);                 }
   void              WindowBorderColor(const color clr)                      { m_border_color=clr;                 }
   color             WindowBorderColor(void)                           const { return(m_border_color);             }
   
   //--- ��������� ��������� ����
   void              State(const bool flag);
   //--- ����� ������������ ������� ����������
   void              RollUpSubwindowMode(const bool flag,const bool height_mode);
   //--- ���������� ���������
   void              ChangeWindowWidth(const int width);
   void              ChangeSubwindowHeight(const int height);

   //--- ��������� �������� �������
   void              SetWindowProperties(void);
   //--- ����������� ���������� Y � �������������
   int               YToRelative(const int y);
   //--- �������� ������� � ������� ��������� 
   bool              CursorInsideCaption(const int x,const int y);
   //--- ��������� ����������
   void              ZeroPanelVariables(void);

   //--- �������� ��������� ����� ������ ����
   void              CheckMouseButtonState(const int x,const int y,const string state);
   //--- �������� ������ ����
   void              CheckMouseFocus(const int x,const int y,const int subwin);
   //--- ��������� ������ �������
   void              SetChartState(const int subwindow_number);
   //--- ���������� ��������� �����
   void              UpdateWindowXY(const int x,const int y);
   //--- ���������������� ���� ���������� ���������� �������
   void              CustomEventChartState(const bool state) { m_custom_event_chart_state=state; }

   //--- �������� �������� ����
   bool              CloseWindow(const string pressed_object);
   //--- �������� ����������� ����
   void              CloseDialogBox(void);
   
   //--- ��������� ��������� ����
   bool              ChangeWindowState(const string pressed_object);
   //--- ������ ��� (1) ������������ � (2) �������������� ����
   void              RollUp(void);
   void              Unroll(void);
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- ������
   virtual void      OnEventTimer(void);
   //--- ����������� ��������
   virtual void      Moving(const int x,const int y);
   //--- �����, �������, �����, ��������
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- ���������, ����� ����������� �� ������� ����� ������ ����
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- �������� ����
   virtual void      ResetColors(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CWindow::CWindow(void) : m_last_id(0),
                         m_id_activated_element(WRONG_VALUE),
                         m_prev_active_window_index(0),
                         m_subwindow_height(0),
                         m_rollup_subwindow_mode(false),
                         m_height_subwindow_mode(false),
                         m_movable(false),
                         m_is_locked(false),
                         m_is_minimized(false),
                         m_tooltips_button(false),
                         m_window_type(W_MAIN),
                         m_icon_file(""),
                         m_right_limit(0),
                         m_clamping_area_mouse(NOT_PRESSED),
                         m_caption_height(20),
                         m_caption_bg_color(C'88,157,255'),
                         m_caption_bg_color_off(clrSilver),
                         m_caption_bg_color_hover(C'118,177,255'),
                         m_bg_color(C'15,15,15'),
                         m_border_color(clrLightGray)

  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ������� ������������������ �����������
   m_bg_zorder      =0;
   m_caption_zorder =1;
   m_button_zorder  =2;
//--- ������� ID �������� �������
   m_chart.Attach();
//--- ������� ������� ���� �������
   SetWindowProperties();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CWindow::~CWindow(void)
  {
   m_chart.Detach();
  }
//+------------------------------------------------------------------+
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CWindow::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      int      x      =(int)lparam; // ���������� �� ��� X
      int      y      =(int)dparam; // ���������� �� ��� Y
      int      subwin =WRONG_VALUE; // ����� ����, � ������� ��������� ������
      datetime time   =NULL;        // ����� ��������������� ���������� X
      double   level  =0.0;         // ������� (����) ��������������� ���������� Y
      int      rel_y  =0;           // ��� ����������� ������������� Y-����������
      //--- ������� �������������� �������
      if(!::ChartXYToTimePrice(m_chart_id,x,y,subwin,time,level))
         return;
      //--- ������� ������������� ���������� Y
      rel_y=YToRelative(y);
      //--- �������� � �������� ��������� ������ ����
      CheckMouseButtonState(x,rel_y,sparam);
      //--- �������� ������ ����
      CheckMouseFocus(x,rel_y,subwin);
      //--- ��������� ��������� �������
      SetChartState(subwin);
      //--- �����, ���� ��� ����� �������������
      if(m_is_locked)
         return;
      //--- ���� ���������� �������� ����, ��������� � ���������
      if(m_clamping_area_mouse==PRESSED_INSIDE_HEADER)
        {
         //--- ���������� ��������� ����
         UpdateWindowXY(x,rel_y);
        }
      //---
      return;
     }
//--- ��������� ������� ������� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ������� ����
      CloseWindow(sparam);
      //--- ��������/���������� ����
      ChangeWindowState(sparam);
      return;
     }
//--- ������� ��������� ������� �������
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      //--- ���� ������ ������
      if(m_clamping_area_mouse==NOT_PRESSED)
        {
         //--- ������� ������� ���� �������
         SetWindowProperties();
         //--- ������������� ���������
         UpdateWindowXY(m_x,m_y);
        }
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CWindow::OnEventTimer(void)
  {
//--- ���� ���� �� �������������
   if(!m_is_locked)
     {
      //--- ��������� ����� �������� �����
      ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� ��������� ����������                           |
//+------------------------------------------------------------------+
bool CWindow::CreateWindow(const long chart_id,const int subwin,const string caption_text,const int x,const int y)
  {
   if(CElement::Id()==WRONG_VALUE)
     {
      ::Print(__FUNCTION__," > ����� ��������� ���� ��� ��������� ����� ��������� � ����: CWndContainer::AddWindow(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_chart_id       =chart_id;
   m_subwin         =subwin;
   m_caption_text   =caption_text;
   m_x              =x;
   m_y              =y;
   m_bg_full_height =m_y_size;
//--- �������� ���� �������� ����
   if(!CreateBackground())
      return(false);
   if(!CreateCaption())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateButtonClose())
      return(false);
   if(!CreateButtonRollUp())
      return(false);
   if(!CreateButtonUnroll())
      return(false);
   if(!CreateButtonTooltip())
      return(false);
//--- ���� ��� ��������� ���������
   if(CElement::ProgramType()==PROGRAM_INDICATOR)
     {
      //--- ���� ���������� ����� ������������� ������ �������
      if(m_height_subwindow_mode)
        {
         m_subwindow_height=m_bg_full_height+3;
         ChangeSubwindowHeight(m_subwindow_height);
        }
     }
//--- �������� ����, ���� ��� ����������
   if(m_window_type==W_DIALOG)
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��� ����                                                 |
//+------------------------------------------------------------------+
bool CWindow::CreateBackground(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_window_bg_"+(string)CElement::Id();
//--- ������ ���� ������� �� ��������� (�������/���������)
   int y_size=0;
   if(m_is_minimized)
     {
      y_size=m_caption_height;
      CElement::YSize(m_caption_height);
     }
   else
     {
      y_size=m_bg_full_height;
      CElement::YSize(m_bg_full_height);
     }
//--- ��������� ��� ����
   if(!m_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,y_size))
      return(false);
//--- ��������� ��������
   m_bg.BackColor(m_bg_color);
   m_bg.Color(m_border_color);
   m_bg.BorderType(BORDER_FLAT);
   m_bg.Corner(m_corner);
   m_bg.Selectable(false);
   m_bg.Z_Order(m_bg_zorder);
   m_bg.Tooltip("\n");
//--- �������� ��������� �������
   CElement::AddToArray(m_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ����                                           |
//+------------------------------------------------------------------+
bool CWindow::CreateCaption(void)
  {
//--- ������������ ����� �������  
   string name=CElement::ProgramName()+"_window_caption_"+(string)CElement::Id();
//--- ��������� ��������� ����
   if(!m_caption_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_caption_height))
      return(false);
//--- ��������� ��������
   m_caption_bg.BackColor(m_caption_bg_color);
   m_caption_bg.Color(m_border_color);
   m_caption_bg.BorderType(BORDER_FLAT);
   m_caption_bg.Corner(m_corner);
   m_caption_bg.Selectable(false);
   m_caption_bg.Z_Order(m_caption_zorder);
   m_caption_bg.Tooltip("\n");
//--- �������� ����������
   m_caption_bg.X(m_x);
   m_caption_bg.Y(m_y);
//--- �������� ������� (� �������)
   m_caption_bg.XSize(m_caption_bg.X_Size());
   m_caption_bg.YSize(m_caption_bg.Y_Size());
//--- ������������� ������� ���������
   CElement::InitColorArray(m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
//--- �������� ��������� �������
   CElement::AddToArray(m_caption_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ���������                                          |
//+------------------------------------------------------------------+
//--- �������� (�� ���������) ��������������� ��� ���������
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
//---
bool CWindow::CreateIcon(void)
  {
   string name=CElement::ProgramName()+"_window_icon_"+(string)CElement::Id();
//--- ���������� �������
   int x=m_x+5;
   int y=m_y+2;
//--- ��������� ����� ����
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ����� �� ���������, ���� �� �������� �������������
   if(m_icon_file=="")
      m_icon_file=DefaultIcon();
//--- ��������� ��������
   m_icon.BmpFileOn("::"+m_icon_file);
   m_icon.BmpFileOff("::"+m_icon_file);
   m_icon.Corner(m_corner);
   m_icon.Selectable(false);
   m_icon.Z_Order(m_button_zorder);
   m_icon.Tooltip("\n");
//--- �������� ����������
   m_icon.X(x);
   m_icon.Y(y);
//--- ������� �� ������� �����
   m_icon.XGap(x-m_x);
   m_icon.YGap(y-m_y);
//--- �������� �������
   m_icon.XSize(m_icon.X_Size());
   m_icon.YSize(m_icon.Y_Size());
//--- �������� ��������� �������
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ����� ���������                                |
//+------------------------------------------------------------------+
bool CWindow::CreateLabel(void)
  {
   string name=CElement::ProgramName()+"_window_label_"+(string)CElement::Id();
//--- ���������� �������
   int x=m_x+24;
   int y=m_y+4;
//--- ��������� ��������� �����
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_label.Description(m_caption_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(clrBlack);
   m_label.Corner(m_corner);
   m_label.Selectable(false);
   m_label.Z_Order(m_button_zorder);
   m_label.Tooltip("\n");
//--- �������� ����������
   m_label.X(x);
   m_label.Y(y);
//--- ������� �� ������� �����
   m_label.XGap(x-m_x);
   m_label.YGap(y-m_y);
//--- �������� �������
   m_label.XSize(m_label.X_Size());
   m_label.YSize(m_label.Y_Size());
//--- �������� ��������� �������
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ �������� ���������                                |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_red.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_black.bmp"
//---
bool CWindow::CreateButtonClose(void)
  {
//--- ���� ��� ��������� "������", ������
   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_window_close_"+(string)CElement::Id();
//--- ���������� �������
   int x=m_x+m_x_size-CLOSE_BUTTON_OFFSET;
   int y=m_y+2;
//--- �������� ������� �������
   m_right_limit+=20;
//--- ��������� ������
   if(!m_button_close.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_button_close.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Close_red.bmp");
   m_button_close.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Close_black.bmp");
   m_button_close.Corner(m_corner);
   m_button_close.Selectable(false);
   m_button_close.Z_Order(m_button_zorder);
   m_button_close.Tooltip("Close");
//--- �������� ����������
   m_button_close.X(x);
   m_button_close.Y(y);
//--- ������� �� ������� �����
   m_button_close.XGap(x-m_x);
   m_button_close.YGap(y-m_y);
//--- �������� �������
   m_button_close.XSize(m_button_close.X_Size());
   m_button_close.YSize(m_button_close.Y_Size());
//--- �������� ��������� �������
   CElement::AddToArray(m_button_close);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ��� ������������ ����                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp"
//---
bool CWindow::CreateButtonRollUp(void)
  {
//--- ���� ��� ��������� "������", ������
   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);
//--- ��� ������ �� �����, ���� ���� ����������
   if(m_window_type==W_DIALOG)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_window_rollup_"+(string)CElement::Id();
//--- ���������� �������
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- �������� ������� �������, ���� ���� ���������
   if(!m_is_minimized)
      m_right_limit+=20;
//--- ��������� ������
   if(!m_button_rollup.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_button_rollup.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp");
   m_button_rollup.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp");
   m_button_rollup.Corner(m_corner);
   m_button_rollup.Selectable(false);
   m_button_rollup.Z_Order(m_button_zorder);
   m_button_rollup.Tooltip("Roll Up");
//--- �������� ����������
   m_button_rollup.X(x);
   m_button_rollup.Y(y);
//--- ������� �� ������� �����
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.YGap(y-m_y);
//--- �������� ������� (� �������)
   m_button_rollup.XSize(m_button_rollup.X_Size());
   m_button_rollup.YSize(m_button_rollup.Y_Size());
//--- ������ ������
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
//--- ������� ������� � ������ ������
   CElement::AddToArray(m_button_rollup);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ��� �������������� ����                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp"
//---
bool CWindow::CreateButtonUnroll(void)
  {
//--- ���� ��� ��������� "������", ������
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- ��� ������ �� �����, ���� ���� ����������
   if(m_window_type==W_DIALOG)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_window_unroll_"+(string)CElement::Id();
//--- ���������� �������
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- �������� ������� �������, ���� ���� �������
   if(m_is_minimized)
      m_right_limit+=20;
//--- ��������� ������
   if(!m_button_unroll.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_button_unroll.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp");
   m_button_unroll.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp");
   m_button_unroll.Corner(m_corner);
   m_button_unroll.Selectable(false);
   m_button_unroll.Z_Order(m_button_zorder);
   m_button_unroll.Tooltip("Unroll");
//--- �������� ����������
   m_button_unroll.X(x);
   m_button_unroll.Y(y);
//--- ������� �� ������� �����
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.YGap(y-m_y);
//--- �������� ������� (� �������)
   m_button_unroll.XSize(m_button_unroll.X_Size());
   m_button_unroll.YSize(m_button_unroll.Y_Size());
//--- ������� ������� � ������ ������
   CElement::AddToArray(m_button_unroll);
//--- ������ ������
   if(!m_is_minimized)
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ���������                                         |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_light.bmp"
//---
bool CWindow::CreateButtonTooltip(void)
  {
//--- ���� ��� ��������� "������", ������
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- ��� ������ �� �����, ���� ���� ����������
   if(m_window_type==W_DIALOG)
      return(true);
//--- ������, ���� ��� ������ �� �����
   if(!m_tooltips_button)
      return(true);
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_window_tooltip_"+(string)CElement::Id();
//--- ���������� �������
   int x=m_x+m_x_size-TOOLTIP_BUTTON_OFFSET;
   int y=m_y+2;
//--- �������� ������� �������
   m_right_limit+=20;
//--- ��������� ������
   if(!m_button_tooltip.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ��������� ��������
   m_button_tooltip.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Help_light.bmp");
   m_button_tooltip.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp");
   m_button_tooltip.Corner(m_corner);
   m_button_tooltip.Selectable(false);
   m_button_tooltip.Z_Order(m_button_zorder);
   m_button_tooltip.Tooltip("Tooltips");
//--- �������� ����������
   m_button_tooltip.X(x);
   m_button_tooltip.Y(y);
//--- ������� �� ������� �����
   m_button_tooltip.XGap(x-m_x);
   m_button_tooltip.YGap(y-m_y);
//--- �������� ������� (� �������)
   m_button_tooltip.XSize(m_button_tooltip.X_Size());
   m_button_tooltip.YSize(m_button_tooltip.Y_Size());
//--- ������� ������� � ������ ������
   CElement::AddToArray(m_button_tooltip);
   return(true);
  }
//+------------------------------------------------------------------+
//| �������� ���� ���������                                          |
//+------------------------------------------------------------------+
void CWindow::CaptionText(const string text)
  {
   m_caption_text=text;
   m_label.Description(text);
  }
//+------------------------------------------------------------------+
//| ����������� ������ �� ���������                                  |
//+------------------------------------------------------------------+
string CWindow::DefaultIcon(void)
  {
   string path="Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp";
//---
   switch(CElement::ProgramType())
     {
      case PROGRAM_SCRIPT:
        {
         path="Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp";
         break;
        }
      case PROGRAM_EXPERT:
        {
         path="Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp";
         break;
        }
      case PROGRAM_INDICATOR:
        {
         path="Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp";
         break;
        }
     }
//---
   return(path);
  }
//+------------------------------------------------------------------+
//| ����� ������������ ������� ����������                            |
//+------------------------------------------------------------------+
void CWindow::RollUpSubwindowMode(const bool rollup_mode=false,const bool height_mode=false)
  {
   if(CElement::m_program_type!=PROGRAM_INDICATOR)
      return;
//---
   m_rollup_subwindow_mode =rollup_mode;
   m_height_subwindow_mode =height_mode;
//---
   if(m_height_subwindow_mode)
      ChangeSubwindowHeight(m_subwindow_height);
  }
//+------------------------------------------------------------------+
//| �������� ������ ������� ����������                               |
//+------------------------------------------------------------------+
void CWindow::ChangeSubwindowHeight(const int height)
  {
   if(CElement::m_subwin<=0 || CElement::m_program_type!=PROGRAM_INDICATOR)
      return;
//---
   if(height>0)
      ::IndicatorSetInteger(INDICATOR_HEIGHT,height);
  }
//+------------------------------------------------------------------+
//| �������� ������ ����                                             |
//+------------------------------------------------------------------+
void CWindow::ChangeWindowWidth(const int width)
  {
//--- ���� ������ �� ����������, ������
   if(width==m_bg.XSize())
      return;
//--- ������� ������ ��� ���� � ���������
   CElement::XSize(width);
   m_bg.XSize(width);
   m_bg.X_Size(width);
   m_caption_bg.XSize(width);
   m_caption_bg.X_Size(width);
//--- ������� ���������� � ������� ��� ���� ������:
//    ������ ��������
   int x=CElement::X2()-CLOSE_BUTTON_OFFSET;
   m_button_close.X(x);
   m_button_close.XGap(x-m_x);
   m_button_close.X_Distance(x);
//--- ������ ��������������
   x=CElement::X2()-ROLL_BUTTON_OFFSET;
   m_button_unroll.X(x);
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.X_Distance(x);
//--- ������ ������������
   m_button_rollup.X(x);
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.X_Distance(x);
//--- ������ ����������� ��������� (���� ��������)
   if(m_tooltips_button)
     {
      x=CElement::X2()-TOOLTIP_BUTTON_OFFSET;
      m_button_tooltip.X(x);
      m_button_tooltip.XGap(x-m_x);
      m_button_tooltip.X_Distance(x);
     }
  }
//+------------------------------------------------------------------+
//| ��������� �������� �������                                       |
//+------------------------------------------------------------------+
void CWindow::SetWindowProperties(void)
  {
//--- ������� ������ � ������ ���� �������
   m_chart_width  =m_chart.WidthInPixels();
   m_chart_height =m_chart.HeightInPixels(m_subwin);
  }
//+------------------------------------------------------------------+
//| ����������� ���������� Y � �������������                         |
//+------------------------------------------------------------------+
int CWindow::YToRelative(const int y)
  {
//--- ������� ���������� �� ����� ������� �� ������� ����������
   int chart_y_distance=m_chart.SubwindowY(m_subwin);
//--- ����������� ���������� Y � �������������
   return(y-chart_y_distance);
  }
//+------------------------------------------------------------------+
//| �������� ��������� ������� � ������� ��������� ����              |
//+------------------------------------------------------------------+
bool CWindow::CursorInsideCaption(const int x,const int y)
  {
   return(x>m_x && x<X2()-m_right_limit && y>m_y && y<m_caption_bg.Y2());
  }
//+------------------------------------------------------------------+
//| ��������� ���������� ��������� � ������������ ���� �             |
//| ���������� ����� ������ ����                                     |
//+------------------------------------------------------------------+
void CWindow::ZeroPanelVariables(void)
  {
   m_prev_x              =0;
   m_prev_y              =0;
   m_size_fixing_x       =0;
   m_size_fixing_y       =0;
   m_clamping_area_mouse =NOT_PRESSED;
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������ ����                                  |
//+------------------------------------------------------------------+
void CWindow::CheckMouseButtonState(const int x,const int y,const string state)
  {
//--- ���� ������ ������
   if(state=="0")
     {
      //--- ������� ����������
      ZeroPanelVariables();
      return;
     }
//--- ���� ������ ������
   if(state=="1")
     {
      //--- ������, ���� ��������� ��� �������������
      if(m_clamping_area_mouse!=NOT_PRESSED)
         return;
      //--- ��� ������� ������
      if(!CElement::MouseFocus())
         m_clamping_area_mouse=PRESSED_OUTSIDE;
      //--- � ������� ������
      else
        {
         //--- ���� ������ ���������
         if(CursorInsideCaption(x,y))
           {
            m_clamping_area_mouse=PRESSED_INSIDE_HEADER;
            return;
           }
         //--- ���� � ������� ����
         m_clamping_area_mouse=PRESSED_INSIDE_WINDOW;
        }
     }
  }
//+------------------------------------------------------------------+
//| �������� ������ ����                                             |
//+------------------------------------------------------------------+
void CWindow::CheckMouseFocus(const int x,const int y,const int subwin)
  {
//--- ���� ������ � ���� ���� ���������
   if(subwin==m_subwin)
     {
      //--- ���� ������ �� � ������ ����������� �����
      if(m_clamping_area_mouse!=PRESSED_INSIDE_HEADER)
        {
         //--- �������� �������������� �������
         CElement::MouseFocus(x>m_x && x<X2() && y>m_y && y<Y2());
         //---
         m_button_close.MouseFocus(x>m_button_close.X() && x<m_button_close.X2() && 
                                   y>m_button_close.Y() && y<m_button_close.Y2());
         m_button_rollup.MouseFocus(x>m_button_rollup.X() && x<m_button_rollup.X2() && 
                                    y>m_button_rollup.Y() && y<m_button_rollup.Y2());
         m_button_unroll.MouseFocus(x>m_button_unroll.X() && x<m_button_unroll.X2() && 
                                    y>m_button_unroll.Y() && y<m_button_unroll.Y2());
        }
     }
   else
     {
      CElement::MouseFocus(false);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �������                                      |
//+------------------------------------------------------------------+
void CWindow::SetChartState(const int subwindow_number)
  {
//--- ���� (������ � ������� ������ � ������ ���� ������) ���
//    ������ ���� ���� ������ ������ ������� ����� ��� ���������
   if((CElement::MouseFocus() && m_clamping_area_mouse==NOT_PRESSED) || 
      m_clamping_area_mouse==PRESSED_INSIDE_WINDOW ||
      m_clamping_area_mouse==PRESSED_INSIDE_HEADER ||
      m_custom_event_chart_state)
     {
      //--- �������� ������ � ���������� ��������� ��������
      m_chart.MouseScroll(false);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,false);
     }
//--- ������� ����������, ���� ������ ��� ���� ����
   else
     {
      m_chart.MouseScroll(true);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
     }
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ����                                        |
//+------------------------------------------------------------------+
void CWindow::UpdateWindowXY(const int x,const int y)
  {
//--- ���� ���������� ����� ������������� �����
   if(!m_movable)
      return;
//---  
   int new_x_point =0; // ����� ���������� X
   int new_y_point =0; // ����� ���������� Y
//--- ������
   int limit_top    =0;
   int limit_left   =0;
   int limit_bottom =0;
   int limit_right  =0;
//--- ���� ������ ���� ������
   if((bool)m_clamping_area_mouse)
     {
      //--- �������� ������� ���������� XY �������
      if(m_prev_y==0 || m_prev_x==0)
        {
         m_prev_y=y;
         m_prev_x=x;
        }
      //--- �������� ���������� �� ������� ����� ����� �� �������
      if(m_size_fixing_y==0 || m_size_fixing_x==0)
        {
         m_size_fixing_y=m_y-m_prev_y;
         m_size_fixing_x=m_x-m_prev_x;
        }
     }
//--- ��������� ������
   limit_top    =y-::fabs(m_size_fixing_y);
   limit_left   =x-::fabs(m_size_fixing_x);
   limit_bottom =m_y+m_caption_height;
   limit_right  =m_x+m_x_size;
//--- ���� �� ������� �� ������� ������� ����/�����/������/�����
   if(limit_bottom<m_chart_height && limit_top>=0 && 
      limit_right<m_chart_width && limit_left>=0)
     {
      new_y_point =y+m_size_fixing_y;
      new_x_point =x+m_size_fixing_x;
     }
//--- ���� ����� �� ������ �������
   else
     {
      if(limit_bottom>m_chart_height) // > ����
        {
         new_y_point =m_chart_height-m_caption_height;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_top<0) // > �����
        {
         new_y_point =0;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_right>m_chart_width) // > ������
        {
         new_x_point =m_chart_width-m_x_size;
         new_y_point =y+m_size_fixing_y;
        }
      if(limit_left<0) // > �����
        {
         new_x_point =0;
         new_y_point =y+m_size_fixing_y;
        }
     }
//--- ������� ����������, ���� ���� �����������
   if(new_x_point>0 || new_y_point>0)
     {
      //--- ������������� ���������� �����
      m_x =(new_x_point<=0)? 1 : new_x_point;
      m_y =(new_y_point<=0)? 1 : new_y_point;
      //---
      if(new_x_point>0)
         m_x=(m_x>m_chart_width-m_x_size-1) ? m_chart_width-m_x_size-1 : m_x;
      if(new_y_point>0)
         m_y=(m_y>m_chart_height-m_caption_height-1) ? m_chart_height-m_caption_height-2 : m_y;
      //--- ������� ����� ��������
      m_prev_x=0;
      m_prev_y=0;
     }
  }
//+------------------------------------------------------------------+
//| ������������� ��������� ����                                     |
//+------------------------------------------------------------------+
void CWindow::State(const bool flag)
  {
//--- ���� ����� ������������� ����
   if(!flag)
     {
      //--- ��������� ������
      m_is_locked=true;
      //--- ��������� ���� ��������� � ����� ����
      m_bg.Color(m_caption_bg_color_off);
      m_caption_bg.Color(m_caption_bg_color_off);
      m_caption_bg.BackColor(m_caption_bg_color_off);
      //--- ������ �� ����� �����. ����� ����� � ��� ������ ���������.
      ::EventChartCustom(m_chart_id,ON_RESET_WINDOW_COLORS,(long)CElement::Id(),0,"");
     }
//--- ���� ����� �������������� ����
   else
     {
      //--- ��������� ������
      m_is_locked=false;
      //--- ��������� ���� ���������
      m_bg.Color(m_border_color);
      m_caption_bg.Color(m_border_color);
      m_caption_bg.BackColor(m_caption_bg_color);
      //--- ����� ������
      CElement::MouseFocus(false);
     }
  }
//+------------------------------------------------------------------+
//| ����� ����� ����                                                 |
//+------------------------------------------------------------------+
void CWindow::ResetColors(void)
  {
   if(!m_is_locked)
     {
      m_is_locked=true;
      m_caption_bg.BackColor(m_caption_bg_color);
     }
  }
//+------------------------------------------------------------------+
//| ����������� ����                                                 |
//+------------------------------------------------------------------+
void CWindow::Moving(const int x,const int y)
  {
//--- ���������� ��������� � ����������
   m_bg.X(x);
   m_bg.Y(y);
   m_caption_bg.X(x);
   m_caption_bg.Y(y);
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_button_close.X(x+m_button_close.XGap());
   m_button_close.Y(y+m_button_close.YGap());
   m_button_unroll.X(x+m_button_unroll.XGap());
   m_button_unroll.Y(y+m_button_unroll.YGap());
   m_button_rollup.X(x+m_button_rollup.XGap());
   m_button_rollup.Y(y+m_button_rollup.YGap());
   m_button_tooltip.X(x+m_button_tooltip.XGap());
   m_button_tooltip.Y(y+m_button_tooltip.YGap());
//--- ���������� ��������� ����������� ��������
   m_bg.X_Distance(m_bg.X());
   m_bg.Y_Distance(m_bg.Y());
   m_caption_bg.X_Distance(m_caption_bg.X());
   m_caption_bg.Y_Distance(m_caption_bg.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_button_close.X_Distance(m_button_close.X());
   m_button_close.Y_Distance(m_button_close.Y());
   m_button_unroll.X_Distance(m_button_unroll.X());
   m_button_unroll.Y_Distance(m_button_unroll.Y());
   m_button_rollup.X_Distance(m_button_rollup.X());
   m_button_rollup.Y_Distance(m_button_rollup.Y());
   m_button_tooltip.X_Distance(m_button_tooltip.X());
   m_button_tooltip.Y_Distance(m_button_tooltip.Y());
  }
//+------------------------------------------------------------------+
//| ��������                                                         |
//+------------------------------------------------------------------+
void CWindow::Delete(void)
  {
//--- ��������� ����������
   m_right_limit=0;
//--- �������� ��������
   m_bg.Delete();
   m_caption_bg.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_button_close.Delete();
   m_button_rollup.Delete();
   m_button_unroll.Delete();
   m_button_tooltip.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ��������� ������ ��������
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CWindow::ChangeObjectsColor(void)
  {
//--- ��������� �������� � �������
   m_button_close.State(m_button_close.MouseFocus());
   m_button_rollup.State(m_button_rollup.MouseFocus());
   m_button_unroll.State(m_button_unroll.MouseFocus());
//--- ��������� ����� � ���������
   CElement::ChangeObjectColor(m_caption_bg.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,
                               m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
  }
//+------------------------------------------------------------------+
//| ���������� ����                                                  |
//+------------------------------------------------------------------+
void CWindow::Show(void)
  {
//--- ������� �������� ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
//--- ��������� ������
   CElement::MouseFocus(false);
   m_button_close.MouseFocus(false);
   m_button_close.State(false);
//--- ��������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_OPEN_DIALOG_BOX,(long)CElement::Id(),0,m_program_name);
  }
//+------------------------------------------------------------------+
//| �������� ����                                                    |
//+------------------------------------------------------------------+
void CWindow::Hide(void)
  {
//--- ������ ��� �������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| ����������� ���� �������� ����                                   |
//+------------------------------------------------------------------+
void CWindow::Reset(void)
  {
//--- ������ ��� ������� �����
   Hide();
//--- ���������� � ������������������ �� ��������
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- � ����������� �� ������ ���������� ������ ������
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   else
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
//--- ����� ������
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CWindow::SetZorders(void)
  {
   m_bg.Z_Order(m_bg_zorder);
   m_caption_bg.Z_Order(m_bg_zorder);
   m_icon.Z_Order(m_button_zorder);
   m_label.Z_Order(m_button_zorder);
   m_button_tooltip.Z_Order(m_button_zorder);
   m_button_unroll.Z_Order(m_button_zorder);
   m_button_rollup.Z_Order(m_button_zorder);
   m_button_close.Z_Order(m_button_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CWindow::ResetZorders(void)
  {
   m_bg.Z_Order(0);
   m_caption_bg.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
   m_button_tooltip.Z_Order(-1);
   m_button_unroll.Z_Order(-1);
   m_button_rollup.Z_Order(-1);
   m_button_close.Z_Order(-1);
  }
//+------------------------------------------------------------------+
//| �������� ����������� ���� ��� ���������                          |
//+------------------------------------------------------------------+
bool CWindow::CloseWindow(const string pressed_object)
  {
//--- ���� ���� ������� �� �� ������ �������� ����
   if(pressed_object!=m_button_close.Name())
      return(false);
//--- ���� ��� ������� ����
   if(m_window_type==W_MAIN)
     {
      //--- ���� ��������� ���� "�������"
      if(CElement::ProgramType()==PROGRAM_EXPERT)
        {
         string text="������� ��������� � �������?";
         //--- ������� ���������� ����
         int mb_res=::MessageBox(text,NULL,MB_YESNO|MB_ICONQUESTION);
         //--- ���� ������ ������ "��", �� ������ ��������� � �������
         if(mb_res==IDYES)
           {
            ::Print(__FUNCTION__," > ��������� ���� ������� � ������� �� ������ �������!");
            //--- �������� �������� � �������
            ::ExpertRemove();
            return(true);
           }
        }
      //--- ���� ��������� ���� "���������"
      else if(CElement::ProgramType()==PROGRAM_INDICATOR)
        {
         //--- �������� ���������� � �������
         if(::ChartIndicatorDelete(m_chart_id,m_subwin,CElement::ProgramName()))
           {
            ::Print(__FUNCTION__," > ��������� ���� ������� � ������� �� ������ �������!");
            return(true);
           }
        }
     }
//--- ���� ��� ���������� ����
   else if(m_window_type==W_DIALOG)
     {
      //--- ������� ���
      CloseDialogBox();
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| �������� ����������� ����                                        |
//+------------------------------------------------------------------+
void CWindow::CloseDialogBox(void)
  {
//--- ��������� ���������
   CElement::IsVisible(false);
//--- ��������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_CLOSE_DIALOG_BOX,CElement::Id(),m_prev_active_window_index,m_caption_text);
  }
//+------------------------------------------------------------------+
//| �������� �� ������� ������������/�������������� ����             |
//+------------------------------------------------------------------+
bool CWindow::ChangeWindowState(const string pressed_object)
  {
//--- ���� ���� ������ ������ "�������� ����"
   if(pressed_object==m_button_rollup.Name())
     {
      RollUp();
      return(true);
     }
//--- ���� ���� ������ ������ "���������� ����"
   if(pressed_object==m_button_unroll.Name())
     {
      Unroll();
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| ����������� ����                                                 |
//+------------------------------------------------------------------+
void CWindow::RollUp(void)
  {
//--- �������� ������
   m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   m_button_unroll.Timeframes(OBJ_ALL_PERIODS);
//--- ���������� � ��������� ������
   m_bg.Y_Size(m_caption_height);
   CElement::YSize(m_caption_height);
//--- ��������� ������
   m_button_unroll.MouseFocus(false);
   m_button_unroll.State(false);
//--- ��������� ����� "�������"
   m_is_minimized=true;
//--- ���� ��� ��������� � ������� � ������������� ������� � � ������� ������������ �������,
//    ��������� ������ ��� ������� ����������
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_caption_height+3);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_WINDOW_ROLLUP,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
//| ������������� ����                                               |
//+------------------------------------------------------------------+
void CWindow::Unroll(void)
  {
//--- �������� ������
   m_button_unroll.Timeframes(OBJ_NO_PERIODS);
   m_button_rollup.Timeframes(OBJ_ALL_PERIODS);
//--- ���������� � ��������� ������
   m_bg.Y_Size(m_bg_full_height);
   CElement::YSize(m_bg_full_height);
//--- ��������� ������
   m_button_rollup.MouseFocus(false);
   m_button_rollup.State(false);
//--- ��������� ����� "���������"
   m_is_minimized=false;
//--- ���� ��� ��������� � ������� � ������������� ������� � � ������� ������������ �������,
//    ��������� ������ ��� ������� ����������
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_subwindow_height);
//--- �������� ��������� �� ����
   ::EventChartCustom(m_chart_id,ON_WINDOW_UNROLL,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
