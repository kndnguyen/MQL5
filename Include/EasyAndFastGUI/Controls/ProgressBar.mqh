//+------------------------------------------------------------------+
//|                                                  ProgressBar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания индикатора выполнения                         |
//+------------------------------------------------------------------+
class CProgressBar : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания элемента
   CRectLabel        m_area;
   CLabel            m_label;
   CRectLabel        m_bar_bg;
   CRectLabel        m_indicator;
   CLabel            m_percent;
   //--- Цвет фона элемента
   color             m_area_color;
   //--- Описание отображаемого процесса
   string            m_label_text;
   //--- Цвет текста
   color             m_label_color;
   //--- Смещение текстовой метки по двум осям
   int               m_label_x_offset;
   int               m_label_y_offset;
   //--- Цвета фона прогресс-бара и рамки фона
   color             m_bar_area_color;
   color             m_bar_border_color;
   //--- Размеры прогресс-бара
   int               m_bar_x_size;
   int               m_bar_y_size;
   //--- Смещение прогресс-бара по двум осям
   int               m_bar_x_offset;
   int               m_bar_y_offset;
   //--- Толщина рамки прогресс-бара
   int               m_bar_border_width;
   //--- Цвет индикатора
   color             m_indicator_color;
   //--- Смещение метки показателя процентов
   int               m_percent_x_offset;
   int               m_percent_y_offset;
   //--- Количество знаков после запятой
   int               m_digits;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_zorder;
   //--- Количество шагов диапазона
   double            m_steps_total;
   //--- Текущая позиция индикатора
   double            m_current_index;
   //---
public:
                     CProgressBar(void);
                    ~CProgressBar(void);
   //--- Методы для создания элемента
   bool              CreateProgressBar(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateBarArea(void);
   bool              CreateIndicator(void);
   bool              CreatePercent(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) количество знаков после запятой
   void              WindowPointer(CWindow &object)     { m_wnd=::GetPointer(object);      }
   void              SetDigits(const int digits)        { m_digits=::fabs(digits);         }
   //--- (1) Цвет фона, (2) название процесса и (3) цвет текста
   void              AreaColor(const color clr)         { m_area_color=clr;                }
   void              LabelText(const string text)       { m_label_text=text;               }
   void              LabelColor(const color clr)        { m_label_color=clr;               }
   //--- Смещение текстовой метки (название процесса)
   void              LabelXOffset(const int x_offset)   { m_label_x_offset=x_offset;       }
   void              LabelYOffset(const int y_offset)   { m_label_y_offset=y_offset;       }
   //--- Цвет (1) фона и (2) рамки прогресс-бара, (3) цвет индикатора
   void              BarAreaColor(const color clr)      { m_bar_area_color=clr;            }
   void              BarBorderColor(const color clr)    { m_bar_border_color=clr;          }
   void              IndicatorColor(const color clr)    { m_indicator_color=clr;           }
   //--- (1) Толщина рамки, (2) размеры области индикатора
   void              BarBorderWidth(const int width)    { m_bar_border_width=width;        }
   void              BarXSize(const int x_size)         { m_bar_x_size=x_size;             }
   void              BarYSize(const int y_size)         { m_bar_y_size=y_size;             }
   //--- (1) Смещение прогресс бара по двум осям, (2) смещение метки показателя процентов
   void              BarXOffset(const int x_offset)     { m_bar_x_offset=x_offset;         }
   void              BarYOffset(const int y_offset)     { m_bar_y_offset=y_offset;         }
   //--- Смещение текстовой метки (процента процесса)
   void              PercentXOffset(const int x_offset) { m_percent_x_offset=x_offset;     }
   void              PercentYOffset(const int y_offset) { m_percent_y_offset=y_offset;     }
   
   //--- Обновление индикатора по указанным значениям
   void              Update(const int index,const int total);
   //---
private:
   //--- Установка новых значений для индикатора
   void              CurrentIndex(const int index);
   void              StepsTotal(const int total);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- Таймер
   virtual void      OnEventTimer(void) {}
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
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgressBar::CProgressBar(void) : m_digits(0),
                                   m_steps_total(1),
                                   m_current_index(0),
                                   m_area_color(clrWhiteSmoke),
                                   m_label_x_offset(0),
                                   m_label_y_offset(1),
                                   m_bar_x_offset(0),
                                   m_bar_y_offset(0),
                                   m_bar_border_width(0),
                                   m_percent_x_offset(7),
                                   m_percent_y_offset(1),
                                   m_label_text("Progress:"),
                                   m_label_color(clrBlack),
                                   m_bar_area_color(C'225,225,225'),
                                   m_bar_border_color(C'225,225,225'),
                                   m_indicator_color(clrMediumSeaGreen)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder=0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CProgressBar::~CProgressBar(void)
  {
  }
//+------------------------------------------------------------------+
//| Создаёт элемент "Индикатор прогресса"                            |
//+------------------------------------------------------------------+
bool CProgressBar::CreateProgressBar(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием индикатора выполнения классу нужно передать "
              "указатель на форму: CProgressBar::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание объектов элемента
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateBarArea())
      return(false);
   if(!CreateIndicator())
      return(false);
   if(!CreatePercent())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт общий фон элемента                                       |
//+------------------------------------------------------------------+
bool CProgressBar::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_progress_area_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y();
//--- Установим объект
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- Координаты
   m_area.X(x);
   m_area.Y(y);
//--- Координаты
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- Отступы от крайней точки
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт метку с названием процесса                               |
//+------------------------------------------------------------------+
bool CProgressBar::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_progress_lable_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+m_label_x_offset;
   int y=CElement::Y()+m_label_y_offset;
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
   m_label.Tooltip("\n");
//--- Координаты
   m_label.X(x);
   m_label.Y(y);
//--- Отступы от крайней точки
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон прогресс бара                                        |
//+------------------------------------------------------------------+
bool CProgressBar::CreateBarArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_progress_bar_area_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+m_bar_x_offset;
   int y=CElement::Y()+m_bar_y_offset;
//--- Установим объект
   if(!m_bar_bg.Create(m_chart_id,name,m_subwin,x,y,m_bar_x_size,m_bar_y_size))
      return(false);
//--- Установим свойства
   m_bar_bg.BackColor(m_bar_area_color);
   m_bar_bg.Color(m_bar_border_color);
   m_bar_bg.BorderType(BORDER_FLAT);
   m_bar_bg.Corner(m_corner);
   m_bar_bg.Selectable(false);
   m_bar_bg.Z_Order(m_zorder);
   m_bar_bg.Tooltip("\n");
//--- Координаты
   m_bar_bg.X(x);
   m_bar_bg.Y(y);
//--- Координаты
   m_bar_bg.XSize(m_bar_x_size);
   m_bar_bg.YSize(m_bar_y_size);
//--- Отступы от крайней точки
   m_bar_bg.XGap(x-m_wnd.X());
   m_bar_bg.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_bar_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт индикатор прогресса                                      |
//+------------------------------------------------------------------+
bool CProgressBar::CreateIndicator(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_progress_bar_indicator_"+(string)CElement::Id();
//--- Координаты
   int x=m_bar_bg.X()+m_bar_border_width;
   int y=m_bar_bg.Y()+m_bar_border_width;
//--- Размеры
   int x_size=1;
   int y_size=m_bar_bg.YSize()-(m_bar_border_width*2);
//--- Установим объект
   if(!m_indicator.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Установим свойства
   m_indicator.BackColor(m_indicator_color);
   m_indicator.Color(m_indicator_color);
   m_indicator.BorderType(BORDER_FLAT);
   m_indicator.Corner(m_corner);
   m_indicator.Selectable(false);
   m_indicator.Z_Order(m_zorder);
   m_indicator.Tooltip("\n");
//--- Координаты
   m_indicator.X(x);
   m_indicator.Y(y);
//--- Координаты
   m_indicator.XSize(x_size);
   m_indicator.YSize(y_size);
//--- Отступы от крайней точки
   m_indicator.XGap(x-m_wnd.X());
   m_indicator.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_indicator);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт метку с показателем процентов прогресса                  |
//+------------------------------------------------------------------+
bool CProgressBar::CreatePercent(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_progress_percent_"+(string)CElement::Id();
//--- Координаты
   int x=m_bar_bg.X2()+m_percent_x_offset;
   int y=CElement::Y()+m_percent_y_offset;
//--- Установим объект
   if(!m_percent.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_percent.Description("0%");
   m_percent.Font(FONT);
   m_percent.FontSize(FONT_SIZE);
   m_percent.Color(m_label_color);
   m_percent.Corner(m_corner);
   m_percent.Anchor(m_anchor);
   m_percent.Selectable(false);
   m_percent.Z_Order(m_zorder);
   m_percent.Tooltip("\n");
//--- Отступы от крайней точки
   m_percent.XGap(x-m_wnd.X());
   m_percent.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_percent);
   return(true);
  }
//+------------------------------------------------------------------+
//| Количество шагов прогресс бара                                   |
//+------------------------------------------------------------------+
void CProgressBar::StepsTotal(const int total)
  {
//--- Скорректировать, если меньше 0
   m_steps_total=(total<1)? 1 : total;
//--- Скорректировать индекс, если выход из диапазона
   if(m_current_index>m_steps_total)
      m_current_index=m_steps_total;
  }
//+------------------------------------------------------------------+
//| Текущая позиция индикатора                                       |
//+------------------------------------------------------------------+
void CProgressBar::CurrentIndex(const int index)
  {
//--- Скорректировать, если меньше 0
   if(index<0)
      m_current_index=1;
//--- Скорректировать индекс, если выход из диапазона
   else
      m_current_index=(index>m_steps_total)? m_steps_total : index;
  }
//+------------------------------------------------------------------+
//| Обновляет прогресс бар                                           |
//+------------------------------------------------------------------+
void CProgressBar::Update(const int index,const int total)
  {
//--- Установить новый индекс
   CurrentIndex(index);
//--- Установить новый диапазон
   StepsTotal(total);
//--- Рассчитаем ширину индикатора
   double new_width=(m_current_index/m_steps_total)*m_bar_bg.XSize();
//--- Скорректировать, если меньше 1
   if((int)new_width<1)
      new_width=1;
   else
     {
      //--- Скорректировать с учётом ширины рамки
      int x_size=m_bar_bg.XSize()-(m_bar_border_width*2);
      //--- Скорректировать, если выход за границу
      if((int)new_width>=x_size)
         new_width=x_size;
     }
//--- Установим индикатору новую ширину
   m_indicator.X_Size((int)new_width);
//--- Рассчитаем процент и сформируем строку
   double percent =m_current_index/m_steps_total*100;
   string desc    =::DoubleToString((percent>100)? 100 : percent,m_digits)+"%";
//--- Установим новое значение
   m_percent.Description(desc);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CProgressBar::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение отступов в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_area.X(x+m_label.XGap());
   m_area.Y(y+m_label.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_bar_bg.X(x+m_bar_bg.XGap());
   m_bar_bg.Y(y+m_bar_bg.YGap());
   m_indicator.X(x+m_indicator.XGap());
   m_indicator.Y(y+m_indicator.YGap());
   m_percent.X(x+m_percent.XGap());
   m_percent.Y(y+m_percent.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_label.X());
   m_area.Y_Distance(m_label.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_bar_bg.X_Distance(m_bar_bg.X());
   m_bar_bg.Y_Distance(m_bar_bg.Y());
   m_indicator.X_Distance(m_indicator.X());
   m_indicator.Y_Distance(m_indicator.Y());
   m_percent.X_Distance(m_percent.X());
   m_percent.Y_Distance(m_percent.Y());
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CProgressBar::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
//--- Обновить местоположение элемента на форме
   Moving(m_wnd.X(),m_wnd.Y());
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CProgressBar::Hide(void)
  {
//--- Выйти, если элемент уже скрыт
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
void CProgressBar::Reset(void)
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
void CProgressBar::Delete(void)
  {
   m_area.Delete();
   m_label.Delete();
   m_bar_bg.Delete();
   m_indicator.Delete();
   m_percent.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CProgressBar::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_bar_bg.Z_Order(m_zorder);
   m_indicator.Z_Order(m_zorder);
   m_percent.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CProgressBar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_bar_bg.Z_Order(0);
   m_indicator.Z_Order(0);
   m_percent.Z_Order(0);
  }
//+------------------------------------------------------------------+
