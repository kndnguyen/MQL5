//+------------------------------------------------------------------+
//|                                                     CheckBox.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания чек-бокса                                     |
//+------------------------------------------------------------------+
class CCheckBox : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания чек-бокса
   CRectLabel        m_area;
   CBmpLabel         m_check;
   CLabel            m_label;
   //--- Цвет фона чекбокса
   color             m_area_color;
   //--- Ярлыки чекбокса в активном и заблокированном состоянии
   string            m_check_bmp_file_on;
   string            m_check_bmp_file_off;
   string            m_check_bmp_file_on_locked;
   string            m_check_bmp_file_off_locked;
   //--- Состояние кнопки чек-бокса
   bool              m_check_button_state;
   //--- Текст чек-бокса
   string            m_label_text;
   //--- Отступы текстовой метки
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвета текстовой метки в разных состояниях
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_zorder;
   int               m_area_zorder;
   //--- Состояние элемента (доступен/заблокирован)
   bool              m_checkbox_state;
   //---
public:
                     CCheckBox(void);
                    ~CCheckBox(void);
   //--- Методы для создания чек-бокса
   bool              CreateCheckBox(const long chart_id,const int subwin,const string text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCheck(void);
   bool              CreateLabel(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращение/установка состояния чек-бокса
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);            }
   bool              CheckBoxState(void)                      const { return(m_checkbox_state);              }
   void              CheckBoxState(const bool state);
   //--- Установка ярлыков для кнопки в активном и заблокированном состояниях
   void              CheckFileOn(const string file_path)            { m_check_bmp_file_on=file_path;         }
   void              CheckFileOff(const string file_path)           { m_check_bmp_file_off=file_path;        }
   void              CheckFileOnLocked(const string file_path)      { m_check_bmp_file_on_locked=file_path;  }
   void              CheckFileOffLocked(const string file_path)     { m_check_bmp_file_off_locked=file_path; }
   //--- (1) Цвет фона, (2) отступы текстовой метки
   void              AreaColor(const color clr)                     { m_area_color=clr;                      }
   void              LabelXGap(const int x_gap)                     { m_label_x_gap=x_gap;                   }
   void              LabelYGap(const int y_gap)                     { m_label_y_gap=y_gap;                   }
   //--- Цвета текста в разных состояниях
   void              LabelColor(const color clr)                    { m_label_color=clr;                     }
   void              LabelColorOff(const color clr)                 { m_label_color_off=clr;                 }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;               }
   void              LabelColorLocked(const color clr)              { m_label_color_locked=clr;              }
   //--- (1) Описание чек-бокса, (2) возвращение/установка состояния кнопки чек-бокса
   string            LabelText(void)                          const { return(m_label.Description());         }
   bool              CheckButtonState(void)                   const { return(m_check.State());               }
   void              CheckButtonState(const bool state);
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
   //--- Сбросить цвет
   virtual void      ResetColors(void);
   //---
private:
   //--- Обработка нажатия на элемент
   bool              OnClickLabel(const string clicked_object);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCheckBox::CCheckBox(void) : m_checkbox_state(true),
                             m_check_button_state(false),
                             m_area_color(C'15,15,15'),
                             m_label_x_gap(20),
                             m_label_y_gap(2),
                             m_label_color(clrWhite),
                             m_label_color_off(clrSilver),
                             m_label_color_locked(clrGray),
                             m_label_color_hover(C'85,170,255'),
                             m_check_bmp_file_on(""),
                             m_check_bmp_file_off(""),
                             m_check_bmp_file_on_locked(""),
                             m_check_bmp_file_off_locked("")

  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder      =0;
   m_area_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCheckBox::~CCheckBox(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработка событий                                                |
//+------------------------------------------------------------------+
void CCheckBox::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Координаты
      int x=(int)lparam;
      int y=(int)dparam;
      //--- Проверка фокуса над элементом
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Нажатие на чек-боксе
      if(OnClickLabel(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CCheckBox::OnEventTimer(void)
  {
//--- Если форма не заблокирована
   if(!m_wnd.IsLocked())
      //--- Изменяем цвета объектов элемента
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Создаёт группу объектов чекбокс                                  |
//+------------------------------------------------------------------+
bool CCheckBox::CreateCheckBox(const long chart_id,const int subwin,const string text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием чек-бокса классу нужно передать "
              "указатель на форму: CCheckBox::WindowPointer(CWindow &object)");
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
   if(!CreateCheck())
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
//| Создаёт площадь чекбокса                                         |
//+------------------------------------------------------------------+
bool CCheckBox::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_checkbox_area_"+(string)CElement::Id();
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
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт чекбокс                                                  |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp"
//---
bool CCheckBox::CreateCheck(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_checkbox_bmp_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+2;
   int y=CElement::Y()+2;
//--- Если не указали картинку для кнопки чек-бокса, значит установка по умолчанию
   if(m_check_bmp_file_on=="")
      m_check_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp";
   if(m_check_bmp_file_off=="")
      m_check_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp";
//---
   if(m_check_bmp_file_on_locked=="")
      m_check_bmp_file_on_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp";
   if(m_check_bmp_file_off_locked=="")
      m_check_bmp_file_off_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp";
//--- Установим объект
   if(!m_check.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_check.BmpFileOn("::"+m_check_bmp_file_on);
   m_check.BmpFileOff("::"+m_check_bmp_file_off);
   m_check.State(m_check_button_state);
   m_check.Corner(m_corner);
   m_check.Selectable(false);
   m_check.Z_Order(m_zorder);
   m_check.Tooltip("\n");
//--- Отступы от крайней точки
   m_check.XGap(x-m_wnd.X());
   m_check.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_check);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт лэйбл чекбокса                                           |
//+------------------------------------------------------------------+
bool CCheckBox::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_checkbox_lable_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+m_label_x_gap;
   int y =CElement::Y()+m_label_y_gap;
//--- Цвет текста относительно состояния
   color label_color=(m_check_button_state) ? m_label_color : m_label_color_off;
//--- Установим объект
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
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CCheckBox::Moving(const int x,const int y)
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
   m_check.X(x+m_check.XGap());
   m_check.Y(y+m_check.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_check.X_Distance(m_check.X());
   m_check.Y_Distance(m_check.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CCheckBox::ChangeObjectsColor(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_checkbox_state)
      return;
//---
   color label_color=(m_check_button_state) ? m_label_color : m_label_color_off;
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,label_color,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| Показывает комбо-бокс                                            |
//+------------------------------------------------------------------+
void CCheckBox::Show(void)
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
//| Скрывает комбо-бокс                                              |
//+------------------------------------------------------------------+
void CCheckBox::Hide(void)
  {
//--- Выйти, если элемент уже видим
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
void CCheckBox::Reset(void)
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
void CCheckBox::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_check.Delete();
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
void CCheckBox::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_check.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CCheckBox::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_check.Z_Order(-1);
   m_label.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Сброс цвета объектов элемента                                    |
//+------------------------------------------------------------------+
void CCheckBox::ResetColors(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_checkbox_state)
      return;
//--- Сбросить цвет
   m_label.Color((m_check_button_state)? m_label_color : m_label_color_off);
//--- Обнулим фокус
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Установка состояния кнопки чек-бокса                             |
//+------------------------------------------------------------------+
void CCheckBox::CheckButtonState(const bool state)
  {
//--- Выйти, если элемент заблокирован
   if(!m_checkbox_state)
      return;
//--- Установим состояние кнопке
   m_check.State(state);
   m_check_button_state=state;
//--- Изменим цвета относительно состояния
   m_label.Color((state)? m_label_color : m_label_color_off);
   CElement::InitColorArray((state)? m_label_color : m_label_color_off,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| Установка состояния элемента                                     |
//+------------------------------------------------------------------+
void CCheckBox::CheckBoxState(const bool state)
  {
//--- Состояние элемента
   m_checkbox_state=state;
//--- Картинка
   m_check.BmpFileOn((state)? "::"+m_check_bmp_file_on : "::"+m_check_bmp_file_on_locked);
   m_check.BmpFileOff((state)? "::"+m_check_bmp_file_off : "::"+m_check_bmp_file_off_locked);
//--- Цвет текстовой метки
   m_label.Color((state)? m_label_color : m_label_color_locked);
  }
//+------------------------------------------------------------------+
//| Нажатие на заголовок элемента                                    |
//+------------------------------------------------------------------+
bool CCheckBox::OnClickLabel(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта
   if(m_area.Name()!=clicked_object)
      return(false);
//--- Выйти, если элемент заблокирован
   if(!m_checkbox_state)
      return(false);
//--- Переключить на противоположный режим
   CheckButtonState(!m_check.State());
//--- Курсор мыши сейчас над элементом
   m_label.Color(m_label_color_hover);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,CElement::Id(),0,m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
