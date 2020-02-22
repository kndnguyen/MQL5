//+------------------------------------------------------------------+
//|                                                 RadioButtons.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания группы радио-кнопок                           |
//+------------------------------------------------------------------+
class CRadioButtons : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания кнопки
   CRectLabel        m_area[];
   CBmpLabel         m_icon[];
   CLabel            m_label[];
   //--- Градиенты текстовых меток
   struct LabelsGradients
     {
      color             m_labels_color_array[];
     };
   LabelsGradients   m_labels_total[];
   //--- Свойства кнопок:
   //    (1) Цвет и (2) приоритет фона на нажатие левой кнопкой мыши
   color             m_area_color;
   int               m_area_zorder;
   //--- Массивы для уникальных свойств кнопок
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   int               m_buttons_width[];
   string            m_buttons_text[];
   //--- Высота кнопок
   int               m_button_y_size;
   //--- Ярлыки кнопки в активном, отключенном и заблокированном состоянии
   string            m_icon_file_on;
   string            m_icon_file_off;
   string            m_icon_file_on_locked;
   string            m_icon_file_off_locked;
   //--- Отступы текста
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвета текста
   color             m_text_color;
   color             m_text_color_off;
   color             m_text_color_hover;
   //--- (1) Текст и (2) индекс выделенной кнопки
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- Приоритет на нажатие левой кнопкой мыши
   int               m_buttons_zorder;
   //--- Доступен/заблокирован
   bool              m_radio_buttons_state;
   //---
public:
                     CRadioButtons(void);
                    ~CRadioButtons(void);
   //--- Методы для создания кнопки
   bool              CreateRadioButtons(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateArea(const int index);
   bool              CreateRadio(const int index);
   bool              CreateLabel(const int index);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) количество кнопок,
   //    (3) общее состояние кнопки (доступен/заблокирован)
   void              WindowPointer(CWindow &object)               { m_wnd=::GetPointer(object);       }
   int               RadioButtonsTotal(void)                const { return(::ArraySize(m_icon));      }
   bool              RadioButtonsState(void)                const { return(m_radio_buttons_state);    }
   void              RadioButtonsState(const bool state);
   //--- Установка ярлыков для кнопки в активном, отключенном и заблокированном состояниях
   void              IconFileOn(const string file_path)           { m_icon_file_on=file_path;         }
   void              IconFileOff(const string file_path)          { m_icon_file_off=file_path;        }
   void              IconFileOnLocked(const string file_path)     { m_icon_file_on_locked=file_path;  }
   void              IconFileOffLocked(const string file_path)    { m_icon_file_off_locked=file_path; }
   //--- Отступы текста
   void              LabelXGap(const int x_gap)                   { m_label_x_gap=x_gap;              }
   void              LabelYGap(const int y_gap)                   { m_label_y_gap=y_gap;              }
   //--- (1) Цвет фона, (2) цвета текста
   void              AreaColor(const color clr)                   { m_area_color=clr;                 }
   void              TextColor(const color clr)                   { m_text_color=clr;                 }
   void              TextColorOff(const color clr)                { m_text_color_off=clr;             }
   void              TextColorHover(const color clr)              { m_text_color_hover=clr;           }
   //--- Возвращает (1) текст и (2) индекс выделенной кнопки
   string            SelectedButtonText(void)               const { return(m_selected_button_text);   }
   int               SelectedButtonIndex(void)              const { return(m_selected_button_index);  }
   //--- Переключает радио-кнопку по указанному индексу
   void              SelectionRadioButton(const int index);

   //--- Добавляет кнопку с указанными свойствами до создания
   void              AddButton(const int x_gap,const int y_gap,const string text,const int width);
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
   //--- Получение идентификатора из имени радио-кнопки
   int               IdFromObjectName(const string object_name);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CRadioButtons::CRadioButtons(void) : m_radio_buttons_state(true),
                                     m_button_y_size(18),
                                     m_area_color(C'15,15,15'),
                                     m_icon_file_on(""),
                                     m_icon_file_off(""),
                                     m_icon_file_on_locked(""),
                                     m_icon_file_off_locked(""),
                                     m_selected_button_text(""),
                                     m_selected_button_index(0),
                                     m_label_x_gap(20),
                                     m_label_y_gap(3),
                                     m_text_color(clrWhite),
                                     m_text_color_off(clrGray),
                                     m_text_color_hover(C'85,170,255')
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder    =1;
   m_buttons_zorder =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CRadioButtons::~CRadioButtons(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик события графика                                       |
//+------------------------------------------------------------------+
void CRadioButtons::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Выйти, если кнопки заблокированы
      if(!m_radio_buttons_state)
         return;
      //--- Определим фокус
      int x=(int)lparam;
      int y=(int)dparam;
      int radio_buttons_total=RadioButtonsTotal();
      for(int i=0; i<radio_buttons_total; i++)
         m_area[i].MouseFocus(x>m_area[i].X() && x<m_area[i].X2() && y>m_area[i].Y() && y<m_area[i].Y2());
      //---
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
void CRadioButtons::OnEventTimer(void)
  {
//--- Изменим цвет, если форма не заблокирована
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Создаёт группу объектов Кнопки                                   |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateRadioButtons(const long chart_id,const int window,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием группы радио-кнопок классу нужно передать "
              "указатель на форму: CButtonsGroup::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =window;
   m_x        =x;
   m_y        =y;
//--- Получим количество кнопок в группе
   int radio_buttons_total=RadioButtonsTotal();
//--- Если нет ни одной кнопки в группе, сообщить об этом
   if(radio_buttons_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна кнопка! Воспользуйтесь методом CRadioButtons::AddButton()");
      return(false);
     }
//--- Установим группу кнопок
   for(int i=0; i<radio_buttons_total; i++)
     {
      CreateArea(i);
      CreateRadio(i);
      CreateLabel(i);
      //--- Обнуление фокуса
      m_area[i].MouseFocus(false);
     }
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь радио-кнопки                                     |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateArea(const int index)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_radio_area_"+(string)index+"__"+(string)CElement::Id();
//--- Расчёт координат
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index];
//--- Установим фон
   if(!m_area[index].Create(m_chart_id,name,m_subwin,x,y,m_buttons_width[index],m_button_y_size))
      return(false);
//--- Установка свойств
   m_area[index].BackColor(m_area_color);
   m_area[index].Color(m_area_color);
   m_area[index].BorderType(BORDER_FLAT);
   m_area[index].Corner(m_corner);
   m_area[index].Selectable(false);
   m_area[index].Z_Order(m_area_zorder);
   m_area[index].Tooltip("\n");
//--- Координаты
   m_area[index].X(x);
   m_area[index].Y(y);
//--- Размеры
   m_area[index].XSize(m_buttons_width[index]);
   m_area[index].YSize(m_button_y_size);
//--- Отступы от крайней точки
   m_area[index].XGap(x-m_wnd.X());
   m_area[index].YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт картинку                                                 |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_on.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_off.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_on_locked.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_off_locked.bmp"
//---
bool CRadioButtons::CreateRadio(const int index)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_radio_bmp_"+(string)index+"__"+(string)CElement::Id();
//--- Расчёт координат
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index]+3;
//--- Если не указали картинки для радио-кнопки, значит установка по умолчанию
   if(m_icon_file_on=="")
      m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\radio_button_on.bmp";
   if(m_icon_file_off=="")
      m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\radio_button_off.bmp";
   if(m_icon_file_on_locked=="")
      m_icon_file_on_locked="Images\\EasyAndFastGUI\\Controls\\radio_button_on_locked.bmp";
   if(m_icon_file_off_locked=="")
      m_icon_file_off_locked="Images\\EasyAndFastGUI\\Controls\\radio_button_off_locked.bmp";
//--- Установим картинку
   if(!m_icon[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
   m_icon[index].BmpFileOn("::"+m_icon_file_on);
   m_icon[index].BmpFileOff("::"+m_icon_file_off);
   m_icon[index].State((index==m_selected_button_index) ? true : false);
   m_icon[index].Corner(m_corner);
   m_icon[index].GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon[index].Selectable(false);
   m_icon[index].Z_Order(m_buttons_zorder);
   m_icon[index].Tooltip("\n");
//--- Отступы от крайней точки
   m_icon[index].XGap(x-m_wnd.X());
   m_icon[index].YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_icon[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт текстовую метку                                          |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateLabel(const int index)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_radio_lable_"+(string)index+"__"+(string)CElement::Id();
//--- Расчёт координат
   int x =CElement::X()+m_buttons_x_gap[index]+m_label_x_gap;
   int y =CElement::Y()+m_buttons_y_gap[index]+m_label_y_gap;
//--- Установим текстовую метку
   if(!m_label[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//---
   color label_color=(index==m_selected_button_index) ? m_text_color : m_text_color_off;
//--- Установка свойств
   m_label[index].Description(m_buttons_text[index]);
   m_label[index].Font(FONT);
   m_label[index].FontSize(FONT_SIZE);
   m_label[index].Color(label_color);
   m_label[index].Corner(m_corner);
   m_label[index].Anchor(m_anchor);
   m_label[index].Selectable(false);
   m_label[index].Z_Order(m_buttons_zorder);
   m_label[index].Tooltip("\n");
//--- Отступы от крайней точки
   m_label[index].XGap(x-m_wnd.X());
   m_label[index].YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(label_color,m_text_color_hover,m_labels_total[index].m_labels_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет кнопку                                                 |
//+------------------------------------------------------------------+
void CRadioButtons::AddButton(const int x_gap,const int y_gap,const string text,const int width)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_buttons_text);
   ::ArrayResize(m_area,array_size+1);
   ::ArrayResize(m_icon,array_size+1);
   ::ArrayResize(m_label,array_size+1);
   ::ArrayResize(m_labels_total,array_size+1);
   ::ArrayResize(m_buttons_x_gap,array_size+1);
   ::ArrayResize(m_buttons_y_gap,array_size+1);
   ::ArrayResize(m_buttons_state,array_size+1);
   ::ArrayResize(m_buttons_text,array_size+1);
   ::ArrayResize(m_buttons_width,array_size+1);
//--- Сохраним значения переданных параметров
   m_buttons_x_gap[array_size] =x_gap;
   m_buttons_y_gap[array_size] =y_gap;
   m_buttons_text[array_size]  =text;
   m_buttons_width[array_size] =width;
   m_buttons_state[array_size] =false;
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CRadioButtons::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
     return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].X(x+m_area[i].XGap());
      m_area[i].Y(y+m_area[i].YGap());
      m_icon[i].X(x+m_icon[i].XGap());
      m_icon[i].Y(y+m_icon[i].YGap());
      m_label[i].X(x+m_label[i].XGap());
      m_label[i].Y(y+m_label[i].YGap());
     }
//--- Обновление координат графических объектов
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].X_Distance(m_area[i].X());
      m_area[i].Y_Distance(m_area[i].Y());
      m_icon[i].X_Distance(m_icon[i].X());
      m_icon[i].Y_Distance(m_icon[i].Y());
      m_label[i].X_Distance(m_label[i].X());
      m_label[i].Y_Distance(m_label[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CRadioButtons::ChangeObjectsColor(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      color label_color=(m_buttons_state[i]) ? m_text_color : m_text_color_off;
      ChangeObjectColor(m_label[i].Name(),m_area[i].MouseFocus(),
                        OBJPROP_COLOR,label_color,m_text_color_hover,m_labels_total[i].m_labels_color_array);
     }
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CRadioButtons::SetZorders(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Z_Order(m_area_zorder);
      m_icon[i].Z_Order(m_buttons_zorder);
      m_label[i].Z_Order(m_buttons_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CRadioButtons::ResetZorders(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Z_Order(-1);
      m_icon[i].Z_Order(-1);
      m_label[i].Z_Order(-1);
     }
  }
//+------------------------------------------------------------------+
//| Показывает кнопку                                                |
//+------------------------------------------------------------------+
void CRadioButtons::Show(void)
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
void CRadioButtons::Hide(void)
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
void CRadioButtons::Reset(void)
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
void CRadioButtons::Delete(void)
  {
//--- Удаление объектов
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Delete();
      m_icon[i].Delete();
      m_label[i].Delete();
     }
//--- Освобождение массивов элемента
   ::ArrayFree(m_labels_total);
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
void CRadioButtons::RadioButtonsState(const bool state)
  {
   m_radio_buttons_state=state;
//---
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_icon[i].BmpFileOn((state)? "::"+m_icon_file_on : "::"+m_icon_file_on_locked);
      m_icon[i].BmpFileOff((state)? "::"+m_icon_file_off : "::"+m_icon_file_off_locked);
      m_label[i].Color((state && i==m_selected_button_index)? m_text_color : m_text_color_off);
     }
  }
//+------------------------------------------------------------------+
//| Указывает, какая радио-кнопка должна быть выделена               |
//+------------------------------------------------------------------+
void CRadioButtons::SelectionRadioButton(const int index)
  {
//--- Получим количество кнопок
   int radio_buttons_total=RadioButtonsTotal();
//--- Если нет ни одной радио-кнопки в группе, сообщить об этом
   if(radio_buttons_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна радио-кнопка! Воспользуйтесь методом CRadioButtons::AddButton()");
     }
//--- Скорректировать значение индекса, если выходит из диапазона
   int correct_index=(index>=radio_buttons_total)? radio_buttons_total-1 :(index<0)? 0 : index;
//--- Переключить кнопку
   for(int i=0; i<radio_buttons_total; i++)
     {
      if(i==correct_index)
        {
         m_buttons_state[i]=true;
         m_icon[i].State(true);
         m_label[i].Color(m_text_color_hover);
         InitColorArray(m_text_color,m_text_color_hover,m_labels_total[i].m_labels_color_array);
        }
      else
        {
         m_buttons_state[i]=false;
         m_icon[i].State(false);
         m_label[i].Color(m_text_color_off);
         InitColorArray(m_text_color_off,m_text_color_hover,m_labels_total[i].m_labels_color_array);
        }
     }
//--- Сохраним её текст и индекс
   m_selected_button_index =correct_index;
   m_selected_button_text  =m_buttons_text[correct_index];
  }
//+------------------------------------------------------------------+
//| Нажатие на радио-кнопку                                          |
//+------------------------------------------------------------------+
bool CRadioButtons::OnClickButton(const string pressed_object)
  {
//--- Выйдем, если нажатие было не на пункте меню
   if(::StringFind(pressed_object,CElement::ProgramName()+"_radio_area_",0)<0)
      return(false);
//--- Получим идентификатор и индекс из имени объекта
   int id=IdFromObjectName(pressed_object);
//--- Выйдем, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Для проверки индекса
   int check_index=WRONG_VALUE;
//--- Выйти, если кнопки заблокированы
   if(!m_radio_buttons_state)
      return(false);
//--- Если нажатие было, то запомним индекс
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      if(m_area[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- Выйдем, если не было нажатия на кнопку в этой группе или
//    если это уже выделенная радио-кнопка
   if(check_index==WRONG_VALUE || check_index==m_selected_button_index)
      return(false);
//--- Переключить кнопку
   SelectionRadioButton(check_index);
//--- Отправить сигнал об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,CElement::Id(),check_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CRadioButtons::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
