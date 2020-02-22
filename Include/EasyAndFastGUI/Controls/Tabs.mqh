//+------------------------------------------------------------------+
//|                                                         Tabs.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания вкладок                                       |
//+------------------------------------------------------------------+
class CTabs : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания элемента
   CRectLabel        m_main_area;
   CRectLabel        m_tabs_area;
   CEdit             m_tabs[];
   //--- Структура свойств и массивов элементов закреплённых за каждой вкладкой
   struct TElements
     {
      CElement         *elements[];
      string            text;
      int               width;
     };
   TElements         m_tab[];
   //--- Количество вкладок
   int               m_tabs_total;
   //--- Позиционирование вкладок
   ENUM_TABS_POSITION m_position_mode;
   //--- Цвет фона общей области
   int               m_area_color;
   //--- Размер вкладок оси Y
   int               m_tab_y_size;
   //--- Цвета вкладок в разных состояниях
   color             m_tab_color;
   color             m_tab_color_hover;
   color             m_tab_color_selected;
   color             m_tab_color_array[];
   //--- Цвет текста вкладок в разных состояних
   color             m_tab_text_color;
   color             m_tab_text_color_selected;
   //--- Цвет рамок вкладок
   color             m_tab_border_color;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_zorder;
   int               m_tab_zorder;
   //--- Индекс выделенной вкладки
   int               m_selected_tab;
   //---
public:
                     CTabs(void);
                    ~CTabs(void);
   //--- Методы для создания вкладок
   bool              CreateTabs(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateMainArea(void);
   bool              CreateTabsArea(void);
   bool              CreateButtons(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, 
   //    (2) устанавливает/получает расположение вкладок (сверху/снизу/слева/справа), (3) устанавливает размер вкладок по оси Y
   void              WindowPointer(CWindow &object)                  { m_wnd=::GetPointer(object);    }
   void              PositionMode(const ENUM_TABS_POSITION mode)     { m_position_mode=mode;          }
   ENUM_TABS_POSITION PositionMode(void)                       const { return(m_position_mode);       }
   void              TabYSize(const int y_size)                      { m_tab_y_size=y_size;           }
   //--- Цвет (1) общего фона, (2) цвета вкладок в разных состояних, (3) цвет рамок вкладок
   void              AreaColor(const color clr)                      { m_area_color=clr;              }
   void              TabBackColor(const color clr)                   { m_tab_color=clr;               }
   void              TabBackColorHover(const color clr)              { m_tab_color_hover=clr;         }
   void              TabBackColorSelected(const color clr)           { m_tab_color_selected=clr;      }
   void              TabBorderColor(const color clr)                 { m_tab_border_color=clr;        }
   //--- Цвет текста вкладок в разных состояних
   void              TabTextColor(const color clr)                   { m_tab_text_color=clr;          }
   void              TabTextColorSelected(const color clr)           { m_tab_text_color_selected=clr; }
   //--- (1) Сохраняет и (2) возвращает индекс выделенной вкладки
   void              SelectedTab(const int index)                    { m_selected_tab=index;          }
   int               SelectedTab(void)                         const { return(m_selected_tab);        }

   //--- Добавляет вкладку
   void              AddTab(const string tab_text="",const int tab_width=50);
   //--- Добавляет элемент в массив вкладки
   void              AddToElementsArray(const int tab_index,CElement &object);
   //--- Показать элементы только выделенной вкладки
   void              ShowTabElements(void);
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
   virtual void      ResetColors(void) {}
   //---
private:
   //--- Обработка нажатия на вкладке
   bool              OnClickTab(const string pressed_object);
   //--- Получение идентификатора из имени объекта
   int               IdFromObjectName(const string object_name);
   //--- Ширина всех вкладок
   int               SumWidthTabs(void);
   //--- Проверка индекса выделенной вкладки
   void              CheckTabIndex();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTabs::CTabs(void) : m_tab_y_size(20),
                     m_position_mode(TABS_TOP),
                     m_selected_tab(WRONG_VALUE),
                     m_area_color(C'15,15,15'),
                     m_tab_color(C'80,120,180'),
                     m_tab_color_hover(C'120,160,220'),
                     m_tab_color_selected(C'225,225,225'),
                     m_tab_text_color(clrGray),
                     m_tab_text_color_selected(clrBlack),
                     m_tab_border_color(clrWhite)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder     =0;
   m_tab_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTabs::~CTabs(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик события графика                                       |
//+------------------------------------------------------------------+
void CTabs::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      for(int i=0; i<m_tabs_total; i++)
         m_tabs[i].MouseFocus(x>m_tabs[i].X() && x<m_tabs[i].X2() && y>m_tabs[i].Y() && y<m_tabs[i].Y2());
      //---
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Нажатие на вкладке
      if(OnClickTab(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CTabs::OnEventTimer(void)
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
//| Создаёт элемент "Вкладки"                                        |
//+------------------------------------------------------------------+
bool CTabs::CreateTabs(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием группы вкладок ему нужно передать "
              "родительский объект с помощью метода WindowPointer(CWindow &object).");
      return(false);
     }
//--- Если нет ни одной вкладки в группе, сообщить об этом
   if(m_tabs_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна вкладка! Воспользуйтесь методом CTabs::AddTab()");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Создание элемента
   if(!CreateMainArea())
      return(false);
   if(!CreateTabsArea())
      return(false);
   if(!CreateButtons())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон общей области                                        |
//+------------------------------------------------------------------+
bool CTabs::CreateMainArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_tabs_main_area_"+(string)CElement::Id();
//--- Координаты
   int x=0;
   int y=0;
//--- Размеры
   int x_size=0;
   int y_size=0;
//--- Расчёт координат и размеров относительно позиционирования вкладок
   switch(m_position_mode)
     {
      case TABS_TOP :
         x      =CElement::X();
         y      =CElement::Y()+m_tab_y_size-1;
         x_size =CElement::XSize();
         y_size =CElement::YSize()-m_tab_y_size;
         break;
      case TABS_BOTTOM :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =CElement::XSize();
         y_size =CElement::YSize()-m_tab_y_size;
         break;
      case TABS_RIGHT :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =CElement::XSize()-SumWidthTabs()+1;
         y_size =CElement::YSize();
         break;
      case TABS_LEFT :
         x      =CElement::X()+SumWidthTabs()-1;
         y      =CElement::Y();
         x_size =CElement::XSize()-SumWidthTabs()+1;
         y_size =CElement::YSize();
         break;
     }
//--- Создание объекта
   if(!m_main_area.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Установка свойств
   m_main_area.BackColor(m_area_color);
   m_main_area.Color(m_tab_border_color);
   m_main_area.BorderType(BORDER_FLAT);
   m_main_area.Corner(m_corner);
   m_main_area.Selectable(false);
   m_main_area.Z_Order(m_zorder);
   m_main_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_main_area.XGap(x-m_wnd.X());
   m_main_area.YGap(y-m_wnd.Y());
//--- Сохраним размеры
   m_main_area.XSize(x_size);
   m_main_area.YSize(y_size);
//--- Сохраним координаты
   m_main_area.X(x);
   m_main_area.Y(y);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_main_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон для вкладок                                          |
//+------------------------------------------------------------------+
bool CTabs::CreateTabsArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_tabs_area_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y();
//--- Размеры
   int x_size=SumWidthTabs();
   int y_size=0;
//--- Расчёт размеров относительно позиционирования вкладок
   if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
     {
      y_size=m_tab_y_size;
     }
   else
     {
      y_size=m_tab_y_size*m_tabs_total-(m_tabs_total-1);
     }
//--- Скорректировать координаты для позиционирования вкладок снизу и справа
   if(m_position_mode==TABS_BOTTOM)
     {
      y=CElement::Y2()-m_tab_y_size-1;
     }
   else if(m_position_mode==TABS_RIGHT)
     {
      x=CElement::X2()-x_size;
     }
//--- Создание объекта
   if(!m_tabs_area.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Установка свойств
   m_tabs_area.BackColor(m_tab_border_color);
   m_tabs_area.Color(m_tab_border_color);
   m_tabs_area.BorderType(BORDER_FLAT);
   m_tabs_area.Corner(m_corner);
   m_tabs_area.Selectable(false);
   m_tabs_area.Z_Order(m_zorder);
   m_tabs_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_tabs_area.XGap(x-m_wnd.X());
   m_tabs_area.YGap(y-m_wnd.Y());
//--- Сохраним размеры
   m_tabs_area.XSize(x_size);
   m_tabs_area.YSize(y_size);
//--- Сохраним координаты
   m_tabs_area.X(x);
   m_tabs_area.Y(y);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_tabs_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вкладки                                                  |
//+------------------------------------------------------------------+
bool CTabs::CreateButtons(void)
  {
//--- Координаты
   int x =CElement::X();
   int y =CElement::Y();
//--- Расчёт координат относительно позиционирования вкладок
   if(m_position_mode==TABS_BOTTOM)
      y=CElement::Y2()-m_tab_y_size-1;
   else if(m_position_mode==TABS_RIGHT)
      x=CElement::X2()-SumWidthTabs();
//--- Проверка индекса выделенной вкладки
   CheckTabIndex();
//--- Создание вкладок
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- Формирование имени объекта
      string name=CElement::ProgramName()+"_tabs_edit_"+(string)i+"__"+(string)CElement::Id();
      //--- Расчёт координат относительно позиционирования вкладок для каждой вкладки отдельно
      if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
         x=(i>0) ? x+m_tab[i-1].width-1 : CElement::X();
      else
         y=(i>0) ? y+m_tab_y_size-1 : CElement::Y();
      //--- Создание объекта
      if(!m_tabs[i].Create(m_chart_id,name,m_subwin,x,y,m_tab[i].width,m_tab_y_size))
         return(false);
      //--- Установка свойств
      m_tabs[i].Font(FONT);
      m_tabs[i].FontSize(FONT_SIZE);
      m_tabs[i].Description(m_tab[i].text);
      m_tabs[i].BorderColor(m_tab_border_color);
      m_tabs[i].BackColor((SelectedTab()==i) ? m_tab_color_selected : m_tab_color);
      m_tabs[i].Color((SelectedTab()==i) ? m_tab_text_color_selected : m_tab_text_color);
      m_tabs[i].Corner(m_corner);
      m_tabs[i].Anchor(m_anchor);
      m_tabs[i].Selectable(false);
      m_tabs[i].TextAlign(ALIGN_CENTER);
      m_tabs[i].Z_Order(m_tab_zorder);
      m_tabs[i].ReadOnly(true);
      m_tabs[i].Tooltip("\n");
      //--- Отступы от крайней точки панели
      m_tabs[i].XGap(x-m_wnd.X());
      m_tabs[i].YGap(y-m_wnd.Y());
      //--- Координаты
      m_tabs[i].X(x);
      m_tabs[i].Y(y);
      //--- Размеры
      m_tabs[i].XSize(m_tab[i].width);
      m_tabs[i].YSize(m_tab_y_size);
      //--- Инициализация массива градиента
      CElement::InitColorArray(m_tab_color,m_tab_color_hover,m_tab_color_array);
      //--- Сохраним указатель объекта
      CElement::AddToArray(m_tabs[i]);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет вкладку                                                |
//+------------------------------------------------------------------+
void CTabs::AddTab(const string tab_text,const int tab_width)
  {
//--- Установить размер массивам вкладок
   int array_size=::ArraySize(m_tabs);
   ::ArrayResize(m_tabs,array_size+1);
   ::ArrayResize(m_tab,array_size+1);
//--- Сохранить переданные свойства
   m_tab[array_size].text  =tab_text;
   m_tab[array_size].width =tab_width;
//--- Сохраним количество вкладок
   m_tabs_total=array_size+1;
  }
//+------------------------------------------------------------------+
//| Добавляет элемент в массив указанной вкладки                     |
//+------------------------------------------------------------------+
void CTabs::AddToElementsArray(const int tab_index,CElement &object)
  {
//--- Проверка на выход из диапазона
   int array_size=::ArraySize(m_tab);
   if(array_size<1 || tab_index<0 || tab_index>=array_size)
      return;
//--- Добавим указатель переданного элемента в массив указанной вкладки
   int size=::ArraySize(m_tab[tab_index].elements);
   ::ArrayResize(m_tab[tab_index].elements,size+1);
   m_tab[tab_index].elements[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| Показывает элементы только выделенной вкладки                    |
//+------------------------------------------------------------------+
void CTabs::ShowTabElements(void)
  {
//--- Выйти, если вкладки скрыты
   if(!CElement::IsVisible())
      return;
//--- Проверка индекса выделенной вкладки
   CheckTabIndex();
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- Получим количество элементов присоединённых к вкладке
      int tab_elements_total=::ArraySize(m_tab[i].elements);
      //--- Если выделена эта вкладка
      if(i==m_selected_tab)
        {
         //--- Показать элементы вкладки
         for(int j=0; j<tab_elements_total; j++)
            m_tab[i].elements[j].Show();
        }
      //--- Скрыть элементы неактивных вкладок
      else
        {
         for(int j=0; j<tab_elements_total; j++)
            m_tab[i].elements[j].Hide();
        }
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета строки списка при наведении курсора              |
//+------------------------------------------------------------------+
void CTabs::ChangeObjectsColor(void)
  {
   for(int i=0; i<m_tabs_total; i++)
      CElement::ChangeObjectColor(m_tabs[i].Name(),m_tabs[i].MouseFocus(),
                                  OBJPROP_BGCOLOR,m_tab_color,m_tab_color_hover,m_tab_color_array);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CTabs::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение отступов в полях элемента
   CElement::X(x+CElement::XGap());
   CElement::Y(y+CElement::YGap());
//--- Сохранение координат в полях объектов
   m_main_area.X(x+m_main_area.XGap());
   m_main_area.Y(y+m_main_area.YGap());
   m_tabs_area.X(x+m_tabs_area.XGap());
   m_tabs_area.Y(y+m_tabs_area.YGap());
//--- Обновление координат графических объектов
   m_main_area.X_Distance(m_main_area.X());
   m_main_area.Y_Distance(m_main_area.Y());
   m_tabs_area.X_Distance(m_tabs_area.X());
   m_tabs_area.Y_Distance(m_tabs_area.Y());
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- Сохранение координат в полях объектов
      m_tabs[i].X(x+m_tabs[i].XGap());
      m_tabs[i].Y(y+m_tabs[i].YGap());
      //--- Обновление координат графических объектов
      m_tabs[i].X_Distance(m_tabs[i].X());
      m_tabs[i].Y_Distance(m_tabs[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CTabs::Show(void)
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
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CTabs::Hide(void)
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
void CTabs::Reset(void)
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
void CTabs::Delete(void)
  {
//--- Удаление графических объектов элемента
   m_main_area.Delete();
   m_tabs_area.Delete();
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Delete();
//--- Освобождение массивов элемента
   for(int i=0; i<m_tabs_total; i++)
      ::ArrayFree(m_tab[i].elements);
//--- 
   ::ArrayFree(m_tab);
   ::ArrayFree(m_tabs);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   m_tabs_total=0;
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CTabs::SetZorders(void)
  {
   m_main_area.Z_Order(m_zorder);
   m_tabs_area.Z_Order(m_zorder);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(m_tab_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CTabs::ResetZorders(void)
  {
   m_main_area.Z_Order(0);
   m_tabs_area.Z_Order(0);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Нажатие на вкладку в группе                                      |
//+------------------------------------------------------------------+
bool CTabs::OnClickTab(const string clicked_object)
  {
//--- Выйдем, если нажатие было не на ячейке таблицы
   if(::StringFind(clicked_object,CElement::ProgramName()+"_tabs_edit_",0)<0)
      return(false);
//--- Получим идентификатор из имени объекта
   int id=IdFromObjectName(clicked_object);
//--- Выйти, если идентификатор не совпадает
   if(id!=CElement::Id())
      return(false);
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- Если выбрана эта вкладка
      if(m_tabs[i].Name()==clicked_object)
        {
         //--- Сохранить индекс выделенной вкладки
         SelectedTab(i);
         //--- Установить цвета
         m_tabs[i].Color(m_tab_text_color_selected);
         m_tabs[i].BackColor(m_tab_color_selected);
        }
      else
        {
         //--- Установить цвета для неактивных вкладок
         m_tabs[i].Color(m_tab_text_color);
         m_tabs[i].BackColor(m_tab_color);
        }
     }
//--- Показать элементы только выделенной вкладки
   ShowTabElements();
   return(true);
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CTabs::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
//| Общая ширина всех вкладок                                        |
//+------------------------------------------------------------------+
int CTabs::SumWidthTabs(void)
  {
   int width=0;
//--- Если позиционирование вкладок справа или слева, вернуть ширину первой вкладки
   if(m_position_mode==TABS_LEFT || m_position_mode==TABS_RIGHT)
      return(m_tab[0].width);
//--- Суммируем ширину всех вкладок
   for(int i=0; i<m_tabs_total; i++)
      width=width+m_tab[i].width;
//--- С учётом наслоения на один пиксель
   width=width-(m_tabs_total-1);
   return(width);
  }
//+------------------------------------------------------------------+
//| Проверка индекса выделенной вкладки                              |
//+------------------------------------------------------------------+
void CTabs::CheckTabIndex(void)
  {
//--- Проверка на выход из диапазона
   int array_size=::ArraySize(m_tab);
   if(m_selected_tab<0)
      m_selected_tab=0;
   if(m_selected_tab>=array_size)
      m_selected_tab=array_size-1;
  }
//+------------------------------------------------------------------+
