//+------------------------------------------------------------------+
//|                                                 SeparateLine.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания разделительной линии                          |
//+------------------------------------------------------------------+
class CSeparateLine : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объект для создания разделительной линии
   CRectCanvas       m_canvas;
   //--- Свойства
   ENUM_TYPE_SEP_LINE m_type_sep_line;   
   color             m_dark_color;
   color             m_light_color;
   //---
public:
                     CSeparateLine(void);
                    ~CSeparateLine(void);
   //--- Сохраняет указатель переданной формы
   void              WindowPointer(CWindow &object) { m_wnd=::GetPointer(object); }
   //--- Создание разделительной линии
   bool              CreateSeparateLine(const long chart_id,const int subwin,const int index,
                                        const int x,const int y,const int x_size,const int y_size);
   //---
private:
   //--- Создаёт холст для рисования разделительной линии
   bool              CreateSepLine(void);
   //--- Рисует разделительную линию
   void              DrawSeparateLine(void);
   //---
public:
   //--- (1) Тип линии, (2) цвета линии
   void              TypeSepLine(const ENUM_TYPE_SEP_LINE type) { m_type_sep_line=type; }
   void              DarkColor(const color clr)                 { m_dark_color=clr;     }
   void              LightColor(const color clr)                { m_light_color=clr;    }
   //---
public:
   //--- Обработчик события графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
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
CSeparateLine::CSeparateLine(void) : m_type_sep_line(H_SEP_LINE),
                                     m_dark_color(clrBlack),
                                     m_light_color(clrDimGray)
  {
//--- Сохраним имя класса элемента в базовом классе  
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSeparateLine::~CSeparateLine(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик события графика                                       |
//+------------------------------------------------------------------+
void CSeparateLine::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
  }
//+------------------------------------------------------------------+
//| Создаёт разделительную линию                                     |
//+------------------------------------------------------------------+
bool CSeparateLine::CreateSeparateLine(const long chart_id,const int subwin,const int index,
                                       const int x,const int y,const int x_size,const int y_size)
  {
//--- Выйти, если нет указателя на форму  
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием элемента классу нужно передать "
              "указатель на форму: CSeparateLine::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_index    =index;
   m_x        =x;
   m_y        =y;
   m_x_size   =x_size;
   m_y_size   =y_size;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создание элемента
   if(!CreateSepLine())
      return(false);
//--- Если форма свёрнуто, то спрятать элемент после создания
   if(m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт холст для рисования разделительной линии                 |
//+------------------------------------------------------------------+
bool CSeparateLine::CreateSepLine(void)
  {
//--- Формирование имени объекта  
   string name=CElement::ProgramName()+"_separate_line_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Создание объекта
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,m_x,m_y,m_x_size,m_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
      return(false);
//--- Прикрепить к графику
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Свойства
   m_canvas.Background(false);
//--- Отступы от крайней точки
   m_canvas.XGap(m_x-m_wnd.X());
   m_canvas.YGap(m_y-m_wnd.Y());
//--- Нарисовать разделительную линию
   DrawSeparateLine();
//--- Добавить в массив
   CElement::AddToArray(m_canvas);
   return(true);
  }
//+------------------------------------------------------------------+
//| Рисует разделительную линию                                      |
//+------------------------------------------------------------------+
void CSeparateLine::DrawSeparateLine(void)
  {
//--- Координаты для линий
   int x1=0,x2=0,y1=0,y2=0;
//--- Размеры холста
   int   x_size =m_canvas.X_Size()-1;
   int   y_size =m_canvas.Y_Size()-1;
//--- Очистить холст
   m_canvas.Erase(::ColorToARGB(clrNONE,0));
//--- Если линия горизонтальная
   if(m_type_sep_line==H_SEP_LINE)
     {
      //--- Сверху тёмная линия
      x1=0;
      y1=0;
      x2=x_size;
      y2=0;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_dark_color));
      //--- Снизу светлая линия
      x1=0;
      x2=x_size;
      y1=y_size;
      y2=y_size;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_light_color));
     }
//--- Если линия вертикальная
   else
     {
      //--- Слева тёмная линия
      x1=0;
      x2=0;
      y1=0;
      y2=y_size;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_dark_color));
      //--- Справа светлая линия
      x1=x_size;
      y1=0;
      x2=x_size;
      y2=y_size;
      //---
      m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(m_light_color));
     }
//--- Обновление холста
   m_canvas.Update();
  }
//+------------------------------------------------------------------+
//| Перемещение элемента                                             |
//+------------------------------------------------------------------+
void CSeparateLine::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_canvas.X(x+m_canvas.XGap());
   m_canvas.Y(y+m_canvas.YGap());
//--- Обновление координат графических объектов
   m_canvas.X_Distance(m_canvas.X());
   m_canvas.Y_Distance(m_canvas.Y());
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CSeparateLine::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты  
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
//--- Инициализация переменных
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CSeparateLine::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть объекты
   m_canvas.Timeframes(OBJ_NO_PERIODS);
//--- Присвоить статус скрытого элемента
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CSeparateLine::Reset(void)
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
void CSeparateLine::Delete(void)
  {
//--- Удаление объектов
   m_canvas.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
