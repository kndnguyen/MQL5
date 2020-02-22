//+------------------------------------------------------------------+
//|                                                      Tooltip.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания всплывающей подсказки                         |
//+------------------------------------------------------------------+
class CTooltip : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Указатель на элемент, к которому присоединена всплывающая подсказка
   CElement         *m_element;
   //--- Объекты для создания всплывающей подсказки
   CRectCanvas       m_canvas;
   //--- Свойства:
   //    Заголовок
   string            m_header;
   //--- Массив строк текста подсказки
   string            m_tooltip_lines[];
   //--- Значение альфа-канала (прозрачность подсказки)
   uchar             m_alpha;
   //--- Цвета (1) текста, (2) заголовка и (3) рамки фона
   color             m_text_color;
   color             m_header_color;
   color             m_border_color;
   //--- Цвета градиента фона
   color             m_gradient_top_color;
   color             m_gradient_bottom_color;
   //--- Массив градиента фона
   color             m_array_color[];
   //---
public:
                     CTooltip(void);
                    ~CTooltip(void);
   //--- Методы для создания всплывающей подсказки
   bool              CreateTooltip(const long chart_id,const int subwin);
   //---
private:
   //--- Создаёт холст для рисования подсказки
   bool              CreateCanvas(void);
   //--- (1) Рисует вертикальный градиент и (2) рамку
   void              VerticalGradient(const uchar alpha);
   void              Border(const uchar alpha);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) сохраняет указатель элемента, (3) заголовок всплывающей подсказки
   void              WindowPointer(CWindow &object)   { m_wnd=::GetPointer(object);     }
   void              ElementPointer(CElement &object) { m_element=::GetPointer(object); }
   void              Header(const string text)        { m_header=text;                  }
   //--- Добавляет строку для подсказки
   void              AddString(const string text);

   //--- (1) Показывает и (2) скрывает всплывающую подсказку
   void              ShowTooltip(void);
   void              FadeOutTooltip(void);
   //---
public:
   //--- Обработчик событий графика
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
CTooltip::CTooltip(void) : m_header(""),
                           m_alpha(0),
                           m_text_color(clrDimGray),
                           m_header_color(C'50,50,50'),
                           m_border_color(C'118,118,118'),
                           m_gradient_top_color(clrWhite),
                           m_gradient_bottom_color(C'208,208,235')
  {
//--- Сохраним имя класса элемента в базовом классе  
   CElement::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTooltip::~CTooltip(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий графика                                       |
//+------------------------------------------------------------------+
void CTooltip::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Выйти, если элемент скрыт
      if(!CElement::IsVisible())
         return;
      //--- Выйти, если кнопка всплывающих подсказок на форме отключена
      if(!m_wnd.TooltipBmpState())
         return;
      //--- Если форма заблокирована
      if(m_wnd.IsLocked())
        {
         //--- Скрыть подсказку
         FadeOutTooltip();
         return;
        }
      //--- Если есть фокус на элементе
      if(m_element.MouseFocus())
         //--- Показать подсказку
         ShowTooltip();
      //--- Если нет фокуса
      else
      //--- Скрыть подсказку
         FadeOutTooltip();
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Создаёт объект Tooltip                                           |
//+------------------------------------------------------------------+
bool CTooltip::CreateTooltip(const long chart_id,const int subwin)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием всплывающей подсказки классу нужно передать "
              "указатель на форму: CTooltip::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Выйти, если нет указателя на элемент
   if(::CheckPointer(m_element)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием всплывающей подсказки классу нужно передать "
              "указатель на элемент: CTooltip::ElementPointer(CElement &object).");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =m_element.X();
   m_y        =m_element.Y2()+1;
//--- Отступы от крайней точки
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Создаёт всплывающую подсказку
   if(!CreateCanvas())
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт холст для рисования                                      |
//+------------------------------------------------------------------+
bool CTooltip::CreateCanvas(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_help_tooltip_"+(string)CElement::Id();
//--- Создадим всплывающую подсказку
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,m_x,m_y,m_x_size,m_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
      return(false);
//--- Прикрепить к графику
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Установим свойства
   m_canvas.Background(false);
   m_canvas.Tooltip("\n");
//--- Отступы от крайней точки
   m_canvas.XGap(m_x-m_wnd.X());
   m_canvas.YGap(m_y-m_wnd.Y());
//--- Установка размера массива градиента для фона подсказки
   CElement::GradientColorsTotal(m_y_size);
   ::ArrayResize(m_array_color,m_y_size);
//--- Инициализация массива градиента
   CElement::InitColorArray(m_gradient_top_color,m_gradient_bottom_color,m_array_color);
//--- Очистка холста для рисования
   m_canvas.Erase(::ColorToARGB(clrNONE,0));
   m_canvas.Update();
   m_alpha=0;
//--- Сохраним указатель объекта
   CElement::AddToArray(m_canvas);
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет строку                                                 |
//+------------------------------------------------------------------+
void CTooltip::AddString(const string text)
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_tooltip_lines);
   ::ArrayResize(m_tooltip_lines,array_size+1);
//--- Сохраним значения переданных параметров
   m_tooltip_lines[array_size]=text;
  }
//+------------------------------------------------------------------+
//| Вертикальный градиент                                            |
//+------------------------------------------------------------------+
void CTooltip::VerticalGradient(const uchar alpha)
  {
//--- Координаты X
   int x1=0;
   int x2=m_x_size;
//--- Рисуем градиент
   for(int y=0; y<m_y_size; y++)
      m_canvas.Line(x1,y,x2,y,::ColorToARGB(m_array_color[y],alpha));
  }
//+------------------------------------------------------------------+
//| Рамка                                                            |
//+------------------------------------------------------------------+
void CTooltip::Border(const uchar alpha)
  {
//--- Цвет рамки
   color clr=m_border_color;
//--- Границы
   int x_size =m_canvas.X_Size()-1;
   int y_size =m_canvas.Y_Size()-1;
//--- Координаты: Сверху/Справа/Снизу/Слева
   int x1[4]; x1[0]=0;      x1[1]=x_size; x1[2]=0;      x1[3]=0;
   int y1[4]; y1[0]=0;      y1[1]=0;      y1[2]=y_size; y1[3]=0;
   int x2[4]; x2[0]=x_size; x2[1]=x_size; x2[2]=x_size; x2[3]=0;
   int y2[4]; y2[0]=0;      y2[1]=y_size; y2[2]=y_size; y2[3]=y_size;
//--- Рисуем рамку по указанным координатам
   for(int i=0; i<4; i++)
      m_canvas.Line(x1[i],y1[i],x2[i],y2[i],::ColorToARGB(clr,alpha));
//--- Округление по углам на один пиксель
   clr=clrBlack;
   m_canvas.PixelSet(0,0,::ColorToARGB(clr,0));
   m_canvas.PixelSet(0,m_y_size-1,::ColorToARGB(clr,0));
   m_canvas.PixelSet(m_x_size-1,0,::ColorToARGB(clr,0));
   m_canvas.PixelSet(m_x_size-1,m_y_size-1,::ColorToARGB(clr,0));
//--- Дорисовка пикселей по указанным координатам
   clr=C'180,180,180';
   m_canvas.PixelSet(1,1,::ColorToARGB(clr,alpha));
   m_canvas.PixelSet(1,m_y_size-2,::ColorToARGB(clr,alpha));
   m_canvas.PixelSet(m_x_size-2,1,::ColorToARGB(clr,alpha));
   m_canvas.PixelSet(m_x_size-2,m_y_size-2,::ColorToARGB(clr,alpha));
  }
//+------------------------------------------------------------------+
//| Отображает всплывающую подсказку                                 |
//+------------------------------------------------------------------+
void CTooltip::ShowTooltip(void)
  {
//--- Выйти, если подсказка видна на 100%
   if(m_alpha>=255)
      return;
//--- Координаты и отступ для заголовка
   int  x        =5;
   int  y        =5;
   int  y_offset =15;
//--- Рисуем градиент
   VerticalGradient(255);
//--- Рисуем рамку
   Border(255);
//--- Рисуем заголовок (если установлен)
   if(m_header!="")
     {
      //--- Установим параметры шрифта
      m_canvas.FontSet(FONT,-80,FW_BLACK);
      //--- Рисуем текст заголовка
      m_canvas.TextOut(x,y,m_header,::ColorToARGB(m_header_color),TA_LEFT|TA_TOP);
     }
//--- Координаты для основного текста подсказки (с учётом наличия заголовка)
   x=(m_header!="")? 15 : 5;
   y=(m_header!="")? 25 : 5;
//--- Установим параметры шрифта
   m_canvas.FontSet(FONT,-80,FW_THIN);
//--- Рисуем основной текст подсказки
   int lines_total=::ArraySize(m_tooltip_lines);
   for(int i=0; i<lines_total; i++)
     {
      m_canvas.TextOut(x,y,m_tooltip_lines[i],::ColorToARGB(m_text_color),TA_LEFT|TA_TOP);
      y=y+y_offset;
     }
//--- Обновить холст
   m_canvas.Update();
//--- Признак полностью видимой подсказки
   m_alpha=255;
  }
//+------------------------------------------------------------------+
//| Плавное исчезновение всплывающей подсказки                       |
//+------------------------------------------------------------------+
void CTooltip::FadeOutTooltip(void)
  {
//--- Выйти, если подсказка скрыта на 100%
   if(m_alpha<1)
      return;
//--- Отступ для заголовка
   int y_offset=15;
//--- Шаг прозрачности
   uchar fadeout_step=7;
//--- Плавное исчезновение подсказки
   for(uchar a=m_alpha; a>=0; a-=fadeout_step)
     {
      //--- Если следующий шаг в минус, остановим цикл
      if(a-fadeout_step<0)
        {
         a=0;
         m_canvas.Erase(::ColorToARGB(clrNONE,0));
         m_canvas.Update();
         m_alpha=0;
         break;
        }
      //--- Координаты для заголовка
      int x =5;
      int y =5;
      //--- Рисуем градиент и рамку
      VerticalGradient(a);
      Border(a);
      //--- Рисуем заголовок (если установлен)
      if(m_header!="")
        {
         //--- Установим параметры шрифта
         m_canvas.FontSet(FONT,-80,FW_BLACK);
         //--- Рисуем текст заголовка
         m_canvas.TextOut(x,y,m_header,::ColorToARGB(m_header_color,a),TA_LEFT|TA_TOP);
        }
      //--- Координаты для основного текста подсказки (с учётом наличия заголовка)
      x=(m_header!="")? 15 : 5;
      y=(m_header!="")? 25 : 5;
      //--- Установим параметры шрифта
      m_canvas.FontSet(FONT,-80,FW_THIN);
      //--- Рисуем основной текст подсказки
      int lines_total=::ArraySize(m_tooltip_lines);
      for(int i=0; i<lines_total; i++)
        {
         m_canvas.TextOut(x,y,m_tooltip_lines[i],::ColorToARGB(m_text_color,a),TA_LEFT|TA_TOP);
         y=y+y_offset;
        }
      //--- Обновить холст
      m_canvas.Update();
     }
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CTooltip::Moving(const int x,const int y)
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
void CTooltip::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CTooltip::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   m_canvas.Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CTooltip::Reset(void)
  {
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CTooltip::Delete(void)
  {
//--- Удаление объектов
   m_canvas.Delete();
//--- Освобождение массивов элемента
   ::ArrayFree(m_tooltip_lines);
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
  }
//+------------------------------------------------------------------+
