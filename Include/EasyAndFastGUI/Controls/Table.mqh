//+------------------------------------------------------------------+
//|                                                        Table.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| Класс для создания таблицы из полей ввода                        |
//+------------------------------------------------------------------+
class CTable : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания таблицы
   CRectLabel        m_area;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   //--- Массив объектов видимой части таблицы
   struct TEdits
     {
      CEdit             m_rows[];
     };
   TEdits            m_columns[];
   //--- Массивы значений и свойств таблицы
   struct TOptions
     {
      string            m_vrows[];
      ENUM_ALIGN_MODE   m_text_align[];
      color             m_text_color[];
      color             m_cell_color[];
     };
   TOptions          m_vcolumns[];
   //--- Количество столбцов и рядов (общее и видимой части) таблицы
   int               m_rows_total;
   int               m_columns_total;
   int               m_visible_rows_total;
   int               m_visible_columns_total;
   //--- Высота рядов таблицы
   int               m_row_y_size;
   //--- (1) Цвет фона и (2) рамки фона таблицы
   color             m_area_color;
   color             m_area_border_color;
   //--- Цвет сетки
   color             m_grid_color;
   //--- Цвет фона заголовков
   color             m_headers_color;
   //--- Цвет текста заголовков
   color             m_headers_text_color;
   //--- Цвет ячеек в разных состояниях
   color             m_cell_color;
   color             m_cell_color_hover;
   //--- Цвет текста в ячейках по умолчанию
   color             m_cell_text_color;
   //--- Цвет (1) фона и (2) текста выделенной строки
   color             m_selected_row_color;
   color             m_selected_row_text_color;
   //--- (1) Индекс и (2) текст выделенной строки
   int               m_selected_item;
   string            m_selected_item_text;
   //--- Режим редактируемой таблицы
   bool              m_read_only;
   //--- Режим подсветки строки при наведении курсора мыши
   bool              m_lights_hover;
   //--- Режим выделяемой строки
   bool              m_selectable_row;
   //--- Режим фиксации первой строки
   bool              m_fix_first_row;
   //--- Режим фиксации первого столбца
   bool              m_fix_first_column;
   //--- Способ выравнивания текста в полях ввода по умолчанию
   ENUM_ALIGN_MODE   m_align_mode;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_zorder;
   int               m_cell_zorder;
   //--- Состояние кнопки мыши (нажата/отжата)
   ENUM_THUMB_MOUSE_STATE m_clamping_area_mouse;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //---
public:
                     CTable(void);
                    ~CTable(void);
   //--- Методы для создания таблицы
   bool              CreateTable(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCells(void);
   bool              CreateCanvasCells(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращает указатели на полосы прокрутки
   void              WindowPointer(CWindow &object)                    { m_wnd=::GetPointer(object);      }
   CScrollV         *GetScrollVPointer(void)                           { return(::GetPointer(m_scrollv)); }
   CScrollH         *GetScrollHPointer(void)                           { return(::GetPointer(m_scrollh)); }
   //--- Цвет (1) фона и (2) рамки таблицы
   void              AreaColor(const color clr)                        { m_area_color=clr;                }
   void              BorderColor(const color clr)                      { m_area_border_color=clr;         }
   //--- (1) Возвращает и (2) устанавливает режим фиксации первой строки
   bool              FixFirstRow(void)                           const { return(m_fix_first_row);         }
   void              FixFirstRow(const bool flag)                      { m_fix_first_row=flag;            }
   //--- (1) Возвращает и (2) устанавливает режим фиксации первого столбца
   bool              FixFirstColumn(void)                        const { return(m_fix_first_column);      }
   void              FixFirstColumn(const bool flag)                   { m_fix_first_column=flag;         }
   //--- Цвет (1) фона заголовков, (2) текста заголовков и (3) сетки таблицы
   void              HeadersColor(const color clr)                     { m_headers_color=clr;             }
   void              HeadersTextColor(const color clr)                 { m_headers_text_color=clr;        }
   void              GridColor(const color clr)                        { m_grid_color=clr;                }
   //--- Размер рядов по оси Y
   void              RowYSize(const int y_size)                        { m_row_y_size=y_size;             }
   void              CellColor(const color clr)                        { m_cell_color=clr;                }
   void              CellColorHover(const color clr)                   { m_cell_color_hover=clr;          }
   //--- Режимы (1) "Только чтение", (2) подсветка ряда при наведении курсора мыши, (3) выделение ряда
   void              ReadOnly(const bool flag)                         { m_read_only=flag;                }
   void              LightsHover(const bool flag)                      { m_lights_hover=flag;             }
   void              SelectableRow(const bool flag)                    { m_selectable_row=flag;           }
   //--- Возвращает общее количество (1) рядов и (2) столбцов, (3) состояние полосы прокрутки
   int               RowsTotal(void)                             const { return(m_rows_total);            }
   int               ColumnsTotal(void)                          const { return(m_columns_total);         }
   //--- Возвращает количество (1) рядов и (2) столбцов видимой части таблицы
   int               VisibleRowsTotal(void)                      const { return(m_visible_rows_total);    }
   int               VisibleColumnsTotal(void)                   const { return(m_visible_columns_total); }
   //--- Возвращает (1) индекс и (2) текст выделенного ряда в таблице, (3) способ выравнивания текста в ячейках
   int               SelectedItem(void)                          const { return(m_selected_item);         }
   string            SelectedItemText(void)                      const { return(m_selected_item_text);    }
   void              TextAlign(const ENUM_ALIGN_MODE align_mode)       { m_align_mode=align_mode;         }

   //--- Устанавливает (1) размер таблицы и (2) размер видимой её части
   void              TableSize(const int columns_total,const int rows_total);
   void              VisibleTableSize(const int visible_columns_total,const int visible_rows_total);
   //--- Установка (1) способа выравнивания текста, (2) цвета текста, (3) цвета фона ячейки
   void              TextAlign(const int column_index,const int row_index,const ENUM_ALIGN_MODE mode);
   void              TextColor(const int column_index,const int row_index,const color clr);
   void              CellColor(const int column_index,const int row_index,const color clr);
   //--- Устанавливает значение в указанную ячейку таблицы
   void              SetValue(const int column_index,const int row_index,const string value);
   //--- Получает значение из указанной ячейки таблицы
   string            GetValue(const int column_index,const int row_index);
   //--- Обновление данных таблицы с учётом последних изменений
   void              UpdateTable(void);
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
   //--- Обработка нажатия на ряде таблицы
   bool              OnClickTableRow(const string clicked_object);
   //--- Обработка ввода значения в ячейку таблицы
   bool              OnEndEditCell(const string edited_object);
   //--- Получение идентификатора из имени объекта
   int               IdFromObjectName(const string object_name);
   //--- Извлекает индекс столбца из имени объекта
   int               ColumnIndexFromObjectName(const string object_name);
   //--- Извлекает индекс ряда из имени объекта
   int               RowIndexFromObjectName(const string object_name);
   //--- Подсветка выделенного ряда
   void              HighlightSelectedItem(void);
   //--- Изменение цвета ряда таблицы при наведении курсора мыши
   void              RowColorByHover(const int x,const int y);
   //--- Ускоренная перемотка данных таблицы
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTable::CTable(void) : m_row_y_size(18),
                       m_fix_first_row(false),
                       m_fix_first_column(false),
                       m_read_only(true),
                       m_lights_hover(false),
                       m_selectable_row(false),
                       m_align_mode(ALIGN_LEFT),
                       m_rows_total(2),
                       m_columns_total(1),
                       m_visible_rows_total(2),
                       m_visible_columns_total(1),
                       m_selected_item(WRONG_VALUE),
                       m_selected_item_text(""),
                       m_headers_color(C'103,116,141'),
                       m_headers_text_color(clrWhite),
                       m_area_color(clrLightGray),
                       m_area_border_color(C'240,240,240'),
                       m_grid_color(clrWhite),
                       m_cell_color(clrWhite),
                       m_cell_color_hover(C'240,240,240'),
                       m_cell_text_color(clrBlack),
                       m_selected_row_color(C'51,153,255'),
                       m_selected_row_text_color(clrWhite)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder      =1;
   m_cell_zorder =2;
//--- Установим размер таблицы и её видимой части
   TableSize(m_columns_total,m_rows_total);
   VisibleTableSize(m_visible_columns_total,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTable::~CTable(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- Если полоса прокрутки в действии
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state) || m_scrollh.ScrollBarControl(x,y,m_mouse_state))
         //--- Смещаем таблицу
         UpdateTable();
      //--- Подсветка выделенного ряда
      HighlightSelectedItem();
      //--- Изменяет цвет ряда таблицы при наведении курсора мыши
      RowColorByHover(x,y);
      return;
     }
//--- Обработка нажатия на объектах
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Выйти, если форма заблокирована
      if(m_wnd.IsLocked())
         return;
      //--- Если нажали на ряде таблицы
      if(OnClickTableRow(sparam))
        {
         //--- Подсветка выделенного ряда
         HighlightSelectedItem();
         return;
        }
      //--- Если нажали на кнопке полосы прокрутки
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
        {
         //--- Обновление данных таблицы с учётом последних изменений
         UpdateTable();
         //--- Подсветка выделенного ряда
         HighlightSelectedItem();
         return;
        }
      return;
     }
//--- Обработка события изменения значения в поле ввода
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      OnEndEditCell(sparam);
      //--- Сбросить цвета таблицы
      ResetColors();
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CTable::OnEventTimer(void)
  {
//--- Если элемент является выпадающим
   if(CElement::IsDropdown())
      FastSwitching();
//--- Если элемент не выпадающий, то учитываем доступность формы в текущий момент
   else
     {
      //--- Отслеживаем перемотку таблицы, только если форма не заблокирована
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт таблицу из полей ввода                                   |
//+------------------------------------------------------------------+
bool CTable::CreateTable(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием таблицы классу нужно передать "
              "указатель на форму: CTable::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
   m_y_size   =m_row_y_size*m_visible_rows_total-(m_visible_rows_total-1)+2;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание таблицы
   if(!CreateArea())
      return(false);
   if(!CreateCells())
      return(false);
   if(!CreateScrollV())
      return(false);
   if(!CreateScrollH())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт фон для таблицы                                          |
//+------------------------------------------------------------------+
bool CTable::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_table_area_"+(string)CElement::Id();
//--- Если есть горизонтальная полоса прокрутки, то скорректировать размер таблицы по оси Y
   m_y_size=(m_columns_total>m_visible_columns_total) ? m_y_size+m_scrollh.ScrollWidth()-1 : m_y_size;
//--- Создание объекта
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
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
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Сохраним размеры
   m_area.XSize(CElement::XSize());
   m_area.YSize(CElement::YSize());
//--- Сохраним координаты
   m_area.X(CElement::X());
   m_area.Y(CElement::Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт сетку ячеек таблицы                                      |
//+------------------------------------------------------------------+
bool CTable::CreateCells(void)
  {
//--- Координаты и ширина ячеек таблицы
   int x =CElement::X()+1;
   int y =0;
   int w =0;
//--- Проверка на наличие вертикальной полосы прокрутки
   bool is_scrollv=m_rows_total>m_visible_rows_total;
//--- Расчёт ширины столбцов. 
//    Ширина зависит от кол-ва видимых столбцов и наличия вертикальной полосы прокрутки.
   if(m_visible_columns_total==1)
      w=(is_scrollv) ? m_x_size-m_scrollv.ScrollWidth() : m_x_size-2;
   else
      w=(is_scrollv) ?(m_x_size-m_scrollv.ScrollWidth())/m_visible_columns_total : m_x_size/m_visible_columns_total+1;
//--- Столбцы
   for(int c=0; c<m_visible_columns_total && c<m_columns_total; c++)
     {
      //--- Расчёт координаты X
      x=(c>0) ? x+w-1 : CElement::X()+1;
      //--- Корректировка ширины последнего столбца
      if(c+1>=m_visible_columns_total)
         w=(is_scrollv) ? CElement::X2()-x-m_scrollv.ScrollWidth() : CElement::X2()-x-1;
      //--- Ряды
      for(int r=0; r<m_visible_rows_total && r<m_rows_total; r++)
        {
         //--- Формирование имени объекта
         string name=CElement::ProgramName()+"_table_edit_"+(string)c+"_"+(string)r+"__"+(string)CElement::Id();
         //--- Расчёт координаты Y
         y=(r>0) ? y+m_row_y_size-1 : CElement::Y()+1;
         //--- Создание объекта
         if(!m_columns[c].m_rows[r].Create(m_chart_id,name,m_subwin,x,y,w,m_row_y_size))
            return(false);
         //--- Установка свойств
         m_columns[c].m_rows[r].Description("");
         m_columns[c].m_rows[r].TextAlign(m_align_mode);
         m_columns[c].m_rows[r].Font(FONT);
         m_columns[c].m_rows[r].FontSize(FONT_SIZE);
         m_columns[c].m_rows[r].Color(m_cell_text_color);
         m_columns[c].m_rows[r].BackColor(m_cell_color);
         m_columns[c].m_rows[r].BorderColor(m_grid_color);
         m_columns[c].m_rows[r].Corner(m_corner);
         m_columns[c].m_rows[r].Anchor(m_anchor);
         m_columns[c].m_rows[r].Selectable(false);
         m_columns[c].m_rows[r].Z_Order(m_cell_zorder);
         m_columns[c].m_rows[r].ReadOnly(m_read_only);
         m_columns[c].m_rows[r].Tooltip("\n");
         //--- Координаты
         m_columns[c].m_rows[r].X(x);
         m_columns[c].m_rows[r].Y(y);
         //--- Отступы от крайней точки панели
         m_columns[c].m_rows[r].XGap(x-m_wnd.X());
         m_columns[c].m_rows[r].YGap(y-m_wnd.Y());
         //--- Размеры
         m_columns[c].m_rows[r].XSize(w);
         m_columns[c].m_rows[r].YSize(m_row_y_size);
         //--- Сохраним указатель объекта
         CElement::AddToArray(m_columns[c].m_rows[r]);
        }
     }
//--- Подсветка выделенной строки
   HighlightSelectedItem();
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вертикальную полосу прокрутки                            |
//+------------------------------------------------------------------+
bool CTable::CreateScrollV(void)
  {
//--- Если общее количество рядов больше, чем видимая часть таблицы, то
//    установим вертикальную полосу прокрутки
   if(m_rows_total<=m_visible_rows_total)
      return(true);
//--- Сохранить указатель формы
   m_scrollv.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X2()-m_scrollv.ScrollWidth();
   int y=CElement::Y();
//--- Установим размеры
   m_scrollv.Id(CElement::Id());
   m_scrollv.IsDropdown(CElement::IsDropdown());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize((m_columns_total>m_visible_columns_total)? CElement::YSize()-m_scrollv.ScrollWidth()+1 : CElement::YSize());
//--- Создание полосы прокрутки
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_rows_total,m_visible_rows_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт горизонтальную полосу прокрутки                          |
//+------------------------------------------------------------------+
bool CTable::CreateScrollH(void)
  {
//--- Если общее количество столбцов больше, чем видимая часть таблицы, то
//    установим горизонтальную полосу прокрутки
   if(m_columns_total<=m_visible_columns_total)
      return(true);
//--- Сохранить указатель формы
   m_scrollh.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y2()-m_scrollh.ScrollWidth();
//--- Установим размеры
   m_scrollh.Id(CElement::Id());
   m_scrollh.IsDropdown(CElement::IsDropdown());
   m_scrollh.XSize((m_rows_total>m_visible_rows_total)? m_area.XSize()-m_scrollh.ScrollWidth()+1 : m_area.XSize());
   m_scrollh.YSize(m_scrollh.ScrollWidth());
//--- Создание полосы прокрутки
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_columns_total,m_visible_columns_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Заполняет массив по указанным индексам                           |
//+------------------------------------------------------------------+
void CTable::SetValue(const int column_index,const int row_index,const string value)
  {
//--- Проверка на выход из диапазона столбцов
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Проверка на выход из диапазона рядов
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Установить значение в массив
   m_vcolumns[column_index].m_vrows[row_index]=value;
  }
//+------------------------------------------------------------------+
//| Возвращает значение по указанным индексам                        |
//+------------------------------------------------------------------+
string CTable::GetValue(const int column_index,const int row_index)
  {
//--- Проверка на выход из диапазона столбцов
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return("");
//--- Проверка на выход из диапазона рядов
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return("");
//--- Вернуть значение
   return(m_vcolumns[column_index].m_vrows[row_index]);
  }
//+------------------------------------------------------------------+
//| Заполняет массив режимом выравнивания текста                     |
//+------------------------------------------------------------------+
void CTable::TextAlign(const int column_index,const int row_index,const ENUM_ALIGN_MODE mode)
  {
//--- Проверка на выход из диапазона столбцов
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Проверка на выход из диапазона рядов
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Установить цвет текста в общий массив
   m_vcolumns[column_index].m_text_align[row_index]=mode;
  }
//+------------------------------------------------------------------+
//| Заполняет массив цветом текста                                   |
//+------------------------------------------------------------------+
void CTable::TextColor(const int column_index,const int row_index,const color clr)
  {
//--- Проверка на выход из диапазона столбцов
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Проверка на выход из диапазона рядов
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Установить цвет текста в общий массив
   m_vcolumns[column_index].m_text_color[row_index]=clr;
  }
//+------------------------------------------------------------------+
//| Заполняет массив цветом ячеек                                    |
//+------------------------------------------------------------------+
void CTable::CellColor(const int column_index,const int row_index,const color clr)
  {
//--- Проверка на выход из диапазона столбцов
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Проверка на выход из диапазона рядов
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Установить цвет фона ячейки в общий массив
   m_vcolumns[column_index].m_cell_color[row_index]=clr;
  }
//+------------------------------------------------------------------+
//| Устанавливает размер таблицы                                     |
//+------------------------------------------------------------------+
void CTable::TableSize(const int columns_total,const int rows_total)
  {
//--- Должно быть не менее одного столбца
   m_columns_total=(columns_total<1) ? 1 : columns_total;
//--- Должно быть не менее двух рядов
   m_rows_total=(rows_total<2) ? 2 : rows_total;
//--- Установить размер массиву столбцов
   ::ArrayResize(m_vcolumns,m_columns_total);
//--- Установить размер массивам рядов
   for(int i=0; i<m_columns_total; i++)
     {
      ::ArrayResize(m_vcolumns[i].m_vrows,m_rows_total);
      ::ArrayResize(m_vcolumns[i].m_text_align,m_rows_total);
      ::ArrayResize(m_vcolumns[i].m_text_color,m_rows_total);
      ::ArrayResize(m_vcolumns[i].m_cell_color,m_rows_total);
      //--- Инициализация массива цвета фона ячеек значением по умолчанию
      ::ArrayInitialize(m_vcolumns[i].m_text_align,m_align_mode);
      ::ArrayInitialize(m_vcolumns[i].m_text_color,m_cell_text_color);
      ::ArrayInitialize(m_vcolumns[i].m_cell_color,m_cell_color);
     }
  }
//+------------------------------------------------------------------+
//| Устанавливает размер видимой части таблицы                       |
//+------------------------------------------------------------------+
void CTable::VisibleTableSize(const int visible_columns_total,const int visible_rows_total)
  {
//--- Должно быть не менее одного столбца
   m_visible_columns_total=(visible_columns_total<1) ? 1 : visible_columns_total;
//--- Должно быть не менее двух рядов
   m_visible_rows_total=(visible_rows_total<2) ? 2 : visible_rows_total;
//--- Установить размер массиву столбцов
   ::ArrayResize(m_columns,m_visible_columns_total);
//--- Установить размер массивам рядов
   for(int i=0; i<m_visible_columns_total; i++)
      ::ArrayResize(m_columns[i].m_rows,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Обновление данных таблицы с учётом последних изменений           |
//+------------------------------------------------------------------+
void CTable::UpdateTable(void)
  {
//--- Смещение на один индекс, если включен режим закреплённых заголовков
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- Получим текущие позиции ползунков горизонтальной и вертикальной полос прокрутки
   int h=m_scrollh.CurrentPos()+l;
   int v=m_scrollv.CurrentPos()+t;
//--- Установка свойств для первой ячейки, если включены режимы фиксации заголовков
   if(m_fix_first_column && m_fix_first_row)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      m_columns[0].m_rows[0].BackColor(m_headers_color);
      m_columns[0].m_rows[0].Color(m_headers_text_color);
      m_columns[0].m_rows[0].TextAlign(m_vcolumns[0].m_text_align[0]);
     }
//--- Смещение заголовков в левом столбце
   if(m_fix_first_column)
     {
      //--- Ряды
      for(int r=t; r<m_visible_rows_total; r++)
        {
         if(r>=t && r<m_rows_total)
           {
            //--- Корректировка значений
            m_columns[0].m_rows[r].Description(m_vcolumns[0].m_vrows[v]);
            //--- Корректировка цвета фона ячейки
            m_columns[0].m_rows[r].BackColor(m_headers_color);
            //--- Корректировка цвета текста ячейки
            m_columns[0].m_rows[r].Color(m_headers_text_color);
            //--- Корректировка выравнивания текста в ячейках
            m_columns[0].m_rows[r].TextAlign(m_vcolumns[0].m_text_align[v]);
           }
         //---
         v++;
        }
     }
//--- Смещение заголовков в верхнем ряду
   if(m_fix_first_row)
     {
      //--- Столбцы
      for(int c=l; c<m_visible_columns_total; c++)
        {
         if(h>=l && h<m_columns_total)
           {
            //--- Корректировка значений
            m_columns[c].m_rows[0].Description(m_vcolumns[h].m_vrows[0]);
            //--- Корректировка цвета фона ячейки
            m_columns[c].m_rows[0].BackColor(m_headers_color);
            //--- Корректировка цвета текста ячейки
            m_columns[c].m_rows[0].Color(m_headers_text_color);
            //--- Корректировка выравнивания текста в ячейках
            m_columns[c].m_rows[0].TextAlign(m_vcolumns[h].m_text_align[0]);
           }
         //---
         h++;
        }
     }
//--- Получим текущую позицию ползунка горизонтальной полосы прокрутки
   h=m_scrollh.CurrentPos()+l;
//--- Столбцы
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- Получим текущую позицию ползунка вертикальной полосы прокрутки
      v=m_scrollv.CurrentPos()+t;
      //--- Ряды
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- Смещение данных таблицы
         if(v>=t && v<m_rows_total && h>=l && h<m_columns_total)
           {
            //--- Корректировка значений
            m_columns[c].m_rows[r].Description(m_vcolumns[h].m_vrows[v]);
            //--- Корректировка цвета фона ячейки
            m_columns[c].m_rows[r].BackColor(m_vcolumns[h].m_cell_color[v]);
            //--- Корректировка цвета текста ячейки
            m_columns[c].m_rows[r].Color(m_vcolumns[h].m_text_color[v]);
            //--- Корректировка выравнивания текста в ячейках
            m_columns[c].m_rows[r].TextAlign(m_vcolumns[h].m_text_align[v]);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CTable::Moving(const int x,const int y)
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
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//--- Столбцы
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- Ряды
      for(int r=0; r<m_visible_rows_total; r++)
        {
         //--- Сохранение координат в полях объектов
         m_columns[c].m_rows[r].X(x+m_columns[c].m_rows[r].XGap());
         m_columns[c].m_rows[r].Y(y+m_columns[c].m_rows[r].YGap());
         //--- Обновление координат графических объектов
         m_columns[c].m_rows[r].X_Distance(m_columns[c].m_rows[r].X());
         m_columns[c].m_rows[r].Y_Distance(m_columns[c].m_rows[r].Y());
        }
     }
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CTable::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Показать полосы прокрутки
   m_scrollv.Show();
   m_scrollh.Show();
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CTable::Hide(void)
  {
//--- Выйти, если элемент уже скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Скрыть полосы прокрутки
   m_scrollv.Hide();
   m_scrollh.Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CTable::Reset(void)
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
void CTable::Delete(void)
  {
//--- Удаление графических объектов
   m_area.Delete();
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Delete();
      //--- Освобождение массивов элемента
      ::ArrayFree(m_columns[c].m_rows);
     }
//--- Освобождение массивов элемента
   for(int c=0; c<m_columns_total; c++)
     {
      ::ArrayFree(m_vcolumns[c].m_vrows);
      ::ArrayFree(m_vcolumns[c].m_text_align);
      ::ArrayFree(m_vcolumns[c].m_text_color);
      ::ArrayFree(m_vcolumns[c].m_cell_color);
     }
//---
   ::ArrayFree(m_columns);
   ::ArrayFree(m_vcolumns);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CTable::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(m_cell_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CTable::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_scrollv.ResetZorders();
   m_scrollh.ResetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(0);
     }
  }
//+------------------------------------------------------------------+
//| Сброс цвета объектов элемента                                    |
//+------------------------------------------------------------------+
void CTable::ResetColors(void)
  {
//--- Смещение на один индекс, если включен режим закреплённых заголовков
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- Получим текущую позицию ползунка горизонтальной полосы прокрутки
   int h=m_scrollh.CurrentPos()+l;
//--- Столбцы
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- Получим текущую позицию ползунка вертикальной полосы прокрутки
      int v=m_scrollv.CurrentPos()+t;
      //--- Ряды
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- Проверка для предотвращения выхода из диапазона
         if(v>=t && v<m_rows_total)
           {
            //--- Пропустить, если дошли до выделенной строки и при этом в режиме "Только чтение"
            if(m_selected_item==v && m_read_only)
              {
               v++;
               continue;
              }
            //--- Корректировка цвета фона ячейки
            m_columns[c].m_rows[r].BackColor(m_vcolumns[h].m_cell_color[v]);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на ряде таблицы                                |
//+------------------------------------------------------------------+
bool CTable::OnClickTableRow(const string clicked_object)
  {
//--- Выйти, если включен режим редактируемой таблицы
   if(!m_read_only)
      return(false);
//--- Выйти, если полоса прокрутки в действии
   if(m_scrollv.ScrollState() || m_scrollh.ScrollState())
      return(false);
//--- Выйдем, если нажатие было не на ячейке таблицы
   if(::StringFind(clicked_object,CElement::ProgramName()+"_table_edit_",0)<0)
      return(false);
//--- Получим идентификатор имени объекта
   int id=IdFromObjectName(clicked_object);
//--- Выйти, если идентификатор не совпадает
   if(id!=CElement::Id())
      return(false);
//--- Для поиска индекса ряда
   int row_index=0;
//--- Смещение на один индекс, если включен режим закреплённых заголовков
   int t=(m_fix_first_row) ? 1 : 0;
//--- Столбцы
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- Получим текущую позицию ползунка вертикальной полосы прокрутки
      int v=m_scrollv.CurrentPos()+t;
      //--- Ряды
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- Если нажатие было на этой ячейке
         if(m_columns[c].m_rows[r].Name()==clicked_object)
           {
            //--- Сохраним индекс ряда
            m_selected_item=row_index=v;
            //--- Сохраним строку ячейки
            m_selected_item_text=m_columns[c].m_rows[r].Description();
            break;
           }
         //--- Увеличим счётчик ряда
         if(v>=t && v<m_rows_total)
            v++;
        }
     }
//--- Выйти, если нажали на заголовке
   if(m_fix_first_row && row_index<1)
      return(false);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_LIST_ITEM,CElement::Id(),m_selected_item,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Событие окончания редактирования значения в ячейке               |
//+------------------------------------------------------------------+
bool CTable::OnEndEditCell(const string edited_object)
  {
//--- Выйти, если отключен режим редактируемой таблицы
   if(m_read_only)
      return(false);
//--- Выйдем, если нажатие было не на ячейке таблицы
   if(::StringFind(edited_object,CElement::ProgramName()+"_table_edit_",0)<0)
      return(false);
//--- Получим идентификатор из имени объекта
   int id=IdFromObjectName(edited_object);
//--- Выйти, если идентификатор не совпадает
   if(id!=CElement::Id())
      return(false);
//--- Получим индексы столбца и ряда ячейки
   int c =ColumnIndexFromObjectName(edited_object);
   int r =RowIndexFromObjectName(edited_object);
//--- Получим индексы столбца и ряда в массиве данных
   int vc =c+m_scrollh.CurrentPos();
   int vr =r+m_scrollv.CurrentPos();
//--- Скорректировать индекс ряда, если нажатие было на заголовке
   if(m_fix_first_row && r==0)
      vr=0;
//--- Получим введённое значение
   string cell_text=m_columns[c].m_rows[r].Description();
//--- Если значение в ячейке было изменено
   if(cell_text!=m_vcolumns[vc].m_vrows[vr])
     {
      //--- Сохраним новое значение в массиве
      SetValue(vc,vr,cell_text);
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),0,string(vc)+"_"+string(vr)+"_"+cell_text);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Извлекает идентификатор из имени объекта                         |
//+------------------------------------------------------------------+
int CTable::IdFromObjectName(const string object_name)
  {
//--- Получим id из имени объекта
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- Вернуть id пункта
   return((int)id);
  }
//+------------------------------------------------------------------+
//| Извлекает индекс столбца из имени объекта                        |
//+------------------------------------------------------------------+
int CTable::ColumnIndexFromObjectName(const string object_name)
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
   if(array_size-3<0)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- Вернуть индекс пункта
   return((int)result[array_size-3]);
  }
//+------------------------------------------------------------------+
//| Извлекает индекс ряда из имени объекта                           |
//+------------------------------------------------------------------+
int CTable::RowIndexFromObjectName(const string object_name)
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
//| Подсветка выделенного ряда                                       |
//+------------------------------------------------------------------+
void CTable::HighlightSelectedItem(void)
  {
//--- Выйти, если один из режимов ("Только чтение", "Выделение строки") отключен
   if(!m_read_only || !m_selectable_row)
      return;
//--- Смещение на один индекс, если включен режим закреплённых заголовков
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- Получим текущую позицию ползунка горизонтальной полосы прокрутки
   int h=m_scrollh.CurrentPos()+l;
//--- Столбцы
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- Получим текущую позицию ползунка вертикальной полосы прокрутки
      int v=m_scrollv.CurrentPos()+t;
      //--- Ряды
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- Смещение данных таблицы
         if(v>=t && v<m_rows_total)
           {
            //--- Корректировка с учётом выделенной строки
            color back_color=(m_selected_item==v) ? m_selected_row_color : m_vcolumns[h].m_cell_color[v];
            color text_color=(m_selected_item==v) ? m_selected_row_text_color : m_vcolumns[h].m_text_color[v];
            //--- Корректировка цвета текста и фона ячейки
            m_columns[c].m_rows[r].Color(text_color);
            m_columns[c].m_rows[r].BackColor(back_color);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета ряда таблицы при наведении курсора мыши          |
//+------------------------------------------------------------------+
void CTable::RowColorByHover(const int x,const int y)
  {
//--- Выйти, если отключена подстветка ряда при наведении курсора мыши или форма заблокирована
   if(!m_lights_hover || !m_read_only || m_wnd.IsLocked())
      return;
//--- Выйти, если полоса прокрутки в процессе перемещения
   if(m_scrollv.ScrollState() || m_scrollh.ScrollState())
      return;
//--- Смещение на один индекс, если включен режим закреплённых заголовков
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- Получим текущую позицию ползунка горизонтальной полосы прокрутки
   int h=m_scrollh.CurrentPos()+l;
//--- Столбцы
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- Получим текущую позицию ползунка вертикальной полосы прокрутки
      int v=m_scrollv.CurrentPos()+t;
      //--- Ряды
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- Проверка для предотвращения выхода из диапазона
         if(v>=t && v<m_rows_total)
           {
            //--- Пропустить, если в режиме "Только чтение", включено выделение ряда и дошли до выделенной строки
            if(m_selected_item==v && m_read_only && m_selectable_row)
              {
               v++;
               continue;
              }
            //--- Подсветить ряд, если курсор над ним
            if(x>m_columns[0].m_rows[r].X() && x<m_columns[m_visible_columns_total-1].m_rows[r].X2() &&
               y>m_columns[c].m_rows[r].Y() && y<m_columns[c].m_rows[r].Y2())
              {
               m_columns[c].m_rows[r].BackColor(m_cell_color_hover);
              }
            //--- Вернуть цвет по умолчанию, если курсор вне области этого ряда
            else
              {
               if(v>=t && v<m_rows_total)
                  m_columns[c].m_rows[r].BackColor(m_vcolumns[h].m_cell_color[v]);
              }
            //---
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| Ускоренная перемотка данных таблицы                              |
//+------------------------------------------------------------------+
void CTable::FastSwitching(void)
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
      //--- Если прокрутка влево
      else if(m_scrollh.ScrollIncState())
         m_scrollh.OnClickScrollInc(m_scrollh.ScrollIncName());
      //--- Если прокрутка вправо
      else if(m_scrollh.ScrollDecState())
         m_scrollh.OnClickScrollDec(m_scrollh.ScrollDecName());
      //--- Обновление данных и свойств
      UpdateTable();
      //--- Подсветка строки
      HighlightSelectedItem();
     }
  }
//+------------------------------------------------------------------+
