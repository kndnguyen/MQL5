//+------------------------------------------------------------------+
//|                                                     Calendar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "SpinEdit.mqh"
#include "ComboBox.mqh"
#include "IconButton.mqh"
#include <Tools\DateTime.mqh>
//+------------------------------------------------------------------+
//| Класс для создания календаря                                     |
//+------------------------------------------------------------------+
class CCalendar : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты и элементы для создания календаря
   CRectLabel        m_area;
   CBmpLabel         m_month_dec;
   CBmpLabel         m_month_inc;
   CComboBox         m_months;
   CSpinEdit         m_years;
   CEdit             m_days_week[7];
   CRectLabel        m_sep_line;
   CEdit             m_days[42];
   CIconButton       m_button_today;
   //--- Экзепляры структуры для работы с датами и временем:
   CDateTime         m_date;      // выделенная пользователем дата
   CDateTime         m_today;     // текущая (локальная на компьютере пользователя) дата
   CDateTime         m_temp_date; // экземпляр для расчётов и проверок
   //--- Цвет фона
   color             m_area_color;
   //--- Цвет рамки фона
   color             m_area_border_color;
   //--- Цвета пунктов календаря (дней месяца) в разных состояниях
   color             m_item_back_color;
   color             m_item_back_color_off;
   color             m_item_back_color_hover;
   color             m_item_back_color_selected;
   //--- Цвета рамок пунктов календаря в разных состояниях
   color             m_item_border_color;
   color             m_item_border_color_hover;
   color             m_item_border_color_selected;
   //--- Цвета текста пунктов календаря в разных состояниях
   color             m_item_text_color;
   color             m_item_text_color_off;
   color             m_item_text_color_hover;
   //--- Цвет разделительной линии
   color             m_sepline_color;
   //--- Ярлыки кнопок (в активном/заблокированном состоянии) для перехода к предыдущему/следующему месяцу
   string            m_left_arrow_file_on;
   string            m_left_arrow_file_off;
   string            m_right_arrow_file_on;
   string            m_right_arrow_file_off;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_area_zorder;
   int               m_button_zorder;
   int               m_zorder;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //---
public:
                     CCalendar(void);
                    ~CCalendar(void);
   //--- Методы для создания календаря
   bool              CreateCalendar(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateMonthDecArrow(void);
   bool              CreateMonthIncArrow(void);
   bool              CreateMonthsList(void);
   bool              CreateYearsSpinEdit(void);
   bool              CreateDaysWeek(void);
   bool              CreateSeparateLine(void);
   bool              CreateDaysMonth(void);
   bool              CreateButtonToday(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) получение указателя комбо-бокса, 
   //    (3) получение указателя списка, (4) получение указателя полосы прокрутки списка, 
   //    (5) получение указателя поля ввода, (6) получение указателя кнопки
   void              WindowPointer(CWindow &object)             { m_wnd=::GetPointer(object);            }
   CComboBox        *GetComboBoxPointer(void)                   { return(::GetPointer(m_months));        }
   CListView        *GetListViewPointer(void)                   { return(m_months.GetListViewPointer()); }
   CScrollV         *GetScrollVPointer(void)                    { return(m_months.GetScrollVPointer());  }
   CSpinEdit        *GetSpinEditPointer(void)                   { return(::GetPointer(m_years));         }
   CIconButton      *GetIconButtonPointer(void)                 { return(::GetPointer(m_button_today));  }
   //--- Установка цвета (1) фона, (2) рамки фона, (3) цвет разделительной линии
   void              AreaBackColor(const color clr)             { m_area_color=clr;                      }
   void              AreaBorderColor(const color clr)           { m_area_border_color=clr;               }
   void              SeparateLineColor(const color clr)         { m_sepline_color=clr;                   }
   //--- Цвета пунктов календаря (дней месяца) в разных состояниях
   void              ItemBackColor(const color clr)             { m_item_back_color=clr;                 }
   void              ItemBackColorOff(const color clr)          { m_item_back_color_off=clr;             }
   void              ItemBackColorHover(const color clr)        { m_item_back_color_hover=clr;           }
   void              ItemBackColorSelected(const color clr)     { m_item_back_color_selected=clr;        }
   //--- Цвета рамок пунктов календаря в разных состояниях
   void              ItemBorderColor(const color clr)           { m_item_border_color=clr;               }
   void              ItemBorderColorHover(const color clr)      { m_item_border_color_hover=clr;         }
   void              ItemBorderColorSelected(const color clr)   { m_item_border_color_selected=clr;      }
   //--- Цвета текста пунктов календаря в разных состояниях
   void              ItemTextColor(const color clr)             { m_item_text_color=clr;                 }
   void              ItemTextColorOff(const color clr)          { m_item_text_color_off=clr;             }
   void              ItemTextColorHover(const color clr)        { m_item_text_color_hover=clr;           }
   //--- Установка ярлыков кнопок (в активном/заблокированном состоянии) для перехода к предыдущему/следующему месяцу
   void              LeftArrowFileOn(const string file_path)    { m_left_arrow_file_on=file_path;        }
   void              LeftArrowFileOff(const string file_path)   { m_left_arrow_file_off=file_path;       }
   void              RightArrowFileOn(const string file_path)   { m_right_arrow_file_on=file_path;       }
   void              RightArrowFileOff(const string file_path)  { m_right_arrow_file_off=file_path;      }
   //--- (1) Установить (выделить) и (2) получить выделенную дату, (3) получить текущую дату в календаре
   void              SelectedDate(const datetime date);
   datetime          SelectedDate(void)                         { return(m_date.DateTime());             }
   datetime          Today(void)                                { return(m_today.DateTime());            }
   //--- Изменение цвета объектов
   void              ChangeObjectsColor(void);
   //--- Изменение цвета объектов в таблице календаря при наведении курсора
   void              ChangeObjectsColor(const int x,const int y);
   //--- Отображение последних изменений в календаре
   void              UpdateCalendar(void);
   //--- Обновление текущей даты
   void              UpdateCurrentDate(void);
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
   //--- Обработка нажатия на кнопке перехода к предыдущему месяцу
   bool              OnClickMonthDec(const string clicked_object);
   //--- Обработка нажатия на кнопке перехода к следующему месяцу
   bool              OnClickMonthInc(const string clicked_object);
   //--- Обработка выбора месяца в списке
   bool              OnClickMonthList(const long id);
   //--- Обработка ввода значения в поле ввода лет
   bool              OnEndEnterYear(const string edited_object);
   //--- Обработка нажатия на кнопке перехода к следующему году
   bool              OnClickYearInc(const long id);
   //--- Обработка нажатия на кнопке перехода к предыдущему году
   bool              OnClickYearDec(const long id);
   //--- Обработка нажатия на дне месяца
   bool              OnClickDayOfMonth(const string clicked_object);
   //--- Обработка нажатия на кнопке перехода к текущей дате
   bool              OnClickTodayButton(const long id);

   //--- Получение идентификатора из имени объекта
   int               IdFromObjectName(const string object_name);
   //--- Корректировка выделенного дня по количеству дней в месяце
   void              CorrectingSelectedDay(void);
   //--- Определение разницы от первого пункта таблицы календаря до пункта первого дня текущего месяца
   int               OffsetFirstDayOfMonth(void);
   //--- Отображает последние изменения в таблице календаря
   void              SetCalendar(void);
   //--- Ускоренная перемотка значений календаря
   void              FastSwitching(void);
   //--- Подсветка текущего дня и выбранного пользователем дня
   void              HighlightDate(void);
   //--- Сброс времени на начало суток
   void              ResetTime(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCalendar::CCalendar(void) : m_area_color(clrWhite),
                             m_area_border_color(clrSilver),
                             m_sepline_color(clrBlack),
                             m_item_back_color(clrWhite),
                             m_item_back_color_off(clrWhite),
                             m_item_back_color_hover(C'235,245,255'),
                             m_item_back_color_selected(C'193,218,255'),
                             m_item_border_color(clrWhite),
                             m_item_border_color_hover(C'160,220,255'),
                             m_item_border_color_selected(C'85,170,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_off(C'200,200,200'),
                             m_item_text_color_hover(C'0,102,204'),
                             m_left_arrow_file_on(""),
                             m_left_arrow_file_off(""),
                             m_right_arrow_file_on(""),
                             m_right_arrow_file_off("")
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder        =0;
   m_area_zorder   =1;
   m_button_zorder =2;
//--- Инициализация структур времени
   m_date.DateTime(::TimeLocal());
   m_today.DateTime(::TimeLocal());
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCalendar::~CCalendar(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CCalendar::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Выйти, если элемент не выпадающий и форма заблокирована
      if(!CElement::IsDropdown() && m_wnd.IsLocked())
         return;
      //--- Координаты и состояние левой кнопки мыши
      int x=(int)lparam;
      int y=(int)dparam;
      m_mouse_state=(bool)int(sparam);
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_month_dec.MouseFocus(x>m_month_dec.X() && x<m_month_dec.X2() && 
                             y>m_month_dec.Y() && y<m_month_dec.Y2());
      m_month_inc.MouseFocus(x>m_month_inc.X() && x<m_month_inc.X2() && 
                             y>m_month_inc.Y() && y<m_month_inc.Y2());
      //--- Выйти, если список месяцев активен
      if(m_months.GetListViewPointer().IsVisible())
         return;
      //--- Если список неактивен и левая кнопка мыши нажата...
      else if(m_mouse_state)
        {
         //--- ...активируем заблокированные ранее (в момент открытия списка) элементы,
         //       если один из них ещё не разблокирован
         if(!m_button_today.ButtonState())
           {
            m_years.SpinEditState(true);
            m_button_today.ButtonState(true);
           }
        }
      //--- Изменение цвета объектов
      ChangeObjectsColor(x,y);
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Выйти, если форма заблокирована и идентификаторы не совпадают
      if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
         return;
      //--- Выйти, если список месяцев активирован
      if(m_months.GetListViewPointer().IsVisible())
         return;
      //--- Активировать элементы (список и поле ввода), если левая кнопка мыши нажата 
      if(m_mouse_state)
        {
         m_years.SpinEditState(true);
         m_button_today.ButtonState(true);
        }
      //--- Обработка нажатия на кнопках переключения месяцев
      if(OnClickMonthDec(sparam))
         return;
      if(OnClickMonthInc(sparam))
         return;
      //--- Обработка нажатия на дне календаря
      if(OnClickDayOfMonth(sparam))
         return;
     }
//--- Обработка события нажатия на кнопке комбо-бокса
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_BUTTON)
     {
      //--- Выйти, если идентификаторы элементов не совпадают
      if(lparam!=CElement::Id())
         return;
      //--- Активировать или заблокировать элементы в зависимости от текущего состояния видимости списка
      m_years.SpinEditState(!m_months.GetListViewPointer().IsVisible());
      m_button_today.ButtonState(!m_months.GetListViewPointer().IsVisible());
     }
//--- Обработка события нажатия на пункте списка комбо-бокса
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      //--- Обработка выбора месяца в списке
      if(!OnClickMonthList(lparam))
         return;
      //---
      return;
     }
//--- Обработка события нажатия на кнопке инкремента
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC)
     {
      //--- Обработка нажатия на кнопке перехода к следующему году
      if(!OnClickYearInc(lparam))
         return;
      //---
      return;
     }
//--- Обработка события нажатия на кнопке декремента
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      //--- Обработка нажатия на кнопке перехода к предыдущему году
      if(!OnClickYearDec(lparam))
         return;
      //---
      return;
     }
//--- Обработка события ввода значения в поле ввода
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      //--- Обработка ввода значения в поле ввода лет
      if(OnEndEnterYear(sparam))
         return;
      //---
      return;
     }
//--- Обработка события нажатия на кнопке
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      //--- Обработка нажатия на кнопке перехода к текущей дате
      if(!OnClickTodayButton(lparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CCalendar::OnEventTimer(void)
  {
//--- Если элемент выпадающий и список скрыт
   if(CElement::IsDropdown() && !m_months.GetListViewPointer().IsVisible())
     {
      ChangeObjectsColor();
      FastSwitching();
     }
   else
     {
      //--- Отслеживаем изменение цвета и перемотку значений, 
      //    только если форма не заблокирована
      if(!m_wnd.IsLocked())
        {
         ChangeObjectsColor();
         FastSwitching();
        }
     }
//--- Обновление текущей даты календаря
   UpdateCurrentDate();
  }
//+------------------------------------------------------------------+
//| Создаёт контекстное меню                                         |
//+------------------------------------------------------------------+
bool CCalendar::CreateCalendar(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием календаря классу нужно передать "
              "указатель на форму: CCalendar::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
   m_x_size   =161;
   m_y_size   =158;
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание элемента
   if(!CreateArea())
      return(false);
   if(!CreateMonthDecArrow())
      return(false);
   if(!CreateMonthIncArrow())
      return(false);
   if(!CreateMonthsList())
      return(false);
   if(!CreateYearsSpinEdit())
      return(false);
   if(!CreateDaysWeek())
      return(false);
   if(!CreateSeparateLine())
      return(false);
   if(!CreateDaysMonth())
      return(false);
   if(!CreateButtonToday())
      return(false);
//--- Обновить календарь
   UpdateCalendar();
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт общую площадь календаря                                  |
//+------------------------------------------------------------------+
bool CCalendar::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_calendar_bg_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y();
//--- Отступы от крайней точки
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- Установим объект
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- Установка свойств
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт переключатель месяцев влево                              |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\LeftTransp_blue.bmp"
//---
bool CCalendar::CreateMonthDecArrow(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_calendar_left_arrow_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X();
   int y =CElement::Y()+5;
//--- Если не указали картинку для стрелки, значит установка по умолчанию
   if(m_left_arrow_file_on=="")
      m_left_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\LeftTransp_blue.bmp";
   if(m_left_arrow_file_off=="")
      m_left_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\LeftTransp_black.bmp";
//--- Установим объект
   if(!m_month_dec.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
   m_month_dec.BmpFileOn("::"+m_left_arrow_file_on);
   m_month_dec.BmpFileOff("::"+m_left_arrow_file_off);
   m_month_dec.Corner(m_corner);
   m_month_dec.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_month_dec.Selectable(false);
   m_month_dec.Z_Order(m_button_zorder);
   m_month_dec.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_month_dec.XSize(m_month_dec.X_Size());
   m_month_dec.YSize(m_month_dec.Y_Size());
//--- Сохраним координаты
   m_month_dec.X(x);
   m_month_dec.Y(y);
//--- Отступы от крайней точки
   m_month_dec.XGap(x-m_wnd.X());
   m_month_dec.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_month_dec);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт переключатель месяцев вправо                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_blue.bmp"
//---
bool CCalendar::CreateMonthIncArrow(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_calendar_right_arrow_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+CElement::XSize()-17;
   int y =CElement::Y()+5;
//--- Если не указали картинку для стрелки, значит установка по умолчанию
   if(m_right_arrow_file_on=="")
      m_right_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_blue.bmp";
   if(m_right_arrow_file_off=="")
      m_right_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp";
//--- Установим объект
   if(!m_month_inc.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установка свойств
   m_month_inc.BmpFileOn("::"+m_right_arrow_file_on);
   m_month_inc.BmpFileOff("::"+m_right_arrow_file_off);
   m_month_inc.Corner(m_corner);
   m_month_inc.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_month_inc.Selectable(false);
   m_month_inc.Z_Order(m_button_zorder);
   m_month_inc.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_month_inc.XSize(m_month_inc.X_Size());
   m_month_inc.YSize(m_month_inc.Y_Size());
//--- Сохраним координаты
   m_month_inc.X(x);
   m_month_inc.Y(y);
//--- Отступы от крайней точки
   m_month_inc.XGap(x-m_wnd.X());
   m_month_inc.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_month_inc);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт комбо-бокс с месяцами                                    |
//+------------------------------------------------------------------+
bool CCalendar::CreateMonthsList(void)
  {
//--- Сохраним указатель на окно
   m_months.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X()+17;
   int y=CElement::Y()+4;
//--- Установим свойства перед созданием
   m_months.XSize(75);
   m_months.YSize(19);
   m_months.LabelText("");
   m_months.ButtonXSize(75);
   m_months.ButtonYSize(19);
   m_months.AreaColor(m_area_color);
   m_months.ButtonBackColor(C'230,230,230');
   m_months.ButtonBackColorHover(C'193,218,255');
   m_months.ButtonBorderColor(C'200,200,200');
   m_months.ButtonBorderColorHover(C'85,170,255');
   m_months.ItemsTotal(12);
   m_months.VisibleItemsTotal(5);
   m_months.IsDropdown(CElement::IsDropdown());
//--- Получим указатель на список
   CListView *lv=m_months.GetListViewPointer();
//--- Установим свойства списка
   lv.LightsHover(true);
//--- Занесём значения в список (названия месяцев)
   for(int i=0; i<12; i++)
      m_months.ValueToList(i,m_date.MonthName(i+1));
//--- Выделим в списке текущий месяц
   m_months.SelectedItemByIndex(m_date.mon-1);
//--- Создадим элемент управления
   if(!m_months.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода года                                          |
//+------------------------------------------------------------------+
bool CCalendar::CreateYearsSpinEdit(void)
  {
//--- Сохраним указатель на окно
   m_years.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X()+96;
   int y=CElement::Y()+4;
//--- Установим свойства перед созданием
   m_years.XSize(50);
   m_years.YSize(18);
   m_years.EditXSize(35);
   m_years.EditYSize(19);
   m_years.MaxValue(2099);
   m_years.MinValue(1970);
   m_years.StepValue(1);
   m_years.SetDigits(0);
   m_years.SetValue(m_date.year);
   m_years.AreaColor(m_area_color);
   m_years.LabelColor(clrBlack);
   m_years.LabelColorLocked(clrBlack);
   m_years.EditColorLocked(clrWhite);
   m_years.EditTextColor(clrBlack);
   m_years.EditTextColorLocked(clrBlack);
   m_years.EditBorderColor(clrSilver);
   m_years.EditBorderColorLocked(clrSilver);
   m_years.IsDropdown(CElement::IsDropdown());
//--- Создадим элемент управления
   if(!m_years.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт названия дней недели                                     |
//+------------------------------------------------------------------+
bool CCalendar::CreateDaysWeek(void)
  {
//--- Координаты
   int x =CElement::X()+9;
   int y =CElement::Y()+26;
//--- Размеры
   int x_size =21;
   int y_size =16;
//--- Счётчик дней недели (для массива объектов)
   int w=0;
//--- Установим объекты отображающие сокращённые названия дней недели
   for(int i=1; i<7; i++,w++)
     {
      //--- Формирование имени объекта
      string name=CElement::ProgramName()+"_calendar_days_week_"+string(w)+"__"+(string)CElement::Id();
      //--- Расчёт координаты X
      x=(w>0)? x+x_size : x;
      //--- Установим объект
      if(!m_days_week[w].Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
         return(false);
      //--- Установка свойств
      m_days_week[w].Description(m_date.ShortDayName(i));
      m_days_week[w].TextAlign(ALIGN_CENTER);
      m_days_week[w].Font(FONT);
      m_days_week[w].FontSize(FONT_SIZE);
      m_days_week[w].Color(m_item_text_color);
      m_days_week[w].BorderColor(m_area_color);
      m_days_week[w].BackColor(m_area_color);
      m_days_week[w].Corner(m_corner);
      m_days_week[w].Anchor(m_anchor);
      m_days_week[w].Selectable(false);
      m_days_week[w].Z_Order(m_zorder);
      m_days_week[w].ReadOnly(true);
      m_days_week[w].Tooltip("\n");
      //--- Установим свойства перед созданием
      m_days_week[w].XSize(x_size);
      m_days_week[w].YSize(y_size);
      //--- Отступы от крайней точки панели
      m_days_week[w].XGap(x-m_wnd.X());
      m_days_week[w].YGap(y-m_wnd.Y());
      //--- Сохраним указатель объекта
      CElement::AddToArray(m_days_week[w]);
      //--- Если был сброс, выйти
      if(i==0)
         break;
      //--- Сброс, если прошли все дни недели
      if(i>=6)
         i=-1;
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт разделительную линию под названиями дней недели          |
//+------------------------------------------------------------------+
bool CCalendar::CreateSeparateLine(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_calendar_separate_line_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+7;
   int y =CElement::Y()+42;
//--- Размеры
   int x_size =147;
   int y_size =1;
//--- Создадим элемент интерфейса
   if(!m_sep_line.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Установка свойств
   m_sep_line.BorderType(BORDER_FLAT);
   m_sep_line.Color(clrLightGray);
//--- Отступы от крайней точки панели
   m_sep_line.XGap(x-m_wnd.X());
   m_sep_line.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_sep_line);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт таблицу дней месяца                                      |
//+------------------------------------------------------------------+
bool CCalendar::CreateDaysMonth(void)
  {
//--- Координаты
   int x =CElement::X()+9;
   int y =CElement::Y()+44;
//--- Размеры
   int x_size =21;
   int y_size =15;
//--- Счётчик дней
   int i=0;
//--- Установим объекты таблицы дней календаря
   for(int r=0; r<6; r++)
     {
      //--- Расчёт координаты Y
      y=(r>0)? y+y_size : y;
      //---
      for(int c=0; c<7; c++)
        {
         //--- Формирование имени объекта
         string name=CElement::ProgramName()+"_calendar_day_"+string(c)+"_"+string(r)+"__"+(string)CElement::Id();
         //--- Расчёт координаты X
         x=(c==0)? CElement::X()+9 : x+x_size;
         //--- Установим объект
         if(!m_days[i].Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
            return(false);
         //--- Установка свойств
         m_days[i].Description(string(i));
         m_days[i].TextAlign(ALIGN_RIGHT);
         m_days[i].Font(FONT);
         m_days[i].FontSize(8);
         m_days[i].Color(clrBlack);
         m_days[i].BorderColor(m_area_color);
         m_days[i].BackColor(m_area_color);
         m_days[i].Corner(m_corner);
         m_days[i].Anchor(m_anchor);
         m_days[i].Selectable(false);
         m_days[i].Z_Order(m_button_zorder);
         m_days[i].ReadOnly(true);
         m_days[i].Tooltip("\n");
         //--- Установим свойства перед созданием
         m_days[i].XSize(x_size);
         m_days[i].YSize(y_size);
         //--- Отступы от крайней точки панели
         m_days[i].XGap(x-m_wnd.X());
         m_days[i].YGap(y-m_wnd.Y());
         //--- Сохраним указатель объекта
         CElement::AddToArray(m_days[i]);
         i++;
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку для перехода на текущую дату                      |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\calendar_today.bmp"
//---
bool CCalendar::CreateButtonToday(void)
  {
//--- Сохраним указатель на окно
   m_button_today.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X()+20;
   int y=CElement::Y()+134;
//--- Установим свойства перед созданием
   m_button_today.TwoState(false);
   m_button_today.ButtonXSize(123);
   m_button_today.ButtonYSize(21);
   m_button_today.LabelXGap(30);
   m_button_today.LabelYGap(5);
   m_button_today.LabelColor(m_item_text_color);
   m_button_today.LabelColorOff(m_item_text_color);
   m_button_today.LabelColorHover(C'0,102,250');
   m_button_today.LabelColorPressed(C'0,102,250');
   m_button_today.BackColor(m_area_color);
   m_button_today.BackColorOff(m_area_color);
   m_button_today.BackColorHover(m_area_color);
   m_button_today.BackColorPressed(m_area_color);
   m_button_today.BorderColor(m_area_color);
   m_button_today.BorderColorOff(m_area_color);
   m_button_today.IconFileOn("Images\\EasyAndFastGUI\\Controls\\calendar_today.bmp");
   m_button_today.IconFileOff("Images\\EasyAndFastGUI\\Controls\\calendar_today.bmp");
   m_button_today.IsDropdown(CElement::IsDropdown());
//--- Создадим элемент управления
   if(!m_button_today.CreateIconButton(m_chart_id,m_subwin,"Today: "+::TimeToString(::TimeLocal(),TIME_DATE),x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Выбор новой даты                                                 |
//+------------------------------------------------------------------+
void CCalendar::SelectedDate(const datetime date)
  {
//--- Сохранение даты в структуре и поле класса
   m_date.DateTime(date);
//--- Отображение последних изменений в календаре
   UpdateCalendar();
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CCalendar::ChangeObjectsColor(void)
  {
   m_month_dec.State(m_month_dec.MouseFocus());
   m_month_inc.State(m_month_inc.MouseFocus());
  }
//+------------------------------------------------------------------+
//| Изменение цвета объектов в таблице календаря                     |
//| при наведении курсора                                            |
//+------------------------------------------------------------------+
void CCalendar::ChangeObjectsColor(const int x,const int y)
  {
//--- Определение разницы от первого пункта таблицы календаря до пункта первого дня текущего месяца
   OffsetFirstDayOfMonth();
//--- Пройдёмся в цикле по пунктам таблицы календаря
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- Если месяц пункта совпадает с текущим месяцем и 
      //    день пункта совпадает с выделенным днём
      if(m_temp_date.mon==m_date.mon &&
         m_temp_date.day==m_date.day)
        {
         //--- Перейти к следующему пункту таблицы
         m_temp_date.DayInc();
         continue;
        }
      //--- Если год/месяц/день пункта совпадает с годом/месяцем/днём текущей даты (сегодня)
      if(m_temp_date.year==m_today.year && 
         m_temp_date.mon==m_today.mon &&
         m_temp_date.day==m_today.day)
        {
         //--- Перейти к следующему пункту таблицы
         m_temp_date.DayInc();
         continue;
        }
      //--- Если курсор мыши находится над этим пунктом
      if(x>m_days[i].X() && x<m_days[i].X2() &&
         y>m_days[i].Y() && y<m_days[i].Y2())
        {
         m_days[i].BackColor(m_item_back_color_hover);
         m_days[i].BorderColor(m_item_border_color_hover);
         m_days[i].Color((m_temp_date.mon==m_date.mon)? m_item_text_color_hover : m_item_text_color_off);
        }
      else
        {
         m_days[i].BackColor(m_item_back_color);
         m_days[i].BorderColor(m_item_border_color);
         m_days[i].Color((m_temp_date.mon==m_date.mon)? m_item_text_color : m_item_text_color_off);
        }
      //--- Перейти к следующему пункту таблицы
      m_temp_date.DayInc();
     }
  }
//+------------------------------------------------------------------+
//| Отображение последних изменений в календаре                      |
//+------------------------------------------------------------------+
void CCalendar::UpdateCalendar(void)
  {
//--- Отобразить изменения в таблице календаря
   SetCalendar();
//--- Подсветка текущего дня и выбранного пользователем дня
   HighlightDate();
//--- Установим год в поле ввода
   m_years.ChangeValue(m_date.year);
//--- Установим месяц в списке комбо-бокса
   m_months.SelectedItemByIndex(m_date.mon-1);
  }
//+------------------------------------------------------------------+
//| Обновление текущей даты                                          |
//+------------------------------------------------------------------+
void CCalendar::UpdateCurrentDate(void)
  {
//--- Счётчик
   static int count=0;
//--- Выйти, если прошло меньше секунды
   if(count<1000)
     {
      count+=TIMER_STEP_MSC;
      return;
     }
//--- Обнулить счётчик
   count=0;
//--- Получим текущее (локальное) время
   MqlDateTime local_time;
   ::TimeToStruct(::TimeLocal(),local_time);
//--- Если наступил новый день
   if(local_time.day!=m_today.day)
     {
      //--- Обновить дату в календаре
      m_today.DateTime(::TimeLocal());
      m_button_today.Object(2).Description(::TimeToString(m_today.DateTime()));
      //--- Отобразить последние изменения в календаре
      UpdateCalendar();
      return;
     }
//--- Обновить дату в календаре
   m_today.DateTime(::TimeLocal());
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CCalendar::Moving(const int x,const int y)
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
   m_month_dec.X(x+m_month_dec.XGap());
   m_month_dec.Y(y+m_month_dec.YGap());
   m_month_inc.X(x+m_month_inc.XGap());
   m_month_inc.Y(y+m_month_inc.YGap());
   m_sep_line.X(x+m_sep_line.XGap());
   m_sep_line.Y(y+m_sep_line.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_month_dec.X_Distance(m_month_dec.X());
   m_month_dec.Y_Distance(m_month_dec.Y());
   m_month_inc.X_Distance(m_month_inc.X());
   m_month_inc.Y_Distance(m_month_inc.Y());
   m_sep_line.X_Distance(m_sep_line.X());
   m_sep_line.Y_Distance(m_sep_line.Y());
//--- Объекты названий дней недели
   for(int i=0; i<7; i++)
     {
      //--- Сохранение координат в полях объектов
      m_days_week[i].X(x+m_days_week[i].XGap());
      m_days_week[i].Y(y+m_days_week[i].YGap());
      //--- Обновление координат графических объектов
      m_days_week[i].X_Distance(m_days_week[i].X());
      m_days_week[i].Y_Distance(m_days_week[i].Y());
     }
//--- Объекты дней календаря
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- Сохранение координат в полях объектов
      m_days[i].X(x+m_days[i].XGap());
      m_days[i].Y(y+m_days[i].YGap());
      //--- Обновление координат графических объектов
      m_days[i].X_Distance(m_days[i].X());
      m_days[i].Y_Distance(m_days[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Показывает календарь                                             |
//+------------------------------------------------------------------+
void CCalendar::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Показать все элементы
   m_years.Show();
   m_months.Show();
   m_button_today.Show();
//--- Состояние видимости
   CElement::IsVisible(true);
//--- Если это выпадающий календарь, то послать команду для обнуления приоритетов на нажатие других элементов
   if(CElement::IsDropdown())
      ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,CElement::Id(),0.0,"");
  }
//+------------------------------------------------------------------+
//| Скрывает календарь                                               |
//+------------------------------------------------------------------+
void CCalendar::Hide(void)
  {
//--- Выйти, если элемент уже скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть все элементы
   m_years.Hide();
   m_months.Hide();
   m_button_today.Hide();
//---
   m_years.SpinEditState(true);
   m_button_today.ButtonState(true);
//--- Состояние видимости
   CElement::IsVisible(false);
//--- Послать команду для восстановления приоритетов на нажатие объектов
   ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CCalendar::Reset(void)
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
void CCalendar::Delete(void)
  {
//--- Удаление объектов календаря
   m_area.Delete();
   m_month_dec.Delete();
   m_month_inc.Delete();
//---
   for(int i=0; i<7; i++)
      m_days_week[i].Delete();
//---
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
      m_days[i].Delete();
//---
   m_sep_line.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CCalendar::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_month_dec.Z_Order(m_button_zorder);
   m_month_inc.Z_Order(m_button_zorder);
//---
   for(int i=0; i<7; i++)
      m_days_week[i].Z_Order(m_zorder);
//---
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
      m_days[i].Z_Order(m_button_zorder);
//---
   m_button_today.SetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CCalendar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_month_dec.Z_Order(0);
   m_month_inc.Z_Order(0);
//---
   for(int i=0; i<7; i++)
      m_days_week[i].Z_Order(0);
//---
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
      m_days[i].Z_Order(0);
//---
   m_button_today.ResetZorders();
  }
//+------------------------------------------------------------------+
//| Нажатие на стрелку влево. Переход к предыдущему месяцу.          |
//+------------------------------------------------------------------+
bool CCalendar::OnClickMonthDec(const string clicked_object)
  {
//--- Выйти, если чужое имя объекта
   if(::StringFind(clicked_object,m_month_dec.Name(),0)<0)
      return(false);
//--- Если текущий год в календаре равен минимальному указанному и
//    текущий месяц "Январь"
   if(m_date.year==m_years.MinValue() && m_date.mon==1)
     {
      //--- Подсветить значение и выйти
      m_years.HighlightLimit();
      return(true);
     }
//--- Установим состояние On
   m_month_dec.State(true);
//--- Перейти к предыдущему месяцу
   m_date.MonDec();
//--- Установить первое число месяца
   m_date.day=1;
//--- Установить время на начало суток
   ResetTime();
//--- Отображение последних изменений в календаре
   UpdateCalendar();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на стрелку влево. Переход к следующему месяцу.           |
//+------------------------------------------------------------------+
bool CCalendar::OnClickMonthInc(const string clicked_object)
  {
//--- Выйти, если чужое имя объекта
   if(::StringFind(clicked_object,m_month_inc.Name(),0)<0)
      return(false);
//--- Если текущий год в календаре равен максимальному указанному и
//    текущий месяц "Декабрь"
   if(m_date.year==m_years.MaxValue() && m_date.mon==12)
     {
      //--- Подсветить значение и выйти
      m_years.HighlightLimit();
      return(true);
     }
//--- Установим состояние On
   m_month_inc.State(true);
//--- Перейти к следующему месяцу
   m_date.MonInc();
//--- Установить первое число месяца
   m_date.day=1;
//--- Установить время на начало суток
   ResetTime();
//--- Отображение последних изменений в календаре
   UpdateCalendar();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка выбора месяца в списке                                 |
//+------------------------------------------------------------------+
bool CCalendar::OnClickMonthList(const long id)
  {
//--- Выйти, если идентификаторы элементов не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Разблокировать элементы
   m_years.SpinEditState(true);
   m_button_today.ButtonState(true);
//--- Получим выбранный месяц в списке
   int month=m_months.GetListViewPointer().SelectedItemIndex()+1;
   m_date.Mon(month);
//--- Корректировка выделенного дня по количеству дней в месяце
   CorrectingSelectedDay();
//--- Установить время на начало суток
   ResetTime();
//--- Отобразить изменения в таблице календаря
   UpdateCalendar();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка ввода значения в поле ввода лет                        |
//+------------------------------------------------------------------+
bool CCalendar::OnEndEnterYear(const string edited_object)
  {
//--- Выйдем, если чужое имя объекта
   if(::StringFind(edited_object,m_years.Object(2).Name(),0)<0)
      return(false);
//--- Выйдем, если значение не изменилось
   string value=m_years.Object(2).Description();
   if(m_date.year==(int)value)
      return(false);
//--- Скорректируем значение в случае выхода за установленные ограничения
   if((int)value<m_years.MinValue())
     {
      value=(string)int(m_years.MinValue());
      //--- Подсветить значение
      m_years.HighlightLimit();
     }
   if((int)value>m_years.MaxValue())
     {
      value=(string)int(m_years.MaxValue());
      //--- Подсветить значение
      m_years.HighlightLimit();
     }
//--- Определим количество дней в текущем месяце
   string year  =value;
   string month =string(m_date.mon);
   string day   =string(1);
   m_temp_date.DateTime(::StringToTime(year+"."+month+"."+day));
//--- Если значение выделенного дня больше, чем количество дней в месяце,
//    установить текущее количество дней в месяце в качестве выделенного дня
   if(m_date.day>m_temp_date.DaysInMonth())
      m_date.day=m_temp_date.DaysInMonth();
//--- Установим дату в структуру
   m_date.DateTime(::StringToTime(year+"."+month+"."+string(m_date.day)));
//--- Отобразим изменения в таблице календаря
   UpdateCalendar();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопке перехода к следующему году           |
//+------------------------------------------------------------------+
bool CCalendar::OnClickYearInc(const long id)
  {
//--- Если список месяцев открыт, закроем его
   if(m_months.GetListViewPointer().IsVisible())
      m_months.ChangeComboBoxListState();
//--- Выйти, если идентификаторы элементов не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Если год меньше максимального указанного, увеличить значение на один
   if(m_date.year<m_years.MaxValue())
      m_date.YearInc();
//--- Корректировка выделенного дня по количеству дней в месяце
   CorrectingSelectedDay();
//--- Отобразить изменения в таблице календаря
   UpdateCalendar();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопке перехода к предыдущему году          |
//+------------------------------------------------------------------+
bool CCalendar::OnClickYearDec(const long id)
  {
//--- Если список месяцев открыт, закроем его
   if(m_months.GetListViewPointer().IsVisible())
      m_months.ChangeComboBoxListState();
//--- Выйти, если идентификаторы элементов не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Если год больше минимального указанного, уменьшить значение на один
   if(m_date.year>m_years.MinValue())
      m_date.YearDec();
//--- Корректировка выделенного дня по количеству дней в месяце  
   CorrectingSelectedDay();
//--- Отобразить изменения в таблице календаря
   UpdateCalendar();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на дне месяца календаря                        |
//+------------------------------------------------------------------+
bool CCalendar::OnClickDayOfMonth(const string clicked_object)
  {
//--- Выйдем, если нажатие было не на дне календаря
   if(::StringFind(clicked_object,CElement::ProgramName()+"_calendar_day_",0)<0)
      return(false);
//--- Получим идентификатор и индекс из имени объекта
   int id=IdFromObjectName(clicked_object);
//--- Выйти, если идентификатор не совпадает
   if(id!=CElement::Id())
      return(false);
//--- Определение разницы от первого пункта таблицы календаря до пункта первого дня текущего месяца
   OffsetFirstDayOfMonth();
//--- Пройдёмся в цикле по пунктам таблицы календаря
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- Если дата текущего пункта меньше, чем установленный в системе минимум
      if(m_temp_date.DateTime()<datetime(D'01.01.1970'))
        {
         //--- Если это объект, на который нажали
         if(m_days[i].Name()==clicked_object)
           {
            //--- Подсветить значение и выйти
            m_years.HighlightLimit();
            return(false);
           }
         //--- Перейти к следующей дате
         m_temp_date.DayInc();
         continue;
        }
      //--- Если это объект, на который нажали
      if(m_days[i].Name()==clicked_object)
        {
         //--- Сохраним дату
         m_date.DateTime(m_temp_date.DateTime());
         //--- Отображение последних изменений в календаре
         UpdateCalendar();
         break;
        }
      //--- Перейти к следующей дате
      m_temp_date.DayInc();
      //--- Проверка выхода за установленный в системе максимум
      if(m_temp_date.year>m_years.MaxValue())
        {
         //--- Подсветить значение и выйти
         m_years.HighlightLimit();
         return(false);
        }
     }
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопке перехода к текущей дате              |
//+------------------------------------------------------------------+
bool CCalendar::OnClickTodayButton(const long id)
  {
//--- Если список месяцев открыт, закроем его
   if(m_months.GetListViewPointer().IsVisible())
      m_months.ChangeComboBoxListState();
//--- Выйти, если идентификаторы элементов не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Установить текущую дату
   m_date.DateTime(::TimeLocal());
//--- Отображение последних изменений в календаре
   UpdateCalendar();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CCalendar::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
//| Определение первого дня месяца                                   |
//+------------------------------------------------------------------+
void CCalendar::CorrectingSelectedDay(void)
  {
//--- Установить текущее количество дней в месяце, если значение выделенного дня больше
   if(m_date.day>m_date.DaysInMonth())
      m_date.day=m_date.DaysInMonth();
  }
//+------------------------------------------------------------------+
//| Определение разницы от первого пункта таблицы календаря          |
//| до пункта первого дня текущего месяца                            |
//+------------------------------------------------------------------+
int CCalendar::OffsetFirstDayOfMonth(void)
  {
//--- Получим дату первого дня выделенного года и месяца в виде строки
   string date=string(m_date.year)+"."+string(m_date.mon)+"."+string(1);
//--- Установим эту дату в структуру для расчётов
   m_temp_date.DateTime(::StringToTime(date));
//--- Если результат вычитания единицы от текущего номера дня недели больше либо равен нулю,
//    вернуть результат, иначе вернуть значение 6
   int diff=(m_temp_date.day_of_week-1>=0) ? m_temp_date.day_of_week-1 : 6;
//--- Запомним дату, которая приходится на первый пункт таблицы
   m_temp_date.DayDec(diff);
   return(diff);
  }
//+------------------------------------------------------------------+
//| Установка значений календаря                                     |
//+------------------------------------------------------------------+
void CCalendar::SetCalendar(void)
  {
//--- Определение разницы от первого пункта таблицы календаря до пункта первого дня текущего месяца
   int diff=OffsetFirstDayOfMonth();
//--- Пройдёмся в цикле по всем пунктам таблицы календаря
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- Установка дня в текущий пункт таблицы
      m_days[i].Description(string(m_temp_date.day));
      //--- Перейти к следующей дате
      m_temp_date.DayInc();
     }
  }
//+------------------------------------------------------------------+
//| Ускоренная промотка календаря                                    |
//+------------------------------------------------------------------+
void CCalendar::FastSwitching(void)
  {
//--- Выйдем, если нет фокуса на элементе
   if(!CElement::MouseFocus())
      return;
//--- Выйти, если форма заблокирована и идентификаторы не совпадают
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- Вернём счётчик к первоначальному значению, если кнопка мыши отжата
   if(!m_mouse_state)
      m_timer_counter=SPIN_DELAY_MSC;
//--- Если же кнопка мыши нажата
   else
     {
      //--- Увеличим счётчик на установленный интервал
      m_timer_counter+=TIMER_STEP_MSC;
      //--- Выйдем, если меньше нуля
      if(m_timer_counter<0)
         return;
      //--- Если левая стрелка нажата
      if(m_month_dec.State())
        {
         //--- Если текущий год в календаре больше/равен минимального указанного
         if(m_date.year>=m_years.MinValue())
           {
            //--- Если текущий год в календаре уже равен минимальному указанному и
            //    текущий месяц "Январь"
            if(m_date.year==m_years.MinValue() && m_date.mon==1)
              {
               //--- Подсветить значение и выйти
               m_years.HighlightLimit();
               return;
              }
            //--- Перейти к следующему месяцу (в сторону уменьшения)
            m_date.MonDec();
            //--- Установить первое число месяца
            m_date.day=1;
           }
        }
      //--- Если правая стрелка нажата
      else if(m_month_inc.State())
        {
         //--- Если текущий в календаре год меньше/равен максимального указанного
         if(m_date.year<=m_years.MaxValue())
           {
            //--- Если текущий год в календаре уже равен максимальному указанному и
            //    текущий месяц "Декабрь"
            if(m_date.year==m_years.MaxValue() && m_date.mon==12)
              {
               //--- Подсветить значение и выйти
               m_years.HighlightLimit();
               return;
              }
            //--- Перейти к следующему месяцу (в сторону увеличения)
            m_date.MonInc();
            //--- Установить первое число месяца
            m_date.day=1;
           }
        }
      //--- Если кнопка инкремента поля ввода лет нажата
      else if(m_years.StateInc())
        {
         //--- Если меньше максимального указанного года,
         //    перейти к следующему году (в сторону увеличения)
         if(m_date.year<m_years.MaxValue())
            m_date.YearInc();
         else
           {
            //--- Подсветить значение и выйти
            m_years.HighlightLimit();
            return;
           }
        }
      //--- Если кнопка декремента поля ввода лет нажата
      else if(m_years.StateDec())
        {
         //--- Если больше минимального указанного года,
         //    перейти к следующему году (в сторону уменьшения)
         if(m_date.year>m_years.MinValue())
            m_date.YearDec();
         else
           {
            //--- Подсветить значение и выйти
            m_years.HighlightLimit();
            return;
           }
        }
      else
         return;
      //--- Отображение последних изменений в календаре
      UpdateCalendar();
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_CHANGE_DATE,CElement::Id(),m_date.DateTime(),"");
     }
  }
//+------------------------------------------------------------------+
//| Подсветка текущего дня и выбранного пользователем дня            |
//+------------------------------------------------------------------+
void CCalendar::HighlightDate(void)
  {
//--- Определение разницы от первого пункта таблицы календаря до пункта первого дня текущего месяца
   OffsetFirstDayOfMonth();
//--- Пройдёмся в цикле по пунктам таблицы календаря
   int items_total=::ArraySize(m_days);
   for(int i=0; i<items_total; i++)
     {
      //--- Если месяц пункта совпадает с текущим месяцем и 
      //    день пункта совпадает с выделенным днём
      if(m_temp_date.mon==m_date.mon &&
         m_temp_date.day==m_date.day)
        {
         m_days[i].Color(m_item_text_color);
         m_days[i].BackColor(m_item_back_color_selected);
         m_days[i].BorderColor(m_item_border_color_selected);
         //--- Перейти к следующему пункту таблицы
         m_temp_date.DayInc();
         continue;
        }
      //--- Если это текущая дата (сегодня)
      if(m_temp_date.year==m_today.year && 
         m_temp_date.mon==m_today.mon &&
         m_temp_date.day==m_today.day)
        {
         m_days[i].BackColor(m_item_back_color);
         m_days[i].BorderColor(m_item_text_color_hover);
         m_days[i].Color(m_item_text_color_hover);
         //--- Перейти к следующему пункту таблицы
         m_temp_date.DayInc();
         continue;
        }
      //---
      m_days[i].BackColor(m_item_back_color);
      m_days[i].BorderColor(m_item_border_color);
      m_days[i].Color((m_temp_date.mon==m_date.mon)? m_item_text_color : m_item_text_color_off);
      //--- Перейти к следующему пункту таблицы
      m_temp_date.DayInc();
     }
  }
//+------------------------------------------------------------------+
//| Сброс времени на начало суток                                    |
//+------------------------------------------------------------------+
void CCalendar::ResetTime(void)
  {
   m_date.hour =0;
   m_date.min  =0;
   m_date.sec  =0;
  }
//+------------------------------------------------------------------+
