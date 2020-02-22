//+------------------------------------------------------------------+
//|                                                     ListView.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| Класс для создания списка                                        |
//+------------------------------------------------------------------+
class CListView : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Указатель на элемент, управляющий видимостью списка
   CElement         *m_combobox;
   //--- Объекты для создания списка
   CRectLabel        m_area;
   CEdit             m_items[];
   CScrollV          m_scrollv;
   //--- Массив значений списка
   string            m_value_items[];
   //--- Размер списка и его видимой части
   int               m_items_total;
   int               m_visible_items_total;
   //--- (1) Индекс и (2) текст выбранного пункта
   int               m_selected_item_index;
   string            m_selected_item_text;
   //--- Свойства фона списка
   int               m_area_zorder;
   color             m_area_border_color;
   //--- Свойства пунктов списка
   int               m_item_zorder;
   int               m_item_y_size;
   color             m_item_color;
   color             m_item_color_hover;
   color             m_item_color_selected;
   color             m_item_text_color;
   color             m_item_text_color_hover;
   color             m_item_text_color_selected;
   //--- Режим выравнивания текста в списке
   ENUM_ALIGN_MODE   m_align_mode;
   //--- Режим подсветки при наведении курсора
   bool              m_lights_hover;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //---
public:
                     CListView(void);
                    ~CListView(void);
   //--- Методы для создания списка
   bool              CreateListView(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateList(void);
   bool              CreateScrollV(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) сохраняет указатель на комбо-бокс, (3) возвращает указатель на полосу прокрутки
   void              WindowPointer(CWindow &object)                      { m_wnd=::GetPointer(object);      }
   void              ComboBoxPointer(CElement &object)                   { m_combobox=::GetPointer(object); }
   CScrollV         *GetScrollVPointer(void)                             { return(::GetPointer(m_scrollv)); }
   //--- (1) Высота пункта, возвращает (2) размер списка и (3) видимой его части
   void              ItemYSize(const int y_size)                         { m_item_y_size=y_size;            }
   int               ItemsTotal(void)                              const { return(m_items_total);           }
   int               VisibleItemsTotal(void)                       const { return(m_visible_items_total);   }
   //--- Состояние полосы прокрутки
   bool              ScrollState(void)                             const { return(m_scrollv.ScrollState()); }
   //--- (1) Цвет рамки фона, (2) режим подсветки пунктов при наведении, (3) режим выравнивания текста
   void              AreaBorderColor(const color clr)                    { m_area_border_color=clr;         }
   void              LightsHover(const bool state)                       { m_lights_hover=state;            }
   void              TextAlign(const ENUM_ALIGN_MODE align_mode)         { m_align_mode=align_mode;         }
   //--- Цвета пунктов списка в разных состояниях
   void              ItemColor(const color clr)                          { m_item_color=clr;                }
   void              ItemColorHover(const color clr)                     { m_item_color_hover=clr;          }
   void              ItemColorSelected(const color clr)                  { m_item_color_selected=clr;       }
   void              ItemTextColor(const color clr)                      { m_item_text_color=clr;           }
   void              ItemTextColorHover(const color clr)                 { m_item_text_color_hover=clr;     }
   void              ItemTextColorSelected(const color clr)              { m_item_text_color_selected=clr;  }
   //--- Возвращает/cохраняет (1) индекс и (2) текст выделенного пункта в списке
   void              SelectedItemByIndex(const int index);
   int               SelectedItemIndex(void)                       const { return(m_selected_item_index);   }
   string            SelectedItemText(void)                        const { return(m_selected_item_text);    }
   //--- Установка значения в список по указанному индексу ряда
   void              ValueToList(const int item_index,const string value);
   //--- Установка (1) размера списка и (2) видимой его части
   void              ListSize(const int items_total);
   void              VisibleListSize(const int visible_items_total);
   //--- (1) Сброс цвета пунктов списка, (2) изменение цвета пунктов списка при наведении
   void              ResetItemsColor(void);
   void              ChangeItemsColor(const int x,const int y);
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
   //--- Обработка нажатия на пункте списка
   bool              OnClickListItem(const string clicked_object);
   //--- Получение идентификатора из имени пункта списка
   int               IdFromObjectName(const string object_name);
   //--- Смещение списка
   void              ShiftList(void);
   //--- Подсветка выбранного пункта
   void              HighlightSelectedItem(void);
   //--- Ускоренная перемотка списка
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CListView::CListView(void) : m_item_y_size(18),
                             m_mouse_state(false),
                             m_lights_hover(false),
                             m_align_mode(ALIGN_LEFT),
                             m_items_total(2),
                             m_visible_items_total(2),
                             m_selected_item_index(WRONG_VALUE),
                             m_selected_item_text(""),
                             m_area_border_color(C'235,235,235'),
                             m_item_color(clrWhite),
                             m_item_color_hover(C'240,240,240'),
                             m_item_color_selected(C'51,153,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_hover(clrBlack),
                             m_item_text_color_selected(clrWhite)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder =1;
   m_item_zorder =2;
//--- Установим размер списка и его видимой части
   ListSize(m_items_total);
   VisibleListSize(m_visible_items_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CListView::~CListView(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CListView::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- Проверка фокуса над списком
      CElement::MouseFocus(x>CElement::X() && x<CElement::X2() && 
                           y>CElement::Y() && y<CElement::Y2());
      //--- Если это выпадающий список и кнопка мыши нажата
      if(CElement::IsDropdown() && m_mouse_state)
        {
         //--- Если курсор вне комбо-бокса, курсор вне списка и не в режиме скролла
         if(!m_combobox.MouseFocus() && !CElement::MouseFocus() && !m_scrollv.ScrollState())
           {
            //--- Спрятать список
            Hide();
            return;
           }
        }
      //--- Смещаем список, если управление ползунком полосы прокрутки в действии
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state))
         ShiftList();
      //--- Изменяет цвет строк списка при наведении
      ChangeItemsColor(x,y);
      return;
     }
//--- Обработка нажатия на объектах
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Если было нажатие на элементе списка
      if(OnClickListItem(sparam))
        {
         //--- Подсветка строки
         HighlightSelectedItem();
         return;
        }
      //--- Если было нажатие на кнопках полосы прокрутки списка
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam))
        {
         //--- Сдвигает список относительно полосы прокрутки
         ShiftList();
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CListView::OnEventTimer(void)
  {
//--- Если элемент выпадающий
   if(CElement::IsDropdown())
      //--- Перемотка списка
      FastSwitching();
//--- Если элемент не выпадающий, то учитываем доступность формы в текущий момент
   else
     {
      //--- Отслеживаем перемотку списка, только если форма не заблокирована
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт список                                                   |
//+------------------------------------------------------------------+
bool CListView::CreateListView(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием списка классу нужно передать "
              "указатель на форму: CListView::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Если список выпадающий, значит нужен указатель на комбо-бокс, к которому он будет привязан
   if(CElement::IsDropdown())
     {
      //--- Выйти, если нет указателя на комбо-бокс
      if(::CheckPointer(m_combobox)==POINTER_INVALID)
        {
         ::Print(__FUNCTION__," > Перед созданием выпадающего списка классу нужно передать "
                 "указатель на комбо-бокс: CListView::ComboBoxPointer(CElement &object)");
         return(false);
        }
     }
//--- Инициализация переменных
   m_id                  =m_wnd.LastId()+1;
   m_chart_id            =chart_id;
   m_subwin              =subwin;
   m_x                   =x;
   m_y                   =y;
   m_y_size              =m_item_y_size*m_visible_items_total-(m_visible_items_total-1)+2;
   m_selected_item_index =(m_selected_item_index==WRONG_VALUE) ? 0 : m_selected_item_index;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание кнопки
   if(!CreateArea())
      return(false);
   if(!CreateList())
      return(false);
   if(!CreateScrollV())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон для списка                                           |
//+------------------------------------------------------------------+
bool CListView::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_listview_area_"+(string)CElement::Id();
//--- Создание объекта
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установка свойств
   m_area.BackColor(m_item_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Сохраним координаты
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- Сохраним размеры
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
//--- Отступы от крайней точки
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт пункты списка                                            |
//+------------------------------------------------------------------+
bool CListView::CreateList(void)
  {
//--- Координаты
   int x =CElement::X()+1;
   int y =0;
//--- Расчёт ширины пунктов списка
   int w=(m_items_total>m_visible_items_total) ? CElement::XSize()-m_scrollv.ScrollWidth() : CElement::XSize()-2;
//---
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Формирование имени объекта
      string name=CElement::ProgramName()+"_listview_edit_"+(string)i+"__"+(string)CElement::Id();
      //--- Расчёт координаты Y
      y=(i>0) ? y+m_item_y_size-1 : CElement::Y()+1;
      //--- Создание объекта
      if(!m_items[i].Create(m_chart_id,name,m_subwin,x,y,w,m_item_y_size))
         return(false);
      //--- Установка свойств
      m_items[i].Description(m_value_items[i]);
      m_items[i].TextAlign(m_align_mode);
      m_items[i].Font(FONT);
      m_items[i].FontSize(FONT_SIZE);
      m_items[i].Color(m_item_text_color);
      m_items[i].BackColor(m_item_color);
      m_items[i].BorderColor(m_item_color);
      m_items[i].Corner(m_corner);
      m_items[i].Anchor(m_anchor);
      m_items[i].Selectable(false);
      m_items[i].Z_Order(m_item_zorder);
      m_items[i].ReadOnly(true);
      m_items[i].Tooltip("\n");
      //--- Координаты
      m_items[i].X(x);
      m_items[i].Y(y);
      //--- Размеры
      m_items[i].XSize(w);
      m_items[i].YSize(m_item_y_size);
      //--- Отступы от крайней точки панели
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- Сохраним указатель объекта
      CElement::AddToArray(m_items[i]);
     }
//--- Подсветка выделенного пункта
   HighlightSelectedItem();
//--- Сдвигает список относительно полосы прокрутки
   ShiftList();
//--- Сохраним текст выделенного пункта
   m_selected_item_text=m_value_items[m_selected_item_index];
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вертикальный скролл                                      |
//+------------------------------------------------------------------+
bool CListView::CreateScrollV(void)
  {
//--- Если количество пунктов больше, чем размер списка, то
//    установим вертикальный скроллинг
   if(m_items_total<=m_visible_items_total)
      return(true);
//--- Сохранить указатель формы
   m_scrollv.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X()+m_area.X_Size()-m_scrollv.ScrollWidth();
   int y=CElement::Y();
//--- Установим свойства
   m_scrollv.Id(CElement::Id());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(CElement::YSize());
   m_scrollv.AreaBorderColor(m_area_border_color);
   m_scrollv.IsDropdown(CElement::IsDropdown());
//--- Создание полосы прокрутки
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_items_total,m_visible_items_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохранение индекса                                               |
//+------------------------------------------------------------------+
void CListView::SelectedItemByIndex(const int index)
  {
//--- Корректировка в случае выхода из диапазона
   m_selected_item_index=(index>=m_items_total)? m_items_total-1 :(index<0)? 0 : index;
//--- Подсветка выделенного пункта
   HighlightSelectedItem();
//--- Сдвигает список относительно полосы прокрутки
   ShiftList();
//--- Сохраним текст выделенного пункта
   m_selected_item_text=m_value_items[m_selected_item_index];
  }
//+------------------------------------------------------------------+
//| Сохраняет переданное значение в списке по указанному индексу     |
//+------------------------------------------------------------------+
void CListView::ValueToList(const int item_index,const string value)
  {
   int array_size=::ArraySize(m_value_items);
//--- Если нет ни одного пункта в контекстном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в списке есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(item_index>=array_size)? array_size-1 :(item_index<0)? 0 : item_index;
//--- Сохраним значение в списке
   m_value_items[i]=value;
  }
//+------------------------------------------------------------------+
//| Устанавливает размер списка                                      |
//+------------------------------------------------------------------+
void CListView::ListSize(const int items_total)
  {
//--- Не имеет смысла делать список менее двух пунктов
   m_items_total=(items_total<2) ? 2 : items_total;
   ::ArrayResize(m_value_items,m_items_total);
  }
//+------------------------------------------------------------------+
//| Устанавливает размер видимой части списка                        |
//+------------------------------------------------------------------+
void CListView::VisibleListSize(const int visible_items_total)
  {
//--- Не имеет смысла делать список менее двух пунктов
   m_visible_items_total=(visible_items_total<2) ? 2 : visible_items_total;
   ::ArrayResize(m_items,m_visible_items_total);
  }
//+------------------------------------------------------------------+
//| Сброс цвета пунктов списка                                       |
//+------------------------------------------------------------------+
void CListView::ResetItemsColor(void)
  {
//--- Получим текущую позицию ползунка полосы прокрутки
   int v=m_scrollv.CurrentPos();
//--- Идём в цикле по видимой части списка
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Увеличим счётчик, если внутри диапазона списка
      if(v>=0 && v<m_items_total)
         v++;
      //--- Пропускаем выделенный пункт
      if(m_selected_item_index==v-1)
         continue;
      //--- Установка цвета (фон, текст)
      m_items[i].BackColor(m_item_color);
      m_items[i].Color(m_item_text_color);
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета строки списка при наведении курсора              |
//+------------------------------------------------------------------+
void CListView::ChangeItemsColor(const int x,const int y)
  {
//--- Выйдем, если отключена подсветка при наведении курсора или прокрутка списка активна
   if(!m_lights_hover || m_scrollv.ScrollState())
      return;
//--- Выйдем, если элемент не выпадающий и форма заблокирована
   if(!CElement::IsDropdown() && m_wnd.IsLocked())
      return;
//--- Получим текущую позицию ползунка полосы прокрутки
   int v=m_scrollv.CurrentPos();
//--- Определим, над каким пунктом сейчас находится курсор и подсветим его
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Увеличим счётчик, если внутри диапазона списка
      if(v>=0 && v<m_items_total)
         v++;
      //--- Пропускаем выделенный пункт
      if(m_selected_item_index==v-1)
        {
         m_items[i].BackColor(m_item_color_selected);
         m_items[i].Color(m_item_text_color_selected);
         continue;
        }
      //--- Если курсор над этим пунктом, то подсветим его
      if(x>m_items[i].X() && x<m_items[i].X2() && y>m_items[i].Y() && y<m_items[i].Y2())
        {
         m_items[i].BackColor(m_item_color_hover);
         m_items[i].Color(m_item_text_color_hover);
        }
      //--- Если курсор не над этим пунктом, то сделаем соответствующий этому состоянию цвет
      else
        {
         m_items[i].BackColor(m_item_color);
         m_items[i].Color(m_item_text_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| Сдвигает список относительно полосы прокрутки                    |
//+------------------------------------------------------------------+
void CListView::ShiftList(void)
  {
//--- Получим текущую позицию ползунка полосы прокрутки
   int v=m_scrollv.CurrentPos();
//--- Идём в цикле по видимой части списка
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Если внутри диапазона списка
      if(v>=0 && v<m_items_total)
        {
         //--- Смещение текста, цвета фона и цвета текста
         m_items[i].Description(m_value_items[v]);
         m_items[i].BackColor((m_selected_item_index==v) ? m_item_color_selected : m_item_color);
         m_items[i].Color((m_selected_item_index==v) ? m_item_text_color_selected : m_item_text_color);
         //--- Увеличим счётчик
         v++;
        }
     }
  }
//+------------------------------------------------------------------+
//| Выделяет выбранный пункт                                         |
//+------------------------------------------------------------------+
void CListView::HighlightSelectedItem(void)
  {
//--- Выйдем, если полоса прокрутки в активном режиме
   if(m_scrollv.ScrollState())
      return;
//--- Получим текущую позицию ползунка полосы прокрутки
   int v=m_scrollv.CurrentPos();
//--- Идём в цикле по видимой части списка
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Если внутри диапазона списка
      if(v>=0 && v<m_items_total)
        {
         //--- Изменение цвета фона и цвета текста
         m_items[i].BackColor((m_selected_item_index==v) ? m_item_color_selected : m_item_color);
         m_items[i].Color((m_selected_item_index==v) ? m_item_text_color_selected : m_item_text_color);
         //--- Увеличим счётчик
         v++;
        }
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CListView::Moving(const int x,const int y)
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
//--- Обновление координат графических объектов   
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//---
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- Сохранение координат в полях объектов
      m_items[r].X(x+m_items[r].XGap());
      m_items[r].Y(y+m_items[r].YGap());
      //--- Обновление координат графических объектов
      m_items[r].X_Distance(m_items[r].X());
      m_items[r].Y_Distance(m_items[r].Y());
     }
  }
//+------------------------------------------------------------------+
//| Показывает список                                                |
//+------------------------------------------------------------------+
void CListView::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Показать полосу прокрутки
   m_scrollv.Show();
//--- Состояние видимости
   CElement::IsVisible(true);
//--- Отправим сигнал на обнуление приоритетов на нажатие левой кнопкой мыши
   if(CElement::IsDropdown())
      ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,m_id,0.0,"");
  }
//+------------------------------------------------------------------+
//| Скрывает список                                                  |
//+------------------------------------------------------------------+
void CListView::Hide(void)
  {
   if(!m_wnd.IsMinimized())
      if(!CElement::IsDropdown())
         if(!CElement::IsVisible())
            return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть полосу прокрутки
   m_scrollv.Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
//--- Отправим сигнал на восстановление приоритетов на нажатие левой кнопкой мыши
   if(!m_wnd.IsMinimized())
      ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CListView::Reset(void)
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
void CListView::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   for(int r=0; r<m_visible_items_total; r++)
      m_items[r].Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CListView::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_scrollv.SetZorders();
   for(int i=0; i<m_visible_items_total; i++)
      m_items[i].Z_Order(m_item_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CListView::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_scrollv.ResetZorders();
   for(int i=0; i<m_visible_items_total; i++)
      m_items[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на пункте списка                               |
//+------------------------------------------------------------------+
bool CListView::OnClickListItem(const string clicked_object)
  {
//--- Выйти, если форма заблокирована и идентификаторы не совпадают
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- Выйдем, если полоса прокрутки в активном режиме
   if(m_scrollv.ScrollState())
      return(false);
//--- Выйдем, если нажатие было не на пункте меню
   if(::StringFind(clicked_object,CElement::ProgramName()+"_listview_edit_",0)<0)
      return(false);
//--- Получим идентификатор и индекс из имени объекта
   int id=IdFromObjectName(clicked_object);
//--- Выйти, если идентификатор не совпадает
   if(id!=CElement::Id())
      return(false);
//--- Получим текущую позицию ползунка полосы прокрутки
   int v=m_scrollv.CurrentPos();
//--- Пройдёмся по видимой части списка
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Если выбран этот пункт в списке
      if(m_items[i].Name()==clicked_object)
        {
         m_selected_item_index =v;
         m_selected_item_text  =m_value_items[v];
        }
      //--- Если внутри диапазона списка
      if(v>=0 && v<m_items_total)
         //--- Увеличим счётчик
         v++;
     }
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_LIST_ITEM,CElement::Id(),0,m_selected_item_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CListView::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
//| Ускоренная перемотка списка                                      |
//+------------------------------------------------------------------+
void CListView::FastSwitching(void)
  {
//--- Выйдем, если нет фокуса на списке
   if(!CElement::MouseFocus())
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
      //--- Если прокрутка вверх
      if(m_scrollv.ScrollIncState())
         m_scrollv.OnClickScrollInc(m_scrollv.ScrollIncName());
      //--- Если прокрутка вниз
      else if(m_scrollv.ScrollDecState())
         m_scrollv.OnClickScrollDec(m_scrollv.ScrollDecName());
      //--- Смещает список
      ShiftList();
     }
  }
//+------------------------------------------------------------------+
