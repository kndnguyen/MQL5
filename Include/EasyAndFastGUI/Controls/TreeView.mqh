//+------------------------------------------------------------------+
//|                                                     TreeView.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "TreeItem.mqh"
#include "Scrolls.mqh"
#include "Pointer.mqh"
//+------------------------------------------------------------------+
//| Класс для создания древовидного списка                           |
//+------------------------------------------------------------------+
class CTreeView : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания элемента
   CRectLabel        m_area;
   CRectLabel        m_content_area;
   CTreeItem         m_items[];
   CTreeItem         m_content_items[];
   CScrollV          m_scrollv;
   CScrollV          m_content_scrollv;
   CPointer          m_x_resize;
   //--- Структура элементов закреплённых за каждым пунктом-вкладкой
   struct TVElements
     {
      CElement         *elements[];
      int               list_index;
     };
   TVElements        m_tab_items[];
   //--- Массивы для всех пунктов древовидного списка (полный список)
   int               m_t_list_index[];
   int               m_t_prev_node_list_index[];
   string            m_t_item_text[];
   string            m_t_path_bmp[];
   int               m_t_item_index[];
   int               m_t_node_level[];
   int               m_t_prev_node_item_index[];
   int               m_t_items_total[];
   int               m_t_folders_total[];
   bool              m_t_item_state[];
   bool              m_t_is_folder[];
   //--- Массивы для списка отображаемых пунктов древовидного списка
   int               m_td_list_index[];
   //--- Массивы для списка содержания пунктов выделенных в древовидном списке (полный список)
   int               m_c_list_index[];
   int               m_c_tree_list_index[];
   string            m_c_item_text[];
   //--- Массивы для списка отображаемых пунктов в списке содержания
   int               m_cd_list_index[];
   int               m_cd_tree_list_index[];
   string            m_cd_item_text[];
   //--- Общее количество пунктов и количество в видимой части списков
   int               m_items_total;
   int               m_content_items_total;
   int               m_visible_items_total;
   //--- Индексы выделенных пунктов в списках
   int               m_selected_item_index;
   int               m_selected_content_item_index;
   //--- Текст выделенного пункта в списке. 
   //    Только для файлов в случае использования класса для создания файлового навигатора.
   //    Если в списке выбран не файл, то в этом поле должна быть пустая строка "".
   string            m_selected_item_file_name;
   //--- Ширина области древовидного списка
   int               m_treeview_area_width;
   //--- Цвет фона и рамки фона
   color             m_area_color;
   color             m_area_border_color;
   //--- Ширина области содержания
   int               m_content_area_width;
   //--- Высота пунктов
   int               m_item_y_size;
   //--- Цвета пунктов в разных состояниях
   color             m_item_back_color_hover;
   color             m_item_back_color_selected;
   //--- Цвета текста в разных состояниях
   color             m_item_text_color;
   color             m_item_text_color_hover;
   color             m_item_text_color_selected;
   //--- Картинки для стрелок
   string            m_item_arrow_file_on;
   string            m_item_arrow_file_off;
   string            m_item_arrow_selected_file_on;
   string            m_item_arrow_selected_file_off;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_zorder;
   //--- Режим файлового навигатора
   ENUM_FILE_NAVIGATOR_MODE m_file_navigator_mode;
   //--- Режим подсветки при наведении курсора
   bool              m_lights_hover;
   //--- Режим показа содержания пункта в рабочей области
   bool              m_show_item_content;
   //--- Режим изменения ширины списков
   bool              m_resize_list_area_mode;
   //--- Режим пунктов-вкладок
   bool              m_tab_items_mode;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //--- (1) Минимальный и (2) максимальный уровень узла
   int               m_min_node_level;
   int               m_max_node_level;
   //--- Количество пунктов в корневом каталоге
   int               m_root_items_total;
   //---
public:
                     CTreeView(void);
                    ~CTreeView(void);
   //--- Методы для создания древовидного списка
   bool              CreateTreeView(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateContentArea(void);
   bool              CreateItems(void);
   bool              CreateScrollV(void);
   bool              CreateContentItems(void);
   bool              CreateContentScrollV(void);
   bool              CreateXResizePointer(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) указатели полос прокрутки списков
   void              WindowPointer(CWindow &object)                     { m_wnd=::GetPointer(object);               }
   CScrollV         *GetScrollVPointer(void)                            { return(::GetPointer(m_scrollv));          }
   CScrollV         *GetContentScrollVPointer(void)                     { return(::GetPointer(m_content_scrollv));  }
   //--- Возвращает (1) указатель пункта древовидного списка, (2) указатель пункта списка содержания, 
   CTreeItem        *ItemPointer(const int index);
   CTreeItem        *ContentItemPointer(const int index);
   //--- (1) Режим файлового навигатора, (2) режим подсветки при наведении курсора мыши, 
   //    (3) режим показа содержания пункта, (4) режим изменения ширины списков, (5) режим пунктов-вкладок
   void              NavigatorMode(const ENUM_FILE_NAVIGATOR_MODE mode) { m_file_navigator_mode=mode;               }
   void              LightsHover(const bool state)                      { m_lights_hover=state;                     }
   void              ShowItemContent(const bool state)                  { m_show_item_content=state;                }
   void              ResizeListAreaMode(const bool state)               { m_resize_list_area_mode=state;            }
   void              TabItemsMode(const bool state)                     { m_tab_items_mode=state;                   }
   //--- Количество пунктов (1) в древовидном списке, (2) в списке содержания и (3) видимое количество пунктов
   int               ItemsTotal(void)                             const { return(::ArraySize(m_items));             }
   int               ContentItemsTotal(void)                      const { return(::ArraySize(m_content_items));     }
   void              VisibleItemsTotal(const int total)                 { m_visible_items_total=total;              }
   //--- (1) Высота пункта, (2) ширина древовидного списка и (3) списка содержания
   void              ItemYSize(const int y_size)                        { m_item_y_size=y_size;                     }
   void              TreeViewAreaWidth(const int x_size)                { m_treeview_area_width=x_size;             }
   void              ContentAreaWidth(const int x_size)                 { m_content_area_width=x_size;              }
   //--- Цвет фона и рамки фона элемента
   void              AreaBackColor(const color clr)                     { m_area_color=clr;                         }
   void              AreaBorderColor(const color clr)                   { m_area_border_color=clr;                  }
   //--- Цвета пунктов в разных состояниях
   void              ItemBackColorHover(const color clr)                { m_item_back_color_hover=clr;              }
   void              ItemBackColorSelected(const color clr)             { m_item_back_color_selected=clr;           }
   //--- Цвета текста в разных состояниях
   void              ItemTextColor(const color clr)                     { m_item_text_color=clr;                    }
   void              ItemTextColorHover(const color clr)                { m_item_text_color_hover=clr;              }
   void              ItemTextColorSelected(const color clr)             { m_item_text_color_selected=clr;           }
   //--- Картинки для стрелки пункта
   void              ItemArrowFileOn(const string file_path)            { m_item_arrow_file_on=file_path;           }
   void              ItemArrowFileOff(const string file_path)           { m_item_arrow_file_off=file_path;          }
   void              ItemArrowSelectedFileOn(const string file_path)    { m_item_arrow_selected_file_on=file_path;  }
   void              ItemArrowSelectedFileOff(const string file_path)   { m_item_arrow_selected_file_off=file_path; }
   //--- (1) Выделяет пункт по индексу и (2) возвращает индекс выделенного пункта, (3) возвращает название файла
   void              SelectedItemIndex(const int index)                 { m_selected_item_index=index;              }
   int               SelectedItemIndex(void)                      const { return(m_selected_item_index);            }
   string            SelectedItemFileName(void)                   const { return(m_selected_item_file_name);        }

   //--- Добавляет пункт в древовидный список
   void              AddItem(const int list_index,const int list_id,const string item_name,const string path_bmp,const int item_index,
                             const int node_number,const int item_number,const int items_total,const int folders_total,const bool item_state,const bool is_folder=true);
   //--- Добавляет элемент в массив пункта-вкладки
   void              AddToElementsArray(const int item_index,CElement &object);
   //--- Показать элементы только выделенного пункта-вкладки
   void              ShowTabElements(void);
   //--- Возвращает полный путь выделенного пункта
   string            CurrentFullPath(void);
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
   //--- Обработка нажатия на кнопке сворачивания/разворачивания списка пункта
   bool              OnClickItemArrow(const string clicked_object);
   //--- Обработка нажатия на пункте древовидного списка
   bool              OnClickItem(const string clicked_object);
   //--- Обработка нажатия на пункте в списке содержания
   bool              OnClickContentListItem(const string clicked_object);
   //--- Получение (1) идентификатора и (2) индекса из имени пункта меню
   int               IdFromObjectName(const string object_name);
   int               IndexFromObjectName(const string object_name);

   //--- Формирует массив пунктов-вкладок
   void              GenerateTabItemsArray(void);
   //--- Определение и установка (1) границ узлов и (2) размера корневого каталога
   void              SetNodeLevelBoundaries(void);
   void              SetRootItemsTotal(void);
   //--- Смещение списков
   void              ShiftTreeList(void);
   void              ShiftContentList(void);
   //--- Ускоренная перемотка списка
   void              FastSwitching(void);

   //--- Управляет шириной списков
   void              ResizeListArea(const int x,const int y);
   //--- Проверка готовности для изменения ширины списков
   void              CheckXResizePointer(const int x,const int y);
   //--- Проверка на выход за ограничения
   bool              CheckOutOfArea(const int x,const int y);
   //--- Обновление ширины древовидного списка
   void              UpdateTreeListWidth(const int x);
   //--- Обновление ширины списка в области содержания
   void              UpdateContentListWidth(const int x);

   //--- Добавляет пункт в список в области содержания
   void              AddDisplayedTreeItem(const int list_index);
   //--- Обновляет (1) двевовидный список и (2) список содержания
   void              UpdateTreeViewList(void);
   void              UpdateContentList(void);
   //--- Перерисовка древовидного списка
   void              RedrawTreeList(void);

   //--- Проверка индекса выделенного пункта на выход из диапазона
   void              CheckSelectedItemIndex(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTreeView::CTreeView(void) : m_treeview_area_width(180),
                             m_content_area_width(WRONG_VALUE),
                             m_item_y_size(20),
                             m_visible_items_total(13),
                             m_tab_items_mode(false),
                             m_lights_hover(false),
                             m_show_item_content(true),
                             m_resize_list_area_mode(false),
                             m_selected_item_index(WRONG_VALUE),
                             m_selected_content_item_index(WRONG_VALUE),
                             m_area_color(clrWhite),
                             m_area_border_color(clrLightGray),
                             m_item_back_color_hover(C'240,240,240'),
                             m_item_back_color_selected(C'51,153,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_hover(clrBlack),
                             m_item_text_color_selected(clrWhite),
                             m_item_arrow_file_on(""),
                             m_item_arrow_file_off(""),
                             m_item_arrow_selected_file_on(""),
                             m_item_arrow_selected_file_off("")
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder=0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTreeView::~CTreeView(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CTreeView::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- Смещаем древовидный список, если управление ползунком полосы прокрутки в действии
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state))
        {
         ShiftTreeList();
         return;
        }
      //--- Заходим, только если есть список
      if(m_t_items_total[m_selected_item_index]>0)
        {
         //--- Смещаем список содержания, если управление ползунком полосы прокрутки в действии
         if(m_content_scrollv.ScrollBarControl(x,y,m_mouse_state))
           {
            ShiftContentList();
            return;
           }
        }
      //--- Управление шириной области содержания
      ResizeListArea(x,y);
      //--- Выйти, если форма заблокирована
      if(m_wnd.IsLocked())
         return;
      //--- Изменение цвета по наведению курсора мыши
      ChangeObjectsColor();
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Выйти, если в режиме измененения размера области списка содержания
      if(m_x_resize.IsVisible() || m_x_resize.State())
         return;
      //--- Обработка нажатия на стрелке пункта
      if(OnClickItemArrow(sparam))
         return;
      //--- Обработка нажатия на пункте древовидного списка
      if(OnClickItem(sparam))
         return;
      //--- Обработка нажатия на пункте в списке содержания
      if(OnClickContentListItem(sparam))
         return;
      //--- Сдвигает список относительно полосы прокрутки
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam))
         ShiftTreeList();
      if(m_content_scrollv.OnClickScrollInc(sparam) || m_content_scrollv.OnClickScrollDec(sparam))
         ShiftContentList();
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CTreeView::OnEventTimer(void)
  {
//--- Если элемент выпадающий
   if(CElement::IsDropdown())
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
  }
//+------------------------------------------------------------------+
//| Создаёт контекстное меню                                         |
//+------------------------------------------------------------------+
bool CTreeView::CreateTreeView(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием древовидного списка ему нужно передать "
              "указатель на форму: CTreeView::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
   m_y_size   =m_item_y_size*m_visible_items_total+2-(m_visible_items_total-1);
//--- Проверка индекса выделенного пункта на выход из диапазона
   CheckSelectedItemIndex();
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание элемента
   if(!CreateArea())
      return(false);
   if(!CreateContentArea())
      return(false);
   if(!CreateItems())
      return(false);
   if(!CreateScrollV())
      return(false);
   if(!CreateContentItems())
      return(false);
   if(!CreateContentScrollV())
      return(false);
   if(!CreateXResizePointer())
      return(false);
//--- Сформируем массив пунктов-вкладок
   GenerateTabItemsArray();
//--- Определение и установка (1) границ узлов и (2) размера корневого каталога
   SetNodeLevelBoundaries();
   SetRootItemsTotal();
//--- Обновить списки
   UpdateTreeViewList();
   UpdateContentList();
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//--- Отправить сообщение для формирования директории в файловом редакторе
   ::EventChartCustom(m_chart_id,ON_CHANGE_TREE_PATH,0,0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон для списка                                           |
//+------------------------------------------------------------------+
bool CTreeView::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_treeview_area_"+(string)CElement::Id();
//--- Создание объекта
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_treeview_area_width,m_y_size))
      return(false);
//--- Установка свойств
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- Сохраним размеры
   m_area.XSize(m_treeview_area_width);
   m_area.YSize(CElement::YSize());
//--- Сохраним координаты
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      m_area.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон для содержания пункта                                |
//+------------------------------------------------------------------+
bool CTreeView::CreateContentArea(void)
  {
//--- Выйти, если область содержания не нужна
   if(m_content_area_width<0)
     {
      //--- Сохраним общую ширину элемента и выйдем
      CElement::XSize(m_treeview_area_width);
      return(true);
     }
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_treeview_content_area_"+(string)CElement::Id();
//--- Координаты
   int x=m_area.X2()-1;
   int y=CElement::Y();
//--- Размер по оси X
   m_content_area_width=(m_content_area_width!=0)? m_content_area_width : m_wnd.X2()-m_area.X2()-1;
//--- Сохраним общую ширину элемента
   CElement::XSize(m_treeview_area_width+m_content_area_width-1);
//--- Создание объекта
   if(!m_content_area.Create(m_chart_id,name,m_subwin,x,y,m_content_area_width,m_y_size))
      return(false);
//--- Установка свойств
   m_content_area.BackColor(m_area_color);
   m_content_area.Color(m_area_border_color);
   m_content_area.BorderType(BORDER_FLAT);
   m_content_area.Corner(m_corner);
   m_content_area.Selectable(false);
   m_content_area.Z_Order(m_zorder);
   m_content_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_content_area.XGap(x-m_wnd.X());
   m_content_area.YGap(CElement::Y()-m_wnd.Y());
//--- Сохраним размеры
   m_content_area.XSize(m_content_area_width);
   m_content_area.YSize(CElement::YSize());
//--- Сохраним координаты
   m_content_area.X(x);
   m_content_area.Y(CElement::Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_content_area);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      m_content_area.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт древовидный список                                       |
//+------------------------------------------------------------------+
bool CTreeView::CreateItems(void)
  {
//--- Координаты
   int x =CElement::X()+1;
   int y =CElement::Y()+1;
//---
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- Расчёт координаты Y
      y=(i>0)? y+m_item_y_size-1 : y;
      //--- Передадим указатель формы
      m_items[i].WindowPointer(m_wnd);
      //--- Установим свойства перед созданием
      m_items[i].Index(0);
      m_items[i].Id(CElement::Id());
      m_items[i].XSize(CElement::XSize());
      m_items[i].YSize(m_item_y_size);
      m_items[i].IconFile(m_t_path_bmp[i]);
      m_items[i].ItemBackColor(m_area_color);
      m_items[i].ItemBackColorHover(m_item_back_color_hover);
      m_items[i].ItemBackColorSelected(m_item_back_color_selected);
      m_items[i].ItemTextColor(m_item_text_color);
      m_items[i].ItemTextColorHover(m_item_text_color_hover);
      m_items[i].ItemTextColorSelected(m_item_text_color_selected);
      m_items[i].ItemArrowFileOn(m_item_arrow_file_on);
      m_items[i].ItemArrowFileOff(m_item_arrow_file_off);
      m_items[i].ItemArrowSelectedFileOn(m_item_arrow_selected_file_on);
      m_items[i].ItemArrowSelectedFileOff(m_item_arrow_selected_file_off);
      //--- Определим тип пункта
      ENUM_TYPE_TREE_ITEM type=TI_SIMPLE;
      if(m_file_navigator_mode==FN_ALL)
         type=(m_t_items_total[i]>0)? TI_HAS_ITEMS : TI_SIMPLE;
      else // FN_ONLY_FOLDERS
      type=(m_t_folders_total[i]>0)? TI_HAS_ITEMS : TI_SIMPLE;
      //--- Корректировка начального состояния пункта
      m_t_item_state[i]=(type==TI_HAS_ITEMS)? m_t_item_state[i]: false;
      //--- Отступы от крайней точки панели
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- Создание элемента
      if(!m_items[i].CreateTreeItem(m_chart_id,m_subwin,x,y,type,
         m_t_list_index[i],m_t_node_level[i],m_t_item_text[i],m_t_item_state[i]))
         return(false);
      //--- Установить цвет выделенному пункту
      if(i==m_selected_item_index)
         m_items[i].HighlightItemState(true);
      //--- Скрыть элемент
      m_items[i].Hide();
      //--- Пункт будет выпалающим элементом
      m_items[i].IsDropdown(true);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вертикальный скролл                                      |
//+------------------------------------------------------------------+
bool CTreeView::CreateScrollV(void)
  {
//--- Сохранить указатель формы
   m_scrollv.WindowPointer(m_wnd);
//--- Координаты
   int x=m_area.X2()-m_scrollv.ScrollWidth();
   int y=CElement::Y();
   m_scrollv.XDistance(x);
//--- Установим свойства
   m_scrollv.Index(0);
   m_scrollv.Id(CElement::Id());
   m_scrollv.XGap(x-m_wnd.X());
   m_scrollv.YGap(y-m_wnd.Y());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(m_item_y_size*m_visible_items_total+2-(m_visible_items_total-1));
//--- Создание полосы прокрутки
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_items_total,m_visible_items_total))
      return(false);
//--- Скрыть элемент
   m_scrollv.Hide();
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт список содержания выделенного пункта                     |
//+------------------------------------------------------------------+
bool CTreeView::CreateContentItems(void)
  {
//--- Выйти, если содержание пункта не нужно показывать или
//    если область содержания отключена
   if(!m_show_item_content || m_content_area_width<0)
      return(true);
//--- Координаты и ширина
   int x =m_content_area.X()+1;
   int y =CElement::Y()+1;
   int w =m_content_area.X2()-x-1;
//--- Счётчик количества пунктов
   int c=0;
//--- 
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- В этот список не должны попасть пункты из корневого каталога, 
      //    поэтому, если уровень узла меньше 1, перейдём к следующему
      if(m_t_node_level[i]<1)
         continue;
      //--- Увеличить размеры массивов на один элемент
      int new_size=c+1;
      ::ArrayResize(m_content_items,new_size);
      ::ArrayResize(m_c_item_text,new_size);
      ::ArrayResize(m_c_tree_list_index,new_size);
      ::ArrayResize(m_c_list_index,new_size);
      //--- Расчёт координаты Y
      y=(c>0)? y+m_item_y_size-1 : y;
      //--- Передадим объект панели
      m_content_items[c].WindowPointer(m_wnd);
      //--- Установим свойства перед созданием
      m_content_items[c].Index(1);
      m_content_items[c].Id(CElement::Id());
      m_content_items[c].XSize(w);
      m_content_items[c].YSize(m_item_y_size);
      m_content_items[c].IconFile(m_t_path_bmp[i]);
      m_content_items[c].ItemBackColor(m_area_color);
      m_content_items[c].ItemBackColorHover(m_item_back_color_hover);
      m_content_items[c].ItemBackColorSelected(m_item_back_color_selected);
      m_content_items[c].ItemTextColor(m_item_text_color);
      m_content_items[c].ItemTextColorHover(m_item_text_color_hover);
      m_content_items[c].ItemTextColorSelected(m_item_text_color_selected);
      //--- Координаты
      m_content_items[c].X(x);
      m_content_items[c].Y(y);
      //--- Отступы от крайней точки панели
      m_content_items[c].XGap(x-m_wnd.X());
      m_content_items[c].YGap(y-m_wnd.Y());
      //--- Создание объекта
      if(!m_content_items[c].CreateTreeItem(m_chart_id,m_subwin,x,y,TI_SIMPLE,c,0,m_t_item_text[i],false))
         return(false);
      //--- Скрыть элемент
      m_content_items[c].Hide();
      //--- Пункт будет выпалающим элементом
      m_content_items[c].IsDropdown(true);
      //--- Сохранить (1) индекс общего списка содержания, (2) индекс древовидного списка и (3) текст пункта
      m_c_list_index[c]      =c;
      m_c_tree_list_index[c] =m_t_list_index[i];
      m_c_item_text[c]       =m_t_item_text[i];
      //---
      c++;
     }
//--- Сохранить размер списка
   m_content_items_total=::ArraySize(m_content_items);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вертикальный скролл для рабочей области                  |
//+------------------------------------------------------------------+
bool CTreeView::CreateContentScrollV(void)
  {
//--- Выйти, если содержание пункта не нужно показывать или
//    если область содержания отключена
   if(!m_show_item_content || m_content_area_width<0)
      return(true);
//--- Сохранить указатель формы
   m_content_scrollv.WindowPointer(m_wnd);
//--- Координаты
   int x=m_content_area.X()+m_content_area.X_Size()-m_content_scrollv.ScrollWidth();
   int y=CElement::Y();
//--- Установим размеры
   m_content_scrollv.Index(1);
   m_content_scrollv.Id(CElement::Id());
   m_content_scrollv.XGap(x-m_wnd.X());
   m_content_scrollv.YGap(y-m_wnd.Y());
   m_content_scrollv.XSize(m_content_scrollv.ScrollWidth());
   m_content_scrollv.YSize(m_item_y_size*m_visible_items_total+2-(m_visible_items_total-1));
//--- Создание полосы прокрутки
   if(!m_content_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_content_items_total,m_visible_items_total))
      return(false);
//--- Скрыть элемент
   m_content_scrollv.Hide();
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт указатель курсора изменения ширины                       |
//+------------------------------------------------------------------+
bool CTreeView::CreateXResizePointer(void)
  {
//--- Выйти, если ширину области содержания не нужно изменять или
//    включен режим пунктов-вкладок
   if(!m_resize_list_area_mode || m_tab_items_mode)
      return(true);
//--- Установка свойств
   m_x_resize.XGap(12);
   m_x_resize.YGap(9);
   m_x_resize.Id(CElement::Id());
   m_x_resize.Type(MP_X_RESIZE);
//--- Создание элемента
   if(!m_x_resize.CreatePointer(m_chart_id,m_subwin))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Возвращает указатель пункта древовидного списка по индексу       |
//+------------------------------------------------------------------+
CTreeItem *CTreeView::ItemPointer(const int index)
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
//| Возвращает указатель пункта области содержания по индексу        |
//+------------------------------------------------------------------+
CTreeItem *CTreeView::ContentItemPointer(const int index)
  {
   int array_size=::ArraySize(m_content_items);
//--- Если нет ни одного пункта в контекстном меню, сообщить об этом
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в контекстном меню есть хотя бы один пункт!");
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть указатель
   return(::GetPointer(m_content_items[i]));
  }
//+------------------------------------------------------------------+
//| Добавляет пункт в общий массив древовидного списка               |
//+------------------------------------------------------------------+
void CTreeView::AddItem(const int list_index,const int prev_node_list_index,const string item_text,const string path_bmp,const int item_index,
                        const int node_level,const int prev_node_item_index,const int items_total,const int folders_total,const bool item_state,const bool is_folder)
  {
//--- Увеличим размер массивов на один элемент
   int array_size =::ArraySize(m_items);
   m_items_total  =array_size+1;
   ::ArrayResize(m_items,m_items_total);
   ::ArrayResize(m_t_list_index,m_items_total);
   ::ArrayResize(m_t_prev_node_list_index,m_items_total);
   ::ArrayResize(m_t_item_text,m_items_total);
   ::ArrayResize(m_t_path_bmp,m_items_total);
   ::ArrayResize(m_t_item_index,m_items_total);
   ::ArrayResize(m_t_node_level,m_items_total);
   ::ArrayResize(m_t_prev_node_item_index,m_items_total);
   ::ArrayResize(m_t_items_total,m_items_total);
   ::ArrayResize(m_t_folders_total,m_items_total);
   ::ArrayResize(m_t_item_state,m_items_total);
   ::ArrayResize(m_t_is_folder,m_items_total);
//--- Сохраним значения переданных параметров
   m_t_list_index[array_size]           =list_index;
   m_t_prev_node_list_index[array_size] =prev_node_list_index;
   m_t_item_text[array_size]            =item_text;
   m_t_path_bmp[array_size]             =path_bmp;
   m_t_item_index[array_size]           =item_index;
   m_t_node_level[array_size]           =node_level;
   m_t_prev_node_item_index[array_size] =prev_node_item_index;
   m_t_items_total[array_size]          =items_total;
   m_t_folders_total[array_size]        =folders_total;
   m_t_item_state[array_size]           =item_state;
   m_t_is_folder[array_size]            =is_folder;
  }
//+------------------------------------------------------------------+
//| Добавляет элемент в массив указанной вкладки                     |
//+------------------------------------------------------------------+
void CTreeView::AddToElementsArray(const int tab_index,CElement &object)
  {
//--- Проверка на выход из диапазона
   int array_size=::ArraySize(m_tab_items);
   if(array_size<1 || tab_index<0 || tab_index>=array_size)
      return;
//--- Добавим указатель переданного элемента в массив указанной вкладки
   int size=::ArraySize(m_tab_items[tab_index].elements);
   ::ArrayResize(m_tab_items[tab_index].elements,size+1);
   m_tab_items[tab_index].elements[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| Показывает элементы только выделенного пункта-вкладки            |
//+------------------------------------------------------------------+
void CTreeView::ShowTabElements(void)
  {
//--- Выйти, если элемент скрыт или режим пунктов-вкладок отключен
   if(!CElement::IsVisible() || !m_tab_items_mode)
      return;
//--- Индекс выделенной вкладки
   int tab_index=WRONG_VALUE;
//--- Определим индекс выделенной вкладки
   int tab_items_total=::ArraySize(m_tab_items);
   for(int i=0; i<tab_items_total; i++)
     {
      if(m_tab_items[i].list_index==m_selected_item_index)
        {
         tab_index=i;
         break;
        }
     }
//--- Покажем элементы только выделенной вкладки
   for(int i=0; i<tab_items_total; i++)
     {
      //--- Получим количество элементов присоединённых к вкладке
      int tab_elements_total=::ArraySize(m_tab_items[i].elements);
      //--- Если выделен этот пункт-вкладка
      if(i==tab_index)
        {
         //--- Показать элементы
         for(int j=0; j<tab_elements_total; j++)
            m_tab_items[i].elements[j].Reset();
        }
      else
        {
         //--- Скрыть элементы
         for(int j=0; j<tab_elements_total; j++)
            m_tab_items[i].elements[j].Hide();
        }
     }
  }
//+------------------------------------------------------------------+
//| Возвращает полный текущий путь                                   |
//+------------------------------------------------------------------+
string CTreeView::CurrentFullPath(void)
  {
//--- Для формирования директории к выделенному пункту
   string path="";
//--- Индекс выделенного пункта
   int li=m_selected_item_index;
//--- Массив для формирования директории
   string path_parts[];
//--- Получим описание (текст) выделенного пункта древовидного списка,
//    но только, если это папка
   if(m_t_is_folder[li])
     {
      ::ArrayResize(path_parts,1);
      path_parts[0]=m_t_item_text[li];
     }
//--- Пройдёмся по всему списку
   int total=::ArraySize(m_t_list_index);
   for(int i=0; i<total; i++)
     {
      //--- Рассматриваем только папки.
      //    Если файл, переходим к следующему пункту.
      if(!m_t_is_folder[i])
         continue;
      //--- Если (1) индекс общего списка совпадает с индексом общего списка предыдущего узла и
      //    (2) индекс пункта локального списка совпадает с индексом пункта предыдущего узла и
      //    (3) соблюдается последовательность уровней узлов
      if(m_t_list_index[i]==m_t_prev_node_list_index[li] &&
         m_t_item_index[i]==m_t_prev_node_item_index[li] &&
         m_t_node_level[i]==m_t_node_level[li]-1)
        {
         //--- Увеличим массив на один элемент и сохраним описание пункта
         int sz=::ArraySize(path_parts);
         ::ArrayResize(path_parts,sz+1);
         path_parts[sz]=m_t_item_text[i];
         //--- Запомним индекс для следующей проверки
         li=i;
         //--- Если дошли до нулевого уровня узла, выходим из цикла
         if(m_t_node_level[i]==0 || i<=0)
            break;
         //--- Сбросить счётчик цикла
         i=-1;
        }
     }
//--- Сформировать строку - полный путь к выделенному пункту в древовидном списке
   total=::ArraySize(path_parts);
   for(int i=total-1; i>=0; i--)
      ::StringAdd(path,path_parts[i]+"\\");
//--- Если выделенный в древовидном списке пункт - папка
   if(m_t_is_folder[m_selected_item_index])
     {
      m_selected_item_file_name="";
      //--- Если пункт в области содержания выделен
      if(m_selected_content_item_index>0)
        {
         //--- Если выделенный пункт - файл, сохраним его название
         if(!m_t_is_folder[m_c_tree_list_index[m_selected_content_item_index]])
            m_selected_item_file_name=m_c_item_text[m_selected_content_item_index];
        }
     }
//--- Если выделенный в древовидном списке пункт - файл
   else
//--- Сохраним его название
      m_selected_item_file_name=m_t_item_text[m_selected_item_index];
//--- Вернуть директорию
   return(path);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CTreeView::ChangeObjectsColor(void)
  {
//--- Выйти, если отключен режим подсветки по наведению курсора мыши или
//    левая кнопка мыши нажата
   if(!m_lights_hover || m_mouse_state)
      return;
//--- Если фокус на области изменения ширины содержания
   if(m_x_resize.IsVisible())
     {
      //--- Сбросить цвета пунктов и выйти
      ResetColors();
      return;
     }
//--- Цвет пунктов в древовидном списке
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
     {
      int li=m_td_list_index[i];
      if(li!=m_selected_item_index)
         m_items[li].ChangeObjectsColor();
     }
//--- Выйти, если область содержания не нужна
   if(m_content_area_width<0)
      return;
//--- Цвет пунктов в списке содержания
   int cd_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<cd_items_total; i++)
     {
      int li=m_cd_list_index[i];
      if(li!=m_selected_content_item_index)
         m_content_items[li].ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CTreeView::Moving(const int x,const int y)
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
   m_content_area.X(x+m_content_area.XGap());
   m_content_area.Y(y+m_content_area.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_content_area.X_Distance(m_content_area.X());
   m_content_area.Y_Distance(m_content_area.Y());
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CTreeView::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Состояние видимости
   CElement::IsVisible(true);
//--- Обновить координаты объектов
   CTreeView::Moving(m_wnd.X(),m_wnd.Y());
//--- Сделать видимыми все объекты
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_content_area.Timeframes(OBJ_ALL_PERIODS);
//--- Показать полосу прокрутки, если количество пунктов списка не помещается
   if(m_items_total>m_visible_items_total)
      m_scrollv.Show();
//--- Обновить координаты и размеры списков
   ShiftTreeList();
   ShiftContentList();
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CTreeView::Hide(void)
  {
//--- Выйти, если элемент уже скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_content_area.Timeframes(OBJ_NO_PERIODS);
//--- Скрыть пункты древовидного списка
   int total=::ArraySize(m_items);
   for(int i=0; i<total; i++)
      m_items[i].Hide();
//--- Скрыть пункты списка содержания
   total=::ArraySize(m_content_items);
   for(int i=0; i<total; i++)
      m_content_items[i].Hide();
//--- Скрыть полосы прокрутки
   m_scrollv.Hide();
   m_content_scrollv.Hide();
//--- Скорректируем размер полосы прокрутки
   m_scrollv.ChangeThumbSize(m_items_total,m_visible_items_total);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CTreeView::Reset(void)
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
void CTreeView::Delete(void)
  {
//--- Удаление графических объектов
   m_area.Delete();
   m_content_area.Delete();
//---
   int total=::ArraySize(m_items);
   for(int i=0; i<total; i++)
      m_items[i].Delete();
//---
   total=::ArraySize(m_content_items);
   for(int i=0; i<total; i++)
      m_content_items[i].Delete();
//---
   m_x_resize.Delete();
//--- Освобождение массивов элемента
   ::ArrayFree(m_items);
   ::ArrayFree(m_content_items);
//---
   total=::ArraySize(m_tab_items);
   for(int i=0; i<total; i++)
      ::ArrayFree(m_tab_items[i].elements);
   ::ArrayFree(m_tab_items);
//---
   ::ArrayFree(m_t_prev_node_list_index);
   ::ArrayFree(m_t_list_index);
   ::ArrayFree(m_t_item_text);
   ::ArrayFree(m_t_path_bmp);
   ::ArrayFree(m_t_item_index);
   ::ArrayFree(m_t_node_level);
   ::ArrayFree(m_t_prev_node_item_index);
   ::ArrayFree(m_t_items_total);
   ::ArrayFree(m_t_folders_total);
   ::ArrayFree(m_t_item_state);
   ::ArrayFree(m_t_is_folder);
//---
   ::ArrayFree(m_td_list_index);
//---
   ::ArrayFree(m_c_list_index);
   ::ArrayFree(m_c_item_text);
//---
   ::ArrayFree(m_cd_item_text);
   ::ArrayFree(m_cd_list_index);
   ::ArrayFree(m_cd_tree_list_index);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
   m_selected_item_index =WRONG_VALUE;
   m_selected_content_item_index =WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CTreeView::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
      m_items[i].SetZorders();
//--- Выйти, если содержание пункта не нужно показывать или
//    если область содержания отключена
   if(!m_show_item_content || m_content_area_width<0)
      return;
//---
   int content_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<content_items_total; i++)
      m_content_items[i].SetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CTreeView::ResetZorders(void)
  {
   m_area.Z_Order(0);
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
      m_items[i].ResetZorders();
//--- Выйти, если список содержания отсутствует
   if(!m_show_item_content)
      return;
//---
   int content_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<content_items_total; i++)
      m_content_items[i].ResetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс цвета                                                      |
//+------------------------------------------------------------------+
void CTreeView::ResetColors(void)
  {
   int items_total=::ArraySize(m_td_list_index);
   for(int i=0; i<items_total; i++)
     {
      int li=m_td_list_index[i];
      if(li!=m_selected_item_index)
         m_items[li].ResetColors();
     }
//--- Выйти, если содержание пункта не нужно показывать или
//    если область содержания отключена
   if(!m_show_item_content || m_content_area_width<0)
      return;
//---
   int content_items_total=::ArraySize(m_cd_list_index);
   for(int i=0; i<content_items_total; i++)
     {
      int li=m_cd_list_index[i];
      if(li!=m_selected_content_item_index)
         m_content_items[li].ResetColors();
     }
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку сворачивания/разворачивания списка пункта      |
//+------------------------------------------------------------------+
bool CTreeView::OnClickItemArrow(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта
   if(::StringFind(clicked_object,CElement::ProgramName()+"_0_treeitem_arrow_",0)<0)
      return(false);
//--- Получим идентификатор из имени объекта
   int id=IdFromObjectName(clicked_object);
//--- Выйти, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Получим индекс пункта в общем списке
   int list_index=IndexFromObjectName(clicked_object);
//--- Получим состояние стрелки пункта и установим противоположное
   m_t_item_state[list_index]=!m_t_item_state[list_index];
   ((CChartObjectBmpLabel*)m_items[list_index].Object(1)).State(m_t_item_state[list_index]);
//--- Обновить древовидный список
   UpdateTreeViewList();
//--- Рассчитать положение ползунка полосы прокрутки
   m_scrollv.CalculateThumbY();
//--- Показать элементы выделенного пункта-вкладки
   ShowTabElements();
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на пункте в древовидном списке                           |
//+------------------------------------------------------------------+
bool CTreeView::OnClickItem(const string clicked_object)
  {
//--- Выйдем, если полоса прокрутки в активном режиме
   if(m_scrollv.ScrollState() || m_content_scrollv.ScrollState())
      return(false);
//--- Выйдем, если чужое имя объекта
   if(::StringFind(clicked_object,CElement::ProgramName()+"_0_treeitem_area_",0)<0)
      return(false);
//--- Получим идентификатор из имени объекта
   int id=IdFromObjectName(clicked_object);
//--- Выйти, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Получим текущую позицию ползунка полосы прокрутки
   int v=m_scrollv.CurrentPos();
//--- Пройдёмся по списку
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- Проверка для предотвращения выхода из диапазона
      if(v>=0 && v<m_items_total)
        {
         //--- Получим общий индекс пункта
         int li=m_td_list_index[v];
         //--- Если выбран этот пункт в списке
         if(m_items[li].Object(0).Name()==clicked_object)
           {
            //--- Выйдем, если этот пункт уже выделен
            if(li==m_selected_item_index)
               return(false);
            //--- Если включен режим пунктов-вкладок и отключен режим показа содержания,
            //    не будем выделять пункты без списка
            if(m_tab_items_mode && !m_show_item_content)
              {
               //--- Если текущий пункт не содержит в себе списка, остановим цикл
               if(m_t_items_total[li]>0)
                  break;
              }
            //--- Установим цвет предыдущему выделенному пункту
            m_items[m_selected_item_index].HighlightItemState(false);
            //--- Запомним индекс для текущего и изменим его цвет
            m_selected_item_index=li;
            m_items[li].HighlightItemState(true);
            break;
           }
         v++;
        }
     }
//--- Сбросить цвета в области содержания
   if(m_selected_content_item_index>=0)
      m_content_items[m_selected_content_item_index].HighlightItemState(false);
//--- Сброс выделенного пункта
   m_selected_content_item_index=WRONG_VALUE;
//--- Обновить список содержания
   UpdateContentList();
//--- Рассчитать положение ползунка полосы прокрутки
   m_content_scrollv.CalculateThumbY();
//--- Скорректировать список содержания
   ShiftContentList();
//--- Показать элементы выделенного пункта-вкладки
   ShowTabElements();
//--- Отправить сообщение о выборе новой директории в древовидном списке
   ::EventChartCustom(m_chart_id,ON_CHANGE_TREE_PATH,0,0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на пункте в списке содержания                            |
//+------------------------------------------------------------------+
bool CTreeView::OnClickContentListItem(const string clicked_object)
  {
//--- Выйти, если область содержания отключена
   if(m_content_area_width<0)
      return(false);
//--- Выйдем, если полоса прокрутки в активном режиме
   if(m_scrollv.ScrollState() || m_content_scrollv.ScrollState())
      return(false);
//--- Выйдем, если чужое имя объекта
   if(::StringFind(clicked_object,CElement::ProgramName()+"_1_treeitem_area_",0)<0)
      return(false);
//--- Получим идентификатор из имени объекта
   int id=IdFromObjectName(clicked_object);
//--- Выйти, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Получим количество пунктов в списке содержания
   int content_items_total=::ArraySize(m_cd_list_index);
//--- Получим текущую позицию ползунка полосы прокрутки
   int v=m_content_scrollv.CurrentPos();
//--- Пройдёмся по списку
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- Проверка для предотвращения выхода из диапазона
      if(v>=0 && v<content_items_total)
        {
         //--- Получим общий индекс списка
         int li=m_cd_list_index[v];
         //--- Если выбран этот пункт в списке
         if(m_content_items[li].Object(0).Name()==clicked_object)
           {
            //--- Установить цвет предыдущему выделенному пункту
            if(m_selected_content_item_index>=0)
               m_content_items[m_selected_content_item_index].HighlightItemState(false);
            //--- Запомним индекс для текущего и изменим цвет
            m_selected_content_item_index=li;
            m_content_items[li].HighlightItemState(true);
           }
         v++;
        }
     }
//--- Отправить сообщение о выборе новой директории в древовидном списке
   ::EventChartCustom(m_chart_id,ON_CHANGE_TREE_PATH,0,0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CTreeView::IdFromObjectName(const string object_name)
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
int CTreeView::IndexFromObjectName(const string object_name)
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
//| Формирует массив пунктов-вкладок                                 |
//+------------------------------------------------------------------+
void CTreeView::GenerateTabItemsArray(void)
  {
//--- Выйти, если режим пунктов-вкладок отключен
   if(!m_tab_items_mode)
      return;
//--- Добавим в массив пунктов-вкладок только пустые пункты
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- Если в этом пункте есть другие пункты, перейдём к следующему
      if(m_t_items_total[i]>0)
         continue;
      //--- Увеличим размер массива пунктов-вкладок на один элемент
      int array_size=::ArraySize(m_tab_items);
      ::ArrayResize(m_tab_items,array_size+1);
      //--- Сохраним общий индекс пункта
      m_tab_items[array_size].list_index=i;
     }
//--- Если отключен показ содержания пунктов
   if(!m_show_item_content)
     {
      //--- Получим размер массива пунктов-вкладок
      int tab_items_total=::ArraySize(m_tab_items);
      //--- Скорректируем индекс, если выход из диапазона
      if(m_selected_item_index>=tab_items_total)
         m_selected_item_index=tab_items_total-1;
      //--- Отключим выделение текущего пункта в списке
      m_items[m_selected_item_index].HighlightItemState(false);
      //--- Индекс выделенной вкладки
      int tab_index=m_tab_items[m_selected_item_index].list_index;
      m_selected_item_index=tab_index;
      //--- Выделим этот пункт
      m_items[tab_index].HighlightItemState(true);
     }
  }
//+------------------------------------------------------------------+
//| Определение и установка границ узлов                             |
//+------------------------------------------------------------------+
void CTreeView::SetNodeLevelBoundaries(void)
  {
//--- Определим минимальный и максимальный уровень узлов
   m_min_node_level =m_t_node_level[::ArrayMinimum(m_t_node_level)];
   m_max_node_level =m_t_node_level[::ArrayMaximum(m_t_node_level)];
  }
//+------------------------------------------------------------------+
//| Определение и установка размера корневого каталога               |
//+------------------------------------------------------------------+
void CTreeView::SetRootItemsTotal(void)
  {
//--- Определим количество пунктов в корневом каталоге
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- Если это минимальный уровень, увеличим счётчик
      if(m_t_node_level[i]==m_min_node_level)
         m_root_items_total++;
     }
  }
//+------------------------------------------------------------------+
//| Сдвигает древовидный список относительно полосы прокрутки        |
//+------------------------------------------------------------------+
void CTreeView::ShiftTreeList(void)
  {
//--- Скрыть все пункты в древовидном списке
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- Если нужна полоса прокрутки
   bool is_scroll=m_items_total>m_visible_items_total;
//--- Расчёт ширины пунктов списка
   int w=(is_scroll)? m_area.XSize()-m_scrollv.ScrollWidth()-1 : m_area.XSize()-2;
//--- Определение позиции скролла
   int v=(is_scroll)? m_scrollv.CurrentPos() : 0;
   m_scrollv.CurrentPos(v);
//--- Координата Y первого пункта древовидного списка
   int y=CElement::Y()+1;
//---
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- Проверка для предотвращения выхода из диапазона
      if(v>=0 && v<m_items_total)
        {
         //--- Рассчитаем координату Y
         y=(r>0)? y+m_item_y_size-1 : y;
         //--- Получим общий индекс пункта древовидного списка
         int li=m_td_list_index[v];
         //--- Установить координаты и ширину
         m_items[li].UpdateX(m_area.X()+1);
         m_items[li].UpdateY(y);
         m_items[li].UpdateWidth(w);
         //--- Показать пункт
         m_items[li].Show();
         v++;
        }
     }
//--- Перерисовать полосу прокрутки
   if(is_scroll)
      m_scrollv.Reset();
  }
//+------------------------------------------------------------------+
//| Сдвигает список содержания относительно полосы прокрутки         |
//+------------------------------------------------------------------+
void CTreeView::ShiftContentList(void)
  {
//--- Выйти, если (1) содержание пункта не нужно показывать или
//    (2) если область содержания отключена
   if(!m_show_item_content || m_content_area_width<0)
      return;
//--- Скрыть все пункты в списке содержания
   m_content_items_total=ContentItemsTotal();
   for(int i=0; i<m_content_items_total; i++)
      m_content_items[i].Hide();
//--- Перерисовать фон области содержания
   m_content_area.Timeframes(OBJ_NO_PERIODS);
   m_content_area.Timeframes(OBJ_ALL_PERIODS);
//--- Получим количество отображаемых пунктов в списке содержания
   int total=::ArraySize(m_cd_list_index);
//--- Если нужна полоса прокрутки
   bool is_scroll=total>m_visible_items_total;
//--- Расчёт ширины пунктов списка
   int w=(is_scroll) ? m_content_area.XSize()-m_content_scrollv.ScrollWidth()-1 : m_content_area.XSize()-2;
//--- Определение позиции скролла
   int v=(is_scroll) ?  m_content_scrollv.CurrentPos() : 0;
   m_content_scrollv.CurrentPos(v);
//--- Координата Y первого пункта древовидного списка
   int y=CElement::Y()+1;
//--- 
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- Проверка для предотвращения выхода из диапазона
      if(v>=0 && v<total)
        {
         //--- Рассчитаем координату Y
         y=(r>0)? y+m_item_y_size-1 : y;
         //--- Получим общий индекс пункта древовидного списка
         int li=m_cd_list_index[v];
         //--- Установить координаты и ширину
         m_content_items[li].UpdateX(m_content_area.X()+1);
         m_content_items[li].UpdateY(y);
         m_content_items[li].UpdateWidth(w);
         //--- Показать пункт
         m_content_items[li].Show();
         v++;
        }
     }
//--- Перерисовать полосу прокрутки
   if(is_scroll)
      m_content_scrollv.Reset();
  }
//+------------------------------------------------------------------+
//| Ускоренная перемотка списков                                     |
//+------------------------------------------------------------------+
void CTreeView::FastSwitching(void)
  {
//--- Выйти, если вне области элемента или активирован режим изменения ширины области содержания
   if(!CElement::MouseFocus() || m_x_resize.State())
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
        {
         m_scrollv.OnClickScrollInc(m_scrollv.ScrollIncName());
         ShiftTreeList();
        }
      //--- Если прокрутка вниз
      else if(m_scrollv.ScrollDecState())
        {
         m_scrollv.OnClickScrollDec(m_scrollv.ScrollDecName());
         ShiftTreeList();
        }
      //--- Выйти, если область содержания отключена
      if(m_content_area_width<0)
         return;
      //--- Если прокрутка вверх
      if(m_content_scrollv.ScrollIncState())
        {
         m_content_scrollv.OnClickScrollInc(m_content_scrollv.ScrollIncName());
         ShiftContentList();
        }
      //--- Если прокрутка вниз
      else if(m_content_scrollv.ScrollDecState())
        {
         m_content_scrollv.OnClickScrollDec(m_content_scrollv.ScrollDecName());
         ShiftContentList();
        }
     }
  }
//+------------------------------------------------------------------+
//| Управляет шириной списков                                        |
//+------------------------------------------------------------------+
void CTreeView::ResizeListArea(const int x,const int y)
  {
//--- Выйти, (1) если ширину области содержания не нужно изменять или
//    (2) если область содержания отключена или (3) включен режим пунктов-вкладок
   if(!m_resize_list_area_mode || m_content_area_width<0 || m_tab_items_mode)
      return;
//--- Выйти, если полоса прокрутки активна
   if(m_scrollv.ScrollState())
      return;
//--- Проверка готовности для изменения ширины списков
   CheckXResizePointer(x,y);
//--- Если курсор отключен, разблокировать форму
   if(!m_x_resize.State())
     {
      //--- Разблокировать форму может только тот, кто её заблокировал
      if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()==CElement::Id())
        {
         m_wnd.IsLocked(false);
         m_wnd.IdActivatedElement(WRONG_VALUE);
         return;
        }
     }
   else
     {
      //--- Проверка на выход за установленные ограничения 
      if(!CheckOutOfArea(x,y))
         return;
      //--- Заблокируем форму и запомним идентификатор активного элемента
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
      //--- Установим X-координату объекту по центру курсора мыши
      m_x_resize.UpdateX(x-m_x_resize.XGap());
      //--- Y-координату устанавливаем, только если не вышли за область элемента
      if(y>m_area.Y() && y<m_area.Y2())
         m_x_resize.UpdateY(y-m_x_resize.YGap());
      //--- Обновление ширины древовидного списка
      UpdateTreeListWidth(x);
      //--- Обновление ширины списка содержания
      UpdateContentListWidth(x);
      //--- Обновить координаты и размеры списков
      ShiftTreeList();
      ShiftContentList();
      //--- Перерисовать указатель
      m_x_resize.Reset();
     }
  }
//+------------------------------------------------------------------+
//| Проверка готовности для изменения ширины списков                 |
//+------------------------------------------------------------------+
void CTreeView::CheckXResizePointer(const int x,const int y)
  {
//--- Если указатель не активирован, но курсор мыши в его области
   if(!m_x_resize.State() && 
      y>m_area.Y() && y<m_area.Y2() && x>m_area.X2()-2 && x<m_area.X2()+3)
     {
      //--- Обновить координаты указателя и сделать его видимым
      int l_x=x-m_x_resize.XGap();
      int l_y=y-m_x_resize.YGap();
      m_x_resize.Moving(l_x,l_y);
      m_x_resize.Show();
      //--- Установить флаг видимости
      m_x_resize.IsVisible(true);
      //--- Если левая кнопка мыши нажата
      if(m_mouse_state)
         //--- Активируем указатель
         m_x_resize.State(true);
     }
   else
     {
      //--- Если левая кнопка мыши отжата
      if(!m_mouse_state)
        {
         //--- Дезактивировать и скрыть указатель
         m_x_resize.State(false);
         m_x_resize.Hide();
         //--- Снять флаг видимости
         m_x_resize.IsVisible(false);
        }
     }
  }
//+------------------------------------------------------------------+
//| Проверка на выход за ограничения                                 |
//+------------------------------------------------------------------+
bool CTreeView::CheckOutOfArea(const int x,const int y)
  {
//--- Ограничение
   int area_limit=80;
//--- Если выходим за границы элемента по горизонтали ...
   if(x<m_area.X()+area_limit || x>m_content_area.X2()-area_limit)
     {
      // ... перемещаем указатель только по вертикали, не выходя за границы
      if(y>m_area.Y() && y<m_area.Y2())
         m_x_resize.UpdateY(y-m_x_resize.YGap());
      //--- Не изменять ширину списков
      return(false);
     }
//--- Изменить ширину списков
   return(true);
  }
//+------------------------------------------------------------------+
//| Обновление ширины древовидного списка                            |
//+------------------------------------------------------------------+
void CTreeView::UpdateTreeListWidth(const int x)
  {
//--- Рассчитаем и установим ширину области древовидного списка
   m_area.X_Size(x-m_area.X());
   m_area.XSize(m_area.X_Size());
//--- Рассчитаем и установим ширину для пунктов в древовидном списке с учётом полосы прокрутки
   int l_w=(m_items_total>m_visible_items_total) ? m_area.XSize()-m_scrollv.ScrollWidth()-4 : m_area.XSize()-1;
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
      m_items[i].UpdateWidth(l_w);
//--- Рассчитаем и установим координаты для полосы прокрутки древовидного списка
   m_scrollv.X(m_area.X2()-m_scrollv.ScrollWidth());
   m_scrollv.XDistance(m_scrollv.X());
  }
//+------------------------------------------------------------------+
//| Обновление ширины списка в области содержания                    |
//+------------------------------------------------------------------+
void CTreeView::UpdateContentListWidth(const int x)
  {
//--- Рассчитаем и установим координату X, отступ и ширину для области содержания
   int l_x=m_area.X2()-1;
   m_content_area.X(l_x);
   m_content_area.X_Distance(l_x);
   m_content_area.XGap(l_x-m_wnd.X());
   m_content_area.XSize(CElement::X2()-m_content_area.X());
   m_content_area.X_Size(m_content_area.XSize());
//--- Рассчитаем и установим координату X и ширину для пунктов в списке содержания
   l_x=m_content_area.X()+1;
   int l_w=(m_content_items_total>m_visible_items_total) ? m_content_area.XSize()-m_content_scrollv.ScrollWidth()-4 : m_content_area.XSize()-2;
   int total=::ArraySize(m_content_items);
   for(int i=0; i<total; i++)
     {
      m_content_items[i].UpdateX(l_x);
      m_content_items[i].UpdateWidth(l_w);
     }
  }
//+------------------------------------------------------------------+
//| Добавляет пункт в массив отображаемых пунктов                    |
//| в древовидном списке                                             |
//+------------------------------------------------------------------+
void CTreeView::AddDisplayedTreeItem(const int list_index)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_td_list_index);
   ::ArrayResize(m_td_list_index,array_size+1);
//--- Сохраним значения переданных параметров
   m_td_list_index[array_size]=list_index;
  }
//+------------------------------------------------------------------+
//| Обновляет древовидный список                                     |
//+------------------------------------------------------------------+
void CTreeView::UpdateTreeViewList(void)
  {
//--- Массивы для контроля последовательности пунктов:
   int l_prev_node_list_index[]; // общий индекс списка предыдущего узла
   int l_item_index[];           // локальный индекс пункта
   int l_items_total[];          // количество пунктов в узле
   int l_folders_total[];        // количество папок в узле
//--- Зададим начальный размер массивов
   int begin_size=m_max_node_level+2;
   ::ArrayResize(l_prev_node_list_index,begin_size);
   ::ArrayResize(l_item_index,begin_size);
   ::ArrayResize(l_items_total,begin_size);
   ::ArrayResize(l_folders_total,begin_size);
//--- Инициализация массивов
   ::ArrayInitialize(l_prev_node_list_index,-1);
   ::ArrayInitialize(l_item_index,-1);
   ::ArrayInitialize(l_items_total,-1);
   ::ArrayInitialize(l_folders_total,-1);
//--- Освобождаем массив отображаемых пунктов древовидного списка
   ::ArrayFree(m_td_list_index);
//--- Счётчик локальных индексов пунктов
   int ii=0;
//--- Для установки флага последнего пункта в корневом каталоге
   bool end_list=false;
//--- Собираем отображаемые пункты в массив. Цикл будет работать до тех пор, пока: 
//    1: счётчик узлов не больше максимального;
//    2: не дошли до последнего пункта (после проверки всех вложенных в него пунктов);
//    3: программу не удалил пользователь.
   int items_total=::ArraySize(m_items);
   for(int nl=m_min_node_level; nl<=m_max_node_level && !end_list; nl++)
     {
      for(int i=0; i<items_total && !::IsStopped(); i++)
        {
         //--- Если включен режим "Отображать только папки"
         if(m_file_navigator_mode==FN_ONLY_FOLDERS)
           {
            //--- Если это файл, перейти к следующему пункту
            if(!m_t_is_folder[i])
               continue;
           }
         //--- Если (1) это не наш узел или (2) последовальность локальных индексов пунктов не соблюдается,
         //    перейдём к следующему
         if(nl!=m_t_node_level[i] || m_t_item_index[i]<=l_item_index[nl])
            continue;
         //--- Перейдём к следующему пункту, если (1) сейчас не в корневом каталоге и 
         //    (2) общий индекс списка предыдущего узла не равен аналогичному в памяти
         if(nl>m_min_node_level && m_t_prev_node_list_index[i]!=l_prev_node_list_index[nl])
            continue;
         //--- Запомним локальный индекс пункта, если следующий будет не меньше размера локального списка
         if(m_t_item_index[i]+1>=l_items_total[nl])
            ii=m_t_item_index[i];
         //--- Если список текущего пункта развёрнут
         if(m_t_item_state[i])
           {
            //--- Добавим пункт в массив отображаемых пунктов в древовидном списке
            AddDisplayedTreeItem(i);
            //--- Запомним текущие значения и перейдём к следующему узлу
            int n=nl+1;
            l_prev_node_list_index[n] =m_t_list_index[i];
            l_item_index[nl]          =m_t_item_index[i];
            l_items_total[n]          =m_t_items_total[i];
            l_folders_total[n]        =m_t_folders_total[i];
            //--- Обнулим счётчик локальных индексов пунктов
            ii=0;
            //--- Перейдём к следующему узлу
            break;
           }
         //--- Добавим пункт в массив отображаемых пунктов в древовидном списке
         AddDisplayedTreeItem(i);
         //--- Увеличим счётчик локальных индексов пунктов
         ii++;
         //--- Если дошли до последнего пункта в корневом каталоге
         if(nl==m_min_node_level && ii>=m_root_items_total)
           {
            //--- Установим флаг и завершим текущий цикл
            end_list=true;
            break;
           }
         //--- Если до последнего пункта в корневом каталоге ещё не дошли
         else if(nl>m_min_node_level)
           {
            //--- Получим количество пунктов в текущем узле
            int total=(m_file_navigator_mode==FN_ONLY_FOLDERS)? l_folders_total[nl]: l_items_total[nl];
            //--- Если это не последний локальный индекс пункта, перейдём к следующему
            if(ii<total)
               continue;
            //--- Если дошли до последнего локального индекса, то 
            //    нужно вернуться на предыдущий узел и продолжить с пункта, на котором остановились
            while(true)
              {
               //--- Сбросим значения текущего узла в перечисленных ниже массивах
               l_prev_node_list_index[nl] =-1;
               l_item_index[nl]           =-1;
               l_items_total[nl]          =-1;
               //--- Уменьшаем счётчик узлов, пока соблюдается равенство в количестве пунктов в локальных списках 
               //    или не дошли до корневого каталога
               if(l_item_index[nl-1]+1>=l_items_total[nl-1])
                 {
                  if(nl-1==m_min_node_level)
                     break;
                  //---
                  nl--;
                  continue;
                 }
               //---
               break;
              }
            //--- Перейдём на предыдущий узел
            nl=nl-2;
            //--- Обнулим счётчик локальных индексов пунктов и перейдём к следующему узлу
            ii=0;
            break;
           }
        }
     }
//--- Перерисовка элемента:
   RedrawTreeList();
  }
//+------------------------------------------------------------------+
//| Обновляет список содержания                                      |
//+------------------------------------------------------------------+
void CTreeView::UpdateContentList(void)
  {
//--- Индекс выделенного пункта
   int li=m_selected_item_index;
//--- Освободим массивы списка содержания
   ::ArrayFree(m_cd_item_text);
   ::ArrayFree(m_cd_list_index);
   ::ArrayFree(m_cd_tree_list_index);
//--- Сформируем список содержания
   int items_total=::ArraySize(m_items);
   for(int i=0; i<items_total; i++)
     {
      //--- Если совпадают (1) уровни узлов и (2) локальные индексы пунктов, а также
      //    (3) индекс предыдущего узла с индексом выделенного пункта
      if(m_t_node_level[i]==m_t_node_level[li]+1 && 
         m_t_prev_node_item_index[i]==m_t_item_index[li] &&
         m_t_prev_node_list_index[i]==li)
        {
         //--- Увеличим массивы отображаемых пунктов списка содержания
         int size     =::ArraySize(m_cd_list_index);
         int new_size =size+1;
         ::ArrayResize(m_cd_item_text,new_size);
         ::ArrayResize(m_cd_list_index,new_size);
         ::ArrayResize(m_cd_tree_list_index,new_size);
         //--- Сохраним в массивах текст пункта и общий индекс древовидного списка
         m_cd_item_text[size]       =m_t_item_text[i];
         m_cd_tree_list_index[size] =m_t_list_index[i];
        }
     }
//--- Если в итоге список не пустой, заполним массив общих индексов списка содержания
   int cd_items_total=::ArraySize(m_cd_list_index);
   if(cd_items_total>0)
     {
      //--- Счётчик пунктов
      int c=0;
      //--- Пройдёмся по списку
      int c_items_total=::ArraySize(m_c_list_index);
      for(int i=0; i<c_items_total; i++)
        {
         //--- Если описание и общие индексы пунктов древовидного списка совпадают
         if(m_c_item_text[i]==m_cd_item_text[c] && 
            m_c_tree_list_index[i]==m_cd_tree_list_index[c])
           {
            //--- Сохраним общий индекс списка содержания и перейдём к следующему
            m_cd_list_index[c]=m_c_list_index[i];
            c++;
            //--- Выйти из цикла, если дошли конца отображаемого списка
            if(c>=cd_items_total)
               break;
           }
        }
     }
//--- Скорректировать размер ползунка полосы прокрутки
   m_content_scrollv.ChangeThumbSize(cd_items_total,m_visible_items_total);
//--- Скорректировать список содержания пункта
   ShiftContentList();
  }
//+------------------------------------------------------------------+
//| Перерисовка элемента                                             |
//+------------------------------------------------------------------+
void CTreeView::RedrawTreeList(void)
  {
//--- Скрыть элемент
   Hide();
//--- Координата Y первого пункта древовидного списка
   int y=CElement::Y()+1;
//--- Получим количество пунктов
   m_items_total=::ArraySize(m_td_list_index);
//--- Скорректируем размер полосы прокрутки
   m_scrollv.ChangeThumbSize(m_items_total,m_visible_items_total);
//--- Расчёт ширины пунктов древовидного списка
   int w=(m_items_total>m_visible_items_total) ? CElement::XSize()-m_scrollv.ScrollWidth() : CElement::XSize()-2;
//--- Установим новые значения
   for(int i=0; i<m_items_total; i++)
     {
      //--- Расчёт координаты Y для каждого пункта
      y=(i>0)? y+m_item_y_size-1 : y;
      //--- Получим общий индекс пункта в списке
      int li=m_td_list_index[i];
      //--- Обновим координаты и размер
      m_items[li].UpdateY(y);
      m_items[li].UpdateWidth(w);
     }
//--- Показать элемент
   Show();
  }
//+------------------------------------------------------------------+
//| Проверка индекса выделенного пункта на выход из диапазона        |
//+------------------------------------------------------------------+
void CTreeView::CheckSelectedItemIndex(void)
  {
//--- Если индекс не определён
   if(m_selected_item_index==WRONG_VALUE)
     {
      //--- Будет выделен первый пункт в списке
      m_selected_item_index=0;
      return;
     }
//--- Проверка на выход из диапазона
   int array_size=::ArraySize(m_items);
   if(array_size<1 || m_selected_item_index<0 || m_selected_item_index>=array_size)
     {
      //--- Будет выделен первый пункт в списке
      m_selected_item_index=0;
      return;
     }
  }
//+------------------------------------------------------------------+
