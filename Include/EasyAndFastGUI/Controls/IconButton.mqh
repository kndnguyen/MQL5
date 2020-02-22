//+------------------------------------------------------------------+
//|                                                   IconButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания кнопки с картинкой                            |
//+------------------------------------------------------------------+
class CIconButton : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания кнопки
   CButton           m_button;
   CBmpLabel         m_icon;
   CLabel            m_label;
   //--- Свойства кнопки:
   //    Размер и приоритет на нажатие левой кнопкой мыши
   int               m_button_x_size;
   int               m_button_y_size;
   int               m_button_zorder;
   //--- Цвет фона в различных режимах
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   color             m_back_color_array[];
   //--- Цвет рамки
   color             m_border_color;
   color             m_border_color_off;
   //--- Ярлыки кнопки в активном и заблокированном состоянии
   string            m_icon_file_on;
   string            m_icon_file_off;
   //--- Отступы ярлыка
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- Текст и отступы текстовой метки
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвет текстовой метки в различных режимах
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   color             m_label_color_array[];
   //--- Общий приоритет для некликабельных объектов
   int               m_zorder;
   //--- Режим двух состояний кнопки
   bool              m_two_state;
   //--- Доступен/заблокирован
   bool              m_button_state;
   //--- Режим "Только картинка", когда кнопка состоит только из объекта BmpLabel
   bool              m_only_icon;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //---
public:
                     CIconButton(void);
                    ~CIconButton(void);
   //--- Методы для создания кнопки
   bool              CreateIconButton(const long chart_id,const int subwin,const string button_text,const int x,const int y);
   //---
private:
   bool              CreateButton(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) установка режима кнопки, (3) установка режима "Только картинка"
   //    (4) общее состояние кнопки (доступен/заблокирован)
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);     }
   void              TwoState(const bool flag)                { m_two_state=flag;               }
   void              OnlyIcon(const bool flag)                { m_only_icon=flag;               }
   bool              IsPressed(void)                    const { return(m_button.State());       }
   bool              ButtonState(void)                  const { return(m_button_state);         }
   void              ButtonState(const bool state);
   //--- (1) Получение текста кнопки, (2) размер кнопки
   string            Text(void)                         const { return(m_label_text);           }
   void              ButtonXSize(const int x_size)            { m_button_x_size=x_size;         }
   void              ButtonYSize(const int y_size)            { m_button_y_size=y_size;         }
   //--- Установка ярлыков для кнопки в активном и заблокированном состояниях
   void              IconFileOn(const string file_path)       { m_icon_file_on=file_path;       }
   void              IconFileOff(const string file_path)      { m_icon_file_off=file_path;      }
   //--- Отступы ярлыка
   void              IconXGap(const int x_gap)                { m_icon_x_gap=x_gap;             }
   void              IconYGap(const int y_gap)                { m_icon_y_gap=y_gap;             }
   //--- Цвета фона кнопки
   void              BackColor(const color clr)               { m_back_color=clr;               }
   void              BackColorOff(const color clr)            { m_back_color_off=clr;           }
   void              BackColorHover(const color clr)          { m_back_color_hover=clr;         }
   void              BackColorPressed(const color clr)        { m_back_color_pressed=clr;       }
   //--- Установка цвета рамки кнопки
   void              BorderColor(const color clr)             { m_border_color=clr;             }
   void              BorderColorOff(const color clr)          { m_border_color_off=clr;         }
   //--- Отступы текстовой метки
   void              LabelXGap(const int x_gap)               { m_label_x_gap=x_gap;            }
   void              LabelYGap(const int y_gap)               { m_label_y_gap=y_gap;            }
   //--- Установка цвета текста кнопки
   void              LabelColor(const color clr)              { m_label_color=clr;              }
   void              LabelColorOff(const color clr)           { m_label_color_off=clr;          }
   void              LabelColorHover(const color clr)         { m_label_color_hover=clr;        }
   void              LabelColorPressed(const color clr)       { m_label_color_pressed=clr;      }
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
CIconButton::CIconButton(void) : m_icon_x_gap(4),
                                 m_icon_y_gap(3),
                                 m_label_x_gap(25),
                                 m_label_y_gap(4),
                                 m_icon_file_on(""),
                                 m_icon_file_off(""),
                                 m_button_state(true),
                                 m_two_state(false),
                                 m_only_icon(false),
                                 m_button_y_size(18),
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
//--- Сохраним имя класса элемента в базовом классе  
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder        =0;
   m_button_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIconButton::~CIconButton(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CIconButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_icon.MouseFocus(x>m_icon.X() && x<m_icon.X2() && y>m_icon.Y() && y<m_icon.Y2());
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
         //--- Если кнопка отжата
         if(!m_button.State())
            m_button.BackColor(m_back_color);
         //---
         return;
        }
      //--- Если есть фокус
      else
        {
         m_label.Color(m_label_color_pressed);
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
void CIconButton::OnEventTimer(void)
  {
//--- Если элемент является выпадающим
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
//| Создаёт элемент "Кнопка"                                         |
//+------------------------------------------------------------------+
bool CIconButton::CreateIconButton(const long chart_id,const int subwin,const string button_text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием кнопки классу нужно передать "
              "указатель на форму: CIconButton::WindowPointer(CWindow &object)");
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
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание кнопки
   if(!CreateButton())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateLabel())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон кнопки                                               |
//+------------------------------------------------------------------+
bool CIconButton::CreateButton(void)
  {
//--- Выйдем, если включен режим "Только картинка"
   if(m_only_icon)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_icon_button_"+(string)CElement::Id();
//--- Установим кнопку
   if(!m_button.Create(m_chart_id,name,m_subwin,m_x,m_y,m_button_x_size,m_button_y_size))
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
//| Создаёт картинку кнопки                                          |
//+------------------------------------------------------------------+
bool CIconButton::CreateIcon(void)
  {
//--- Если режим "Только картинка" отключен
   if(!m_only_icon)
     {
      //--- Если ярлык для кнопки не нужен, выйти
      if(m_icon_file_on=="" || m_icon_file_off=="")
         return(true);
     }
//--- Если включен режим "Только картинка" 
   else
     {
      //--- Если ярлык не был определён, вывести сообщение и выйти
      if(m_icon_file_on=="" || m_icon_file_off=="")
        {
         ::Print(__FUNCTION__," > В режиме \"Only icon\" определение картинки обязательно.");
         return(false);
        }
     }
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_icon_button_bmp_"+(string)CElement::Id();
//--- Координаты
   int x =(!m_only_icon)? m_x+m_icon_x_gap : m_x;
   int y =(!m_only_icon)? m_y+m_icon_y_gap : m_y;
//--- Установим ярлык
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_icon.BmpFileOn("::"+m_icon_file_on);
   m_icon.BmpFileOff("::"+m_icon_file_off);
   m_icon.State(true);
   m_icon.Corner(m_corner);
   m_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon.Selectable(false);
   m_icon.Z_Order((!m_only_icon)? m_zorder : m_button_zorder);
   m_icon.Tooltip((!m_only_icon)? "\n" : m_label_text);
//--- Сохраним координаты
   m_icon.X(x);
   m_icon.Y(y);
//--- Сохраним размеры
   m_icon.XSize(m_icon.X_Size());
   m_icon.YSize(m_icon.Y_Size());
//--- Отступы от крайней точки
   m_icon.XGap(x-m_wnd.X());
   m_icon.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт надпись кнопки                                           |
//+------------------------------------------------------------------+
bool CIconButton::CreateLabel(void)
  {
//--- Выйдем, если включен режим "Только картинка"
   if(m_only_icon)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_icon_button_lable_"+(string)CElement::Id();
//--- Координаты
   int x =m_x+m_label_x_gap;
   int y =m_y+m_label_y_gap;
//--- Установим текстовую метку
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
   m_label.Tooltip("\n");
//--- Отступы от крайней точки
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CIconButton::Moving(const int x,const int y)
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
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
//--- Обновление координат графических объектов
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
  }
//+------------------------------------------------------------------+
//| Показывает кнопку                                                |
//+------------------------------------------------------------------+
void CIconButton::Show(void)
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
void CIconButton::Hide(void)
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
void CIconButton::Reset(void)
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
void CIconButton::Delete(void)
  {
//--- Удаление объектов
   m_button.Delete();
   m_icon.Delete();
   m_label.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CIconButton::SetZorders(void)
  {
   m_label.Z_Order(m_zorder);
   m_button.Z_Order(m_button_zorder);
   m_icon.Z_Order((!m_only_icon)? m_zorder : m_button_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CIconButton::ResetZorders(void)
  {
   m_button.Z_Order(-1);
   m_icon.Z_Order(-1);
   m_label.Z_Order(-1);
//--- 
   m_icon.MouseFocus(false);
   ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Сбрасывает цвет                                                  |
//+------------------------------------------------------------------+
void CIconButton::ResetColors(void)
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
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CIconButton::ChangeObjectsColor(void)
  {
   if(m_only_icon)
      m_icon.State(m_icon.MouseFocus());
//--- Выйти, если элемент заблокирован
   if(!m_button_state)
      return;
//---
   ChangeObjectColor(m_button.Name(),MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
   ChangeObjectColor(m_label.Name(),MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| Изменение состояния кнопки                                       |
//+------------------------------------------------------------------+
void CIconButton::ButtonState(const bool state)
  {
   m_button_state=state;
//--- Установить цвета объектам согласно текущему состоянию
   m_icon.State(state);
   m_label.Color((state)? m_label_color : m_label_color_off);
   m_button.State(false);
   m_button.BackColor((state)? m_back_color : m_back_color_off);
   m_button.BorderColor((state)? m_border_color : m_border_color_off);
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку                                                |
//+------------------------------------------------------------------+
bool CIconButton::OnClickButton(const string clicked_object)
  {
//--- Если отключен режим "Только картинка"
   if(!m_only_icon)
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
      //--- Если это самоотжимающаяся кнопка
      if(!m_two_state)
        {
         m_button.State(false);
         m_button.BackColor(m_back_color);
         m_label.Color(m_label_color);
        }
      //--- Если это кнопка с двумя состояниями
      else
        {
         if(m_button.State())
           {
            m_button.State(true);
            m_label.Color(m_label_color_pressed);
            m_button.BackColor(m_back_color_pressed);
            CElement::InitColorArray(m_back_color_pressed,m_back_color_pressed,m_back_color_array);
           }
         else
           {
            m_button.State(false);
            m_label.Color(m_label_color);
            m_button.BackColor(m_back_color);
            CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
           }
        }
     }
//--- Если режим "Только картинка" включен  
   else
     {
      //--- Выйдем, если чужое имя объекта
      if(m_icon.Name()!=clicked_object)
         return(false);
      //--- Установим состояние On
      m_icon.State(true);
     }
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),CElement::Index(),m_label_text);
   return(true);
  }
//+------------------------------------------------------------------+
