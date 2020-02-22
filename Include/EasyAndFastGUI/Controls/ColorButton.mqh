//+------------------------------------------------------------------+
//|                                                  ColorButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания кнопки вызова цветовой палитры                |
//+------------------------------------------------------------------+
class CColorButton : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания элемента
   CRectLabel        m_area;
   CLabel            m_label;
   CButton           m_button;
   CRectLabel        m_button_icon;
   CLabel            m_button_label;
   //--- Цвет фона
   color             m_area_color;
   //--- Текст описания
   string            m_label_text;
   //--- Отступы для описания
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвет описания в разных состояниях
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_array[];
   //--- Размеры кнопки
   int               m_button_x_size;
   int               m_button_y_size;
   //--- Цвет кнопки в разных состояниях
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   color             m_back_color_array[];
   //--- Цвет рамки
   color             m_border_color;
   color             m_border_color_off;
   //--- Цвет текста в кнопке в разных состояниях
   color             m_button_label_color;
   color             m_button_label_color_off;
   color             m_button_label_color_hover;
   color             m_button_label_color_pressed;
   color             m_button_label_color_array[];
   //--- Доступен/заблокирован
   bool              m_button_state;
   //--- Выбранный цвет
   color             m_current_color;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_button_zorder;
   int               m_zorder;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //---
public:
                     CColorButton(void);
                    ~CColorButton(void);
   //--- Методы для создания элемента
   bool              CreateColorButton(const long chart_id,const int subwin,const string button_text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateButton(void);
   bool              CreateButtonIcon(void);
   bool              CreateButtonLabel(void);
   //---
public:
   //--- Сохраняет (1) указатель формы
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);    }
   bool              ButtonState(void) const            const { return(m_button_state);        }
   void              ButtonState(const bool state);
   //--- Цвет (1) фона элемента, (2) размеры кнопки
   void              AreaColor(const color clr)               { m_area_color=clr;              }
   void              ButtonXSize(const int x_size)            { m_button_x_size=x_size;        }
   void              ButtonYSize(const int y_size)            { m_button_y_size=y_size;        }
   //--- (1) Текст описания элемента, (2) отступы описания
   string            LabelText(void)                    const { return(m_label.Description()); }
   void              LabelXGap(const int x_gap)               { m_label_x_gap=x_gap;           }
   void              LabelYGap(const int y_gap)               { m_label_y_gap=y_gap;           }
   //--- Цвета текста описания в разных состояниях
   void              LabelColor(const color clr)              { m_label_color=clr;             }
   void              LabelColorOff(const color clr)           { m_label_color_off=clr;         }
   void              LabelColorHover(const color clr)         { m_label_color_hover=clr;       }
   //--- Цвета фона кнопки в разных состояниях
   void              BackColor(const color clr)               { m_back_color=clr;              }
   void              BackColorHover(const color clr)          { m_back_color_hover=clr;        }
   void              BackColorPressed(const color clr)        { m_back_color_pressed=clr;      }
   //--- (1) Цвета рамки кнопки в разных состояниях, (2) возвращает/устанавливает текущий цвет параметра
   void              BorderColor(const color clr)             { m_border_color=clr;            }
   void              BorderColorOff(const color clr)          { m_border_color_off=clr;        }
   color             CurrentColor(void)                 const { return(m_current_color);       }
   void              CurrentColor(const color clr);
   //--- Изменение цвета элемента
   void              ChangeObjectsColor(void);
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
   virtual void      ResetColors(void);
   //---
private:
   //--- Обработка нажатия на кнопке
   bool              OnClickButton(const string clicked_object);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CColorButton::CColorButton(void) : m_button_state(true),
                                   m_current_color(clrGold),
                                   m_area_color(C'15,15,15'),
                                   m_label_x_gap(20),
                                   m_label_y_gap(3),
                                   m_button_y_size(18),
                                   m_label_color(clrWhite),
                                   m_label_color_off(clrGray),
                                   m_label_color_hover(C'85,170,255'),
                                   m_back_color(clrLightGray),
                                   m_back_color_off(clrLightGray),
                                   m_back_color_hover(C'193,218,255'),
                                   m_back_color_pressed(C'153,178,215'),
                                   m_border_color(clrWhite),
                                   m_border_color_off(clrDarkGray),
                                   m_button_label_color(clrBlack),
                                   m_button_label_color_off(clrDarkGray),
                                   m_button_label_color_hover(clrBlack),
                                   m_button_label_color_pressed(clrBlack)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_button_zorder =1;
   m_zorder        =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CColorButton::~CColorButton(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CColorButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_button.MouseFocus(x>m_button.X() && x<m_button.X2() && y>m_button.Y() && y<m_button.Y2());
      //--- Выйти, если форма заблокирована
      if(m_wnd.IsLocked())
         return;
      //--- Выйти, если левая кнопка мыши отжата
      if(!m_mouse_state)
         return;
      //--- Выйти, если кнопка заблокирована
      if(!m_button_state)
         return;
      //--- Если нет фокуса
      if(!CElement::MouseFocus())
        {
         m_button.BackColor(m_back_color);
         return;
        }
      //--- Если есть фокус
      else
        {
         m_label.Color(m_label_color_hover);
         //--- Установить цвет с учётом фокуса
         if(m_button.MouseFocus())
            m_button.BackColor(m_back_color_pressed);
         else
            m_button.BackColor(m_back_color_hover);
         //---
         return;
        }
      //---
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CColorButton::OnEventTimer(void)
  {
//--- Если элемент выпадающий
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- Если форма и кнопка не заблокированы
      if(!m_wnd.IsLocked() && m_button_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт объект Кнопка                                            |
//+------------------------------------------------------------------+
bool CColorButton::CreateColorButton(const long chart_id,const int subwin,const string button_text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием кнопки классу нужно передать "
              "указатель на форму: CColorButton::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =x;
   m_y          =y;
   m_label_text =button_text;
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание кнопки
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateButton())
      return(false);
   if(!CreateButtonIcon())
      return(false);
   if(!CreateButtonLabel())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь                                                  |
//+------------------------------------------------------------------+
bool CColorButton::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_button_area_"+(string)CElement::Id();
//--- Создание объекта
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(CElement::m_x-m_wnd.X());
   m_area.YGap(CElement::m_y-m_wnd.Y());
//--- Сохраним размеры (в группе)
   CElement::XSize(m_x_size);
   CElement::YSize(m_y_size);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт лэйбл                                                    |
//+------------------------------------------------------------------+
bool CColorButton::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_button_lable_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y()+2;
//--- Цвет текста относительно состояния
   color label_color=(m_button_state)? m_label_color : m_label_color_off;
//--- Создание объекта
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_label.Description(m_label_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.Tooltip("\n");
//--- Отступы от крайней точки
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(label_color,m_label_color_hover,m_label_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку                                                   |
//+------------------------------------------------------------------+
bool CColorButton::CreateButton(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_button_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+CElement::XSize()-m_button_x_size;
   int y =CElement::Y()-1;
//--- Создание объекта
   if(!m_button.Create(m_chart_id,name,m_subwin,x,y,m_button_x_size,m_button_y_size))
      return(false);
//--- Установим свойства
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
//--- Сохраним координаты
   m_button.X(x);
   m_button.Y(y);
//--- Сохраним размеры
   m_button.XSize(m_button_x_size);
   m_button.YSize(m_button_y_size);
//--- Отступы от крайней точки
   m_button.XGap(x-m_wnd.X());
   m_button.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт картинку кнопки                                          |
//+------------------------------------------------------------------+
bool CColorButton::CreateButtonIcon(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_button_bmp_"+(string)CElement::Id();
//--- Координаты
   int x =m_button.X()+3;
   int y =m_button.Y()+3;
//--- Создание объекта
   if(!m_button_icon.Create(m_chart_id,name,m_subwin,x,y,12,12))
      return(false);
//--- Установим свойства
   m_button_icon.Corner(m_corner);
   m_button_icon.Color(clrGray);
   m_button_icon.BackColor(m_current_color);
   m_button_icon.Selectable(false);
   m_button_icon.Z_Order(m_button_zorder);
   m_button_icon.BorderType(BORDER_FLAT);
   m_button_icon.Tooltip("\n");
//--- Сохраним координаты
   m_button_icon.X(x);
   m_button_icon.Y(y);
//--- Сохраним размеры
   m_button_icon.XSize(m_button_icon.X_Size());
   m_button_icon.YSize(m_button_icon.Y_Size());
//--- Отступы от крайней точки
   m_button_icon.XGap(x-m_wnd.X());
   m_button_icon.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_button_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт надпись кнопки                                           |
//+------------------------------------------------------------------+
bool CColorButton::CreateButtonLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_button_text_"+(string)CElement::Id();
//--- Координаты
   int x =m_button.X()+m_label_x_gap;
   int y =m_button.Y()+m_label_y_gap;
//--- Создание объекта
   if(!m_button_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_button_label.Description(::ColorToString(m_current_color));
   m_button_label.Font(FONT);
   m_button_label.FontSize(FONT_SIZE);
   m_button_label.Color(m_button_label_color);
   m_button_label.Corner(m_corner);
   m_button_label.Anchor(m_anchor);
   m_button_label.Selectable(false);
   m_button_label.Z_Order(m_zorder);
   m_button_label.Tooltip("\n");
//--- Отступы от крайней точки
   m_button_label.XGap(x-m_wnd.X());
   m_button_label.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_button_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Изменяет текущий цвет параметра                                  |
//+------------------------------------------------------------------+
void CColorButton::CurrentColor(const color clr)
  {
   m_current_color=clr;
   m_button_icon.BackColor(clr);
   m_button_label.Description(::ColorToString(clr));
  }
//+------------------------------------------------------------------+
//| Изменение состояния кнопки                                       |
//+------------------------------------------------------------------+
void CColorButton::ButtonState(const bool state)
  {
   m_button_state=state;
//--- Установить цвета объектам согласно текущему состоянию
   m_label.Color((state)? m_label_color : m_label_color_off);
   m_button_label.Color((state)? m_button_label_color : m_button_label_color_off);
   m_button.State(false);
   m_button.BackColor((state)? m_back_color : m_back_color_off);
   m_button.BorderColor((state)? m_border_color : m_border_color_off);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CColorButton::ChangeObjectsColor(void)
  {
   color label_color=(m_button_state) ? m_label_color : m_label_color_off;
   ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,label_color,m_label_color_hover,m_label_color_array);
   ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CColorButton::Moving(const int x,const int y)
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
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_button.X(x+m_button.XGap());
   m_button.Y(y+m_button.YGap());
   m_button_icon.X(x+m_button_icon.XGap());
   m_button_icon.Y(y+m_button_icon.YGap());
   m_button_label.X(x+m_button_label.XGap());
   m_button_label.Y(y+m_button_label.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_button_icon.X_Distance(m_button_icon.X());
   m_button_icon.Y_Distance(m_button_icon.Y());
   m_button_label.X_Distance(m_button_label.X());
   m_button_label.Y_Distance(m_button_label.Y());
  }
//+------------------------------------------------------------------+
//| Показывает кнопку                                                |
//+------------------------------------------------------------------+
void CColorButton::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает кнопку                                                  |
//+------------------------------------------------------------------+
void CColorButton::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CColorButton::Reset(void)
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
void CColorButton::Delete(void)
  {
   m_area.Delete();
   m_label.Delete();
   m_button.Delete();
   m_button_icon.Delete();
   m_button_label.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CColorButton::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_button.Z_Order(m_button_zorder);
   m_button_icon.Z_Order(m_zorder);
   m_button_label.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CColorButton::ResetZorders(void)
  {
   m_area.Z_Order(-1);
   m_label.Z_Order(-1);
   m_button.Z_Order(-1);
   m_button_icon.Z_Order(-1);
   m_button_label.Z_Order(-1);
  }
//+------------------------------------------------------------------+
//| Сбрасывает цвет                                                  |
//+------------------------------------------------------------------+
void CColorButton::ResetColors(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_button_state)
      return;
//--- Сбросить цвета
   m_label.Color(m_label_color);
   m_button.BackColor(m_back_color);
//--- Обнулим фокус
   m_button.MouseFocus(false);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку                                                |
//+------------------------------------------------------------------+
bool CColorButton::OnClickButton(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта
   if(m_button.Name()!=clicked_object)
      return(false);
//--- Выйти, если кнопка заблокирована
   if(!m_button_state)
     {
      m_button.State(false);
      return(false);
     }
//--- Сбросить состояние и цвет
   m_button.State(false);
   m_label.Color(m_label_color);
   m_button.BackColor(m_back_color);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),CElement::Index(),m_label_text);
   return(true);
  }
//+------------------------------------------------------------------+
