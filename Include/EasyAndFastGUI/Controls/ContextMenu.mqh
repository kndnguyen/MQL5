//+------------------------------------------------------------------+
//|                                                  ContextMenu.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "MenuItem.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| Класс для создания контекстного меню                             |
//+------------------------------------------------------------------+
class CContextMenu : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания пункта меню
   CRectLabel        m_area;
   CMenuItem         m_items[];
   CSeparateLine     m_sep_line[];
   //--- Указатель на предыдущий узел
   CMenuItem        *m_prev_node;
   //--- Свойства фона
   int               m_area_zorder;
   color             m_area_color;
   color             m_area_border_color;
   color             m_area_color_hover;
   color             m_area_color_array[];
   //--- Свойства пункта меню
   int               m_item_y_size;
   color             m_item_back_color;
   color             m_item_border_color;
   color             m_item_back_color_hover;
   color             m_item_back_color_hover_off;
   color             m_label_color;
   color             m_label_color_hover;
   string            m_right_arrow_file_on;
   string            m_right_arrow_file_off;
   //--- Свойства разделительной линии
   color             m_sepline_dark_color;
   color             m_sepline_light_color;
   //--- Массивы свойств пунктов меню:
   //    (1) Текст, (2) ярлык доступного пункта, (3) ярлык заблокированного пункта
   string            m_label_text[];
   string            m_path_bmp_on[];
   string            m_path_bmp_off[];
   //--- Массив номеров индексов пунктов меню, после которых нужно установить разделительную линию
   int               m_sep_line_index[];
   //--- Состояние контекстного меню
   bool              m_context_menu_state;
   //--- Сторона фиксации контекстного меню
   ENUM_FIX_CONTEXT_MENU m_fix_side;
   //--- Режим свободного контекстного меню. То есть, без привязки к предыдущему узлу.
   bool              m_free_context_menu;
   //---
public:
                     CContextMenu(void);
                    ~CContextMenu(void);
   //--- Методы для создания контекстного меню
   bool              CreateContextMenu(const long chart_id,const int window,const int x=0,const int y=0);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   bool              CreateSeparateLine(const int line_number,const int x,const int y);
   //---
public:
   //--- (1) Сохраняет указатель формы,
   //    (2) получение и (3) сохранение указателя предыдущего узла, (4) установка режима свободного контекстного меню
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);           }
   CMenuItem        *PrevNodePointer(void)                    const { return(m_prev_node);                  }
   void              PrevNodePointer(CMenuItem &object)             { m_prev_node=::GetPointer(object);     }
   void              FreeContextMenu(const bool flag)               { m_free_context_menu=flag;             }
   //--- Возвращает указатель пункта из контекстного меню
   CMenuItem        *ItemPointerByIndex(const int index);

   //--- Методы для настройки внешнего вида контекстного меню:
   //    Цвет фона контекстного меню
   void              AreaBackColor(const color clr)                 { m_area_color=clr;                     }
   void              AreaBorderColor(const color clr)               { m_area_border_color=clr;              }

   //--- (1) Количество пунктов меню, (2) высота, (3) цвет фона и (4) цвет рамки пункта меню 
   int               ItemsTotal(void)                         const { return(::ArraySize(m_items));         }
   void              ItemYSize(const int y_size)                    { m_item_y_size=y_size;                 }
   void              ItemBackColor(const color clr)                 { m_item_back_color=clr;                }
   void              ItemBorderColor(const color clr)               { m_item_border_color=clr;              }
   //--- Цвет фона (1) доступного и (2) заблокированного пункта меню при наведении курсора мыши
   void              ItemBackColorHover(const color clr)            { m_item_back_color_hover=clr;          }
   void              ItemBackColorHoverOff(const color clr)         { m_item_back_color_hover_off=clr;      }
   //--- Цвет текста (1) обычный и (2) в фокусе
   void              LabelColor(const color clr)                    { m_label_color=clr;                    }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;              }
   //--- Определение картинки для признака наличия контекстного меню в пункте
   void              RightArrowFileOn(const string file_path)       { m_right_arrow_file_on=file_path;      }
   void              RightArrowFileOff(const string file_path)      { m_right_arrow_file_off=file_path;     }
   //--- (1) Тёмный и (2) светлый цвет разделительной линии
   void              SeparateLineDarkColor(const color clr)         { m_sepline_dark_color=clr;             }
   void              SeparateLineLightColor(const color clr)        { m_sepline_light_color=clr;            }

   //--- Добавляет пункт меню с указанными свойствами до создания контекстного меню
   void              AddItem(const string text,const string path_bmp_on,const string path_bmp_off,const ENUM_TYPE_MENU_ITEM type);
   //--- Добавляет разделительную линию после указанного пункта до создания контекстного меню
   void              AddSeparateLine(const int item_index);

   //--- Возвращает описание (отображаемый текст)
   string            DescriptionByIndex(const int index);
   //--- Возвращает тип пункта меню
   ENUM_TYPE_MENU_ITEM TypeMenuItemByIndex(const int index);

   //--- (1) Получение и (2) установка состояния чекбокса
   bool              CheckBoxStateByIndex(const int index);
   void              CheckBoxStateByIndex(const int index,const bool state);
   //--- (1) Возвращает и (2) устанавливает id радио-пункта по индексу
   int               RadioItemIdByIndex(const int index);
   void              RadioItemIdByIndex(const int item_index,const int radio_id);
   //--- (1) Возвращает выделенный радио-пункт, (2) переключает радио-пункт
   int               SelectedRadioItem(const int radio_id);
   void              SelectedRadioItem(const int radio_index,const int radio_id);

   //--- (1) Получение и (2) установка состояния контекстного меню, (3) установка режима фиксации контекстного меню
   bool              ContextMenuState(void)                   const { return(m_context_menu_state);         }
   void              ContextMenuState(const bool flag)              { m_context_menu_state=flag;            }
   void              FixSide(const ENUM_FIX_CONTEXT_MENU side)      { m_fix_side=side;                      }

   //--- Изменяет цвет пунктов меню при наведении курсора
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
   //--- Проверка условий на закрытие всех контекстных меню
   void              CheckHideContextMenus(void);
   //--- Проверка условий на закрытие всех контекстных меню, которые были открыты после этого
   void              CheckHideBackContextMenus(void);
   //--- Обработка нажатия на пункте, к которому это контекстное меню привязано
   bool              OnClickMenuItem(const string clicked_object);
   //--- Приём сообщения от пункта меню для обработки
   void              ReceiveMessageFromMenuItem(const int id_item,const int index_item,const string message_item);
   //--- Получение (1) идентификатора и (2) индекса из имени пункта меню
   int               IdFromObjectName(const string object_name);
   int               IndexFromObjectName(const string object_name);
   //--- Получение (1) идентификатора и (2) индекса из сообщения радио-пункта
   int               RadioIdFromMessage(const string message);
   int               RadioIndexByItemIndex(const int index);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CContextMenu::CContextMenu(void) : m_context_menu_state(false),
                                   m_free_context_menu(false),
                                   m_fix_side(FIX_RIGHT),
                                   m_item_y_size(24),
                                   m_area_color(C'15,15,15'),
                                   m_area_color_hover(C'51,153,255'),
                                   m_area_border_color(clrWhiteSmoke),
                                   m_label_color(clrWhite),
                                   m_label_color_hover(clrWhite),
                                   m_sepline_dark_color(clrBlack),
                                   m_sepline_light_color(clrDimGray),
                                   m_right_arrow_file_on(""),
                                   m_right_arrow_file_off("")
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder=0;
//--- Контекстное меню является выпадающим элементом
   CElement::IsDropdown(true);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CContextMenu::~CContextMenu(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CContextMenu::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка пермещения курсора мыши
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Получим фокус
      int x=(int)lparam;
      int y=(int)dparam;
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- Выйти, если это свободное контекстное меню
      if(m_free_context_menu)
         return;
      //--- Если контекстное меню включено и левая кнопка мыши нажата
      if(m_context_menu_state && sparam=="1")
        {
         //--- Проверим условий на закрытие всех контекстных меню
         CheckHideContextMenus();
         return;
        }
      //--- Проверим условия на закрытие всех контекстных меню, которые были открыты после этого
      CheckHideBackContextMenus();
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
//--- Обработка события ON_CLICK_MENU_ITEM
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_MENU_ITEM)
     {
      //--- Выйти, если это свободное контекстное меню
      if(m_free_context_menu)
         return;
      //---
      int    item_id      =int(lparam);
      int    item_index   =int(dparam);
      string item_message =sparam;
      //--- Приём сообщения от пункта меню для обработки
      ReceiveMessageFromMenuItem(item_id,item_index,item_message);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CContextMenu::OnEventTimer(void)
  {
//--- Изменение цвета пунктов меню при наведении курсора
   ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Создаёт контекстное меню                                         |
//+------------------------------------------------------------------+
bool CContextMenu::CreateContextMenu(const long chart_id,const int subwin,const int x=0,const int y=0)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием контекстного меню ему нужно передать "
              "объект окна с помощью метода WindowPointer(CWindow &object).");
      return(false);
     }
//--- Если это привязанное контекстное меню
   if(!m_free_context_menu)
     {
      //--- Выйти, если нет указателя на предыдущий узел 
      if(::CheckPointer(m_prev_node)==POINTER_INVALID)
        {
         ::Print(__FUNCTION__," > Перед созданием контекстного меню ему нужно передать "
                 "указатель на предыдущий узел с помощью метода CContextMenu::PrevNodePointer(CMenuItem &object).");
         return(false);
        }
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
//--- Если координаты не указаны
   if(x==0 || y==0)
     {
      m_x =(m_fix_side==FIX_RIGHT)? m_prev_node.X2()-3 : m_prev_node.X()+1;
      m_y =(m_fix_side==FIX_RIGHT)? m_prev_node.Y()-1  : m_prev_node.Y2()-1;
     }
//--- Если координаты указаны
   else
     {
      m_x =x;
      m_y =y;
     }
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание контекстного меню
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- Скрыть элемент
   Hide();
//--- Сбросить цвет объектов
   ResetColors();
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт общую площадь контекстного меню                          |
//+------------------------------------------------------------------+
bool CContextMenu::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_contextmenu_bg_"+(string)CElement::Id();
//--- Расчёт высоты контекстного меню зависит от количества пунктов меню и разделительных линий
   int items_total =ItemsTotal();
   int sep_y_size  =::ArraySize(m_sep_line)*9;
   m_y_size        =(m_item_y_size*items_total+2)+sep_y_size-(items_total-1);
//--- Установим фон контекстного меню
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
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
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Размеры фона
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт список пунктов меню                                      |
//+------------------------------------------------------------------+
bool CContextMenu::CreateItems(void)
  {
   int s =0;     // Для определения положения разделительных линий
   int x =m_x+1; // Координата X
   int y =m_y+1; // Координата Y. Будет рассчитываться в цикле для каждого пункта меню.
//--- Количество разделительных линий
   int sep_lines_total=::ArraySize(m_sep_line_index);
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Расчёт координаты Y
      y=(i>0)? y+m_item_y_size-1 : y;
      //--- Сохраним указатель формы
      m_items[i].WindowPointer(m_wnd);
      //--- Если контекстное меню с привязкой, то добавим указатель на предыдущий узел
      if(!m_free_context_menu)
         m_items[i].PrevNodePointer(m_prev_node);
      //--- Установим свойства
      m_items[i].XSize(m_x_size-2);
      m_items[i].YSize(m_item_y_size);
      m_items[i].IconFileOn(m_path_bmp_on[i]);
      m_items[i].IconFileOff(m_path_bmp_off[i]);
      m_items[i].AreaBackColor(m_area_color);
      m_items[i].AreaBackColorHoverOff(m_item_back_color_hover_off);
      m_items[i].AreaBorderColor(m_area_color);
      m_items[i].LabelColor(m_label_color);
      m_items[i].LabelColorHover(m_label_color_hover);
      m_items[i].RightArrowFileOn(m_right_arrow_file_on);
      m_items[i].RightArrowFileOff(m_right_arrow_file_off);
      m_items[i].IsDropdown(m_is_dropdown);
      //--- Отступы от крайней точки панели
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- Создание пункта меню
      if(!m_items[i].CreateMenuItem(m_chart_id,m_subwin,i,m_label_text[i],x,y))
         return(false);
      //--- Обнулить фокус
      CElement::MouseFocus(false);
      //--- Перейти к следующему, если все разделительные линии установлены
      if(s>=sep_lines_total)
         continue;
      //--- Если индексы совпали, значит после этого пункта нужно установить разделительную линию
      if(i==m_sep_line_index[s])
        {
         //--- Координаты
         int l_x=x+5;
         y=y+m_item_y_size+2;
         //--- Установка разделительной линии
         if(!CreateSeparateLine(s,l_x,y))
            return(false);
         //--- Корректировка координаты Y для следующего пункта
         y=y-m_item_y_size+7;
         //--- Увеличение счётчика разделительных линий
         s++;
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт разделительную линию                                     |
//+------------------------------------------------------------------+
bool CContextMenu::CreateSeparateLine(const int line_number,const int x,const int y)
  {
//--- Сохраним указатель формы
   m_sep_line[line_number].WindowPointer(m_wnd);
//--- Установим свойства
   m_sep_line[line_number].TypeSepLine(H_SEP_LINE);
   m_sep_line[line_number].DarkColor(m_sepline_dark_color);
   m_sep_line[line_number].LightColor(m_sepline_light_color);
//--- Создание разделительной линии
   if(!m_sep_line[line_number].CreateSeparateLine(m_chart_id,m_subwin,line_number,x,y,m_x_size-10,2))
      return(false);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_sep_line[line_number].Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| Возвращает указатель пункта меню по индексу                      |
//+------------------------------------------------------------------+
CMenuItem *CContextMenu::ItemPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- Если нет ни одного пункта в контекстном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в контекстном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть указатель
   return(::GetPointer(m_items[i]));
  }
//+------------------------------------------------------------------+
//| Добавляет пункт меню                                             |
//+------------------------------------------------------------------+
void CContextMenu::AddItem(const string text,const string path_bmp_on,const string path_bmp_off,const ENUM_TYPE_MENU_ITEM type)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_label_text,array_size+1);
   ::ArrayResize(m_path_bmp_on,array_size+1);
   ::ArrayResize(m_path_bmp_off,array_size+1);
//--- Сохраним значения переданных параметров
   m_label_text[array_size]   =text;
   m_path_bmp_on[array_size]  =path_bmp_on;
   m_path_bmp_off[array_size] =path_bmp_off;
//--- Установка типа пункта меню
   m_items[array_size].TypeMenuItem(type);
  }
//+------------------------------------------------------------------+
//| Добавляет разделительную линию                                   |
//+------------------------------------------------------------------+
void CContextMenu::AddSeparateLine(const int item_index)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_sep_line);
   ::ArrayResize(m_sep_line,array_size+1);
   ::ArrayResize(m_sep_line_index,array_size+1);
//--- Сохраним номер индекса
   m_sep_line_index[array_size]=item_index;
  }
//+------------------------------------------------------------------+
//| Возвращает название пункта по индексу                            |
//+------------------------------------------------------------------+
string CContextMenu::DescriptionByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- Если нет ни одного пункта в контекстном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в контекстном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть описание пункта
   return(m_items[i].LabelText());
  }
//+------------------------------------------------------------------+
//| Возвращает тип пункта по индексу                                 |
//+------------------------------------------------------------------+
ENUM_TYPE_MENU_ITEM CContextMenu::TypeMenuItemByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- Если нет ни одного пункта в контекстном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в контекстном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть тип пункта
   return(m_items[i].TypeMenuItem());
  }
//+------------------------------------------------------------------+
//| Возвращает состояние чекбокса по индексу                         |
//+------------------------------------------------------------------+
bool CContextMenu::CheckBoxStateByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- Если нет ни одного пункта в контекстном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в контекстном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть состояние пункта
   return(m_items[i].CheckBoxState());
  }
//+------------------------------------------------------------------+
//| Устанавливает состояние чекбокса по индексу                      |
//+------------------------------------------------------------------+
void CContextMenu::CheckBoxStateByIndex(const int index,const bool state)
  {
//--- Проверка на выход из диапазона
   int size=::ArraySize(m_items);
   if(size<1 || index<0 || index>=size)
      return;
//--- Установить состояние
   m_items[index].CheckBoxState(state);
  }
//+------------------------------------------------------------------+
//| Возвращает id радио-пункта по индексу                            |
//+------------------------------------------------------------------+
int CContextMenu::RadioItemIdByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- Если нет ни одного пункта в контекстном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в контекстном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть идентификатор
   return(m_items[i].RadioButtonID());
  }
//+------------------------------------------------------------------+
//| Устанавливает id для радио-пункта по индексу                     |
//+------------------------------------------------------------------+
void CContextMenu::RadioItemIdByIndex(const int index,const int id)
  {
//--- Проверка на выход из диапазона
   int array_size=::ArraySize(m_items);
   if(array_size<1 || index<0 || index>=array_size)
      return;
//--- Установить идентификатор
   m_items[index].RadioButtonID(id);
  }
//+------------------------------------------------------------------+
//| Возвращает индекс радио-пункта по id                             |
//+------------------------------------------------------------------+
int CContextMenu::SelectedRadioItem(const int radio_id)
  {
//--- Счётчик радио-пунктов
   int count_radio_id=0;
//--- Пройдёмся в цикле по списку пунктов контекстного меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Перейти к следующему, если не радио-пункт
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- Если идентификаторы совпадают
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- Если это активный радио-пункт, выходим из цикла
         if(m_items[i].RadioButtonState())
            break;
         //--- Увеличить счётчик радио-пунктов
         count_radio_id++;
        }
     }
//--- Вернуть индекс
   return(count_radio_id);
  }
//+------------------------------------------------------------------+
//| Переключает радио-пункт по индексу и id                          |
//+------------------------------------------------------------------+
void CContextMenu::SelectedRadioItem(const int radio_index,const int radio_id)
  {
//--- Счётчик радио-пунктов
   int count_radio_id=0;
//--- Пройдёмся в цикле по списку пунктов контекстного меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Перейти к следующему, если не радио-пункт
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- Если идентификаторы совпадают
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- Переключить радио-пункт
         if(count_radio_id==radio_index)
            m_items[i].RadioButtonState(true);
         else
            m_items[i].RadioButtonState(false);
         //--- Увеличить счётчик радио-пунктов
         count_radio_id++;
        }
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CContextMenu::Moving(const int x,const int y)
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
//--- Перемещение пунктов меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Moving(x,y);
//--- Перемещение разделительных линий
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| Показывает контекстное меню                                      |
//+------------------------------------------------------------------+
void CContextMenu::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Показать объекты контекстного меню
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Показать пункты меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Show();
//--- Показать разделительные линии
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Show();
//--- Сбросить цвет объектов
   ResetColors();
//--- Присвоить статус видимого элемента
   CElement::IsVisible(true);
//--- Состояние контекстного меню
   m_context_menu_state=true;
//--- Отметить состояние в предыдущем узле
   if(!m_free_context_menu)
      m_prev_node.ContextMenuState(true);
//--- Заблокируем форму
   m_wnd.IsLocked(true);
//--- Отправим сигнал на обнуление приоритетов на нажатие левой кнопкой мыши
   ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,CElement::Id(),0.0,"");
  }
//+------------------------------------------------------------------+
//| Скрывает контекстное меню                                        |
//+------------------------------------------------------------------+
void CContextMenu::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть объекты контекстного меню
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть пункты меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- Скрыть разделительные линии
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Hide();
//--- Обнулить фокус
   CElement::MouseFocus(false);
//--- Присвоить статус скрытого элемента
   CElement::IsVisible(false);
//--- Состояние контекстного меню
   m_context_menu_state=false;
//--- Отметить состояние в предыдущем узле
   if(!m_free_context_menu)
      m_prev_node.ContextMenuState(false);
//--- Отправим сигнал на восстановление приоритетов на нажатие левой кнопкой мыши
   ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CContextMenu::Reset(void)
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
void CContextMenu::Delete(void)
  {
//--- Удаление объектов  
   m_area.Delete();
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Delete();
//--- Удаление разделительных линий
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Delete();
//--- Освобождение массивов элемента
   ::ArrayFree(m_items);
   ::ArrayFree(m_sep_line);
   ::ArrayFree(m_sep_line_index);
   ::ArrayFree(m_label_text);
   ::ArrayFree(m_path_bmp_on);
   ::ArrayFree(m_path_bmp_off);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   m_context_menu_state=false;
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CContextMenu::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CContextMenu::ResetZorders(void)
  {
   m_area.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Сброс цвета объектов элемента                                    |
//+------------------------------------------------------------------+
void CContextMenu::ResetColors(void)
  {
//--- Пройтись по всем пунктам меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Сбросить цвет пункта меню
      m_items[i].ResetColors();
     }
  }
//+------------------------------------------------------------------+
//| Проверка условий на закрытие всех контекстных меню               |
//+------------------------------------------------------------------+
void CContextMenu::CheckHideContextMenus(void)
  {
//--- Выйти, если курсор в области контекстного меню или в области предыдущего узла
   if(CElement::MouseFocus() || m_prev_node.MouseFocus())
      return;
//--- Если же курсор вне области этих элементов, то ...
//    ... нужно проверить, есть ли открытые контекстные меню, которые были активированы после этого
//--- Для этого пройдёмся в цикле по списку этого контекстного меню ...
//    ... для определения наличия пункта, который содержит в себе контекстное меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Если такой пункт нашёлся, то нужно проверить, открыто ли его контекстное меню.
      //    Если оно открыто, то не нужно отсылать сигнал на закрытие всех контекстных меню из этого элемента, так как...
      //    ... возможно, что курсор находится в области следующего и нужно проверить там.
      if(m_items[i].TypeMenuItem()==MI_HAS_CONTEXT_MENU)
         if(m_items[i].ContextMenuState())
            return;
     }
//--- Разблокируем форму
   m_wnd.IsLocked(false);
//--- Послать сигнал на скрытие всех контекстных меню
   ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
  }
//+------------------------------------------------------------------+
//| Проверка условий на закрытие всех контекстных меню,              |
//| которые были открыты после этого                                 |
//+------------------------------------------------------------------+
void CContextMenu::CheckHideBackContextMenus(void)
  {
//--- Пройтись по всем пунктам меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Если пункт содержит контекстное меню и оно включено
      if(m_items[i].TypeMenuItem()==MI_HAS_CONTEXT_MENU && m_items[i].ContextMenuState())
        {
         //--- Если фокус в контекстном меню, но не в этом пункте
         if(CElement::MouseFocus() && !m_items[i].MouseFocus())
           {
            //--- Отправить сигнал на скрытие всех контекстных меню, которые были открыты после этого
            ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CContextMenu::ChangeObjectsColor(void)
  {
//--- Выйти, если контекстное меню отключено
   if(!m_context_menu_state)
      return;
//--- Пройтись по всем пунктам меню
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Изменить цвет пункта меню
      m_items[i].ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на пункт меню                                  |
//+------------------------------------------------------------------+
bool CContextMenu::OnClickMenuItem(const string clicked_object)
  {
//--- Выйдем, если это контекстное меню имеет предыдущий узел и уже открыто
   if(!m_free_context_menu && m_context_menu_state)
      return(true);
//--- Выйдем, если нажатие было не на пункте меню
   if(::StringFind(clicked_object,CElement::ProgramName()+"_menuitem_",0)<0)
      return(false);
//--- Получим идентификатор и индекс из имени объекта
   int id    =IdFromObjectName(clicked_object);
   int index =IndexFromObjectName(clicked_object);
//--- Если контекстное меню имеет предыдущий узел
   if(!m_free_context_menu)
     {
      //--- Выйдем, если нажали не на пункте, к которому это контекстное меню привязано
      if(id!=m_prev_node.Id() || index!=m_prev_node.Index())
         return(false);
      //--- Показать контекстное меню
      Show();
     }
//--- Если это свободное контекстное меню
   else
     {
      //--- Найдём в цикле пункт меню, на который нажали
      int total=ItemsTotal();
      for(int i=0; i<total; i++)
        {
         if(m_items[i].Object(0).Name()!=clicked_object)
            continue;
         //--- Отправим сообщение об этом
         ::EventChartCustom(m_chart_id,ON_CLICK_FREEMENU_ITEM,CElement::Id(),i,DescriptionByIndex(i));
         break;
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Приём сообщения от пункта меню для обработки                     |
//+------------------------------------------------------------------+
void CContextMenu::ReceiveMessageFromMenuItem(const int id_item,const int index_item,const string message_item)
  {
//--- Если есть признак сообщения этой программы и id элемента совпадает
   if(::StringFind(message_item,CElement::ProgramName(),0)>-1 && id_item==CElement::Id())
     {
      //--- Если нажатие было на радио-пункте
      if(::StringFind(message_item,"radioitem",0)>-1)
        {
         //--- Получим id радио-пункта из переданного сообщения
         int radio_id=RadioIdFromMessage(message_item);
         //--- Получим индекс радио-пункта по общему индексу
         int radio_index=RadioIndexByItemIndex(index_item);
         //--- Переключить радио-пункт
         SelectedRadioItem(radio_index,radio_id);
        }
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_CLICK_CONTEXTMENU_ITEM,id_item,index_item,DescriptionByIndex(index_item));
     }
//--- Скрытие контекстного меню
   Hide();
//--- Разблокируем форму
   m_wnd.IsLocked(false);
//--- Послать сигнал на скрытие всех контекстных меню
   ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CContextMenu::IdFromObjectName(const string object_name)
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
int CContextMenu::IndexFromObjectName(const string object_name)
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
//| Извлекает идентификатор из сообщения для радио-пункта            |
//+------------------------------------------------------------------+
int CContextMenu::RadioIdFromMessage(const string message)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- Получим код разделителя
   u_sep=::StringGetCharacter("_",0);
//--- Разобьём строку
   ::StringSplit(message,u_sep,result);
   array_size=::ArraySize(result);
//--- Если структура сообщения отличается от ожидаемой
   if(array_size!=3)
     {
      ::Print(__FUNCTION__," > Неправильная структура в сообщении для радио-пункта! message: ",message);
      return(WRONG_VALUE);
     }
//--- Предотвращение выхода за пределы массива
   if(array_size<3)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- Вернуть id радио-пункта
   return((int)result[2]);
  }
//+------------------------------------------------------------------+
//| Возвращает индекс радио-пункта по общему индексу                 |
//+------------------------------------------------------------------+
int CContextMenu::RadioIndexByItemIndex(const int index)
  {
   int radio_index=0;
//--- Получаем ID радио-пункта по общему индексу
   int radio_id=RadioItemIdByIndex(index);
//--- Счётчик пунктов из нужной группы
   int count_radio_id=0;
//--- Пройдёмся в цикле по списку
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Если это не радио-пункт, перейти к следующему
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- Если идентификаторы совпадают
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- Если индексы совпали, то 
         //    запомним текущее значение счётчика и закончим цикл
         if(m_items[i].Index()==index)
           {
            radio_index=count_radio_id;
            break;
           }
         //--- Увеличение счётчика
         count_radio_id++;
        }
     }
//--- Вернуть индекс
   return(radio_index);
  }
//+------------------------------------------------------------------+
