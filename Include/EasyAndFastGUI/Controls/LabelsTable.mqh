//+------------------------------------------------------------------+
//|                                                  LabelsTable.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| Класс для создания таблицы из текстовых меток                    |
//+------------------------------------------------------------------+
class CLabelsTable : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания таблицы
   CRectLabel        m_area;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   //--- Массив объектов видимой части таблицы
   struct LTLabels
     {
      CLabel            m_rows[];
     };
   LTLabels          m_columns[];
   //--- Массивы значений и свойств таблицы
   struct LTOptions
     {
      string            m_vrows[];
      color             m_colors[];
     };
   LTOptions         m_vcolumns[];
   //--- Количество столбцов и рядов (общее и видимой части) таблицы
   int               m_rows_total;
   int               m_columns_total;
   int               m_visible_rows_total;
   int               m_visible_columns_total;
   //--- Высота ряда
   int               m_row_y_size;
   //--- Цвет фона таблицы
   color             m_area_color;
   //--- Цвет текста в таблице по умолчанию
   color             m_text_color;
   //--- Расстояние между точкой привязки первого столбца и левым краем элемента
   int               m_x_offset;
   //--- Расстояние между точками привязки столбцов
   int               m_column_x_offset;
   //--- Режим фиксации первой строки
   bool              m_fix_first_row;
   //--- Режим фиксации первого столбца
   bool              m_fix_first_column;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_zorder;
   int               m_area_zorder;
   //--- Состояние кнопки мыши (нажата/отжата)
   ENUM_THUMB_MOUSE_STATE m_clamping_area_mouse;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //---
public:
                     CLabelsTable(void);
                    ~CLabelsTable(void);
   //--- Методы для создания таблицы
   bool              CreateLabelsTable(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabels(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращает указатели на полосы прокрутки
   void              WindowPointer(CWindow &object)               { m_wnd=::GetPointer(object);      }
   CScrollV         *GetScrollVPointer(void)                      { return(::GetPointer(m_scrollv)); }
   CScrollH         *GetScrollHPointer(void)                      { return(::GetPointer(m_scrollh)); }
   //--- Возвращает общее количество (1) рядов и (2) столбцов
   int               RowsTotal(void)                        const { return(m_rows_total);            }
   int               ColumnsTotal(void)                     const { return(m_columns_total);         }
   //--- Возвращает количество (1) рядов и (2) столбцов видимой части таблицы
   int               VisibleRowsTotal(void)                 const { return(m_visible_rows_total);    }
   int               VisibleColumnsTotal(void)              const { return(m_visible_columns_total); }
   //--- (1) Цвет фона, (2) цвет текста
   void              AreaColor(const color clr)                   { m_area_color=clr;                }
   void              TextColor(const color clr)                   { m_text_color=clr;                }
   //--- (1) Высота ряда, (2) устанавливает расстояние между точкой привязки первого столбца и левым краем таблицы,
   //    (3) устанавливает расстояние между точками привязки столбцов
   void              RowYSize(const int y_size)                   { m_row_y_size=y_size;             }
   void              XOffset(const int x_offset)                  { m_x_offset=x_offset;             }
   void              ColumnXOffset(const int x_offset)            { m_column_x_offset=x_offset;      }
   //--- (1) Возвращает и (2) устанавливает режим фиксации первой строки
   bool              FixFirstRow(void)                      const { return(m_fix_first_row);         }
   void              FixFirstRow(const bool flag)                 { m_fix_first_row=flag;            }
   //--- (1) Возвращает и (2) устанавливает режим фиксации первого столбца
   bool              FixFirstColumn(void)                   const { return(m_fix_first_column);      }
   void              FixFirstColumn(const bool flag)              { m_fix_first_column=flag;         }

   //--- Устанавливает (1) размер таблицы и (2) размер видимой её части 
   void              TableSize(const int columns_total,const int rows_total);
   void              VisibleTableSize(const int visible_columns_total,const int visible_rows_total);
   //--- Устанавливает значение в указанную ячейку таблицы
   void              SetValue(const int column_index,const int row_index,const string value);
   //--- Получает значение из указанной ячейки таблицы
   string            GetValue(const int column_index,const int row_index);
   //--- Изменяет цвет текста в указанной ячейке таблицы
   void              TextColor(const int column_index,const int row_index,const color clr);
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
   virtual void      ResetColors(void) {}
   //---
private:
   //--- Ускоренная перемотка списка
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CLabelsTable::CLabelsTable(void) : m_fix_first_row(false),
                                   m_fix_first_column(false),
                                   m_row_y_size(18),
                                   m_x_offset(30),
                                   m_column_x_offset(60),
                                   m_area_color(clrWhiteSmoke),
                                   m_text_color(clrBlack),
                                   m_rows_total(2),
                                   m_columns_total(1),
                                   m_visible_rows_total(2),
                                   m_visible_columns_total(1)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder      =0;
   m_area_zorder =1;
//--- Установим размер таблицы и её видимой части
   TableSize(m_columns_total,m_rows_total);
   VisibleTableSize(m_visible_columns_total,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CLabelsTable::~CLabelsTable(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CLabelsTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- Проверка фокуса над таблицей
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      //--- Смещаем список, если управление ползунком полосы прокрутки в действии
      if(m_scrollv.ScrollBarControl(x,y,m_mouse_state) || m_scrollh.ScrollBarControl(x,y,m_mouse_state))
         UpdateTable();
      //---
      return;
     }
//--- Обработка нажатия на объектах
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Если было нажатие на одной из кнопок полос прокрутки таблицы
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
         //--- Сдвигает таблицу относительно полосы прокрутки
         UpdateTable();
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CLabelsTable::OnEventTimer(void)
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
//| Создаёт таблицу из текстовых меток                               |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateLabelsTable(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием таблицы из меток классу нужно передать "
              "указатель на форму: CLabelsTable::WindowPointer(CWindow &object).");
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
   if(!CreateLabels())
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
//| Создаёт фон таблицы                                              |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_labelstable_area_"+(string)CElement::Id();
//--- Отступы от крайней точки
   m_area.XGap(CElement::X()-m_wnd.X());
   m_area.YGap(CElement::Y()-m_wnd.Y());
//--- Если есть горизонтальная полоса прокрутки, то скорректировать размер таблицы по оси Y
   m_y_size=(m_columns_total>m_visible_columns_total) ? m_y_size+m_scrollh.ScrollWidth()-1 : m_y_size;
//--- Создание объекта
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установка свойств
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
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
//| Создаёт массив текстовых меток                                   |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateLabels(void)
  {
//--- Координаты и отступ
   int x      =CElement::X();
   int y      =0;
   int offset =0;
//--- Столбцы
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- Расчёт отступа столбца
      offset=(c>0) ? m_column_x_offset : m_x_offset;
      //--- Расчёт координаты X
      x=x+offset;
      //--- Ряды
      for(int r=0; r<m_visible_rows_total; r++)
        {
         //--- Формирование имени объекта
         string name=CElement::ProgramName()+"_labelstable_label_"+(string)c+"_"+(string)r+"__"+(string)CElement::Id();
         //--- Расчёт координаты Y
         y=(r>0) ? y+m_row_y_size-1 : CElement::Y()+10;
         //--- Создание объекта
         if(!m_columns[c].m_rows[r].Create(m_chart_id,name,m_subwin,x,y))
            return(false);
         //--- Установка свойств
         m_columns[c].m_rows[r].Description(m_vcolumns[c].m_vrows[r]);
         m_columns[c].m_rows[r].Font(FONT);
         m_columns[c].m_rows[r].FontSize(FONT_SIZE);
         m_columns[c].m_rows[r].Color(m_text_color);
         m_columns[c].m_rows[r].Corner(m_corner);
         m_columns[c].m_rows[r].Anchor(ANCHOR_CENTER);
         m_columns[c].m_rows[r].Selectable(false);
         m_columns[c].m_rows[r].Z_Order(m_zorder);
         m_columns[c].m_rows[r].Tooltip("\n");
         //--- Отступы от крайней точки формы
         m_columns[c].m_rows[r].XGap(x-m_wnd.X());
         m_columns[c].m_rows[r].YGap(y-m_wnd.Y());
         //--- Координаты
         m_columns[c].m_rows[r].X(x);
         m_columns[c].m_rows[r].Y(y);
         //--- Сохраним указатель объекта
         CElement::AddToArray(m_columns[c].m_rows[r]);
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вертикальную полосу прокрутки                            |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateScrollV(void)
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
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(CElement::YSize()-m_scrollv.ScrollWidth()+1);
//--- Создание полосы прокрутки
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_rows_total,m_visible_rows_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт горизонтальную полосу прокрутки                          |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateScrollH(void)
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
//--- Установим свойства
   m_scrollh.Id(CElement::Id());
   m_scrollh.XSize(CElement::XSize()-m_scrollh.ScrollWidth()+1);
   m_scrollh.YSize(m_scrollh.ScrollWidth());
//--- Создание полосы прокрутки
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_columns_total,m_visible_columns_total))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Устанавливает размер таблицы                                     |
//+------------------------------------------------------------------+
void CLabelsTable::TableSize(const int columns_total,const int rows_total)
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
      ::ArrayResize(m_vcolumns[i].m_colors,m_rows_total);
      //--- Инициализация массива цвета текста значением по умолчанию
      ::ArrayInitialize(m_vcolumns[i].m_colors,m_text_color);
     }
  }
//+------------------------------------------------------------------+
//| Устанавливает размер видимой части таблицы                       |
//+------------------------------------------------------------------+
void CLabelsTable::VisibleTableSize(const int visible_columns_total,const int visible_rows_total)
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
//| Устанавливает значение по указанным индексам                     |
//+------------------------------------------------------------------+
void CLabelsTable::SetValue(const int column_index,const int row_index,const string value)
  {
//--- Проверка на выход из диапазона столбцов
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Проверка на выход из диапазона рядов
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Установить значение
   m_vcolumns[column_index].m_vrows[row_index]=value;
  }
//+------------------------------------------------------------------+
//| Возвращает значение по указанным индексам                        |
//+------------------------------------------------------------------+
string CLabelsTable::GetValue(const int column_index,const int row_index)
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
//| Изменяет цвет по указанным индексам                              |
//+------------------------------------------------------------------+
void CLabelsTable::TextColor(const int column_index,const int row_index,const color clr)
  {
//--- Проверка на выход из диапазона столбцов
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Проверка на выход из диапазона рядов
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Установить цвет
   m_vcolumns[column_index].m_colors[row_index]=clr;
  }
//+------------------------------------------------------------------+
//| Обновление данных таблицы с учётом последних изменений           |
//+------------------------------------------------------------------+
void CLabelsTable::UpdateTable(void)
  {
//--- Смещение на один индекс, если включен режим закреплённых заголовков
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- Получим текущие позиции ползунков горизонтальной и вертикальной полос прокрутки
   int h=m_scrollh.CurrentPos()+l;
   int v=m_scrollv.CurrentPos()+t;
//--- Смещение заголовков в левом столбце
   if(m_fix_first_column)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      //--- Ряды
      for(int r=t; r<m_visible_rows_total; r++)
        {
         if(r>=t && r<m_rows_total)
            m_columns[0].m_rows[r].Description(m_vcolumns[0].m_vrows[v]);
         //---
         v++;
        }
     }
//--- Смещение заголовков в верхнем ряду
   if(m_fix_first_row)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      //--- Столбцы
      for(int c=l; c<m_visible_columns_total; c++)
        {
         if(h>=l && h<m_columns_total)
            m_columns[c].m_rows[0].Description(m_vcolumns[h].m_vrows[0]);
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
            //--- Корректировка цвета
            m_columns[c].m_rows[r].Color(m_vcolumns[h].m_colors[v]);
            //--- Корректировка значений
            m_columns[c].m_rows[r].Description(m_vcolumns[h].m_vrows[v]);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элемента                                             |
//+------------------------------------------------------------------+
void CLabelsTable::Moving(const int x,const int y)
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
void CLabelsTable::Show(void)
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
void CLabelsTable::Hide(void)
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
void CLabelsTable::Reset(void)
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
void CLabelsTable::Delete(void)
  {
//--- Удаление графических объектов
   m_area.Delete();
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Delete();
      //---
      ::ArrayFree(m_columns[c].m_rows);
     }
//--- Освобождение массивов элемента
   for(int c=0; c<m_columns_total; c++)
     {
      ::ArrayFree(m_vcolumns[c].m_vrows);
      ::ArrayFree(m_vcolumns[c].m_colors);
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
void CLabelsTable::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(m_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CLabelsTable::ResetZorders(void)
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
//| Ускоренная промотка                                              |
//+------------------------------------------------------------------+
void CLabelsTable::FastSwitching(void)
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
      //--- Смещает список
      UpdateTable();
     }
  }
//+------------------------------------------------------------------+
