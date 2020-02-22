//+------------------------------------------------------------------+
//|                                                       Window.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include <Charts\Chart.mqh>
//--- Отступы для кнопок от правого края окна
#define CLOSE_BUTTON_OFFSET   (20)
#define ROLL_BUTTON_OFFSET    (36)
#define TOOLTIP_BUTTON_OFFSET (53)
//+------------------------------------------------------------------+
//| Класс создания формы для элементов управления                    |
//+------------------------------------------------------------------+
class CWindow : public CElement
  {
private:
   CChart            m_chart;
   //--- Объекты для создания формы
   CRectLabel        m_bg;
   CRectLabel        m_caption_bg;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CBmpLabel         m_button_tooltip;
   CBmpLabel         m_button_unroll;
   CBmpLabel         m_button_rollup;
   CBmpLabel         m_button_close;
   //--- Идентификатор последнего элемента управления
   int               m_last_id;
   //--- Идентификатор активированного элемента управления
   int               m_id_activated_element;
   //--- Индекс предыдущего активного окна
   int               m_prev_active_window_index;
   //--- Возможность перемещать окно на графике
   bool              m_movable;
   //--- Статус свёрнутого окна
   bool              m_is_minimized;
   //--- Статус заблокированного окна
   bool              m_is_locked;
   //--- Тип окна
   ENUM_WINDOW_TYPE  m_window_type;
   //--- Режим фиксированной высоты подокна (для индикаторов)
   bool              m_height_subwindow_mode;
   //--- Режим сворачивания формы в подокне индикатора
   bool              m_rollup_subwindow_mode;
   //--- Высота подокна индикатора
   int               m_subwindow_height;
   //--- Свойства фона
   color             m_bg_color;
   int               m_bg_full_height;
   //--- Свойства заголовка
   string            m_caption_text;
   int               m_caption_height;
   color             m_caption_bg_color;
   color             m_caption_bg_color_off;
   color             m_caption_bg_color_hover;
   color             m_caption_color_bg_array[];
   //--- Цвет рамок формы (фона, заголовка)
   color             m_border_color;
   //--- Ярлык формы
   string            m_icon_file;
   //--- Наличие кнопки для режима показа всплывающих подсказок
   bool              m_tooltips_button;

   //--- Размеры графика
   int               m_chart_width;
   int               m_chart_height;

   //--- Для определения границ области захвата в заголовке окна
   int               m_right_limit;
   //--- Переменные связанные с перемещением
   int               m_prev_x;
   int               m_prev_y;
   int               m_size_fixing_x;
   int               m_size_fixing_y;
   //---
   int               m_bg_zorder;
   int               m_caption_zorder;
   int               m_button_zorder;

   //--- Состояние кнопки мыши с учётом, где она была нажата
   ENUM_WMOUSE_STATE m_clamping_area_mouse;
   //--- Для управления состоянием графика
   bool              m_custom_event_chart_state;
   //---
public:
                     CWindow(void);
                    ~CWindow(void);
   //--- Методы для создания окна
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
   //--- Изменение цвета объектов формы
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Методы для сохранения и получения id последнего созданного элемента
   int               LastId(void)                                      const { return(m_last_id);                  }
   void              LastId(const int id)                                    { m_last_id=id;                       }
   //--- Методы для сохранения и получения id активированного элемента
   int               IdActivatedElement(void)                          const { return(m_id_activated_element);     }
   void              IdActivatedElement(const int id)                        { m_id_activated_element=id;          }
   //--- (1) Получение и сохранение индекса предыдущего активного окна
   int               PrevActiveWindowIndex(void)                       const { return(m_prev_active_window_index); }
   void              PrevActiveWindowIndex(const int index)                  { m_prev_active_window_index=index;   }
   //--- Тип окна
   ENUM_WINDOW_TYPE  WindowType(void)                                  const { return(m_window_type);              }
   void              WindowType(const ENUM_WINDOW_TYPE flag)                 { m_window_type=flag;                 }
   //--- Ярлык по умолчанию
   string            DefaultIcon(void);
   //--- (1) пользовательский ярлык окна, (2) ограничение области захвата заголовка
   void              IconFile(const string file_path)                        { m_icon_file=file_path;              }
   void              RightLimit(const int value)                             { m_right_limit=value;                }
   //--- (1) Использовать кнопку подсказок, (2) проверка режима показа всплывающих подсказок
   void              UseTooltipsButton(void)                                 { m_tooltips_button=true;             }
   bool              TooltipBmpState(void)                             const { return(m_button_tooltip.State());   }
   
   //--- Возможность перемещения окна
   bool              Movable(void)                                     const { return(m_movable);                  }
   void              Movable(const bool flag)                                { m_movable=flag;                     }
   //--- Статус свёрнутого окна
   bool              IsMinimized(void)                                 const { return(m_is_minimized);             }
   void              IsMinimized(const bool flag)                            { m_is_minimized=flag;                }
   //--- Статус заблокированного окна
   bool              IsLocked(void)                                    const { return(m_is_locked);                }
   void              IsLocked(const bool flag)                               { m_is_locked=flag;                   }
   //--- Свойства заголовка
   void              CaptionText(const string text);
   string            CaptionText(void)                                 const { return(m_caption_text);             }
   void              CaptionHeight(const int height)                         { m_caption_height=height;            }
   int               CaptionHeight(void)                               const { return(m_caption_height);           }
   void              CaptionBgColor(const color clr)                         { m_caption_bg_color=clr;             }
   color             CaptionBgColor(void)                              const { return(m_caption_bg_color);         }
   void              CaptionBgColorOff(const color clr)                      { m_caption_bg_color_off=clr;         }
   void              CaptionBgColorHover(const color clr)                    { m_caption_bg_color_hover=clr;       }
   color             CaptionBgColorHover(void)                         const { return(m_caption_bg_color_hover);   }
   //--- Свойства окна
   void              WindowBgColor(const color clr)                          { m_bg_color=clr;                     }
   color             WindowBgColor(void)                               const { return(m_bg_color);                 }
   void              WindowBorderColor(const color clr)                      { m_border_color=clr;                 }
   color             WindowBorderColor(void)                           const { return(m_border_color);             }
   
   //--- Установка состояния окна
   void              State(const bool flag);
   //--- Режим сворачивания подокна индикатора
   void              RollUpSubwindowMode(const bool flag,const bool height_mode);
   //--- Управление размерами
   void              ChangeWindowWidth(const int width);
   void              ChangeSubwindowHeight(const int height);

   //--- Получение размеров графика
   void              SetWindowProperties(void);
   //--- Преобразует координату Y в относительную
   int               YToRelative(const int y);
   //--- Проверка курсора в области заголовка 
   bool              CursorInsideCaption(const int x,const int y);
   //--- Обнуление переменных
   void              ZeroPanelVariables(void);

   //--- Проверка состояния левой кнопки мыши
   void              CheckMouseButtonState(const int x,const int y,const string state);
   //--- Проверка фокуса мыши
   void              CheckMouseFocus(const int x,const int y,const int subwin);
   //--- Установка режима графика
   void              SetChartState(const int subwindow_number);
   //--- Обновление координат формы
   void              UpdateWindowXY(const int x,const int y);
   //--- Пользовательский флаг управления свойствами графика
   void              CustomEventChartState(const bool state) { m_custom_event_chart_state=state; }

   //--- Закрытие главного окна
   bool              CloseWindow(const string pressed_object);
   //--- Закрытие диалогового окна
   void              CloseDialogBox(void);
   
   //--- Изменение состояния окна
   bool              ChangeWindowState(const string pressed_object);
   //--- Методы для (1) сворачивания и (2) разворачивания окна
   void              RollUp(void);
   void              Unroll(void);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Таймер
   virtual void      OnEventTimer(void);
   //--- Перемещение элемента
   virtual void      Moving(const int x,const int y);
   //--- Показ, скрытие, сброс, удаление
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- Установка, сброс приоритетов на нажитие левой кнопки мыши
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- Сбросить цвет
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
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим строгую последовательность приоритетов
   m_bg_zorder      =0;
   m_caption_zorder =1;
   m_button_zorder  =2;
//--- Получим ID текущего графика
   m_chart.Attach();
//--- Получим размеры окна графика
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
//| Обработчик событий графика                                       |
//+------------------------------------------------------------------+
void CWindow::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      int      x      =(int)lparam; // Координата по оси X
      int      y      =(int)dparam; // Координата по оси Y
      int      subwin =WRONG_VALUE; // Номер окна, в котором находится курсор
      datetime time   =NULL;        // Время соответствующее координате X
      double   level  =0.0;         // Уровень (цена) соответствующий координате Y
      int      rel_y  =0;           // Для определения относительной Y-координаты
      //--- Получим местоположение курсора
      if(!::ChartXYToTimePrice(m_chart_id,x,y,subwin,time,level))
         return;
      //--- Получим относительную координату Y
      rel_y=YToRelative(y);
      //--- Проверим и запомним состояние кнопки мыши
      CheckMouseButtonState(x,rel_y,sparam);
      //--- Проверка фокуса мыши
      CheckMouseFocus(x,rel_y,subwin);
      //--- Установим состояние графика
      SetChartState(subwin);
      //--- Выйти, если эта форма заблокирована
      if(m_is_locked)
         return;
      //--- Если управление передано окну, определим её положение
      if(m_clamping_area_mouse==PRESSED_INSIDE_HEADER)
        {
         //--- Обновление координат окна
         UpdateWindowXY(x,rel_y);
        }
      //---
      return;
     }
//--- Обработка события нажатия на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Закрыть окно
      CloseWindow(sparam);
      //--- Свернуть/Развернуть окно
      ChangeWindowState(sparam);
      return;
     }
//--- Событие изменения свойств графика
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      //--- Если кнопка отжата
      if(m_clamping_area_mouse==NOT_PRESSED)
        {
         //--- Получим размеры окна графика
         SetWindowProperties();
         //--- Корректировка координат
         UpdateWindowXY(m_x,m_y);
        }
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CWindow::OnEventTimer(void)
  {
//--- Если окно не заблокировано
   if(!m_is_locked)
     {
      //--- Изменение цвета объектов формы
      ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт форму для элементов управления                           |
//+------------------------------------------------------------------+
bool CWindow::CreateWindow(const long chart_id,const int subwin,const string caption_text,const int x,const int y)
  {
   if(CElement::Id()==WRONG_VALUE)
     {
      ::Print(__FUNCTION__," > Перед созданием окна его указатель нужно сохранить в базе: CWndContainer::AddWindow(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_chart_id       =chart_id;
   m_subwin         =subwin;
   m_caption_text   =caption_text;
   m_x              =x;
   m_y              =y;
   m_bg_full_height =m_y_size;
//--- Создание всех объектов окна
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
//--- Если эта программа индикатор
   if(CElement::ProgramType()==PROGRAM_INDICATOR)
     {
      //--- Если установлен режим фиксированной высоты подокна
      if(m_height_subwindow_mode)
        {
         m_subwindow_height=m_bg_full_height+3;
         ChangeSubwindowHeight(m_subwindow_height);
        }
     }
//--- Спрятать окно, если оно диалоговое
   if(m_window_type==W_DIALOG)
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон окна                                                 |
//+------------------------------------------------------------------+
bool CWindow::CreateBackground(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_window_bg_"+(string)CElement::Id();
//--- Размер окна зависит от состояния (свёрнуто/развёрнуто)
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
//--- Установим фон окна
   if(!m_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,y_size))
      return(false);
//--- Установим свойства
   m_bg.BackColor(m_bg_color);
   m_bg.Color(m_border_color);
   m_bg.BorderType(BORDER_FLAT);
   m_bg.Corner(m_corner);
   m_bg.Selectable(false);
   m_bg.Z_Order(m_bg_zorder);
   m_bg.Tooltip("\n");
//--- Сохраним указатель объекта
   CElement::AddToArray(m_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт заголовок окна                                           |
//+------------------------------------------------------------------+
bool CWindow::CreateCaption(void)
  {
//--- Формирование имени объекта  
   string name=CElement::ProgramName()+"_window_caption_"+(string)CElement::Id();
//--- Установим заголовок окна
   if(!m_caption_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_caption_height))
      return(false);
//--- Установим свойства
   m_caption_bg.BackColor(m_caption_bg_color);
   m_caption_bg.Color(m_border_color);
   m_caption_bg.BorderType(BORDER_FLAT);
   m_caption_bg.Corner(m_corner);
   m_caption_bg.Selectable(false);
   m_caption_bg.Z_Order(m_caption_zorder);
   m_caption_bg.Tooltip("\n");
//--- Сохраним координаты
   m_caption_bg.X(m_x);
   m_caption_bg.Y(m_y);
//--- Сохраним размеры (в объекте)
   m_caption_bg.XSize(m_caption_bg.X_Size());
   m_caption_bg.YSize(m_caption_bg.Y_Size());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_caption_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт ярлык программы                                          |
//+------------------------------------------------------------------+
//--- Картинки (по умолчанию) символизирующие тип программы
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
//---
bool CWindow::CreateIcon(void)
  {
   string name=CElement::ProgramName()+"_window_icon_"+(string)CElement::Id();
//--- Координаты объекта
   int x=m_x+5;
   int y=m_y+2;
//--- Установим ярлык окна
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Ярлык по умолчанию, если не определён пользователем
   if(m_icon_file=="")
      m_icon_file=DefaultIcon();
//--- Установим свойства
   m_icon.BmpFileOn("::"+m_icon_file);
   m_icon.BmpFileOff("::"+m_icon_file);
   m_icon.Corner(m_corner);
   m_icon.Selectable(false);
   m_icon.Z_Order(m_button_zorder);
   m_icon.Tooltip("\n");
//--- Сохраним координаты
   m_icon.X(x);
   m_icon.Y(y);
//--- Отступы от крайней точки
   m_icon.XGap(x-m_x);
   m_icon.YGap(y-m_y);
//--- Сохраним размеры
   m_icon.XSize(m_icon.X_Size());
   m_icon.YSize(m_icon.Y_Size());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт текстовую метку заголовка                                |
//+------------------------------------------------------------------+
bool CWindow::CreateLabel(void)
  {
   string name=CElement::ProgramName()+"_window_label_"+(string)CElement::Id();
//--- Координаты объекта
   int x=m_x+24;
   int y=m_y+4;
//--- Установим текстовую метку
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_label.Description(m_caption_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(clrBlack);
   m_label.Corner(m_corner);
   m_label.Selectable(false);
   m_label.Z_Order(m_button_zorder);
   m_label.Tooltip("\n");
//--- Сохраним координаты
   m_label.X(x);
   m_label.Y(y);
//--- Отступы от крайней точки
   m_label.XGap(x-m_x);
   m_label.YGap(y-m_y);
//--- Сохраним размеры
   m_label.XSize(m_label.X_Size());
   m_label.YSize(m_label.Y_Size());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку закрытия программы                                |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_red.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_black.bmp"
//---
bool CWindow::CreateButtonClose(void)
  {
//--- Если тип программы "скрипт", выйдем
   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_window_close_"+(string)CElement::Id();
//--- Координаты объекта
   int x=m_x+m_x_size-CLOSE_BUTTON_OFFSET;
   int y=m_y+2;
//--- Увеличим область захвата
   m_right_limit+=20;
//--- Установим кнопку
   if(!m_button_close.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_button_close.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Close_red.bmp");
   m_button_close.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Close_black.bmp");
   m_button_close.Corner(m_corner);
   m_button_close.Selectable(false);
   m_button_close.Z_Order(m_button_zorder);
   m_button_close.Tooltip("Close");
//--- Сохраним координаты
   m_button_close.X(x);
   m_button_close.Y(y);
//--- Отступы от крайней точки
   m_button_close.XGap(x-m_x);
   m_button_close.YGap(y-m_y);
//--- Сохраним размеры
   m_button_close.XSize(m_button_close.X_Size());
   m_button_close.YSize(m_button_close.Y_Size());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_button_close);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку для сворачивания окна                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp"
//---
bool CWindow::CreateButtonRollUp(void)
  {
//--- Если тип программы "скрипт", выйдем
   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);
//--- Эта кнопка не нужна, если окно диалоговое
   if(m_window_type==W_DIALOG)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_window_rollup_"+(string)CElement::Id();
//--- Координаты объекта
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- Увеличим область захвата, если окно развёрнуто
   if(!m_is_minimized)
      m_right_limit+=20;
//--- Установим кнопку
   if(!m_button_rollup.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_button_rollup.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp");
   m_button_rollup.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp");
   m_button_rollup.Corner(m_corner);
   m_button_rollup.Selectable(false);
   m_button_rollup.Z_Order(m_button_zorder);
   m_button_rollup.Tooltip("Roll Up");
//--- Сохраним координаты
   m_button_rollup.X(x);
   m_button_rollup.Y(y);
//--- Отступы от крайней точки
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.YGap(y-m_y);
//--- Сохраним размеры (в объекте)
   m_button_rollup.XSize(m_button_rollup.X_Size());
   m_button_rollup.YSize(m_button_rollup.Y_Size());
//--- Скрыть объект
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
//--- Добавим объекты в массив группы
   CElement::AddToArray(m_button_rollup);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку для разворачивания окна                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp"
//---
bool CWindow::CreateButtonUnroll(void)
  {
//--- Если тип программы "скрипт", выйдем
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- Эта кнопка не нужна, если окно диалоговое
   if(m_window_type==W_DIALOG)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_window_unroll_"+(string)CElement::Id();
//--- Координаты объекта
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- Увеличим область захвата, если окно свёрнуто
   if(m_is_minimized)
      m_right_limit+=20;
//--- Установим кнопку
   if(!m_button_unroll.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_button_unroll.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp");
   m_button_unroll.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp");
   m_button_unroll.Corner(m_corner);
   m_button_unroll.Selectable(false);
   m_button_unroll.Z_Order(m_button_zorder);
   m_button_unroll.Tooltip("Unroll");
//--- Сохраним координаты
   m_button_unroll.X(x);
   m_button_unroll.Y(y);
//--- Отступы от крайней точки
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.YGap(y-m_y);
//--- Сохраним размеры (в объекте)
   m_button_unroll.XSize(m_button_unroll.X_Size());
   m_button_unroll.YSize(m_button_unroll.Y_Size());
//--- Добавим объекты в массив группы
   CElement::AddToArray(m_button_unroll);
//--- Скрыть объект
   if(!m_is_minimized)
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку подсказок                                         |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_light.bmp"
//---
bool CWindow::CreateButtonTooltip(void)
  {
//--- Если тип программы "скрипт", выйдем
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- Эта кнопка не нужна, если окно диалоговое
   if(m_window_type==W_DIALOG)
      return(true);
//--- Выйдем, если эта кнопка не нужна
   if(!m_tooltips_button)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_window_tooltip_"+(string)CElement::Id();
//--- Координаты объекта
   int x=m_x+m_x_size-TOOLTIP_BUTTON_OFFSET;
   int y=m_y+2;
//--- Увеличим область захвата
   m_right_limit+=20;
//--- Установим кнопку
   if(!m_button_tooltip.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_button_tooltip.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Help_light.bmp");
   m_button_tooltip.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp");
   m_button_tooltip.Corner(m_corner);
   m_button_tooltip.Selectable(false);
   m_button_tooltip.Z_Order(m_button_zorder);
   m_button_tooltip.Tooltip("Tooltips");
//--- Сохраним координаты
   m_button_tooltip.X(x);
   m_button_tooltip.Y(y);
//--- Отступы от крайней точки
   m_button_tooltip.XGap(x-m_x);
   m_button_tooltip.YGap(y-m_y);
//--- Сохраним размеры (в объекте)
   m_button_tooltip.XSize(m_button_tooltip.X_Size());
   m_button_tooltip.YSize(m_button_tooltip.Y_Size());
//--- Добавим объекты в массив группы
   CElement::AddToArray(m_button_tooltip);
   return(true);
  }
//+------------------------------------------------------------------+
//| Изменяет тект заголовка                                          |
//+------------------------------------------------------------------+
void CWindow::CaptionText(const string text)
  {
   m_caption_text=text;
   m_label.Description(text);
  }
//+------------------------------------------------------------------+
//| Определение ярлыка по умолчанию                                  |
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
//| Режим сворачивания подокна индикатора                            |
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
//| Изменяет высоту подокна индикатора                               |
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
//| Изменяет ширину окна                                             |
//+------------------------------------------------------------------+
void CWindow::ChangeWindowWidth(const int width)
  {
//--- Если ширина не изменилась, выйдем
   if(width==m_bg.XSize())
      return;
//--- Обновим ширину для фона и заголовка
   CElement::XSize(width);
   m_bg.XSize(width);
   m_bg.X_Size(width);
   m_caption_bg.XSize(width);
   m_caption_bg.X_Size(width);
//--- Обновим координаты и отступы для всех кнопок:
//    Кнопка закрытия
   int x=CElement::X2()-CLOSE_BUTTON_OFFSET;
   m_button_close.X(x);
   m_button_close.XGap(x-m_x);
   m_button_close.X_Distance(x);
//--- Кнопка разворачивания
   x=CElement::X2()-ROLL_BUTTON_OFFSET;
   m_button_unroll.X(x);
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.X_Distance(x);
//--- Кнопка сворачивания
   m_button_rollup.X(x);
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.X_Distance(x);
//--- Кнопка всплывающих подсказок (если включена)
   if(m_tooltips_button)
     {
      x=CElement::X2()-TOOLTIP_BUTTON_OFFSET;
      m_button_tooltip.X(x);
      m_button_tooltip.XGap(x-m_x);
      m_button_tooltip.X_Distance(x);
     }
  }
//+------------------------------------------------------------------+
//| Получение размеров графика                                       |
//+------------------------------------------------------------------+
void CWindow::SetWindowProperties(void)
  {
//--- Получим ширину и высоту окна графика
   m_chart_width  =m_chart.WidthInPixels();
   m_chart_height =m_chart.HeightInPixels(m_subwin);
  }
//+------------------------------------------------------------------+
//| Преобразует координату Y в относительную                         |
//+------------------------------------------------------------------+
int CWindow::YToRelative(const int y)
  {
//--- Получим расстояние от верха графика до подокна индикатора
   int chart_y_distance=m_chart.SubwindowY(m_subwin);
//--- Преобразуем координату Y в относительную
   return(y-chart_y_distance);
  }
//+------------------------------------------------------------------+
//| Проверка положения курсора в области заголовка окна              |
//+------------------------------------------------------------------+
bool CWindow::CursorInsideCaption(const int x,const int y)
  {
   return(x>m_x && x<X2()-m_right_limit && y>m_y && y<m_caption_bg.Y2());
  }
//+------------------------------------------------------------------+
//| Обнуление переменных связанных с перемещением окна и             |
//| состоянием левой кнопки мыши                                     |
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
//| Проверяет состояние кнопки мыши                                  |
//+------------------------------------------------------------------+
void CWindow::CheckMouseButtonState(const int x,const int y,const string state)
  {
//--- Если кнопка отжата
   if(state=="0")
     {
      //--- Обнулим переменные
      ZeroPanelVariables();
      return;
     }
//--- Если кнопка нажата
   if(state=="1")
     {
      //--- Выйдем, если состояние уже зафиксировано
      if(m_clamping_area_mouse!=NOT_PRESSED)
         return;
      //--- Вне области панели
      if(!CElement::MouseFocus())
         m_clamping_area_mouse=PRESSED_OUTSIDE;
      //--- В области панели
      else
        {
         //--- Если внутри заголовка
         if(CursorInsideCaption(x,y))
           {
            m_clamping_area_mouse=PRESSED_INSIDE_HEADER;
            return;
           }
         //--- Если в области окна
         m_clamping_area_mouse=PRESSED_INSIDE_WINDOW;
        }
     }
  }
//+------------------------------------------------------------------+
//| Проверка фокуса мыши                                             |
//+------------------------------------------------------------------+
void CWindow::CheckMouseFocus(const int x,const int y,const int subwin)
  {
//--- Если курсор в зоне окна программы
   if(subwin==m_subwin)
     {
      //--- Если сейчас не в режиме перемещения формы
      if(m_clamping_area_mouse!=PRESSED_INSIDE_HEADER)
        {
         //--- Проверим местоположение курсора
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
//| Установим состояние графика                                      |
//+------------------------------------------------------------------+
void CWindow::SetChartState(const int subwindow_number)
  {
//--- Если (курсор в области панели и кнопка мыши отжата) или
//    кнопка мыши была нажата внутри области формы или заголовка
   if((CElement::MouseFocus() && m_clamping_area_mouse==NOT_PRESSED) || 
      m_clamping_area_mouse==PRESSED_INSIDE_WINDOW ||
      m_clamping_area_mouse==PRESSED_INSIDE_HEADER ||
      m_custom_event_chart_state)
     {
      //--- Отключим скролл и управление торговыми уровнями
      m_chart.MouseScroll(false);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,false);
     }
//--- Включим управление, если курсор вне зоны окна
   else
     {
      m_chart.MouseScroll(true);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
     }
  }
//+------------------------------------------------------------------+
//| Обновление координат окна                                        |
//+------------------------------------------------------------------+
void CWindow::UpdateWindowXY(const int x,const int y)
  {
//--- Если установлен режим фиксированной формы
   if(!m_movable)
      return;
//---  
   int new_x_point =0; // Новая координата X
   int new_y_point =0; // Новая координата Y
//--- Лимиты
   int limit_top    =0;
   int limit_left   =0;
   int limit_bottom =0;
   int limit_right  =0;
//--- Если кнопка мыши нажата
   if((bool)m_clamping_area_mouse)
     {
      //--- Запомним текущие координаты XY курсора
      if(m_prev_y==0 || m_prev_x==0)
        {
         m_prev_y=y;
         m_prev_x=x;
        }
      //--- Запомним расстояние от крайней точки формы до курсора
      if(m_size_fixing_y==0 || m_size_fixing_x==0)
        {
         m_size_fixing_y=m_y-m_prev_y;
         m_size_fixing_x=m_x-m_prev_x;
        }
     }
//--- Установим лимиты
   limit_top    =y-::fabs(m_size_fixing_y);
   limit_left   =x-::fabs(m_size_fixing_x);
   limit_bottom =m_y+m_caption_height;
   limit_right  =m_x+m_x_size;
//--- Если не выходим за пределы графика вниз/вверх/вправо/влево
   if(limit_bottom<m_chart_height && limit_top>=0 && 
      limit_right<m_chart_width && limit_left>=0)
     {
      new_y_point =y+m_size_fixing_y;
      new_x_point =x+m_size_fixing_x;
     }
//--- Если вышли из границ графика
   else
     {
      if(limit_bottom>m_chart_height) // > вниз
        {
         new_y_point =m_chart_height-m_caption_height;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_top<0) // > вверх
        {
         new_y_point =0;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_right>m_chart_width) // > вправо
        {
         new_x_point =m_chart_width-m_x_size;
         new_y_point =y+m_size_fixing_y;
        }
      if(limit_left<0) // > влево
        {
         new_x_point =0;
         new_y_point =y+m_size_fixing_y;
        }
     }
//--- Обновим координаты, если было перемещение
   if(new_x_point>0 || new_y_point>0)
     {
      //--- Скорректируем координаты формы
      m_x =(new_x_point<=0)? 1 : new_x_point;
      m_y =(new_y_point<=0)? 1 : new_y_point;
      //---
      if(new_x_point>0)
         m_x=(m_x>m_chart_width-m_x_size-1) ? m_chart_width-m_x_size-1 : m_x;
      if(new_y_point>0)
         m_y=(m_y>m_chart_height-m_caption_height-1) ? m_chart_height-m_caption_height-2 : m_y;
      //--- Обнулим точки фиксации
      m_prev_x=0;
      m_prev_y=0;
     }
  }
//+------------------------------------------------------------------+
//| Устанавливает состояние окна                                     |
//+------------------------------------------------------------------+
void CWindow::State(const bool flag)
  {
//--- Если нужно заблокировать окно
   if(!flag)
     {
      //--- Установим статус
      m_is_locked=true;
      //--- Установим цвет заголовка и рамок окна
      m_bg.Color(m_caption_bg_color_off);
      m_caption_bg.Color(m_caption_bg_color_off);
      m_caption_bg.BackColor(m_caption_bg_color_off);
      //--- Сигнал на сброс цвета. Сброс будет и для других элементов.
      ::EventChartCustom(m_chart_id,ON_RESET_WINDOW_COLORS,(long)CElement::Id(),0,"");
     }
//--- Если нужно разблокировать окно
   else
     {
      //--- Установим статус
      m_is_locked=false;
      //--- Установим цвет заголовка
      m_bg.Color(m_border_color);
      m_caption_bg.Color(m_border_color);
      m_caption_bg.BackColor(m_caption_bg_color);
      //--- Сброс фокуса
      CElement::MouseFocus(false);
     }
  }
//+------------------------------------------------------------------+
//| Сброс цвета окна                                                 |
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
//| Перемещение окна                                                 |
//+------------------------------------------------------------------+
void CWindow::Moving(const int x,const int y)
  {
//--- Сохранение координат в переменных
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
//--- Обновление координат графических объектов
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
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CWindow::Delete(void)
  {
//--- Обнуление переменных
   m_right_limit=0;
//--- Удаление объектов
   m_bg.Delete();
   m_caption_bg.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_button_close.Delete();
   m_button_rollup.Delete();
   m_button_unroll.Delete();
   m_button_tooltip.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Обнуление фокуса элемента
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CWindow::ChangeObjectsColor(void)
  {
//--- Изменение картинки в кнопках
   m_button_close.State(m_button_close.MouseFocus());
   m_button_rollup.State(m_button_rollup.MouseFocus());
   m_button_unroll.State(m_button_unroll.MouseFocus());
//--- Изменение цвета в заголовке
   CElement::ChangeObjectColor(m_caption_bg.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,
                               m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
  }
//+------------------------------------------------------------------+
//| Показывает окно                                                  |
//+------------------------------------------------------------------+
void CWindow::Show(void)
  {
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
//--- Обнуление фокуса
   CElement::MouseFocus(false);
   m_button_close.MouseFocus(false);
   m_button_close.State(false);
//--- Отправить сообщение об этом
   ::EventChartCustom(m_chart_id,ON_OPEN_DIALOG_BOX,(long)CElement::Id(),0,m_program_name);
  }
//+------------------------------------------------------------------+
//| Скрывает окно                                                    |
//+------------------------------------------------------------------+
void CWindow::Hide(void)
  {
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка всех объектов окна                                   |
//+------------------------------------------------------------------+
void CWindow::Reset(void)
  {
//--- Скрыть все объекты формы
   Hide();
//--- Отобразить в последовательности их создания
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- В зависимости от режима отобразить нужную кнопку
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   else
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
//--- Сброс фокуса
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
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
//| Сброс приоритетов                                                |
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
//| Закрытие диалогового окна или программы                          |
//+------------------------------------------------------------------+
bool CWindow::CloseWindow(const string pressed_object)
  {
//--- Если было нажатие не на кнопке закрытия окна
   if(pressed_object!=m_button_close.Name())
      return(false);
//--- Если это главное окно
   if(m_window_type==W_MAIN)
     {
      //--- Если программа типа "Эксперт"
      if(CElement::ProgramType()==PROGRAM_EXPERT)
        {
         string text="Удалить программу с графика?";
         //--- Откроем диалоговое окно
         int mb_res=::MessageBox(text,NULL,MB_YESNO|MB_ICONQUESTION);
         //--- Если нажата кнопка "Да", то удалим программу с графика
         if(mb_res==IDYES)
           {
            ::Print(__FUNCTION__," > Программа была удалена с графика по Вашему решению!");
            //--- Удаление эксперта с графика
            ::ExpertRemove();
            return(true);
           }
        }
      //--- Если программа типа "Индикатор"
      else if(CElement::ProgramType()==PROGRAM_INDICATOR)
        {
         //--- Удаление индикатора с графика
         if(::ChartIndicatorDelete(m_chart_id,m_subwin,CElement::ProgramName()))
           {
            ::Print(__FUNCTION__," > Программа была удалена с графика по Вашему решению!");
            return(true);
           }
        }
     }
//--- Если это диалоговое окно
   else if(m_window_type==W_DIALOG)
     {
      //--- Закроем его
      CloseDialogBox();
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Закрытие диалогового окна                                        |
//+------------------------------------------------------------------+
void CWindow::CloseDialogBox(void)
  {
//--- Состояние видимости
   CElement::IsVisible(false);
//--- Отправить сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLOSE_DIALOG_BOX,CElement::Id(),m_prev_active_window_index,m_caption_text);
  }
//+------------------------------------------------------------------+
//| Проверка на события сворачивания/разворачивания окна             |
//+------------------------------------------------------------------+
bool CWindow::ChangeWindowState(const string pressed_object)
  {
//--- Если была нажата кнопка "Свернуть окно"
   if(pressed_object==m_button_rollup.Name())
     {
      RollUp();
      return(true);
     }
//--- Если была нажата кнопка "Развернуть окно"
   if(pressed_object==m_button_unroll.Name())
     {
      Unroll();
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Сворачивает окно                                                 |
//+------------------------------------------------------------------+
void CWindow::RollUp(void)
  {
//--- Заменить кнопку
   m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   m_button_unroll.Timeframes(OBJ_ALL_PERIODS);
//--- Установить и запомнить размер
   m_bg.Y_Size(m_caption_height);
   CElement::YSize(m_caption_height);
//--- Отключить кнопку
   m_button_unroll.MouseFocus(false);
   m_button_unroll.State(false);
//--- Состояние формы "Свёрнуто"
   m_is_minimized=true;
//--- Если это индикатор в подокне с фиксированной высотой и с режимом сворачивания подокна,
//    установим размер для подокна индикатора
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_caption_height+3);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_WINDOW_ROLLUP,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
//| Разворачивает окно                                               |
//+------------------------------------------------------------------+
void CWindow::Unroll(void)
  {
//--- Заменить кнопку
   m_button_unroll.Timeframes(OBJ_NO_PERIODS);
   m_button_rollup.Timeframes(OBJ_ALL_PERIODS);
//--- Установить и запомнить размер
   m_bg.Y_Size(m_bg_full_height);
   CElement::YSize(m_bg_full_height);
//--- Отключить кнопку
   m_button_rollup.MouseFocus(false);
   m_button_rollup.State(false);
//--- Состояние формы "Развёрнуто"
   m_is_minimized=false;
//--- Если это индикатор в подокне с фиксированной высотой и с режимом сворачивания подокна,
//    установим размер для подокна индикатора
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_subwindow_height);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_WINDOW_UNROLL,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
