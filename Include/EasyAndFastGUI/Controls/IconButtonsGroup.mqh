//+------------------------------------------------------------------+
//|                                             IconButtonsGroup.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания группы радио-кнопок                           |
//+------------------------------------------------------------------+
class CIconButtonsGroup : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания кнопки
   CButton           m_buttons[];
   CBmpLabel         m_icons[];
   CLabel            m_labels[];
   //--- Градиенты текстовых меток
   struct IconButtonsGradients
     {
      color             m_back_color_array[];
      color             m_label_color_array[];
     };
   IconButtonsGradients   m_icon_buttons_total[];
   //--- Свойства кнопок:
   //    Массивы для уникальных свойств кнопок
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   string            m_buttons_text[];
   int               m_buttons_width[];
   string            m_icon_file_on[];
   string            m_icon_file_off[];
   //--- Высота кнопок
   int               m_buttons_y_size;
   //--- Цвет фона в различных режимах
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   //--- Цвет рамки
   color             m_border_color;
   color             m_border_color_off;
   //--- Отступы ярлыка
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- Отступы текстовой метки
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвет текстовой метки в различных режимах
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   //--- (1) Текст и (2) индекс выделенной кнопки
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- Общий приоритет для некликабельных объектов
   int               m_zorder;
   //--- Приоритет на нажатие левой кнопкой мыши
   int               m_buttons_zorder;
   //--- Доступен/заблокирован
   bool              m_icon_buttons_state;
   //---
public:
                     CIconButtonsGroup(void);
                    ~CIconButtonsGroup(void);
   //--- Методы для создания кнопки
   bool              CreateIconButtonsGroup(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateButton(const int index);
   bool              CreateIcon(const int index);
   bool              CreateLabel(const int index);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) высота кнопок, (3) количество кнопок,
   //    (4) общее состояние кнопки (доступен/заблокирован)
   void              WindowPointer(CWindow &object)               { m_wnd=::GetPointer(object);      }
   void              ButtonsYSize(const int y_size)               { m_buttons_y_size=y_size;         }
   int               IconButtonsTotal(void)                 const { return(::ArraySize(m_icons));    }
   bool              IconButtonsState(void)                 const { return(m_icon_buttons_state);    }
   void              IconButtonsState(const bool state);
   //--- Цвета фона кнопки
   void              BackColor(const color clr)                   { m_back_color=clr;                }
   void              BackColorOff(const color clr)                { m_back_color_off=clr;            }
   void              BackColorHover(const color clr)              { m_back_color_hover=clr;          }
   void              BackColorPressed(const color clr)            { m_back_color_pressed=clr;        }
   //--- Установка цвета рамки кнопки
   void              BorderColor(const color clr)                 { m_border_color=clr;              }
   void              BorderColorOff(const color clr)              { m_border_color_off=clr;          }
   //--- Отступы ярлыка
   void              IconXGap(const int x_gap)                    { m_icon_x_gap=x_gap;              }
   void              IconYGap(const int y_gap)                    { m_icon_y_gap=y_gap;              }
   //--- Отступы текстовой метки
   void              LabelXGap(const int x_gap)                   { m_label_x_gap=x_gap;             }
   void              LabelYGap(const int y_gap)                   { m_label_y_gap=y_gap;             }
   //--- Возвращает (1) текст и (2) индекс выделенной кнопки
   string            SelectedButtonText(void)               const { return(m_selected_button_text);  }
   int               SelectedButtonIndex(void)              const { return(m_selected_button_index); }
   //--- Переключает радио-кнопку по указанному индексу
   void              SelectedRadioButton(const int index);

   //--- Добавляет кнопку с указанными свойствами до создания
   void              AddButton(const int x_gap,const int y_gap,const string text,
                               const int width,const string icon_file_on,const string icon_file_off);
   //--- Изменение цвета
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
   //---
private:
   //--- Обработка нажатия на кнопку
   bool              OnClickButton(const string pressed_object);
   //--- Проверка нажатой левой кнопки мыши над кнопками группы
   void              CheckPressedOverButton(void);
   //--- Получение идентификатора из имени радио-кнопки
   int               IdFromObjectName(const string object_name);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CIconButtonsGroup::CIconButtonsGroup(void) : m_icon_buttons_state(true),
                                             m_buttons_y_size(22),
                                             m_selected_button_text(""),
                                             m_selected_button_index(0),
                                             m_icon_x_gap(4),
                                             m_icon_y_gap(3),
                                             m_label_x_gap(25),
                                             m_label_y_gap(4),
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
   m_zorder         =0;
   m_buttons_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIconButtonsGroup::~CIconButtonsGroup(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик события графика                                       |
//+------------------------------------------------------------------+
void CIconButtonsGroup::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Выйти, если кнопки заблокированы
      if(!m_icon_buttons_state)
         return;
      //--- Определим фокус
      int x=(int)lparam;
      int y=(int)dparam;
      int icon_buttons_total=IconButtonsTotal();
      for(int i=0; i<icon_buttons_total; i++)
         m_buttons[i].MouseFocus(x>m_buttons[i].X() && x<m_buttons[i].X2() && y>m_buttons[i].Y() && y<m_buttons[i].Y2());
      //--- Выйти, если кнопка мыши не нажата
      if(sparam!="1")
         return;
      //--- Проверка нажатой левой кнопки мыши над кнопками группы
      CheckPressedOverButton();
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Переключить кнопку
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CIconButtonsGroup::OnEventTimer(void)
  {
//--- Изменим цвет, если форма не заблокирована
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Создаёт группу объектов "кнопки с картинками"                    |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateIconButtonsGroup(const long chart_id,const int window,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием группы кнопок классу нужно передать "
              "указатель на форму: CButtonsGroup::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =window;
   m_x        =x;
   m_y        =y;
//--- Установим кнопку
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      CreateButton(i);
      CreateIcon(i);
      CreateLabel(i);
      //---
      m_buttons[i].MouseFocus(false);
     }
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь кнопки                                           |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateButton(const int index)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_icon_button_"+(string)index+"__"+(string)CElement::Id();
//--- Расчёт координат
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index];
//--- Установим кнопку
   if(!m_buttons[index].Create(m_chart_id,name,m_subwin,x,y,m_buttons_width[index],m_buttons_y_size))
      return(false);
//--- Установим свойства
   m_buttons[index].Font(FONT);
   m_buttons[index].FontSize(FONT_SIZE);
   m_buttons[index].Color(m_back_color);
   m_buttons[index].Description("");
   m_buttons[index].BackColor(m_back_color);
   m_buttons[index].BorderColor(m_border_color);
   m_buttons[index].Corner(m_corner);
   m_buttons[index].Anchor(m_anchor);
   m_buttons[index].Selectable(false);
   m_buttons[index].Z_Order(m_buttons_zorder);
   m_buttons[index].Tooltip("\n");
//--- Сохраним размеры
   m_buttons[index].XSize(m_buttons_width[index]);
   m_buttons[index].YSize(m_buttons_width[index]);
//--- Отступы от крайней точки
   m_buttons[index].XGap(x-m_wnd.X());
   m_buttons[index].YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_icon_buttons_total[index].m_back_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_buttons[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт картинку                                                 |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateIcon(const int index)
  {
//--- Если ярлык для кнопки не нужен, выйти
   if(m_icon_file_on[index]=="" || m_icon_file_off[index]=="")
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_icon_button_bmp_"+(string)index+"__"+(string)CElement::Id();
//--- Расчёт координат
   int x=m_x+m_buttons_x_gap[index]+m_icon_x_gap;
   int y=m_y+m_buttons_y_gap[index]+m_icon_y_gap;
//--- Установим картинку
   if(!m_icons[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
   m_icons[index].BmpFileOn("::"+m_icon_file_on[index]);
   m_icons[index].BmpFileOff("::"+m_icon_file_off[index]);
   m_icons[index].State(true);
   m_icons[index].Corner(m_corner);
   m_icons[index].GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icons[index].Selectable(false);
   m_icons[index].Z_Order(m_zorder);
   m_icons[index].Tooltip("\n");
//--- Отступы от крайней точки
   m_icons[index].XGap(x-m_wnd.X());
   m_icons[index].YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_icons[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт текстовую метку                                          |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateLabel(const int index)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_icon_button_lable_"+(string)index+"__"+(string)CElement::Id();
//--- Координаты
   int x=m_x+m_buttons_x_gap[index]+m_label_x_gap;
   int y=m_y+m_buttons_y_gap[index]+m_label_y_gap;
//--- Установим текстовую метку
   if(!m_labels[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_labels[index].Description(m_buttons_text[index]);
   m_labels[index].Font(FONT);
   m_labels[index].FontSize(FONT_SIZE);
   m_labels[index].Color(m_label_color);
   m_labels[index].Corner(m_corner);
   m_labels[index].Anchor(m_anchor);
   m_labels[index].Selectable(false);
   m_labels[index].Z_Order(m_zorder);
   m_labels[index].Tooltip("\n");
//--- Отступы от крайней точки
   m_labels[index].XGap(x-m_wnd.X());
   m_labels[index].YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_label_color,m_label_color_hover,m_icon_buttons_total[index].m_label_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_labels[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет кнопку                                                 |
//+------------------------------------------------------------------+
void CIconButtonsGroup::AddButton(const int x_gap,const int y_gap,const string text,
                                  const int width,const string icon_file_on,const string icon_file_off)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_buttons_text);
   ::ArrayResize(m_buttons,array_size+1);
   ::ArrayResize(m_icons,array_size+1);
   ::ArrayResize(m_labels,array_size+1);
   ::ArrayResize(m_buttons_x_gap,array_size+1);
   ::ArrayResize(m_buttons_y_gap,array_size+1);
   ::ArrayResize(m_buttons_state,array_size+1);
   ::ArrayResize(m_buttons_text,array_size+1);
   ::ArrayResize(m_buttons_width,array_size+1);
   ::ArrayResize(m_icon_file_on,array_size+1);
   ::ArrayResize(m_icon_file_off,array_size+1);
   ::ArrayResize(m_icon_buttons_total,array_size+1);
//--- Сохраним значения переданных параметров
   m_buttons_x_gap[array_size] =x_gap;
   m_buttons_y_gap[array_size] =y_gap;
   m_buttons_text[array_size]  =text;
   m_buttons_width[array_size] =width;
   m_icon_file_on[array_size]  =icon_file_on;
   m_icon_file_off[array_size] =icon_file_off;
   m_buttons_state[array_size] =false;
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].X(x+m_buttons[i].XGap());
      m_buttons[i].Y(y+m_buttons[i].YGap());
      m_icons[i].X(x+m_icons[i].XGap());
      m_icons[i].Y(y+m_icons[i].YGap());
      m_labels[i].X(x+m_labels[i].XGap());
      m_labels[i].Y(y+m_labels[i].YGap());
     }
//--- Обновление координат графических объектов
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].X_Distance(m_buttons[i].X());
      m_buttons[i].Y_Distance(m_buttons[i].Y());
      m_icons[i].X_Distance(m_icons[i].X());
      m_icons[i].Y_Distance(m_icons[i].Y());
      m_labels[i].X_Distance(m_labels[i].X());
      m_labels[i].Y_Distance(m_labels[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CIconButtonsGroup::ChangeObjectsColor(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      color label_color=(m_buttons_state[i]) ? m_label_color : m_label_color_off;
      ChangeObjectColor(m_labels[i].Name(),m_buttons[i].MouseFocus(),
                        OBJPROP_COLOR,label_color,m_label_color_pressed,m_icon_buttons_total[i].m_label_color_array);
      ChangeObjectColor(m_buttons[i].Name(),m_buttons[i].MouseFocus(),
                        OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_icon_buttons_total[i].m_back_color_array);
     }
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CIconButtonsGroup::SetZorders(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Z_Order(m_buttons_zorder);
      m_icons[i].Z_Order(m_zorder);
      m_labels[i].Z_Order(m_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CIconButtonsGroup::ResetZorders(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Z_Order(-1);
      m_icons[i].Z_Order(-1);
      m_labels[i].Z_Order(-1);
     }
  }
//+------------------------------------------------------------------+
//| Показывает кнопку                                                |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Show(void)
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
void CIconButtonsGroup::Hide(void)
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
void CIconButtonsGroup::Reset(void)
  {
//--- Выйти, если это выпадающий элемент 
   if(CElement::IsDropdown())
      return;
//--- Скрыть и показать
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Delete(void)
  {
//--- Удаление объектов
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Delete();
      m_icons[i].Delete();
      m_labels[i].Delete();
     }
//--- Освобождение массивов элемента
   ::ArrayFree(m_buttons_x_gap);
   ::ArrayFree(m_buttons_y_gap);
   ::ArrayFree(m_buttons_width);
   ::ArrayFree(m_buttons_state);
   ::ArrayFree(m_buttons_text);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Изменение состояния кнопок                                       |
//+------------------------------------------------------------------+
void CIconButtonsGroup::IconButtonsState(const bool state)
  {
   m_icon_buttons_state=state;
//---
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_icons[i].State(state && i==m_selected_button_index);
      m_labels[i].Color((state && i==m_selected_button_index)? m_label_color_pressed : m_label_color_off);
      m_buttons[i].BackColor((state && i==m_selected_button_index)? m_back_color_pressed : m_back_color_off);
     }
  }
//+------------------------------------------------------------------+
//| Указывает, какая радио-кнопка должна быть выделена               |
//+------------------------------------------------------------------+
void CIconButtonsGroup::SelectedRadioButton(const int index)
  {
//--- Получим количество кнопок
   int icon_buttons_total=IconButtonsTotal();
//--- Если нет ни одной радио-кнопки в группе, сообщить об этом
   if(icon_buttons_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна кнопка! Воспользуйтесь методом CIconButtonsGroup::AddButton()");
     }
//--- Скорректировать значение индекса, если выходит из диапазона
   int correct_index=(index>=icon_buttons_total)? icon_buttons_total-1 : (index<0)? 0 : index;
//--- Переключить кнопку
   for(int i=0; i<icon_buttons_total; i++)
     {
      if(i==correct_index)
        {
         m_buttons_state[i]=true;
         m_icons[i].State(true);
         m_labels[i].Color(m_label_color_hover);
         m_buttons[i].BackColor(m_back_color_pressed);
         CElement::InitColorArray(m_label_color,m_label_color_hover,m_icon_buttons_total[i].m_label_color_array);
        }
      else
        {
         m_buttons_state[i]=false;
         m_icons[i].State(false);
         m_labels[i].Color(m_label_color_off);
         m_buttons[i].BackColor(m_back_color_off);
         CElement::InitColorArray(m_label_color_off,m_label_color_hover,m_icon_buttons_total[i].m_label_color_array);
        }
      //---
      m_buttons[i].State(false);
     }
//--- Сохраним её текст и индекс
   m_selected_button_index =correct_index;
   m_selected_button_text  =m_buttons_text[correct_index];
  }
//+------------------------------------------------------------------+
//| Нажатие на радио-кнопку                                          |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::OnClickButton(const string pressed_object)
  {
//--- Выйдем, если нажатие было не на пункте меню
   if(::StringFind(pressed_object,CElement::ProgramName()+"_icon_button_",0)<0)
      return(false);
//--- Получим идентификатор и индекс из имени объекта
   int id=IdFromObjectName(pressed_object);
//--- Выйдем, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Для проверки индекса
   int check_index=WRONG_VALUE;
//--- Получим количество кнопок
   int icon_buttons_total=IconButtonsTotal();
//--- Выйти, если кнопки заблокированы
   if(!m_icon_buttons_state)
     {
      for(int i=0; i<icon_buttons_total; i++)
         m_buttons[i].State(false);
      //---
      return(false);
     }
//--- Если нажатие было, то запомним индекс
   for(int i=0; i<icon_buttons_total; i++)
     {
      if(m_buttons[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- Выйдем, если не было нажатия на кнопку в этой группе или
//    если это уже выделенная кнопка
   if(check_index==WRONG_VALUE || check_index==m_selected_button_index)
     {
      m_buttons[check_index].State(false);
      return(false);
     }
//--- Переключить кнопку
   SelectedRadioButton(check_index);
//--- Отправить сигнал об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),m_selected_button_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверка нажатой левой кнопки мыши над кнопками группы           |
//+------------------------------------------------------------------+
void CIconButtonsGroup::CheckPressedOverButton(void)
  {
   int buttons_total=IconButtonsTotal();
//--- Установить цвет в зависимости от местоположения зажатой левой кнопки мыши
   for(int i=0; i<buttons_total; i++)
     {
      //--- Если есть фокус, то цвет нажатой кнопки
      if(m_buttons[i].MouseFocus())
         m_buttons[i].BackColor(m_back_color_pressed);
      //--- Если фокуса нет, то...
      else
        {
         //--- ...если кнопка группы не нажата, присвоить цвет фона
         if(!m_buttons_state[i])
            m_buttons[i].BackColor(m_back_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CIconButtonsGroup::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
