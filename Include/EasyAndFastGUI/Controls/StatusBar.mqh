//+------------------------------------------------------------------+
//|                                                    StatusBar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| Класс для создания статусной строки                              |
//+------------------------------------------------------------------+
class CStatusBar : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания кнопки
   CRectLabel        m_area;
   CEdit             m_items[];
   CSeparateLine     m_sep_line[];
   //--- Свойства:
   //    Массивы для уникальных свойств
   int               m_width[];
   //--- (1) Цвет фона и (2) рамки фона
   color             m_area_color;
   color             m_area_border_color;
   //--- Цвет текста
   color             m_label_color;
   //--- Приоритет на нажатие левой кнопки мыши
   int               m_zorder;
   //--- Цвета для разделительных линий
   color             m_sepline_dark_color;
   color             m_sepline_light_color;
   //---
public:
                     CStatusBar(void);
                    ~CStatusBar(void);
   //--- Методы для создания статусной строки
   bool              CreateStatusBar(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   bool              CreateSeparateLine(const int line_number,const int x,const int y);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) количество пунктов
   void              WindowPointer(CWindow &object)                   { m_wnd=::GetPointer(object);   }
   int               ItemsTotal(void)                           const { return(::ArraySize(m_items)); }
   //--- Цвет (1) фона, (2) рамки фона и (3) текста
   void              AreaColor(const color clr)                       { m_area_color=clr;             }
   void              AreaBorderColor(const color clr)                 { m_area_border_color=clr;      }
   void              LabelColor(const color clr)                      { m_label_color=clr;            }
   //--- Цвета разделительных линий
   void              SeparateLineDarkColor(const color clr)           { m_sepline_dark_color=clr;     }
   void              SeparateLineLightColor(const color clr)          { m_sepline_light_color=clr;    }

   //--- Добавляет пункт с указанными свойствами до создания статусной строки
   void              AddItem(const int width);
   //--- Установка значения по указанному индексу
   void              ValueToItem(const int index,const string value);
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
CStatusBar::CStatusBar(void) : m_area_color(C'240,240,240'),
                               m_area_border_color(clrSilver),
                               m_label_color(clrBlack),
                               m_sepline_dark_color(C'160,160,160'),
                               m_sepline_light_color(clrWhite)
  {
//--- Сохраним имя класса элемента в базовом классе  
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder=2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CStatusBar::~CStatusBar(void)
  {
  }
//+------------------------------------------------------------------+
//| Создаёт статусную строку                                         |
//+------------------------------------------------------------------+
bool CStatusBar::CreateStatusBar(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием статусной строки классу нужно передать "
              "указатель на форму: CStatusBar::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создаёт статусную строку
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- Скрыть элемент, если окно минимизировано
   if(m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт общую площадь                                            |
//+------------------------------------------------------------------+
bool CStatusBar::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_statusbar_bg_"+(string)CElement::Id();
//--- Координаты и ширина фона
   int x=m_x;
   int y=m_y;
   m_x_size=(m_x_size<1)? m_wnd.XSize()-2 : m_x_size;
//--- Установим фон статусной строки
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт список пунктов статусной строки                          |
//+------------------------------------------------------------------+
bool CStatusBar::CreateItems(void)
  {
   int l_w=0;
   int l_x=m_x+1;
   int l_y=m_y+1;
//--- Получим количество пунктов
   int items_total=ItemsTotal();
//--- Если нет ни одного пункта в группе, сообщить об этом и выйти
   if(items_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы один пункт! Воспользуйтесь методом CStatusBar::AddItem()");
      return(false);
     }
//--- Если ширина первого пункта не задана, то...
   if(m_width[0]<1)
     {
      //--- ...рассчитаем её относительно общей ширины других пунктов
      for(int i=1; i<items_total; i++)
         l_w+=m_width[i];
      //---
      m_width[0]=m_wnd.XSize()-l_w-(items_total+2);
     }
//--- Создадим указанное количество пунктов
   for(int i=0; i<items_total; i++)
     {
      //--- Формирование имени объекта
      string name=CElement::ProgramName()+"_statusbar_edit_"+string(i)+"__"+(string)CElement::Id();
      //--- Координата X
      l_x=(i>0)? l_x+m_width[i-1]: l_x;
      //--- Создание объекта
      if(!m_items[i].Create(m_chart_id,name,m_subwin,l_x,l_y,m_width[i],m_y_size-2))
         return(false);
      //--- Установка свойств
      m_items[i].Description("");
      m_items[i].TextAlign(ALIGN_LEFT);
      m_items[i].Font(FONT);
      m_items[i].FontSize(FONT_SIZE);
      m_items[i].Color(m_label_color);
      m_items[i].BorderColor(m_area_color);
      m_items[i].BackColor(m_area_color);
      m_items[i].Corner(m_corner);
      m_items[i].Anchor(m_anchor);
      m_items[i].Selectable(false);
      m_items[i].Z_Order(m_zorder);
      m_items[i].ReadOnly(true);
      m_items[i].Tooltip("\n");
      //--- Отступы от крайней точки панели
      m_items[i].XGap(l_x-m_wnd.X());
      m_items[i].YGap(l_y-m_wnd.Y());
      //--- Координаты
      m_items[i].X(l_x);
      m_items[i].Y(l_y);
      //--- Размеры
      m_items[i].XSize(m_width[i]);
      m_items[i].YSize(m_y_size-2);
      //--- Сохраним указатель объекта
      CElement::AddToArray(m_items[i]);
     }
//--- Создание разделительных линий
   for(int i=1; i<items_total; i++)
     {
      //--- Координата X
      l_x=m_items[i].X();
      //--- Создание линии
      CreateSeparateLine(i,l_x,l_y+2);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт разделительную линию                                     |
//+------------------------------------------------------------------+
bool CStatusBar::CreateSeparateLine(const int line_number,const int x,const int y)
  {
//--- Линии устанавливаются со второго (1) пункта
   if(line_number<1)
      return(false);
//--- Корректировка индекса
   int i=line_number-1;
//--- Увеличение массива линий на один элемент
   int array_size=::ArraySize(m_sep_line);
   ::ArrayResize(m_sep_line,array_size+1);
//--- Сохраним указатель на окно
   m_sep_line[i].WindowPointer(m_wnd);
//--- Установка свойств
   m_sep_line[i].TypeSepLine(V_SEP_LINE);
   m_sep_line[i].DarkColor(m_sepline_dark_color);
   m_sep_line[i].LightColor(m_sepline_light_color);
//--- Создание линии
   if(!m_sep_line[i].CreateSeparateLine(m_chart_id,m_subwin,line_number,x,y,2,m_y_size-6))
      return(false);
//--- Отступы от крайней точки панели
   m_sep_line[i].XGap(x-m_wnd.X());
   m_sep_line[i].YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_sep_line[i].Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет пункт меню                                             |
//+------------------------------------------------------------------+
void CStatusBar::AddItem(const int width)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_width,array_size+1);
//--- Сохраним значения переданных параметров
   m_width[array_size]=width;
  }
//+------------------------------------------------------------------+
//| Устанавливает значение по указанному индексу                     |
//+------------------------------------------------------------------+
void CStatusBar::ValueToItem(const int index,const string value)
  {
//--- Проверка на выход из диапазона
   int array_size=::ArraySize(m_items);
   if(array_size<1 || index<0 || index>=array_size)
      return;
//--- Установка переданного текста
   m_items[index].Description(value);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CStatusBar::Moving(const int x,const int y)
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
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Сохранение координат в полях объектов
      m_items[i].X(x+m_items[i].XGap());
      m_items[i].Y(y+m_items[i].YGap());
      //--- Обновление координат графических объектов
      m_items[i].X_Distance(m_items[i].X());
      m_items[i].Y_Distance(m_items[i].Y());
     }
//--- Перемещение разделительных линий
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CStatusBar::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Показать разделительные линии
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Show();
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CStatusBar::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть разделительные линии
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CStatusBar::Reset(void)
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
void CStatusBar::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
//--- Освобождение массивов элемента
   ::ArrayFree(m_items);
   ::ArrayFree(m_sep_line);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CStatusBar::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CStatusBar::ResetZorders(void)
  {
   m_area.Z_Order(0);
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
