//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//--- Перечисление функций
enum ENUM_FORMULA
  {
   FORMULA_1=0, // Formula 1
   FORMULA_2=1, // Formula 2
   FORMULA_3=2  // Formula 3
  };
//--- Внешние параметры
input ENUM_FORMULA Formula        =FORMULA_1;       // Formula
input color        ColorSeries_01 =clrRed;          // Color series 01
input color        ColorSeries_02 =clrDodgerBlue;   // Color series 02
input color        ColorSeries_03 =clrWhite;        // Color series 03
input color        ColorSeries_04 =clrYellow;       // Color series 04
input color        ColorSeries_05 =clrMediumPurple; // Color series 05
input color        ColorSeries_06 =clrMagenta;      // Color series 06
//+------------------------------------------------------------------+
//| Класс для создания приложения                                    |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- Форма
   CWindow           m_window1;
   //--- Статусная строка
   CStatusBar        m_status_bar;
   //--- Элементы управления
   CSpinEdit         m_delay_ms;
   CComboBox         m_series_total;
   CCheckBoxEdit     m_increment_ratio;
   CSpinEdit         m_offset_series;
   CSpinEdit         m_min_limit_size;
   CCheckBoxEdit     m_max_limit_size;
   CCheckBoxEdit     m_run_speed;
   CSpinEdit         m_series_size;
   CLineGraph        m_line_chart;
   //--- Индикатор выполнения
   CProgressBar      m_progress_bar;
   
   //--- Структура серий на графике
   struct Series
     {
      double            data[];      // массив отображаемых данных
      double            data_temp[]; // вспомогательный массив для расчётов
     };
   Series            m_series[];

   //--- (1) Названия и (2) цвета серий
   string            m_series_name[];
   color             m_series_color[];
   //--- Счётчик скорости "бегущей" серии
   double            m_run_speed_counter;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Инициализация/деинициализация
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Таймер
   void              OnTimerEvent(void);
   //---
public:
   //--- Создаёт экспертную панель
   bool              CreateExpertPanel(void);
   //---
private:
   //--- Форма
   bool              CreateWindow(const string text);
   //--- Статусная строка
#define STATUSBAR1_GAP_X      (1)
#define STATUSBAR1_GAP_Y      (359)
   bool              CreateStatusBar(void);
   //--- Элементы для управления линейным графиком
#define SPINEDIT1_GAP_X       (7)
#define SPINEDIT1_GAP_Y       (25)
   bool              CreateSpinEditDelay(const string text);
#define COMBOBOX1_GAP_X       (7)
#define COMBOBOX1_GAP_Y       (50)
   bool              CreateComboBoxSeriesTotal(const string text);
#define CHECKBOX_EDIT1_GAP_X  (161)
#define CHECKBOX_EDIT1_GAP_Y  (25)
   bool              CreateCheckBoxEditIncrementRatio(const string text);
#define SPINEDIT2_GAP_X       (161)
#define SPINEDIT2_GAP_Y       (50)
   bool              CreateSpinEditOffsetSeries(const string text);
#define SPINEDIT3_GAP_X       (330)
#define SPINEDIT3_GAP_Y       (25)
   bool              CreateSpinEditMinLimitSize(const string text);
#define CHECKBOX_EDIT2_GAP_X  (330)
#define CHECKBOX_EDIT2_GAP_Y  (50)
   bool              CreateCheckBoxEditMaxLimitSize(const string text);
#define CHECKBOX_EDIT3_GAP_X  (501)
#define CHECKBOX_EDIT3_GAP_Y  (25)
   bool              CreateCheckBoxEditRunSpeed(const string text);
#define SPINEDIT4_GAP_X       (501)
#define SPINEDIT4_GAP_Y       (50)
   bool              CreateSpinEditSeriesSize(const string text);
   //--- Линейный график
#define LINECHART1_GAP_X      (5)
#define LINECHART1_GAP_Y      (75)
   bool              CreateLineChart(void);
   //--- Индикатор выполнения
#define PROGRESSBAR1_GAP_X    (5)
#define PROGRESSBAR1_GAP_Y    (364)
   bool              CreateProgressBar(void);
   //---
private:
   //--- Установить новый размер сериям
   void              ResizeDataArrays(void);
   //--- Инициализация вспомогательных массивов для расчётов
   void              InitArrays(void);
   //--- Рассчитать серии
   void              CalculateSeries(void);
   //--- Добавить серии на график
   void              AddSeries(void);
   //--- Обновить серии на графике
   void              UpdateSeries(void);
   //--- Перерасчёт серий на графике
   void              RecalculatingSeries(void);

   //--- Обновление линейного графика по таймеру
   void              UpdateLineChartByTimer(void);

   //--- Смещение серий линейного графика ("бегущий" график)
   void              ShiftLineChartSeries(void);
   //--- Авто-изменение размера серий линейного графика
   void              AutoResizeLineChartSeries(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void) : m_run_speed_counter(0.0)
  {
//--- Установка размера массивам серий
   int number_of_series=24;
   ::ArrayResize(m_series,number_of_series);
   ::ArrayResize(m_series_name,number_of_series);
   ::ArrayResize(m_series_color,number_of_series);
//--- Инициализация массива названий серий
   for(int i=0; i<number_of_series; i++)
      m_series_name[i]="Series "+string(i+1);
//--- Инициализация массивов цвета серий
   m_series_color[0] =m_series_color[6]  =m_series_color[12] =m_series_color[18] =ColorSeries_01;
   m_series_color[1] =m_series_color[7]  =m_series_color[13] =m_series_color[19] =ColorSeries_02;
   m_series_color[2] =m_series_color[8]  =m_series_color[14] =m_series_color[20] =ColorSeries_03;
   m_series_color[3] =m_series_color[9]  =m_series_color[15] =m_series_color[21] =ColorSeries_04;
   m_series_color[4] =m_series_color[10] =m_series_color[16] =m_series_color[22] =ColorSeries_05;
   m_series_color[5] =m_series_color[11] =m_series_color[17] =m_series_color[23] =ColorSeries_06;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CProgram::~CProgram(void)
  {
  }
//+------------------------------------------------------------------+
//| Инициализация                                                    |
//+------------------------------------------------------------------+
void CProgram::OnInitEvent(void)
  {
  }
//+------------------------------------------------------------------+
//| Деинициализация                                                  |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
  {
//--- Удаление интерфейса
   CWndEvents::Destroy();
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
  {
   CWndEvents::OnTimerEvent();

//--- Обновление линейного графика по таймеру
   UpdateLineChartByTimer();

//--- Обновление второго пункта статусной строки будет каждые 500 миллисекунд
   static int count=0;
   if(count<500)
     {
      count+=TIMER_STEP_MSC;
      return;
     }
//--- Обнулить счётчик
   count=0;
//--- Изменить значение во втором пункте статусной строки
   m_status_bar.ValueToItem(1,::TimeToString(::TimeLocal(),TIME_DATE|TIME_SECONDS));
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Событие разворачивания окна
   if(id==CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
     {
      //--- Показать индикатор выполнения
      if(m_max_limit_size.CheckButtonState())
         m_progress_bar.Show();
      //---
      return;
     }
//--- Событие выбора пункта в комбо-боксе
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      //--- Получим новое количество серий
      m_line_chart.MaxData((int)m_series_total.ButtonText());
      //--- (1) Установим размер массивам и (2) инициализируем их
      ResizeDataArrays();
      InitArrays();
      //--- (1) Рассчитаем, (2) добавим на график и (3) обновим серии
      CalculateSeries();
      AddSeries();
      UpdateSeries();
      return;
     }
//--- Событие нажатия на текстовой метке элемента
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      //--- Если это сообщение от элемента 'Size of series'
      if(sparam==m_series_size.LabelText())
        {
         //--- Перерасчёт серий на графике
         RecalculatingSeries();
         return;
        }
      //--- Если это сообщение от элемента 'Max. Limit Size'
      if(sparam==m_max_limit_size.LabelText())
        {
         //--- Показать или скрыть индикатор выполнения в зависимости от состояния чек-бокса элемента 'Max. limit size'
         if(m_max_limit_size.CheckButtonState())
            m_progress_bar.Show();
         else
            m_progress_bar.Hide();
         //---
         return;
        }
     }
//--- Событие ввода нового значения в поле ввода
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      //--- Если это сообщение от элемента 'Increment ratio' или 'Offset series' или 'Size of series'
      if(sparam==m_increment_ratio.LabelText() ||
         sparam==m_offset_series.LabelText() ||
         sparam==m_series_size.LabelText())
        {
         //--- Перерасчёт серий на графике
         RecalculatingSeries();
         return;
        }
      return;
     }
//--- События нажатия на кнопках-переключателях поля ввода
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC || id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      //--- Если это сообщение от элемента 'Increment ratio' или 'Offset series' или 'Size of series'
      if(sparam==m_increment_ratio.LabelText() ||
         sparam==m_offset_series.LabelText() ||
         sparam==m_series_size.LabelText())
        {
         //--- Перерасчёт серий на графике
         RecalculatingSeries();
         return;
        }
      return;
     }
  }
//+------------------------------------------------------------------+
//| Создаёт экспертную панель                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(void)
  {
//--- Создание формы 1 для элементов управления
   if(!CreateWindow("EXPERT PANEL"))
      return(false);
//--- Создание элементов управления:
//    Статусная строка
   if(!CreateStatusBar())
      return(false);
//--- Элементы управления линейным графиком
   if(!CreateSpinEditDelay("Delay (ms):"))
      return(false);
   if(!CreateComboBoxSeriesTotal("Number of series:"))
      return(false);
   if(!CreateCheckBoxEditIncrementRatio("Increment ratio:"))
      return(false);
   if(!CreateSpinEditOffsetSeries("Offset series:"))
      return(false);
   if(!CreateSpinEditMinLimitSize("Min. limit size:"))
      return(false);
   if(!CreateCheckBoxEditMaxLimitSize("Max. limit size:"))
      return(false);
   if(!CreateCheckBoxEditRunSpeed("Run speed:"))
      return(false);
   if(!CreateSpinEditSeriesSize("Size of series:"))
      return(false);
//--- Линейный график
   if(!CreateLineChart())
      return(false);
//--- Индикатор выполнения
   if(!CreateProgressBar())
      return(false);
//--- Перерисовка графика
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт форму для элементов управления                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
//---
bool CProgram::CreateWindow(const string caption_text)
  {
//--- Добавим указатель окна в массив окон
   CWndContainer::AddWindow(m_window1);
//--- Координаты
   int x=(m_window1.X()>0) ? m_window1.X() : 29;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 30;
//--- Свойства
   m_window1.Movable(true);
   m_window1.XSize(640);
   m_window1.YSize(384);
   m_window1.WindowBgColor(clrWhiteSmoke);
   m_window1.WindowBorderColor(clrLightSteelBlue);
   m_window1.CaptionBgColor(clrLightSteelBlue);
   m_window1.CaptionBgColorHover(clrLightSteelBlue);
   m_window1.IconFile("Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp");
//--- Создание формы
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт статусную строку                                         |
//+------------------------------------------------------------------+
bool CProgram::CreateStatusBar(void)
  {
#define STATUS_LABELS_TOTAL 2
//--- Сохраним указатель на окно
   m_status_bar.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+STATUSBAR1_GAP_X;
   int y=m_window1.Y()+STATUSBAR1_GAP_Y;
//--- Ширина
   int width[]={0,110};
//--- Установим свойства перед созданием
   m_status_bar.YSize(24);
   m_status_bar.AreaColor(C'225,225,225');
   m_status_bar.AreaBorderColor(C'225,225,225');
//--- Укажем сколько должно быть частей и установим им свойства
   for(int i=0; i<STATUS_LABELS_TOTAL; i++)
      m_status_bar.AddItem(width[i]);
//--- Создадим элемент управления
   if(!m_status_bar.CreateStatusBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Установка текста в первый пункт статусной строки
   m_status_bar.ValueToItem(0,"For Help, press F1");
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода "Delay"                                       |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditDelay(string text)
  {
//--- Сохраним указатель на окно
   m_delay_ms.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+SPINEDIT1_GAP_X;
   int y=m_window1.Y()+SPINEDIT1_GAP_Y;
//--- Значение
   double v=(m_delay_ms.GetValue()<0) ? 16 : m_delay_ms.GetValue();
//--- Установим свойства перед созданием
   m_delay_ms.XSize(144);
   m_delay_ms.YSize(18);
   m_delay_ms.EditXSize(40);
   m_delay_ms.MaxValue(1000);
   m_delay_ms.MinValue(1);
   m_delay_ms.StepValue(1);
   m_delay_ms.SetDigits(0);
   m_delay_ms.SetValue(v);
   m_delay_ms.ResetMode(true);
   m_delay_ms.AreaColor(clrWhiteSmoke);
   m_delay_ms.LabelColor(clrBlack);
   m_delay_ms.EditBorderColor(clrSilver);
//--- Создадим элемент управления
   if(!m_delay_ms.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_delay_ms);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт комбо-бокс "Series Total"                                |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBoxSeriesTotal(const string text)
  {
#define ROWS1_TOTAL 24
//--- Сохраним указатель на окно
   m_series_total.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+COMBOBOX1_GAP_X;
   int y=m_window1.Y()+COMBOBOX1_GAP_Y;
//--- Установим свойства перед созданием
   m_series_total.XSize(140);
   m_series_total.YSize(18);
   m_series_total.LabelText(text);
   m_series_total.ButtonXSize(51);
   m_series_total.AreaColor(clrWhiteSmoke);
   m_series_total.LabelColor(clrBlack);
   m_series_total.ButtonBackColor(C'220,220,220');
   m_series_total.ButtonBackColorHover(C'193,218,255');
   m_series_total.ButtonBorderColor(clrSilver);
   m_series_total.ItemsTotal(ROWS1_TOTAL);
   m_series_total.VisibleItemsTotal(5);
//--- Заполним список комбо-бокса
   for(int i=0; i<ROWS1_TOTAL; i++)
      m_series_total.ValueToList(i,string(i+1));
//--- Получим указатель списка
   CListView *lv=m_series_total.GetListViewPointer();
//--- Установим свойства списка
   lv.LightsHover(true);
//--- Создадим элемент управления
   if(!m_series_total.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- Выберем пункт в списке комбо-бокса
   m_series_total.SelectedItemByIndex(5);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_series_total);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт чекбокс с полем ввода "Increment Ratio"                  |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditIncrementRatio(string text)
  {
//--- Сохраним указатель на окно
   m_increment_ratio.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+CHECKBOX_EDIT1_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT1_GAP_Y;
//--- Значение
   double v=(m_increment_ratio.GetValue()<0) ? 35 : m_increment_ratio.GetValue();
//--- Установим свойства перед созданием
   m_increment_ratio.XSize(160);
   m_increment_ratio.YSize(18);
   m_increment_ratio.EditXSize(40);
   m_increment_ratio.MaxValue(100);
   m_increment_ratio.MinValue(1);
   m_increment_ratio.StepValue(1);
   m_increment_ratio.SetDigits(0);
   m_increment_ratio.SetValue(v);
   m_increment_ratio.AreaColor(clrWhiteSmoke);
   m_increment_ratio.LabelColor(clrBlack);
   m_increment_ratio.LabelColorOff(clrBlack);
   m_increment_ratio.EditBorderColor(clrSilver);
   m_increment_ratio.CheckButtonState(false);
//--- Создадим элемент управления
   if(!m_increment_ratio.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_increment_ratio);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода "Offset Series"                               |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditOffsetSeries(string text)
  {
//--- Сохраним указатель на окно
   m_offset_series.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+SPINEDIT2_GAP_X;
   int y=m_window1.Y()+SPINEDIT2_GAP_Y;
//--- Значение
   double v=(m_offset_series.GetValue()<0) ? 1.00 : m_offset_series.GetValue();
//--- Установим свойства перед созданием
   m_offset_series.XSize(160);
   m_offset_series.YSize(18);
   m_offset_series.EditXSize(40);
   m_offset_series.MaxValue(1);
   m_offset_series.MinValue(0.01);
   m_offset_series.StepValue(0.01);
   m_offset_series.SetDigits(2);
   m_offset_series.SetValue(v);
   m_offset_series.AreaColor(clrWhiteSmoke);
   m_offset_series.LabelColor(clrBlack);
   m_offset_series.EditBorderColor(clrSilver);
   m_offset_series.ResetMode(true);
//--- Создадим элемент управления
   if(!m_offset_series.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_offset_series);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода "Min. Limit Size"                             |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditMinLimitSize(string text)
  {
//--- Сохраним указатель на окно
   m_min_limit_size.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+SPINEDIT3_GAP_X;
   int y=m_window1.Y()+SPINEDIT3_GAP_Y;
//--- Значение
   double v=(m_min_limit_size.GetValue()<0) ? 2 : m_min_limit_size.GetValue();
//--- Установим свойства перед созданием
   m_min_limit_size.XSize(162);
   m_min_limit_size.YSize(18);
   m_min_limit_size.EditXSize(40);
   m_min_limit_size.MaxValue(100);
   m_min_limit_size.MinValue(2);
   m_min_limit_size.StepValue(1);
   m_min_limit_size.SetDigits(0);
   m_min_limit_size.SetValue(v);
   m_min_limit_size.AreaColor(clrWhiteSmoke);
   m_min_limit_size.LabelColor(clrBlack);
   m_min_limit_size.EditBorderColor(clrSilver);
   m_min_limit_size.ResetMode(true);
//--- Создадим элемент управления
   if(!m_min_limit_size.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_min_limit_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт чекбокс с полем ввода "Max. Limit Size"                  |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditMaxLimitSize(string text)
  {
//--- Сохраним указатель на окно
   m_max_limit_size.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+CHECKBOX_EDIT2_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT2_GAP_Y;
//--- Значение
   double v=(m_max_limit_size.GetValue()<0) ? 50 : m_max_limit_size.GetValue();
//--- Установим свойства перед созданием
   m_max_limit_size.XSize(162);
   m_max_limit_size.YSize(18);
   m_max_limit_size.EditXSize(40);
   m_max_limit_size.MaxValue(10000);
   m_max_limit_size.MinValue(50);
   m_max_limit_size.StepValue(1);
   m_max_limit_size.SetDigits(0);
   m_max_limit_size.SetValue(v);
   m_max_limit_size.AreaColor(clrWhiteSmoke);
   m_max_limit_size.LabelColor(clrBlack);
   m_max_limit_size.LabelColorOff(clrBlack);
   m_max_limit_size.EditBorderColor(clrSilver);
   m_max_limit_size.CheckButtonState(false);
//--- Создадим элемент управления
   if(!m_max_limit_size.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_max_limit_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт чекбокс с полем ввода "Run Speed"                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditRunSpeed(string text)
  {
//--- Сохраним указатель на окно
   m_run_speed.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+CHECKBOX_EDIT3_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT3_GAP_Y;
//--- Значение
   double v=(m_run_speed.GetValue()<0) ? 0.05 : m_run_speed.GetValue();
//--- Установим свойства перед созданием
   m_run_speed.XSize(134);
   m_run_speed.YSize(18);
   m_run_speed.EditXSize(40);
   m_run_speed.MaxValue(1);
   m_run_speed.MinValue(0.01);
   m_run_speed.StepValue(0.01);
   m_run_speed.SetDigits(2);
   m_run_speed.SetValue(v);
   m_run_speed.AreaColor(clrWhiteSmoke);
   m_run_speed.LabelColor(clrBlack);
   m_run_speed.LabelColorOff(clrBlack);
   m_run_speed.EditBorderColor(clrSilver);
   m_run_speed.CheckButtonState(false);
//--- Создадим элемент управления
   if(!m_run_speed.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_run_speed);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода "Series Size"                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditSeriesSize(string text)
  {
//--- Сохраним указатель на окно
   m_series_size.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+SPINEDIT4_GAP_X;
   int y=m_window1.Y()+SPINEDIT4_GAP_Y;
//--- Значение
   double v=(m_series_size.GetValue()<0) ? 2 : m_series_size.GetValue();
//--- Установим свойства перед созданием
   m_series_size.XSize(134);
   m_series_size.YSize(18);
   m_series_size.EditXSize(40);
   m_series_size.MaxValue(m_max_limit_size.MaxValue());
   m_series_size.MinValue(m_min_limit_size.MinValue());
   m_series_size.StepValue(1);
   m_series_size.SetDigits(0);
   m_series_size.SetValue(v);
   m_series_size.AreaColor(clrWhiteSmoke);
   m_series_size.LabelColor(clrBlack);
   m_series_size.EditBorderColor(clrSilver);
   m_series_size.ResetMode(true);
//--- Создадим элемент управления
   if(!m_series_size.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_series_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт линейный график                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateLineChart(void)
  {
//--- Сохраним указатель на окно
   m_line_chart.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+LINECHART1_GAP_X;
   int y=m_window1.Y()+LINECHART1_GAP_Y;
//--- Установим свойства перед созданием
   m_line_chart.XSize(630);
   m_line_chart.YSize(280);
   m_line_chart.BorderColor(clrSilver);
   m_line_chart.VScaleParams(2,-2,4);
   m_line_chart.MaxData(int(m_series_total.ButtonText()));
//--- Создадим элемент управления
   if(!m_line_chart.CreateLineGraph(m_chart_id,m_subwin,x,y))
      return(false);
//--- (1) Установим размер массивам и (2) инициализируем их
   ResizeDataArrays();
   InitArrays();
//--- (1) Рассчитаем и (2) добавим серии на график
   CalculateSeries();
   AddSeries();
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_line_chart);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт прогресс бар                                             |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar(void)
  {
//--- Сохраним указатель на форму
   m_progress_bar.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+PROGRESSBAR1_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR1_GAP_Y;
//--- Установим свойства перед созданием
   m_progress_bar.XSize(510);
   m_progress_bar.YSize(15);
   m_progress_bar.BarXSize(420);
   m_progress_bar.BarYSize(11);
   m_progress_bar.BarXOffset(65);
   m_progress_bar.BarYOffset(2);
   m_progress_bar.BarBorderWidth(2);
   m_progress_bar.LabelText("Processing:");
   m_progress_bar.AreaColor(C'225,225,225');
   m_progress_bar.BarAreaColor(clrWhiteSmoke);
   m_progress_bar.BarBorderColor(clrWhiteSmoke);
   m_progress_bar.IsDropdown(true);
//--- Создание элемента
   if(!m_progress_bar.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Скрыть элемент
   m_progress_bar.Hide();
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_progress_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Обновление по таймеру                                            |
//+------------------------------------------------------------------+
void CProgram::UpdateLineChartByTimer(void)
  {
//--- Выйти, если форма свёрнута или в процессе перемещения
   if(m_window1.IsMinimized())
      return;
//--- Выйти, если отключена анимация
   if(!m_max_limit_size.CheckButtonState() && !m_run_speed.CheckButtonState())
      return;
//--- Задержка
   static int count=0;
   if(count<m_delay_ms.GetValue())
     {
      count+=TIMER_STEP_MSC;
      return;
     }
   count=0;
//--- Если включена опция "Бегущие серии", то будем смещать первое значение серий
   ShiftLineChartSeries();
//--- Если включено управление размером массивов серий по таймеру
   AutoResizeLineChartSeries();
//--- Инициализируем массивы
   InitArrays();
//--- (1) Рассчитаем и (2) обновим серии
   CalculateSeries();
   UpdateSeries();
  }
//+------------------------------------------------------------------+
//| Установим новый размер массивам                                  |
//+------------------------------------------------------------------+
void CProgram::ResizeDataArrays(void)
  {
   int total          =(int)m_series_total.ButtonText();
   int size_of_series =(int)m_series_size.GetValue();
//---
   for(int s=0; s<total; s++)
     {
      //--- Установим новый размер массивам
      ::ArrayResize(m_series[s].data,size_of_series);
      ::ArrayResize(m_series[s].data_temp,size_of_series);
     }
  }
//+------------------------------------------------------------------+
//| Инициализация вспомогательных массивов для расчётов              |
//+------------------------------------------------------------------+
void CProgram::InitArrays(void)
  {
   int total=(int)m_series_total.ButtonText();
//---
   for(int s=0; s<total; s++)
     {
      int size_of_series=::ArraySize(m_series[s].data_temp);
      //---
      for(int i=0; i<size_of_series; i++)
        {
         if(i==0)
           {
            if(s>0)
               m_series[s].data_temp[i]=m_series[s-1].data_temp[i]+m_offset_series.GetValue();
            else
               m_series[s].data_temp[i]=m_run_speed_counter;
           }
         else
            m_series[s].data_temp[i]=m_series[s].data_temp[i-1]+(int)m_increment_ratio.GetValue();
        }
     }
  }
//+------------------------------------------------------------------+
//| Рассчитывает серии                                               |
//+------------------------------------------------------------------+
void CProgram::CalculateSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
//---
   for(int s=0; s<total; s++)
     {
      int size_of_series=::ArraySize(m_series[s].data_temp);
      //---
      for(int i=0; i<size_of_series; i++)
        {
         m_series[s].data_temp[i]+=m_offset_series.GetValue();
         //---
         switch(Formula)
           {
            case FORMULA_1 :
               m_series[s].data[i]=::sin(m_series[s].data_temp[i])-::cos(m_series[s].data_temp[i]);
               break;
            case FORMULA_2 :
               m_series[s].data[i]=::sin(m_series[s].data_temp[i]-::cos(m_series[s].data_temp[i]));
               break;
            case FORMULA_3 :
               m_series[s].data[i]=::sin(m_series[s].data_temp[i]*10)-::cos(m_series[s].data_temp[i]);
               break;
           }

        }
     }
  }
//+------------------------------------------------------------------+
//| Рассчитывает и устанавливает серии на диаграмму                  |
//+------------------------------------------------------------------+
void CProgram::AddSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
   for(int s=0; s<total; s++)
      m_line_chart.SeriesAdd(m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| Рассчитывает и обновляет серии на диаграмме                      |
//+------------------------------------------------------------------+
void CProgram::UpdateSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
   for(int s=0; s<total; s++)
      m_line_chart.SeriesUpdate(s,m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| Перерасчёт серий на графике                                      |
//+------------------------------------------------------------------+
void CProgram::RecalculatingSeries(void)
  {
//--- (1) Установим размер массивам и (2) инициализируем их
   ResizeDataArrays();
   InitArrays();
//--- (1) Рассчитаем и (2) обновим серии
   CalculateSeries();
   UpdateSeries();
  }
//+------------------------------------------------------------------+
//| Смещение серий линейного графика                                 |
//+------------------------------------------------------------------+
void CProgram::ShiftLineChartSeries(void)
  {
   if(m_run_speed.CheckButtonState())
      m_run_speed_counter+=m_run_speed.GetValue();
  }
//+------------------------------------------------------------------+
//| Авто-изменение размера серий линейного графика                   |
//+------------------------------------------------------------------+
void CProgram::AutoResizeLineChartSeries(void)
  {
//--- Выйти, если отключено увеличение массива серий по таймеру
   if(!m_max_limit_size.CheckButtonState())
      return;
//--- Для указания направления изменения размера массивов
   static bool resize_direction=false;
//--- Если дошли до минимума размера массива
   if((int)m_series_size.GetValue()<=m_min_limit_size.GetValue())
     {
      //--- Переключим направление на увеличение массива
      resize_direction=false;
      //--- Если нужно изменять значение X
      if(m_increment_ratio.CheckButtonState())
        {
         //--- Для указания направления счётчика коэффициента приращения
         static bool increment_ratio_direction=true;
         //--- Если счётчик направлен на увеличение
         if(increment_ratio_direction)
           {
            //--- Если дошли до максимального ограничения, изменим направление счётчика на противоположное
            if(m_increment_ratio.GetValue()>=m_increment_ratio.MaxValue()-1)
               increment_ratio_direction=false;
           }
         //--- Если счётчик направлен на уменьшение
         else
           {
            //--- Если дошли до минимального ограничения, изменим направление счётчика на противоположное
            if(m_increment_ratio.GetValue()<=m_increment_ratio.MinValue()+1)
               increment_ratio_direction=true;
           }
         //--- Получим текущее значение параметра "Increment ratio" и изменим его по указанному направлению
         int increase_value=(int)m_increment_ratio.GetValue();
         m_increment_ratio.ChangeValue((increment_ratio_direction)? ++increase_value : --increase_value);
        }
     }
//--- Переключим направление на уменьшение массива если дошли до максимума
   if((int)m_series_size.GetValue()>=m_max_limit_size.GetValue())
      resize_direction=true;

//--- Если индикатор выполнения включен, отобразим процесс
   if(m_progress_bar.IsVisible())
     {
      if(!resize_direction)
         m_progress_bar.Update((int)m_series_size.GetValue(),(int)m_max_limit_size.GetValue());
      else
         m_progress_bar.Update(int(m_max_limit_size.GetValue()-m_series_size.GetValue()),(int)m_max_limit_size.GetValue());
     }
//--- Изменяем размер массива по направлению
   int size_of_series=(int)m_series_size.GetValue();
   m_series_size.ChangeValue((!resize_direction)? ++size_of_series : --size_of_series);
//--- Установим новый размер массивам
   ResizeDataArrays();
  }
//+------------------------------------------------------------------+
