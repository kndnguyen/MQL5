//+------------------------------------------------------------------+
//|                                                  ColorPicker.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "SpinEdit.mqh"
#include "SimpleButton.mqh"
#include "RadioButtons.mqh"
#include "ColorButton.mqh"
//+------------------------------------------------------------------+
//| Класс для создания цветовой палитры для выбора цвета             |
//+------------------------------------------------------------------+
class CColorPicker : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Указатель на кнопку вызывающую элемент для выбора цвета
   CColorButton     *m_color_button;
   //--- Объекты для создания элемента
   CRectLabel        m_area;
   CRectCanvas       m_canvas;
   CRectLabel        m_current;
   CRectLabel        m_picked;
   CRectLabel        m_hover;
   //---
   CRadioButtons     m_radio_buttons;
   CSpinEdit         m_hsl_h_edit;
   CSpinEdit         m_hsl_s_edit;
   CSpinEdit         m_hsl_l_edit;
   //---
   CSpinEdit         m_rgb_r_edit;
   CSpinEdit         m_rgb_g_edit;
   CSpinEdit         m_rgb_b_edit;
   //---
   CSpinEdit         m_lab_l_edit;
   CSpinEdit         m_lab_a_edit;
   CSpinEdit         m_lab_b_edit;
   //---
   CSimpleButton     m_button_ok;
   CSimpleButton     m_button_cancel;
   //--- Цвет (1) фона и (2) рамки фона
   color             m_area_color;
   color             m_area_border_color;
   //--- Цвет рамки палитры
   color             m_palette_border_color;
   //--- Цвета (1) текущего, (2) выбранного и (3) указанного курсором мыши
   color             m_current_color;
   color             m_picked_color;
   color             m_hover_color;
   //--- Значения компонентов в разных цветовых моделях:
   //    HSL
   double            m_hsl_h;
   double            m_hsl_s;
   double            m_hsl_l;
   //--- RGB
   double            m_rgb_r;
   double            m_rgb_g;
   double            m_rgb_b;
   //--- Lab
   double            m_lab_l;
   double            m_lab_a;
   double            m_lab_b;
   //--- XYZ
   double            m_xyz_x;
   double            m_xyz_y;
   double            m_xyz_z;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_area_zorder;
   int               m_canvas_zorder;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //---
public:
                     CColorPicker(void);
                    ~CColorPicker(void);
   //--- Методы для создания элемента
   bool              CreateColorPicker(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreatePalette(void);
   bool              CreateCurrentSample(void);
   bool              CreatePickedSample(void);
   bool              CreateHoverSample(void);
   bool              CreateRadioButtons(void);
   bool              CreateHslHEdit(void);
   bool              CreateHslSEdit(void);
   bool              CreateHslLEdit(void);
   bool              CreateRgbREdit(void);
   bool              CreateRgbGEdit(void);
   bool              CreateRgbBEdit(void);
   bool              CreateLabLEdit(void);
   bool              CreateLabAEdit(void);
   bool              CreateLabBEdit(void);
   bool              CreateButtonOK(const string text);
   bool              CreateButtonCancel(const string text);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращает указатели на элементы формы
   void              WindowPointer(CWindow &object)           { m_wnd=::GetPointer(object);            }
   CRadioButtons    *GetRadioButtonsHslPointer(void)          { return(::GetPointer(m_radio_buttons)); }
   CSpinEdit        *GetSpinEditHslHPointer(void)             { return(::GetPointer(m_hsl_h_edit));    }
   CSpinEdit        *GetSpinEditHslSPointer(void)             { return(::GetPointer(m_hsl_s_edit));    }
   CSpinEdit        *GetSpinEditHslLPointer(void)             { return(::GetPointer(m_hsl_l_edit));    }
   CSpinEdit        *GetSpinEditRgbRPointer(void)             { return(::GetPointer(m_rgb_r_edit));    }
   CSpinEdit        *GetSpinEditRgbGPointer(void)             { return(::GetPointer(m_rgb_g_edit));    }
   CSpinEdit        *GetSpinEditRgbBPointer(void)             { return(::GetPointer(m_rgb_b_edit));    }
   CSpinEdit        *GetSpinEditLabLPointer(void)             { return(::GetPointer(m_lab_l_edit));    }
   CSpinEdit        *GetSpinEditLabAPointer(void)             { return(::GetPointer(m_lab_a_edit));    }
   CSpinEdit        *GetSpinEditLabBPointer(void)             { return(::GetPointer(m_lab_b_edit));    }
   CSimpleButton    *GetSimpleButtonOKPointer(void)           { return(::GetPointer(m_button_ok));     }
   CSimpleButton    *GetSimpleButtonCancelPointer(void)       { return(::GetPointer(m_button_cancel)); }
   //--- Установка цвета (1) фона и (2) рамки фона, (3) рамки палитры
   void              AreaBackColor(const color clr)           { m_area_color=clr;                      }
   void              AreaBorderColor(const color clr)         { m_area_border_color=clr;               }
   void              PaletteBorderColor(const color clr)      { m_palette_border_color=clr;            }
   
   //--- Сохраняет указатель на кнопку вызывающую цветовую палитру
   void              ColorButtonPointer(CColorButton &object);
   //--- Установка цвета выбранного пользователем цвета на палитре
   void              CurrentColor(const color clr);
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
   //--- Получение цвета под курсором мыши
   bool              OnHoverColor(const int x,const int y);
   //--- Обработка нажатия на палитре
   bool              OnClickPalette(const string clicked_object);
   //--- Обработка нажатия на радио-кнопке
   bool              OnClickRadioButton(const long id,const int button_index,const string button_text);
   //--- Обработка ввода нового значения в поле ввода
   bool              OnEndEdit(const long id,const int button_index);
   //--- Обработка нажатия на кнопке 'OK'
   bool              OnClickButtonOK(const string clicked_object);
   //--- Обработка нажатия на кнопке 'Cancel'
   bool              OnClickButtonCancel(const string clicked_object);

   //--- Рисует палитру
   void              DrawPalette(const int index);
   //--- Рисует палитру по цветовой модели HSL (0: H, 1: S, 2: L)
   void              DrawHSL(const int index);
   //--- Рисует палитру по цветовой модели RGB (3: R, 4: G, 5: B)
   void              DrawRGB(const int index);
   //--- Рисует палитру по цветовой модели LAB (6: L, 7: a, 8: b)
   void              DrawLab(const int index);
   //--- Рисует рамку палитры
   void              DrawPaletteBorder(void);

   //--- Расчёт и установка компонентов цвета
   void              SetComponents(const int index,const bool fix_selected);
   //--- Установка текущих параметров в поля ввода
   void              SetControls(const int index,const bool fix_selected);

   //--- Установка параметров цветовых моделей относительно (1) HSL, (2) RGB, (3) Lab
   void              SetHSL(void);
   void              SetRGB(void);
   void              SetLab(void);

   //--- Корректировка компонент RGB
   void              AdjustmentComponentRGB(void);
   //--- Корректировка компонент HSL
   void              AdjustmentComponentHSL(void);

   //--- Ускоренная перемотка значений в поле ввода
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CColorPicker::CColorPicker(void) : m_area_color(clrWhiteSmoke),
                                   m_area_border_color(clrWhiteSmoke),
                                   m_palette_border_color(clrSilver),
                                   m_current_color(clrWhite),
                                   m_picked_color(clrCornflowerBlue),
                                   m_hover_color(clrRed)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder   =0;
   m_canvas_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CColorPicker::~CColorPicker(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик события графика                                       |
//+------------------------------------------------------------------+
void CColorPicker::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_canvas.MouseFocus(x>m_canvas.X() && x<m_canvas.X2()-1 && y>m_canvas.Y() && y<m_canvas.Y2()-1);
      //--- Получение цвета под курсором мыши
      if(OnHoverColor(x,y))
         return;
      //---
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Если нажали на палитре
      if(OnClickPalette(sparam))
         return;
      //---
      return;
     }
//--- Обработка ввода значения в поле ввода
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      //--- Проверка ввода нового значения
      if(OnEndEdit(lparam,(int)dparam))
         return;
      //---
      return;
     }
//--- Обработка нажатия на элементе
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      //--- Если нажали на радио-кнопке
      if(OnClickRadioButton(lparam,(int)dparam,sparam))
         return;
      //---
      return;
     }
//--- Обработка нажатия на переключателях полей ввода
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC || id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      //--- Проверка ввода нового значения
      if(OnEndEdit(lparam,(int)dparam))
         return;
      //---
      return;
     }
//--- Обработка нажатия на кнопке элемента
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      //--- Выйти, если идентификаторы не совпадают
      if(lparam!=CElement::Id())
         return;
      //--- Если нажали на кнопке "OK"
      if(OnClickButtonOK(sparam))
         return;
      //--- Если нажали на кнопке "CANCEL"
      if(OnClickButtonCancel(sparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CColorPicker::OnEventTimer(void)
  {
//--- Если элемент выпадающий
   if(CElement::IsDropdown())
      FastSwitching();
   else
     {
      //--- Отслеживаем перемотку значений, 
      //    только если форма не заблокирована
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| Создаёт объект Color Picker                                      |
//+------------------------------------------------------------------+
bool CColorPicker::CreateColorPicker(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием элемента для выбора цвета классу нужно передать "
              "указатель на форму: CColorPicker::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x_size   =348;
   m_y_size   =265;
   m_x        =x;
   m_y        =y;
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создадим объекты элемента
   if(!CreateArea())
      return(false);
   if(!CreatePalette())
      return(false);
   if(!CreateCurrentSample())
      return(false);
   if(!CreatePickedSample())
      return(false);
   if(!CreateHoverSample())
      return(false);
   if(!CreateRadioButtons())
      return(false);
   if(!CreateHslHEdit())
      return(false);
   if(!CreateHslSEdit())
      return(false);
   if(!CreateHslLEdit())
      return(false);
   if(!CreateRgbREdit())
      return(false);
   if(!CreateRgbGEdit())
      return(false);
   if(!CreateRgbBEdit())
      return(false);
   if(!CreateLabLEdit())
      return(false);
   if(!CreateLabAEdit())
      return(false);
   if(!CreateLabBEdit())
      return(false);
   if(!CreateButtonOK("OK"))
      return(false);
   if(!CreateButtonCancel("Cancel"))
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//--- Рассчитать компоненты всех цветовых моделей и
//    нарисовать палитру относительно выделенной радио-кнопки
   SetComponents(m_radio_buttons.SelectedButtonIndex(),false);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт общую площадь                                            |
//+------------------------------------------------------------------+
bool CColorPicker::CreateArea(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_picker_bg_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X();
   int y=CElement::Y();
//--- Отступы от крайней точки
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- Создать объект
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- Свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт палитру цветов                                           |
//+------------------------------------------------------------------+
bool CColorPicker::CreatePalette(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_picker_palette_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+6;
   int y=CElement::Y()+5;
//--- Размеры
   int x_size=255;
   int y_size=255;
//--- Создать объект
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,x_size,y_size,COLOR_FORMAT_XRGB_NOALPHA))
      return(false);
//--- Прикрепить к графику
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Свойства
   m_canvas.Tooltip("\n");
   m_canvas.Z_Order(m_canvas_zorder);
//--- Координаты
   m_canvas.X(x);
   m_canvas.Y(y);
//--- Размеры
   m_canvas.XSize(x_size);
   m_canvas.YSize(y_size);
//--- Отступы от крайней точки
   m_canvas.XGap(x-m_wnd.X());
   m_canvas.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_canvas);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт образец текущего цвета                                   |
//+------------------------------------------------------------------+
bool CColorPicker::CreateCurrentSample(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_picker_csample_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+266;
   int y=CElement::Y()+5;
//--- Создать объект
   if(!m_current.Create(m_chart_id,name,m_subwin,x,y,76,25))
      return(false);
//--- Свойства
   m_current.BackColor(m_current_color);
   m_current.Color(clrSilver);
   m_current.BorderType(BORDER_FLAT);
   m_current.Corner(m_corner);
   m_current.Selectable(false);
   m_current.Z_Order(m_area_zorder);
   m_current.Tooltip(::ColorToString(m_current_color));
//--- Отступы от крайней точки
   m_current.XGap(x-m_wnd.X());
   m_current.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_current);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт образец выбранного цвета                                 |
//+------------------------------------------------------------------+
bool CColorPicker::CreatePickedSample(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_picker_psample_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+290;
   int y=CElement::Y()+6;
//--- Создать объект
   if(!m_picked.Create(m_chart_id,name,m_subwin,x,y,26,23))
      return(false);
//--- Свойства
   m_picked.BackColor(m_picked_color);
   m_picked.Color(m_picked_color);
   m_picked.BorderType(BORDER_FLAT);
   m_picked.Corner(m_corner);
   m_picked.Selectable(false);
   m_picked.Z_Order(m_area_zorder);
   m_picked.Tooltip(::ColorToString(m_picked_color));
//--- Отступы от крайней точки
   m_picked.XGap(x-m_wnd.X());
   m_picked.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_picked);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт образец цвета при наведении                              |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHoverSample(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_color_picker_hsample_"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+316;
   int y=CElement::Y()+6;
//--- Создать объект
   if(!m_hover.Create(m_chart_id,name,m_subwin,x,y,25,23))
      return(false);
//--- Свойства
   m_hover.BackColor(m_hover_color);
   m_hover.Color(m_hover_color);
   m_hover.BorderType(BORDER_FLAT);
   m_hover.Corner(m_corner);
   m_hover.Selectable(false);
   m_hover.Z_Order(m_area_zorder);
   m_hover.Tooltip(::ColorToString(m_hover_color));
//--- Отступы от крайней точки
   m_hover.XGap(x-m_wnd.X());
   m_hover.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_hover);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт группу радио-кнопок                                      |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRadioButtons(void)
  {
//--- Сохраним указатель на форму
   m_radio_buttons.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+267;
   int y =CElement::Y()+35;
//--- Свойства
   int    buttons_x_offset[] ={0,0,0,0,0,0,0,0,0};
   int    buttons_y_offset[] ={0,19,38,60,79,98,120,139,158};
   string buttons_text[]     ={"H:","S:","L:","R:","G:","B:","L:","a:","b:"};
   int    buttons_width[]    ={80,80,80,80,80,80,80,80,80};
//--- Свойства
   m_radio_buttons.AreaColor(m_area_color);
   m_radio_buttons.TextColor(clrBlack);
   m_radio_buttons.TextColorOff(clrSilver);
   m_radio_buttons.LabelXGap(17);
//--- Добавим радио-кнопки с указанными свойствами
   for(int i=0; i<9; i++)
      m_radio_buttons.AddButton(buttons_x_offset[i],buttons_y_offset[i],buttons_text[i],buttons_width[i]);
//--- Создать группу кнопок
   if(!m_radio_buttons.CreateRadioButtons(m_chart_id,m_subwin,x,y))
      return(false);
//--- Выделим вторую радио-кнопку
   m_radio_buttons.SelectionRadioButton(1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (hsl) H                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHslHEdit(void)
  {
//--- Сохраним указатель на форму
   m_hsl_h_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+36;
//--- Свойства
   m_hsl_h_edit.XSize(38);
   m_hsl_h_edit.YSize(18);
   m_hsl_h_edit.EditXSize(30);
   m_hsl_h_edit.MaxValue(360);
   m_hsl_h_edit.MinValue(0);
   m_hsl_h_edit.StepValue(1);
   m_hsl_h_edit.SetDigits(0);
   m_hsl_h_edit.SetValue(360);
   m_hsl_h_edit.Index(0);
   m_hsl_h_edit.AreaColor(m_area_color);
   m_hsl_h_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_hsl_h_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (hsl) S                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHslSEdit(void)
  {
//--- Сохраним указатель на форму
   m_hsl_s_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+55;
//--- Свойства
   m_hsl_s_edit.XSize(38);
   m_hsl_s_edit.YSize(18);
   m_hsl_s_edit.EditXSize(30);
   m_hsl_s_edit.MaxValue(100);
   m_hsl_s_edit.MinValue(0);
   m_hsl_s_edit.StepValue(1);
   m_hsl_s_edit.SetDigits(0);
   m_hsl_s_edit.SetValue(100);
   m_hsl_s_edit.Index(1);
   m_hsl_s_edit.AreaColor(m_area_color);
   m_hsl_s_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_hsl_s_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (hsl) L                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHslLEdit(void)
  {
//--- Сохраним указатель на форму
   m_hsl_l_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+74;
//--- Свойства
   m_hsl_l_edit.XSize(38);
   m_hsl_l_edit.YSize(18);
   m_hsl_l_edit.EditXSize(30);
   m_hsl_l_edit.MaxValue(100);
   m_hsl_l_edit.MinValue(0);
   m_hsl_l_edit.StepValue(1);
   m_hsl_l_edit.SetDigits(0);
   m_hsl_l_edit.SetValue(50);
   m_hsl_l_edit.Index(2);
   m_hsl_l_edit.AreaColor(m_area_color);
   m_hsl_l_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_hsl_l_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (rgb) R                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRgbREdit(void)
  {
//--- Сохраним указатель на форму
   m_rgb_r_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+96;
//--- Свойства
   m_rgb_r_edit.XSize(38);
   m_rgb_r_edit.YSize(18);
   m_rgb_r_edit.EditXSize(30);
   m_rgb_r_edit.MaxValue(255);
   m_rgb_r_edit.MinValue(0);
   m_rgb_r_edit.StepValue(1);
   m_rgb_r_edit.SetDigits(0);
   m_rgb_r_edit.SetValue(50);
   m_rgb_r_edit.Index(3);
   m_rgb_r_edit.AreaColor(m_area_color);
   m_rgb_r_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_rgb_r_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (rgb) G                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRgbGEdit(void)
  {
//--- Сохраним указатель на форму
   m_rgb_g_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+115;
//--- Свойства
   m_rgb_g_edit.XSize(38);
   m_rgb_g_edit.YSize(18);
   m_rgb_g_edit.EditXSize(30);
   m_rgb_g_edit.MaxValue(255);
   m_rgb_g_edit.MinValue(0);
   m_rgb_g_edit.StepValue(1);
   m_rgb_g_edit.SetDigits(0);
   m_rgb_g_edit.SetValue(50);
   m_rgb_g_edit.Index(4);
   m_rgb_g_edit.AreaColor(m_area_color);
   m_rgb_g_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_rgb_g_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (rgb) B                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRgbBEdit(void)
  {
//--- Сохраним указатель на форму
   m_rgb_b_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+134;
//--- Свойства
   m_rgb_b_edit.XSize(38);
   m_rgb_b_edit.YSize(18);
   m_rgb_b_edit.EditXSize(30);
   m_rgb_b_edit.MaxValue(255);
   m_rgb_b_edit.MinValue(0);
   m_rgb_b_edit.StepValue(1);
   m_rgb_b_edit.SetDigits(0);
   m_rgb_b_edit.SetValue(50);
   m_rgb_b_edit.Index(5);
   m_rgb_b_edit.AreaColor(m_area_color);
   m_rgb_b_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_rgb_b_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (Lab) L                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateLabLEdit(void)
  {
//--- Сохраним указатель на форму
   m_lab_l_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+156;
//--- Свойства
   m_lab_l_edit.XSize(38);
   m_lab_l_edit.YSize(18);
   m_lab_l_edit.EditXSize(30);
   m_lab_l_edit.MaxValue(100);
   m_lab_l_edit.MinValue(0);
   m_lab_l_edit.StepValue(1);
   m_lab_l_edit.SetDigits(0);
   m_lab_l_edit.SetValue(50);
   m_lab_l_edit.Index(6);
   m_lab_l_edit.AreaColor(m_area_color);
   m_lab_l_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_lab_l_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (Lab) a                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateLabAEdit(void)
  {
//--- Сохраним указатель на форму
   m_lab_a_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+175;
//--- Свойства
   m_lab_a_edit.XSize(38);
   m_lab_a_edit.YSize(18);
   m_lab_a_edit.EditXSize(30);
   m_lab_a_edit.MaxValue(127);
   m_lab_a_edit.MinValue(-128);
   m_lab_a_edit.StepValue(1);
   m_lab_a_edit.SetDigits(0);
   m_lab_a_edit.SetValue(50);
   m_lab_a_edit.Index(7);
   m_lab_a_edit.AreaColor(m_area_color);
   m_lab_a_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_lab_a_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода (Lab) b                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateLabBEdit(void)
  {
//--- Сохраним указатель на форму
   m_lab_b_edit.WindowPointer(m_wnd);
//--- Координаты
   int x =CElement::X()+307;
   int y =CElement::Y()+194;
//--- Свойства
   m_lab_b_edit.XSize(38);
   m_lab_b_edit.YSize(18);
   m_lab_b_edit.EditXSize(30);
   m_lab_b_edit.MaxValue(127);
   m_lab_b_edit.MinValue(-128);
   m_lab_b_edit.StepValue(1);
   m_lab_b_edit.SetDigits(0);
   m_lab_b_edit.SetValue(50);
   m_lab_b_edit.Index(8);
   m_lab_b_edit.AreaColor(m_area_color);
   m_lab_b_edit.EditBorderColor(clrSilver);
//--- Создание элемента
   if(!m_lab_b_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку OK                                                |
//+------------------------------------------------------------------+
bool CColorPicker::CreateButtonOK(const string text)
  {
//--- Сохраним указатель на форму
   m_button_ok.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X()+267;
   int y=CElement::Y()+220;
//--- Свойства
   m_button_ok.ButtonXSize(75);
   m_button_ok.ButtonYSize(18);
   m_button_ok.BackColor(clrGainsboro);
   m_button_ok.BackColorHover(C'193,218,255');
   m_button_ok.BackColorPressed(C'190,190,200');
   m_button_ok.TextColor(clrBlack);
   m_button_ok.BorderColor(C'150,170,180');
   m_button_ok.Index(0);
//--- Создание элемента
   if(!m_button_ok.CreateSimpleButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку Cancel                                            |
//+------------------------------------------------------------------+
bool CColorPicker::CreateButtonCancel(const string text)
  {
//--- Сохраним указатель на форму
   m_button_cancel.WindowPointer(m_wnd);
//--- Координаты
   int x=CElement::X()+267;
   int y=CElement::Y()+241;
//--- Свойства
   m_button_cancel.ButtonXSize(75);
   m_button_cancel.ButtonYSize(18);
   m_button_cancel.BackColor(clrGainsboro);
   m_button_cancel.BackColorHover(C'193,218,255');
   m_button_cancel.BackColorPressed(C'190,190,200');
   m_button_cancel.TextColor(clrBlack);
   m_button_cancel.BorderColor(C'150,170,180');
   m_button_cancel.Index(1);
//--- Создание элемента
   if(!m_button_cancel.CreateSimpleButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Сохраняет указатель на кнопку вызывающую цветовую палитру и      |
//| открывает окно, к которому палитра присоединена                  |
//+------------------------------------------------------------------+
void CColorPicker::ColorButtonPointer(CColorButton &object)
  {
//--- Сохранить указатель на кнопку
   m_color_button=::GetPointer(object);
//--- Установим цвет переданной кнопки всем маркерам палитры
   CurrentColor(object.CurrentColor());
//--- Откроем окно, к которому присоединена палитра
   m_wnd.Show();
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CColorPicker::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение координат в полях элемента
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Сохранение координат в полях объектов
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
   m_canvas.X(x+m_canvas.XGap());
   m_canvas.Y(y+m_canvas.YGap());
   m_current.X(x+m_current.XGap());
   m_current.Y(y+m_current.YGap());
   m_picked.X(x+m_picked.XGap());
   m_picked.Y(y+m_picked.YGap());
   m_hover.X(x+m_hover.XGap());
   m_hover.Y(y+m_hover.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_canvas.X_Distance(m_canvas.X());
   m_canvas.Y_Distance(m_canvas.Y());
   m_current.X_Distance(m_current.X());
   m_current.Y_Distance(m_current.Y());
   m_picked.X_Distance(m_picked.X());
   m_picked.Y_Distance(m_picked.Y());
   m_hover.X_Distance(m_hover.X());
   m_hover.Y_Distance(m_hover.Y());
  }
//+------------------------------------------------------------------+
//| Показывает пункт меню                                            |
//+------------------------------------------------------------------+
void CColorPicker::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
   m_current.Timeframes(OBJ_ALL_PERIODS);
   m_picked.Timeframes(OBJ_ALL_PERIODS);
   m_hover.Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает пункт меню                                              |
//+------------------------------------------------------------------+
void CColorPicker::Hide(void)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_canvas.Timeframes(OBJ_NO_PERIODS);
   m_current.Timeframes(OBJ_NO_PERIODS);
   m_picked.Timeframes(OBJ_NO_PERIODS);
   m_hover.Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CColorPicker::Reset(void)
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
void CColorPicker::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_canvas.Delete();
   m_current.Delete();
   m_picked.Delete();
   m_hover.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CColorPicker::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_canvas.Z_Order(m_canvas_zorder);
   m_current.Z_Order(m_area_zorder);
   m_picked.Z_Order(m_area_zorder);
   m_hover.Z_Order(m_area_zorder);
//---
   m_radio_buttons.SetZorders();
   m_hsl_h_edit.SetZorders();
   m_hsl_s_edit.SetZorders();
   m_hsl_l_edit.SetZorders();
//---
   m_rgb_r_edit.SetZorders();
   m_rgb_g_edit.SetZorders();
   m_rgb_b_edit.SetZorders();
//---
   m_lab_l_edit.SetZorders();
   m_lab_a_edit.SetZorders();
   m_lab_b_edit.SetZorders();
//---
   m_button_ok.SetZorders();
   m_button_cancel.SetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CColorPicker::ResetZorders(void)
  {
   m_area.Z_Order(-1);
   m_canvas.Z_Order(-1);
   m_current.Z_Order(-1);
   m_picked.Z_Order(-1);
   m_hover.Z_Order(-1);
//---
   m_radio_buttons.ResetZorders();
   m_hsl_h_edit.ResetZorders();
   m_hsl_s_edit.ResetZorders();
   m_hsl_l_edit.ResetZorders();
//---
   m_rgb_r_edit.ResetZorders();
   m_rgb_g_edit.ResetZorders();
   m_rgb_b_edit.ResetZorders();
//---
   m_lab_l_edit.ResetZorders();
   m_lab_a_edit.ResetZorders();
   m_lab_b_edit.ResetZorders();
//---
   m_button_ok.ResetZorders();
   m_button_cancel.ResetZorders();
  }
//+------------------------------------------------------------------+
//| Установка текущего цвета                                         |
//+------------------------------------------------------------------+
void CColorPicker::CurrentColor(const color clr)
  {
   m_hover_color=clr;
   m_hover.Color(clr);
   m_hover.BackColor(clr);
   m_hover.Tooltip(::ColorToString(clr));
//---
   m_picked_color=clr;
   m_picked.Color(clr);
   m_picked.BackColor(clr);
   m_picked.Tooltip(::ColorToString(clr));
//---
   m_current_color=clr;
   m_current.BackColor(clr);
   m_current.Tooltip(::ColorToString(clr));
  }
//+------------------------------------------------------------------+
//| Получение цвета под курсором мыши                                |
//+------------------------------------------------------------------+
bool CColorPicker::OnHoverColor(const int x,const int y)
  {
//--- Выйти, если фокус не на палитре
   if(!m_canvas.MouseFocus())
      return(false);
//--- Определим цвет на палитре под курсором мыши
   int lx =x-m_canvas.X();
   int ly =y-m_canvas.Y();
   m_hover_color=(color)::ColorToARGB(m_canvas.PixelGet(lx,ly),0);
//--- Установим цвет и всплывающую подсказку в соответствующий образец (маркер)
   m_hover.Color(m_hover_color);
   m_hover.BackColor(m_hover_color);
   m_hover.Tooltip(::ColorToString(m_hover_color));
//--- Установим всплывающую подсказку палитре
   m_canvas.Tooltip(::ColorToString(m_hover_color));
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на цветовой палитре                            |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickPalette(const string clicked_object)
  {
//--- Выйти, если имя объекта не совпадает
   if(clicked_object!=m_canvas.Name())
      return(false);
//--- Установим цвет и всплывающую подсказку в соответствующий образец
   m_picked_color=m_hover_color;
   m_picked.Color(m_picked_color);
   m_picked.BackColor(m_picked_color);
   m_picked.Tooltip(::ColorToString(m_picked_color));
//--- Рассчитаем и установим компоненты цвета относительно выделенной радио-кнопки
   SetComponents();
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на радио-кнопке                                |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickRadioButton(const long id,const int button_index,const string button_text)
  {
//--- Выйти, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Выйти, если текст радио-кнопки не совпадает
   if(button_text!=m_radio_buttons.SelectedButtonText())
      return(false);
//--- Обновить палитру с учётом последних изменений
   DrawPalette(button_index);
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка ввода нового значения в поле ввода                     |
//+------------------------------------------------------------------+
bool CColorPicker::OnEndEdit(const long id,const int button_index)
  {
//--- Выйти, если идентификаторы не совпадают
   if(id!=CElement::Id())
      return(false);
//--- Рассчитаем и установим компоненты цвета для всех цветовых моделей 
   SetComponents(button_index,false);
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопке 'OK'                                 |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickButtonOK(const string clicked_object)
  {
//--- Выйти, если имя объекта не совпадает
   if(clicked_object!=m_button_ok.Text())
      return(false);
//--- Сохранить выбранный цвет
   m_current_color=m_picked_color;
   m_current.BackColor(m_current_color);
   m_current.Tooltip(::ColorToString(m_current_color));
//--- Если есть указатель кнопки вызова окна для выбора цвета
   if(::CheckPointer(m_color_button)!=POINTER_INVALID)
     {
      //--- Установим кнопке выбранный цвет
      m_color_button.CurrentColor(m_current_color);
      //--- Закроем окно
      m_wnd.CloseDialogBox();
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_CHANGE_COLOR,CElement::Id(),CElement::Index(),m_color_button.LabelText());
      //--- Обнулим указатель
      m_color_button=NULL;
     }
   else
     {
      //--- Если указателя нет и окно диалоговое,
      //    вывести сообщение, что нет указателя на кнопку для вызова элемента
      if(m_wnd.WindowType()==W_DIALOG)
         ::Print(__FUNCTION__," > Невалидный указатель вызывающего элемента (CColorButton).");
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на кнопке 'Cancel'                             |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickButtonCancel(const string clicked_object)
  {
//--- Выйти, если имя объекта не совпадает
   if(clicked_object!=m_button_cancel.Text())
      return(false);
//--- Закроем окно, если оно диалоговое
   if(m_wnd.WindowType()==W_DIALOG)
      m_wnd.CloseDialogBox();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Рисует палитру                                                   |
//+------------------------------------------------------------------+
void CColorPicker::DrawPalette(const int index)
  {
   switch(index)
     {
      //--- HSL (0: H, 1: S, 2: L)
      case 0 : case 1 : case 2 :
        {
         DrawHSL(index);
         break;
        }
      //--- RGB (3: R, 4: G, 5: B)
      case 3 : case 4 : case 5 :
        {
         DrawRGB(index);
         break;
        }
      //--- LAB (6: L, 7: a, 8: b)
      case 6 : case 7 : case 8 :
        {
         DrawLab(index);
         break;
        }
     }
//--- Нарисуем рамку палитры
   DrawPaletteBorder();
//--- Обновим палитру
   m_canvas.Update();
  }
//+------------------------------------------------------------------+
//| Рисует палитру HSL                                               |
//+------------------------------------------------------------------+
void CColorPicker::DrawHSL(const int index)
  {
   switch(index)
     {
      //--- Hue (H) - цветовой тон в диапазоне от 0 до 360
      case 0 :
        {
         //--- Рассчитаем H-компоненту
         m_hsl_h=m_hsl_h_edit.GetValue()/360.0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем L-компоненту
            m_hsl_l=ly/(double)m_canvas.YSize();
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем S-компоненту
               m_hsl_s=lx/(double)m_canvas.XSize();
               //--- Конвертация HSL-компонент в RGB-компоненты
               m_clr.HSLtoRGB(m_hsl_h,m_hsl_s,m_hsl_l,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Saturation (S) - насыщенность в диапазоне от 0 до 100
      case 1 :
        {
         //--- Рассчитаем S-компоненту
         m_hsl_s=m_hsl_s_edit.GetValue()/100.0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем L-компоненту
            m_hsl_l=ly/(double)m_canvas.YSize();
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем H-компоненту
               m_hsl_h=lx/(double)m_canvas.XSize();
               //--- Конвертация HSL-компонент в RGB-компоненты
               m_clr.HSLtoRGB(m_hsl_h,m_hsl_s,m_hsl_l,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Lightness (L) - яркость в диапазоне от 0 до 100
      case 2 :
        {
         //--- Рассчитаем L-компоненту
         m_hsl_l=m_hsl_l_edit.GetValue()/100.0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем S-компоненту
            m_hsl_s=ly/(double)m_canvas.YSize();
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем H-компоненту
               m_hsl_h=lx/(double)m_canvas.XSize();
               //--- Конвертация HSL-компонент в RGB-компоненты
               m_clr.HSLtoRGB(m_hsl_h,m_hsl_s,m_hsl_l,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует палитру RGB                                               |
//+------------------------------------------------------------------+
void CColorPicker::DrawRGB(const int index)
  {
//--- Шаги по осям X и Y для расчёта RGB-компонент
   double rgb_x_step=255.0/m_canvas.XSize();
   double rgb_y_step=255.0/m_canvas.YSize();
//---
   switch(index)
     {
      //--- Red (R) - красный. Цветовой диапазон от 0 до 255
      case 3 :
        {
         //--- Получим текущую R-компоненту и обнулим B-компоненту
         m_rgb_r =m_rgb_r_edit.GetValue();
         m_rgb_b =0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем B-компоненту и обнулим R-компоненту
            m_rgb_g=0;
            m_rgb_b+=rgb_y_step;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем G-компоненту
               m_rgb_g+=rgb_x_step;
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Green (G) - зелёный. Цветовой диапазон от 0 до 255
      case 4 :
        {
         //--- Получим текущую G-компоненту и обнулим B-компоненту
         m_rgb_g =m_rgb_g_edit.GetValue();
         m_rgb_b =0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем B-компоненту и обнулим R-компоненту
            m_rgb_r=0;
            m_rgb_b+=rgb_y_step;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем R-компоненту
               m_rgb_r+=rgb_x_step;
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Blue (B) - синий. Цветовой диапазон от 0 до 255
      case 5 :
        {
         //--- Получим текущую B-компоненту и обнулим G-компоненту
         m_rgb_g =0;
         m_rgb_b =m_rgb_b_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем G-компоненту и обнулим R-компоненту
            m_rgb_r=0;
            m_rgb_g+=rgb_y_step;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем R-компоненту
               m_rgb_r+=rgb_x_step;
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует палитру Lab                                               |
//+------------------------------------------------------------------+
void CColorPicker::DrawLab(const int index)
  {
   switch(index)
     {
      //--- Lightness (L) - яркость в диапазоне от 0 до 100
      case 6 :
        {
         //--- Получим текущую L-компоненту
         m_lab_l=m_lab_l_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем b-компоненту
            m_lab_b=(ly/(double)m_canvas.YSize()*255.0)-128;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем a-компоненту
               m_lab_a=(lx/(double)m_canvas.XSize()*255.0)-128;
               //--- Конвертация Lab-компонент в RGB-компоненты
               m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
               m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- Корректировка компонент RGB
               AdjustmentComponentRGB();
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Хроматическая компонента 'a' - диапазон от -128 (зелёный) до 127 (пурпурный)
      case 7 :
        {
         //--- Получим текущую a-компоненту
         m_lab_a=m_lab_a_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем b-компоненту
            m_lab_b=(ly/(double)m_canvas.YSize()*255.0)-128;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем L-компоненту
               m_lab_l=100.0*lx/(double)m_canvas.XSize();
               //--- Конвертация Lab-компонент в RGB-компоненты
               m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
               m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- Корректировка компонент RGB
               AdjustmentComponentRGB();
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Хроматическая компонента 'b' - диапазон от -128 (синий) до 127 (жёлтый)
      case 8 :
        {
         //--- Получим текущую b-компоненту
         m_lab_b=m_lab_b_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- Рассчитаем a-компоненту
            m_lab_a=(ly/(double)m_canvas.YSize()*255.0)-128;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- Рассчитаем L-компоненту
               m_lab_l=100.0*lx/(double)m_canvas.XSize();
               //--- Конвертация Lab-компонент в RGB-компоненты
               m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
               m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- Корректировка компонент RGB
               AdjustmentComponentRGB();
               //--- Соединим каналы
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует рамку палитры                                             |
//+------------------------------------------------------------------+
void CColorPicker::DrawPaletteBorder(void)
  {
//--- Размер палитры
   int x_size=m_canvas.XSize()-1;
   int y_size=m_canvas.YSize()-1;
//--- Нарисовать рамку
   m_canvas.Line(0,0,x_size,0,m_palette_border_color);
   m_canvas.Line(0,y_size,x_size,y_size,m_palette_border_color);
   m_canvas.Line(0,0,0,y_size,m_palette_border_color);
   m_canvas.Line(x_size,0,x_size,y_size,m_palette_border_color);
  }
//+------------------------------------------------------------------+
//| Расчёт и установка компонентов цвета                             |
//+------------------------------------------------------------------+
void CColorPicker::SetComponents(const int index=0,const bool fix_selected=true)
  {
//--- Если нужно скорректировать цвета относительно выделенного радио-кнопкой компонента
   if(fix_selected)
     {
      //--- Разложим на RGB-компоненты выбранный цвет
      m_rgb_r=m_clr.GetR(m_picked_color);
      m_rgb_g=m_clr.GetG(m_picked_color);
      m_rgb_b=m_clr.GetB(m_picked_color);
      //--- Конвертируем RGB-компоненты в HSL-компоненты
      m_clr.RGBtoHSL(m_rgb_r,m_rgb_g,m_rgb_b,m_hsl_h,m_hsl_s,m_hsl_l);
      //--- Корректировка компонент HSL
      AdjustmentComponentHSL();
      //--- Конвертируем RGB-компоненты в LAB-компоненты
      m_clr.RGBtoXYZ(m_rgb_r,m_rgb_g,m_rgb_b,m_xyz_x,m_xyz_y,m_xyz_z);
      m_clr.XYZtoCIELab(m_xyz_x,m_xyz_y,m_xyz_z,m_lab_l,m_lab_a,m_lab_b);
      //--- Установим цвета в поля ввода
      SetControls(m_radio_buttons.SelectedButtonIndex(),true);
      return;
     }
//--- Установка параметров цветовых моделей
   switch(index)
     {
      case 0 : case 1 : case 2 :
         SetHSL();
         break;
      case 3 : case 4 : case 5 :
         SetRGB();
         break;
      case 6 : case 7 : case 8 :
         SetLab();
         break;
     }
//--- Нарисовать палитру относительно выделенной радио-кнопки
   DrawPalette(m_radio_buttons.SelectedButtonIndex());
  }
//+------------------------------------------------------------------+
//| Установка текущих параметров в поля ввода                        |
//+------------------------------------------------------------------+
void CColorPicker::SetControls(const int index,const bool fix_selected)
  {
//--- Если нужно зафиксировать значение в поле ввода выделенной радио-кнопки
   if(fix_selected)
     {
      //--- Компоненты HSL
      if(index!=0)
         m_hsl_h_edit.ChangeValue(m_hsl_h);
      if(index!=1)
         m_hsl_s_edit.ChangeValue(m_hsl_s);
      if(index!=2)
         m_hsl_l_edit.ChangeValue(m_hsl_l);
      //--- Компоненты RGB
      if(index!=3)
         m_rgb_r_edit.ChangeValue(m_rgb_r);
      if(index!=4)
         m_rgb_g_edit.ChangeValue(m_rgb_g);
      if(index!=5)
         m_rgb_b_edit.ChangeValue(m_rgb_b);
      //--- Компоненты Lab
      if(index!=6)
         m_lab_l_edit.ChangeValue(m_lab_l);
      if(index!=7)
         m_lab_a_edit.ChangeValue(m_lab_a);
      if(index!=8)
         m_lab_b_edit.ChangeValue(m_lab_b);
      return;
     }
//--- Если нужно скорректировать значения в полях ввода всех цветовых моделей
   m_hsl_h_edit.ChangeValue(m_hsl_h);
   m_hsl_s_edit.ChangeValue(m_hsl_s);
   m_hsl_l_edit.ChangeValue(m_hsl_l);
//---
   m_rgb_r_edit.ChangeValue(m_rgb_r);
   m_rgb_g_edit.ChangeValue(m_rgb_g);
   m_rgb_b_edit.ChangeValue(m_rgb_b);
//---
   m_lab_l_edit.ChangeValue(m_lab_l);
   m_lab_a_edit.ChangeValue(m_lab_a);
   m_lab_b_edit.ChangeValue(m_lab_b);
  }
//+------------------------------------------------------------------+
//| Установка параметров цветовых моделей относительно HSL           |
//+------------------------------------------------------------------+
void CColorPicker::SetHSL(void)
  {
//--- Получим текущие значения компонентов HSL
   m_hsl_h=m_hsl_h_edit.GetValue();
   m_hsl_s=m_hsl_s_edit.GetValue();
   m_hsl_l=m_hsl_l_edit.GetValue();
//--- Конвертация HSL-компонент в RGB-компоненты
   m_clr.HSLtoRGB(m_hsl_h/360.0,m_hsl_s/100.0,m_hsl_l/100.0,m_rgb_r,m_rgb_g,m_rgb_b);
//--- Конвертация RGB-компонент в Lab-компоненты
   m_clr.RGBtoXYZ(m_rgb_r,m_rgb_g,m_rgb_b,m_xyz_x,m_xyz_y,m_xyz_z);
   m_clr.XYZtoCIELab(m_xyz_x,m_xyz_y,m_xyz_z,m_lab_l,m_lab_a,m_lab_b);
//--- Установка текущих параметров в поля ввода
   SetControls(0,false);
  }
//+------------------------------------------------------------------+
//| Установка параметров цветовых моделей относительно RGB           |
//+------------------------------------------------------------------+
void CColorPicker::SetRGB(void)
  {
//--- Получим текущие значения компонентов RGB
   m_rgb_r=m_rgb_r_edit.GetValue();
   m_rgb_g=m_rgb_g_edit.GetValue();
   m_rgb_b=m_rgb_b_edit.GetValue();
//--- Конвертация RGB-компонент в HSL-компоненты
   m_clr.RGBtoHSL(m_rgb_r,m_rgb_g,m_rgb_b,m_hsl_h,m_hsl_s,m_hsl_l);
//--- Корректировка компонент HSL
   AdjustmentComponentHSL();
//--- Конвертация RGB-компонент в Lab-компоненты
   m_clr.RGBtoXYZ(m_rgb_r,m_rgb_g,m_rgb_b,m_xyz_x,m_xyz_y,m_xyz_z);
   m_clr.XYZtoCIELab(m_xyz_x,m_xyz_y,m_xyz_z,m_lab_l,m_lab_a,m_lab_b);
//--- Установка текущих параметров в поля ввода
   SetControls(0,false);
  }
//+------------------------------------------------------------------+
//| Установка параметров цветовых моделей относительно Lab           |
//+------------------------------------------------------------------+
void CColorPicker::SetLab(void)
  {
//--- Получим текущие значения компонентов Lab
   m_lab_l=m_lab_l_edit.GetValue();
   m_lab_a=m_lab_a_edit.GetValue();
   m_lab_b=m_lab_b_edit.GetValue();
//--- Конвертация Lab-компонент в RGB-компоненты
   m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
   m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
//--- Корректировка компонент RGB
   AdjustmentComponentRGB();
//--- Конвертация RGB-компонент в HSL-компоненты
   m_clr.RGBtoHSL(m_rgb_r,m_rgb_g,m_rgb_b,m_hsl_h,m_hsl_s,m_hsl_l);
//--- Корректировка компонент HSL
   AdjustmentComponentHSL();
//--- Установка текущих параметров в поля ввода
   SetControls(0,false);
  }
//+------------------------------------------------------------------+
//| Корректировка компонент RGB                                      |
//+------------------------------------------------------------------+
void CColorPicker::AdjustmentComponentRGB(void)
  {
   m_rgb_r=::fmin(::fmax(m_rgb_r,0),255);
   m_rgb_g=::fmin(::fmax(m_rgb_g,0),255);
   m_rgb_b=::fmin(::fmax(m_rgb_b,0),255);
  }
//+------------------------------------------------------------------+
//| Корректировка компонент HSL                                      |
//+------------------------------------------------------------------+
void CColorPicker::AdjustmentComponentHSL(void)
  {
   m_hsl_h*=360;
   m_hsl_s*=100;
   m_hsl_l*=100;
  }
//+------------------------------------------------------------------+
//| Ускоренная промотка значения в поле ввода                        |
//+------------------------------------------------------------------+
void CColorPicker::FastSwitching(void)
  {
//--- Выйдем, если нет фокуса на элементе
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
      //--- Определение активированного счётчика у активированной радио-кнопки
      int index=WRONG_VALUE;
      if(m_radio_buttons.SelectedButtonIndex()==0 && (m_hsl_h_edit.StateInc() || m_hsl_h_edit.StateDec()))
         index=0;
      else if(m_radio_buttons.SelectedButtonIndex()==1 && (m_hsl_s_edit.StateInc() || m_hsl_s_edit.StateDec()))
         index=1;
      else if(m_radio_buttons.SelectedButtonIndex()==2 && (m_hsl_l_edit.StateInc() || m_hsl_l_edit.StateDec()))
         index=2;
      else if(m_radio_buttons.SelectedButtonIndex()==3 && (m_rgb_r_edit.StateInc() || m_rgb_r_edit.StateDec()))
         index=3;
      else if(m_radio_buttons.SelectedButtonIndex()==4 && (m_rgb_g_edit.StateInc() || m_rgb_g_edit.StateDec()))
         index=4;
      else if(m_radio_buttons.SelectedButtonIndex()==5 && (m_rgb_b_edit.StateInc() || m_rgb_b_edit.StateDec()))
         index=5;
      else if(m_radio_buttons.SelectedButtonIndex()==6 && (m_lab_l_edit.StateInc() || m_lab_l_edit.StateDec()))
         index=6;
      else if(m_radio_buttons.SelectedButtonIndex()==7 && (m_lab_a_edit.StateInc() || m_lab_a_edit.StateDec()))
         index=7;
      else if(m_radio_buttons.SelectedButtonIndex()==8 && (m_lab_b_edit.StateInc() || m_lab_b_edit.StateDec()))
         index=8;
      //--- Если есть, обновим палитру
      if(index!=WRONG_VALUE)
         DrawPalette(index);
      //--- Определение активированного счётчика
      index=WRONG_VALUE;
      if(m_hsl_h_edit.StateInc() || m_hsl_h_edit.StateDec())
         index=0;
      else if(m_hsl_s_edit.StateInc() || m_hsl_s_edit.StateDec())
         index=1;
      else if(m_hsl_l_edit.StateInc() || m_hsl_l_edit.StateDec())
         index=2;
      else if(m_rgb_r_edit.StateInc() || m_rgb_r_edit.StateDec())
         index=3;
      else if(m_rgb_g_edit.StateInc() || m_rgb_g_edit.StateDec())
         index=4;
      else if(m_rgb_b_edit.StateInc() || m_rgb_b_edit.StateDec())
         index=5;
      else if(m_lab_l_edit.StateInc() || m_lab_l_edit.StateDec())
         index=6;
      else if(m_lab_a_edit.StateInc() || m_lab_a_edit.StateDec())
         index=7;
      else if(m_lab_b_edit.StateInc() || m_lab_b_edit.StateDec())
         index=8;
      //--- Если есть, пересчитаем компоненты всех цветовых моделей и обновим палитру
      if(index!=WRONG_VALUE)
         SetComponents(index,false);
     }
  }
//+------------------------------------------------------------------+
