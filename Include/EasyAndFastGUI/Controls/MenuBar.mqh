//+------------------------------------------------------------------+
//|                                                      MenuBar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "MenuItem.mqh"
#include "ContextMenu.mqh"
//+------------------------------------------------------------------+
//| Класс для создания главного меню                                 |
//+------------------------------------------------------------------+
class CMenuBar : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания пункта меню
   CRectLabel        m_area;
   CMenuItem         m_items[];
   //--- Массив указателей на контекстные меню
   CContextMenu     *m_contextmenus[];

   //--- Свойства фона
   int               m_area_zorder;
   color             m_area_color;
   color             m_area_color_hover;
   color             m_area_border_color;
   //--- Общие свойства пунктов меню
   int               m_item_y_size;
   color             m_item_color;
   color             m_item_color_hover;
   color             m_item_border_color;
   int               m_label_x_gap;
   int               m_label_y_gap;
   color             m_label_color;
   color             m_label_color_hover;

   //--- Массивы уникальных свойств пунктов меню:
   //    (1) Ширина, (2) текст
   int               m_width[];
   string            m_label_text[];
   //--- Состояние главного меню
   bool              m_menubar_state;
   //---
public:
                     CMenuBar(void);
                    ~CMenuBar(void);
   //--- Методы для создания главного меню
   bool              CreateMenuBar(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   //---
public:
   //--- Сохраняет указатель формы
   void              WindowPointer(CWindow &object) { m_wnd=::GetPointer(object); }

   //--- (1) Получение указателя указанного пункта меню, (2) получение указателя указанного контекстного меню
   CMenuItem        *ItemPointerByIndex(const int index);
   CContextMenu     *ContextMenuPointerByIndex(const int index);

   //--- Количество (1) пунктов и (2) контекстных меню, (3) состояние главного меню
   int               ItemsTotal(void)               const { return(::ArraySize(m_items));        }
   int               ContextMenusTotal(void)        const { return(::ArraySize(m_contextmenus)); }
   bool              State(void)                    const { return(m_menubar_state);             }
   void              State(const bool state);

   //--- Цвет (1) фона и (2) рамки фона главного меню
   void              MenuBackColor(const color clr)       { m_area_color=clr;                    }
   void              MenuBorderColor(const color clr)     { m_area_border_color=clr;             }
   //--- (1) цвет фона, (2) цвет фона при наведении курсора и (3) цвет рамки пунктов главного меню
   void              ItemBackColor(const color clr)       { m_item_color=clr;                    }
   void              ItemBackColorHover(const color clr)  { m_item_color_hover=clr;              }
   void              ItemBorderColor(const color clr)     { m_item_border_color=clr;             }
   //--- Отступы текстовой метки от крайней точки фона пункта
   void              LabelXGap(const int x_gap)           { m_label_x_gap=x_gap;                 }
   void              LabelYGap(const int y_gap)           { m_label_y_gap=y_gap;                 }
   //--- Цвет текста (1) обычный и (2) в фокусе
   void              LabelColor(const color clr)          { m_label_color=clr;                   }
   void              LabelColorHover(const color clr)     { m_label_color_hover=clr;             }

   //--- Добавляет пункт меню с указанными свойствами до создания главного меню
   void              AddItem(const int width,const string text);
   //--- Присоединяет переданное контекстное меню к указанному пункту главного меню
   void              AddContextMenuPointer(const int index,CContextMenu &object);

   //--- Изменяет цвет при наведении курсора мыши
   void              ChangeObjectsColor(void);

   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
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
   //--- Обработка нажатия на пункте меню
   bool              OnClickMenuItem(const string clicked_object);
   //--- Получение (1) идентификатора и (2) индекса из имени пункта меню
   int               IdFromObjectName(const string object_name);
   int               IndexFromObjectName(const string object_name);
   //--- Возвращает активный пункт главного меню
   int               ActiveItemIndex(void);
   //--- Переключает контекстные меню главного меню, наведением курсора
   void              SwitchContextMenuByFocus(const int active_item_index);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMenuBar::CMenuBar(void) : m_menubar_state(false),
                           m_area_zorder(0),
                           m_area_color(C'240,240,240'),
                           m_area_border_color(clrSilver),
                           m_item_y_size(22),
                           m_item_color(C'240,240,240'),
                           m_item_color_hover(C'51,153,255'),
                           m_item_border_color(C'240,240,240'),
                           m_label_x_gap(15),
                           m_label_y_gap(3),
                           m_label_color(clrBlack),
                           m_label_color_hover(clrWhite)
  {
//--- Сохраним имя класса элемента в базовом классе
   ClassName(CLASS_NAME);
//--- Высота главного меню по умолчанию
   m_y_size=22;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMenuBar::~CMenuBar(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CMenuBar::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора    
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Выйти, если главное меню неактивировано
      if(!m_menubar_state)
         return;
      //--- Получим индекс активиронного пункта главного меню
      int active_item_index=ActiveItemIndex();
      if(active_item_index==WRONG_VALUE)
         return;
      //--- Изменить цвет, если фокус изменился
      ChangeObjectsColor();
      //--- Переключить контекстное меню по активированному пункту главного меню
      SwitchContextMenuByFocus(active_item_index);
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на пункте главного меню
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Создаёт главное меню                                             |
//+------------------------------------------------------------------+
bool CMenuBar::CreateMenuBar(const long chart_id,const int window,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием главного меню ему нужно передать "
              "объект формы с помощью метода WindowPointer(CWindow &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =window;
   m_x        =x;
   m_y        =y;
//--- Отступы от крайней точки
   CElement::XGap(x-m_wnd.X());
   CElement::YGap(y-m_wnd.Y());
//--- Создание главного меню
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- Изначально главное меню неактивно
   State(false);
//--- Скрыть элемент, если он в диалоговом окне или окно свёрнуто
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт общую площадь главного меню                              |
//+------------------------------------------------------------------+
bool CMenuBar::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_menubar_bg_"+(string)CElement::Id();
//--- Координаты и ширина
   int x      =m_x;
   int y      =m_y;
   int x_size =m_wnd.XSize()-2;
//--- Установим фон главного меню
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(XGap());
   m_area.YGap(YGap());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт список пунктов меню                                      |
//+------------------------------------------------------------------+
bool CMenuBar::CreateItems(void)
  {
   int x=m_x+1;
   int y=m_y+1;
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Расчёт координаты X
      x=(i>0)? x+m_width[i-1]: x;
      //--- Передадим объект панели
      m_items[i].WindowPointer(m_wnd);
      //--- Установим свойства перед созданием
      m_items[i].TypeMenuItem(MI_HAS_CONTEXT_MENU);
      m_items[i].ShowRightArrow(false);
      m_items[i].XSize(m_width[i]);
      m_items[i].YSize(m_y_size-2);
      m_items[i].AreaBorderColor(m_item_border_color);
      m_items[i].AreaBackColor(m_item_color);
      m_items[i].AreaBackColorHover(m_item_color_hover);
      m_items[i].LabelXGap(m_label_x_gap);
      m_items[i].LabelYGap(m_label_y_gap);
      m_items[i].LabelColor(m_label_color);
      m_items[i].LabelColorHover(m_label_color_hover);
      //--- Отступы от крайней точки панели
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- Создание пункта меню
      if(!m_items[i].CreateMenuItem(m_chart_id,m_subwin,i,m_label_text[i],x,y))
         return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Установка состояния главного меню                                |
//+------------------------------------------------------------------+
void CMenuBar::State(const bool state)
  {
   if(state)
      m_menubar_state=true;
   else
     {
      m_menubar_state=false;
      //--- Пройтись по всем пунктам главного меню для
      //    установки статуса отключенных контекстных меню
      int items_total=ItemsTotal();
      for(int i=0; i<items_total; i++)
         m_items[i].ContextMenuState(false);
      //--- Разблокировать форму
      m_wnd.IsLocked(false);
     }
  }
//+------------------------------------------------------------------+
//| Возвращает указатель пункта меню по индексу                      |
//+------------------------------------------------------------------+
CMenuItem *CMenuBar::ItemPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- Если нет ни одного пункта в главном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в главном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть указатель
   return(::GetPointer(m_items[i]));
  }
//+------------------------------------------------------------------+
//| Возвращает указатель контекстного меню по индексу                |
//+------------------------------------------------------------------+
CContextMenu *CMenuBar::ContextMenuPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_contextmenus);
//--- Если нет ни одного пункта в главном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в главном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть указатель
   return(::GetPointer(m_contextmenus[i]));
  }
//+------------------------------------------------------------------+
//| Добавляет пункт меню                                             |
//+------------------------------------------------------------------+
void CMenuBar::AddItem(const int width,const string text)
  {
//--- Увеличим размер массивов на один элемент  
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_contextmenus,array_size+1);
   ::ArrayResize(m_width,array_size+1);
   ::ArrayResize(m_label_text,array_size+1);
//--- Сохраним значения переданных параметров
   m_width[array_size]      =width;
   m_label_text[array_size] =text;
  }
//+------------------------------------------------------------------+
//| Добавляет указатель контекстного меню                            |
//+------------------------------------------------------------------+
void CMenuBar::AddContextMenuPointer(const int index,CContextMenu &object)
  {
//--- Проверка на выход из диапазона
   int size=::ArraySize(m_contextmenus);
   if(size<1 || index<0 || index>=size)
      return;
//--- Сохранить указатель
   m_contextmenus[index]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| Сброс цвета пунктов                                              |
//+------------------------------------------------------------------+
void CMenuBar::ResetColors(void)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].ResetColors();
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CMenuBar::Moving(const int x,const int y)
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
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CMenuBar::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты  
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Сделать видимыми все пункты меню 
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Show();
//--- Инициализация переменных
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CMenuBar::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть объекты главного меню
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть пункты меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- Присвоить статус скрытого элемента
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CMenuBar::Reset(void)
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
void CMenuBar::Delete(void)
  {
//--- Удаление объектов  
   m_area.Delete();
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Delete();
//--- Освобождение массивов элемента
   ::ArrayFree(m_items);
   ::ArrayFree(m_contextmenus);
   ::ArrayFree(m_width);
   ::ArrayFree(m_label_text);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CMenuBar::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CMenuBar::ResetZorders(void)
  {
   m_area.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CMenuBar::ChangeObjectsColor(void)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Нажатие на пункте главного меню                                  |
//+------------------------------------------------------------------+
bool CMenuBar::OnClickMenuItem(const string clicked_object)
  {
//--- Выйдем, если нажатие было не на пункте меню
   if(::StringFind(clicked_object,CElement::ProgramName()+"_menuitem_",0)<0)
      return(false);
//--- Получим идентификатор и индекс из имени объекта
   int id    =IdFromObjectName(clicked_object);
   int index =IndexFromObjectName(clicked_object);
//--- Выйти, если идентификатор не совпадает
   if(id!=CElement::Id())
      return(false);
//--- Если есть указатель на контекстное меню
   if(::CheckPointer(m_contextmenus[index])!=POINTER_INVALID)
     {
      //--- Изменить цвет пункта
      m_items[index].HighlightItemState(true);
      //--- Состояние главного меню зависит от видимости контекстного меню
      m_menubar_state=(m_contextmenus[index].ContextMenuState())? false : true;
      //--- Установить состояние формы
      m_wnd.IsLocked(m_menubar_state);
      //--- Если главное меню отключено
      if(!m_menubar_state)
         //--- Послать сигнал на скрытие всех контекстных меню
         ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
     }
//--- Если нет указателя на контекстное меню
   else
     {
      //--- Послать сигнал на скрытие всех контекстных меню
      ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CMenuBar::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
//| Извлекает индекс из имени объекта                                |
//+------------------------------------------------------------------+
int CMenuBar::IndexFromObjectName(const string object_name)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- Получим код разделителя
   u_sep=::StringGetCharacter("_",0);
//--- Разобьём строку
   ::StringSplit(object_name,u_sep,result);
   array_size=::ArraySize(result)-1;
//--- Проверка выхода за диапазон массива
   if(array_size-2<0)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- Вернуть индекс пункта
   return((int)result[array_size-2]);
  }
//+------------------------------------------------------------------+
//| Возвращает индекс активированного пункта меню                    |
//+------------------------------------------------------------------+
int CMenuBar::ActiveItemIndex(void)
  {
   int active_item_index=WRONG_VALUE;
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Если пункт в фокусе
      if(m_items[i].MouseFocus())
        {
         //--- Запомним индекс и остановим цикл
         active_item_index=i;
         break;
        }
     }
//---
   return(active_item_index);
  }
//+------------------------------------------------------------------+
//| Переключает контекстные меню главного меню, наведением курсора   |
//+------------------------------------------------------------------+
void CMenuBar::SwitchContextMenuByFocus(const int active_item_index)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Перейти к следующему, если в этом пункте нет контекстного меню
      if(::CheckPointer(m_contextmenus[i])==POINTER_INVALID)
         continue;
      //--- Если дошли до указанного пункта, то сделать его контекстное меню видимым
      if(i==active_item_index)
         m_contextmenus[i].Show();
      //--- Все остальные контекстные меню нужно скрыть
      else
        {
         CContextMenu *cm=m_contextmenus[i];
         //--- Скрыть контекстные меню, которые открыты из других контекстных меню.
         //    Пройдёмся в цикле по пунктам текущего контекстного меню, чтобы выяснить, есть ли такие.
         int cm_items_total=cm.ItemsTotal();
         for(int c=0; c<cm_items_total; c++)
           {
            CMenuItem *mi=cm.ItemPointerByIndex(c);
            //--- Перейти к следующему, если указатель на пункт некорректный
            if(::CheckPointer(mi)==POINTER_INVALID)
               continue;
            //--- Перейти к следующему, если этот пункт не содержит в себе контекстное меню
            if(mi.TypeMenuItem()!=MI_HAS_CONTEXT_MENU)
               continue;
            //--- Если контекстное меню есть и оно активировано
            if(mi.ContextMenuState())
              {
               //--- Отправить сигнал на закрытие всех контекстных меню, которые открыты из этого
               ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
               break;
              }
           }
         //--- Скрыть контекстное меню главного меню
         m_contextmenus[i].Hide();
         //--- Сбросить цвет пункта меню
         m_items[i].ResetColors();
        }
     }
  }
//+------------------------------------------------------------------+
