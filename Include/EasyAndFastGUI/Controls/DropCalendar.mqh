//+------------------------------------------------------------------+
//|                                                 DropCalendar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Calendar.mqh"
//+------------------------------------------------------------------+
//| Класс для создания выпадающего календаря                         |
//+------------------------------------------------------------------+
class CDropCalendar : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты и элементы для создания элемента
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_field;
   CEdit             m_drop_button;
   CBmpLabel         m_drop_button_icon;
   CCalendar         m_calendar;
   //--- Цвет фона
   color             m_area_color;
   //--- Отображаемое описание элемента
   string            m_label_text;
   //--- Цвета текстовой метки в разных состояниях
   color             m_label_color;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- Цвета поля ввода в разных состояниях
   color             m_edit_color;
   color             m_edit_color_locked;
   //--- Цвета рамки комбо-бокса в разных состояниях
   color             m_border_color;
   color             m_border_color_hover;
   color             m_border_color_locked;
   color             m_border_color_array[];
   //--- Размеры комбо-бокса
   int               m_combobox_x_size;
   int               m_combobox_y_size;
   //--- Размеры кнопки комбо-бокса
   int               m_button_x_size;
   int               m_button_y_size;
   //--- Цвета кнопки в разных состояниях
   color             m_button_color;
   color             m_button_color_hover;
   color             m_button_color_locked;
   color             m_button_color_pressed;
   color             m_button_color_array[];
   //--- Цвет текста в поле комбо-бокса
   color             m_combobox_text_color;
   color             m_combobox_text_color_locked;
   //--- Картинки для кнопки
   string            m_icon_file_on;
   string            m_icon_file_off;
   string            m_icon_file_locked;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_area_zorder;
   int               m_combobox_zorder;
   int               m_zorder;
   //--- Доступен/заблокирован
   bool              m_drop_calendar_state;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //---
public:
                     CDropCalendar(void);
                    ~CDropCalendar(void);
   //--- Методы для создания выпадающего календаря
   bool              CreateDropCalendar(const long chart_id,const int subwin,const string text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateEditBox(void);
   bool              CreateDropButton(void);
   bool              CreateDropButtonIcon(void);
   bool              CreateCalendar(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) получение указателя календаря, (3) возвращение/установка состояния элемента
   void              WindowPointer(CWindow &object)          { m_wnd=::GetPointer(object);       }
   CCalendar        *GetCalendarPointer(void)                { return(::GetPointer(m_calendar)); }
   bool              DropCalendarState(void)           const { return(m_drop_calendar_state);    }
   void              DropCalendarState(const bool state);
   //--- (1) Размер кнопки комбо-бокса по оси X, (2) размеры комбо-бокса
   void              ButtonXSize(const int x_size)           { m_button_x_size=x_size;           }
   void              ComboboxXSize(const int x_size)         { m_combobox_x_size=x_size;         }
   void              ComboboxYSize(const int y_size)         { m_combobox_y_size=y_size;         }
   //--- Установка и получение отображаемого текста описания элемента
   void              LabelText(const string text)            { m_label_text=text;                }
   string            LabelText(void)                   const { return(m_label.Description());    }
   //--- (1) Установка цвета фона, (2) цвета текстовой метки в разных состояниях
   void              AreaBackColor(const color clr)          { m_area_color=clr;                 }
   void              LabelColor(const color clr)             { m_label_color=clr;                }
   void              LabelColorHover(const color clr)        { m_label_color_hover=clr;          }
   void              LabelColorLocked(const color clr)       { m_label_color_locked=clr;         }
   //--- Цвета поля ввода в разных состояниях
   void              EditColor(const color clr)              { m_edit_color=clr;                 }
   void              EditColorLocked(const color clr)        { m_edit_color_locked=clr;          }
   //--- (1) Цвет кнопки комбо-бокса в разных состояниях, (2) цвет текста в поле комбо-бокса
   void              ButtonColor(const color clr)            { m_button_color=clr;               }
   void              ButtonColorHover(const color clr)       { m_button_color_hover=clr;         }
   void              ButtonColorLocked(const color clr)      { m_button_color_locked=clr;        }
   void              ButtonColorPressed(const color clr)     { m_button_color_pressed=clr;       }
   void              ComboboxTextColor(const color clr)      { m_combobox_text_color=clr;        }
   //--- (1) Цвет рамки кнопки комбо-бокса в разных состояниях
   void              BorderColor(const color clr)            { m_border_color=clr;               }
   void              BorderColorHover(const color clr)       { m_border_color_hover=clr;         }
   void              BorderColorLocked(const color clr)      { m_border_color_locked=clr;        }
   //--- Установка ярлыков для кнопки в активном и заблокированном состояниях
   void              IconFileOn(const string file_path)      { m_icon_file_on=file_path;         }
   void              IconFileOff(const string file_path)     { m_icon_file_off=file_path;        }
   void              IconFileLocked(const string file_path)  { m_icon_file_locked=file_path;     }
   //--- (1) Установить (выделить) и (2) получить выделенную дату
   void              SelectedDate(const datetime date);
   datetime          SelectedDate(void) { return(m_calendar.SelectedDate()); }
   //--- Изменение цвета объектов
   void              ChangeObjectsColor(void);
   //--- Изменение состояния видимости календаря на противоположное
   void              ChangeComboBoxCalendarState(void);
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
   //--- Обработка нажатия на кнопку комбо-бокса
   bool              OnClickButton(const string clicked_object);
   //--- Проверка нажатой левой кнопки мыши над кнопкой комбо-бокса
   void              CheckPressedOverButton(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CDropCalendar::CDropCalendar(void) : m_drop_calendar_state(true),
                                     m_button_x_size(32),
                                     m_button_y_size(20),
                                     m_combobox_x_size(100),
                                     m_combobox_y_size(20),
                                     m_area_color(C'15,15,15'),
                                     m_label_text("Drop calendar: "),
                                     m_label_color(clrBlack),
                                     m_label_color_hover(C'85,170,255'),
                                     m_label_color_locked(clrSilver),
                                     m_edit_color(clrWhite),
                                     m_edit_color_locked(clrWhiteSmoke),
                                     m_border_color(clrSilver),
                                     m_border_color_hover(C'85,170,255'),
                                     m_border_color_locked(clrSilver),
                                     m_button_color(C'220,220,220'),
                                     m_button_color_hover(C'193,218,255'),
                                     m_button_color_locked(C'230,230,230'),
                                     m_button_color_pressed(C'153,178,215'),
                                     m_combobox_text_color(clrBlack),
                                     m_combobox_text_color_locked(clrSilver),
                                     m_icon_file_on(""),
                                     m_icon_file_off(""),
                                     m_icon_file_locked("")

  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder     =1;
   m_combobox_zorder =2;
   m_zorder          =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CDropCalendar::~CDropCalendar(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CDropCalendar::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_drop_button.MouseFocus(x>m_drop_button.X() && x<m_drop_button.X2() && 
                               y>m_drop_button.Y() && y<m_drop_button.Y2());
      //--- Проверка нажатой левой кнопки мыши над кнопкой комбо-бокса
      CheckPressedOverButton();
      return;
     }
//--- Обработка события выбора новой даты в календаре
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_DATE)
     {
      //--- Выйти, если идентификаторы элементов не совпадают
      if(lparam!=CElement::Id())
         return;
      //--- Установим новую дату в поле комбо-бокса
      m_field.Description(::TimeToString((datetime)dparam,TIME_DATE));
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Нажатие на кнопке комбо-бокса
      if(OnClickButton(sparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CDropCalendar::OnEventTimer(void)
  {
//--- Если элемент выпадающий
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- Отслеживаем изменение цвета, только если форма не заблокирована
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт выпадающий календарь                                     |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateDropCalendar(const long chart_id,const int subwin,const string text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием выпадающего календаря классу нужно передать "
              "указатель на форму: CDropCalendar::WindowPointer(CWindow &object).");
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
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание элемента
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateEditBox())
      return(false);
   if(!CreateDropButton())
      return(false);
   if(!CreateDropButtonIcon())
      return(false);
   if(!CreateCalendar())
      return(false);
//--- Скрыть календарь
   m_calendar.Hide();
//--- Отобразить выделенную дату в календаре
   m_field.Description(::TimeToString((datetime)m_calendar.SelectedDate(),TIME_DATE));
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь комбо-бокса                                      |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_dc_combobox_area_"+(string)CElement::Id();
//--- Установим объект
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_button_y_size))
      return(false);
//--- Установка свойств
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт лэйбл комбо-бокса                                        |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_dc_combobox_lable_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y()+2;
//--- Установим объект
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
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
//| Создаёт поле ввода даты и времени                                |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateEditBox(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_dc_combobox_edit_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+CElement::XSize()-m_combobox_x_size;
   int y =CElement::Y()-1;
//--- Установим объект
   if(!m_field.Create(m_chart_id,name,m_subwin,x,y,m_combobox_x_size,m_combobox_y_size))
      return(false);
//--- Установка свойств
   m_field.Font(FONT);
   m_field.FontSize(FONT_SIZE);
   m_field.Color(m_combobox_text_color);
   m_field.Description("");
   m_field.BorderColor(m_border_color);
   m_field.BackColor(m_edit_color);
   m_field.Corner(m_corner);
   m_field.Anchor(m_anchor);
   m_field.Selectable(false);
   m_field.Z_Order(m_combobox_zorder);
   m_field.ReadOnly(true);
   m_field.Tooltip("\n");
//--- Сохраним координаты
   m_field.X(x);
   m_field.Y(y);
//--- Сохраним размеры
   m_field.XSize(m_combobox_x_size);
   m_field.YSize(m_combobox_y_size);
//--- Отступы от крайней точки
   m_field.XGap(x-m_wnd.X());
   m_field.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_field);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку комбо-бокса                                       |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateDropButton(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_dc_combobox_button_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+CElement::XSize()-m_button_x_size;
   int y =CElement::Y()-1;
//--- Установим объект
   if(!m_drop_button.Create(m_chart_id,name,m_subwin,x,y,m_button_x_size,m_combobox_y_size))
      return(false);
//--- Установка свойств
   m_drop_button.Font(FONT);
   m_drop_button.FontSize(FONT_SIZE);
   m_drop_button.Color(m_combobox_text_color);
   m_drop_button.Description("");
   m_drop_button.BorderColor(m_border_color);
   m_drop_button.BackColor(m_button_color);
   m_drop_button.Corner(m_corner);
   m_drop_button.Anchor(m_anchor);
   m_drop_button.Selectable(false);
   m_drop_button.Z_Order(m_combobox_zorder);
   m_drop_button.ReadOnly(true);
   m_drop_button.Tooltip("\n");
//--- Сохраним координаты
   m_drop_button.X(x);
   m_drop_button.Y(y);
//--- Сохраним размеры
   m_drop_button.XSize(m_button_x_size);
   m_drop_button.YSize(m_combobox_y_size);
//--- Отступы от крайней точки
   m_drop_button.XGap(x-m_wnd.X());
   m_drop_button.YGap(y-m_wnd.Y());
//--- Инициализация массивов градиента
   CElement::InitColorArray(m_border_color,m_border_color_hover,m_border_color_array);
   CElement::InitColorArray(m_button_color,m_button_color_hover,m_button_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_drop_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт картинку на кнопке комбо-бокса                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_drop_on.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_drop_off.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_drop_locked.bmp"
//---
bool CDropCalendar::CreateDropButtonIcon(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_dc_combobox_icon_"+(string)CElement::Id();
//--- Координаты
   int x=m_drop_button.X()+m_button_x_size-25;
   int y=CElement::Y()+1;
//--- Если картинка не определена, установка по умолчанию
   if(m_icon_file_on=="")
      m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\calendar_drop_on.bmp";
   if(m_icon_file_off=="")
      m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\calendar_drop_off.bmp";
   if(m_icon_file_locked=="")
      m_icon_file_locked="Images\\EasyAndFastGUI\\Controls\\calendar_drop_locked.bmp";
//--- Установим объект
   if(!m_drop_button_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
   m_drop_button_icon.BmpFileOn("::"+m_icon_file_on);
   m_drop_button_icon.BmpFileOff("::"+m_icon_file_off);
   m_drop_button_icon.Corner(m_corner);
   m_drop_button_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_drop_button_icon.Selectable(false);
   m_drop_button_icon.Z_Order(m_zorder);
   m_drop_button_icon.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_drop_button_icon.XSize(m_drop_button_icon.X_Size());
   m_drop_button_icon.YSize(m_drop_button_icon.Y_Size());
//--- Сохраним координаты
   m_drop_button_icon.X(x);
   m_drop_button_icon.Y(y);
//--- Отступы от крайней точки
   m_drop_button_icon.XGap(x-m_wnd.X());
   m_drop_button_icon.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_drop_button_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт список                                                   |
//+------------------------------------------------------------------+
bool CDropCalendar::CreateCalendar(void)
  {
//--- Передать объект панели
   m_calendar.WindowPointer(m_wnd);
//--- Координаты
   int x=m_field.X();
   int y=m_field.Y2();
//--- Установим календарю признак выпадающего элемента
   m_calendar.IsDropdown(true);
//--- Создадим элемент управления
   if(!m_calendar.CreateCalendar(m_chart_id,m_subwin,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Установка новой даты в календарь                                 |
//+------------------------------------------------------------------+
void CDropCalendar::SelectedDate(const datetime date)
  {
//--- Установим и запомним дату
   m_calendar.SelectedDate(date);
//--- Отобразим дату в поле ввода комбо-бокса
   m_field.Description(::TimeToString(date,TIME_DATE));
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CDropCalendar::ChangeObjectsColor(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_drop_calendar_state)
      return;
//---
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_field.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
   CElement::ChangeObjectColor(m_drop_button.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
   CElement::ChangeObjectColor(m_drop_button.Name(),m_drop_button.MouseFocus(),OBJPROP_BGCOLOR,m_button_color,m_button_color_hover,m_button_color_array);
  }
//+------------------------------------------------------------------+
//| Изменение состояния элемента                                     |
//+------------------------------------------------------------------+
void CDropCalendar::DropCalendarState(const bool state)
  {
   m_drop_calendar_state=state;
//--- Картинка
   m_drop_button_icon.BmpFileOff((state)? "::"+m_icon_file_on : "::"+m_icon_file_locked);
//--- Цвет текстовой метки
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- Цвета поля ввода
   m_field.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_field.Color((state)? m_combobox_text_color : m_combobox_text_color_locked);
   m_field.BorderColor((state)? m_border_color : m_border_color_locked);
//--- Цвета кнопки комбо-бокса
   m_drop_button.BackColor((state)? m_button_color : m_button_color_locked);
   m_drop_button.BorderColor((state)? m_border_color : m_border_color_locked);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CDropCalendar::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение отступов в полях элемента
   CElement::X(x+CElement::XGap());
   CElement::Y(y+CElement::YGap());
//--- Сохранение координат в полях объектов
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_field.X(x+m_field.XGap());
   m_field.Y(y+m_field.YGap());
   m_drop_button.X(x+m_drop_button.XGap());
   m_drop_button.Y(y+m_drop_button.YGap());
   m_drop_button_icon.X(x+m_drop_button_icon.XGap());
   m_drop_button_icon.Y(y+m_drop_button_icon.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_field.X_Distance(m_field.X());
   m_field.Y_Distance(m_field.Y());
   m_drop_button.X_Distance(m_drop_button.X());
   m_drop_button.Y_Distance(m_drop_button.Y());
   m_drop_button_icon.X_Distance(m_drop_button_icon.X());
   m_drop_button_icon.Y_Distance(m_drop_button_icon.Y());
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CDropCalendar::Show(void)
  {
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_label.Timeframes(OBJ_ALL_PERIODS);
   m_field.Timeframes(OBJ_ALL_PERIODS);
   m_drop_button.Timeframes(OBJ_ALL_PERIODS);
   m_drop_button_icon.Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CDropCalendar::Hide(void)
  {
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_label.Timeframes(OBJ_NO_PERIODS);
   m_field.Timeframes(OBJ_NO_PERIODS);
   m_drop_button.Timeframes(OBJ_NO_PERIODS);
   m_drop_button_icon.Timeframes(OBJ_NO_PERIODS);
   m_calendar.Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CDropCalendar::Reset(void)
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
void CDropCalendar::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_label.Delete();
   m_field.Delete();
   m_drop_button.Delete();
   m_drop_button_icon.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CDropCalendar::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_zorder);
   m_field.Z_Order(m_combobox_zorder);
   m_drop_button.Z_Order(m_combobox_zorder);
   m_drop_button_icon.Z_Order(m_zorder);
   m_calendar.SetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CDropCalendar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_field.Z_Order(0);
   m_drop_button.Z_Order(0);
   m_drop_button_icon.Z_Order(0);
   m_calendar.ResetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс цвета у всех объектов                                      |
//+------------------------------------------------------------------+
void CDropCalendar::ResetColors(void)
  {
   m_label.Color(m_label_color);
   m_field.BorderColor(m_border_color);
   m_drop_button.BackColor(m_button_color);
   m_drop_button.BorderColor(m_border_color);
  }
//+------------------------------------------------------------------+
//| Изменение состояния видимости календаря на противоположное       |
//+------------------------------------------------------------------+
void CDropCalendar::ChangeComboBoxCalendarState(void)
  {
//--- Если календарь открыт
   if(m_calendar.IsVisible())
     {
      //--- Спрячем его и установим соответствующие значения свойствам кнопки
      m_calendar.Hide();
      m_drop_button_icon.State(false);
      m_label.Color(m_label_color_hover);
      m_field.BorderColor(m_border_color_hover);
      m_drop_button.BorderColor(m_border_color_hover);
      m_drop_button.BackColor(m_button_color_hover);
      //--- Разблокировать форму
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
//--- Если календарь скрыт
   else
     {
      //--- Откроем его и установим соответствующие значения свойствам кнопки
      m_calendar.Show();
      m_drop_button_icon.State(true);
      m_drop_button.BackColor(m_button_color_pressed);
      //--- Заблокировать форму
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
     }
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку комбо-бокса                                    |
//+------------------------------------------------------------------+
bool CDropCalendar::OnClickButton(const string clicked_object)
  {
//--- Выйти, если нажали не на кнопку комбо-бокса
   if(clicked_object!=m_drop_button.Name())
      return(false);
//--- Выйти, если форма заблокирована и идентификаторы не совпадают
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- Выйти, если элемент заблокирован
   if(!m_drop_calendar_state)
      return(false);
//--- Изменить состояние видимости календаря на противоположное
   ChangeComboBoxCalendarState();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_COMBOBOX_BUTTON,CElement::Id(),0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверка нажатой левой кнопки мыши над кнопкой                   |
//+------------------------------------------------------------------+
void CDropCalendar::CheckPressedOverButton(void)
  {
//--- Выйти, если левая кнопка мыши отжата
   if(!m_mouse_state)
      return;
//--- Выйти, если элемент заблокирован
   if(!m_drop_calendar_state)
      return;
//--- Если есть фокус на элементе
   if(CElement::MouseFocus())
     {
      //--- Выйти, если форма заблокирована и идентификаторы не совпадают
      if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
         return;
      //--- Если календарь скрыт
      if(!m_calendar.IsVisible())
        {
         //--- Установить цвет кнопке относительно курсора мыши
         if(m_drop_button.MouseFocus())
            m_drop_button.BackColor(m_button_color_pressed);
         else
            m_drop_button.BackColor(m_button_color);
        }
     }
//--- Если нет фокуса на элементе
   else
     {
      //--- Выйти, если фокус на календаре
      if(m_calendar.MouseFocus())
         return;
      //--- Выйти, если полоса прокрутки списка месяцев календаря в действии
      if(m_calendar.GetScrollVPointer().ScrollState())
         return;
      //--- Скрыть календарь и сбросить цвета объектов
      m_calendar.Hide();
      m_drop_button_icon.State(false);
      //--- Сбросить цвета
      ResetColors();
      //--- Разблокировать форму, если идентификаторы элемента и активатора совпадают
      if(m_wnd.IdActivatedElement()==CElement::Id())
         m_wnd.IsLocked(false);
     }
  }
//+------------------------------------------------------------------+
