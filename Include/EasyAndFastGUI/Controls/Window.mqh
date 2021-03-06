//+------------------------------------------------------------------+
//|                                                       Window.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include <Charts\Chart.mqh>
//--- Îòñòóïû äëÿ êíîïîê îò ïðàâîãî êðàÿ îêíà
#define CLOSE_BUTTON_OFFSET   (20)
#define ROLL_BUTTON_OFFSET    (36)
#define TOOLTIP_BUTTON_OFFSET (53)
//+------------------------------------------------------------------+
//| Êëàññ ñîçäàíèÿ ôîðìû äëÿ ýëåìåíòîâ óïðàâëåíèÿ                    |
//+------------------------------------------------------------------+
class CWindow : public CElement
  {
private:
   CChart            m_chart;
   //--- Îáúåêòû äëÿ ñîçäàíèÿ ôîðìû
   CRectLabel        m_bg;
   CRectLabel        m_caption_bg;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CBmpLabel         m_button_tooltip;
   CBmpLabel         m_button_unroll;
   CBmpLabel         m_button_rollup;
   CBmpLabel         m_button_close;
   //--- Èäåíòèôèêàòîð ïîñëåäíåãî ýëåìåíòà óïðàâëåíèÿ
   int               m_last_id;
   //--- Èäåíòèôèêàòîð àêòèâèðîâàííîãî ýëåìåíòà óïðàâëåíèÿ
   int               m_id_activated_element;
   //--- Èíäåêñ ïðåäûäóùåãî àêòèâíîãî îêíà
   int               m_prev_active_window_index;
   //--- Âîçìîæíîñòü ïåðåìåùàòü îêíî íà ãðàôèêå
   bool              m_movable;
   //--- Ñòàòóñ ñâ¸ðíóòîãî îêíà
   bool              m_is_minimized;
   //--- Ñòàòóñ çàáëîêèðîâàííîãî îêíà
   bool              m_is_locked;
   //--- Òèï îêíà
   ENUM_WINDOW_TYPE  m_window_type;
   //--- Ðåæèì ôèêñèðîâàííîé âûñîòû ïîäîêíà (äëÿ èíäèêàòîðîâ)
   bool              m_height_subwindow_mode;
   //--- Ðåæèì ñâîðà÷èâàíèÿ ôîðìû â ïîäîêíå èíäèêàòîðà
   bool              m_rollup_subwindow_mode;
   //--- Âûñîòà ïîäîêíà èíäèêàòîðà
   int               m_subwindow_height;
   //--- Ñâîéñòâà ôîíà
   color             m_bg_color;
   int               m_bg_full_height;
   //--- Ñâîéñòâà çàãîëîâêà
   string            m_caption_text;
   int               m_caption_height;
   color             m_caption_bg_color;
   color             m_caption_bg_color_off;
   color             m_caption_bg_color_hover;
   color             m_caption_color_bg_array[];
   //--- Öâåò ðàìîê ôîðìû (ôîíà, çàãîëîâêà)
   color             m_border_color;
   //--- ßðëûê ôîðìû
   string            m_icon_file;
   //--- Íàëè÷èå êíîïêè äëÿ ðåæèìà ïîêàçà âñïëûâàþùèõ ïîäñêàçîê
   bool              m_tooltips_button;

   //--- Ðàçìåðû ãðàôèêà
   int               m_chart_width;
   int               m_chart_height;

   //--- Äëÿ îïðåäåëåíèÿ ãðàíèö îáëàñòè çàõâàòà â çàãîëîâêå îêíà
   int               m_right_limit;
   //--- Ïåðåìåííûå ñâÿçàííûå ñ ïåðåìåùåíèåì
   int               m_prev_x;
   int               m_prev_y;
   int               m_size_fixing_x;
   int               m_size_fixing_y;
   //---
   int               m_bg_zorder;
   int               m_caption_zorder;
   int               m_button_zorder;

   //--- Ñîñòîÿíèå êíîïêè ìûøè ñ ó÷¸òîì, ãäå îíà áûëà íàæàòà
   ENUM_WMOUSE_STATE m_clamping_area_mouse;
   //--- Äëÿ óïðàâëåíèÿ ñîñòîÿíèåì ãðàôèêà
   bool              m_custom_event_chart_state;
   //---
public:
                     CWindow(void);
                    ~CWindow(void);
   //--- Ìåòîäû äëÿ ñîçäàíèÿ îêíà
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
   //--- Èçìåíåíèå öâåòà îáúåêòîâ ôîðìû
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Ìåòîäû äëÿ ñîõðàíåíèÿ è ïîëó÷åíèÿ id ïîñëåäíåãî ñîçäàííîãî ýëåìåíòà
   int               LastId(void)                                      const { return(m_last_id);                  }
   void              LastId(const int id)                                    { m_last_id=id;                       }
   //--- Ìåòîäû äëÿ ñîõðàíåíèÿ è ïîëó÷åíèÿ id àêòèâèðîâàííîãî ýëåìåíòà
   int               IdActivatedElement(void)                          const { return(m_id_activated_element);     }
   void              IdActivatedElement(const int id)                        { m_id_activated_element=id;          }
   //--- (1) Ïîëó÷åíèå è ñîõðàíåíèå èíäåêñà ïðåäûäóùåãî àêòèâíîãî îêíà
   int               PrevActiveWindowIndex(void)                       const { return(m_prev_active_window_index); }
   void              PrevActiveWindowIndex(const int index)                  { m_prev_active_window_index=index;   }
   //--- Òèï îêíà
   ENUM_WINDOW_TYPE  WindowType(void)                                  const { return(m_window_type);              }
   void              WindowType(const ENUM_WINDOW_TYPE flag)                 { m_window_type=flag;                 }
   //--- ßðëûê ïî óìîë÷àíèþ
   string            DefaultIcon(void);
   //--- (1) ïîëüçîâàòåëüñêèé ÿðëûê îêíà, (2) îãðàíè÷åíèå îáëàñòè çàõâàòà çàãîëîâêà
   void              IconFile(const string file_path)                        { m_icon_file=file_path;              }
   void              RightLimit(const int value)                             { m_right_limit=value;                }
   //--- (1) Èñïîëüçîâàòü êíîïêó ïîäñêàçîê, (2) ïðîâåðêà ðåæèìà ïîêàçà âñïëûâàþùèõ ïîäñêàçîê
   void              UseTooltipsButton(void)                                 { m_tooltips_button=true;             }
   bool              TooltipBmpState(void)                             const { return(m_button_tooltip.State());   }
   
   //--- Âîçìîæíîñòü ïåðåìåùåíèÿ îêíà
   bool              Movable(void)                                     const { return(m_movable);                  }
   void              Movable(const bool flag)                                { m_movable=flag;                     }
   //--- Ñòàòóñ ñâ¸ðíóòîãî îêíà
   bool              IsMinimized(void)                                 const { return(m_is_minimized);             }
   void              IsMinimized(const bool flag)                            { m_is_minimized=flag;                }
   //--- Ñòàòóñ çàáëîêèðîâàííîãî îêíà
   bool              IsLocked(void)                                    const { return(m_is_locked);                }
   void              IsLocked(const bool flag)                               { m_is_locked=flag;                   }
   //--- Ñâîéñòâà çàãîëîâêà
   void              CaptionText(const string text);
   string            CaptionText(void)                                 const { return(m_caption_text);             }
   void              CaptionHeight(const int height)                         { m_caption_height=height;            }
   int               CaptionHeight(void)                               const { return(m_caption_height);           }
   void              CaptionBgColor(const color clr)                         { m_caption_bg_color=clr;             }
   color             CaptionBgColor(void)                              const { return(m_caption_bg_color);         }
   void              CaptionBgColorOff(const color clr)                      { m_caption_bg_color_off=clr;         }
   void              CaptionBgColorHover(const color clr)                    { m_caption_bg_color_hover=clr;       }
   color             CaptionBgColorHover(void)                         const { return(m_caption_bg_color_hover);   }
   //--- Ñâîéñòâà îêíà
   void              WindowBgColor(const color clr)                          { m_bg_color=clr;                     }
   color             WindowBgColor(void)                               const { return(m_bg_color);                 }
   void              WindowBorderColor(const color clr)                      { m_border_color=clr;                 }
   color             WindowBorderColor(void)                           const { return(m_border_color);             }
   
   //--- Óñòàíîâêà ñîñòîÿíèÿ îêíà
   void              State(const bool flag);
   //--- Ðåæèì ñâîðà÷èâàíèÿ ïîäîêíà èíäèêàòîðà
   void              RollUpSubwindowMode(const bool flag,const bool height_mode);
   //--- Óïðàâëåíèå ðàçìåðàìè
   void              ChangeWindowWidth(const int width);
   void              ChangeSubwindowHeight(const int height);

   //--- Ïîëó÷åíèå ðàçìåðîâ ãðàôèêà
   void              SetWindowProperties(void);
   //--- Ïðåîáðàçóåò êîîðäèíàòó Y â îòíîñèòåëüíóþ
   int               YToRelative(const int y);
   //--- Ïðîâåðêà êóðñîðà â îáëàñòè çàãîëîâêà 
   bool              CursorInsideCaption(const int x,const int y);
   //--- Îáíóëåíèå ïåðåìåííûõ
   void              ZeroPanelVariables(void);

   //--- Ïðîâåðêà ñîñòîÿíèÿ ëåâîé êíîïêè ìûøè
   void              CheckMouseButtonState(const int x,const int y,const string state);
   //--- Ïðîâåðêà ôîêóñà ìûøè
   void              CheckMouseFocus(const int x,const int y,const int subwin);
   //--- Óñòàíîâêà ðåæèìà ãðàôèêà
   void              SetChartState(const int subwindow_number);
   //--- Îáíîâëåíèå êîîðäèíàò ôîðìû
   void              UpdateWindowXY(const int x,const int y);
   //--- Ïîëüçîâàòåëüñêèé ôëàã óïðàâëåíèÿ ñâîéñòâàìè ãðàôèêà
   void              CustomEventChartState(const bool state) { m_custom_event_chart_state=state; }

   //--- Çàêðûòèå ãëàâíîãî îêíà
   bool              CloseWindow(const string pressed_object);
   //--- Çàêðûòèå äèàëîãîâîãî îêíà
   void              CloseDialogBox(void);
   
   //--- Èçìåíåíèå ñîñòîÿíèÿ îêíà
   bool              ChangeWindowState(const string pressed_object);
   //--- Ìåòîäû äëÿ (1) ñâîðà÷èâàíèÿ è (2) ðàçâîðà÷èâàíèÿ îêíà
   void              RollUp(void);
   void              Unroll(void);
   //---
public:
   //--- Îáðàáîò÷èê ñîáûòèé ãðàôèêà
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Òàéìåð
   virtual void      OnEventTimer(void);
   //--- Ïåðåìåùåíèå ýëåìåíòà
   virtual void      Moving(const int x,const int y);
   //--- Ïîêàç, ñêðûòèå, ñáðîñ, óäàëåíèå
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- Óñòàíîâêà, ñáðîñ ïðèîðèòåòîâ íà íàæèòèå ëåâîé êíîïêè ìûøè
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- Ñáðîñèòü öâåò
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
//--- Ñîõðàíèì èìÿ êëàññà ýëåìåíòà â áàçîâîì êëàññå
   CElement::ClassName(CLASS_NAME);
//--- Óñòàíîâèì ñòðîãóþ ïîñëåäîâàòåëüíîñòü ïðèîðèòåòîâ
   m_bg_zorder      =0;
   m_caption_zorder =1;
   m_button_zorder  =2;
//--- Ïîëó÷èì ID òåêóùåãî ãðàôèêà
   m_chart.Attach();
//--- Ïîëó÷èì ðàçìåðû îêíà ãðàôèêà
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
//| Îáðàáîò÷èê ñîáûòèé ãðàôèêà                                       |
//+------------------------------------------------------------------+
void CWindow::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Îáðàáîòêà ñîáûòèÿ ïåðåìåùåíèÿ êóðñîðà
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      int      x      =(int)lparam; // Êîîðäèíàòà ïî îñè X
      int      y      =(int)dparam; // Êîîðäèíàòà ïî îñè Y
      int      subwin =WRONG_VALUE; // Íîìåð îêíà, â êîòîðîì íàõîäèòñÿ êóðñîð
      datetime time   =NULL;        // Âðåìÿ ñîîòâåòñòâóþùåå êîîðäèíàòå X
      double   level  =0.0;         // Óðîâåíü (öåíà) ñîîòâåòñòâóþùèé êîîðäèíàòå Y
      int      rel_y  =0;           // Äëÿ îïðåäåëåíèÿ îòíîñèòåëüíîé Y-êîîðäèíàòû
      //--- Ïîëó÷èì ìåñòîïîëîæåíèå êóðñîðà
      if(!::ChartXYToTimePrice(m_chart_id,x,y,subwin,time,level))
         return;
      //--- Ïîëó÷èì îòíîñèòåëüíóþ êîîðäèíàòó Y
      rel_y=YToRelative(y);
      //--- Ïðîâåðèì è çàïîìíèì ñîñòîÿíèå êíîïêè ìûøè
      CheckMouseButtonState(x,rel_y,sparam);
      //--- Ïðîâåðêà ôîêóñà ìûøè
      CheckMouseFocus(x,rel_y,subwin);
      //--- Óñòàíîâèì ñîñòîÿíèå ãðàôèêà
      SetChartState(subwin);
      //--- Âûéòè, åñëè ýòà ôîðìà çàáëîêèðîâàíà
      if(m_is_locked)
         return;
      //--- Åñëè óïðàâëåíèå ïåðåäàíî îêíó, îïðåäåëèì å¸ ïîëîæåíèå
      if(m_clamping_area_mouse==PRESSED_INSIDE_HEADER)
        {
         //--- Îáíîâëåíèå êîîðäèíàò îêíà
         UpdateWindowXY(x,rel_y);
        }
      //---
      return;
     }
//--- Îáðàáîòêà ñîáûòèÿ íàæàòèÿ íà îáúåêòå
   if(id==CHARTEVENT_OBJECT_CLICK)
     {

      CloseWindow(sparam);

      ChangeWindowState(sparam);
      return;
     }
//--- Ñîáûòèå èçìåíåíèÿ ñâîéñòâ ãðàôèêà
   if(id==CHARTEVENT_CHART_CHANGE)
     {

      if(m_clamping_area_mouse==NOT_PRESSED)
        {

         SetWindowProperties();

         UpdateWindowXY(m_x,m_y);
        }
      return;
     }
  }
//+------------------------------------------------------------------+
//| Òàéìåð                                                           |
//+------------------------------------------------------------------+
void CWindow::OnEventTimer(void)
  {
//--- Åñëè îêíî íå çàáëîêèðîâàíî
   if(!m_is_locked)
     {
      //--- Èçìåíåíèå öâåòà îáúåêòîâ ôîðìû
      ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò ôîðìó äëÿ ýëåìåíòîâ óïðàâëåíèÿ                           |
//+------------------------------------------------------------------+
bool CWindow::CreateWindow(const long chart_id,const int subwin,const string caption_text,const int x,const int y)
  {
   if(CElement::Id()==WRONG_VALUE)
     {
      ::Print(__FUNCTION__," > CWndContainer::AddWindow(CWindow &object)");
      return(false);
     }
//--- Èíèöèàëèçàöèÿ ïåðåìåííûõ
   m_chart_id       =chart_id;
   m_subwin         =subwin;
   m_caption_text   =caption_text;
   m_x              =x;
   m_y              =y;
   m_bg_full_height =m_y_size;
//--- Ñîçäàíèå âñåõ îáúåêòîâ îêíà
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
//--- Åñëè ýòà ïðîãðàììà èíäèêàòîð
   if(CElement::ProgramType()==PROGRAM_INDICATOR)
     {
      //--- Åñëè óñòàíîâëåí ðåæèì ôèêñèðîâàííîé âûñîòû ïîäîêíà
      if(m_height_subwindow_mode)
        {
         m_subwindow_height=m_bg_full_height+3;
         ChangeSubwindowHeight(m_subwindow_height);
        }
     }
//--- Ñïðÿòàòü îêíî, åñëè îíî äèàëîãîâîå
   if(m_window_type==W_DIALOG)
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò ôîí îêíà                                                 |
//+------------------------------------------------------------------+
bool CWindow::CreateBackground(void)
  {
//--- Ôîðìèðîâàíèå èìåíè îáúåêòà
   string name=CElement::ProgramName()+"_window_bg_"+(string)CElement::Id();
//--- Ðàçìåð îêíà çàâèñèò îò ñîñòîÿíèÿ (ñâ¸ðíóòî/ðàçâ¸ðíóòî)
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
//--- Óñòàíîâèì ôîí îêíà
   if(!m_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,y_size))
      return(false);
//--- Óñòàíîâèì ñâîéñòâà
   m_bg.BackColor(m_bg_color);
   m_bg.Color(m_border_color);
   m_bg.BorderType(BORDER_FLAT);
   m_bg.Corner(m_corner);
   m_bg.Selectable(false);
   m_bg.Z_Order(m_bg_zorder);
   m_bg.Tooltip("\n");
//--- Ñîõðàíèì óêàçàòåëü îáúåêòà
   CElement::AddToArray(m_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò çàãîëîâîê îêíà                                           |
//+------------------------------------------------------------------+
bool CWindow::CreateCaption(void)
  {
//--- Ôîðìèðîâàíèå èìåíè îáúåêòà  
   string name=CElement::ProgramName()+"_window_caption_"+(string)CElement::Id();
//--- Óñòàíîâèì çàãîëîâîê îêíà
   if(!m_caption_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_caption_height))
      return(false);
//--- Óñòàíîâèì ñâîéñòâà
   m_caption_bg.BackColor(m_caption_bg_color);
   m_caption_bg.Color(m_border_color);
   m_caption_bg.BorderType(BORDER_FLAT);
   m_caption_bg.Corner(m_corner);
   m_caption_bg.Selectable(false);
   m_caption_bg.Z_Order(m_caption_zorder);
   m_caption_bg.Tooltip("\n");
//--- Ñîõðàíèì êîîðäèíàòû
   m_caption_bg.X(m_x);
   m_caption_bg.Y(m_y);
//--- Ñîõðàíèì ðàçìåðû (â îáúåêòå)
   m_caption_bg.XSize(m_caption_bg.X_Size());
   m_caption_bg.YSize(m_caption_bg.Y_Size());
//--- Èíèöèàëèçàöèÿ ìàññèâà ãðàäèåíòà
   CElement::InitColorArray(m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
//--- Ñîõðàíèì óêàçàòåëü îáúåêòà
   CElement::AddToArray(m_caption_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò ÿðëûê ïðîãðàììû                                          |
//+------------------------------------------------------------------+
//--- Êàðòèíêè (ïî óìîë÷àíèþ) ñèìâîëèçèðóþùèå òèï ïðîãðàììû
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
//---
bool CWindow::CreateIcon(void)
  {
   string name=CElement::ProgramName()+"_window_icon_"+(string)CElement::Id();
//--- Êîîðäèíàòû îáúåêòà
   int x=m_x+5;
   int y=m_y+2;
//--- Óñòàíîâèì ÿðëûê îêíà
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- ßðëûê ïî óìîë÷àíèþ, åñëè íå îïðåäåë¸í ïîëüçîâàòåëåì
   if(m_icon_file=="")
      m_icon_file=DefaultIcon();
//--- Óñòàíîâèì ñâîéñòâà
   m_icon.BmpFileOn("::"+m_icon_file);
   m_icon.BmpFileOff("::"+m_icon_file);
   m_icon.Corner(m_corner);
   m_icon.Selectable(false);
   m_icon.Z_Order(m_button_zorder);
   m_icon.Tooltip("\n");
//--- Ñîõðàíèì êîîðäèíàòû
   m_icon.X(x);
   m_icon.Y(y);
//--- Îòñòóïû îò êðàéíåé òî÷êè
   m_icon.XGap(x-m_x);
   m_icon.YGap(y-m_y);
//--- Ñîõðàíèì ðàçìåðû
   m_icon.XSize(m_icon.X_Size());
   m_icon.YSize(m_icon.Y_Size());
//--- Ñîõðàíèì óêàçàòåëü îáúåêòà
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò òåêñòîâóþ ìåòêó çàãîëîâêà                                |
//+------------------------------------------------------------------+
bool CWindow::CreateLabel(void)
  {
   string name=CElement::ProgramName()+"_window_label_"+(string)CElement::Id();
//--- Êîîðäèíàòû îáúåêòà
   int x=m_x+24;
   int y=m_y+4;
//--- Óñòàíîâèì òåêñòîâóþ ìåòêó
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Óñòàíîâèì ñâîéñòâà
   m_label.Description(m_caption_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(clrBlack);
   m_label.Corner(m_corner);
   m_label.Selectable(false);
   m_label.Z_Order(m_button_zorder);
   m_label.Tooltip("\n");
//--- Ñîõðàíèì êîîðäèíàòû
   m_label.X(x);
   m_label.Y(y);
//--- Îòñòóïû îò êðàéíåé òî÷êè
   m_label.XGap(x-m_x);
   m_label.YGap(y-m_y);
//--- Ñîõðàíèì ðàçìåðû
   m_label.XSize(m_label.X_Size());
   m_label.YSize(m_label.Y_Size());
//--- Ñîõðàíèì óêàçàòåëü îáúåêòà
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò êíîïêó çàêðûòèÿ ïðîãðàììû                                |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_red.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_black.bmp"
//---
bool CWindow::CreateButtonClose(void)
  {

   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);

   string name=CElement::ProgramName()+"_window_close_"+(string)CElement::Id();

   int x=m_x+m_x_size-CLOSE_BUTTON_OFFSET;
   int y=m_y+2;

   m_right_limit+=20;

   if(!m_button_close.Create(m_chart_id,name,m_subwin,x,y))
      return(false);

   m_button_close.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Close_red.bmp");
   m_button_close.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Close_black.bmp");
   m_button_close.Corner(m_corner);
   m_button_close.Selectable(false);
   m_button_close.Z_Order(m_button_zorder);
   m_button_close.Tooltip("Close");

   m_button_close.X(x);
   m_button_close.Y(y);

   m_button_close.XGap(x-m_x);
   m_button_close.YGap(y-m_y);

   m_button_close.XSize(m_button_close.X_Size());
   m_button_close.YSize(m_button_close.Y_Size());

   CElement::AddToArray(m_button_close);
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò êíîïêó äëÿ ñâîðà÷èâàíèÿ îêíà                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp"
//---
bool CWindow::CreateButtonRollUp(void)
  {
//--- Åñëè òèï ïðîãðàììû "ñêðèïò", âûéäåì
   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);
//--- Ýòà êíîïêà íå íóæíà, åñëè îêíî äèàëîãîâîå
   if(m_window_type==W_DIALOG)
      return(true);
//--- Ôîðìèðîâàíèå èìåíè îáúåêòà
   string name=CElement::ProgramName()+"_window_rollup_"+(string)CElement::Id();
//--- Êîîðäèíàòû îáúåêòà
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- Óâåëè÷èì îáëàñòü çàõâàòà, åñëè îêíî ðàçâ¸ðíóòî
   if(!m_is_minimized)
      m_right_limit+=20;
//--- Óñòàíîâèì êíîïêó
   if(!m_button_rollup.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Óñòàíîâèì ñâîéñòâà
   m_button_rollup.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp");
   m_button_rollup.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp");
   m_button_rollup.Corner(m_corner);
   m_button_rollup.Selectable(false);
   m_button_rollup.Z_Order(m_button_zorder);
   m_button_rollup.Tooltip("Roll Up");
//--- Ñîõðàíèì êîîðäèíàòû
   m_button_rollup.X(x);
   m_button_rollup.Y(y);
//--- Îòñòóïû îò êðàéíåé òî÷êè
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.YGap(y-m_y);
//--- Ñîõðàíèì ðàçìåðû (â îáúåêòå)
   m_button_rollup.XSize(m_button_rollup.X_Size());
   m_button_rollup.YSize(m_button_rollup.Y_Size());
//--- Ñêðûòü îáúåêò
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
//--- Äîáàâèì îáúåêòû â ìàññèâ ãðóïïû
   CElement::AddToArray(m_button_rollup);
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò êíîïêó äëÿ ðàçâîðà÷èâàíèÿ îêíà                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp"
//---
bool CWindow::CreateButtonUnroll(void)
  {
//--- Åñëè òèï ïðîãðàììû "ñêðèïò", âûéäåì
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- Ýòà êíîïêà íå íóæíà, åñëè îêíî äèàëîãîâîå
   if(m_window_type==W_DIALOG)
      return(true);
//--- Ôîðìèðîâàíèå èìåíè îáúåêòà
   string name=CElement::ProgramName()+"_window_unroll_"+(string)CElement::Id();
//--- Êîîðäèíàòû îáúåêòà
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- Óâåëè÷èì îáëàñòü çàõâàòà, åñëè îêíî ñâ¸ðíóòî
   if(m_is_minimized)
      m_right_limit+=20;
//--- Óñòàíîâèì êíîïêó
   if(!m_button_unroll.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Óñòàíîâèì ñâîéñòâà
   m_button_unroll.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp");
   m_button_unroll.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp");
   m_button_unroll.Corner(m_corner);
   m_button_unroll.Selectable(false);
   m_button_unroll.Z_Order(m_button_zorder);
   m_button_unroll.Tooltip("Unroll");
//--- Ñîõðàíèì êîîðäèíàòû
   m_button_unroll.X(x);
   m_button_unroll.Y(y);
//--- Îòñòóïû îò êðàéíåé òî÷êè
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.YGap(y-m_y);
//--- Ñîõðàíèì ðàçìåðû (â îáúåêòå)
   m_button_unroll.XSize(m_button_unroll.X_Size());
   m_button_unroll.YSize(m_button_unroll.Y_Size());
//--- Äîáàâèì îáúåêòû â ìàññèâ ãðóïïû
   CElement::AddToArray(m_button_unroll);
//--- Ñêðûòü îáúåêò
   if(!m_is_minimized)
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Ñîçäà¸ò êíîïêó ïîäñêàçîê                                         |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_light.bmp"
//---
bool CWindow::CreateButtonTooltip(void)
  {
//--- Åñëè òèï ïðîãðàììû "ñêðèïò", âûéäåì
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- Ýòà êíîïêà íå íóæíà, åñëè îêíî äèàëîãîâîå
   if(m_window_type==W_DIALOG)
      return(true);
//--- Âûéäåì, åñëè ýòà êíîïêà íå íóæíà
   if(!m_tooltips_button)
      return(true);
//--- Ôîðìèðîâàíèå èìåíè îáúåêòà
   string name=CElement::ProgramName()+"_window_tooltip_"+(string)CElement::Id();
//--- Êîîðäèíàòû îáúåêòà
   int x=m_x+m_x_size-TOOLTIP_BUTTON_OFFSET;
   int y=m_y+2;
//--- Óâåëè÷èì îáëàñòü çàõâàòà
   m_right_limit+=20;
//--- Óñòàíîâèì êíîïêó
   if(!m_button_tooltip.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Óñòàíîâèì ñâîéñòâà
   m_button_tooltip.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Help_light.bmp");
   m_button_tooltip.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp");
   m_button_tooltip.Corner(m_corner);
   m_button_tooltip.Selectable(false);
   m_button_tooltip.Z_Order(m_button_zorder);
   m_button_tooltip.Tooltip("Tooltips");
//--- Ñîõðàíèì êîîðäèíàòû
   m_button_tooltip.X(x);
   m_button_tooltip.Y(y);
//--- Îòñòóïû îò êðàéíåé òî÷êè
   m_button_tooltip.XGap(x-m_x);
   m_button_tooltip.YGap(y-m_y);
//--- Ñîõðàíèì ðàçìåðû (â îáúåêòå)
   m_button_tooltip.XSize(m_button_tooltip.X_Size());
   m_button_tooltip.YSize(m_button_tooltip.Y_Size());
//--- Äîáàâèì îáúåêòû â ìàññèâ ãðóïïû
   CElement::AddToArray(m_button_tooltip);
   return(true);
  }
//+------------------------------------------------------------------+
//| Èçìåíÿåò òåêò çàãîëîâêà                                          |
//+------------------------------------------------------------------+
void CWindow::CaptionText(const string text)
  {
   m_caption_text=text;
   m_label.Description(text);
  }
//+------------------------------------------------------------------+
//| Îïðåäåëåíèå ÿðëûêà ïî óìîë÷àíèþ                                  |
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
//| Ðåæèì ñâîðà÷èâàíèÿ ïîäîêíà èíäèêàòîðà                            |
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
//| Èçìåíÿåò âûñîòó ïîäîêíà èíäèêàòîðà                               |
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
//| Èçìåíÿåò øèðèíó îêíà                                             |
//+------------------------------------------------------------------+
void CWindow::ChangeWindowWidth(const int width)
  {
//--- Åñëè øèðèíà íå èçìåíèëàñü, âûéäåì
   if(width==m_bg.XSize())
      return;
//--- Îáíîâèì øèðèíó äëÿ ôîíà è çàãîëîâêà
   CElement::XSize(width);
   m_bg.XSize(width);
   m_bg.X_Size(width);
   m_caption_bg.XSize(width);
   m_caption_bg.X_Size(width);
//--- Îáíîâèì êîîðäèíàòû è îòñòóïû äëÿ âñåõ êíîïîê:
//    Êíîïêà çàêðûòèÿ
   int x=CElement::X2()-CLOSE_BUTTON_OFFSET;
   m_button_close.X(x);
   m_button_close.XGap(x-m_x);
   m_button_close.X_Distance(x);
//--- Êíîïêà ðàçâîðà÷èâàíèÿ
   x=CElement::X2()-ROLL_BUTTON_OFFSET;
   m_button_unroll.X(x);
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.X_Distance(x);
//--- Êíîïêà ñâîðà÷èâàíèÿ
   m_button_rollup.X(x);
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.X_Distance(x);
//--- Êíîïêà âñïëûâàþùèõ ïîäñêàçîê (åñëè âêëþ÷åíà)
   if(m_tooltips_button)
     {
      x=CElement::X2()-TOOLTIP_BUTTON_OFFSET;
      m_button_tooltip.X(x);
      m_button_tooltip.XGap(x-m_x);
      m_button_tooltip.X_Distance(x);
     }
  }
//+------------------------------------------------------------------+
//| Ïîëó÷åíèå ðàçìåðîâ ãðàôèêà                                       |
//+------------------------------------------------------------------+
void CWindow::SetWindowProperties(void)
  {
//--- Ïîëó÷èì øèðèíó è âûñîòó îêíà ãðàôèêà
   m_chart_width  =m_chart.WidthInPixels();
   m_chart_height =m_chart.HeightInPixels(m_subwin);
  }
//+------------------------------------------------------------------+
//| Ïðåîáðàçóåò êîîðäèíàòó Y â îòíîñèòåëüíóþ                         |
//+------------------------------------------------------------------+
int CWindow::YToRelative(const int y)
  {
//--- Ïîëó÷èì ðàññòîÿíèå îò âåðõà ãðàôèêà äî ïîäîêíà èíäèêàòîðà
   int chart_y_distance=m_chart.SubwindowY(m_subwin);
//--- Ïðåîáðàçóåì êîîðäèíàòó Y â îòíîñèòåëüíóþ
   return(y-chart_y_distance);
  }
//+------------------------------------------------------------------+
//| Ïðîâåðêà ïîëîæåíèÿ êóðñîðà â îáëàñòè çàãîëîâêà îêíà              |
//+------------------------------------------------------------------+
bool CWindow::CursorInsideCaption(const int x,const int y)
  {
   return(x>m_x && x<X2()-m_right_limit && y>m_y && y<m_caption_bg.Y2());
  }
//+------------------------------------------------------------------+
//| Îáíóëåíèå ïåðåìåííûõ ñâÿçàííûõ ñ ïåðåìåùåíèåì îêíà è             |
//| ñîñòîÿíèåì ëåâîé êíîïêè ìûøè                                     |
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
//| Ïðîâåðÿåò ñîñòîÿíèå êíîïêè ìûøè                                  |
//+------------------------------------------------------------------+
void CWindow::CheckMouseButtonState(const int x,const int y,const string state)
  {
//--- Åñëè êíîïêà îòæàòà
   if(state=="0")
     {
      //--- Îáíóëèì ïåðåìåííûå
      ZeroPanelVariables();
      return;
     }
//--- Åñëè êíîïêà íàæàòà
   if(state=="1")
     {
      //--- Âûéäåì, åñëè ñîñòîÿíèå óæå çàôèêñèðîâàíî
      if(m_clamping_area_mouse!=NOT_PRESSED)
         return;
      //--- Âíå îáëàñòè ïàíåëè
      if(!CElement::MouseFocus())
         m_clamping_area_mouse=PRESSED_OUTSIDE;
      //--- Â îáëàñòè ïàíåëè
      else
        {
         //--- Åñëè âíóòðè çàãîëîâêà
         if(CursorInsideCaption(x,y))
           {
            m_clamping_area_mouse=PRESSED_INSIDE_HEADER;
            return;
           }
         //--- Åñëè â îáëàñòè îêíà
         m_clamping_area_mouse=PRESSED_INSIDE_WINDOW;
        }
     }
  }
//+------------------------------------------------------------------+
//| Ïðîâåðêà ôîêóñà ìûøè                                             |
//+------------------------------------------------------------------+
void CWindow::CheckMouseFocus(const int x,const int y,const int subwin)
  {
//--- Åñëè êóðñîð â çîíå îêíà ïðîãðàììû
   if(subwin==m_subwin)
     {
      //--- Åñëè ñåé÷àñ íå â ðåæèìå ïåðåìåùåíèÿ ôîðìû
      if(m_clamping_area_mouse!=PRESSED_INSIDE_HEADER)
        {
         //--- Ïðîâåðèì ìåñòîïîëîæåíèå êóðñîðà
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
//| Óñòàíîâèì ñîñòîÿíèå ãðàôèêà                                      |
//+------------------------------------------------------------------+
void CWindow::SetChartState(const int subwindow_number)
  {
//--- Åñëè (êóðñîð â îáëàñòè ïàíåëè è êíîïêà ìûøè îòæàòà) èëè
//    êíîïêà ìûøè áûëà íàæàòà âíóòðè îáëàñòè ôîðìû èëè çàãîëîâêà
   if((CElement::MouseFocus() && m_clamping_area_mouse==NOT_PRESSED) || 
      m_clamping_area_mouse==PRESSED_INSIDE_WINDOW ||
      m_clamping_area_mouse==PRESSED_INSIDE_HEADER ||
      m_custom_event_chart_state)
     {
      //--- Îòêëþ÷èì ñêðîëë è óïðàâëåíèå òîðãîâûìè óðîâíÿìè
      m_chart.MouseScroll(false);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,false);
     }
//--- Âêëþ÷èì óïðàâëåíèå, åñëè êóðñîð âíå çîíû îêíà
   else
     {
      m_chart.MouseScroll(true);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
     }
  }
//+------------------------------------------------------------------+
//| Îáíîâëåíèå êîîðäèíàò îêíà                                        |
//+------------------------------------------------------------------+
void CWindow::UpdateWindowXY(const int x,const int y)
  {
//--- Åñëè óñòàíîâëåí ðåæèì ôèêñèðîâàííîé ôîðìû
   if(!m_movable)
      return;
//---  
   int new_x_point =0; // Íîâàÿ êîîðäèíàòà X
   int new_y_point =0; // Íîâàÿ êîîðäèíàòà Y
//--- Ëèìèòû
   int limit_top    =0;
   int limit_left   =0;
   int limit_bottom =0;
   int limit_right  =0;
//--- Åñëè êíîïêà ìûøè íàæàòà
   if((bool)m_clamping_area_mouse)
     {
      //--- Çàïîìíèì òåêóùèå êîîðäèíàòû XY êóðñîðà
      if(m_prev_y==0 || m_prev_x==0)
        {
         m_prev_y=y;
         m_prev_x=x;
        }
      //--- Çàïîìíèì ðàññòîÿíèå îò êðàéíåé òî÷êè ôîðìû äî êóðñîðà
      if(m_size_fixing_y==0 || m_size_fixing_x==0)
        {
         m_size_fixing_y=m_y-m_prev_y;
         m_size_fixing_x=m_x-m_prev_x;
        }
     }
//--- Óñòàíîâèì ëèìèòû
   limit_top    =y-::fabs(m_size_fixing_y);
   limit_left   =x-::fabs(m_size_fixing_x);
   limit_bottom =m_y+m_caption_height;
   limit_right  =m_x+m_x_size;
//--- Åñëè íå âûõîäèì çà ïðåäåëû ãðàôèêà âíèç/ââåðõ/âïðàâî/âëåâî
   if(limit_bottom<m_chart_height && limit_top>=0 && 
      limit_right<m_chart_width && limit_left>=0)
     {
      new_y_point =y+m_size_fixing_y;
      new_x_point =x+m_size_fixing_x;
     }
//--- Åñëè âûøëè èç ãðàíèö ãðàôèêà
   else
     {
      if(limit_bottom>m_chart_height) // > âíèç
        {
         new_y_point =m_chart_height-m_caption_height;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_top<0) // > ââåðõ
        {
         new_y_point =0;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_right>m_chart_width) // > âïðàâî
        {
         new_x_point =m_chart_width-m_x_size;
         new_y_point =y+m_size_fixing_y;
        }
      if(limit_left<0) // > âëåâî
        {
         new_x_point =0;
         new_y_point =y+m_size_fixing_y;
        }
     }
//--- Îáíîâèì êîîðäèíàòû, åñëè áûëî ïåðåìåùåíèå
   if(new_x_point>0 || new_y_point>0)
     {
      //--- Ñêîððåêòèðóåì êîîðäèíàòû ôîðìû
      m_x =(new_x_point<=0)? 1 : new_x_point;
      m_y =(new_y_point<=0)? 1 : new_y_point;
      //---
      if(new_x_point>0)
         m_x=(m_x>m_chart_width-m_x_size-1) ? m_chart_width-m_x_size-1 : m_x;
      if(new_y_point>0)
         m_y=(m_y>m_chart_height-m_caption_height-1) ? m_chart_height-m_caption_height-2 : m_y;
      //--- Îáíóëèì òî÷êè ôèêñàöèè
      m_prev_x=0;
      m_prev_y=0;
     }
  }
//+------------------------------------------------------------------+
//| Óñòàíàâëèâàåò ñîñòîÿíèå îêíà                                     |
//+------------------------------------------------------------------+
void CWindow::State(const bool flag)
  {
//--- Åñëè íóæíî çàáëîêèðîâàòü îêíî
   if(!flag)
     {
      //--- Óñòàíîâèì ñòàòóñ
      m_is_locked=true;
      //--- Óñòàíîâèì öâåò çàãîëîâêà è ðàìîê îêíà
      m_bg.Color(m_caption_bg_color_off);
      m_caption_bg.Color(m_caption_bg_color_off);
      m_caption_bg.BackColor(m_caption_bg_color_off);
      //--- Ñèãíàë íà ñáðîñ öâåòà. Ñáðîñ áóäåò è äëÿ äðóãèõ ýëåìåíòîâ.
      ::EventChartCustom(m_chart_id,ON_RESET_WINDOW_COLORS,(long)CElement::Id(),0,"");
     }
//--- Åñëè íóæíî ðàçáëîêèðîâàòü îêíî
   else
     {
      //--- Óñòàíîâèì ñòàòóñ
      m_is_locked=false;
      //--- Óñòàíîâèì öâåò çàãîëîâêà
      m_bg.Color(m_border_color);
      m_caption_bg.Color(m_border_color);
      m_caption_bg.BackColor(m_caption_bg_color);
      //--- Ñáðîñ ôîêóñà
      CElement::MouseFocus(false);
     }
  }
//+------------------------------------------------------------------+
//| Ñáðîñ öâåòà îêíà                                                 |
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
//| Ïåðåìåùåíèå îêíà                                                 |
//+------------------------------------------------------------------+
void CWindow::Moving(const int x,const int y)
  {
//--- Ñîõðàíåíèå êîîðäèíàò â ïåðåìåííûõ
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
//--- Îáíîâëåíèå êîîðäèíàò ãðàôè÷åñêèõ îáúåêòîâ
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
//| Óäàëåíèå                                                         |
//+------------------------------------------------------------------+
void CWindow::Delete(void)
  {
//--- Îáíóëåíèå ïåðåìåííûõ
   m_right_limit=0;
//--- Óäàëåíèå îáúåêòîâ
   m_bg.Delete();
   m_caption_bg.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_button_close.Delete();
   m_button_rollup.Delete();
   m_button_unroll.Delete();
   m_button_tooltip.Delete();
//--- Îñâîáîæäåíèå ìàññèâà îáúåêòîâ
   CElement::FreeObjectsArray();
//--- Îáíóëåíèå ôîêóñà ýëåìåíòà
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Èçìåíåíèå öâåòà îáúåêòà ïðè íàâåäåíèè êóðñîðà                    |
//+------------------------------------------------------------------+
void CWindow::ChangeObjectsColor(void)
  {
//--- Èçìåíåíèå êàðòèíêè â êíîïêàõ
   m_button_close.State(m_button_close.MouseFocus());
   m_button_rollup.State(m_button_rollup.MouseFocus());
   m_button_unroll.State(m_button_unroll.MouseFocus());
//--- Èçìåíåíèå öâåòà â çàãîëîâêå
   CElement::ChangeObjectColor(m_caption_bg.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,
                               m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
  }
//+------------------------------------------------------------------+
//| Ïîêàçûâàåò îêíî                                                  |
//+------------------------------------------------------------------+
void CWindow::Show(void)
  {
//--- Ñäåëàòü âèäèìûìè âñå îáúåêòû
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Ñîñòîÿíèå âèäèìîñòè
   CElement::IsVisible(true);
//--- Îáíóëåíèå ôîêóñà
   CElement::MouseFocus(false);
   m_button_close.MouseFocus(false);
   m_button_close.State(false);
//--- Îòïðàâèòü ñîîáùåíèå îá ýòîì
   ::EventChartCustom(m_chart_id,ON_OPEN_DIALOG_BOX,(long)CElement::Id(),0,m_program_name);
  }
//+------------------------------------------------------------------+
//| Ñêðûâàåò îêíî                                                    |
//+------------------------------------------------------------------+
void CWindow::Hide(void)
  {
//--- Ñêðûòü âñå îáúåêòû
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Ñîñòîÿíèå âèäèìîñòè
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Ïåðåðèñîâêà âñåõ îáúåêòîâ îêíà                                   |
//+------------------------------------------------------------------+
void CWindow::Reset(void)
  {
//--- Ñêðûòü âñå îáúåêòû ôîðìû
   Hide();
//--- Îòîáðàçèòü â ïîñëåäîâàòåëüíîñòè èõ ñîçäàíèÿ
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Â çàâèñèìîñòè îò ðåæèìà îòîáðàçèòü íóæíóþ êíîïêó
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   else
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//--- Ñîñòîÿíèå âèäèìîñòè
   CElement::IsVisible(true);
//--- Ñáðîñ ôîêóñà
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Óñòàíîâêà ïðèîðèòåòîâ                                            |
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
//| Ñáðîñ ïðèîðèòåòîâ                                                |
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
//| Çàêðûòèå äèàëîãîâîãî îêíà èëè ïðîãðàììû                          |
//+------------------------------------------------------------------+
bool CWindow::CloseWindow(const string pressed_object)
  {

   if(pressed_object!=m_button_close.Name())
      return(false);

   if(m_window_type==W_MAIN)
     {

      if(CElement::ProgramType()==PROGRAM_EXPERT)
        {
         string text="Are you sure to close this application?";

         int mb_res=::MessageBox(text,NULL,MB_YESNO|MB_ICONQUESTION);

         if(mb_res==IDYES)
           {
            ::Print(__FUNCTION__," > Ïðîãðàììà áûëà óäàëåíà ñ ãðàôèêà ïî Âàøåìó ðåøåíèþ!");

            ::ExpertRemove();
            return(true);
           }
        }

      else if(CElement::ProgramType()==PROGRAM_INDICATOR)
        {

         if(::ChartIndicatorDelete(m_chart_id,m_subwin,CElement::ProgramName()))
           {
            ::Print(__FUNCTION__," > ChartIndicatorDelete!");
            return(true);
           }
        }
     }

   else if(m_window_type==W_DIALOG)
     {

      CloseDialogBox();
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Çàêðûòèå äèàëîãîâîãî îêíà                                        |
//+------------------------------------------------------------------+
void CWindow::CloseDialogBox(void)
  {
//--- Ñîñòîÿíèå âèäèìîñòè
   CElement::IsVisible(false);
//--- Îòïðàâèòü ñîîáùåíèå îá ýòîì
   ::EventChartCustom(m_chart_id,ON_CLOSE_DIALOG_BOX,CElement::Id(),m_prev_active_window_index,m_caption_text);
  }
//+------------------------------------------------------------------+
//| Ïðîâåðêà íà ñîáûòèÿ ñâîðà÷èâàíèÿ/ðàçâîðà÷èâàíèÿ îêíà             |
//+------------------------------------------------------------------+
bool CWindow::ChangeWindowState(const string pressed_object)
  {
//--- Åñëè áûëà íàæàòà êíîïêà "Ñâåðíóòü îêíî"
   if(pressed_object==m_button_rollup.Name())
     {
      RollUp();
      return(true);
     }
//--- Åñëè áûëà íàæàòà êíîïêà "Ðàçâåðíóòü îêíî"
   if(pressed_object==m_button_unroll.Name())
     {
      Unroll();
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Ñâîðà÷èâàåò îêíî                                                 |
//+------------------------------------------------------------------+
void CWindow::RollUp(void)
  {
//--- Çàìåíèòü êíîïêó
   m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   m_button_unroll.Timeframes(OBJ_ALL_PERIODS);
//--- Óñòàíîâèòü è çàïîìíèòü ðàçìåð
   m_bg.Y_Size(m_caption_height);
   CElement::YSize(m_caption_height);
//--- Îòêëþ÷èòü êíîïêó
   m_button_unroll.MouseFocus(false);
   m_button_unroll.State(false);
//--- Ñîñòîÿíèå ôîðìû "Ñâ¸ðíóòî"
   m_is_minimized=true;
//--- Åñëè ýòî èíäèêàòîð â ïîäîêíå ñ ôèêñèðîâàííîé âûñîòîé è ñ ðåæèìîì ñâîðà÷èâàíèÿ ïîäîêíà,
//    óñòàíîâèì ðàçìåð äëÿ ïîäîêíà èíäèêàòîðà
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_caption_height+3);
//--- Îòïðàâèì ñîîáùåíèå îá ýòîì
   ::EventChartCustom(m_chart_id,ON_WINDOW_ROLLUP,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
//| Ðàçâîðà÷èâàåò îêíî                                               |
//+------------------------------------------------------------------+
void CWindow::Unroll(void)
  {
//--- Çàìåíèòü êíîïêó
   m_button_unroll.Timeframes(OBJ_NO_PERIODS);
   m_button_rollup.Timeframes(OBJ_ALL_PERIODS);
//--- Óñòàíîâèòü è çàïîìíèòü ðàçìåð
   m_bg.Y_Size(m_bg_full_height);
   CElement::YSize(m_bg_full_height);
//--- Îòêëþ÷èòü êíîïêó
   m_button_rollup.MouseFocus(false);
   m_button_rollup.State(false);
//--- Ñîñòîÿíèå ôîðìû "Ðàçâ¸ðíóòî"
   m_is_minimized=false;
//--- Åñëè ýòî èíäèêàòîð â ïîäîêíå ñ ôèêñèðîâàííîé âûñîòîé è ñ ðåæèìîì ñâîðà÷èâàíèÿ ïîäîêíà,
//    óñòàíîâèì ðàçìåð äëÿ ïîäîêíà èíäèêàòîðà
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_subwindow_height);
//--- Îòïðàâèì ñîîáùåíèå îá ýòîì
   ::EventChartCustom(m_chart_id,ON_WINDOW_UNROLL,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
