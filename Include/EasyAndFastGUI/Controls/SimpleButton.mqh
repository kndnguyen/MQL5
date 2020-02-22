//+------------------------------------------------------------------+
//|                                                 SimpleButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания простой кнопки                                |
//+------------------------------------------------------------------+
class CSimpleButton : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объект для создания кнопки
   CButton           m_button;
   //--- Свойства кнопки:
   //    (1) Текст, (2) размеры
   string            m_button_text;
   int               m_button_x_size;
   int               m_button_y_size;
   //--- Цвет фона
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   color             m_back_color_array[];
   //--- Цвет рамки
   color             m_border_color;
   color             m_border_color_off;
   //--- Цвет текста
   color             m_text_color;
   color             m_text_color_off;
   color             m_text_color_pressed;
   //--- Приоритет на нажатие левой кнопкой мыши
   int               m_button_zorder;
   //--- Режим двух состояний кнопки
   bool              m_two_state;
   //--- Доступен/заблокирован
   bool              m_button_state;
   //---
public:
                     CSimpleButton(void);
                    ~CSimpleButton(void);
   //--- Методы для создания простой кнопки
   bool              CreateSimpleButton(const long chart_id,const int subwin,const string button_text,const int x,const int y);
   //---
private:
   bool              CreateButton(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) установка режима кнопки,
   //    (3) общее состояние кнопки (доступен/заблокирован)
   void              WindowPointer(CWindow &object)          { m_wnd=::GetPointer(object);     }
   void              TwoState(const bool flag)               { m_two_state=flag;               }
   bool              IsPressed(void)                   const { return(m_button.State());       }
   bool              ButtonState(void)                 const { return(m_button_state);         }
   void              ButtonState(const bool state);
   //--- Размер кнопки
   void              ButtonXSize(const int x_size)           { m_button_x_size=x_size;         }
   void              ButtonYSize(const int y_size)           { m_button_y_size=y_size;         }
   //--- (1) Возвращает текст кнопки, (2) установка цвета текста кнопки
   string            Text(void)                        const { return(m_button.Description()); }
   void              TextColor(const color clr)              { m_text_color=clr;               }
   void              TextColorOff(const color clr)           { m_text_color_off=clr;           }
   void              TextColorPressed(const color clr)       { m_text_color_pressed=clr;       }
   //--- Установка цвета фона кнопки
   void              BackColor(const color clr)              { m_back_color=clr;               }
   void              BackColorOff(const color clr)           { m_back_color_off=clr;           }
   void              BackColorHover(const color clr)         { m_back_color_hover=clr;         }
   void              BackColorPressed(const color clr)       { m_back_color_pressed=clr;       }
   //--- Установка цвета рамки кнопки
   void              BorderColor(const color clr)            { m_border_color=clr;             }
   void              BorderColorOff(const color clr)         { m_border_color_off=clr;         }

   //--- Изменение цвета элемента
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Обработчик события графика
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
CSimpleButton::CSimpleButton(void) : m_button_state(true),
                                     m_two_state(false),
                                     m_button_x_size(50),
                                     m_button_y_size(22),
                                     m_text_color(clrBlack),
                                     m_text_color_off(clrDarkGray),
                                     m_text_color_pressed(clrWhite),
                                     m_back_color(clrSilver),
                                     m_back_color_off(clrLightGray),
                                     m_back_color_hover(clrLightGray),
                                     m_back_color_pressed(C'153,178,215'),
                                     m_border_color(clrWhite),
                                     m_border_color_off(clrWhite)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритет на нажатие левой кнопки мыши
   m_button_zorder=1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSimpleButton::~CSimpleButton(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработка событий                                                |
//+------------------------------------------------------------------+
void CSimpleButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Определим фокус
      int x=(int)lparam;
      int y=(int)dparam;
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- Выйти, если форма заблокирована
      if(m_wnd.IsLocked())
         return;
      //--- Выйти, если кнопка мыши отжата
      if(sparam=="0")
         return;
      //--- Выйти, если кнопка заблокирована
      if(!m_button_state)
         return;
      //--- Если нет фокуса
      if(!CElement::MouseFocus())
        {
         //--- Если кнопка отжата
         if(!m_button.State())
           {
            m_button.Color(m_text_color);
            m_button.BackColor(m_back_color);
           }
         //---
         return;
        }
      //--- Если есть фокус
      else
        {
         m_button.Color(m_text_color_pressed);
         m_button.BackColor(m_back_color_pressed);
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
void CSimpleButton::OnEventTimer(void)
  {
//--- Если элемент является выпадающим
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- Если форма не заблокирована
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт объект Кнопка                                            |
//+------------------------------------------------------------------+
bool CSimpleButton::CreateSimpleButton(const long chart_id,const int subwin,const string button_text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием кнопки классу нужно передать "
              "указатель на форму: CSimpleButton::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id          =m_wnd.LastId()+1;
   m_chart_id    =chart_id;
   m_subwin      =subwin;
   m_x           =x;
   m_y           =y;
   m_button_text =button_text;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание кнопки
   if(!CreateButton())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку                                                   |
//+------------------------------------------------------------------+
bool CSimpleButton::CreateButton(void)
  {
//--- Формирование имени объекта
   string name="";
//--- Если индекс не задан
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_simple_button_"+(string)CElement::Id();
//--- Если индекс задан
   else
      name=CElement::ProgramName()+"_simple_button_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Установим кнопку
   if(!m_button.Create(m_chart_id,name,m_subwin,m_x,m_y,m_button_x_size,m_button_y_size))
      return(false);
//--- Установим свойства
   m_button.Font(FONT);
   m_button.FontSize(FONT_SIZE);
   m_button.Color(m_text_color);
   m_button.Description(m_button_text);
   m_button.BackColor(m_back_color);
   m_button.BorderColor(m_border_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_button_zorder);
   m_button.Tooltip("\n");
//--- Сохраним размеры
   CElement::XSize(m_button_x_size);
   CElement::YSize(m_button_y_size);
//--- Отступы от крайней точки
   m_button.XGap(m_x-m_wnd.X());
   m_button.YGap(m_y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CSimpleButton::ChangeObjectsColor(void)
  {
   ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
  }
//+------------------------------------------------------------------+
//| Сбрасывает цвет                                                  |
//+------------------------------------------------------------------+
void CSimpleButton::ResetColors(void)
  {
//--- Выйти, если режим двух состояний и кнопка нажата
   if(m_two_state && m_button_state)
      return;
//--- Сбросить цвет
   m_button.BackColor(m_back_color);
//--- Обнулим фокус
   m_button.MouseFocus(false);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Изменение состояния кнопки                                       |
//+------------------------------------------------------------------+
void CSimpleButton::ButtonState(const bool state)
  {
   m_button_state=state;
   m_button.State(false);
   m_button.Color((state)? m_text_color : m_text_color_off);
   m_button.BackColor((state)? m_back_color : m_back_color_off);
   m_button.BorderColor((state)? m_border_color : m_border_color_off);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CSimpleButton::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_button.X(x+m_button.XGap());
   m_button.Y(y+m_button.YGap());
//--- Обновление координат графических объектов
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CSimpleButton::SetZorders(void)
  {
   m_button.Z_Order(m_button_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CSimpleButton::ResetZorders(void)
  {
   m_button.Z_Order(-1);
  }
//+------------------------------------------------------------------+
//| Показывает кнопку                                                |
//+------------------------------------------------------------------+
void CSimpleButton::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   m_button.Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает кнопку                                                  |
//+------------------------------------------------------------------+
void CSimpleButton::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   m_button.Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CSimpleButton::Reset(void)
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
void CSimpleButton::Delete(void)
  {
//--- Удаление объектов
   m_button.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопку                                      |
//+------------------------------------------------------------------+
bool CSimpleButton::OnClickButton(const string clicked_object)
  {
//--- Проверка по имени объекта
   if(m_button.Name()!=clicked_object)
      return(false);
//--- Если кнопка заблокирована
   if(!m_button_state)
     {
      m_button.State(false);
      return(false);
     }
//--- Если режим кнопки с одним состоянием
   if(!m_two_state)
     {
      m_button.State(false);
      m_button.Color(m_text_color);
      m_button.BackColor(m_back_color);
     }
//--- Если режим кнопки с двумя состояниями
   else
     {
      //--- Если кнопка нажата
      if(m_button.State())
        {
         //--- Изменим цвета кнопки 
         m_button.State(true);
         m_button.Color(m_text_color_pressed);
         m_button.BackColor(m_back_color_pressed);
         CElement::InitColorArray(m_back_color_pressed,m_back_color_pressed,m_back_color_array);
        }
      //--- Если кнопка отжата
      else
        {
         //--- Изменим цвета кнопки 
         m_button.State(false);
         m_button.Color(m_text_color);
         m_button.BackColor(m_back_color);
         CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
        }
     }
//--- Отправить сигнал об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),CElement::Index(),m_button.Description());
   return(true);
  }
//+------------------------------------------------------------------+
