//+------------------------------------------------------------------+
//|                                                     TreeItem.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания пункта древовидного списка                    |
//+------------------------------------------------------------------+
class CTreeItem : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания пункта древовидного списка
   CRectLabel        m_area;
   CBmpLabel         m_arrow;
   CBmpLabel         m_icon;
   CEdit             m_label;
   //--- Цвета фона в разных состояниях
   color             m_item_back_color;
   color             m_item_back_color_hover;
   color             m_item_back_color_selected;
   //--- Отступ для стрелки (признака наличия списка)
   int               m_arrow_x_offset;
   //--- Картинки для стрелки пункта
   string            m_item_arrow_file_on;
   string            m_item_arrow_file_off;
   string            m_item_arrow_selected_file_on;
   string            m_item_arrow_selected_file_off;
   //--- Ярлык пункта
   string            m_icon_file;
   //--- Отступы текстовой метки
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвета текста в разных состояниях пункта
   color             m_item_text_color;
   color             m_item_text_color_hover;
   color             m_item_text_color_selected;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_area_zorder;
   int               m_arrow_zorder;
   int               m_zorder;
   //--- Тип пункта
   ENUM_TYPE_TREE_ITEM m_item_type;
   //--- Индекс пункта в общем списке
   int               m_list_index;
   //--- Уровень узла
   int               m_node_level;
   //--- Отображаемый текст пункта
   string            m_item_text;
   //--- Состояние списка пункта (открыт/свёрнут)
   bool              m_item_state;
   //---
public:
                     CTreeItem(void);
                    ~CTreeItem(void);
   //--- Методы для создания пункта древовидного списка
   bool              CreateTreeItem(const long chart_id,const int subwin,const int x,const int y,const ENUM_TYPE_TREE_ITEM type,
                                    const int list_index,const int node_level,const string item_text,const bool item_state);
   //---
private:
   bool              CreateArea(void);
   bool              CreateArrow(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) цвета фона пункта
   void              WindowPointer(CWindow &object)                   { m_wnd=::GetPointer(object);               }
   void              ItemBackColor(const color clr)                   { m_item_back_color=clr;                    }
   void              ItemBackColorHover(const color clr)              { m_item_back_color_hover=clr;              }
   void              ItemBackColorSelected(const color clr)           { m_item_back_color_selected=clr;           }
   //--- (1) Установка ярлыка для пункта, (2) установка картинок для стрелки пункта
   void              IconFile(const string file_path)                 { m_icon_file=file_path;                    }
   void              ItemArrowFileOn(const string file_path)          { m_item_arrow_file_on=file_path;           }
   void              ItemArrowFileOff(const string file_path)         { m_item_arrow_file_off=file_path;          }
   void              ItemArrowSelectedFileOn(const string file_path)  { m_item_arrow_selected_file_on=file_path;  }
   void              ItemArrowSelectedFileOff(const string file_path) { m_item_arrow_selected_file_off=file_path; }
   //--- (1) Возвращает текст пункта, (2) установка отступов для текстовой метки
   string            LabelText(void)                            const { return(m_label.Description());            }
   void              LabelXGap(const int x_gap)                       { m_label_x_gap=x_gap;                      }
   void              LabelYGap(const int y_gap)                       { m_label_y_gap=y_gap;                      }
   //--- Цвета текста в разных состояниях
   void              ItemTextColor(const color clr)                   { m_item_text_color=clr;                    }
   void              ItemTextColorHover(const color clr)              { m_item_text_color_hover=clr;              }
   void              ItemTextColorSelected(const color clr)           { m_item_text_color_selected=clr;           }
   //--- Обновление координат и ширины
   void              UpdateX(const int x);
   void              UpdateY(const int y);
   void              UpdateWidth(const int width);
   //--- Изменение цвета пункта относительно указанного состояния
   void              HighlightItemState(const bool state);
   //--- Изменение цвета по наведению курсора мыши
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
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
   //--- Сбросить цвет
   virtual void      ResetColors(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTreeItem::CTreeItem(void) : m_node_level(0),
                             m_arrow_x_offset(5),
                             m_item_type(TI_SIMPLE),
                             m_item_state(false),
                             m_label_x_gap(16),
                             m_label_y_gap(2),
                             m_item_back_color(clrWhite),
                             m_item_back_color_hover(C'240,240,240'),
                             m_item_back_color_selected(C'51,153,255'),
                             m_item_text_color(clrBlack),
                             m_item_text_color_hover(clrBlack),
                             m_item_text_color_selected(clrWhite),
                             m_icon_file(""),
                             m_item_arrow_file_on(""),
                             m_item_arrow_file_off(""),
                             m_item_arrow_selected_file_on(""),
                             m_item_arrow_selected_file_off("")
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder  =1;
   m_arrow_zorder =2;
   m_zorder       =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTreeItem::~CTreeItem(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CTreeItem::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
  }
//+------------------------------------------------------------------+
//| Создаёт пункт древовидного списка                                |
//+------------------------------------------------------------------+
bool CTreeItem::CreateTreeItem(const long chart_id,const int subwin,const int x,const int y,const ENUM_TYPE_TREE_ITEM type,
                               const int list_index,const int node_level,const string item_text,const bool item_state)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием пункта списка классу нужно передать "
              "указатель на форму: CTreeItem::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id             =m_wnd.LastId()+1;
   m_chart_id       =chart_id;
   m_subwin         =subwin;
   m_x              =x;
   m_y              =y;
   m_item_type      =type;
   m_list_index     =list_index;
   m_node_level     =node_level;
   m_item_text      =item_text;
   m_item_state     =item_state;
   m_arrow_x_offset =(m_node_level>0)? (12*m_node_level)+5 : 5;
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание пункта меню
   if(!CreateArea())
      return(false);
   if(!CreateArrow())
      return(false);
   if(!CreateIcon())
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
//| Создаёт площадь пункта древовидного списка                       |
//+------------------------------------------------------------------+
bool CTreeItem::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_area_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- Установим объект
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_item_back_color);
   m_area.Color(m_item_back_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- Размеры
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
   CElement::XSize(CElement::XSize());
   CElement::YSize(CElement::YSize());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт стрелку (признак выпадающего списка)                     |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_white.bmp"
//---
bool CTreeItem::CreateArrow(void)
  {
//--- Рассчитаем координаты
   int x =CElement::X()+m_arrow_x_offset;
   int y =CElement::Y()+2;
//--- Сохраним координаты для расчёта координат следующих в очереди создания объектов элемента
   m_arrow.X(x);
   m_arrow.Y(y);
//--- Выйдем, если пункт не имеет выпадающего списка
   if(m_item_type!=TI_HAS_ITEMS)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_arrow_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- Установить картинки по умолчанию
   if(m_item_arrow_file_on=="")
      m_item_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_black.bmp";
   if(m_item_arrow_file_off=="")
      m_item_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp";
   if(m_item_arrow_selected_file_on=="")
      m_item_arrow_selected_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_rotate_white.bmp";
   if(m_item_arrow_selected_file_off=="")
      m_item_arrow_selected_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp";
//--- Установим объект
   if(!m_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_arrow.BmpFileOn("::"+m_item_arrow_file_on);
   m_arrow.BmpFileOff("::"+m_item_arrow_file_off);
   m_arrow.State(m_item_state);
   m_arrow.Corner(m_corner);
   m_arrow.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_arrow.Selectable(false);
   m_arrow.Z_Order(m_arrow_zorder);
   m_arrow.Tooltip("\n");
//--- Отступы от крайней точки
   m_arrow.XGap(x-m_wnd.X());
   m_arrow.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_arrow);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт картинку пункта                                          |
//+------------------------------------------------------------------+
bool CTreeItem::CreateIcon(void)
  {
//--- Рассчитаем координаты
   int x =m_arrow.X()+17;
   int y =CElement::Y()+2;
//--- Сохраним координаты
   m_icon.X(x);
   m_icon.Y(y);
//--- Выйти, если ярлык не нужен
   if(m_icon_file=="")
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_icon_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- Установим объект
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_icon.BmpFileOn("::"+m_icon_file);
   m_icon.BmpFileOff("::"+m_icon_file);
   m_icon.State(true);
   m_icon.Corner(m_corner);
   m_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon.Selectable(false);
   m_icon.Z_Order(m_zorder);
   m_icon.Tooltip("\n");
//--- Отступы от крайней точки
   m_icon.XGap(x-m_wnd.X());
   m_icon.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт текстовую метку пункта                                   |
//+------------------------------------------------------------------+
bool CTreeItem::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_"+(string)CElement::Index()+"_treeitem_lable_"+(string)m_list_index+"__"+(string)CElement::Id();
//--- Рассчитаем координаты и ширину
   int x=(m_icon_file=="")? m_icon.X() : m_icon.X()+m_label_x_gap;
   int y=CElement::Y()+m_label_y_gap;
   int w=CElement::X2()-x-1;
//--- Установим объект
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y,w,15))
      return(false);
//--- Установка свойств
   m_label.Description(m_item_text);
   m_label.TextAlign(ALIGN_LEFT);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(m_item_text_color);
   m_label.BackColor(m_item_back_color);
   m_label.BorderColor(m_item_back_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.ReadOnly(true);
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
//| Обновление координаты X                                          |
//+------------------------------------------------------------------+
void CTreeItem::UpdateX(const int x)
  {
//--- Обновление общих координат и отступа от крайней точки
   CElement::X(x);
   CElement::XGap(CElement::X()-m_wnd.X());
//--- Координаты и отступ фона
   m_area.X_Distance(CElement::X());
   m_area.XGap(CElement::X()-m_wnd.X());
//--- Координаты и отступ стрелки
   int l_x=CElement::X()+m_arrow_x_offset;
   m_arrow.X(l_x);
   m_arrow.X_Distance(l_x);
   m_arrow.XGap(l_x-m_wnd.X());
//--- Координаты и отступ картинки
   l_x=m_arrow.X()+17;
   m_icon.X(l_x);
   m_icon.X_Distance(l_x);
   m_icon.XGap(l_x-m_wnd.X());
//--- Координаты и отступ текстовой метки
   l_x=(m_icon_file=="")? m_icon.X() : m_icon.X()+m_label_x_gap;
   m_label.X(l_x);
   m_label.X_Distance(l_x);
   m_label.XGap(l_x-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Обновление координаты Y                                          |
//+------------------------------------------------------------------+
void CTreeItem::UpdateY(const int y)
  {
//--- Обновление общих координат и отступа от крайней точки
   CElement::Y(y);
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Координаты и отступ фона
   m_area.Y_Distance(CElement::Y());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- Координаты и отступ стрелки
   int l_y=CElement::Y()+2;
   m_arrow.Y(l_y);
   m_arrow.Y_Distance(l_y);
   m_arrow.YGap(l_y-m_wnd.Y());
//--- Координаты и отступ картинки
   l_y=CElement::Y()+2;
   m_icon.Y(l_y);
   m_icon.Y_Distance(l_y);
   m_icon.YGap(l_y-m_wnd.Y());
//--- Координаты и отступ текстовой метки
   l_y=CElement::Y()+m_label_y_gap;
   m_label.Y(l_y);
   m_label.Y_Distance(l_y);
   m_label.YGap(l_y-m_wnd.Y());
  }
//+------------------------------------------------------------------+
//| Обновление ширины                                                |
//+------------------------------------------------------------------+
void CTreeItem::UpdateWidth(const int width)
  {
//--- Ширина фона
   CElement::XSize(width);
   m_area.XSize(width);
   m_area.X_Size(width);
//--- Ширина текстовой метки
   int w=CElement::X2()-m_label.X()-1;
   m_label.XSize(w);
   m_label.X_Size(w);
  }
//+------------------------------------------------------------------+
//| Изменение цвета пункта относительно указанного состояния         |
//+------------------------------------------------------------------+
void CTreeItem::HighlightItemState(const bool state)
  {
   m_area.BackColor((state)? m_item_back_color_selected : m_item_back_color);
   m_label.BackColor((state)? m_item_back_color_selected : m_item_back_color);
   m_label.BorderColor((state)? m_item_back_color_selected : m_item_back_color);
   m_label.Color((state)? m_item_text_color_selected : m_item_text_color);
   m_arrow.BmpFileOn((state)? "::"+m_item_arrow_selected_file_on : "::"+m_item_arrow_file_on);
   m_arrow.BmpFileOff((state)? "::"+m_item_arrow_selected_file_off : "::"+m_item_arrow_file_off);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CTreeItem::ChangeObjectsColor(void)
  {
   if(CElement::MouseFocus())
     {
      m_area.BackColor(m_item_back_color_hover);
      m_label.BackColor(m_item_back_color_hover);
      m_label.BorderColor(m_item_back_color_hover);
      m_label.Color(m_item_text_color_hover);
     }
   else
     {
      m_area.BackColor(m_item_back_color);
      m_label.BackColor(m_item_back_color);
      m_label.BorderColor(m_item_back_color);
      m_label.Color(m_item_text_color);
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CTreeItem::Moving(const int x,const int y)
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
   m_arrow.X(x+m_arrow.XGap());
   m_arrow.Y(y+m_arrow.YGap());
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_arrow.X_Distance(m_arrow.X());
   m_arrow.Y_Distance(m_arrow.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CTreeItem::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_arrow.Timeframes(OBJ_ALL_PERIODS);
   m_icon.Timeframes(OBJ_ALL_PERIODS);
   m_label.Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CTreeItem::Hide(void)
  {
//--- Выйти, если элемент уже скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_arrow.Timeframes(OBJ_NO_PERIODS);
   m_icon.Timeframes(OBJ_NO_PERIODS);
   m_label.Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CTreeItem::Reset(void)
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
void CTreeItem::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_arrow.Delete();
   m_icon.Delete();
   m_label.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CTreeItem::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_arrow.Z_Order(m_arrow_zorder);
   m_icon.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CTreeItem::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_arrow.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Сброс цвета                                                      |
//+------------------------------------------------------------------+
void CTreeItem::ResetColors(void)
  {
   m_area.BackColor(m_item_back_color);
   m_label.BackColor(m_item_back_color);
   m_label.BorderColor(m_item_back_color);
//--- Сброс фокуса
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
