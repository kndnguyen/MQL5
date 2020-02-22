//+------------------------------------------------------------------+
//|                                                 ButtonsGroup.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания группы простых кнопок                         |
//+------------------------------------------------------------------+
class CButtonsGroup : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания кнопки
   CButton           m_buttons[];
   //--- Градиенты кнопок
   struct ButtonsGradients
     {
      color             m_buttons_color_array[];
     };
   ButtonsGradients  m_buttons_total[];
   //--- Свойства кнопок:
   //    Режим радио-кнопок
   bool              m_radio_buttons_mode;
   //--- Массивы для уникальных свойств кнопок
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   string            m_buttons_text[];
   int               m_buttons_width[];
   color             m_buttons_color[];
   color             m_buttons_color_hover[];
   color             m_buttons_color_pressed[];
   //--- Высота кнопок
   int               m_button_y_size;
   //--- Цвет заблокированных кнопок
   color             m_back_color_off;
   //--- Цвет рамки в активном и заблокированных режимах
   color             m_border_color;
   color             m_border_color_off;
   //--- Цвета текста
   color             m_text_color;
   color             m_text_color_off;
   color             m_text_color_pressed;
   //--- (1) Текст и (2) индекс выделенной кнопки
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- Приоритет на нажатие левой кнопкой мыши
   int               m_buttons_zorder;
   //--- Доступен/заблокирован
   bool              m_buttons_group_state;
   //---
public:
                     CButtonsGroup(void);
                    ~CButtonsGroup(void);
   //--- Методы для создания кнопки
   bool              CreateButtonsGroup(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateButtons(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) количество кнопок,
   //    (3) общее состояние группы кнопок (доступен/заблокирован)
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);      }
   int               ButtonsTotal(void)                       const { return(::ArraySize(m_buttons));  }
   bool              ButtonsGroupState(void)                  const { return(m_buttons_group_state);   }
   void              ButtonsGroupState(const bool state);
   //--- (1) высота кнопок, (2) установка режима радио-кнопок
   void              ButtonYSize(const int y_size)                  { m_button_y_size=y_size;          }
   void              RadioButtonsMode(const bool flag)              { m_radio_buttons_mode=flag;       }
   //--- (1) Цвета фона заблокированной кнопки и рамки ((2) доступен/(3) заблокирован)
   void              BackColorOff(const color clr)                  { m_back_color_off=clr;            }
   void              BorderColor(const color clr)                   { m_border_color=clr;              }
   void              BorderColorOff(const color clr)                { m_border_color_off=clr;          }
   //--- Цвета текста
   void              TextColor(const color clr)                     { m_text_color=clr;                }
   void              TextColorOff(const color clr)                  { m_text_color_off=clr;            }
   void              TextColorPressed(const color clr)              { m_text_color_pressed=clr;        }
   //--- Возвращает (1) текст и (2) индекс выделенной кнопки
   string            SelectedButtonText(void)                 const { return(m_selected_button_text);  }
   int               SelectedButtonIndex(void)                const { return(m_selected_button_index); }
   //--- Переключает кнопку по указанному индексу
   void              SelectionButton(const int index);

   //--- Добавляет кнопку с указанными свойствами до создания
   void              AddButton(const int x_gap,const int y_gap,const string text,const int width,
                               const color button_color,const color button_color_hover,const color button_color_pressed);
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
   bool              OnClickButton(const string clicked_object);
   //--- Проверка нажатой левой кнопки мыши над кнопками группы
   void              CheckPressedOverButton(void);
   //--- Получение идентификатора из имени кнопки
   int               IdFromObjectName(const string object_name);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CButtonsGroup::CButtonsGroup(void) : m_radio_buttons_mode(false),
                                     m_buttons_group_state(true),
                                     m_button_y_size(22),
                                     m_selected_button_text(""),
                                     m_selected_button_index(WRONG_VALUE),
                                     m_text_color(clrBlack),
                                     m_text_color_off(clrDarkGray),
                                     m_text_color_pressed(clrWhite),
                                     m_back_color_off(clrLightGray),
                                     m_border_color(clrWhite),
                                     m_border_color_off(clrWhite)
  {
//--- Сохраним имя класса элемента в базовом классе  
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_buttons_zorder=1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CButtonsGroup::~CButtonsGroup(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик события графика                                       |
//+------------------------------------------------------------------+
void CButtonsGroup::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Выйти, если кнопки заблокированы
      if(!m_buttons_group_state)
         return;
      //--- Определим фокус
      int x=(int)lparam;
      int y=(int)dparam;
      int buttons_total=ButtonsTotal();
      for(int i=0; i<buttons_total; i++)
        {
         m_buttons[i].MouseFocus(x>m_buttons[i].X() && x<m_buttons[i].X2() && 
                                 y>m_buttons[i].Y() && y<m_buttons[i].Y2());
        }
      //--- Выйти, если форма заблокирована
      if(m_wnd.IsLocked())
         return;
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
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CButtonsGroup::OnEventTimer(void)
  {
//--- Изменим цвет, если форма не заблокирована
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Создаёт группу кнопок                                            |
//+------------------------------------------------------------------+
bool CButtonsGroup::CreateButtonsGroup(const long chart_id,const int subwin,const int x,const int y)
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
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Создаёт кнопки
   if(!CreateButtons())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопки                                                   |
//+------------------------------------------------------------------+
bool CButtonsGroup::CreateButtons(void)
  {
//--- Координаты
   int l_x =m_x;
   int l_y =m_y;
//--- Получим количество кнопок
   int buttons_total=ButtonsTotal();
//--- Если нет ни одной кнопки в группе, сообщить об этом
   if(buttons_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна кнопка! Воспользуйтесь методом CButtonsGroup::AddButton()");
      return(false);
     }
//--- Создадим указанное количество кнопок
   for(int i=0; i<buttons_total; i++)
     {
      //--- Формирование имени объекта
      string name=CElement::ProgramName()+"_buttons_"+(string)i+"__"+(string)CElement::Id();
      //--- Расчёт координат
      l_x=m_x+m_buttons_x_gap[i];
      l_y=m_y+m_buttons_y_gap[i];
      //--- Установим кнопку
      if(!m_buttons[i].Create(m_chart_id,name,m_subwin,l_x,l_y,m_buttons_width[i],m_button_y_size))
         return(false);
      //--- Установка свойств
      m_buttons[i].State(false);
      m_buttons[i].Font(FONT);
      m_buttons[i].FontSize(FONT_SIZE);
      m_buttons[i].Color(m_text_color);
      m_buttons[i].Description(m_buttons_text[i]);
      m_buttons[i].BorderColor(m_border_color);
      m_buttons[i].BackColor(m_buttons_color[i]);
      m_buttons[i].Corner(m_corner);
      m_buttons[i].Anchor(m_anchor);
      m_buttons[i].Selectable(false);
      m_buttons[i].Z_Order(m_buttons_zorder);
      m_buttons[i].Tooltip("\n");
      //--- Сохраним отступы от крайней точки панели, координаты и размеры
      m_buttons[i].XGap(l_x-m_wnd.X());
      m_buttons[i].YGap(l_y-m_wnd.Y());
      //--- Координаты
      m_buttons[i].X(l_x);
      m_buttons[i].Y(l_y);
      //--- Размеры
      m_buttons[i].XSize(m_buttons_width[i]);
      m_buttons[i].YSize(m_button_y_size);
      //--- Инициализация массива градиента
      CElement::InitColorArray(m_buttons_color[i],m_buttons_color_hover[i],m_buttons_total[i].m_buttons_color_array);
      //--- Сохраним указатель объекта
      CElement::AddToArray(m_buttons[i]);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет кнопку                                                 |
//+------------------------------------------------------------------+
void CButtonsGroup::AddButton(const int x_gap,const int y_gap,const string text,const int width,
                              const color button_color,const color button_color_hover,const color pressed_button_color)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_buttons);
   ::ArrayResize(m_buttons,array_size+1);
   ::ArrayResize(m_buttons_total,array_size+1);
   ::ArrayResize(m_buttons_state,array_size+1);
   ::ArrayResize(m_buttons_x_gap,array_size+1);
   ::ArrayResize(m_buttons_y_gap,array_size+1);
   ::ArrayResize(m_buttons_text,array_size+1);
   ::ArrayResize(m_buttons_width,array_size+1);
   ::ArrayResize(m_buttons_color,array_size+1);
   ::ArrayResize(m_buttons_color_hover,array_size+1);
   ::ArrayResize(m_buttons_color_pressed,array_size+1);
//--- Сохраним значения переданных параметров
   m_buttons_x_gap[array_size]         =x_gap;
   m_buttons_y_gap[array_size]         =y_gap;
   m_buttons_text[array_size]          =text;
   m_buttons_width[array_size]         =width;
   m_buttons_color[array_size]         =button_color;
   m_buttons_color_hover[array_size]   =button_color_hover;
   m_buttons_color_pressed[array_size] =pressed_button_color;
   m_buttons_state[array_size]         =false;
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CButtonsGroup::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//---
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
     {
      //--- Сохранение координат в полях объектов
      m_buttons[i].X(x+m_buttons[i].XGap());
      m_buttons[i].Y(y+m_buttons[i].YGap());
      //--- Обновление координат графических объектов
      m_buttons[i].X_Distance(m_buttons[i].X());
      m_buttons[i].Y_Distance(m_buttons[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CButtonsGroup::ChangeObjectsColor(void)
  {
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
     {
      CElement::ChangeObjectColor(m_buttons[i].Name(),m_buttons[i].MouseFocus(),
                                  OBJPROP_BGCOLOR,m_buttons_color[i],m_buttons_color_hover[i],m_buttons_total[i].m_buttons_color_array);
     }
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CButtonsGroup::Show(void)
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
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CButtonsGroup::Hide(void)
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
void CButtonsGroup::Reset(void)
  {
//--- Выйдем, если элемент выпадающий
   if(CElement::IsDropdown())
      return;
//--- Скрыть и показать
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CButtonsGroup::SetZorders(void)
  {
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
      m_buttons[i].Z_Order(m_buttons_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CButtonsGroup::ResetZorders(void)
  {
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
      m_buttons[i].Z_Order(-1);
  }
//+------------------------------------------------------------------+
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CButtonsGroup::Delete(void)
  {
//--- Удаление объектов
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
      m_buttons[i].Delete();
//--- Освобождение массивов элемента
   ::ArrayFree(m_buttons);
   ::ArrayFree(m_buttons_total);
   ::ArrayFree(m_buttons_state);
   ::ArrayFree(m_buttons_x_gap);
   ::ArrayFree(m_buttons_y_gap);
   ::ArrayFree(m_buttons_text);
   ::ArrayFree(m_buttons_width);
   ::ArrayFree(m_buttons_color);
   ::ArrayFree(m_buttons_color_hover);
   ::ArrayFree(m_buttons_color_pressed);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Изменение состояния кнопок                                       |
//+------------------------------------------------------------------+
void CButtonsGroup::ButtonsGroupState(const bool state)
  {
   m_buttons_group_state=state;
//---
   int buttons_total=ButtonsTotal();
   for(int i=0; i<buttons_total; i++)
     {
      m_buttons[i].State(false);
      m_buttons[i].Color((state)? m_text_color : m_text_color_off);
      m_buttons[i].BackColor((state)? m_buttons_color[i]: m_back_color_off);
      m_buttons[i].BorderColor((state)? m_border_color : m_border_color_off);
     }
//--- Нажать кнопку, если до блокировки была нажатая
   if(m_buttons_group_state)
     {
      if(m_selected_button_index!=WRONG_VALUE)
        {
         m_buttons_state[m_selected_button_index]=true;
         m_buttons[m_selected_button_index].Color(m_text_color_pressed);
         m_buttons[m_selected_button_index].BackColor(m_buttons_color_pressed[m_selected_button_index]);
        }
     }
  }
//+------------------------------------------------------------------+
//| Переключает кнопку по указанному индексу                         |
//+------------------------------------------------------------------+
void CButtonsGroup::SelectionButton(const int index)
  {
//--- Для проверки существования нажатой в группе кнопки
   bool check_pressed_button=false;
//--- Получим количество кнопок
   int buttons_total=ButtonsTotal();
//--- Если нет ни одной кнопки в группе, сообщить об этом
   if(buttons_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна кнопка! Воспользуйтесь методом CButtonsGroup::AddButton()");
     }
//--- Скорректировать значение индекса, если выходит из диапазона
   int correct_index=(index>=buttons_total)? buttons_total-1 : (index<0)? 0 : index;
//--- Изменить состояние кнопки на противоположное
   m_buttons_state[correct_index]=(m_buttons_state[correct_index])? false : true;
//--- Пройдёмся в цикле по группе кнопок
   for(int i=0; i<buttons_total; i++)
     {
      //--- В зависимости от режима осуществляется соответствующая проверка
      bool condition=(m_radio_buttons_mode)? (i==correct_index) : (i==correct_index && m_buttons_state[i]);
      //--- Если условие исполнено, сделаем кнопку нажатой
      if(condition)
        {
         if(m_radio_buttons_mode)
            m_buttons_state[i]=true;
         //--- Есть нажатая кнопка
         check_pressed_button=true;
         //--- Установить цвета
         m_buttons[i].Color(m_text_color_pressed);
         m_buttons[i].BackColor(m_buttons_color_pressed[i]);
         CElement::InitColorArray(m_buttons_color_pressed[i],m_buttons_color_pressed[i],m_buttons_total[i].m_buttons_color_array);
        }
      //--- Если условие не исполнилось, сделаем кнопку отжатой
      else
        {
         //--- Установить отключенное состояние и цвета
         m_buttons_state[i]=false;
         m_buttons[i].Color(m_text_color);
         m_buttons[i].BackColor(m_buttons_color[i]);
         CElement::InitColorArray(m_buttons_color[i],m_buttons_color_hover[i],m_buttons_total[i].m_buttons_color_array);
        }
      //--- Обнулить штатное состояние кнопки
      m_buttons[i].State(false);
     }
//--- Если есть нажатая кнопка, сохраним её текст и индекс
   m_selected_button_text  =(check_pressed_button) ? m_buttons[correct_index].Description() : "";
   m_selected_button_index =(check_pressed_button) ? correct_index : WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку в группе                                       |
//+------------------------------------------------------------------+
bool CButtonsGroup::OnClickButton(const string pressed_object)
  {
//--- Выйдем, если нажатие было не на пункте меню
   if(::StringFind(pressed_object,CElement::ProgramName()+"_buttons_",0)<0)
      return(false);
//--- Получим идентификатор из имени объекта
   int id=IdFromObjectName(pressed_object);
//--- Выйдем, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Для проверки индекса
   int check_index=WRONG_VALUE;
//--- Проверим, было ли нажатие на одной из кнопок этой группы
   int buttons_total=ButtonsTotal();
//--- Выйти, если кнопки заблокированы
   if(!m_buttons_group_state)
     {
      for(int i=0; i<buttons_total; i++)
         m_buttons[i].State(false);
      //---
      return(false);
     }
//--- Если нажатие было, то запомним индекс
   for(int i=0; i<buttons_total; i++)
     {
      if(m_buttons[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- Выйдем, если не было нажатия на кнопку в этой группе
   if(check_index==WRONG_VALUE)
      return(false);
//--- Переключить кнопку
   SelectionButton(check_index);
//--- Отправить сигнал об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),m_selected_button_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверка нажатой левой кнопки мыши над кнопками группы           |
//+------------------------------------------------------------------+
void CButtonsGroup::CheckPressedOverButton(void)
  {
   int buttons_total=ButtonsTotal();
//--- Установить цвет в зависимости от местоположения зажатой левой кнопки мыши
   for(int i=0; i<buttons_total; i++)
     {
      //--- Если есть фокус, то цвет нажатой кнопки
      if(m_buttons[i].MouseFocus())
         m_buttons[i].BackColor(m_buttons_color_pressed[i]);
      //--- Если фокуса нет, то...
      else
        {
         //--- ...если кнопка группы не нажата, присвоить цвет фона
         if(!m_buttons_state[i])
            m_buttons[i].BackColor(m_buttons_color[i]);
        }
     }
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CButtonsGroup::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
