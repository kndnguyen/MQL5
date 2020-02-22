//+------------------------------------------------------------------+
//|                                                  CanvasTable.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| Класс для создания нарисованной таблицы                          |
//+------------------------------------------------------------------+
class CCanvasTable : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания таблицы
   CRectLabel        m_area;
   CRectCanvas       m_canvas;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   //--- Массив значений и свойства таблицы
   struct CTOptions
     {
      string            m_vrows[];
      int               m_width;
      ENUM_ALIGN_MODE   m_text_align;
     };
   CTOptions         m_vcolumns[];
   //--- 
   int               m_rows_total;
   int               m_columns_total;
   int               m_visible_rows_total;
   int               m_visible_columns_total;
   //--- Общий размер и размер видимой части таблицы
   int               m_table_x_size;
   int               m_table_y_size;
   int               m_table_visible_x_size;
   int               m_table_visible_y_size;
   //--- Цвет фона
   color             m_area_color;
   //--- Цвет сетки
   color             m_grid_color;
   //--- Размер (высота) ячеек
   int               m_cell_y_size;
   //--- Цвет ячеек
   color             m_cell_color;
   //--- Цвет текста
   color             m_cell_text_color;
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
                     CCanvasTable(void);
                    ~CCanvasTable(void);
   //--- Методы для создания таблицы
   bool              CreateTable(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCells(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращает указатели на полосы прокрутки
   void              WindowPointer(CWindow &object)       { m_wnd=::GetPointer(object);      }
   CScrollV         *GetScrollVPointer(void)              { return(::GetPointer(m_scrollv)); }
   CScrollH         *GetScrollHPointer(void)              { return(::GetPointer(m_scrollh)); }
   //--- Цвет (1) фона, (2) сетки и (3) текста таблицы
   void              AreaColor(const color clr)           { m_cell_color=clr;                }
   void              GridColor(const color clr)           { m_grid_color=clr;                }
   void              TextColor(const color clr)           { m_cell_text_color=clr;           }
   //--- (1) Высота ячеек, возвращает общее количество (2) рядов и (3) столбцов
   void              CellYSize(const int y_size)          { m_cell_y_size=y_size;            }
   int               RowsTotal(void)                const { return(m_rows_total);            }
   int               ColumnsTotal(void)             const { return(m_columns_total);         }
   //--- Возвращает количество (1) рядов и (2) столбцов видимой части таблицы
   int               VisibleRowsTotal(void)         const { return(m_visible_rows_total);    }
   int               VisibleColumnsTotal(void)      const { return(m_visible_columns_total); }
   //--- Устанавливает (1) основной размер таблицы и (2) размер видимой её части
   void              TableSize(const int columns_total,const int rows_total);
   void              VisibleTableSize(const int visible_columns_total,const int visible_rows_total);
   //--- Установка (1) режима выравнивания текста и (2) ширины для каждого столбца
   void              TextAlign(const ENUM_ALIGN_MODE &array[]);
   void              ColumnsWidth(const int &array[]);
   //--- Устанавливает значение в указанную ячейку таблицы
   void              SetValue(const int column_index,const int row_index,const string value);
   //--- Получает значение из указанной ячейки таблицы
   string            GetValue(const int column_index,const int row_index);
   //--- Смещение таблицы относительно позиций полос прокрутки
   void              ShiftTable(void);
   //--- Рисует таблицу с учётом последних внесённых изменений
   void              DrawTable(void);
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
   //--- Рассчитывает размеры таблицы
   void              CalculateTableSize(void);
   //--- Рисует сетку
   void              DrawGrid(void);
   //--- Рисует текст
   void              DrawText(void);
   //--- Ускоренная перемотка таблицы
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCanvasTable::CCanvasTable(void) : m_cell_y_size(18),
                                   m_rows_total(2),
                                   m_columns_total(1),
                                   m_visible_rows_total(2),
                                   m_visible_columns_total(1),
                                   m_grid_color(clrWhite),
                                   m_cell_color(clrWhite),
                                   m_cell_text_color(clrBlack)
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
CCanvasTable::~CCanvasTable(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CCanvasTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
         ShiftTable();
      //---
      return;
     }
//--- Обработка нажатия на объектах
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Если нажали на кнопке полосы прокрутки
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
        {
         //--- Сдвигает таблицу
         ShiftTable();
        }
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CCanvasTable::OnEventTimer(void)
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
//| Создаёт нарисованную таблицу                                     |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateTable(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием таблицы классу нужно передать "
              "указатель на форму: CCanvasTable::WindowPointer(CWindow &object).");
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
//--- Рассчитаем размеры таблицы
   CalculateTableSize();
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
bool CCanvasTable::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_table_area_"+(string)CElement::Id();
//--- Создание объекта
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установка свойств
   m_area.BackColor(m_cell_color);
   m_area.Color(m_cell_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Сохраним размеры
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- Сохраним координаты
   m_area.X(m_x);
   m_area.Y(m_y);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт сетку ячеек таблицы                                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateCells(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_table_canvas_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X()+1;
   int y =CElement::Y()+1;
//--- Создание объекта
   ::ResetLastError();
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,m_table_x_size,m_table_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > Не удалось создать холст для рисования таблицы: ",::GetLastError());
      return(false);
     }
//--- Прикрепить к графику
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Установим свойства
   m_canvas.Tooltip("\n");
//--- Координаты
   m_canvas.X(x);
   m_canvas.Y(y);
//--- Отступы от крайней точки панели
   m_canvas.XGap(x-m_wnd.X());
   m_canvas.YGap(y-m_wnd.Y());
//--- Сохраним размеры
   m_canvas.XSize(m_table_x_size);
   m_canvas.YSize(m_table_y_size);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_canvas);
//--- Установим размеры видимой области
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_XSIZE,m_table_visible_x_size);
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_YSIZE,m_table_visible_y_size);
//--- Зададим смещение фрейма внутри изображения по осям X и Y
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_XOFFSET,0);
   ::ObjectSetInteger(m_chart_id,name,OBJPROP_YOFFSET,0);
//--- Нарисуем таблицу
   DrawTable();
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вертикальный скролл                                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateScrollV(void)
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
//--- Установим свойства
   m_scrollv.Id(CElement::Id());
   m_scrollv.IsDropdown(CElement::IsDropdown());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(m_cell_y_size*m_visible_rows_total+2-(m_visible_rows_total-1));
//--- Создание полосы прокрутки
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_rows_total,m_visible_rows_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт горизонтальный скролл                                    |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateScrollH(void)
  {
//--- Если общая ширина таблицы больше, чем видимая её часть, то
//    установим горизонтальную полосу прокрутки
   if(m_table_x_size<=m_table_visible_x_size)
      return(true);
//--- Сохранить указатель формы
   m_scrollh.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y2()-m_scrollh.ScrollWidth();
//--- Установим свойства
   m_scrollh.Id(CElement::Id());
   m_scrollh.IsDropdown(CElement::IsDropdown());
   m_scrollh.XSize(m_area.XSize()-m_scrollh.ScrollWidth()+1);
   m_scrollh.YSize(m_scrollh.ScrollWidth());
//--- Создание полосы прокрутки
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_table_x_size,m_table_visible_x_size))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Заполняет массив режимом выравнивания текста                     |
//+------------------------------------------------------------------+
void CCanvasTable::TextAlign(const ENUM_ALIGN_MODE &array[])
  {
   int total=0;
   int array_size=::ArraySize(array);
//--- Выйти, если передан массив нулевого размера
   if(array_size<1)
      return;
//--- Скорректировать значение для предотвращения выхода из диапазона массива 
   total=(array_size<m_columns_total)? array_size : m_columns_total;
//--- Сохранить значения в структуре
   for(int c=0; c<total; c++)
      m_vcolumns[c].m_text_align=array[c];
  }
//+------------------------------------------------------------------+
//| Заполняет массив ширины столбцов                                 |
//+------------------------------------------------------------------+
void CCanvasTable::ColumnsWidth(const int &array[])
  {
   int total=0;
   int array_size=::ArraySize(array);
//--- Выйти, если передан массив нулевого размера
   if(array_size<1)
      return;
//--- Скорректировать значение для предотвращения выхода из диапазона массива 
   total=(array_size<m_columns_total)? array_size : m_columns_total;
//--- Сохранить значения в структуре
   for(int c=0; c<total; c++)
      m_vcolumns[c].m_width=array[c];
  }
//+------------------------------------------------------------------+
//| Заполняет массив по указанным индексам                           |
//+------------------------------------------------------------------+
void CCanvasTable::SetValue(const int column_index,const int row_index,const string value)
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
string CCanvasTable::GetValue(const int column_index,const int row_index)
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
//| Устанавливает размер таблицы                                     |
//+------------------------------------------------------------------+
void CCanvasTable::TableSize(const int columns_total,const int rows_total)
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
      //--- Инициализация свойств столбцов значениями по умолчанию
      m_vcolumns[i].m_width      =100;
      m_vcolumns[i].m_text_align =ALIGN_CENTER;
     }
  }
//+------------------------------------------------------------------+
//| Устанавливает размер видимой части таблицы                       |
//+------------------------------------------------------------------+
void CCanvasTable::VisibleTableSize(const int visible_columns_total,const int visible_rows_total)
  {
//--- Должно быть не менее одного столбца
   m_visible_columns_total=(visible_columns_total<1) ? 1 : visible_columns_total;
//--- Должно быть не менее двух рядов
   m_visible_rows_total=(visible_rows_total<2) ? 2 : visible_rows_total;
  }
//+------------------------------------------------------------------+
//| Рассчитывает размеры таблицы                                     |
//+------------------------------------------------------------------+
void CCanvasTable::CalculateTableSize(void)
  {
//--- Рассчитаем общую ширину таблицы
   m_table_x_size=0;
   for(int c=0; c<m_columns_total; c++)
      m_table_x_size=m_table_x_size+m_vcolumns[c].m_width;
//--- Ширина таблицы с учётом наличия вертикальной полосы прокрутки
   int x_size=(m_rows_total>m_visible_rows_total) ? m_x_size-m_scrollh.ScrollWidth() : m_x_size-2;
//--- Если ширина всех столбцов меньше ширины таблицы, то будем использовать ширину таблицы
   if(m_table_x_size<m_x_size)
      m_table_x_size=x_size;
//--- Рассчитаем общую высоту таблицы
   m_table_y_size=m_cell_y_size*m_rows_total-(m_rows_total-1);
//--- Зададим размер фрейма для показа фрагмента изображения (видимой части таблицы таблицы)
   m_table_visible_x_size=x_size;
   m_table_visible_y_size=m_cell_y_size*m_visible_rows_total-(m_visible_rows_total-1);
//--- Если есть горизонтальная полоса прокрутки, то скорректировать размер элемента по оси Y
   int y_size=m_cell_y_size*m_visible_rows_total+2-(m_visible_rows_total-1);
   m_y_size=(m_table_x_size>m_table_visible_x_size) ? y_size+m_scrollh.ScrollWidth()-1 : y_size;
  }
//+------------------------------------------------------------------+
//| Рисует сетку                                                     |
//+------------------------------------------------------------------+
void CCanvasTable::DrawGrid(void)
  {
//--- Цвет сетки
   uint clr=::ColorToARGB(m_grid_color,255);
//--- Размер холста для рисования
   int x_size =m_canvas.XSize()-1;
   int y_size =m_canvas.YSize()-1;
//--- Координаты
   int x1=0,x2=0,y1=0,y2=0;
//--- Горизонтальные линии
   x1=0;
   y1=0;
   x2=x_size;
   y2=0;
   for(int i=0; i<=m_rows_total; i++)
     {
      m_canvas.Line(x1,y1,x2,y2,clr);
      y2=y1+=m_cell_y_size-1;
     }
//--- Вертикальные линии
   x1=0;
   y1=0;
   x2=0;
   y2=y_size;
   for(int i=0; i<m_columns_total; i++)
     {
      m_canvas.Line(x1,y1,x2,y2,clr);
      x2=x1+=m_vcolumns[i].m_width;
     }
//--- Справа
   x1=x_size;
   y1=0;
   x2=x_size;
   y2=y_size;
   m_canvas.Line(x1,y1,x2,y2,clr);
  }
//+------------------------------------------------------------------+
//| Рисует текст                                                     |
//+------------------------------------------------------------------+
void CCanvasTable::DrawText(void)
  {
//--- Для расчёта координат и отступов
   int  x             =0;
   int  y             =0;
   uint text_align    =0;
   int  column_offset =0;
   int  cell_x_offset =10;
   int  cell_y_offset =3;
//--- Цвет текста
   uint clr=::ColorToARGB(m_cell_text_color,255);
//--- Свойства шрифта
   m_canvas.FontSet(FONT,-80,FW_NORMAL);
//--- Столбцы
   for(int c=0; c<m_columns_total; c++)
     {
      //--- Расчёты отступа для первого столбца
      if(c==0)
        {
         //--- Выравнивание текста в ячейках по установленному режиму для каждого столбца
         switch(m_vcolumns[0].m_text_align)
           {
            //--- По центру
            case ALIGN_CENTER :
               column_offset=column_offset+m_vcolumns[0].m_width/2;
               x=column_offset;
               break;
               //--- Cправа
            case ALIGN_RIGHT :
               column_offset=column_offset+m_vcolumns[0].m_width;
               x=column_offset-cell_x_offset;
               break;
               //--- Слева
            case ALIGN_LEFT :
               x=column_offset+cell_x_offset;
               break;
           }
        }
      //--- Расчёты отступов для всех столбцов кроме первого
      else
        {
         //--- Выравнивание текста в ячейках по установленному режиму для каждого столбца
         switch(m_vcolumns[c].m_text_align)
           {
            //--- По центру
            case ALIGN_CENTER :
               //--- Расчёт отступа относительно выравнивания в предыдущем столбце
               switch(m_vcolumns[c-1].m_text_align)
                 {
                  case ALIGN_CENTER :
                     column_offset=column_offset+(m_vcolumns[c-1].m_width/2)+(m_vcolumns[c].m_width/2);
                     break;
                  case ALIGN_RIGHT :
                     column_offset=column_offset+(m_vcolumns[c].m_width/2);
                     break;
                  case ALIGN_LEFT :
                     column_offset=column_offset+m_vcolumns[c-1].m_width+(m_vcolumns[c].m_width/2);
                     break;
                 }
               //---
               x=column_offset;
               break;
               //--- Справа
            case ALIGN_RIGHT :
               //--- Расчёт отступа относительно выравнивания в предыдущем столбце
               switch(m_vcolumns[c-1].m_text_align)
                 {
                  case ALIGN_CENTER :
                     column_offset=column_offset+(m_vcolumns[c-1].m_width/2)+m_vcolumns[c].m_width;
                     x=column_offset-cell_x_offset;
                     break;
                  case ALIGN_RIGHT :
                     column_offset=column_offset+m_vcolumns[c].m_width;
                     x=column_offset-cell_x_offset;
                     break;
                  case ALIGN_LEFT :
                     column_offset=column_offset+m_vcolumns[c-1].m_width+m_vcolumns[c].m_width;
                     x=column_offset-cell_x_offset;
                     break;
                 }
               //---
               break;
               //--- Слева
            case ALIGN_LEFT :
               //--- Расчёт отступа относительно выравнивания в предыдущем столбце
               switch(m_vcolumns[c-1].m_text_align)
                 {
                  case ALIGN_CENTER :
                     column_offset=column_offset+(m_vcolumns[c-1].m_width/2);
                     x=column_offset+cell_x_offset;
                     break;
                  case ALIGN_RIGHT :
                     x=column_offset+cell_x_offset;
                     break;
                  case ALIGN_LEFT :
                     column_offset=column_offset+m_vcolumns[c-1].m_width;
                     x=column_offset+cell_x_offset;
                     break;
                 }
               //---
               break;
           }
        }
      //--- Ряды
      for(int r=0; r<m_rows_total; r++)
        {
         //---
         y+=(r>0) ? m_cell_y_size-1 : cell_y_offset;
         //---
         switch(m_vcolumns[c].m_text_align)
           {
            case ALIGN_CENTER :
               text_align=TA_CENTER|TA_TOP;
               break;
            case ALIGN_RIGHT :
               text_align=TA_RIGHT|TA_TOP;
               break;
            case ALIGN_LEFT :
               text_align=TA_LEFT|TA_TOP;
               break;
           }
         //--- Нарисовать текст
         m_canvas.TextOut(x,y,m_vcolumns[c].m_vrows[r],clr,text_align);
        }
      //--- Обнулить координату Y для следующего цикла
      y=0;
     }
  }
//+------------------------------------------------------------------+
//| Рисует таблицу                                                   |
//+------------------------------------------------------------------+
void CCanvasTable::DrawTable(void)
  {
//--- Сделать фон прозрачным
   m_canvas.Erase(::ColorToARGB(clrNONE,0));
//--- Нарисовать сетку
   DrawGrid();
//--- Нарисовать текст
   DrawText();
//--- Отобразить последние нарисованные изменения
   m_canvas.Update();
//--- Смещение таблицы относительно полос прокрутки
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Сдвигает таблицу относительно полос прокрутки                    |
//+------------------------------------------------------------------+
void CCanvasTable::ShiftTable(void)
  {
//--- Получим текущие позиции ползунков горизонтальной и вертикальной полос прокрутки
   int h=m_scrollh.CurrentPos();
   int v=m_scrollv.CurrentPos();
//--- Расчёт положения таблицы относительно ползунков полос прокрутки
   long c=h;
   long r=v*(m_cell_y_size-1);
//--- Смещение таблицы
   ::ObjectSetInteger(m_chart_id,m_canvas.Name(),OBJPROP_XOFFSET,c);
   ::ObjectSetInteger(m_chart_id,m_canvas.Name(),OBJPROP_YOFFSET,r);
  }
//+------------------------------------------------------------------+
//| Перемещение элемента                                             |
//+------------------------------------------------------------------+
void CCanvasTable::Moving(const int x,const int y)
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
   m_canvas.X(x+m_canvas.XGap());
   m_canvas.Y(y+m_canvas.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_canvas.X_Distance(m_canvas.X());
   m_canvas.Y_Distance(m_canvas.Y());
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CCanvasTable::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
   m_scrollv.Show();
   m_scrollh.Show();
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CCanvasTable::Hide(void)
  {
//--- Выйти, если элемент уже скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_canvas.Timeframes(OBJ_NO_PERIODS);
   m_scrollv.Hide();
   m_scrollh.Hide();
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CCanvasTable::Reset(void)
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
void CCanvasTable::Delete(void)
  {
//--- Удаление графических объектов
   m_area.Delete();
   m_canvas.Delete();
//--- Освобождение массивов элемента
   for(int c=0; c<m_columns_total; c++)
      ::ArrayFree(m_vcolumns[c].m_vrows);
//---
   ::ArrayFree(m_vcolumns);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CCanvasTable::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_canvas.Z_Order(m_cell_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CCanvasTable::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_canvas.Z_Order(0);
   m_scrollv.ResetZorders();
   m_scrollh.ResetZorders();
  }
//+------------------------------------------------------------------+
//| Ускоренная промотка полосы прокрутки                             |
//+------------------------------------------------------------------+
void CCanvasTable::FastSwitching(void)
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
      //--- Смещает таблицу
      ShiftTable();
     }
  }
//+------------------------------------------------------------------+
