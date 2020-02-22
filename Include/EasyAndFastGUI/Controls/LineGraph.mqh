//+------------------------------------------------------------------+
//|                                                    LineGraph.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания линейного графика                             |
//+------------------------------------------------------------------+
class CLineGraph : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания элемента
   CLineChartObject  m_line_chart;
   //--- Цвета градиента
   color             m_bg_color;
   color             m_bg_color2;
   //--- Цвет рамки
   color             m_border_color;
   //--- Цвет сетки
   color             m_grid_color;
   //--- Цвет текста
   color             m_text_color;
   //--- Количество знаков после запятой
   int               m_digits;
   //---
public:
                     CLineGraph(void);
                    ~CLineGraph(void);
   //--- Методы для создания элемента
   bool              CreateLineGraph(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateGraph(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) количество знаков после запятой, (3) максимальное количество рядов данных
   void              WindowPointer(CWindow &object)    { m_wnd=::GetPointer(object);  }
   void              SetDigits(const int digits)       { m_digits=::fabs(digits);     }
   void              MaxData(const int total)          { m_line_chart.MaxData(total); }
   //--- Два цвета для градиента
   void              BackgroundColor(const color clr)  { m_bg_color=clr;              }
   void              BackgroundColor2(const color clr) { m_bg_color2=clr;             }
   //--- Цвета (1) рамки, (2) сетки и (3) текста
   void              BorderColor(const color clr)      { m_border_color=clr;          }
   void              GridColor(const color clr)        { m_grid_color=clr;            }
   void              TextColor(const color clr)        { m_text_color=clr;            }
   //--- Установка параметров вертикальной шкалы
   void              VScaleParams(const double max,const double min,const int num_grid);
   //--- Добавление ряда на график
   void              SeriesAdd(double &data[],const string descr,const color clr);
   //--- Обновление ряда на графике
   void              SeriesUpdate(const uint pos,const double &data[],const string descr,const color clr);
   //--- Удаление ряда с графика
   void              SeriesDelete(const uint pos);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- Таймер
   virtual void      OnEventTimer(void) {}
   //--- Перемещение элемента
   virtual void      Moving(const int x,const int y);
   //--- (1) Показ, (2) скрытие, (3) сброс, (4) удаление
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CLineGraph::CLineGraph(void) : m_digits(2),
                               m_bg_color(clrBlack),
                               m_bg_color2(C'0,80,95'),
                               m_border_color(clrDimGray),
                               m_grid_color(C'50,55,60'),
                               m_text_color(clrLightSlateGray)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CLineGraph::~CLineGraph(void)
  {
  }
//+------------------------------------------------------------------+
//| Создаёт график                                                   |
//+------------------------------------------------------------------+
bool CLineGraph::CreateLineGraph(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием графика классу нужно передать "
              "указатель на форму: CLineGraph::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Создание элемента
   if(!CreateGraph())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт холст для рисования                                      |
//+------------------------------------------------------------------+
bool CLineGraph::CreateGraph(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_line_graph_"+(string)CElement::Id();
//--- Создание объекта
   if(!m_line_chart.CreateBitmapLabel(m_chart_id,m_subwin,name,m_x,m_y,m_x_size,m_y_size,COLOR_FORMAT_XRGB_NOALPHA))
      return(false);
//--- Прикрепить объект к графику терминала
   if(!m_line_chart.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Свойства
   m_line_chart.FontSet(FONT,-80,FW_NORMAL);
   m_line_chart.ScaleDigits(m_digits);
   m_line_chart.ColorBackground(m_bg_color);
   m_line_chart.ColorBackground2(m_bg_color2);
   m_line_chart.ColorBorder(m_border_color);
   m_line_chart.ColorGrid(::ColorToARGB(m_grid_color));
   m_line_chart.ColorText(::ColorToARGB(m_text_color));
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Сохраним размеры (в группе)
   CElement::XSize(CElement::XSize());
   CElement::YSize(CElement::YSize());
//--- Отступы от крайней точки
   m_line_chart.XGap(CElement::X()-m_wnd.X());
   m_line_chart.YGap(CElement::Y()-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_line_chart);
   return(true);
  }
//+------------------------------------------------------------------+
//| Установка параметров оси Y                                       |
//+------------------------------------------------------------------+
void CLineGraph::VScaleParams(const double max,const double min,const int num_grid)
  {
   m_line_chart.VScaleParams(max,min,num_grid);
  }
//+------------------------------------------------------------------+
//| Добавление серии на график                                       |
//+------------------------------------------------------------------+
void CLineGraph::SeriesAdd(double &data[],const string descr,const color clr)
  {
   m_line_chart.SeriesAdd(data,descr,::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| Обновление серии на графике                                      |
//+------------------------------------------------------------------+
void CLineGraph::SeriesUpdate(const uint pos,const double &data[],const string descr,const color clr)
  {
   m_line_chart.SeriesUpdate(pos,data,descr,::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| Удаление серии с графика                                         |
//+------------------------------------------------------------------+
void CLineGraph::SeriesDelete(const uint pos)
  {
   m_line_chart.SeriesDelete(pos);
  }
//+------------------------------------------------------------------+
//| Перемещение                                                      |
//+------------------------------------------------------------------+
void CLineGraph::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_line_chart.X(x+m_line_chart.XGap());
   m_line_chart.Y(y+m_line_chart.YGap());
//--- Обновление координат графических объектов
   m_line_chart.X_Distance(m_line_chart.X());
   m_line_chart.Y_Distance(m_line_chart.Y());
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CLineGraph::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   m_line_chart.Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CLineGraph::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   m_line_chart.Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CLineGraph::Reset(void)
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
void CLineGraph::Delete(void)
  {
   m_line_chart.DeleteAll();
   m_line_chart.Destroy();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
