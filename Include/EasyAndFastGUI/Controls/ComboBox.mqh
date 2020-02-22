//+------------------------------------------------------------------+
//|                                                     ComboBox.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "ListView.mqh"
//+------------------------------------------------------------------+
//| Класс для создания комбинированного списка                       |
//+------------------------------------------------------------------+
class CComboBox : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания комбо-бокса
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_button;
   CBmpLabel         m_drop_arrow;
   CListView         m_listview;
   //--- Свойства комбо-бокса:
   //    Цвет общего фона
   color             m_area_color;
   //--- Текст и отступы текстовой метки
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвета текстовой метки в разных состояниях
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_array[];
   //--- (1) Текст кнопки и (2) её размеры
   string            m_button_text;
   int               m_button_x_size;
   int               m_button_y_size;
   //--- Цвета кнопки в разных состояниях
   color             m_button_color;
   color             m_button_color_off;
   color             m_button_color_hover;
   color             m_button_color_pressed;
   color             m_button_color_array[];
   //--- Цвета рамки кнопки в разных состояних
   color             m_button_border_color;
   color             m_button_border_color_off;
   color             m_button_border_color_hover;
   color             m_button_border_color_array[];
   //--- Цвет текста кнопки в разных состояних
   color             m_button_text_color;
   color             m_button_text_color_off;
   //--- Отступы ярлыка
   int               m_drop_arrow_x_gap;
   int               m_drop_arrow_y_gap;
   //--- Ярлыки кнопки с выпадающим меню в активном и заблокированном состоянии
   string            m_drop_arrow_file_on;
   string            m_drop_arrow_file_off;
   //--- Приоритеты на нажатие левой кнопкой мыши
   int               m_area_zorder;
   int               m_button_zorder;
   int               m_zorder;
   //--- Доступен/заблокирован
   bool              m_combobox_state;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //---
public:
                     CComboBox(void);
                    ~CComboBox(void);
   //--- Методы для создания комбо-бокса
   bool              CreateComboBox(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateButton(void);
   bool              CreateDropArrow(void);
   bool              CreateList(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, возвращает указатели на (2) список и (3) полосу прокрутки
   void              WindowPointer(CWindow &object)                   { m_wnd=::GetPointer(object);                      }
   CListView        *GetListViewPointer(void)                         { return(::GetPointer(m_listview));                }
   CScrollV         *GetScrollVPointer(void)                          { return(m_listview.GetScrollVPointer());          }
   //--- Установка (1) размера списка (количество пунктов) и (2) видимой его части, (3) получение и установка состояния элемента
   void              ItemsTotal(const int items_total)                { m_listview.ListSize(items_total);                }
   void              VisibleItemsTotal(const int visible_items_total) { m_listview.VisibleListSize(visible_items_total); }
   bool              ComboBoxState(void)                        const { return(m_combobox_state);                        }
   void              ComboBoxState(const bool state);
   //--- (1) Цвет фона, (2) устанавливает и (3) возвращает значение текстовой метки
   void              AreaColor(const color clr)                       { m_area_color=clr;                                }
   void              LabelText(const string label_text)               { m_label_text=label_text;                         }
   string            LabelText(void)                            const { return(m_label_text);                            }
   //--- Отступы текстовой метки
   void              LabelXGap(const int x_gap)                       { m_label_x_gap=x_gap;                             }
   void              LabelYGap(const int y_gap)                       { m_label_y_gap=y_gap;                             }
   //--- (1) Возвращает текст кнопки, (2) установка размеров кнопки
   string            ButtonText(void)                           const { return(m_button_text);                           }
   void              ButtonXSize(const int x_size)                    { m_button_x_size=x_size;                          }
   void              ButtonYSize(const int y_size)                    { m_button_y_size=y_size;                          }
   //--- (1) Цвет фона, (2) цвета текстовой метки
   void              LabelColor(const color clr)                      { m_label_color=clr;                               }
   void              LabelColorOff(const color clr)                   { m_label_color_off=clr;                           }
   void              LabelColorHover(const color clr)                 { m_label_color_hover=clr;                         }
   //--- Цвета кнопки
   void              ButtonBackColor(const color clr)                 { m_button_color=clr;                              }
   void              ButtonBackColorOff(const color clr)              { m_button_color_off=clr;                          }
   void              ButtonBackColorHover(const color clr)            { m_button_color_hover=clr;                        }
   void              ButtonBackColorPressed(const color clr)          { m_button_color_pressed=clr;                      }
   //--- Цвета рамки кнопки
   void              ButtonBorderColor(const color clr)               { m_button_border_color=clr;                       }
   void              ButtonBorderColorOff(const color clr)            { m_button_border_color_off=clr;                   }
   void              ButtonBorderColorHover(const color clr)          { m_button_border_color_hover=clr;                 }
   //--- Цвета текста кнопки
   void              ButtonTextColor(const color clr)                 { m_button_text_color=clr;                         }
   void              ButtonTextColorOff(const color clr)              { m_button_text_color_off=clr;                     }
   //--- Установка ярлыков для кнопки с выпадающим меню в активном и заблокированном состояниях
   void              DropArrowFileOn(const string file_path)          { m_drop_arrow_file_on=file_path;                  }
   void              DropArrowFileOff(const string file_path)         { m_drop_arrow_file_off=file_path;                 }
   //--- Отступы ярлыка
   void              DropArrowXGap(const int x_gap)                   { m_drop_arrow_x_gap=x_gap;                        }
   void              DropArrowYGap(const int y_gap)                   { m_drop_arrow_y_gap=y_gap;                        }

   //--- Сохраняет переданное значение в списке по указанному индексу
   void              ValueToList(const int item_index,const string item_text);
   //--- Выделение пункта по указанному индексу
   void              SelectedItemByIndex(const int index);
   //--- Изменение цвета объекта при наведении курсора
   void              ChangeObjectsColor(void);
   //--- Изменяет текущее состояние комбо-бокса на противоположное
   void              ChangeComboBoxListState(void);
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
   //--- Обработка нажатия на кнопку
   bool              OnClickButton(const string clicked_object);
   //--- Проверка нажатой левой кнопки мыши над кнопкой комбо-бокса
   void              CheckPressedOverButton(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CComboBox::CComboBox(void) : m_area_color(C'15,15,15'),
                             m_combobox_state(true),
                             m_label_text("combobox: "),
                             m_label_x_gap(0),
                             m_label_y_gap(2),
                             m_label_color(clrWhite),
                             m_label_color_off(clrGray),
                             m_label_color_hover(C'85,170,255'),
                             m_button_text(""),
                             m_button_y_size(18),
                             m_button_text_color(clrBlack),
                             m_button_text_color_off(clrDarkGray),
                             m_button_color(clrGainsboro),
                             m_button_color_off(clrLightGray),
                             m_button_color_hover(C'193,218,255'),
                             m_button_color_pressed(C'153,178,215'),
                             m_button_border_color(clrWhite),
                             m_button_border_color_off(clrWhite),
                             m_button_border_color_hover(C'85,170,255'),
                             m_drop_arrow_x_gap(16),
                             m_drop_arrow_y_gap(1),
                             m_drop_arrow_file_on(""),
                             m_drop_arrow_file_off("")
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Режим выпадающего списка
   m_listview.IsDropdown(true);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder        =0;
   m_area_zorder   =1;
   m_button_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CComboBox::~CComboBox(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CComboBox::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- Проверка фокуса над элементами
      CElement::MouseFocus(x>CElement::X() && x<CElement::X2() && 
                           y>CElement::Y() && y<CElement::Y2());
      m_button.MouseFocus(x>m_button.X() && x<m_button.X2() && 
                          y>m_button.Y() && y<m_button.Y2());
      //--- Проверка нажатой левой кнопки мыши над кнопкой
      CheckPressedOverButton();
      return;
     }
//--- Обработка события нажатия на пункте списка
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LIST_ITEM)
     {
      //--- Если идентификаторы совпадают
      if(lparam==CElement::Id())
        {
         //--- Запомнить и установить текст в кнопку
         m_button_text=m_listview.SelectedItemText();
         m_button.Description(m_listview.SelectedItemText());
         //--- Изменить состояние списка
         ChangeComboBoxListState();
         //--- Отправим сообщение об этом
         ::EventChartCustom(m_chart_id,ON_CLICK_COMBOBOX_ITEM,CElement::Id(),0,m_label_text);
        }
      //---
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Нажатие на кнопке комбо-бокса
      if(OnClickButton(sparam))
         return;
      //---
      return;
     }
//--- Обработка события изменения свойств графика
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      //--- Выйти, если элемент заблокирован
      if(!m_combobox_state)
         return;
      //--- ВЫйти, если список скрыт
      if(!m_listview.IsVisible())
         return;
      //--- Скрыть список
      m_listview.Hide();
      //--- Восстановить цвета
      ResetColors();
      //--- Если форма заблокирована и идентификаторы совпадают
      if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()==CElement::Id())
        {
         //--- Разблокировать форму
         m_wnd.IsLocked(false);
         m_wnd.IdActivatedElement(WRONG_VALUE);
        }
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CComboBox::OnEventTimer(void)
  {
//--- Если элемент выпадающий и список скрыт
   if(CElement::IsDropdown() && !m_listview.IsVisible())
      ChangeObjectsColor();
   else
     {
      //--- Если форма и элемент не заблокированы
      if(!m_wnd.IsLocked() && m_combobox_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт группу объектов типа комбо-бокс                          |
//+------------------------------------------------------------------+
bool CComboBox::CreateComboBox(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием комбобокса классу нужно передать "
              "указатель на форму: CComboBox::WindowPointer(CWindow &object)");
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
//--- Создание элемента
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateButton())
      return(false);
   if(!CreateDropArrow())
      return(false);
   if(!CreateList())
      return(false);
//--- Запомнить и установить текст в кнопку
   m_button_text=m_listview.SelectedItemText();
   m_button.Description(m_listview.SelectedItemText());
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь комбо-бокса                                      |
//+------------------------------------------------------------------+
bool CComboBox::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_combobox_area_"+(string)CElement::Id();
//--- Установим объект
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
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
//| Создаёт лэйбл комбо-бокса                                        |
//+------------------------------------------------------------------+
bool CComboBox::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_combobox_lable_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+m_label_x_gap;
   int y=CElement::Y()+m_label_y_gap;
   color label_color=(m_combobox_state)? m_label_color : m_label_color_off;
//--- Установим объект
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
//--- Инициализация массива градиента
   CElement::InitColorArray(label_color,m_label_color_hover,m_label_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку комбо-бокса                                       |
//+------------------------------------------------------------------+
bool CComboBox::CreateButton(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_combobox_button_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+CElement::XSize()-m_button_x_size;
   int y =CElement::Y()-1;
//--- Установим объект
   if(!m_button.Create(m_chart_id,name,m_subwin,x,y,m_button_x_size,m_button_y_size))
      return(false);
//--- Установим свойства
   m_button.Font(FONT);
   m_button.FontSize(FONT_SIZE);
   m_button.Description(m_button_text);
   m_button.Color(m_button_text_color);
   m_button.BackColor(m_button_color);
   m_button.BorderColor(m_button_border_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_button_zorder);
   m_button.ReadOnly(true);
   m_button.Tooltip("\n");
//--- Сохраним координаты
   m_button.X(x);
   m_button.Y(y);
//--- Сохраним размеры
   m_button.XSize(m_button_x_size);
   m_button.YSize(m_button_y_size);
//--- Отступы от крайней точки
   m_button.XGap(x-m_wnd.X());
   m_button.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_button_color,m_button_color_hover,m_button_color_array);
   CElement::InitColorArray(m_button_border_color,m_button_border_color_hover,m_button_border_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт стрелку на комбо-боксе                                   |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
//---
bool CComboBox::CreateDropArrow(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_combobox_drop_"+(string)CElement::Id();
//--- Координаты
   int x=m_button.X()+m_button.XSize()-m_drop_arrow_x_gap;
   int y=m_button.Y()+m_drop_arrow_y_gap;
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
//| Создаёт список                                                   |
//+------------------------------------------------------------------+
bool CComboBox::CreateList(void)
  {
//--- Сохраним указатели на форму и комбо-бокс
   m_listview.WindowPointer(m_wnd);
   m_listview.ComboBoxPointer(this);
//--- Координаты
   int x=CElement::X2()-m_button_x_size;
   int y=CElement::Y()+m_button_y_size;
//--- Установим свойства
   m_listview.Id(CElement::Id());
   m_listview.XSize(m_button_x_size);
//--- Создадим элемент управления
   if(!m_listview.CreateListView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Скрыть список
   m_listview.Hide();
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет переданное значение в списке по указанному индексу     |
//+------------------------------------------------------------------+
void CComboBox::ValueToList(const int item_index,const string item_text)
  {
   m_listview.ValueToList(item_index,item_text);
  }
//+------------------------------------------------------------------+
//| Выделение пункта по указанному индексу                           |
//+------------------------------------------------------------------+
void CComboBox::SelectedItemByIndex(const int index)
  {
//--- Выбрать пункт в списке
   m_listview.SelectedItemByIndex(index);
//--- Запомнить и установить текст в кнопке
   m_button_text=m_listview.SelectedItemText();
   m_button.Description(m_listview.SelectedItemText());
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CComboBox::Moving(const int x,const int y)
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
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_button.X(x+m_button.XGap());
   m_button.Y(y+m_button.YGap());
   m_drop_arrow.X(x+m_drop_arrow.XGap());
   m_drop_arrow.Y(y+m_drop_arrow.YGap());
//--- Обновление координат графических объектов  
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_drop_arrow.X_Distance(m_drop_arrow.X());
   m_drop_arrow.Y_Distance(m_drop_arrow.Y());
  }
//+------------------------------------------------------------------+
//| Показывает комбо-бокс                                            |
//+------------------------------------------------------------------+
void CComboBox::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Показать список
   m_listview.Hide();
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает комбо-бокс                                              |
//+------------------------------------------------------------------+
void CComboBox::Hide(void)
  {
//--- Выйти, если элемент уже видим
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Цвет кнопки
   m_button.BackColor(m_button_color);
//--- Скрыть список
   m_listview.Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CComboBox::Reset(void)
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
void CComboBox::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_label.Delete();
   m_button.Delete();
   m_drop_arrow.Delete();
//--- Состояние видимости
   CElement::IsVisible(true);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CComboBox::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_zorder);
   m_button.Z_Order(m_button_zorder);
   m_drop_arrow.Z_Order(m_zorder);
   m_listview.SetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CComboBox::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_button.Z_Order(0);
   m_drop_arrow.Z_Order(0);
   m_listview.ResetZorders();
  }
//+------------------------------------------------------------------+
//| Сбрасывает цвет                                                  |
//+------------------------------------------------------------------+
void CComboBox::ResetColors(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_combobox_state)
      return;
//--- Сбросить цвет
   m_label.Color(m_label_color);
   m_button.BackColor(m_button_color);
//--- Обнулим фокус
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CComboBox::ChangeObjectsColor(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_combobox_state)
      return;
//--- Изменить цвет объектов
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,m_button_color,m_button_color_hover,m_button_color_array);
   CElement::ChangeObjectColor(m_button.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_button_border_color,m_button_border_color_hover,m_button_border_color_array);
  }
//+------------------------------------------------------------------+
//| Изменение состояния комбо-бокса                                  |
//+------------------------------------------------------------------+
void CComboBox::ComboBoxState(const bool state)
  {
   m_combobox_state=state;
//--- Установить цвета объектам согласно текущему состоянию
   m_label.Color((state)? m_label_color : m_label_color_off);
   m_button.Color((state)? m_button_text_color : m_button_text_color_off);
   m_button.BackColor((state)? m_button_color : m_button_color_off);
   m_button.BorderColor((state)? m_button_border_color : m_button_border_color_off);
   m_drop_arrow.State(state);
  }
//+------------------------------------------------------------------+
//| Изменяет текущее состояние комбо-бокса на противоположное        |
//+------------------------------------------------------------------+
void CComboBox::ChangeComboBoxListState(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_combobox_state)
      return;
//--- Если список виден
   if(m_listview.IsVisible())
     {
      //--- Скрыть список
      m_listview.Hide();
      //--- Установить цвета
      m_label.Color(m_label_color_hover);
      m_button.BackColor(m_button_color_hover);
      //--- Если элемент не выпадающий
      if(!CElement::IsDropdown())
        {
         //--- Разблокировать форму
         m_wnd.IsLocked(false);
         m_wnd.IdActivatedElement(WRONG_VALUE);
        }
     }
//--- Если список скрыт
   else
     {
      //--- Показать список
      m_listview.Show();
      //--- Установить цвета
      m_label.Color(m_label_color_hover);
      m_button.BackColor(m_button_color_pressed);
      //--- Заблокировать форму
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElement::Id());
     }
  }
//+------------------------------------------------------------------+
//| Нажатие на кнопку комбо-бокса                                    |
//+------------------------------------------------------------------+
bool CComboBox::OnClickButton(const string clicked_object)
  {
//--- Выйти, если форма заблокирована и идентификаторы не совпадают
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return(false);
//--- Выйдем, если чужое имя объекта  
   if(clicked_object!=m_button.Name())
      return(false);
//--- Изменить состояние списка
   ChangeComboBoxListState();
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_COMBOBOX_BUTTON,CElement::Id(),0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверка нажатой левой кнопки мыши над кнопкой                   |
//+------------------------------------------------------------------+
void CComboBox::CheckPressedOverButton(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_combobox_state)
      return;
//--- Выйти, если левая кнопка мыши отжата
   if(!m_mouse_state)
      return;
//--- Выйти, если форма заблокирована и идентификаторы не совпадают
   if(m_wnd.IsLocked() && m_wnd.IdActivatedElement()!=CElement::Id())
      return;
//--- Если фокуса нет
   if(!CElement::MouseFocus())
     {
      //--- Выйти, если фокус не на списке или полоса прокрутки списка в действии
      if(m_listview.MouseFocus() || m_listview.ScrollState())
         return;
      //--- Скрыть список
      m_listview.Hide();
      //--- Восстановить цвета
      ResetColors();
      //--- Если идентификаторы совпадают и элемент не выпадающий
      if(m_wnd.IdActivatedElement()==CElement::Id() && !CElement::IsDropdown())
         //--- Разблокировать форму
         m_wnd.IsLocked(false);
     }
//--- Если фокус есть
   else
     {
      //--- Выйти, если список виден
      if(m_listview.IsVisible())
         return;
      //--- Установить цвет с учётом фокуса
      if(m_button.MouseFocus())
         m_button.BackColor(m_button_color_pressed);
      else
         m_button.BackColor(m_button_color_hover);
     }
  }
//+------------------------------------------------------------------+
