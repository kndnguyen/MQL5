//+------------------------------------------------------------------+
//|                                                  SplitButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "ContextMenu.mqh"
//+------------------------------------------------------------------+
//| Класс для создания сдвоенной кнопки                              |
//+------------------------------------------------------------------+
class CSplitButton : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания кнопки
   CButton           m_button;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CEdit             m_drop_button;
   CBmpLabel         m_drop_arrow;
   CContextMenu      m_drop_menu;
   //--- Свойства кнопки:
   //    Размер и приоритет кнопки на нажатие левой кнопкой мыши
   int               m_button_x_size;
   int               m_button_y_size;
   int               m_button_zorder;
   //--- Цвета фона
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_pressed;
   color             m_back_color_hover;
   color             m_back_color_array[];
   //--- Цвета рамки
   color             m_border_color;
   color             m_border_color_off;
   color             m_border_color_hover;
   color             m_border_color_array[];
   //--- Размер и приоритет кнопки с выпадающим меню на нажатие левой кнопкой мыши
   int               m_drop_button_x_size;
   int               m_drop_button_zorder;
   //--- Отступы ярлыка
   int               m_drop_arrow_x_gap;
   int               m_drop_arrow_y_gap;
   //--- Ярлыки кнопки с выпадающим меню в активном и заблокированном состоянии
   string            m_drop_arrow_file_on;
   string            m_drop_arrow_file_off;
   //--- Отступы ярлыка
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- Ярлыки кнопки в активном и заблокированном состоянии
   string            m_icon_file_on;
   string            m_icon_file_off;
   //--- Текст и отступы текстовой метки
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвета текстовой метки
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   color             m_label_color_array[];
   //--- Общий приоритет для некликабельных объектов
   int               m_zorder;
   //--- Доступен/заблокирован
   bool              m_button_state;
   //--- Состояние контекстного меню 
   bool              m_drop_menu_state;
   //---
public:
                     CSplitButton(void);
                    ~CSplitButton(void);
   //--- Методы для создания кнопки
   bool              CreateSplitButton(const long chart_id,const string button_text,const int window,const int x,const int y);
   //---
private:
   bool              CreateButton(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   bool              CreateDropButton(void);
   bool              CreateDropIcon(void);
   bool              CreateDropMenu(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) получение указателя контекстного меню,
   //    (3) общее состояние кнопки (доступен/заблокирован)
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);         }
   CContextMenu     *GetContextMenuPointer(void)              { return(::GetPointer(m_drop_menu));  }
   bool              ButtonState(void)                  const { return(m_button_state);             }
   void              ButtonState(const bool state);
   //--- Размер главной кнопки и кнопки с выпадающим меню
   void              ButtonXSize(const int x_size)            { m_button_x_size=x_size;             }
   void              ButtonYSize(const int y_size)            { m_button_y_size=y_size;             }
   void              DropButtonXSize(const int x_size)        { m_drop_button_x_size=x_size;        }
   //--- Установка цвета рамки кнопки
   void              BorderColor(const color clr)             { m_border_color=clr;                 }
   void              BorderColorOff(const color clr)          { m_border_color_off=clr;             }
   void              BorderColorHover(const color clr)        { m_border_color_hover=clr;           }
   //--- Установка ярлыков для кнопки в активном и заблокированном состояниях
   void              IconFileOn(const string file_path)       { m_icon_file_on=file_path;           }
   void              IconFileOff(const string file_path)      { m_icon_file_off=file_path;          }
   //--- Отступы ярлыка
   void              IconXGap(const int x_gap)                { m_icon_x_gap=x_gap;                 }
   void              IconYGap(const int y_gap)                { m_icon_y_gap=y_gap;                 }
   //--- Цвета фона
   void              BackColor(const color clr)               { m_back_color=clr;                   }
   void              BackColorOff(const color clr)            { m_back_color_off=clr;               }
   void              BackColorHover(const color clr)          { m_back_color_hover=clr;             }
   void              BackColorPressed(const color clr)        { m_back_color_pressed=clr;           }
   //--- (1) Текст и (2) отступы текстовой метки
   string            Text(void)                         const { return(m_label.Description());      }
   void              LabelXGap(const int x_gap)               { m_label_x_gap=x_gap;                }
   void              LabelYGap(const int y_gap)               { m_label_y_gap=y_gap;                }
   //--- Цвета текстовой метки
   void              LabelColor(const color clr)              { m_label_color=clr;                  }
   void              LabelColorOff(const color clr)           { m_label_color_off=clr;              }
   void              LabelColorHover(const color clr)         { m_label_color_hover=clr;            }
   void              LabelColorPressed(const color clr)       { m_label_color_pressed=clr;          }
   //--- Установка ярлыков для кнопки с выпадающим меню в активном и заблокированном состояниях
   void              DropArrowFileOn(const string file_path)  { m_drop_arrow_file_on=file_path;     }
   void              DropArrowFileOff(const string file_path) { m_drop_arrow_file_off=file_path;    }
   //--- Отступы ярлыка
   void              DropArrowXGap(const int x_gap)           { m_drop_arrow_x_gap=x_gap;           }
   void              DropArrowYGap(const int y_gap)           { m_drop_arrow_y_gap=y_gap;           }
   //--- Добавляет пункт меню с указанными свойствами до создания контекстного меню
   void              AddItem(const string text,const string path_bmp_on,const string path_bmp_off);
   //--- Добавляет разделительную линию после указанного пункта до создания контекстного меню
   void              AddSeparateLine(const int item_index);
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
   //---
private:
   //--- Обработка нажатия на кнопку
   bool              OnClickButton(const string clicked_object);
   //--- Обработка нажатия на кнопку с выпадающим меню
   bool              OnClickDropButton(const string clicked_object);
   //--- Проверка нажатой левой кнопки мыши над сдвоенной кнопкой
   void              CheckPressedOverButton(const bool mouse_state);
   //--- Скрывает выпадающее меню
   void              HideDropDownMenu(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CSplitButton::CSplitButton(void) : m_drop_menu_state(false),
                                   m_button_state(true),
                                   m_icon_x_gap(4),
                                   m_icon_y_gap(3),
                                   m_label_x_gap(25),
                                   m_label_y_gap(4),
                                   m_drop_arrow_x_gap(0),
                                   m_drop_arrow_y_gap(3),
                                   m_drop_arrow_file_on(""),
                                   m_drop_arrow_file_off(""),
                                   m_icon_file_on(""),
                                   m_icon_file_off(""),
                                   m_button_y_size(18),
                                   m_border_color(clrWhite),
                                   m_border_color_off(clrWhite),
                                   m_border_color_hover(clrWhite),
                                   m_back_color(clrSilver),
                                   m_back_color_off(clrLightGray),
                                   m_back_color_hover(C'193,218,255'),
                                   m_back_color_pressed(clrBlack),
                                   m_label_color(clrBlack),
                                   m_label_color_off(clrDarkGray),
                                   m_label_color_hover(clrBlack),
                                   m_label_color_pressed(clrBlack)
  {
//--- Сохраним имя класса элемента в базовом классе  
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder             =0;
   m_button_zorder      =1;
   m_drop_button_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSplitButton::~CSplitButton(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CSplitButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_drop_button.MouseFocus(x>m_drop_button.X() && x<m_drop_button.X2() && 
                               y>m_drop_button.Y() && y<m_drop_button.Y2());
      //--- Выйти, если кнопка заблокирована
      if(!m_button_state)
         return;
      //--- Вне области элемента и с нажатой кнопкой мыши
      if(!CElement::MouseFocus() && sparam=="1")
        {
         //--- Выйти, если фокус в контекстном меню
         if(m_drop_menu.MouseFocus())
            return;
         //--- Скрыть выпадающее меню
         HideDropDownMenu();
         return;
        }
      //--- Проверка нажатой левой кнопки мыши над сдвоенной кнопкой
      CheckPressedOverButton(bool((int)sparam));
      return;
     }
//--- Обработка события нажатия на пункте свободного меню
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_FREEMENU_ITEM)
     {
      //--- Выйти, если идентификаторы не совпадают
      if(CElement::Id()!=lparam)
         return;
      //--- Скрыть выпадающее меню
      HideDropDownMenu();
      //--- Отправим сообщение
      ::EventChartCustom(m_chart_id,ON_CLICK_CONTEXTMENU_ITEM,lparam,dparam,sparam);
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Нажатие на основной кнопке
      if(OnClickButton(sparam))
         return;
      //--- Нажатие на кнопке с выпадающим меню
      if(OnClickDropButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CSplitButton::OnEventTimer(void)
  {
//--- Если элемент является выпадающим
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- Если форма и кнопка не заблокированы
      if(!m_wnd.IsLocked() && m_button_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт элемент "Кнопка"                                         |
//+------------------------------------------------------------------+
bool CSplitButton::CreateSplitButton(const long chart_id,const string button_text,const int window,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием кнопки классу нужно передать "
              "указатель на форму: CSplitButton::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =window;
   m_x          =x;
   m_y          =y;
   m_label_text =button_text;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание кнопки
   if(!CreateButton())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateDropButton())
      return(false);
   if(!CreateDropIcon())
      return(false);
   if(!CreateDropMenu())
      return(false);
//--- Скрыть список
   m_drop_menu.Hide();
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон кнопки                                               |
//+------------------------------------------------------------------+
bool CSplitButton::CreateButton(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_split_button_"+(string)CElement::Id();
//--- Установим фон
   if(!m_button.Create(m_chart_id,name,m_subwin,m_x,m_y,m_button_x_size,m_button_y_size))
      return(false);
//--- Установим свойства
   m_button.Font(FONT);
   m_button.FontSize(FONT_SIZE);
   m_button.Color(m_back_color);
   m_button.Description("");
   m_button.BorderColor(m_border_color);
   m_button.BackColor(m_back_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_button_zorder);
   m_button.Tooltip("\n");
//--- Сохраним размеры
   CElement::XSize(m_button_x_size);
   CElement::YSize(m_button_y_size);
//--- Отступы от крайней точки
   m_button.XGap(m_x-m_wnd.X());
   m_button.YGap(m_y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт картинку кнопки                                          |
//+------------------------------------------------------------------+
bool CSplitButton::CreateIcon(void)
  {
//--- Выйдем, если ярлык не нужен
   if(m_icon_file_on=="" || m_icon_file_off=="")
      return(true);
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_split_button_bmp_"+(string)CElement::Id();
//--- Координаты
   int x =m_x+m_icon_x_gap;
   int y =m_y+m_icon_y_gap;
//--- Установим картинку
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_icon.BmpFileOn("::"+m_icon_file_on);
   m_icon.BmpFileOff("::"+m_icon_file_off);
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
//| Создаёт надпись кнопки                                           |
//+------------------------------------------------------------------+
bool CSplitButton::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_split_button_lable_"+(string)CElement::Id();
//--- Координаты
   int x =m_x+m_label_x_gap;
   int y =m_y+m_label_y_gap;
//--- Установим текстовую метку
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
//--- Отступы от крайней точки
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку комбо-бокса                                       |
//+------------------------------------------------------------------+
bool CSplitButton::CreateDropButton(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_split_button_drop_button_"+(string)CElement::Id();
//--- Координаты
   int x =m_x+m_x_size-m_drop_button_x_size;
   int y =m_y;
//--- Установим кнопку
   if(!m_drop_button.Create(m_chart_id,name,m_subwin,x,y,m_drop_button_x_size,m_button_y_size))
      return(false);
//--- Установим свойства
   m_drop_button.Font(FONT);
   m_drop_button.FontSize(FONT_SIZE);
   m_drop_button.Color(clrNONE);
   m_drop_button.Description("");
   m_drop_button.BackColor(m_back_color);
   m_drop_button.BorderColor(m_border_color);
   m_drop_button.Corner(m_corner);
   m_drop_button.Anchor(m_anchor);
   m_drop_button.Selectable(false);
   m_drop_button.Z_Order(m_drop_button_zorder);
   m_drop_button.ReadOnly(true);
   m_drop_button.Tooltip("\n");
//--- Сохраним координаты
   m_drop_button.X(x);
   m_drop_button.Y(y);
//--- Сохраним размеры
   m_drop_button.XSize(m_drop_button_x_size);
   m_drop_button.YSize(m_button_y_size);
//--- Отступы от крайней точки
   m_drop_button.XGap(x-m_wnd.X());
   m_drop_button.YGap(y-m_wnd.Y());
//--- Инициализация массивов градиента
   CElement::InitColorArray(m_border_color,m_border_color_hover,m_border_color_array);
   CElement::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_drop_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт картинку на комбо-боксе                                  |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
//---
bool CSplitButton::CreateDropIcon(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_split_button_combobox_icon_"+(string)CElement::Id();
//--- Координаты
   int x =m_drop_button.X()+m_drop_arrow_x_gap;
   int y =m_drop_button.Y()+m_drop_arrow_y_gap;
//--- Если не указали картинку для стрелки, значит установка по умолчанию
   if(m_drop_arrow_file_on=="")
      m_drop_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp";
   if(m_drop_arrow_file_off=="")
      m_drop_arrow_file_off="Images\\EasyAndFastGUI\\Controls\\DropOff.bmp";
//--- Установим картинку
   if(!m_drop_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_drop_arrow.BmpFileOn("::"+m_drop_arrow_file_on);
   m_drop_arrow.BmpFileOff("::"+m_drop_arrow_file_off);
   m_drop_arrow.State(true);
   m_drop_arrow.Corner(m_corner);
   m_drop_arrow.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_drop_arrow.Selectable(false);
   m_drop_arrow.Z_Order(m_zorder);
   m_drop_arrow.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_drop_arrow.XSize(m_drop_arrow.X_Size());
   m_drop_arrow.YSize(m_drop_arrow.Y_Size());
//--- Сохраним координаты
   m_drop_arrow.X(x);
   m_drop_arrow.Y(y);
//--- Отступы от крайней точки
   m_drop_arrow.XGap(x-m_wnd.X());
   m_drop_arrow.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_drop_arrow);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт выпадающее меню                                          |
//+------------------------------------------------------------------+
bool CSplitButton::CreateDropMenu(void)
  {
//--- Передать объект панели
   m_drop_menu.WindowPointer(m_wnd);
//--- Свободное контекстное меню
   m_drop_menu.FreeContextMenu(true);
//--- Координаты
   int x=m_x;
   int y=m_y+m_y_size;
//--- Установим свойства
   m_drop_menu.Id(CElement::Id());
   m_drop_menu.XSize((m_drop_menu.XSize()>0)? m_drop_menu.XSize() : m_button_x_size);
//--- Установим контекстное меню
   if(!m_drop_menu.CreateContextMenu(m_chart_id,m_subwin,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет пункт меню                                             |
//+------------------------------------------------------------------+
void CSplitButton::AddItem(const string text,const string path_bmp_on,const string path_bmp_off)
  {
   m_drop_menu.AddItem(text,path_bmp_on,path_bmp_off,MI_SIMPLE);
  }
//+------------------------------------------------------------------+
//| Добавляет разделительную линию                                   |
//+------------------------------------------------------------------+
void CSplitButton::AddSeparateLine(const int item_index)
  {
   m_drop_menu.AddSeparateLine(item_index);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CSplitButton::SetZorders(void)
  {
   m_icon.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_drop_arrow.Z_Order(m_zorder);
   m_drop_button.Z_Order(m_drop_button_zorder);
   m_button.Z_Order(m_button_zorder);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CSplitButton::ResetZorders(void)
  {
   m_button.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
   m_drop_button.Z_Order(0);
   m_drop_arrow.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Показывает кнопку                                                |
//+------------------------------------------------------------------+
void CSplitButton::Show(void)
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
//| Скрывает кнопку                                                  |
//+------------------------------------------------------------------+
void CSplitButton::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть список
   m_drop_menu.Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CSplitButton::Reset(void)
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
void CSplitButton::Delete(void)
  {
//--- Удаление объектов
   m_button.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_drop_button.Delete();
   m_drop_arrow.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CSplitButton::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_button.X(x+m_button.XGap());
   m_button.Y(y+m_button.YGap());
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_drop_button.X(x+m_drop_button.XGap());
   m_drop_button.Y(y+m_drop_button.YGap());
   m_drop_arrow.X(x+m_drop_arrow.XGap());
   m_drop_arrow.Y(y+m_drop_arrow.YGap());
//--- Обновление координат графических объектов
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_drop_button.X_Distance(m_drop_button.X());
   m_drop_button.Y_Distance(m_drop_button.Y());
   m_drop_arrow.X_Distance(m_drop_arrow.X());
   m_drop_arrow.Y_Distance(m_drop_arrow.Y());
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CSplitButton::ChangeObjectsColor(void)
  {
   ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
   ChangeObjectColor(m_drop_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
   ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
   ChangeObjectColor(m_drop_button.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_border_color,m_border_color_hover,m_border_color_array);
  }
//+------------------------------------------------------------------+
//| Изменение состояния кнопки                                       |
//+------------------------------------------------------------------+
void CSplitButton::ButtonState(const bool state)
  {
   m_button_state=state;
//--- Установить цвета объектам согласно текущему состоянию
   m_icon.State(state);
   m_label.Color((state)? m_label_color : m_label_color_off);
   m_button.State(false);
   m_button.BackColor((state)? m_back_color : m_back_color_off);
   m_button.BorderColor((state)? m_border_color : m_border_color_off);
   m_drop_button.BackColor((state)? m_back_color : m_back_color_off);
   m_drop_button.BorderColor((state)? m_border_color : m_border_color_off);
   m_drop_arrow.State(state);
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку                                                |
//+------------------------------------------------------------------+
bool CSplitButton::OnClickButton(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта  
   if(clicked_object!=m_button.Name())
      return(false);
//--- Выйти, если кнопка заблокирована
   if(!m_button_state)
     {
      //--- Отожмём кнопку
      m_button.State(false);
      return(false);
     }
//--- Скроем меню
   m_drop_menu.Hide();
   m_drop_menu_state=false;
//--- Отожмём кнопку и установим цвет фокуса
   m_button.State(false);
   m_button.BackColor(m_back_color_hover);
   m_drop_button.BackColor(m_back_color_hover);
//--- Разблокируем форму
   m_wnd.IsLocked(false);
   m_wnd.IdActivatedElement(WRONG_VALUE);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку с выпадающим меню                              |
//+------------------------------------------------------------------+
bool CSplitButton::OnClickDropButton(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта  
   if(clicked_object!=m_drop_button.Name())
      return(false);
//--- Выйти, если кнопка заблокирована
   if(!m_button_state)
     {
      //--- Отожмём кнопку
      m_button.State(false);
      return(false);
     }
//--- Если список открыт, скроем его
   if(m_drop_menu_state)
     {
      m_drop_menu_state=false;
      m_drop_menu.Hide();
      m_button.BackColor(m_back_color_hover);
      m_drop_button.BackColor(m_back_color_hover);
      //--- Разблокируем форму и обнулим id элемента-активатора
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
//--- Если список скрыт, откроем его
   else
     {
      m_drop_menu_state=true;
      m_drop_menu.Show();
      m_button.BackColor(m_back_color_hover);
      m_drop_button.BackColor(m_back_color_pressed);
      //--- Заблокируем форму и сохраним id элемента-активатора
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверка нажатой левой кнопки мыши над сдвоенной кнопкой         |
//+------------------------------------------------------------------+
void CSplitButton::CheckPressedOverButton(const bool mouse_state)
  {
//--- Выйти, если вне области элемента
   if(!CElement::MouseFocus())
      return;
//--- Выйти, если форма заблокирована и идентификаторы формы и этого элемента не совпадают
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- Кнопка мыши нажата
   if(mouse_state)
     {
      //--- В зоне кнопки меню
      if(m_drop_button.MouseFocus())
        {
         m_button.BackColor(m_back_color_hover);
         m_drop_button.BackColor(m_back_color_pressed);
        }
      else
        {
         m_button.BackColor(m_back_color_pressed);
         m_drop_button.BackColor(m_back_color_pressed);
        }
     }
//--- Кнопка мыши отжата
   else
     {
      if(m_drop_menu_state)
        {
         m_button.BackColor(m_back_color_hover);
         m_drop_button.BackColor(m_back_color_pressed);
        }
     }
  }
//+------------------------------------------------------------------+
//| Скрывает выпадающее меню                                         |
//+------------------------------------------------------------------+
void CSplitButton::HideDropDownMenu(void)
  {
//--- Скрыть меню и установить соответствующие признаки
   m_drop_menu.Hide();
   m_drop_menu_state=false;
   m_button.BackColor(m_back_color);
   m_drop_button.BackColor(m_back_color);
//--- Разблокируем форму, если идентификаторы формы и этого элемента совпадают
   if(m_wnd.IdActivatedElement()==CElement::Id())
     {
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
  }
//+------------------------------------------------------------------+
