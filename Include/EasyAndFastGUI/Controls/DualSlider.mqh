//+------------------------------------------------------------------+
//|                                                   DualSlider.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| Класс для создания двухстороннего слайдера с полями ввода        |
//+------------------------------------------------------------------+
class CDualSlider : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания элемента
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_left_edit;
   CEdit             m_right_edit;
   CSeparateLine     m_slot;
   CRectLabel        m_indicator;
   CRectLabel        m_left_thumb;
   CRectLabel        m_right_thumb;
   //--- Цвет общего фона
   color             m_area_color;
   //--- Текст чек-бокса
   string            m_label_text;
   //--- Цвета текстовой метки в разных состояниях
   color             m_label_color;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- Текущие значения в полях ввода
   double            m_left_edit_value;
   double            m_right_edit_value;
   //--- Размеры поля ввода
   int               m_edit_x_size;
   int               m_edit_y_size;
   //--- Цвета поля ввода в разных состояниях
   color             m_edit_color;
   color             m_edit_color_locked;
   //--- Цвета текста поля ввода в разных состояниях
   color             m_edit_text_color;
   color             m_edit_text_color_locked;
   //--- Цвета рамки поля ввода в разных состояниях
   color             m_edit_border_color;
   color             m_edit_border_color_hover;
   color             m_edit_border_color_locked;
   color             m_edit_border_color_array[];
   //--- Размер прорези
   int               m_slot_y_size;
   //--- Цвета прорези
   color             m_slot_line_dark_color;
   color             m_slot_line_light_color;
   //--- Цвета индикатора в разных состояниях
   color             m_slot_indicator_color;
   color             m_slot_indicator_color_locked;
   //--- Размеры ползунка слайдера
   int               m_thumb_x_size;
   int               m_thumb_y_size;
   //--- Цвета ползунка слайдера
   color             m_thumb_color;
   color             m_thumb_color_hover;
   color             m_thumb_color_locked;
   color             m_thumb_color_pressed;
   //--- Приоритеты на нажатие левой кнопкой мыши
   int               m_zorder;
   int               m_area_zorder;
   int               m_edit_zorder;
   //--- (1) Минимальное и (2) максимальное значение, (3) шаг изменения значения
   double            m_min_value;
   double            m_max_value;
   double            m_step_value;
   //--- Количество знаков после запятой
   int               m_digits;
   //--- Режим выравнивания текста
   ENUM_ALIGN_MODE   m_align_mode;
   //--- Состояние элемента (доступен/заблокирован)
   bool              m_slider_state;
   //--- Текущая позиция ползунков слайдера
   double            m_left_current_pos;
   double            m_left_current_pos_x;
   double            m_right_current_pos;
   double            m_right_current_pos_x;
   //--- Количество пикселей в рабочей области
   int               m_pixels_total;
   //--- Количество шагов в рабочей области
   int               m_value_steps_total;
   //--- Размер шага относительно ширины рабочей области
   double            m_position_step;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Состояние кнопки мыши (нажата/отжата)
   ENUM_THUMB_MOUSE_STATE m_clamping_mouse_left_thumb;
   ENUM_THUMB_MOUSE_STATE m_clamping_mouse_right_thumb;
   //--- Для определения режима перемещения ползунка слайдера
   bool              m_slider_thumb_state;
   //--- Переменные связанные с перемещением ползунка
   int               m_slider_size_fixing;
   int               m_slider_point_fixing;
   //---
public:
                     CDualSlider(void);
                    ~CDualSlider(void);
   //--- Методы для создания элемента
   bool              CreateSlider(const long chart_id,const int subwin,const string text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateLeftEdit(void);
   bool              CreateRightEdit(void);
   bool              CreateSlot(void);
   bool              CreateIndicator(void);
   bool              CreateLeftThumb(void);
   bool              CreateRightThumb(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращение/установка состояния элемента
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);         }
   bool              SliderState(void) const                        { return(m_slider_state);             }
   void              SliderState(const bool state);
   //--- (1) Цвет фона, (2) цвета текстовой метки
   void              AreaColor(const color clr)                     { m_area_color=clr;                   }
   void              LabelColor(const color clr)                    { m_label_color=clr;                  }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;            }
   void              LabelColorLocked(const color clr)              { m_label_color_locked=clr;           }
   //--- Размеры (1) поля ввода и (2) прорези
   void              EditXSize(const int x_size)                    { m_edit_x_size=x_size;               }
   void              EditYSize(const int y_size)                    { m_edit_y_size=y_size;               }
   void              SlotYSize(const int y_size)                    { m_slot_y_size=y_size;               }
   //--- Цвета поля ввода в разных состояниях
   void              EditColor(const color clr)                     { m_edit_color=clr;                   }
   void              EditColorLocked(const color clr)               { m_edit_color_locked=clr;            }
   //--- Цвета текста поля ввода в разных состояниях
   void              EditTextColor(const color clr)                 { m_edit_text_color=clr;              }
   void              EditTextColorLocked(const color clr)           { m_edit_text_color_locked=clr;       }
   //--- Цвета рамки поля ввода в разных состояниях
   void              EditBorderColor(const color clr)               { m_edit_border_color=clr;            }
   void              EditBorderColorHover(const color clr)          { m_edit_border_color_hover=clr;      }
   void              EditBorderColorLocked(const color clr)         { m_edit_border_color_locked=clr;     }
   //--- (1) Тёмный и (2) светлый цвет разделительной линии (прорези)
   void              SlotLineDarkColor(const color clr)             { m_slot_line_dark_color=clr;         }
   void              SlotLineLightColor(const color clr)            { m_slot_line_light_color=clr;        }
   //--- Цвета индикатора слайдера в разных состояниях
   void              SlotIndicatorColor(const color clr)            { m_slot_indicator_color=clr;         }
   void              SlotIndicatorColorLocked(const color clr)      { m_slot_indicator_color_locked=clr;  }
   //--- Размеры ползунка слайдера
   void              ThumbXSize(const int x_size)                   { m_thumb_x_size=x_size;              }
   void              ThumbYSize(const int y_size)                   { m_thumb_y_size=y_size;              }
   //--- Цвета ползунка слайдера
   void              ThumbColor(const color clr)                    { m_thumb_color=clr;                  }
   void              ThumbColorHover(const color clr)               { m_thumb_color_hover=clr;            }
   void              ThumbColorLocked(const color clr)              { m_thumb_color_locked=clr;           }
   void              ThumbColorPressed(const color clr)             { m_thumb_color_pressed=clr;          }
   //--- Минимальное значение
   double            MinValue(void)                           const { return(m_min_value);                }
   void              MinValue(const double value)                   { m_min_value=value;                  }
   //--- Максимальное значение
   double            MaxValue(void)                           const { return(m_max_value);                }
   void              MaxValue(const double value)                   { m_max_value=value;                  }
   //--- Шаг изменения значения
   double            StepValue(void)                          const { return(m_step_value);               }
   void              StepValue(const double value)                  { m_step_value=(value<=0)? 1 : value; }
   //--- (1) Количество знаков после запятой, (2) режим выравнивания текста
   void              SetDigits(const int digits)                    { m_digits=::fabs(digits);            }
   void              AlignMode(ENUM_ALIGN_MODE mode)                { m_align_mode=mode;                  }
   //--- Возвращение и установка значения в полях ввода (левое и правое)
   double            GetLeftValue(void)                       const { return(m_left_edit_value);          }
   double            GetRightValue(void)                      const { return(m_right_edit_value);         }
   bool              SetLeftValue(double value);
   bool              SetRightValue(double value);
   //--- Изменение значения в полях ввода (левое и правое)
   void              ChangeLeftValue(const double value);
   void              ChangeRightValue(const double value);
   //--- Изменение цвета объекта при наведении курсора
   void              ChangeObjectsColor(void);
   //--- Изменение цвета ползунка слайдера
   void              ChangeThumbColor(void);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Таймер
   virtual void      OnEventTimer(void);
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
   //---
private:
   //--- Обработка ввода значения в поле ввода
   bool              OnEndEdit(const string object_name);
   //--- Процесс перемещения ползунка слайдера (левого и правого)
   void              OnDragLeftThumb(const int x);
   void              OnDragRightThumb(const int x);
   //--- Обновление положения ползунка слайдера (левого и правого)
   void              UpdateLeftThumb(const int new_x_point);
   void              UpdateRightThumb(const int new_x_point);
   //--- Проверяет состояние кнопки мыши над ползунком слайдера
   void              CheckMouseOnLeftThumb(void);
   void              CheckMouseOnRightThumb(void);
   //--- Обнуление переменных связанных с перемещением ползунка слайдера
   void              ZeroThumbVariables(void);
   //--- Расчёт значений (шаги и коэффициенты)
   bool              CalculateCoefficients(void);
   //--- Расчёт координаты X ползунка слайдера (левого и правого)
   void              CalculateLeftThumbX(void);
   void              CalculateRightThumbX(void);
   //--- Изменяет позицию левого ползунка слайдера относительно значения (левого и правого)
   void              CalculateLeftThumbPos(void);
   void              CalculateRightThumbPos(void);
   //--- Обновление индикатора слайдера
   void              UpdateIndicator(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CDualSlider::CDualSlider(void) : m_digits(2),
                                 m_left_edit_value(WRONG_VALUE),
                                 m_right_edit_value(WRONG_VALUE),
                                 m_align_mode(ALIGN_LEFT),
                                 m_slider_state(true),
                                 m_slider_size_fixing(0),
                                 m_slider_point_fixing(0),
                                 m_min_value(0),
                                 m_max_value(10),
                                 m_step_value(1),
                                 m_left_current_pos(WRONG_VALUE),
                                 m_right_current_pos(WRONG_VALUE),
                                 m_area_color(C'15,15,15'),
                                 m_label_color(clrWhite),
                                 m_label_color_hover(C'85,170,255'),
                                 m_label_color_locked(clrGray),
                                 m_edit_x_size(30),
                                 m_edit_y_size(18),
                                 m_edit_color(clrWhite),
                                 m_edit_color_locked(clrDimGray),
                                 m_edit_text_color(clrBlack),
                                 m_edit_text_color_locked(clrGray),
                                 m_edit_border_color(clrGray),
                                 m_edit_border_color_hover(C'85,170,255'),
                                 m_edit_border_color_locked(clrGray),
                                 m_slot_y_size(4),
                                 m_slot_line_dark_color(C'65,65,65'),
                                 m_slot_line_light_color(clrGray),
                                 m_slot_indicator_color(clrDodgerBlue),
                                 m_slot_indicator_color_locked(clrDimGray),
                                 m_thumb_x_size(6),
                                 m_thumb_y_size(14),
                                 m_thumb_color(C'170,170,170'),
                                 m_thumb_color_hover(C'200,200,200'),
                                 m_thumb_color_locked(clrGray),
                                 m_thumb_color_pressed(C'230,230,230')
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder      =0;
   m_area_zorder =1;
   m_edit_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CDualSlider::~CDualSlider(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик события графика                                       |
//+------------------------------------------------------------------+
void CDualSlider::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт   
      if(!CElement::IsVisible())
         return;
      //--- Координаты и состояние левой кнопки мыши
      int x=(int)lparam;
      int y=(int)dparam;
      m_mouse_state=(bool)int(sparam);
      //--- Проверка фокуса над элементами
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_left_thumb.MouseFocus(x>m_left_thumb.X() && x<m_left_thumb.X2() && 
                              y>m_left_thumb.Y() && y<m_left_thumb.Y2());
      m_right_thumb.MouseFocus(x>m_right_thumb.X() && x<m_right_thumb.X2() && 
                               y>m_right_thumb.Y() && y<m_right_thumb.Y2());
      //--- Выйти, если элемент заблокирован
      if(!m_slider_state)
         return;
      //--- Проверим и запомним состояние кнопки мыши
      CheckMouseOnLeftThumb();
      CheckMouseOnRightThumb();
      //--- Изменим цвет ползунка слайдера
      ChangeThumbColor();
      //--- Если управление передано полосе слайдера (левому ползунку)
      if(m_clamping_mouse_left_thumb==THUMB_PRESSED_INSIDE)
        {
         //--- Перемещение ползунка слайдера
         OnDragLeftThumb(x);
         //--- Расчёт позиции ползунка слайдера в диапазоне значений
         CalculateLeftThumbPos();
         //--- Установка нового значения в поле ввода
         ChangeLeftValue(m_left_current_pos);
         //--- Обновляем индикатор слайдера
         UpdateIndicator();
         return;
        }
      //--- Если управление передано полосе прокрутки (правому ползунку)
      if(m_clamping_mouse_right_thumb==THUMB_PRESSED_INSIDE)
        {
         //--- Перемещение ползунка слайдера
         OnDragRightThumb(x);
         //--- Расчёт позиции ползунка слайдера в диапазоне значений
         CalculateRightThumbPos();
         //--- Установка нового значения в поле ввода
         ChangeRightValue(m_right_current_pos);
         //--- Обновляем индикатор слайдера
         UpdateIndicator();
         return;
        }
     }
//--- Обработка события изменения значения в поле ввода
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      //--- Обработка ввода значения
      if(OnEndEdit(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CDualSlider::OnEventTimer(void)
  {
//--- Если элемент выпадающий
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- Если форма и элемент не заблокированы
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт группу объектов редактируемого поля ввода                |
//+------------------------------------------------------------------+
bool CDualSlider::CreateSlider(const long chart_id,const int subwin,const string text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму  
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием двухстороннего слайдера классу нужно передать "
              "указатель на форму: CDualSlider::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =x;
   m_y          =y;
   m_label_text =text;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание элемента
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateLeftEdit())
      return(false);
   if(!CreateRightEdit())
      return(false);
   if(!CreateSlot())
      return(false);
   if(!CreateIndicator())
      return(false);
   if(!CreateLeftThumb())
      return(false);
   if(!CreateRightThumb())
      return(false);
      
//--- Расчёт координаты X левого ползунка относительно текущего значения в левом поле ввода
   CalculateLeftThumbX();
//--- Расчёт позиции левого ползунка слайдера в диапазоне значений
   CalculateLeftThumbPos();
//--- Обновляем ползунок слайдера
   UpdateLeftThumb(m_left_thumb.X());
//--- Обновляем индикатор слайдера
   UpdateIndicator();
   
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь редактируемого поля ввода                        |
//+------------------------------------------------------------------+
bool CDualSlider::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_slider_area_"+(string)CElement::Id();
//--- Установим объект
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
//m_area.Hidden(true);
   m_area.Tooltip("\n");
//--- Сохраним координаты
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- Размеры
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
//--- Отступы от крайней точки
   m_area.XGap(CElement::m_x-m_wnd.X());
   m_area.YGap(CElement::m_y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт лэйбл редактируемого поля ввода                          |
//+------------------------------------------------------------------+
bool CDualSlider::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_slider_lable_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y()+5;
//--- Установим объект
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_label.Description(m_label_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(m_label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
//m_label.Hidden(true);
   m_label.Tooltip("\n");
//--- Сохраним координаты
   m_area.X(x);
   m_area.Y(y);
//--- Отступы от крайней точки
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт левое поле ввода                                         |
//+------------------------------------------------------------------+
bool CDualSlider::CreateLeftEdit(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_slider_left_edit_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X2()-(m_edit_x_size*2)-5;
   int y=CElement::Y()+3;
//--- Установим объект
   if(!m_left_edit.Create(m_chart_id,name,m_subwin,x,y,m_edit_x_size,m_edit_y_size))
      return(false);
//--- Установим свойства
   m_left_edit.Font(FONT);
   m_left_edit.FontSize(FONT_SIZE);
   m_left_edit.TextAlign(m_align_mode);
   m_left_edit.Description(::DoubleToString(m_left_edit_value,m_digits));
   m_left_edit.Color(m_edit_text_color);
   m_left_edit.BorderColor(m_edit_border_color);
   m_left_edit.BackColor(m_edit_color);
   m_left_edit.Corner(m_corner);
   m_left_edit.Anchor(m_anchor);
   m_left_edit.Selectable(false);
   m_left_edit.Z_Order(m_edit_zorder);
//m_left_edit.Hidden(true);
   m_left_edit.Tooltip("\n");
//--- Сохраним координаты
   m_left_edit.X(x);
   m_left_edit.Y(y);
//--- Размеры
   m_left_edit.XSize(m_edit_x_size);
   m_left_edit.YSize(m_edit_y_size);
//--- Отступы от крайней точки
   m_left_edit.XGap(x-m_wnd.X());
   m_left_edit.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   InitColorArray(m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_left_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт правое поле ввода                                        |
//+------------------------------------------------------------------+
bool CDualSlider::CreateRightEdit(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_slider_right_edit_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X2()-m_edit_x_size;
   int y=CElement::Y()+3;
//--- Установим объект
   if(!m_right_edit.Create(m_chart_id,name,m_subwin,x,y,m_edit_x_size,m_edit_y_size))
      return(false);
//--- Установим свойства
   m_right_edit.Font(FONT);
   m_right_edit.FontSize(FONT_SIZE);
   m_right_edit.TextAlign(m_align_mode);
   m_right_edit.Description(::DoubleToString(m_right_edit_value,m_digits));
   m_right_edit.Color(m_edit_text_color);
   m_right_edit.BorderColor(m_edit_border_color);
   m_right_edit.BackColor(m_edit_color);
   m_right_edit.Corner(m_corner);
   m_right_edit.Anchor(m_anchor);
   m_right_edit.Selectable(false);
   m_right_edit.Z_Order(m_edit_zorder);
//m_right_edit.Hidden(true);
   m_right_edit.Tooltip("\n");
//--- Сохраним координаты
   m_right_edit.X(x);
   m_right_edit.Y(y);
//--- Размеры
   m_right_edit.XSize(m_edit_x_size);
   m_right_edit.YSize(m_edit_y_size);
//--- Отступы от крайней точки
   m_right_edit.XGap(x-m_wnd.X());
   m_right_edit.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   InitColorArray(m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_right_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт прорезь для полосы прокрутки                             |
//+------------------------------------------------------------------+
bool CDualSlider::CreateSlot(void)
  {
//--- Сохраним указатель формы
   m_slot.WindowPointer(m_wnd);
//--- Установим свойства
   m_slot.TypeSepLine(H_SEP_LINE);
   m_slot.DarkColor(m_slot_line_dark_color);
   m_slot.LightColor(m_slot_line_light_color);
//--- Создание разделительной линии
   if(!m_slot.CreateSeparateLine(m_chart_id,m_subwin,0,CElement::X(),CElement::Y()+30,CElement::XSize(),m_slot_y_size))
      return(false);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_slot.Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт индикатор полосы прокрутки                               |
//+------------------------------------------------------------------+
bool CDualSlider::CreateIndicator(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_slider_indicator_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=m_slot.Y()+1;
//--- Размер
   int y_size=m_slot_y_size-2;
//--- Установим объект
   if(!m_indicator.Create(m_chart_id,name,m_subwin,x,y,m_x_size,y_size))
      return(false);
//--- Установим свойства
   m_indicator.BackColor(m_slot_indicator_color);
   m_indicator.Color(m_slot_indicator_color);
   m_indicator.BorderType(BORDER_FLAT);
   m_indicator.Corner(m_corner);
   m_indicator.Selectable(false);
   m_indicator.Z_Order(m_zorder);
//m_indicator.Hidden(true);
   m_indicator.Tooltip("\n");
//--- Сохраним координаты
   m_indicator.X(x);
   m_indicator.Y(y);
//--- Размеры
   m_indicator.XSize(CElement::XSize());
   m_indicator.YSize(y_size);
//--- Отступы от крайней точки
   m_indicator.XGap(x-m_wnd.X());
   m_indicator.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_indicator);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт левую полосу прокрутки                                   |
//+------------------------------------------------------------------+
bool CDualSlider::CreateLeftThumb(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_slider_left_thumb_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=m_slot.Y()-((m_thumb_y_size-m_slot_y_size)/2);
//--- Установим объект
   if(!m_left_thumb.Create(m_chart_id,name,m_subwin,x,y,m_thumb_x_size,m_thumb_y_size))
      return(false);
//--- Установим свойства
   m_left_thumb.BackColor(m_thumb_color);
   m_left_thumb.Color(m_thumb_color);
   m_left_thumb.BorderType(BORDER_FLAT);
   m_left_thumb.Corner(m_corner);
   m_left_thumb.Selectable(false);
   m_left_thumb.Z_Order(m_zorder);
//m_left_thumb.Hidden(true);
   m_left_thumb.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_left_thumb.XSize(m_thumb_x_size);
   m_left_thumb.YSize(m_thumb_y_size);
//--- Сохраним координаты
   m_left_thumb.X(x);
   m_left_thumb.Y(y);
//--- Отступы от крайней точки
   m_left_thumb.XGap(x-m_wnd.X());
   m_left_thumb.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_left_thumb);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт правую полосу прокрутки                                  |
//+------------------------------------------------------------------+
bool CDualSlider::CreateRightThumb(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_slider_right_thumb_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=m_slot.Y()-((m_thumb_y_size-m_slot_y_size)/2);
//--- Установим объект
   if(!m_right_thumb.Create(m_chart_id,name,m_subwin,x,y,m_thumb_x_size,m_thumb_y_size))
      return(false);
//--- Установим свойства
   m_right_thumb.BackColor(m_thumb_color);
   m_right_thumb.Color(m_thumb_color);
   m_right_thumb.BorderType(BORDER_FLAT);
   m_right_thumb.Corner(m_corner);
   m_right_thumb.Selectable(false);
   m_right_thumb.Z_Order(m_zorder);
//m_right_thumb.Hidden(true);
   m_right_thumb.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_right_thumb.XSize(m_thumb_x_size);
   m_right_thumb.YSize(m_thumb_y_size);
//--- Сохраним координаты
   m_right_thumb.X(x);
   m_right_thumb.Y(y);
//--- Отступы от крайней точки
   m_right_thumb.XGap(x-m_wnd.X());
   m_right_thumb.YGap(y-m_wnd.Y());
//--- Расчёт значений вспомогательных переменных
   CalculateCoefficients();
//--- Расчёт координаты X ползунка относительно текущего значения в поле ввода
   CalculateRightThumbX();
//--- Расчёт позиции ползунка слайдера в диапазоне значений
   CalculateRightThumbPos();
//--- Обновляем ползунок слайдера
   UpdateRightThumb(m_right_thumb.X());
//--- Обновляем индикатор слайдера
   UpdateIndicator();
//--- Сохраним указатель объекта
   CElement::AddToArray(m_right_thumb);
   return(true);
  }
//+------------------------------------------------------------------+
//| Установка текущего значения в левое поле ввода                   |
//+------------------------------------------------------------------+
bool CDualSlider::SetLeftValue(double value)
  {
//--- Скорректируем с учетом шага
   double corrected_value=::MathRound(value/m_step_value)*m_step_value;
//--- Проверка на минимум/максимум
   if(corrected_value<=m_min_value)
      corrected_value=m_min_value;
   if(corrected_value>=m_max_value)
      corrected_value=m_max_value;
//--- Если значение было изменено
   if(m_left_edit_value!=corrected_value)
     {
      m_left_edit_value=corrected_value;
      return(true);
     }
//--- Значение без изменений
   return(false);
  }
//+------------------------------------------------------------------+
//| Изменение значения в левом поле ввода                            |
//+------------------------------------------------------------------+
void CDualSlider::ChangeLeftValue(const double value)
  {
//--- Проверим, скорректируем и запомним новое значение
   SetLeftValue(value);
//--- Установим новое значение в поле ввода
   m_left_edit.Description(::DoubleToString(GetLeftValue(),m_digits));
  }
//+------------------------------------------------------------------+
//| Установка текущего значения в правое поле ввода                  |
//+------------------------------------------------------------------+
bool CDualSlider::SetRightValue(double value)
  {
//--- Скорректируем с учетом шага
   double corrected_value=::MathRound(value/m_step_value)*m_step_value;
//--- Проверка на минимум/максимум
   if(corrected_value<=m_min_value)
      corrected_value=m_min_value;
   if(corrected_value>=m_max_value)
      corrected_value=m_max_value;
//--- Если значение было изменено
   if(m_right_edit_value!=corrected_value)
     {
      m_right_edit_value=corrected_value;
      return(true);
     }
//--- Значение без изменений
   return(false);
  }
//+------------------------------------------------------------------+
//| Изменение значения в правом поле ввода                           |
//+------------------------------------------------------------------+
void CDualSlider::ChangeRightValue(const double value)
  {
//--- Проверим, скорректируем и запомним новое значение
   SetRightValue(value);
//--- Установим новое значение в поле ввода
   m_right_edit.Description(::DoubleToString(GetRightValue(),m_digits));
  }
//+------------------------------------------------------------------+
//| Изменение состояния элемента                                     |
//+------------------------------------------------------------------+
void CDualSlider::SliderState(const bool state)
  {
//--- Состояние элемента
   m_slider_state=state;
//--- Цвет текстовой метки
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- Цвет поля ввода
   m_left_edit.Color((state)? m_edit_text_color : m_edit_text_color_locked);
   m_left_edit.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_left_edit.BorderColor((state)? m_edit_border_color : m_edit_border_color_locked);
   m_right_edit.Color((state)? m_edit_text_color : m_edit_text_color_locked);
   m_right_edit.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_right_edit.BorderColor((state)? m_edit_border_color : m_edit_border_color_locked);
//--- Цвет индикатора
   m_indicator.BackColor((state)? m_slot_indicator_color : m_slot_indicator_color_locked);
   m_indicator.Color((state)? m_slot_indicator_color : m_slot_indicator_color_locked);
//--- Цвет ползунка слайдера
   m_left_thumb.BackColor((state)? m_thumb_color : m_thumb_color_locked);
   m_left_thumb.Color((state)? m_thumb_color : m_thumb_color_locked);
   m_right_thumb.BackColor((state)? m_thumb_color : m_thumb_color_locked);
   m_right_thumb.Color((state)? m_thumb_color : m_thumb_color_locked);
//--- Настройка относительно текущего состояния
   if(!m_slider_state)
     {
      //--- Поле ввода в режим "Только чтение"
      m_left_edit.ReadOnly(true);
      m_right_edit.ReadOnly(true);
     }
   else
     {
      //--- Поле ввода в режим редактирования
      m_left_edit.ReadOnly(false);
      m_right_edit.ReadOnly(false);
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CDualSlider::ChangeObjectsColor(void)
  {
//--- Выйти, если элемент заблокирован или в режиме перемещения ползунка слайдера
   if(!m_slider_state || m_slider_thumb_state)
      return;
//---
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_left_edit.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
   CElement::ChangeObjectColor(m_right_edit.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
  }
//+------------------------------------------------------------------+
//| Изменение цвета полосы прокрутки                                 |
//+------------------------------------------------------------------+
void CDualSlider::ChangeThumbColor(void)
  {
//--- Выйти, если форма заблокирована и идентификатор активного в текущий момент элемента отличается
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- Если курсор в зоне левого ползунка слайдера
   if(m_left_thumb.MouseFocus())
     {
      //--- Если левая кнопка мыши отжата
      if(m_clamping_mouse_left_thumb==THUMB_NOT_PRESSED)
        {
         m_slider_thumb_state=false;
         m_left_thumb.Color(m_thumb_color_hover);
         m_left_thumb.BackColor(m_thumb_color_hover);
         return;
        }
      //--- Левая кнопка мыши нажата
      else if(m_clamping_mouse_left_thumb==THUMB_PRESSED_INSIDE)
        {
         m_slider_thumb_state=true;
         m_left_thumb.Color(m_thumb_color_pressed);
         m_left_thumb.BackColor(m_thumb_color_pressed);
         return;
        }
     }
//--- Если курсор вне зоны левого ползунка слайдера
   else
     {
      //--- Левая кнопка мыши отжата
      if(!m_mouse_state)
        {
         m_slider_thumb_state=false;
         m_left_thumb.Color(m_thumb_color);
         m_left_thumb.BackColor(m_thumb_color);
        }
     }
//--- Если курсор в зоне правого ползунка слайдера
   if(m_right_thumb.MouseFocus())
     {
      //--- Если левая кнопка мыши отжата     
      if(m_clamping_mouse_right_thumb==THUMB_NOT_PRESSED)
        {
         m_slider_thumb_state=false;
         m_right_thumb.Color(m_thumb_color_hover);
         m_right_thumb.BackColor(m_thumb_color_hover);
         return;
        }
      //--- Левая кнопка мыши нажата
      else if(m_clamping_mouse_right_thumb==THUMB_PRESSED_INSIDE)
        {
         m_slider_thumb_state=true;
         m_right_thumb.Color(m_thumb_color_pressed);
         m_right_thumb.BackColor(m_thumb_color_pressed);
         return;
        }
     }
//--- Если курсор вне зоны правого ползунка слайдера
   else
     {
      //--- Левая кнопка мыши отжата
      if(!m_mouse_state)
        {
         m_slider_thumb_state=false;
         m_right_thumb.Color(m_thumb_color);
         m_right_thumb.BackColor(m_thumb_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CDualSlider::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение отступов в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_left_edit.X(x+m_left_edit.XGap());
   m_left_edit.Y(y+m_left_edit.YGap());
   m_right_edit.X(x+m_right_edit.XGap());
   m_right_edit.Y(y+m_right_edit.YGap());
   m_indicator.X(x+m_indicator.XGap());
   m_indicator.Y(y+m_indicator.YGap());
   m_left_thumb.X(x+m_left_thumb.XGap());
   m_left_thumb.Y(y+m_left_thumb.YGap());
   m_right_thumb.X(x+m_right_thumb.XGap());
   m_right_thumb.Y(y+m_right_thumb.YGap());
//--- Обновление координат графических объектов  
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_left_edit.X_Distance(m_left_edit.X());
   m_left_edit.Y_Distance(m_left_edit.Y());
   m_right_edit.X_Distance(m_right_edit.X());
   m_right_edit.Y_Distance(m_right_edit.Y());
   m_indicator.X_Distance(m_indicator.X());
   m_indicator.Y_Distance(m_indicator.Y());
   m_left_thumb.X_Distance(m_left_thumb.X());
   m_left_thumb.Y_Distance(m_left_thumb.Y());
   m_right_thumb.X_Distance(m_right_thumb.X());
   m_right_thumb.Y_Distance(m_right_thumb.Y());
//--- Перемещение прорези
   m_slot.Moving(x,y);
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CDualSlider::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Показать прорезь
   m_slot.Show();
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CDualSlider::Hide(void)
  {
//--- Выйти, если элемент уже видим
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть прорезь
   m_slot.Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CDualSlider::Reset(void)
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
void CDualSlider::Delete(void)
  {
//--- Удаление объектов  
   m_area.Delete();
   m_label.Delete();
   m_left_edit.Delete();
   m_right_edit.Delete();
   m_slot.Delete();
   m_indicator.Delete();
   m_left_thumb.Delete();
   m_right_thumb.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CDualSlider::SetZorders(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_slider_state)
      return;
//--- Установим значения по умолчанию
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_zorder);
   m_left_edit.Z_Order(m_edit_zorder);
   m_right_edit.Z_Order(m_edit_zorder);
   m_indicator.Z_Order(m_zorder);
   m_left_thumb.Z_Order(m_zorder);
   m_right_thumb.Z_Order(m_zorder);
//--- Поля ввода в режим редактирования
   m_left_edit.ReadOnly(false);
   m_right_edit.ReadOnly(false);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CDualSlider::ResetZorders(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_slider_state)
      return;
//--- Обнуление приоритетов
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_left_edit.Z_Order(0);
   m_right_edit.Z_Order(0);
   m_indicator.Z_Order(0);
   m_left_thumb.Z_Order(0);
   m_right_thumb.Z_Order(0);
//--- Поле ввода в режим "Только чтение"
   m_left_edit.ReadOnly(true);
   m_right_edit.ReadOnly(true);
  }
//+------------------------------------------------------------------+
//| Окончание ввода значения                                         |
//+------------------------------------------------------------------+
bool CDualSlider::OnEndEdit(const string object_name)
  {
//--- Если ввод значения в левое поле
   if(object_name==m_left_edit.Name())
     {
      //--- Получим только что введённое значение
      double entered_value=::StringToDouble(m_left_edit.Description());
      //--- Проверим, скорректируем и запомним новое значение
      ChangeLeftValue(entered_value);
      //--- Рассчитаем координату X ползунка
      CalculateLeftThumbX();
      //--- Обновление положения ползунка слайдера
      UpdateLeftThumb(m_left_thumb.X());
      //--- Рассчитаем позицию в диапазоне значений
      CalculateLeftThumbPos();
      //--- Установка нового значения в поле ввода
      ChangeLeftValue(m_left_current_pos);
      //--- Обновляем индикатор слайдера
      UpdateIndicator();
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),CElement::Index(),m_label.Description());
      return(true);
     }
//--- Если ввод значения в правое поле
   if(object_name==m_right_edit.Name())
     {
      //--- Получим только что введённое значение
      double entered_value=::StringToDouble(m_right_edit.Description());
      //--- Проверим, скорректируем и запомним новое значение
      ChangeRightValue(entered_value);
      //--- Рассчитаем координату X ползунка
      CalculateRightThumbX();
      //--- Обновление положения ползунка слайдера
      UpdateRightThumb(m_right_thumb.X());
      //--- Рассчитаем позицию в диапазоне значений
      CalculateRightThumbPos();
      //--- Установка нового значения в поле ввода
      ChangeRightValue(m_right_current_pos);
      //--- Обновляем индикатор слайдера
      UpdateIndicator();
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),CElement::Index(),m_label.Description());
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Процесс перемещения левого ползунка слайдера                     |
//+------------------------------------------------------------------+
void CDualSlider::OnDragLeftThumb(const int x)
  {
//--- Для определения новой X координаты  
   int new_x_point=0;
//--- Если ползунок слайдера неактивен, ...
   if(!m_slider_thumb_state)
     {
      //--- ...обнулим вспомогательные переменные для перемещения ползунка
      m_slider_point_fixing =0;
      m_slider_size_fixing  =0;
      return;
     }
//--- Если точка фиксации нулевая, то запомним текущую координату курсора
   if(m_slider_point_fixing==0)
      m_slider_point_fixing=x;
//--- Если значение расстояния от крайней точки ползунка до текущей координаты курсора нулевое, рассчитаем его
   if(m_slider_size_fixing==0)
      m_slider_size_fixing=m_left_thumb.X()-x;
//--- Если в нажатом состоянии прошли порог вправо
   if(x-m_slider_point_fixing>0)
     {
      //--- Рассчитаем координату X
      new_x_point=x+m_slider_size_fixing;
      //--- Обновление положения полосы прокрутки
      UpdateLeftThumb(new_x_point);
      return;
     }
//--- Если в нажатом состоянии прошли порог влево
   if(x-m_slider_point_fixing<0)
     {
      //--- Рассчитаем координату X
      new_x_point=x-::fabs(m_slider_size_fixing);
      //--- Обновление положения полосы прокрутки
      UpdateLeftThumb(new_x_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Процесс перемещения правого ползунка слайдера                    |
//+------------------------------------------------------------------+
void CDualSlider::OnDragRightThumb(const int x)
  {
//--- Для определения новой X координаты  
   int new_x_point=0;
//--- Если ползунок слайдера неактивен, ...
   if(!m_slider_thumb_state)
     {
      //--- ...обнулим вспомогательные переменные для перемещения ползунка
      m_slider_point_fixing =0;
      m_slider_size_fixing  =0;
      return;
     }
//--- Если точка фиксации нулевая, то запомним текущую координату курсора
   if(m_slider_point_fixing==0)
      m_slider_point_fixing=x;
//--- Если значение расстояния от крайней точки ползунка до текущей координаты курсора нулевое, рассчитаем его
   if(m_slider_size_fixing==0)
      m_slider_size_fixing=m_right_thumb.X()-x;
//--- Если в нажатом состоянии прошли порог вправо
   if(x-m_slider_point_fixing>0)
     {
      //--- Рассчитаем координату X
      new_x_point=x+m_slider_size_fixing;
      //--- Обновление положения полосы прокрутки
      UpdateRightThumb(new_x_point);
      return;
     }
//--- Если в нажатом состоянии прошли порог влево
   if(x-m_slider_point_fixing<0)
     {
      //--- Рассчитаем координату X
      new_x_point=x-::fabs(m_slider_size_fixing);
      //--- Обновление положения полосы прокрутки
      UpdateRightThumb(new_x_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Обновление положения левого ползунка слайдера                    |
//+------------------------------------------------------------------+
void CDualSlider::UpdateLeftThumb(const int new_x_point)
  {
   int x=new_x_point;
//--- Обнуление точки фиксации
   m_slider_point_fixing=0;
//--- Проверка на выход из рабочей области
   if(new_x_point<m_area.X())
      x=m_area.X();
   int right_limit=m_right_thumb.X()-m_right_thumb.XSize();
   if(new_x_point>=right_limit)
      x=right_limit-1;
//--- Обновим список и скролл
   m_left_thumb.X(x);
   m_left_thumb.X_Distance(x);
//--- Сохраним отступы
   m_left_thumb.XGap(m_left_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Обновление положения правого ползунка слайдера                   |
//+------------------------------------------------------------------+
void CDualSlider::UpdateRightThumb(const int new_x_point)
  {
   int x=new_x_point;
//--- Обнуление точки фиксации
   m_slider_point_fixing=0;
//--- Проверка на выход из рабочей области
   int right_limit=m_area.X2()-m_right_thumb.XSize();
   if(new_x_point>right_limit)
      x=right_limit;
   if(new_x_point<=m_left_thumb.X2())
      x=m_left_thumb.X2()+1;
//--- Обновим список и скролл
   m_right_thumb.X(x);
   m_right_thumb.X_Distance(x);
//--- Сохраним отступы
   m_right_thumb.XGap(m_right_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Расчёт значений (шаги и коэффициенты)                            |
//+------------------------------------------------------------------+
bool CDualSlider::CalculateCoefficients(void)
  {
//--- Выйти, если ширина элемента меньше, чем ширина ползунка слайдера
   if(CElement::XSize()<m_thumb_x_size*2+1)
      return(false);
//--- Количество пикселей в рабочей области
   m_pixels_total=CElement::XSize()-m_thumb_x_size;
//--- Количество шагов в диапазоне значений рабочей области
   m_value_steps_total=int((m_max_value-m_min_value)/m_step_value);
//--- Размер шага относительно ширины рабочей области
   m_position_step=m_step_value*(double(m_value_steps_total)/double(m_pixels_total));
   return(true);
  }
//+------------------------------------------------------------------+
//| Расчёт координаты X левого ползунка слайдера                     |
//+------------------------------------------------------------------+
void CDualSlider::CalculateLeftThumbX(void)
  {
//--- Корректировка с учётом того, что минимальное значение может быть отрицательным
   double neg_range=(m_min_value<0)? ::fabs(m_min_value/m_position_step) : 0;
//--- Рассчитаем координату X для ползунка слайдера
   m_left_current_pos_x=m_area.X()+(m_left_edit_value/m_position_step)+neg_range;
//--- Если выходим за пределы рабочей области влево
   if(m_left_current_pos_x<m_area.X())
      m_left_current_pos_x=m_area.X();
//--- Если выходим за пределы рабочей области вправо
   if(m_left_current_pos_x>m_right_thumb.X())
      m_left_current_pos_x=m_right_thumb.X()-m_left_thumb.XSize();
//--- Сохраним и установим новую координату X
   m_left_thumb.X(int(m_left_current_pos_x));
   m_left_thumb.X_Distance(int(m_left_current_pos_x));
   m_left_thumb.XGap(m_left_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Расчёт координаты X правого ползунка слайдера                    |
//+------------------------------------------------------------------+
void CDualSlider::CalculateRightThumbX(void)
  {
//--- Корректировка с учётом того, что минимальное значение может быть отрицательным
   double neg_range=(m_min_value<0)? ::fabs(m_min_value/m_position_step) : 0;
//--- Рассчитаем координату X для ползунка слайдера
   m_right_current_pos_x=m_area.X()+(m_right_edit_value/m_position_step)+neg_range;
//--- Если выходим за пределы рабочей области влево
   if(m_right_current_pos_x<m_area.X())
      m_right_current_pos_x=m_area.X();
//--- Если выходим за пределы рабочей области вправо
   if(m_right_current_pos_x+m_right_thumb.XSize()>m_area.X2())
      m_right_current_pos_x=m_area.X2()-m_right_thumb.XSize();
//--- Сохраним и установим новую координату X
   m_right_thumb.X(int(m_right_current_pos_x));
   m_right_thumb.X_Distance(int(m_right_current_pos_x));
   m_right_thumb.XGap(m_right_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Изменяет позицию левого ползунка слайдера относительно значения  |
//+------------------------------------------------------------------+
void CDualSlider::CalculateLeftThumbPos(void)
  {
//--- Получим номер позиции ползунка слайдера
   m_left_current_pos=(m_left_thumb.X()-m_area.X())*m_position_step;
//--- Корректировка с учётом того, что минимальное значение может быть отрицательным
   if(m_min_value<0 && m_left_current_pos_x!=WRONG_VALUE)
      m_left_current_pos+=int(m_min_value);
//--- Проверка на выход из рабочей области влево
   if(m_left_thumb.X()<=m_area.X())
      m_left_current_pos=int(m_min_value);
  }
//+------------------------------------------------------------------+
//| Изменяет позицию правого ползунка слайдера относительно значения |
//+------------------------------------------------------------------+
void CDualSlider::CalculateRightThumbPos(void)
  {
//--- Получим номер позиции ползунка слайдера
   m_right_current_pos=(m_right_thumb.X()-m_area.X())*m_position_step;
//--- Корректировка с учётом того, что минимальное значение может быть отрицательным
   if(m_min_value<0 && m_right_current_pos_x!=WRONG_VALUE)
      m_right_current_pos+=int(m_min_value);
//--- Проверка на выход из рабочей области вправо
   if(m_right_thumb.X2()>=m_area.X2())
      m_right_current_pos=int(m_max_value);
  }
//+------------------------------------------------------------------+
//| Обнуление переменных связанных с перемещением ползунка слайдера  |
//+------------------------------------------------------------------+
void CDualSlider::ZeroThumbVariables(void)
  {
//--- Если зашли сюда, то это значит, что левая кнопка мыши отжата.
//    Если до этого зажатие левой кнопки мыши было осуществлено над ползунком слайдера...
   if(m_clamping_mouse_left_thumb==THUMB_PRESSED_INSIDE || 
      m_clamping_mouse_right_thumb==THUMB_PRESSED_INSIDE)
     {
      //--- ... отправим сообщение, что изменение значения в поле ввода посредством ползунка завершена
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),CElement::Index(),m_label.Description());
     }
//---
   m_slider_size_fixing         =0;
   m_clamping_mouse_left_thumb  =THUMB_NOT_PRESSED;
   m_clamping_mouse_right_thumb =THUMB_NOT_PRESSED;
//--- Если идентификатор элемента совпадает с идентификатором активатором,
//    разблокируем форму и сбросим идентификатор активного элемента
   if(CElement::Id()==m_wnd.IdActivatedElement())
     {
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
  }
//+------------------------------------------------------------------+
//| Проверяет состояние кнопки мыши                                  |
//+------------------------------------------------------------------+
void CDualSlider::CheckMouseOnLeftThumb(void)
  {
//--- Если левая кнопка мыши отжата
   if(!m_mouse_state)
     {
      //--- Обнулим переменные
      ZeroThumbVariables();
      return;
     }
//--- Если левая кнопка мыши нажата
   else
     {
      //--- Выйдем, если кнопка уже нажата в какой-либо области
      if(m_clamping_mouse_left_thumb!=THUMB_NOT_PRESSED)
         return;
      //--- Вне области полосы прокрутки
      if(!m_left_thumb.MouseFocus())
         m_clamping_mouse_left_thumb=THUMB_PRESSED_OUTSIDE;
      //--- В области полосы прокрутки
      else
        {
         //--- Если внутри полосы
         m_clamping_mouse_left_thumb=THUMB_PRESSED_INSIDE;
         //--- Заблокируем форму и запомним идентификатор активного элемента
         m_wnd.IsLocked(true);
         m_wnd.IdActivatedElement(CElement::Id());
        }
     }
  }
//+------------------------------------------------------------------+
//| Проверяет состояние кнопки мыши                                  |
//+------------------------------------------------------------------+
void CDualSlider::CheckMouseOnRightThumb(void)
  {
//--- Если левая кнопка мыши отжата
   if(!m_mouse_state)
     {
      //--- Обнулим переменные
      ZeroThumbVariables();
      return;
     }
//--- Если левая кнопка мыши нажата
   else
     {
      //--- Выйдем, если кнопка уже нажата в какой-либо области
      if(m_clamping_mouse_right_thumb!=THUMB_NOT_PRESSED)
         return;
      //--- Вне области полосы прокрутки
      if(!m_right_thumb.MouseFocus())
         m_clamping_mouse_right_thumb=THUMB_PRESSED_OUTSIDE;
      //--- В области полосы прокрутки
      else
        {
         //--- Если внутри полосы
         m_clamping_mouse_right_thumb=THUMB_PRESSED_INSIDE;
         //--- Заблокируем форму и запомним идентификатор активного элемента
         m_wnd.IsLocked(true);
         m_wnd.IdActivatedElement(CElement::Id());
        }
     }
  }
//+------------------------------------------------------------------+
//| Обновление индикатора слайдера                                   |
//+------------------------------------------------------------------+
void CDualSlider::UpdateIndicator(void)
  {
//--- Рассчитаем размер
   int x_size=m_right_thumb.X()-m_left_thumb.X();
//--- Корректировка в случае недопустимых значений
   if(x_size<=0)
      x_size=1;
//--- Установка новых значений. (1) Координаты, (2) размер, (3) отступ
   m_indicator.X(m_left_thumb.X2());
   m_indicator.X_Distance(m_left_thumb.X2());
   m_indicator.X_Size(x_size);
   m_indicator.XGap(m_indicator.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
