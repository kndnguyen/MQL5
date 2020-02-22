//+------------------------------------------------------------------+
//|                                                      Scrolls.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//--- Список классов в файле для быстрого перехода (Alt+G)
class CScroll;
class CScrollV;
class CScrollH;
//+------------------------------------------------------------------+
//| Базовый класс для создания полосы прокрутки                      |
//+------------------------------------------------------------------+
class CScroll : public CElement
  {
protected:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания полосы прокрутки
   CRectLabel        m_area;
   CRectLabel        m_bg;
   CBmpLabel         m_inc;
   CBmpLabel         m_dec;
   CRectLabel        m_thumb;
   //--- Свойства общей площади полосы прокрутки
   int               m_area_width;
   int               m_area_length;
   color             m_area_color;
   color             m_area_border_color;
   //--- Свойства фона под ползунком
   int               m_bg_length;
   color             m_bg_border_color;
   //--- Картинки для кнопок
   string            m_inc_file_on;
   string            m_inc_file_off;
   string            m_dec_file_on;
   string            m_dec_file_off;
   //--- Цвета ползунка в разных состояниях
   color             m_thumb_color;
   color             m_thumb_color_hover;
   color             m_thumb_color_pressed;
   color             m_thumb_border_color;
   color             m_thumb_border_color_hover;
   color             m_thumb_border_color_pressed;
   //--- (1) Общее количество пунктов и (2) видимое
   int               m_items_total;
   int               m_visible_items_total;
   //--- (1) Ширина ползунка, (2) длина ползунка и (3) его минимальная длина
   int               m_thumb_width;
   int               m_thumb_length;
   int               m_thumb_min_length;
   //--- (1) Размер шага ползунка и (2) кол-во шагов
   double            m_thumb_step_size;
   double            m_thumb_steps_total;
   //--- Приоритеты на нажатие левой кнопкой мыши
   int               m_area_zorder;
   int               m_bg_zorder;
   int               m_arrow_zorder;
   int               m_thumb_zorder;
   //--- Переменные связанные с перемещением ползунка
   bool              m_scroll_state;
   int               m_thumb_size_fixing;
   int               m_thumb_point_fixing;
   //--- Текущая позиция ползунка
   int               m_current_pos;
   //--- Для определения области зажатия левой кнопки мыши
   ENUM_THUMB_MOUSE_STATE m_clamping_area_mouse;
   //---
public:
                     CScroll(void);
                    ~CScroll(void);
   //--- Методы для создания полосы прокрутки
   bool              CreateScroll(const long chart_id,const int subwin,const int x,const int y,const int items_total,const int visible_items_total);
   //---
private:
   bool              CreateArea(void);
   bool              CreateBg(void);
   bool              CreateInc(void);
   bool              CreateDec(void);
   bool              CreateThumb(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) ширина ползунка
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);       }
   void              ScrollWidth(const int width)             { m_area_width=width;               }
   int               ScrollWidth(void)                  const { return(m_area_width);             }
   //--- (1) Цвет фона, (2) рамки фона и (3) внутренней рамки фона
   void              AreaColor(const color clr)               { m_area_color=clr;                 }
   void              AreaBorderColor(const color clr)         { m_area_border_color=clr;          }
   void              BgBorderColor(const color clr)           { m_bg_border_color=clr;            }
   //--- Установка картинок для кнопок
   void              IncFileOn(const string file_path)        { m_inc_file_on=file_path;          }
   void              IncFileOff(const string file_path)       { m_inc_file_off=file_path;         }
   void              DecFileOn(const string file_path)        { m_dec_file_on=file_path;          }
   void              DecFileOff(const string file_path)       { m_dec_file_off=file_path;         }
   //--- (1) Цвета фона ползунка и (2) рамки фона ползунка
   void              ThumbColor(const color clr)              { m_thumb_border_color=clr;         }
   void              ThumbColorHover(const color clr)         { m_thumb_border_color_hover=clr;   }
   void              ThumbColorPressed(const color clr)       { m_thumb_border_color_pressed=clr; }
   void              ThumbBorderColor(const color clr)        { m_thumb_border_color=clr;         }
   void              ThumbBorderColorHover(const color clr)   { m_thumb_border_color_hover=clr;   }
   void              ThumbBorderColorPressed(const color clr) { m_thumb_border_color_pressed=clr; }
   //--- Имена объектов кнопок
   string            ScrollIncName(void)                const { return(m_inc.Name());             }
   string            ScrollDecName(void)                const { return(m_dec.Name());             }
   //--- Состояние кнопок
   bool              ScrollIncState(void)               const { return(m_inc.State());            }
   bool              ScrollDecState(void)               const { return(m_dec.State());            }
   //--- Состояние полосы прокрутки (свободно/в режиме перемещения ползунка)
   void              ScrollState(const bool scroll_state)     { m_scroll_state=scroll_state;      }
   bool              ScrollState(void)                  const { return(m_scroll_state);           }
   //--- Текущая позиция ползунка
   void              CurrentPos(const int pos)                { m_current_pos=pos;                }
   int               CurrentPos(void)                   const { return(m_current_pos);            }
   //--- Определяет область зажатия левой кнопки мыши
   void              CheckMouseButtonState(const bool mouse_state);
   //--- Обнуление переменных
   void              ZeroThumbVariables(void);
   //--- Изменение размера ползунка по новым условиям
   void              ChangeThumbSize(const int items_total,const int visible_items_total);
   //--- Расчёт длины ползунка полосы прокрутки
   bool              CalculateThumbSize(void);
   //--- Изменение цвета объектов полосы прокрутки
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Таймер
   virtual void      OnEventTimer(void) {}
   //--- Перемещение элемента
   virtual void      Moving(const int x,const int y);
   //--- (1) Показ, (2) скрытие, (3) сброс, (4) удаление
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- (1) Установка, (2) сброс приоритетов на нажатие левой кнопки мыши
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- Сбросить цвет
   virtual void      ResetColors(void) {}
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CScroll::CScroll(void) : m_current_pos(0),
                         m_area_width(15),
                         m_area_length(0),
                         m_inc_file_on(""),
                         m_inc_file_off(""),
                         m_dec_file_on(""),
                         m_dec_file_off(""),
                         m_thumb_width(0),
                         m_thumb_length(0),
                         m_thumb_min_length(15),
                         m_thumb_size_fixing(0),
                         m_thumb_point_fixing(0),
                         m_area_color(C'210,210,210'),
                         m_area_border_color(C'240,240,240'),
                         m_bg_border_color(C'210,210,210'),
                         m_thumb_color(C'190,190,190'),
                         m_thumb_color_hover(C'180,180,180'),
                         m_thumb_color_pressed(C'160,160,160'),
                         m_thumb_border_color(C'170,170,170'),
                         m_thumb_border_color_hover(C'160,160,160'),
                         m_thumb_border_color_pressed(C'140,140,140')
  {
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder  =8;
   m_bg_zorder    =9;
   m_arrow_zorder =10;
   m_thumb_zorder =11;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CScroll::~CScroll(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CScroll::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //---
      int x=(int)lparam;
      int y=(int)dparam;
      //--- Проверка фокуса над кнопками
      m_inc.MouseFocus(x>m_inc.X() && x<m_inc.X2() && y>m_inc.Y() && y<m_inc.Y2());
      m_dec.MouseFocus(x>m_dec.X() && x<m_dec.X2() && y>m_dec.Y() && y<m_dec.Y2());
     }
  }
//+------------------------------------------------------------------+
//| Создаёт полосу прокрутки                                         |
//+------------------------------------------------------------------+
bool CScroll::CreateScroll(const long chart_id,const int subwin,const int x,const int y,const int items_total,const int visible_items_total)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием скролла классу нужно передать "
              "указатель на форму: CScroll::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Выйти, если производится попытка использовать базовый класс полосы прокрутки
   if(CElement::ClassName()=="")
     {
      ::Print(__FUNCTION__," > Используйте производные классы полосы прокрутки (CScrollV или CScrollH).");
      return(false);
     }
//--- Инициализация переменных
   m_chart_id            =chart_id;
   m_subwin              =subwin;
   m_x                   =x;
   m_y                   =y;
   m_area_width          =(CElement::ClassName()=="CScrollV")? CElement::XSize() : CElement::YSize();
   m_area_length         =(CElement::ClassName()=="CScrollV")? CElement::YSize() : CElement::XSize();
   m_items_total         =(items_total>0)? items_total : 1;
   m_visible_items_total =(visible_items_total>items_total)? items_total : visible_items_total;
   m_thumb_width         =m_area_width-2;
   m_thumb_steps_total   =m_items_total-m_visible_items_total+1;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание кнопки
   if(!CreateArea())
      return(false);
   if(!CreateBg())
      return(false);
   if(!CreateInc())
      return(false);
   if(!CreateDec())
      return(false);
   if(!CreateThumb())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт общую площадь скролла                                    |
//+------------------------------------------------------------------+
bool CScroll::CreateArea(void)
  {
//--- Формирование имени объекта
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_area_" : "_scrollh_area_";
//--- Если индекс не задан
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- Если индекс задан
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Создание объекта
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установка свойств
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Размеры
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- Отступы от крайней точки
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон скролла                                              |
//+------------------------------------------------------------------+
bool CScroll::CreateBg(void)
  {
//--- Формирование имени объекта
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_bg_" : "_scrollh_bg_";
//--- Если индекс не задан
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- Если индекс задан
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x=0;
   int y=0;
//--- Размеры
   int x_size=0;
   int y_size=0;
//--- Установка свойств с учётом типа скролла
   if(CElement::ClassName()=="CScrollV")
     {
      m_bg_length =CElement::YSize()-(m_thumb_width*2)-2;
      x           =CElement::X()+1;
      y           =CElement::Y()+m_thumb_width+1;
      x_size      =m_thumb_width;
      y_size      =m_bg_length;
     }
   else
     {
      m_bg_length =CElement::XSize()-(m_thumb_width*2)-2;
      x           =CElement::X()+m_thumb_width+1;
      y           =CElement::Y()+1;
      x_size      =m_bg_length;
      y_size      =m_thumb_width;
     }
//--- Создание объекта
   if(!m_bg.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Установка свойств
   m_bg.BackColor(m_area_color);
   m_bg.Color(m_bg_border_color);
   m_bg.BorderType(BORDER_FLAT);
   m_bg.Corner(m_corner);
   m_bg.Selectable(false);
   m_bg.Z_Order(m_bg_zorder);
   m_bg.Tooltip("\n");
//--- Сохраним координаты
   m_bg.X(x);
   m_bg.Y(y);
//--- Сохраним отступы
   m_bg.XGap(x-m_wnd.X());
   m_bg.YGap(y-m_wnd.Y());
//--- Сохраним размеры
   m_bg.XSize(x_size);
   m_bg.YSize(y_size);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт переключатель скролла вверх или влево                    |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\UpTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\UpTransp_min_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_min_dark.bmp"
//---
bool CScroll::CreateInc(void)
  {
//--- Формирование имени объекта
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_inc_" : "_scrollh_inc_";
//--- Если индекс не задан
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- Если индекс задан
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x=m_x+1;
   int y=m_y+1;
//--- Установка свойств с учётом типа скролла
   if(CElement::ClassName()=="CScrollV")
     {
      if(m_inc_file_on=="")
         m_inc_file_on="::Images\\EasyAndFastGUI\\Controls\\UpTransp_min_dark.bmp";
      if(m_inc_file_off=="")
         m_inc_file_off="::Images\\EasyAndFastGUI\\Controls\\UpTransp_min.bmp";
     }
   else
     {
      if(m_inc_file_on=="")
         m_inc_file_on="::Images\\EasyAndFastGUI\\Controls\\LeftTransp_min_dark.bmp";
      if(m_inc_file_off=="")
         m_inc_file_off="::Images\\EasyAndFastGUI\\Controls\\LeftTransp_min.bmp";
     }
//--- Создание объекта
   if(!m_inc.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
   m_inc.BmpFileOn(m_inc_file_on);
   m_inc.BmpFileOff(m_inc_file_off);
   m_inc.Corner(m_corner);
   m_inc.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_inc.Selectable(false);
   m_inc.Z_Order(m_arrow_zorder);
   m_inc.Tooltip("\n");
//--- Сохраним координаты
   m_inc.X(x);
   m_inc.Y(y);
//--- Сохраним отступы
   m_inc.XGap(x-m_wnd.X());
   m_inc.YGap(y-m_wnd.Y());
//--- Сохраним размеры
   m_inc.XSize(m_inc.X_Size());
   m_inc.YSize(m_inc.Y_Size());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_inc);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт переключатель скролла вниз или вправо                    |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DownTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DownTransp_min_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_min.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_min_dark.bmp"
//---
bool CScroll::CreateDec(void)
  {
//--- Формирование имени объекта
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_dec_" : "_scrollh_dec_";
//--- Если индекс не задан
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- Если индекс задан
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x=m_x+1;
   int y=m_y+m_bg.YSize()+m_thumb_width+1;
//--- Установка свойств с учётом типа скролла
   if(CElement::ClassName()=="CScrollV")
     {
      x =m_x+1;
      y =m_y+m_bg.YSize()+m_thumb_width+1;
      //--- Если картинка не определена, установка по умолчанию
      if(m_dec_file_on=="")
         m_dec_file_on="Images\\EasyAndFastGUI\\Controls\\DownTransp_min_dark.bmp";
      if(m_dec_file_off=="")
         m_dec_file_off="Images\\EasyAndFastGUI\\Controls\\DownTransp_min.bmp";
     }
   else
     {
      x =m_x+m_bg.XSize()+m_thumb_width+1;
      y =m_y+1;
      //--- Если картинка не определена, установка по умолчанию
      if(m_dec_file_on=="")
         m_dec_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_min_dark.bmp";
      if(m_dec_file_off=="")
         m_dec_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_min.bmp";
     }
//--- Создание объекта
   if(!m_dec.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
   m_dec.BmpFileOn("::"+m_dec_file_on);
   m_dec.BmpFileOff("::"+m_dec_file_off);
   m_dec.Corner(m_corner);
   m_dec.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_dec.Selectable(false);
   m_dec.Z_Order(m_arrow_zorder);
   m_dec.Tooltip("\n");
//--- Сохраним координаты
   m_dec.X(x);
   m_dec.Y(y);
//--- Сохраним отступы
   m_dec.XGap(x-m_wnd.X());
   m_dec.YGap(y-m_wnd.Y());
//--- Сохраним размеры
   m_dec.XSize(m_dec.X_Size());
   m_dec.YSize(m_dec.Y_Size());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_dec);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт ползунок полосы прокрутки                                |
//+------------------------------------------------------------------+
bool CScroll::CreateThumb(void)
  {
//--- Формирование имени объекта  
   string name      ="";
   string name_part =(CElement::ClassName()=="CScrollV")? "_scrollv_thumb_" : "_scrollh_thumb_";
//--- Если индекс не задан
   if(CElement::Index()==WRONG_VALUE)
      name=CElement::ProgramName()+name_part+(string)CElement::Id();
//--- Если индекс задан
   else
      name=CElement::ProgramName()+name_part+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x=0;
   int y=0;
//--- Размеры
   int x_size=0;
   int y_size=0;
//--- Рассчитаем размер полосы прокрутки
   if(!CalculateThumbSize())
      return(true);
//--- Установка свойства с учётом типа скролла
   if(CElement::ClassName()=="CScrollV")
     {
      x      =(m_thumb.X()>0) ? m_thumb.X() : m_x+1;
      y      =(m_thumb.Y()>0) ? m_thumb.Y() : m_y+m_thumb_width+1;
      x_size =m_thumb_width;
      y_size =m_thumb_length;
     }
   else
     {
      x      =(m_thumb.X()>0) ? m_thumb.X() : m_x+m_thumb_width+1;
      y      =(m_thumb.Y()>0) ? m_thumb.Y() : m_y+1;
      x_size =m_thumb_length;
      y_size =m_thumb_width;
     }
//--- Создание объекта
   if(!m_thumb.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Установка свойств
   m_thumb.BackColor(m_thumb_color);
   m_thumb.Color(m_thumb_border_color);
   m_thumb.BorderType(BORDER_FLAT);
   m_thumb.Corner(m_corner);
   m_thumb.Selectable(false);
   m_thumb.Z_Order(m_thumb_zorder);
   m_thumb.Tooltip("\n");
//--- Сохраним координаты
   m_thumb.X(x);
   m_thumb.Y(y);
//--- Сохраним отступы
   m_thumb.XGap(x-m_wnd.X());
   m_thumb.YGap(y-m_wnd.Y());
//--- Сохраним размеры
   m_thumb.XSize(x_size);
   m_thumb.YSize(y_size);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_thumb);
   return(true);
  }
//+------------------------------------------------------------------+
//| Расчёт размера полосы прокрутки                                  |
//+------------------------------------------------------------------+
bool CScroll::CalculateThumbSize(void)
  {
//--- Расчёт не нужен, если длина области для перемещения ползунка меньше, чем минимальная длина ползунка
   if(m_bg_length<m_thumb_min_length)
      return(false);
//--- Разница в процентах между общим количеством пунктов и видимым
   double percentage_difference=1-(double)(m_items_total-m_visible_items_total)/m_items_total;
//--- Рассчитаем размер шага ползунка
   m_thumb_step_size=(double)(m_bg_length-(m_bg_length*percentage_difference))/m_thumb_steps_total;
//--- Рассчитаем размер рабочей области для перемещения ползунка
   double work_area=m_thumb_step_size*m_thumb_steps_total;
//--- Если размер рабочей области меньше размера всей области, получим размер ползунка, иначе установим минимальный размер
   double thumb_size=(work_area<m_bg_length)? m_bg_length-work_area+m_thumb_step_size : m_thumb_min_length;
//--- Проверка размера ползунка с учётом приведения типа
   m_thumb_length=((int)thumb_size<m_thumb_min_length)? m_thumb_min_length :(int)thumb_size;
   return(true);
  }
//+------------------------------------------------------------------+
//| Определяет область зажатия левой кнопки мыши                     |
//+------------------------------------------------------------------+
void CScroll::CheckMouseButtonState(const bool mouse_state)
  {
//--- Если левая кнопки мыши отжата
   if(!mouse_state)
     {
      //--- Обнулим переменные
      ZeroThumbVariables();
      return;
     }
//--- Если кнопка нажата
   if(mouse_state)
     {
      //--- Выйдем, если кнопка уже нажата в какой-либо области
      if(m_clamping_area_mouse!=THUMB_NOT_PRESSED)
         return;
      //--- Вне области ползунка полосы прокрутки
      if(!m_thumb.MouseFocus())
         m_clamping_area_mouse=THUMB_PRESSED_OUTSIDE;
      //--- В области ползунка полосы прокрутки
      else
        {
         m_clamping_area_mouse=THUMB_PRESSED_INSIDE;
         //--- Если элемент не выпадающий
         if(!CElement::IsDropdown())
           {
            //--- Заблокируем форму и запомним идентификатор активного элемента
            m_wnd.IsLocked(true);
            m_wnd.IdActivatedElement(CElement::Id());
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Обнуление переменных связанных с перемещением ползунка           |
//+------------------------------------------------------------------+
void CScroll::ZeroThumbVariables(void)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return;
//--- Если элемент не выпадающий
   if(!CElement::IsDropdown() && m_clamping_area_mouse==THUMB_PRESSED_INSIDE)
     {
      //--- Разблокируем форму и сбросим идентификатор активного элемента
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
//--- Обнулить переменные
   m_thumb_size_fixing   =0;
   m_clamping_area_mouse =THUMB_NOT_PRESSED;
  }
//+------------------------------------------------------------------+
//| Изменяет цвет объектов полосы прокрутки списка                   |
//+------------------------------------------------------------------+
void CScroll::ChangeObjectsColor(void)
  {
//--- Выйти, если форма заблокирована и идентификатор активного в текущий момент элемента отличается
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- Цвет кнопок полосы прокрутки списка
   if(!m_scroll_state)
     {
      m_inc.State(m_inc.MouseFocus());
      m_dec.State(m_dec.MouseFocus());
     }
//--- Если курсор в зоне полосы прокрутки
   if(m_thumb.MouseFocus())
     {
      //--- Если левая кнопка мыши отжата
      if(m_clamping_area_mouse==THUMB_NOT_PRESSED)
        {
         m_scroll_state=false;
         m_thumb.BackColor(m_thumb_color_hover);
         m_thumb.Color(m_thumb_border_color_hover);
        }
      //--- Левая кнопка мыши нажата на ползунке
      else if(m_clamping_area_mouse==THUMB_PRESSED_INSIDE)
        {
         m_scroll_state=true;
         m_thumb.BackColor(m_thumb_color_pressed);
         m_thumb.Color(m_thumb_border_color_pressed);
        }
     }
//--- Если курсор вне зоны полосы прокрутки
   else
     {
      //--- Левая кнопка мыши отжата
      if(m_clamping_area_mouse==THUMB_NOT_PRESSED)
        {
         m_scroll_state=false;
         m_thumb.BackColor(m_thumb_color);
         m_thumb.Color(m_thumb_border_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| Изменение размера ползунка по новым условиям                     |
//+------------------------------------------------------------------+
void CScroll::ChangeThumbSize(const int items_total,const int visible_items_total)
  {
   m_items_total         =items_total;
   m_visible_items_total =visible_items_total;
//--- Выйдем, если количество элементов списка не больше количества видимой части списка
   if(items_total<=visible_items_total)
      return;
//--- Получим количество шагов для ползунка
   m_thumb_steps_total=items_total-visible_items_total+1;
//--- Получим размер полосы прокрутки
   if(!CalculateThumbSize())
      return;
//--- Сохраним размеры
   if(CElement::ClassName()=="CScrollV")
     {
      CElement::YSize(m_thumb_length);
      m_thumb.YSize(m_thumb_length);
      m_thumb.Y_Size(m_thumb_length);
     }
   else
     {
      CElement::XSize(m_thumb_length);
      m_thumb.XSize(m_thumb_length);
      m_thumb.X_Size(m_thumb_length);
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CScroll::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
   m_bg.X(x+m_bg.XGap());
   m_bg.Y(y+m_bg.YGap());
   m_inc.X(x+m_inc.XGap());
   m_inc.Y(y+m_inc.YGap());
   m_dec.X(x+m_dec.XGap());
   m_dec.Y(y+m_dec.YGap());
   m_thumb.X(x+m_thumb.XGap());
   m_thumb.Y(y+m_thumb.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_bg.X_Distance(m_bg.X());
   m_bg.Y_Distance(m_bg.Y());
   m_inc.X_Distance(m_inc.X());
   m_inc.Y_Distance(m_inc.Y());
   m_dec.X_Distance(m_dec.X());
   m_dec.Y_Distance(m_dec.Y());
   m_thumb.X_Distance(m_thumb.X());
   m_thumb.Y_Distance(m_thumb.Y());
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CScroll::Show(void)
  {
//--- Выйдем, если количество элементов списка не больше количества видимой части списка
   if(m_items_total<=m_visible_items_total)
      return;
//---
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_bg.Timeframes(OBJ_ALL_PERIODS);
   m_inc.Timeframes(OBJ_ALL_PERIODS);
   m_dec.Timeframes(OBJ_ALL_PERIODS);
   m_thumb.Timeframes(OBJ_ALL_PERIODS);
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CScroll::Hide(void)
  {
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_bg.Timeframes(OBJ_NO_PERIODS);
   m_inc.Timeframes(OBJ_NO_PERIODS);
   m_dec.Timeframes(OBJ_NO_PERIODS);
   m_thumb.Timeframes(OBJ_NO_PERIODS);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CScroll::Reset(void)
  {
//--- Выйдем, если элемент выпадающий
   if(CElement::IsDropdown())
      return;
//--- Скрыть и показать
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CScroll::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_bg.Delete();
   m_inc.Delete();
   m_dec.Delete();
   m_thumb.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CScroll::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_bg.Z_Order(m_bg_zorder);
   m_inc.Z_Order(m_arrow_zorder);
   m_dec.Z_Order(m_arrow_zorder);
   m_thumb.Z_Order(m_thumb_zorder);
//--- Если вертикальная полоса прокрутки
   if(CElement::ClassName()=="CScrollV")
     {
      m_inc.BmpFileOn(m_inc_file_on);
      m_dec.BmpFileOn(m_dec_file_on);
      return;
     }
//--- Если горизонтальная полоса прокрутки
   if(CElement::ClassName()=="CScrollH")
     {
      m_inc.BmpFileOn(m_inc_file_on);
      m_dec.BmpFileOn(m_dec_file_on);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CScroll::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_bg.Z_Order(0);
   m_inc.Z_Order(0);
   m_dec.Z_Order(0);
   m_thumb.Z_Order(0);
//--- Если вертикальная полоса прокрутки
   if(CElement::ClassName()=="CScrollV")
     {
      m_inc.BmpFileOn(m_inc_file_off);
      m_dec.BmpFileOn(m_dec_file_off);
      return;
     }
//--- Если горизонтальная полоса прокрутки
   if(CElement::ClassName()=="CScrollH")
     {
      m_inc.BmpFileOn(m_inc_file_off);
      m_dec.BmpFileOn(m_dec_file_off);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Класс для управления вертикальной полосой прокрутки              |
//+------------------------------------------------------------------+
class CScrollV : public CScroll
  {
public:
                     CScrollV(void);
                    ~CScrollV(void);
   //--- Управление ползунком
   bool              ScrollBarControl(const int x,const int y,const bool mouse_state);
   //--- Расчёт координаты Y ползунка
   void              CalculateThumbY(void);
   //--- Установить новую координату для полосы прокрутки
   void              XDistance(const int x);
   //--- Обработка нажатия на кнопках полосы прокрутки
   bool              OnClickScrollInc(const string clicked_object);
   bool              OnClickScrollDec(const string clicked_object);
   //---
private:
   //--- Процесс перемещения ползунка
   void              OnDragThumb(const int y);
   //--- Обновление положения ползунка
   void              UpdateThumb(const int new_y_point);
   //--- Корректирует номер позиции ползунка
   void              CalculateThumbPos(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CScrollV::CScrollV(void)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CScrollV::~CScrollV(void)
  {
  }
//+------------------------------------------------------------------+
//| Управление ползунком                                             |
//+------------------------------------------------------------------+
bool CScrollV::ScrollBarControl(const int x,const int y,const bool mouse_state)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return(false);
//--- Если форма не заблокирована и идентификаторы совпадают
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- Проверка фокуса над ползуком
   m_thumb.MouseFocus(x>m_thumb.X() && x<m_thumb.X2() && 
                      y>m_thumb.Y() && y<m_thumb.Y2());
//--- Проверим и запомним состояние кнопки мыши
   CScroll::CheckMouseButtonState(mouse_state);
//--- Изменим цвет ползунка
   CScroll::ChangeObjectsColor();
//--- Если управление передано полосе прокрутки, определим положение ползунка
   if(CScroll::ScrollState())
     {
      //--- Перемещение ползунка
      OnDragThumb(y);
      //--- Изменяет номер позиции ползунка
      CalculateThumbPos();
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Расчёт координаты Y ползунка полосы прокрутки                    |
//+------------------------------------------------------------------+
void CScrollV::CalculateThumbY(void)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return;
//--- Определим текущую координату Y ползунка
   int scroll_thumb_y=int(m_bg.Y()+(CScroll::CurrentPos()*CScroll::m_thumb_step_size));
//--- Если выходим за пределы рабочей области вверх
   if(scroll_thumb_y<=m_bg.Y())
      scroll_thumb_y=m_bg.Y();
//--- Если выходим за пределы рабочей области вниз
   if(scroll_thumb_y+CScroll::m_thumb_length>=m_bg.Y2() || 
      CScroll::CurrentPos()>=CScroll::m_thumb_steps_total-1)
     {
      scroll_thumb_y=int(m_bg.Y2()-CScroll::m_thumb_length);
     }
//--- Обновим координату и отступ по оси Y
   m_thumb.Y(scroll_thumb_y);
   m_thumb.Y_Distance(scroll_thumb_y);
   m_thumb.YGap(m_thumb.Y()-m_wnd.Y());
  }
//+------------------------------------------------------------------+
//| Изменение координаты X элемента                                  |
//+------------------------------------------------------------------+
void CScrollV::XDistance(const int x)
  {
//--- Обновим координату X элемента...
   int l_x=x+1;
   CElement::X(x);
//--- ...и всех объектов полосы прокрутки
   m_area.X(CElement::X());
   m_bg.X(l_x);
   m_thumb.X(l_x);
   m_inc.X(l_x);
   m_dec.X(l_x);
//--- Установим координату объектам
   m_area.X_Distance(CElement::X());
   m_bg.X_Distance(l_x);
   m_thumb.X_Distance(l_x);
   m_inc.X_Distance(l_x);
   m_dec.X_Distance(l_x);
//--- Обновим отступы у всех объектов элемента
   l_x=l_x-m_wnd.X();
   m_area.XGap(CElement::X()-m_wnd.X());
   m_bg.XGap(l_x);
   m_thumb.XGap(l_x);
   m_inc.XGap(l_x);
   m_dec.XGap(l_x);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопке вверх/влево                          |
//+------------------------------------------------------------------+
bool CScrollV::OnClickScrollInc(const string clicked_object)
  {
//--- Выйдем, если нажатие было не на этот объект или скролл сейчас активен или кол-во шагов неопределено
   if(m_inc.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<1)
      return(false);
//--- Уменьшим номер позиции полосы прокрутки
   if(CScroll::CurrentPos()>0)
      CScroll::m_current_pos--;
//--- Расчёт координты Y полосы прокрутки
   CalculateThumbY();
//--- Установим состояние On
   m_inc.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопке вниз/вправо                          |
//+------------------------------------------------------------------+
bool CScrollV::OnClickScrollDec(const string clicked_object)
  {
//--- Выйдем, если нажатие было не на этот объект или скролл сейчас активен или кол-во шагов неопределено
   if(m_dec.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<1)
      return(false);
//--- Увеличим номер позиции полосы прокрутки
   if(CScroll::CurrentPos()<CScroll::m_thumb_steps_total-1)
      CScroll::m_current_pos++;
//--- Расчёт координты Y полосы прокрутки
   CalculateThumbY();
//--- Установим состояние On
   m_dec.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Перемещение ползунка                                             |
//+------------------------------------------------------------------+
void CScrollV::OnDragThumb(const int y)
  {
//--- Для определения новой Y координаты
   int new_y_point=0;
//--- Если полоса прокрутки неактивна, ...
   if(!CScroll::ScrollState())
     {
      //--- ...обнулим вспомогательные переменные для перемещения ползунка
      CScroll::m_thumb_size_fixing  =0;
      CScroll::m_thumb_point_fixing =0;
      return;
     }
//--- Если точка фиксации нулевая, то запомним текущую координату курсора
   if(CScroll::m_thumb_point_fixing==0)
      CScroll::m_thumb_point_fixing=y;
//--- Если значение расстояния от крайней точки ползунка до текущей координаты курсора нулевое, рассчитаем его
   if(CScroll::m_thumb_size_fixing==0)
      CScroll::m_thumb_size_fixing=m_thumb.Y()-y;
//--- Если в нажатом состоянии прошли порог вниз
   if(y-CScroll::m_thumb_point_fixing>0)
     {
      //--- Рассчитаем координату Y
      new_y_point=y+CScroll::m_thumb_size_fixing;
      //--- Обновим положение ползунка
      UpdateThumb(new_y_point);
      return;
     }
//--- Если в нажатом состоянии прошли порог вверх
   if(y-CScroll::m_thumb_point_fixing<0)
     {
      //--- Рассчитаем координату Y
      new_y_point=y-::fabs(CScroll::m_thumb_size_fixing);
      //--- Обновим положение ползунка
      UpdateThumb(new_y_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Обновление положения ползунка                                    |
//+------------------------------------------------------------------+
void CScrollV::UpdateThumb(const int new_y_point)
  {
   int y=new_y_point;
//--- Обнуление точки фиксации
   CScroll::m_thumb_point_fixing=0;
//--- Проверка на выход из рабочей области вниз и корректировка значений
   if(new_y_point>m_bg.Y2()-CScroll::m_thumb_length)
     {
      y=m_bg.Y2()-CScroll::m_thumb_length;
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total));
     }
//--- Проверка на выход из рабочей области вверх и корректировка значений
   if(new_y_point<=m_bg.Y())
     {
      y=m_bg.Y();
      CScroll::CurrentPos(0);
     }
//--- Обновим координаты и отступы
   m_thumb.Y(y);
   m_thumb.Y_Distance(y);
   m_thumb.YGap(m_thumb.Y()-(CElement::Y()-CElement::YGap()));
  }
//+------------------------------------------------------------------+
//| Корректирует номер позиции ползунка                              |
//+------------------------------------------------------------------+
void CScrollV::CalculateThumbPos(void)
  {
//--- Выйти, если шаг равен нулю
   if(CScroll::m_thumb_step_size==0)
      return;
//--- Корректирует номер позиции полосы прокрутки
   CScroll::CurrentPos(int((m_thumb.Y()-m_bg.Y())/CScroll::m_thumb_step_size));
//--- Проверка на выход из рабочей области вниз/вверх
   if(m_thumb.Y2()>=m_bg.Y2()-1)
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total-1));
   if(m_thumb.Y()<m_bg.Y())
      CScroll::CurrentPos(0);
  }
//+------------------------------------------------------------------+
//| Класс для управления горизонтальной полосой прокрутки            |
//+------------------------------------------------------------------+
class CScrollH : public CScroll
  {
public:
                     CScrollH(void);
                    ~CScrollH(void);
   //--- Управление ползунком
   bool              ScrollBarControl(const int x,const int y,const bool mouse_state);
   //--- Расчёт координаты X ползунка
   void              CalculateThumbX(void);
   //--- Обработка нажатия на кнопках полосы прокрутки
   bool              OnClickScrollInc(const string clicked_object);
   bool              OnClickScrollDec(const string clicked_object);
   //---
private:
   //--- Перемещение ползунка
   void              OnDragThumb(const int x);
   //--- Обновление положения ползунка
   void              UpdateThumb(const int new_x_point);
   //--- Корректирует номер позиции ползунка
   void              CalculateThumbPos(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CScrollH::CScrollH(void)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CScrollH::~CScrollH(void)
  {
  }
//+------------------------------------------------------------------+
//| Управление скроллом                                              |
//+------------------------------------------------------------------+
bool CScrollH::ScrollBarControl(const int x,const int y,const bool mouse_state)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
      return(false);
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- Проверка фокуса над ползуком
   m_thumb.MouseFocus(x>m_thumb.X() && x<m_thumb.X2() && 
                      y>m_thumb.Y() && y<m_thumb.Y2());
//--- Проверим и запомним состояние кнопки мыши
   CScroll::CheckMouseButtonState(mouse_state);
//--- Изменим цвет полосы прокрутки списка
   CScroll::ChangeObjectsColor();
//--- Если управление передано полосе прокрутки, определим положение ползунка
   if(CScroll::ScrollState())
     {
      //--- Перемещение ползунка
      OnDragThumb(x);
      //--- Изменяет номер позиции ползунка
      CalculateThumbPos();
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//| Расчёт координаты X ползунка                                     |
//+------------------------------------------------------------------+
void CScrollH::CalculateThumbX(void)
  {
//--- Определим текущую координату X ползунка
   int scroll_thumb_x=int(m_bg.X()+(CScroll::CurrentPos()*CScroll::m_thumb_step_size));
//--- Если выходим за пределы рабочей области влево
   if(scroll_thumb_x<=m_bg.X())
      scroll_thumb_x=m_bg.X();
//--- Если выходим за пределы рабочей области вправо
   if(scroll_thumb_x+CScroll::m_thumb_length>=m_bg.X2() || 
      CScroll::CurrentPos()>=CScroll::m_thumb_steps_total-1)
     {
      scroll_thumb_x=int(m_bg.X2()-CScroll::m_thumb_length);
     }
//--- Обновим координату и отступ по оси X
   m_thumb.X(scroll_thumb_x);
   m_thumb.X_Distance(scroll_thumb_x);
   m_thumb.XGap(m_thumb.X()-(m_x-CElement::XGap()));
  }
//+------------------------------------------------------------------+
//| Нажатие на переключателе влево                                   |
//+------------------------------------------------------------------+
bool CScrollH::OnClickScrollInc(const string clicked_object)
  {
//--- Выйдем, если нажатие было не на этот объект или скролл сейчас активен или кол-во шагов неопределено
   if(m_inc.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<0)
      return(false);
//--- Уменьшим номер позиции полосы прокрутки
   if(CScroll::CurrentPos()>0)
      CScroll::m_current_pos--;
//--- Расчёт координты X полосы прокрутки
   CalculateThumbX();
//--- Установим состояние On
   m_inc.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на переключателе вправо                                  |
//+------------------------------------------------------------------+
bool CScrollH::OnClickScrollDec(const string clicked_object)
  {
//--- Выйдем, если нажатие было не на этот объект или скролл сейчас активен или кол-во шагов неопределено
   if(m_dec.Name()!=clicked_object || CScroll::ScrollState() || CScroll::m_thumb_steps_total<0)
      return(false);
//--- Увеличим номер позиции полосы прокрутки
   if(CScroll::CurrentPos()<CScroll::m_thumb_steps_total-1)
      CScroll::m_current_pos++;
//--- Расчёт координаты X полосы прокрутки
   CalculateThumbX();
//--- Установим состояние On
   m_dec.State(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Перемещение ползунка                                             |
//+------------------------------------------------------------------+
void CScrollH::OnDragThumb(const int x)
  {
//--- Для определения новой X координаты
   int new_x_point=0;
//--- Если полоса прокрутки неактивна, ...
   if(!CScroll::ScrollState())
     {
      //--- ...обнулим вспомогательные переменные для перемещения ползунка
      CScroll::m_thumb_size_fixing  =0;
      CScroll::m_thumb_point_fixing =0;
      return;
     }
//--- Если точка фиксации нулевая, то запомним текущую координаты курсора
   if(CScroll::m_thumb_point_fixing==0)
      CScroll::m_thumb_point_fixing=x;
//--- Если значение расстояния от крайней точки ползунка до текущей координаты курсора нулевое, рассчитаем его
   if(CScroll::m_thumb_size_fixing==0)
      CScroll::m_thumb_size_fixing=m_thumb.X()-x;
//--- Если в нажатом состоянии прошли порог вправо
   if(x-CScroll::m_thumb_point_fixing>0)
     {
      //--- Рассчитаем координату X
      new_x_point=x+CScroll::m_thumb_size_fixing;
      //--- Обновление положения полосы прокрутки
      UpdateThumb(new_x_point);
      return;
     }
//--- Если в нажатом состоянии прошли порог влево
   if(x-CScroll::m_thumb_point_fixing<0)
     {
      //--- Рассчитаем координату X
      new_x_point=x-::fabs(CScroll::m_thumb_size_fixing);
      //--- Обновление положения полосы прокрутки
      UpdateThumb(new_x_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Обновление положения полосы прокрутки                            |
//+------------------------------------------------------------------+
void CScrollH::UpdateThumb(const int new_x_point)
  {
   int x=new_x_point;
//--- Обнуление точки фиксации
   CScroll::m_thumb_point_fixing=0;
//--- Проверка на выход из рабочей области вправо и корректировка значений
   if(new_x_point>m_bg.X2()-CScroll::m_thumb_length)
     {
      x=m_bg.X2()-CScroll::m_thumb_length;
      CScroll::CurrentPos(0);
     }
//--- Проверка на выход из рабочей области влево и корректировка значений
   if(new_x_point<=m_bg.X())
     {
      x=m_bg.X();
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total));
     }
//--- Обновим координаты и отступы
   m_thumb.X(x);
   m_thumb.X_Distance(x);
   m_thumb.XGap(m_thumb.X()-(m_x-CElement::XGap()));
  }
//+------------------------------------------------------------------+
//| Корректирует номер позиции ползунка                              |
//+------------------------------------------------------------------+
void CScrollH::CalculateThumbPos(void)
  {
//--- Выйти, если шаг равен нулю
   if(CScroll::m_thumb_step_size==0)
      return;
//--- Корректирует номер позиции полосы прокрутки
   CScroll::CurrentPos(int((m_thumb.X()-m_bg.X())/CScroll::m_thumb_step_size));
//--- Проверка на выход из рабочей области влево/вправо
   if(m_thumb.X2()>=m_bg.X2()-1)
      CScroll::CurrentPos(int(CScroll::m_thumb_steps_total-1));
   if(m_thumb.X()<m_bg.X())
      CScroll::CurrentPos(0);
  }
//+------------------------------------------------------------------+
