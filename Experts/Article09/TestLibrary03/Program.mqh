//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//--- ������������ �������
enum ENUM_FORMULA
  {
   FORMULA_1=0, // Formula 1
   FORMULA_2=1, // Formula 2
   FORMULA_3=2  // Formula 3
  };
//--- ������� ���������
input ENUM_FORMULA Formula        =FORMULA_1;       // Formula
input color        ColorSeries_01 =clrRed;          // Color series 01
input color        ColorSeries_02 =clrDodgerBlue;   // Color series 02
input color        ColorSeries_03 =clrWhite;        // Color series 03
input color        ColorSeries_04 =clrYellow;       // Color series 04
input color        ColorSeries_05 =clrMediumPurple; // Color series 05
input color        ColorSeries_06 =clrMagenta;      // Color series 06
//+------------------------------------------------------------------+
//| ����� ��� �������� ����������                                    |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- �����
   CWindow           m_window1;
   //--- ��������� ������
   CStatusBar        m_status_bar;
   //--- �������� ����������
   CSpinEdit         m_delay_ms;
   CComboBox         m_series_total;
   CCheckBoxEdit     m_increment_ratio;
   CSpinEdit         m_offset_series;
   CSpinEdit         m_min_limit_size;
   CCheckBoxEdit     m_max_limit_size;
   CCheckBoxEdit     m_run_speed;
   CSpinEdit         m_series_size;
   CLineGraph        m_line_chart;
   //--- ��������� ����������
   CProgressBar      m_progress_bar;
   
   //--- ��������� ����� �� �������
   struct Series
     {
      double            data[];      // ������ ������������ ������
      double            data_temp[]; // ��������������� ������ ��� ��������
     };
   Series            m_series[];

   //--- (1) �������� � (2) ����� �����
   string            m_series_name[];
   color             m_series_color[];
   //--- ������� �������� "�������" �����
   double            m_run_speed_counter;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- �������������/���������������
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- ������
   void              OnTimerEvent(void);
   //---
public:
   //--- ������ ���������� ������
   bool              CreateExpertPanel(void);
   //---
private:
   //--- �����
   bool              CreateWindow(const string text);
   //--- ��������� ������
#define STATUSBAR1_GAP_X      (1)
#define STATUSBAR1_GAP_Y      (359)
   bool              CreateStatusBar(void);
   //--- �������� ��� ���������� �������� ��������
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
   //--- �������� ������
#define LINECHART1_GAP_X      (5)
#define LINECHART1_GAP_Y      (75)
   bool              CreateLineChart(void);
   //--- ��������� ����������
#define PROGRESSBAR1_GAP_X    (5)
#define PROGRESSBAR1_GAP_Y    (364)
   bool              CreateProgressBar(void);
   //---
private:
   //--- ���������� ����� ������ ������
   void              ResizeDataArrays(void);
   //--- ������������� ��������������� �������� ��� ��������
   void              InitArrays(void);
   //--- ���������� �����
   void              CalculateSeries(void);
   //--- �������� ����� �� ������
   void              AddSeries(void);
   //--- �������� ����� �� �������
   void              UpdateSeries(void);
   //--- ���������� ����� �� �������
   void              RecalculatingSeries(void);

   //--- ���������� ��������� ������� �� �������
   void              UpdateLineChartByTimer(void);

   //--- �������� ����� ��������� ������� ("�������" ������)
   void              ShiftLineChartSeries(void);
   //--- ����-��������� ������� ����� ��������� �������
   void              AutoResizeLineChartSeries(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void) : m_run_speed_counter(0.0)
  {
//--- ��������� ������� �������� �����
   int number_of_series=24;
   ::ArrayResize(m_series,number_of_series);
   ::ArrayResize(m_series_name,number_of_series);
   ::ArrayResize(m_series_color,number_of_series);
//--- ������������� ������� �������� �����
   for(int i=0; i<number_of_series; i++)
      m_series_name[i]="Series "+string(i+1);
//--- ������������� �������� ����� �����
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
//| �������������                                                    |
//+------------------------------------------------------------------+
void CProgram::OnInitEvent(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������������                                                  |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
  {
//--- �������� ����������
   CWndEvents::Destroy();
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
  {
   CWndEvents::OnTimerEvent();

//--- ���������� ��������� ������� �� �������
   UpdateLineChartByTimer();

//--- ���������� ������� ������ ��������� ������ ����� ������ 500 �����������
   static int count=0;
   if(count<500)
     {
      count+=TIMER_STEP_MSC;
      return;
     }
//--- �������� �������
   count=0;
//--- �������� �������� �� ������ ������ ��������� ������
   m_status_bar.ValueToItem(1,::TimeToString(::TimeLocal(),TIME_DATE|TIME_SECONDS));
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ������� �������������� ����
   if(id==CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
     {
      //--- �������� ��������� ����������
      if(m_max_limit_size.CheckButtonState())
         m_progress_bar.Show();
      //---
      return;
     }
//--- ������� ������ ������ � �����-�����
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      //--- ������� ����� ���������� �����
      m_line_chart.MaxData((int)m_series_total.ButtonText());
      //--- (1) ��������� ������ �������� � (2) �������������� ��
      ResizeDataArrays();
      InitArrays();
      //--- (1) ����������, (2) ������� �� ������ � (3) ������� �����
      CalculateSeries();
      AddSeries();
      UpdateSeries();
      return;
     }
//--- ������� ������� �� ��������� ����� ��������
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      //--- ���� ��� ��������� �� �������� 'Size of series'
      if(sparam==m_series_size.LabelText())
        {
         //--- ���������� ����� �� �������
         RecalculatingSeries();
         return;
        }
      //--- ���� ��� ��������� �� �������� 'Max. Limit Size'
      if(sparam==m_max_limit_size.LabelText())
        {
         //--- �������� ��� ������ ��������� ���������� � ����������� �� ��������� ���-����� �������� 'Max. limit size'
         if(m_max_limit_size.CheckButtonState())
            m_progress_bar.Show();
         else
            m_progress_bar.Hide();
         //---
         return;
        }
     }
//--- ������� ����� ������ �������� � ���� �����
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      //--- ���� ��� ��������� �� �������� 'Increment ratio' ��� 'Offset series' ��� 'Size of series'
      if(sparam==m_increment_ratio.LabelText() ||
         sparam==m_offset_series.LabelText() ||
         sparam==m_series_size.LabelText())
        {
         //--- ���������� ����� �� �������
         RecalculatingSeries();
         return;
        }
      return;
     }
//--- ������� ������� �� �������-�������������� ���� �����
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC || id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      //--- ���� ��� ��������� �� �������� 'Increment ratio' ��� 'Offset series' ��� 'Size of series'
      if(sparam==m_increment_ratio.LabelText() ||
         sparam==m_offset_series.LabelText() ||
         sparam==m_series_size.LabelText())
        {
         //--- ���������� ����� �� �������
         RecalculatingSeries();
         return;
        }
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������ ���������� ������                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(void)
  {
//--- �������� ����� 1 ��� ��������� ����������
   if(!CreateWindow("EXPERT PANEL"))
      return(false);
//--- �������� ��������� ����������:
//    ��������� ������
   if(!CreateStatusBar())
      return(false);
//--- �������� ���������� �������� ��������
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
//--- �������� ������
   if(!CreateLineChart())
      return(false);
//--- ��������� ����������
   if(!CreateProgressBar())
      return(false);
//--- ����������� �������
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� ��������� ����������                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
//---
bool CProgram::CreateWindow(const string caption_text)
  {
//--- ������� ��������� ���� � ������ ����
   CWndContainer::AddWindow(m_window1);
//--- ����������
   int x=(m_window1.X()>0) ? m_window1.X() : 29;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 30;
//--- ��������
   m_window1.Movable(true);
   m_window1.XSize(640);
   m_window1.YSize(384);
   m_window1.WindowBgColor(clrWhiteSmoke);
   m_window1.WindowBorderColor(clrLightSteelBlue);
   m_window1.CaptionBgColor(clrLightSteelBlue);
   m_window1.CaptionBgColorHover(clrLightSteelBlue);
   m_window1.IconFile("Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp");
//--- �������� �����
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ��������� ������                                         |
//+------------------------------------------------------------------+
bool CProgram::CreateStatusBar(void)
  {
#define STATUS_LABELS_TOTAL 2
//--- �������� ��������� �� ����
   m_status_bar.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+STATUSBAR1_GAP_X;
   int y=m_window1.Y()+STATUSBAR1_GAP_Y;
//--- ������
   int width[]={0,110};
//--- ��������� �������� ����� ���������
   m_status_bar.YSize(24);
   m_status_bar.AreaColor(C'225,225,225');
   m_status_bar.AreaBorderColor(C'225,225,225');
//--- ������ ������� ������ ���� ������ � ��������� �� ��������
   for(int i=0; i<STATUS_LABELS_TOTAL; i++)
      m_status_bar.AddItem(width[i]);
//--- �������� ������� ����������
   if(!m_status_bar.CreateStatusBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ��������� ������ � ������ ����� ��������� ������
   m_status_bar.ValueToItem(0,"For Help, press F1");
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� "Delay"                                       |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditDelay(string text)
  {
//--- �������� ��������� �� ����
   m_delay_ms.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+SPINEDIT1_GAP_X;
   int y=m_window1.Y()+SPINEDIT1_GAP_Y;
//--- ��������
   double v=(m_delay_ms.GetValue()<0) ? 16 : m_delay_ms.GetValue();
//--- ��������� �������� ����� ���������
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
//--- �������� ������� ����������
   if(!m_delay_ms.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_delay_ms);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �����-���� "Series Total"                                |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBoxSeriesTotal(const string text)
  {
#define ROWS1_TOTAL 24
//--- �������� ��������� �� ����
   m_series_total.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+COMBOBOX1_GAP_X;
   int y=m_window1.Y()+COMBOBOX1_GAP_Y;
//--- ��������� �������� ����� ���������
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
//--- �������� ������ �����-�����
   for(int i=0; i<ROWS1_TOTAL; i++)
      m_series_total.ValueToList(i,string(i+1));
//--- ������� ��������� ������
   CListView *lv=m_series_total.GetListViewPointer();
//--- ��������� �������� ������
   lv.LightsHover(true);
//--- �������� ������� ����������
   if(!m_series_total.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ����� � ������ �����-�����
   m_series_total.SelectedItemByIndex(5);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_series_total);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� � ����� ����� "Increment Ratio"                  |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditIncrementRatio(string text)
  {
//--- �������� ��������� �� ����
   m_increment_ratio.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+CHECKBOX_EDIT1_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT1_GAP_Y;
//--- ��������
   double v=(m_increment_ratio.GetValue()<0) ? 35 : m_increment_ratio.GetValue();
//--- ��������� �������� ����� ���������
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
//--- �������� ������� ����������
   if(!m_increment_ratio.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_increment_ratio);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� "Offset Series"                               |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditOffsetSeries(string text)
  {
//--- �������� ��������� �� ����
   m_offset_series.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+SPINEDIT2_GAP_X;
   int y=m_window1.Y()+SPINEDIT2_GAP_Y;
//--- ��������
   double v=(m_offset_series.GetValue()<0) ? 1.00 : m_offset_series.GetValue();
//--- ��������� �������� ����� ���������
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
//--- �������� ������� ����������
   if(!m_offset_series.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_offset_series);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� "Min. Limit Size"                             |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditMinLimitSize(string text)
  {
//--- �������� ��������� �� ����
   m_min_limit_size.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+SPINEDIT3_GAP_X;
   int y=m_window1.Y()+SPINEDIT3_GAP_Y;
//--- ��������
   double v=(m_min_limit_size.GetValue()<0) ? 2 : m_min_limit_size.GetValue();
//--- ��������� �������� ����� ���������
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
//--- �������� ������� ����������
   if(!m_min_limit_size.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_min_limit_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� � ����� ����� "Max. Limit Size"                  |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditMaxLimitSize(string text)
  {
//--- �������� ��������� �� ����
   m_max_limit_size.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+CHECKBOX_EDIT2_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT2_GAP_Y;
//--- ��������
   double v=(m_max_limit_size.GetValue()<0) ? 50 : m_max_limit_size.GetValue();
//--- ��������� �������� ����� ���������
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
//--- �������� ������� ����������
   if(!m_max_limit_size.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_max_limit_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� � ����� ����� "Run Speed"                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditRunSpeed(string text)
  {
//--- �������� ��������� �� ����
   m_run_speed.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+CHECKBOX_EDIT3_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT3_GAP_Y;
//--- ��������
   double v=(m_run_speed.GetValue()<0) ? 0.05 : m_run_speed.GetValue();
//--- ��������� �������� ����� ���������
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
//--- �������� ������� ����������
   if(!m_run_speed.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_run_speed);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� "Series Size"                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditSeriesSize(string text)
  {
//--- �������� ��������� �� ����
   m_series_size.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+SPINEDIT4_GAP_X;
   int y=m_window1.Y()+SPINEDIT4_GAP_Y;
//--- ��������
   double v=(m_series_size.GetValue()<0) ? 2 : m_series_size.GetValue();
//--- ��������� �������� ����� ���������
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
//--- �������� ������� ����������
   if(!m_series_size.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_series_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ������                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateLineChart(void)
  {
//--- �������� ��������� �� ����
   m_line_chart.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+LINECHART1_GAP_X;
   int y=m_window1.Y()+LINECHART1_GAP_Y;
//--- ��������� �������� ����� ���������
   m_line_chart.XSize(630);
   m_line_chart.YSize(280);
   m_line_chart.BorderColor(clrSilver);
   m_line_chart.VScaleParams(2,-2,4);
   m_line_chart.MaxData(int(m_series_total.ButtonText()));
//--- �������� ������� ����������
   if(!m_line_chart.CreateLineGraph(m_chart_id,m_subwin,x,y))
      return(false);
//--- (1) ��������� ������ �������� � (2) �������������� ��
   ResizeDataArrays();
   InitArrays();
//--- (1) ���������� � (2) ������� ����� �� ������
   CalculateSeries();
   AddSeries();
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_line_chart);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ���                                             |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar(void)
  {
//--- �������� ��������� �� �����
   m_progress_bar.WindowPointer(m_window1);
//--- ����������
   int x=m_window1.X()+PROGRESSBAR1_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR1_GAP_Y;
//--- ��������� �������� ����� ���������
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
//--- �������� ��������
   if(!m_progress_bar.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������ �������
   m_progress_bar.Hide();
//--- ������� ��������� �� ������� � ����
   CWndContainer::AddToElementsArray(0,m_progress_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| ���������� �� �������                                            |
//+------------------------------------------------------------------+
void CProgram::UpdateLineChartByTimer(void)
  {
//--- �����, ���� ����� ������� ��� � �������� �����������
   if(m_window1.IsMinimized())
      return;
//--- �����, ���� ��������� ��������
   if(!m_max_limit_size.CheckButtonState() && !m_run_speed.CheckButtonState())
      return;
//--- ��������
   static int count=0;
   if(count<m_delay_ms.GetValue())
     {
      count+=TIMER_STEP_MSC;
      return;
     }
   count=0;
//--- ���� �������� ����� "������� �����", �� ����� ������� ������ �������� �����
   ShiftLineChartSeries();
//--- ���� �������� ���������� �������� �������� ����� �� �������
   AutoResizeLineChartSeries();
//--- �������������� �������
   InitArrays();
//--- (1) ���������� � (2) ������� �����
   CalculateSeries();
   UpdateSeries();
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������ ��������                                  |
//+------------------------------------------------------------------+
void CProgram::ResizeDataArrays(void)
  {
   int total          =(int)m_series_total.ButtonText();
   int size_of_series =(int)m_series_size.GetValue();
//---
   for(int s=0; s<total; s++)
     {
      //--- ��������� ����� ������ ��������
      ::ArrayResize(m_series[s].data,size_of_series);
      ::ArrayResize(m_series[s].data_temp,size_of_series);
     }
  }
//+------------------------------------------------------------------+
//| ������������� ��������������� �������� ��� ��������              |
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
//| ������������ �����                                               |
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
//| ������������ � ������������� ����� �� ���������                  |
//+------------------------------------------------------------------+
void CProgram::AddSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
   for(int s=0; s<total; s++)
      m_line_chart.SeriesAdd(m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| ������������ � ��������� ����� �� ���������                      |
//+------------------------------------------------------------------+
void CProgram::UpdateSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
   for(int s=0; s<total; s++)
      m_line_chart.SeriesUpdate(s,m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| ���������� ����� �� �������                                      |
//+------------------------------------------------------------------+
void CProgram::RecalculatingSeries(void)
  {
//--- (1) ��������� ������ �������� � (2) �������������� ��
   ResizeDataArrays();
   InitArrays();
//--- (1) ���������� � (2) ������� �����
   CalculateSeries();
   UpdateSeries();
  }
//+------------------------------------------------------------------+
//| �������� ����� ��������� �������                                 |
//+------------------------------------------------------------------+
void CProgram::ShiftLineChartSeries(void)
  {
   if(m_run_speed.CheckButtonState())
      m_run_speed_counter+=m_run_speed.GetValue();
  }
//+------------------------------------------------------------------+
//| ����-��������� ������� ����� ��������� �������                   |
//+------------------------------------------------------------------+
void CProgram::AutoResizeLineChartSeries(void)
  {
//--- �����, ���� ��������� ���������� ������� ����� �� �������
   if(!m_max_limit_size.CheckButtonState())
      return;
//--- ��� �������� ����������� ��������� ������� ��������
   static bool resize_direction=false;
//--- ���� ����� �� �������� ������� �������
   if((int)m_series_size.GetValue()<=m_min_limit_size.GetValue())
     {
      //--- ���������� ����������� �� ���������� �������
      resize_direction=false;
      //--- ���� ����� �������� �������� X
      if(m_increment_ratio.CheckButtonState())
        {
         //--- ��� �������� ����������� �������� ������������ ����������
         static bool increment_ratio_direction=true;
         //--- ���� ������� ��������� �� ����������
         if(increment_ratio_direction)
           {
            //--- ���� ����� �� ������������� �����������, ������� ����������� �������� �� ���������������
            if(m_increment_ratio.GetValue()>=m_increment_ratio.MaxValue()-1)
               increment_ratio_direction=false;
           }
         //--- ���� ������� ��������� �� ����������
         else
           {
            //--- ���� ����� �� ������������ �����������, ������� ����������� �������� �� ���������������
            if(m_increment_ratio.GetValue()<=m_increment_ratio.MinValue()+1)
               increment_ratio_direction=true;
           }
         //--- ������� ������� �������� ��������� "Increment ratio" � ������� ��� �� ���������� �����������
         int increase_value=(int)m_increment_ratio.GetValue();
         m_increment_ratio.ChangeValue((increment_ratio_direction)? ++increase_value : --increase_value);
        }
     }
//--- ���������� ����������� �� ���������� ������� ���� ����� �� ���������
   if((int)m_series_size.GetValue()>=m_max_limit_size.GetValue())
      resize_direction=true;

//--- ���� ��������� ���������� �������, ��������� �������
   if(m_progress_bar.IsVisible())
     {
      if(!resize_direction)
         m_progress_bar.Update((int)m_series_size.GetValue(),(int)m_max_limit_size.GetValue());
      else
         m_progress_bar.Update(int(m_max_limit_size.GetValue()-m_series_size.GetValue()),(int)m_max_limit_size.GetValue());
     }
//--- �������� ������ ������� �� �����������
   int size_of_series=(int)m_series_size.GetValue();
   m_series_size.ChangeValue((!resize_direction)? ++size_of_series : --size_of_series);
//--- ��������� ����� ������ ��������
   ResizeDataArrays();
  }
//+------------------------------------------------------------------+
