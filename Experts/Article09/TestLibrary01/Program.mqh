//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//+------------------------------------------------------------------+
//| Класс для создания приложения                                    |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- Форма 1 - главное окно
   CWindow           m_window1;
   //--- Форма 2 - окно с цветовой палитрой для выбора цвета
   CWindow           m_window2;
   //--- Главное меню и его контекстные меню
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Статусная строка
   CStatusBar        m_status_bar;

   //--- Кнопки для вызова окна с цветовой палитрой
   CColorButton      m_color_button1;
   CColorButton      m_color_button2;
   CColorButton      m_color_button3;
   CColorButton      m_color_button4;
   CColorButton      m_color_button5;
   //--- Цветовая палитра
   CColorPicker      m_color_picker;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Инициализация/деинициализация
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Таймер
   void              OnTimerEvent(void);
   //---
protected:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
public:
   //--- Создаёт экспертную панель
   bool              CreateExpertPanel(void);
   //---
private:
   //--- Форма 1
   bool              CreateWindow1(const string text);
   //--- Форма 2
   bool              CreateWindow2(const string text);

   //--- Главное меню и его контекстные меню
#define MENUBAR_GAP_X         (1)
#define MENUBAR_GAP_Y         (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Статусная строка
#define STATUSBAR1_GAP_X      (1)
#define STATUSBAR1_GAP_Y      (175)
   bool              CreateStatusBar(void);
   //--- Кнопки для вызова цветовой палитры
#define COLORBUTTON1_GAP_X    (7)
#define COLORBUTTON1_GAP_Y    (50)
   bool              CreateColorButton1(const string text);
#define COLORBUTTON2_GAP_X    (7)
#define COLORBUTTON2_GAP_Y    (75)
   bool              CreateColorButton2(const string text);
#define COLORBUTTON3_GAP_X    (7)
#define COLORBUTTON3_GAP_Y    (100)
   bool              CreateColorButton3(const string text);
#define COLORBUTTON4_GAP_X    (7)
#define COLORBUTTON4_GAP_Y    (125)
   bool              CreateColorButton4(const string text);
#define COLORBUTTON5_GAP_X    (7)
#define COLORBUTTON5_GAP_Y    (150)
   bool              CreateColorButton5(const string text);
   //--- Цветовая палитра
#define COLORPICKER_GAP_X     (1)
#define COLORPICKER_GAP_Y     (20)
   bool              CreateColorPicker(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void)
  {
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
//--- 
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Событие нажатия на пункте меню
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      return;
     }
//--- Событие изменения цвета посредством цветовой палитры
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_COLOR)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);

      //---Если идентификаторы элементов совпадают
      if(lparam==m_color_picker.Id())
        {
         //--- Если ответ от первой кнопки
         if(sparam==m_color_button1.LabelText())
           {
            //--- Изменить цвет объекта, который относится к первой кнопке...
            return;
           }
         //--- Если ответ от второй кнопки
         if(sparam==m_color_button2.LabelText())
           {
            //--- Изменить цвет объекта, который относится ко второй кнопке...
            return;
           }
         //--- Если ответ от третьей кнопки
         if(sparam==m_color_button3.LabelText())
           {
            //--- Изменить цвет объекта, который относится к третьей кнопке...
            return;
           }
         //--- Если ответ от четвёртой кнопки
         if(sparam==m_color_button4.LabelText())
           {
            //--- Изменить цвет объекта, который относится к четвёртой кнопке...
            return;
           }
         //--- Если ответ от пятой кнопки
         if(sparam==m_color_button5.LabelText())
           {
            //--- Изменить цвет объекта, который относится к пятой кнопке...
            return;
           }
        }
      return;
     }
//--- Событие нажатия на кнопке
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);

      //--- Если нажали на первую кнопку
      if(sparam==m_color_button1.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button1);
         return;
        }
      //--- Если нажали на вторую кнопку
      if(sparam==m_color_button2.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button2);
         return;
        }
      //--- Если нажали на третью кнопку
      if(sparam==m_color_button3.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button3);
         return;
        }
      //--- Если нажали на четвёртую кнопку
      if(sparam==m_color_button4.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button4);
         return;
        }
      //--- Если нажали на пятую кнопку
      if(sparam==m_color_button5.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button5);
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| Создаёт экспертную панель                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(void)
  {
//--- Создание формы 1 для элементов управления
   if(!CreateWindow1("EXPERT PANEL"))
      return(false);
//--- Создание элементов управления:
//    Главное меню
   if(!CreateMenuBar())
      return(false);
//--- Контекстные меню
   if(!CreateMBContextMenu1())
      return(false);
   if(!CreateMBContextMenu2())
      return(false);
   if(!CreateMBContextMenu3())
      return(false);
   if(!CreateMBContextMenu4())
      return(false);
//--- Статусная строка
   if(!CreateStatusBar())
      return(false);

//--- Кнопка для вызова цветовой палитры
   if(!CreateColorButton1("Color button 1:"))
      return(false);
   if(!CreateColorButton2("Color button 2:"))
      return(false);
   if(!CreateColorButton3("Color button 3:"))
      return(false);
   if(!CreateColorButton4("Color button 4:"))
      return(false);
   if(!CreateColorButton5("Color button 5:"))
      return(false);

//--- Создание формы 2 для цветовой палитры
   if(!CreateWindow2("COLOR PICKER"))
      return(false);
//--- Цветовая палитра
   if(!CreateColorPicker())
      return(false);
//--- Перерисовка графика
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт форму 1 для элементов управления                         |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow1(const string caption_text)
  {
//--- Добавим указатель окна в массив окон
   CWndContainer::AddWindow(m_window1);
//--- Координаты
   int x=(m_window1.X()>0) ? m_window1.X() : 1;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 1;
//--- Свойства
   m_window1.Movable(true);
   m_window1.XSize(210);
   m_window1.YSize(200);
   m_window1.WindowBgColor(clrWhiteSmoke);
   m_window1.WindowBorderColor(clrLightSteelBlue);
   m_window1.CaptionBgColor(clrLightSteelBlue);
   m_window1.CaptionBgColorHover(clrLightSteelBlue);
//--- Создание формы
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт главное меню                                             |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuBar(void)
  {
//--- Три пункта в главном меню
#define MENUBAR_TOTAL 3
//--- Сохраним указатель на окно
   m_menubar.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+MENUBAR_GAP_X;
   int y=m_window1.Y()+MENUBAR_GAP_Y;
//--- Массивы с уникальными свойствами пунктов
   int    width[MENUBAR_TOTAL] ={50,55,53};
   string text[MENUBAR_TOTAL]  ={"File","View","Help"};
//--- Свойства
   m_menubar.MenuBackColor(C'225,225,225');
   m_menubar.MenuBorderColor(C'225,225,225');
   m_menubar.ItemBackColor(C'225,225,225');
   m_menubar.ItemBorderColor(C'225,225,225');
//--- Добавить пункты в главное меню
   for(int i=0; i<MENUBAR_TOTAL; i++)
      m_menubar.AddItem(width[i],text[i]);
//--- Создадим элемент управления
   if(!m_menubar.CreateMenuBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_menubar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт контекстное меню                                         |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice_colorless.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
//---
bool CProgram::CreateMBContextMenu1(void)
  {
//--- Шесть пунктов в контекстном меню
#define CONTEXTMENU_ITEMS1 3
//--- Сохраним указатель на окно
   m_mb_contextmenu1.WindowPointer(m_window1);
//--- Сохраним указатель на предыдущий узел
   m_mb_contextmenu1.PrevNodePointer(m_menubar.ItemPointerByIndex(0));
//--- Прикрепить контекстное меню к указанному пункту меню
   m_menubar.AddContextMenuPointer(0,m_mb_contextmenu1);
//--- Массив названий пунктов
   string items_text[CONTEXTMENU_ITEMS1]=
     {
      "ContextMenu 1 Item 1",
      "ContextMenu 1 Item 2",
      "ContextMenu 1 Item 3..."
     };
//--- Массив ярлыков для доступного режима
   string items_bmp_on[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- Массив ярлыков для заблокированного режима
   string items_bmp_off[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp"
     };
//--- Массив типов пунктов
   ENUM_TYPE_MENU_ITEM items_type[]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE
     };
//--- Установим свойства перед созданием
   m_mb_contextmenu1.FixSide(FIX_BOTTOM);
   m_mb_contextmenu1.XSize(160);
   m_mb_contextmenu1.AreaBackColor(C'240,240,240');
   m_mb_contextmenu1.AreaBorderColor(clrSilver);
   m_mb_contextmenu1.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu1.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu1.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu1.LabelColor(clrBlack);
   m_mb_contextmenu1.LabelColorHover(clrWhite);
   m_mb_contextmenu1.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu1.SeparateLineLightColor(clrWhite);
//--- Добавить пункты в контекстное меню
   for(int i=0; i<CONTEXTMENU_ITEMS1; i++)
      m_mb_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Разделительная линия после второго пункта
   m_mb_contextmenu1.AddSeparateLine(1);
//--- Деактивировать второй пункт
   m_mb_contextmenu1.ItemPointerByIndex(1).ItemState(false);
//--- Создать контекстное меню
   if(!m_mb_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт контекстное меню                                         |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu2(void)
  {
//--- Шесть пунктов в контекстном меню
#define CONTEXTMENU_ITEMS2 3
//--- Сохраним указатель на окно
   m_mb_contextmenu2.WindowPointer(m_window1);
//--- Сохраним указатель на предыдущий узел
   m_mb_contextmenu2.PrevNodePointer(m_menubar.ItemPointerByIndex(1));
//--- Прикрепить контекстное меню к указанному пункту меню
   m_menubar.AddContextMenuPointer(1,m_mb_contextmenu2);
//--- Массив названий пунктов
   string items_text[CONTEXTMENU_ITEMS2]=
     {
      "ContextMenu 2 Item 1",
      "ContextMenu 2 Item 2",
      "ContextMenu 2 Item 3"
     };
//--- Массив ярлыков для доступного режима
   string items_bmp_on[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Массив ярлыков для заблокированного режима
   string items_bmp_off[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Массив типов пунктов
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS2]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Установим свойства перед созданием
   m_mb_contextmenu2.FixSide(FIX_BOTTOM);
   m_mb_contextmenu2.XSize(160);
   m_mb_contextmenu2.AreaBackColor(C'240,240,240');
   m_mb_contextmenu2.AreaBorderColor(clrSilver);
   m_mb_contextmenu2.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu2.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu2.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu2.LabelColor(clrBlack);
   m_mb_contextmenu2.LabelColorHover(clrWhite);
   m_mb_contextmenu2.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu2.SeparateLineLightColor(clrWhite);
//--- Добавить пункты в контекстное меню
   for(int i=0; i<CONTEXTMENU_ITEMS2; i++)
      m_mb_contextmenu2.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Разделительная линия после второго пункта
   m_mb_contextmenu2.AddSeparateLine(1);
//--- Создать контекстное меню
   if(!m_mb_contextmenu2.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт контекстное меню                                         |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp"
//---
bool CProgram::CreateMBContextMenu3(void)
  {
//--- Пять пунктов в контекстном меню
#define CONTEXTMENU_ITEMS3 5
//--- Сохраним указатель на окно
   m_mb_contextmenu3.WindowPointer(m_window1);
//--- Сохраним указатель на предыдущий узел
   m_mb_contextmenu3.PrevNodePointer(m_menubar.ItemPointerByIndex(2));
//--- Прикрепить контекстное меню к указанному пункту меню
   m_menubar.AddContextMenuPointer(2,m_mb_contextmenu3);
//--- Массив названий пунктов
   string items_text[CONTEXTMENU_ITEMS3]=
     {
      "ContextMenu 3 Item 1",
      "ContextMenu 3 Item 2",
      "ContextMenu 3 Item 3...",
      "ContextMenu 3 Item 4",
      "ContextMenu 3 Item 5"
     };
//--- Массив ярлыков для доступного режима
   string items_bmp_on[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp",
      "",""
     };
//--- Массив ярлыков для заблокированного режима 
   string items_bmp_off[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Массив типов пунктов
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS3]=
     {
      MI_SIMPLE,
      MI_HAS_CONTEXT_MENU,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Установим свойства перед созданием
   m_mb_contextmenu3.FixSide(FIX_BOTTOM);
   m_mb_contextmenu3.XSize(160);
   m_mb_contextmenu3.AreaBackColor(C'240,240,240');
   m_mb_contextmenu3.AreaBorderColor(clrSilver);
   m_mb_contextmenu3.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu3.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu3.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu3.LabelColor(clrBlack);
   m_mb_contextmenu3.LabelColorHover(clrWhite);
   m_mb_contextmenu3.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu3.SeparateLineLightColor(clrWhite);
   m_mb_contextmenu3.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RightTransp_black.bmp");
//--- Добавить пункты в контекстное меню
   for(int i=0; i<CONTEXTMENU_ITEMS3; i++)
      m_mb_contextmenu3.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Разделительная линия после третьего пункта
   m_mb_contextmenu3.AddSeparateLine(2);
//--- Создать контекстное меню
   if(!m_mb_contextmenu3.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт контекстное меню                                         |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu4(void)
  {
//--- Шесть пунктов в контекстном меню
#define CONTEXTMENU_ITEMS4 3
//--- Сохраним указатель на окно
   m_mb_contextmenu4.WindowPointer(m_window1);
//--- Сохраним указатель на предыдущий узел
   m_mb_contextmenu4.PrevNodePointer(m_mb_contextmenu3.ItemPointerByIndex(1));
//--- Массив названий пунктов
   string items_text[CONTEXTMENU_ITEMS4]=
     {
      "ContextMenu 4 Item 1",
      "ContextMenu 4 Item 2",
      "ContextMenu 4 Item 3"
     };
//--- Массив ярлыков для доступного режима
   string items_bmp_on[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Массив ярлыков для заблокированного режима
   string items_bmp_off[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_colorless.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_colorless.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Массив типов пунктов
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS4]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Установим свойства перед созданием
   m_mb_contextmenu4.XSize(160);
   m_mb_contextmenu4.AreaBackColor(C'240,240,240');
   m_mb_contextmenu4.AreaBorderColor(clrSilver);
   m_mb_contextmenu4.ItemBackColorHover(C'240,240,240');
   m_mb_contextmenu4.ItemBackColorHoverOff(clrLightGray);
   m_mb_contextmenu4.ItemBorderColor(C'240,240,240');
   m_mb_contextmenu4.LabelColor(clrBlack);
   m_mb_contextmenu4.LabelColorHover(clrWhite);
   m_mb_contextmenu4.SeparateLineDarkColor(C'160,160,160');
   m_mb_contextmenu4.SeparateLineLightColor(clrWhite);
//--- Добавить пункты в контекстное меню
   for(int i=0; i<CONTEXTMENU_ITEMS4; i++)
      m_mb_contextmenu4.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Разделительная линия после второго пункта
   m_mb_contextmenu4.AddSeparateLine(1);
//--- Создать контекстное меню
   if(!m_mb_contextmenu4.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu4);
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
//| Создаёт кнопку для вызова цветовой палитры 1                     |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton1(const string text)
  {
//--- Сохраним указатель на окно
   m_color_button1.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+COLORBUTTON1_GAP_X;
   int y=m_window1.Y()+COLORBUTTON1_GAP_Y;
//--- Установим свойства перед созданием
   m_color_button1.XSize(195);
   m_color_button1.YSize(18);
   m_color_button1.ButtonXSize(100);
   m_color_button1.ButtonYSize(18);
   m_color_button1.AreaColor(clrWhiteSmoke);
   m_color_button1.LabelColor(clrBlack);
   m_color_button1.BackColor(C'220,220,220');
   m_color_button1.BorderColor(clrSilver);
   m_color_button1.CurrentColor(clrRed);
//--- Создать элемент
   if(!m_color_button1.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_color_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку для вызова цветовой палитры 2                     |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton2(const string text)
  {
//--- Сохраним указатель на окно
   m_color_button2.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+COLORBUTTON2_GAP_X;
   int y=m_window1.Y()+COLORBUTTON2_GAP_Y;
//--- Установим свойства перед созданием
   m_color_button2.XSize(195);
   m_color_button2.YSize(18);
   m_color_button2.ButtonXSize(100);
   m_color_button2.ButtonYSize(18);
   m_color_button2.AreaColor(clrWhiteSmoke);
   m_color_button2.LabelColor(clrBlack);
   m_color_button2.BackColor(C'220,220,220');
   m_color_button2.BorderColor(clrSilver);
   m_color_button2.CurrentColor(clrGold);
//--- Создать элемент
   if(!m_color_button2.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_color_button2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку для вызова цветовой палитры 3                     |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton3(const string text)
  {
//--- Сохраним указатель на окно
   m_color_button3.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+COLORBUTTON3_GAP_X;
   int y=m_window1.Y()+COLORBUTTON3_GAP_Y;
//--- Установим свойства перед созданием
   m_color_button3.XSize(195);
   m_color_button3.YSize(18);
   m_color_button3.ButtonXSize(100);
   m_color_button3.ButtonYSize(18);
   m_color_button3.AreaColor(clrWhiteSmoke);
   m_color_button3.LabelColor(clrBlack);
   m_color_button3.BackColor(C'220,220,220');
   m_color_button3.BorderColor(clrSilver);
   m_color_button3.CurrentColor(clrCornflowerBlue);
//--- Создать элемент
   if(!m_color_button3.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_color_button3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку для вызова цветовой палитры 4                     |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton4(const string text)
  {
//--- Сохраним указатель на окно
   m_color_button4.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+COLORBUTTON4_GAP_X;
   int y=m_window1.Y()+COLORBUTTON4_GAP_Y;
//--- Установим свойства перед созданием
   m_color_button4.XSize(195);
   m_color_button4.YSize(18);
   m_color_button4.ButtonXSize(100);
   m_color_button4.ButtonYSize(18);
   m_color_button4.AreaColor(clrWhiteSmoke);
   m_color_button4.LabelColor(clrBlack);
   m_color_button4.BackColor(C'220,220,220');
   m_color_button4.BorderColor(clrSilver);
   m_color_button4.CurrentColor(clrGreen);
//--- Создать элемент
   if(!m_color_button4.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_color_button4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку для вызова цветовой палитры 5                     |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton5(const string text)
  {
//--- Сохраним указатель на окно
   m_color_button5.WindowPointer(m_window1);
//--- Координаты
   int x=m_window1.X()+COLORBUTTON5_GAP_X;
   int y=m_window1.Y()+COLORBUTTON5_GAP_Y;
//--- Установим свойства перед созданием
   m_color_button5.XSize(195);
   m_color_button5.YSize(18);
   m_color_button5.ButtonXSize(100);
   m_color_button5.ButtonYSize(18);
   m_color_button5.AreaColor(clrWhiteSmoke);
   m_color_button5.LabelColor(clrBlack);
   m_color_button5.BackColor(C'220,220,220');
   m_color_button5.BorderColor(clrSilver);
   m_color_button5.CurrentColor(clrBrown);
//--- Создать элемент
   if(!m_color_button5.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(0,m_color_button5);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт форму 2 для цветовой палитры                             |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\color_picker.bmp"
//---
bool CProgram::CreateWindow2(const string caption_text)
  {
//--- Сохраним указатель на окно
   CWndContainer::AddWindow(m_window2);
//--- Координаты
   int x=(m_window2.X()>0) ? m_window2.X() : 30;
   int y=(m_window2.Y()>0) ? m_window2.Y() : 30;
//--- Свойства
   m_window2.Movable(true);
   m_window2.XSize(350);
   m_window2.YSize(286);
   m_window2.WindowType(W_DIALOG);
   m_window2.WindowBgColor(clrWhiteSmoke);
   m_window2.WindowBorderColor(clrLightSteelBlue);
   m_window2.CaptionBgColor(clrLightSteelBlue);
   m_window2.CaptionBgColorHover(clrLightSteelBlue);
   m_window2.IconFile("Images\\EasyAndFastGUI\\Icons\\bmp16\\color_picker.bmp");
//--- Создание формы
   if(!m_window2.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт цветовую палитру для выбора цвета                        |
//+------------------------------------------------------------------+
bool CProgram::CreateColorPicker(void)
  {
//--- Сохраним указатель на окно
   m_color_picker.WindowPointer(m_window2);
//--- Координаты
   int x=m_window2.X()+COLORPICKER_GAP_X;
   int y=m_window2.Y()+COLORPICKER_GAP_Y;
//--- Создание элемента
   if(!m_color_picker.CreateColorPicker(m_chart_id,m_subwin,x,y))
      return(false);
//--- Добавим указатель на элемент в базу
   CWndContainer::AddToElementsArray(1,m_color_picker);
   return(true);
  }
//+------------------------------------------------------------------+
