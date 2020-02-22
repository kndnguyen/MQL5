//+------------------------------------------------------------------+
//|                                                     MenuItem.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс создания пункта меню                                       |
//+------------------------------------------------------------------+
class CMenuItem : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания пункта меню
   CRectLabel        m_area;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CBmpLabel         m_arrow;
   //--- Указатель на предыдущий узел
   CMenuItem        *m_prev_node;
   //--- Тип пункта меню
   ENUM_TYPE_MENU_ITEM m_type_menu_item;
   //--- Свойства фона
   int               m_area_zorder;
   color             m_area_border_color;
   color             m_area_color;
   color             m_area_color_hover;
   color             m_area_color_hover_off;
   //--- Свойства ярлыка
   string            m_icon_file_on;
   string            m_icon_file_off;
   //--- Свойства текстовой метки
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   //--- Свойства признака контекстного меню
   bool              m_show_right_arrow;
   string            m_right_arrow_file_on;
   string            m_right_arrow_file_off;
   //--- Общий приоритет на нажатие
   int               m_zorder;
   //--- Доступен/заблокирован
   bool              m_item_state;
   //--- Состояние чекбокса
   bool              m_checkbox_state;
   //--- Состояние радио-кнопки и её идентификатор
   bool              m_radiobutton_state;
   int               m_radiobutton_id;
   //--- Состояние контекстного меню
   bool              m_context_menu_state;
   //---
public:
                     CMenuItem(void);
                    ~CMenuItem(void);
   //--- Методы для создания пункта меню
   bool              CreateMenuItem(const long chart_id,const int subwin,const int index_number,const string label_text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   bool              CreateArrow(void);
   //--- Нажатие на пункте меню
   bool              OnClickMenuItem(const string clicked_object);
   //---
public:
   //--- (1) Сохраняет указатель формы
   //    (2) Получение и (3) сохранение указателя предыдущего узла
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);            }
   CMenuItem        *PrevNodePointer(void)                    const { return(m_prev_node);                   }
   void              PrevNodePointer(CMenuItem &object)             { m_prev_node=::GetPointer(object);      }
   //--- (1) Установка и получение типа, (2) номер индекса
   void              TypeMenuItem(const ENUM_TYPE_MENU_ITEM type)   { m_type_menu_item=type;                 }
   ENUM_TYPE_MENU_ITEM TypeMenuItem(void)                     const { return(m_type_menu_item);              }
   //--- Методы фона
   void              AreaBackColor(const color clr)                 { m_area_color=clr;                      }
   void              AreaBackColorHover(const color clr)            { m_area_color_hover=clr;                }
   void              AreaBackColorHoverOff(const color clr)         { m_area_color_hover_off=clr;            }
   void              AreaBorderColor(const color clr)               { m_area_border_color=clr;               }
   //--- Методы ярлыка
   void              IconFileOn(const string file_path)             { m_icon_file_on=file_path;              }
   void              IconFileOff(const string file_path)            { m_icon_file_off=file_path;             }
   //--- Методы текстовой метки
   string            LabelText(void)                          const { return(m_label.Description());         }
   void              LabelXGap(const int x_gap)                     { m_label_x_gap=x_gap;                   }
   void              LabelYGap(const int y_gap)                     { m_label_y_gap=y_gap;                   }
   void              LabelColor(const color clr)                    { m_label_color=clr;                     }
   void              LabelColorOff(const color clr)                 { m_label_color_off=clr;                 }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;               }
   //--- Методы признака наличия контекстного меню
   void              ShowRightArrow(const bool flag)                { m_show_right_arrow=flag;               }
   void              RightArrowFileOn(const string file_path)       { m_right_arrow_file_on=file_path;       }
   void              RightArrowFileOff(const string file_path)      { m_right_arrow_file_off=file_path;      }
   //--- Общее (1) состояние пункта и (2) пункта-чекбокса
   void              ItemState(const bool state);
   bool              ItemState(void)                          const { return(m_item_state);                  }
   void              CheckBoxState(const bool flag)                 { m_checkbox_state=flag;                 }
   bool              CheckBoxState(void)                      const { return(m_checkbox_state);              }
   //--- Идентификатор радио-пункта
   void              RadioButtonID(const int id)                    { m_radiobutton_id=id;                   }
   int               RadioButtonID(void)                      const { return(m_radiobutton_id);              }
   //--- Состояние радио-пункта
   void              RadioButtonState(const bool flag)              { m_radiobutton_state=flag;              }
   bool              RadioButtonState(void)                   const { return(m_radiobutton_state);           }
   //--- Состояние контекстного меню закреплённого за этим пунктом
   bool              ContextMenuState(void)                   const { return(m_context_menu_state);          }
   void              ContextMenuState(const bool flag)              { m_context_menu_state=flag;             }

   //--- Изменение цвета пункта относительно указанного состояния
   void              HighlightItemState(const bool state);
   //--- Изменение цвета объектов элемента
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
   //--- (1) Установка, (2) сброс приоритетов на нажитие левой кнопки мыши
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- Сбросить цвет
   virtual void      ResetColors(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMenuItem::CMenuItem(void) : m_type_menu_item(MI_SIMPLE),
                             m_context_menu_state(false),
                             m_item_state(true),
                             m_checkbox_state(true),
                             m_radiobutton_id(0),
                             m_radiobutton_state(false),
                             m_icon_file_on(""),
                             m_icon_file_off(""),
                             m_show_right_arrow(true),
                             m_right_arrow_file_on(""),
                             m_right_arrow_file_off(""),
                             m_area_color(C'15,15,15'),
                             m_area_color_hover(C'51,153,255'),
                             m_area_color_hover_off(C'70,80,90'),
                             m_area_border_color(C'15,15,15'),
                             m_label_x_gap(32),
                             m_label_y_gap(5),
                             m_label_color(clrWhite),
                             m_label_color_off(clrGray),
                             m_label_color_hover(C'85,170,255')
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим строгую последовательность приоритетов
   m_area_zorder =2;
   m_zorder      =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMenuItem::~CMenuItem(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CMenuItem::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора  
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Определим фокус
      int x=(int)lparam;
      int y=(int)dparam;
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CMenuItem::OnEventTimer(void)
  {
//--- Если окно доступно
   if(!m_wnd.IsLocked())
     {
      //--- Если статус отключенного контекстного меню
      if(!m_context_menu_state)
         //--- Изменение цвета объектов формы
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт элемент "Пункт меню"                                     |
//+------------------------------------------------------------------+
bool CMenuItem::CreateMenuItem(const long chart_id,const int subwin,const int index_number,const string label_text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием пункта меню классу нужно передать "
              "указатель на форму: CMenuItem::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Если указателя на предыдущий узел нет, то
//    предполагается независимый пункт меню, то есть такой, который не является часть контекстного меню
   if(::CheckPointer(m_prev_node)==POINTER_INVALID)
     {
      //--- Выйти, если установленный тип не соответствует
      if(m_type_menu_item!=MI_SIMPLE && m_type_menu_item!=MI_HAS_CONTEXT_MENU)
        {
         ::Print(__FUNCTION__," > Тип независимого пункта меню может быть только MI_SIMPLE или MI_HAS_CONTEXT_MENU, ",
                 "то есть, с наличием контекстного меню.\n",
                 __FUNCTION__," > Установить тип пункта меню можно с помощью метода CMenuItem::TypeMenuItem()");
         return(false);
        }
     }
//--- Инициализация переменных
   m_id           =m_wnd.LastId()+1;
   m_index        =index_number;
   m_chart_id     =chart_id;
   m_subwin       =subwin;
   m_label_text   =label_text;
   m_x            =x;
   m_y            =y;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание пункта меню
   if(!CreateArea())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateArrow())
      return(false);
//--- Если форма свёрнуто, то скрыть элемент после создания
   if(m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь пункта меню                                      |
//+------------------------------------------------------------------+
bool CMenuItem::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_menuitem_area_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Установим фон пункта меню
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
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт ярлык пункта                                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_white.bmp"
//---
bool CMenuItem::CreateIcon(void)
  {
//--- Если это простой пункт или пункт содержащий в себе контекстное меню
   if(m_type_menu_item==MI_SIMPLE || m_type_menu_item==MI_HAS_CONTEXT_MENU)
     {
      //--- Если ярлык не нужен (картинка не определена), выйдем
      if(m_icon_file_on=="" || m_icon_file_off=="")
         return(true);
     }
//--- Если это чекбокс
   else if(m_type_menu_item==MI_CHECKBOX)
     {
      //--- Если картинка не определена, установка по умолчанию
      if(m_icon_file_on=="")
         m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_white.bmp";
      if(m_icon_file_off=="")
         m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_gray.bmp";
     }
//--- Если это радио-пункт     
   else if(m_type_menu_item==MI_RADIOBUTTON)
     {
      //--- Если картинка не определена, установка по умолчанию
      if(m_icon_file_on=="")
         m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_white.bmp";
      if(m_icon_file_off=="")
         m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_gray.bmp";
     }
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_menuitem_icon_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты объекта
   int x =m_x+7;
   int y =m_y+4;
//--- Установим ярлык
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_icon.BmpFileOn("::"+m_icon_file_on);
   m_icon.BmpFileOff("::"+m_icon_file_off);
   m_icon.State(m_item_state);
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
//| Создаёт текстовую метку пункта меню                              |
//+------------------------------------------------------------------+
bool CMenuItem::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_menuitem_lable_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты объекта
   int x =m_x+m_label_x_gap;
   int y =m_y+m_label_y_gap;
//--- Цвет текста зависит от текущего состояния (доступен/заблокирован)
   color label_color=(m_item_state)? m_label_color : m_label_color_off;
//--- Установим текстовую метку
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
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт стрелку (признак выпадающего контекстного меню)          |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp"
//---
bool CMenuItem::CreateArrow(void)
  {
//--- Выйдем, если пункт не имеет выпадающего меню или стрелка не нужна
   if(m_type_menu_item!=MI_HAS_CONTEXT_MENU || !m_show_right_arrow)
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_menuitem_arrow_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты объекта
   int x =m_x+CElement::XSize()-16;
   int y =m_y+4;
//--- Если не указали картинку для стрелки, значит установка по умолчанию
   if(m_right_arrow_file_on=="")
      m_right_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\RightTransp_white.bmp";
   if(m_right_arrow_file_off=="")
      m_right_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\RightTransp.bmp";
//--- Установим стрелку
   if(!m_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_arrow.BmpFileOn("::"+m_right_arrow_file_on);
   m_arrow.BmpFileOff("::"+m_right_arrow_file_off);
   m_arrow.State(false);
   m_arrow.Corner(m_corner);
   m_arrow.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_arrow.Selectable(false);
   m_arrow.Z_Order(m_zorder);
   m_arrow.Tooltip("\n");
//--- Отступы от крайней точки
   m_arrow.XGap(x-m_wnd.X());
   m_arrow.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_arrow);
   return(true);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CMenuItem::ChangeObjectsColor(void)
  {
//--- Выйти, если у этого пункта есть контекстное меню и оно включено
   if(m_type_menu_item==MI_HAS_CONTEXT_MENU && m_context_menu_state)
      return;
//--- Блок кода для простых пунктов и пунктов содержащих в себе контекстное меню
   if(m_type_menu_item==MI_HAS_CONTEXT_MENU || m_type_menu_item==MI_SIMPLE)
     {
      //--- Если есть фокус
      if(CElement::MouseFocus())
        {
         //Print(__FUNCSIG__," >>> index: ",m_index,"; text: ",m_label_text);
         m_icon.State(m_item_state);
         m_area.BackColor((m_item_state)? m_area_color_hover : m_area_color_hover_off);
         m_label.Color((m_item_state)? m_label_color_hover : m_label_color_off);
         if(m_item_state)
            m_arrow.State(true);
        }
      //--- Если нет фокуса
      else
        {
         m_arrow.State(false);
         m_area.BackColor(m_area_color);
         m_label.Color((m_item_state)? m_label_color : m_label_color_off);
        }
     }
//--- Блок код для пунктов-чекбоксов и радио-пунктов
   else if(m_type_menu_item==MI_CHECKBOX || m_type_menu_item==MI_RADIOBUTTON)
     {
      m_icon.State(CElement::MouseFocus());
      m_area.BackColor((CElement::MouseFocus())? m_area_color_hover : m_area_color);
      m_label.Color((CElement::MouseFocus())? m_label_color_hover : m_label_color);
     }
  }
//+------------------------------------------------------------------+
//| Изменение состояния пункта меню                                  |
//+------------------------------------------------------------------+
void CMenuItem::ItemState(const bool state)
  {
   m_item_state=state;
   m_icon.State(state);
   m_label.Color((state)? m_label_color : m_label_color_off);
  }
//+------------------------------------------------------------------+
//| Изменение цвета пункта относительно указанного состояния         |
//+------------------------------------------------------------------+
void CMenuItem::HighlightItemState(const bool state)
  {
   m_area.BackColor((state)? m_area_color_hover : m_area_color);
   m_label.Color((state)? m_label_color_hover : m_label_color);
   m_arrow.State(state);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CMenuItem::Moving(const int x,const int y)
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
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_arrow.X(x+m_arrow.XGap());
   m_arrow.Y(y+m_arrow.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_arrow.X_Distance(m_arrow.X());
   m_arrow.Y_Distance(m_arrow.Y());
  }
//+------------------------------------------------------------------+
//| Делает видимым пункт меню                                        |
//+------------------------------------------------------------------+
void CMenuItem::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Отключить подсветку выделенного пункта
   HighlightItemState(false);
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Если это чекбокс, то с учётом его состояния
   if(m_type_menu_item==MI_CHECKBOX)
      m_icon.Timeframes((m_checkbox_state)? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
//--- Если это радио-пункт, то с учётом его состояния
   else if(m_type_menu_item==MI_RADIOBUTTON)
      m_icon.Timeframes((m_radiobutton_state)? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
//--- Обнуление переменных
   CElement::IsVisible(true);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CMenuItem::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Обнуление переменных
   m_context_menu_state=false;
   CElement::IsVisible(false);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CMenuItem::Reset(void)
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
void CMenuItem::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_arrow.Delete();
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
void CMenuItem::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_icon.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_arrow.Z_Order(m_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CMenuItem::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
   m_arrow.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Сброс цвета пункта                                               |
//+------------------------------------------------------------------+
void CMenuItem::ResetColors(void)
  {
   m_area.BackColor(m_area_color);
   m_label.Color(m_label_color);
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на пункте меню                                 |
//+------------------------------------------------------------------+
bool CMenuItem::OnClickMenuItem(const string clicked_object)
  {
//--- Проверка по имени объекта
   if(m_area.Name()!=clicked_object)
      return(false);
//--- Выйдем, если пункт неактивирован
   if(!m_item_state)
      return(false);
//--- Если этот пункт содержит контекстное меню
   if(m_type_menu_item==MI_HAS_CONTEXT_MENU)
     {
      //--- Если выпадающее меню этого пункта не активировано
      if(!m_context_menu_state)
        {
         //--- Присвоим статус включенного контекстного меню
         m_context_menu_state=true;
        }
      else
        {
         //--- Присвоим статус отключенного контекстного меню
         m_context_menu_state=false;
         //--- Отправим сигнал для закрытия контекстных меню, которые дальше этого пункта
         ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
        }
      return(true);
     }
//--- Если этот пункт не содержит контекстное меню, но является частью контекстного меню
   else
     {
      //--- Префикс сообщения с именем программы
      string message=CElement::ProgramName();
      //--- Если это чекбокс, изменим его состояние
      if(m_type_menu_item==MI_CHECKBOX)
        {
         m_checkbox_state=(m_checkbox_state)? false : true;
         m_icon.Timeframes((m_checkbox_state)? OBJ_NO_PERIODS : OBJ_ALL_PERIODS);
         //--- Добавим в сообщение, что это чекбокс
         message+="_checkbox";
        }
      //--- Если это радио-пункт, изменим его состояние
      else if(m_type_menu_item==MI_RADIOBUTTON)
        {
         m_radiobutton_state=(m_radiobutton_state)? false : true;
         m_icon.Timeframes((m_radiobutton_state)? OBJ_NO_PERIODS : OBJ_ALL_PERIODS);
         //--- Добавим в сообщение, что это радио-пункт
         message+="_radioitem_"+(string)m_radiobutton_id;
        }
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_CLICK_MENU_ITEM,CElement::Id(),CElement::Index(),message);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
