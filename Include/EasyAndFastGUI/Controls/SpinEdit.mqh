//+------------------------------------------------------------------+
//|                                                     SpinEdit.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Класс для создания поля ввода                                    |
//+------------------------------------------------------------------+
class CSpinEdit : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания поля ввода
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_edit;
   CBmpLabel         m_spin_inc;
   CBmpLabel         m_spin_dec;
   //--- Цвет фона элемента
   color             m_area_color;
   //--- Текст описания поля ввода
   string            m_label_text;
   //--- Отступы текстовой метки
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Цвета текста в разных состояниях
   color             m_label_color;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- Текущее значение в поле ввода
   double            m_edit_value;
   //--- Размеры поля ввода
   int               m_edit_x_size;
   int               m_edit_y_size;
   //--- Отступ поля ввода от правого края
   int               m_edit_x_gap;
   //--- Цвета поля ввода и текста поля ввода в разных состояниях
   color             m_edit_color;
   color             m_edit_color_locked;
   color             m_edit_text_color;
   color             m_edit_text_color_locked;
   color             m_edit_text_color_highlight;
   //--- Цвета рамки поля ввода в разных состояниях
   color             m_edit_border_color;
   color             m_edit_border_color_hover;
   color             m_edit_border_color_locked;
   color             m_edit_border_color_array[];
   //--- Ярлыки переключателей в активном и заблокированном состоянии
   string            m_inc_bmp_file_on;
   string            m_inc_bmp_file_off;
   string            m_inc_bmp_file_locked;
   string            m_dec_bmp_file_on;
   string            m_dec_bmp_file_off;
   string            m_dec_bmp_file_locked;
   //--- Отступы кнопок (от правого края)
   int               m_inc_x_gap;
   int               m_inc_y_gap;
   int               m_dec_x_gap;
   int               m_dec_y_gap;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_area_zorder;
   int               m_label_zorder;
   int               m_edit_zorder;
   int               m_spin_zorder;
   //--- Состояние элемента (доступен/заблокирован)
   bool              m_spin_edit_state;
   //--- Режим сброса значения до минимального
   bool              m_reset_mode;
   //--- Минимальное/максимальное значение
   double            m_min_value;
   double            m_max_value;
   //--- Шаг для изменения значения в поле ввода
   double            m_step_value;
   //--- Режим выравнивания текста
   ENUM_ALIGN_MODE   m_align_mode;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //--- Количество знаков после запятой
   int               m_digits;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //---
public:
                     CSpinEdit(void);
                    ~CSpinEdit(void);
   //--- Методы для создания поля ввода
   bool              CreateSpinEdit(const long chart_id,const int subwin,const string label_text,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateEdit(void);
   bool              CreateSpinInc(void);
   bool              CreateSpinDec(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращение/установка состояния доступности поля ввода
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);         }
   bool              SpinEditState(void)                      const { return(m_spin_edit_state);          }
   void              SpinEditState(const bool state);
   //--- (1) Цвет фона, (2) текст описания поля ввода, (3) отступы текстовой метки
   void              AreaColor(const color clr)                     { m_area_color=clr;                   }
   string            LabelText(void)                          const { return(m_label.Description());      }
   void              LabelXGap(const int x_gap)                     { m_label_x_gap=x_gap;                }
   void              LabelYGap(const int y_gap)                     { m_label_y_gap=y_gap;                }
   //--- Цвета текстовой метки в разных состояниях
   void              LabelColor(const color clr)                    { m_label_color=clr;                  }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;            }
   void              LabelColorLocked(const color clr)              { m_label_color_locked=clr;           }
   //--- (1) Размеры поля ввода, (2) отступ поля ввода от правого края
   void              EditXSize(const int x_size)                    { m_edit_x_size=x_size;               }
   void              EditYSize(const int y_size)                    { m_edit_y_size=y_size;               }
   void              EditXGap(const int x_gap)                      { m_edit_x_gap=x_gap;                 }
   //--- Цвета поля ввода в разных состояниях
   void              EditColor(const color clr)                     { m_edit_color=clr;                   }
   void              EditColorLocked(const color clr)               { m_edit_color_locked=clr;            }
   //--- Цвета текста поля ввода в разных состояниях
   void              EditTextColor(const color clr)                 { m_edit_text_color=clr;              }
   void              EditTextColorLocked(const color clr)           { m_edit_text_color_locked=clr;       }
   void              EditTextColorHighlight(const color clr)        { m_edit_text_color_highlight=clr;    }
   //--- Цвета рамки поля ввода в разных состояниях
   void              EditBorderColor(const color clr)               { m_edit_border_color=clr;            }
   void              EditBorderColorHover(const color clr)          { m_edit_border_color_hover=clr;      }
   void              EditBorderColorLocked(const color clr)         { m_edit_border_color_locked=clr;     }
   //--- Установка ярлыков для кнопки в активном и заблокированном состояниях
   void              IncFileOn(const string file_path)              { m_inc_bmp_file_on=file_path;        }
   void              IncFileOff(const string file_path)             { m_inc_bmp_file_off=file_path;       }
   void              IncFileLocked(const string file_path)          { m_inc_bmp_file_locked=file_path;    }
   void              DecFileOn(const string file_path)              { m_dec_bmp_file_on=file_path;        }
   void              DecFileOff(const string file_path)             { m_dec_bmp_file_off=file_path;       }
   void              DecFileLocked(const string file_path)          { m_dec_bmp_file_locked=file_path;    }
   //--- Отступы для кнопок поля ввода
   void              IncXGap(const int x_gap)                       { m_inc_x_gap=x_gap;                  }
   void              IncYGap(const int y_gap)                       { m_inc_y_gap=y_gap;                  }
   void              DecXGap(const int x_gap)                       { m_dec_x_gap=x_gap;                  }
   void              DecYGap(const int y_gap)                       { m_dec_y_gap=y_gap;                  }
   //--- Состояние кнопок поля ввода
   bool              StateInc(void)                           const { return(m_spin_inc.State());         }
   bool              StateDec(void)                           const { return(m_spin_dec.State());         }
   //--- Режим сброса при нажатии на текстовой метке
   bool              ResetMode(void)                                { return(m_reset_mode);               }
   void              ResetMode(const bool mode)                     { m_reset_mode=mode;                  }
   //--- Минимальное значение
   double            MinValue(void)                           const { return(m_min_value);                }
   void              MinValue(const double value)                   { m_min_value=value;                  }
   //--- Максимальное значение
   double            MaxValue(void)                           const { return(m_max_value);                }
   void              MaxValue(const double value)                   { m_max_value=value;                  }
   //--- Шаг значения
   double            StepValue(void)                          const { return(m_step_value);               }
   void              StepValue(const double value)                  { m_step_value=(value<=0)? 1 : value; }
   //--- (1) Количество знаков после запятой, (2) режим выравнивания текста, (3) возвращение и установка значения поля ввода
   void              SetDigits(const int digits)                    { m_digits=::fabs(digits);            }
   void              AlignMode(ENUM_ALIGN_MODE mode)                { m_align_mode=mode;                  }
   double            GetValue(void)                           const { return(m_edit_value);               }
   bool              SetValue(const double value);
   //--- Изменение значения в поле ввода
   void              ChangeValue(const double value);
   //--- Изменение цвета объектов
   void              ChangeObjectsColor(void);
   //--- Подмигивание при достижении лимита
   void              HighlightLimit(void);
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
   //--- Обработка нажатия на текстовую метку
   bool              OnClickLabel(const string clicked_object);
   //--- Обработка ввода значения в поле ввода
   bool              OnEndEdit(const string edited_object);
   //--- Обработка нажатия кнопки поля ввода
   bool              OnClickSpinInc(const string clicked_object);
   bool              OnClickSpinDec(const string clicked_object);
   //--- Ускоренная перемотка значений в поле ввода
   void              FastSwitching(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CSpinEdit::CSpinEdit(void) : m_digits(2),
                             m_edit_value(WRONG_VALUE),
                             m_min_value(DBL_MIN),
                             m_max_value(DBL_MAX),
                             m_step_value(1),
                             m_reset_mode(false),
                             m_align_mode(ALIGN_LEFT),
                             m_spin_edit_state(true),
                             m_timer_counter(SPIN_DELAY_MSC),
                             m_area_color(C'15,15,15'),
                             m_label_x_gap(0),
                             m_label_y_gap(2),
                             m_label_color(clrWhite),
                             m_label_color_hover(C'85,170,255'),
                             m_label_color_locked(clrGray),
                             m_edit_y_size(18),
                             m_edit_x_gap(15),
                             m_edit_color(clrWhite),
                             m_edit_color_locked(clrDimGray),
                             m_edit_text_color(clrBlack),
                             m_edit_text_color_locked(clrGray),
                             m_edit_text_color_highlight(clrRed),
                             m_edit_border_color(clrGray),
                             m_edit_border_color_hover(C'85,170,255'),
                             m_edit_border_color_locked(clrGray),
                             m_inc_x_gap(16),
                             m_inc_y_gap(0),
                             m_dec_x_gap(16),
                             m_dec_y_gap(8),
                             m_inc_bmp_file_on(""),
                             m_inc_bmp_file_off(""),
                             m_inc_bmp_file_locked(""),
                             m_dec_bmp_file_on(""),
                             m_dec_bmp_file_off(""),
                             m_dec_bmp_file_locked("")

  {
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_area_zorder  =1;
   m_label_zorder =0;
   m_edit_zorder  =2;
   m_spin_zorder  =3;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSpinEdit::~CSpinEdit(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработка событий                                                |
//+------------------------------------------------------------------+
void CSpinEdit::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- Проверка фокуса над элементами
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_spin_inc.MouseFocus(x>m_spin_inc.X() && x<m_spin_inc.X2() && y>m_spin_inc.Y() && y<m_spin_inc.Y2());
      m_spin_dec.MouseFocus(x>m_spin_dec.X() && x<m_spin_dec.X2() && y>m_spin_dec.Y() && y<m_spin_dec.Y2());
      return;
     }
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Выйти, если элемент заблокирован
      if(!m_spin_edit_state)
         return;
      //--- Обработка нажатия на текстовую метку
      if(OnClickLabel(sparam))
         return;
      //--- Обработка нажатия кнопок поля ввода
      if(OnClickSpinInc(sparam))
         return;
      if(OnClickSpinDec(sparam))
         return;
      //---
      return;
     }
//--- Обработка события изменения значения в поле ввода
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      //--- Выйти, если элемент заблокирован
      if(!m_spin_edit_state)
         return;
      //--- Обработка ввода значения
      if(OnEndEdit(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CSpinEdit::OnEventTimer(void)
  {
//--- Если элемент выпадающий
   if(CElement::IsDropdown())
     {
      ChangeObjectsColor();
      FastSwitching();
     }
   else
     {
      //--- Отслеживаем изменение цвета и перемотку значений, 
      //    только если форма не заблокирована
      if(!m_wnd.IsLocked())
        {
         ChangeObjectsColor();
         FastSwitching();
        }
     }
  }
//+------------------------------------------------------------------+
//| Создаёт группу объектов редактируемого поля ввода                |
//+------------------------------------------------------------------+
bool CSpinEdit::CreateSpinEdit(const long chart_id,const int subwin,const string label_text,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием поля ввода классу нужно передать "
              "указатель на форму: CSpinEdit::WindowPointer(CWindow &object)");
      return(false);
     }
//--- Инициализация переменных
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =x;
   m_y          =y;
   m_label_text =label_text;
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание элемента
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateEdit())
      return(false);
   if(!CreateSpinInc())
      return(false);
   if(!CreateSpinDec())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт площадь редактируемого поля ввода                        |
//+------------------------------------------------------------------+
bool CSpinEdit::CreateArea(void)
  {
//--- Формирование имени объекта
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_area_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_area_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Установим объект
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Установим свойства
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Отступы от крайней точки
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт лэйбл редактируемого поля ввода                          |
//+------------------------------------------------------------------+
bool CSpinEdit::CreateLabel(void)
  {
//--- Формирование имени объекта
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_lable_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_lable_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x=CElement::X()+m_label_x_gap;
   int y=CElement::Y()+m_label_y_gap;
//--- Установим объект
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_label.Description(m_label_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(m_label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_label_zorder);
   m_label.Tooltip("\n");
//--- Отступы от крайней точки
   m_label.XGap(x-m_wnd.X());
   m_label.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода с переключателями                             |
//+------------------------------------------------------------------+
bool CSpinEdit::CreateEdit(void)
  {
//--- Формирование имени объекта
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_edit_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_edit_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X2()-m_edit_x_size-m_edit_x_gap;
   int y =CElement::Y()-1;
//--- Установим объект
   if(!m_edit.Create(m_chart_id,name,m_subwin,x,y,m_edit_x_size,m_edit_y_size))
      return(false);
//--- Установим свойства
   m_edit.Font(FONT);
   m_edit.FontSize(FONT_SIZE);
   m_edit.TextAlign(m_align_mode);
   m_edit.Description(::DoubleToString(m_edit_value,m_digits));
   m_edit.Color(m_edit_text_color);
   m_edit.BackColor(m_edit_color);
   m_edit.BorderColor(m_edit_border_color);
   m_edit.Corner(m_corner);
   m_edit.Anchor(m_anchor);
   m_edit.Selectable(false);
   m_edit.Z_Order(m_edit_zorder);
   m_edit.Tooltip("\n");
//--- Сохраним координаты
   m_edit.X(x);
   m_edit.Y(y);
//--- Отступы от крайней точки
   m_edit.XGap(x-m_wnd.X());
   m_edit.YGap(y-m_wnd.Y());
//--- Инициализация массива градиента
   CElement::InitColorArray(m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
//--- Сохраним указатель объекта
   CElement::AddToArray(m_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт переключатель вверх                                      |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinInc_blue.bmp"
//---
bool CSpinEdit::CreateSpinInc(void)
  {
//--- Формирование имени объекта
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_spin_inc_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_spin_inc_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X2()-m_inc_x_gap;
   int y =CElement::Y()+m_inc_y_gap;
//--- Если не указали картинки для переключателя, значит установка по умолчанию
   if(m_inc_bmp_file_on=="")
      m_inc_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\SpinInc_blue.bmp";
   if(m_inc_bmp_file_off=="")
      m_inc_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp";
   if(m_inc_bmp_file_locked=="")
      m_inc_bmp_file_locked="Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp";
//--- Установим объект
   if(!m_spin_inc.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_spin_inc.BmpFileOn("::"+m_inc_bmp_file_on);
   m_spin_inc.BmpFileOff("::"+m_inc_bmp_file_off);
   m_spin_inc.Corner(m_corner);
   m_spin_inc.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_spin_inc.Selectable(false);
   m_spin_inc.Z_Order(m_spin_zorder);
   m_spin_inc.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_spin_inc.XSize(m_spin_inc.X_Size());
   m_spin_inc.YSize(m_spin_inc.Y_Size());
//--- Сохраним координаты
   m_spin_inc.X(x);
   m_spin_inc.Y(y);
//--- Отступы от крайней точки
   m_spin_inc.XGap(x-m_wnd.X());
   m_spin_inc.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_spin_inc);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт переключатель вниз                                       |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinDec_blue.bmp"
//---
bool CSpinEdit::CreateSpinDec(void)
  {
//--- Формирование имени объекта
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElement::ProgramName()+"_spinedit_spin_dec_"+(string)CElement::Id();
   else
      name=CElement::ProgramName()+"_spinedit_spin_dec_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X2()-m_dec_x_gap;
   int y =CElement::Y()+m_dec_y_gap;
//--- Если не указали картинки для переключателя, значит установка по умолчанию
   if(m_dec_bmp_file_on=="")
      m_dec_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\SpinDec_blue.bmp";
   if(m_dec_bmp_file_off=="")
      m_dec_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp";
   if(m_dec_bmp_file_locked=="")
      m_dec_bmp_file_locked="Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp";
//--- Установим объект
   if(!m_spin_dec.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Установим свойства
   m_spin_dec.BmpFileOn("::"+m_dec_bmp_file_on);
   m_spin_dec.BmpFileOff("::"+m_dec_bmp_file_off);
   m_spin_dec.Corner(m_corner);
   m_spin_dec.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_spin_dec.Selectable(false);
   m_spin_dec.Z_Order(m_spin_zorder);
   m_spin_dec.Tooltip("\n");
//--- Сохраним размеры (в объекте)
   m_spin_dec.XSize(m_spin_dec.X_Size());
   m_spin_dec.YSize(m_spin_dec.Y_Size());
//--- Сохраним координаты
   m_spin_dec.X(x);
   m_spin_dec.Y(y);
//--- Отступы от крайней точки
   m_spin_dec.XGap(x-m_wnd.X());
   m_spin_dec.YGap(y-m_wnd.Y());
//--- Сохраним указатель объекта
   CElement::AddToArray(m_spin_dec);
   return(true);
  }
//+------------------------------------------------------------------+
//| Изменение значения в поле ввода                                  |
//+------------------------------------------------------------------+
void CSpinEdit::ChangeValue(const double value)
  {
//--- Проверим, скорректируем и запомним новое значение
   SetValue(value);
//--- Установим новое значение в поле ввода
   m_edit.Description(::DoubleToString(GetValue(),m_digits));
  }
//+------------------------------------------------------------------+
//| Проверка текущего значения                                       |
//+------------------------------------------------------------------+
bool CSpinEdit::SetValue(double value)
  {
//--- Для корректировки
   double corrected_value =0.0;
//--- Скорректируем с учетом шага
   corrected_value=::MathRound(value/m_step_value)*m_step_value;
//--- Проверка на минимум/максимум
   if(corrected_value<m_min_value)
     {
      //--- Установить минимальное значение
      corrected_value=m_min_value;
      //--- Установим состояние On
      m_spin_dec.State(true);
      //--- Подмигнуть, сообщив этим о достижении лимита
      HighlightLimit();
     }
   if(corrected_value>m_max_value)
     {
      //--- Установить максимальное значение
      corrected_value=m_max_value;
      //--- Установим состояние On
      m_spin_inc.State(true);
      //--- Подмигнуть, сообщив этим о достижении лимита
      HighlightLimit();
     }
//--- Если значение было изменено
   if(m_edit_value!=corrected_value)
     {
      m_edit_value=corrected_value;
      m_edit.Color(m_edit_text_color);
      return(true);
     }
//--- Значение без изменений
   return(false);
  }
//+------------------------------------------------------------------+
//| Подсвечивание лимита                                             |
//+------------------------------------------------------------------+
void CSpinEdit::HighlightLimit(void)
  {
//--- Временно изменить цвет текста
   m_edit.Color(m_edit_text_color_highlight);
//--- Обновить
   ::ChartRedraw();
//--- Задержка перед возвращением к исходному цвету
   ::Sleep(100);
//--- Изменить цвет текста на исходный
   m_edit.Color(m_edit_text_color);
  }
//+------------------------------------------------------------------+
//| Установка состояния элемента                                     |
//+------------------------------------------------------------------+
void CSpinEdit::SpinEditState(const bool state)
  {
   m_spin_edit_state=state;
//--- Цвет текстовой метки
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- Цвет поля ввода
   m_edit.Color((state)? m_edit_text_color : m_edit_text_color_locked);
   m_edit.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_edit.BorderColor((state)? m_edit_border_color : m_edit_border_color_locked);
//--- Картинка переключателей
   m_spin_inc.BmpFileOn((state)? "::"+m_inc_bmp_file_on : "::"+m_inc_bmp_file_locked);
   m_spin_dec.BmpFileOn((state)? "::"+m_dec_bmp_file_on : "::"+m_dec_bmp_file_locked);
//--- Настройка относительно текущего состояния
   if(!m_spin_edit_state)
     {
      //--- Приоритеты
      m_edit.Z_Order(-1);
      m_spin_inc.Z_Order(-1);
      m_spin_dec.Z_Order(-1);
      //--- Поле ввода в режим "Только чтение"
      m_edit.ReadOnly(true);
     }
   else
     {
      //--- Приоритеты
      m_edit.Z_Order(m_edit_zorder);
      m_spin_inc.Z_Order(m_spin_zorder);
      m_spin_dec.Z_Order(m_spin_zorder);
      //--- Поле ввода в режим редактирования
      m_edit.ReadOnly(false);
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CSpinEdit::ChangeObjectsColor(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_spin_edit_state)
      return;
//--- Фокус на кнопках
   m_spin_inc.State(m_spin_inc.MouseFocus());
   m_spin_dec.State(m_spin_dec.MouseFocus());
//--- Фокус на текстовой метке и поле ввода
   CElement::ChangeObjectColor(m_label.Name(),CElement::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElement::ChangeObjectColor(m_edit.Name(),CElement::MouseFocus(),OBJPROP_BORDER_COLOR,m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CSpinEdit::Moving(const int x,const int y)
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
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_edit.X(x+m_edit.XGap());
   m_edit.Y(y+m_edit.YGap());
   m_spin_inc.X(x+m_spin_inc.XGap());
   m_spin_inc.Y(y+m_spin_inc.YGap());
   m_spin_dec.X(x+m_spin_dec.XGap());
   m_spin_dec.Y(y+m_spin_dec.YGap());
//--- Обновление координат графических объектов
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_edit.X_Distance(m_edit.X());
   m_edit.Y_Distance(m_edit.Y());
   m_spin_inc.X_Distance(m_spin_inc.X());
   m_spin_inc.Y_Distance(m_spin_inc.Y());
   m_spin_dec.X_Distance(m_spin_dec.X());
   m_spin_dec.Y_Distance(m_spin_dec.Y());
  }
//+------------------------------------------------------------------+
//| Показывает комбо-бокс                                            |
//+------------------------------------------------------------------+
void CSpinEdit::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElement::IsVisible())
      return;
//--- Сделать видимыми все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает комбо-бокс                                              |
//+------------------------------------------------------------------+
void CSpinEdit::Hide(void)
  {
//--- Выйти, если элемент уже видим
   if(!CElement::IsVisible())
      return;
//--- Скрыть все объекты
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CSpinEdit::Reset(void)
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
void CSpinEdit::Delete(void)
  {
//--- Удаление объектов
   m_area.Delete();
   m_label.Delete();
   m_edit.Delete();
   m_spin_inc.Delete();
   m_spin_dec.Delete();
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Инициализация переменных значениями по умолчанию
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CSpinEdit::SetZorders(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_spin_edit_state)
      return;
//--- Установить приоритеты
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_label_zorder);
   m_edit.Z_Order(m_edit_zorder);
   m_spin_inc.Z_Order(m_spin_zorder);
   m_spin_dec.Z_Order(m_spin_zorder);
//--- Поле ввода в режим редактирования
   m_edit.ReadOnly(false);
//--- Восстановить картинки в переключателях
   m_spin_inc.BmpFileOn("::"+m_inc_bmp_file_on);
   m_spin_dec.BmpFileOn("::"+m_dec_bmp_file_on);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CSpinEdit::ResetZorders(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_spin_edit_state)
      return;
//--- Сбросить приоритеты
   m_area.Z_Order(-1);
   m_label.Z_Order(-1);
   m_edit.Z_Order(-1);
   m_spin_inc.Z_Order(-1);
   m_spin_dec.Z_Order(-1);
//--- Поле ввода в режим "Только чтение"
   m_edit.ReadOnly(true);
//--- Заменить картинки в переключателях
   m_spin_inc.BmpFileOn("::"+m_inc_bmp_file_off);
   m_spin_dec.BmpFileOn("::"+m_dec_bmp_file_off);
  }
//+------------------------------------------------------------------+
//| Сброс цвета объектов элемента                                    |
//+------------------------------------------------------------------+
void CSpinEdit::ResetColors(void)
  {
//--- Выйти, если элемент заблокирован
   if(!m_spin_edit_state)
      return;
//--- Сбросить цвет
   m_label.Color(m_label_color);
   m_edit.BorderColor(m_edit_border_color);
//--- Обнулим фокус
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на текстовую метку                             |
//+------------------------------------------------------------------+
bool CSpinEdit::OnClickLabel(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта
   if(m_area.Name()!=clicked_object)
      return(false);
//--- Если включен режим сброса значения
   if(m_reset_mode)
     {
      //--- Установим минимальное значение
      ChangeValue(MinValue());
     }
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка ввода значения в поле ввода                            |
//+------------------------------------------------------------------+
bool CSpinEdit::OnEndEdit(const string edited_object)
  {
//--- Выйдем, если чужое имя объекта
   if(m_edit.Name()!=edited_object)
      return(false);
//--- Получим введённое значение
   double entered_value=::StringToDouble(m_edit.Description());
//--- Проверим, скорректируем и запомним новое значение
   ChangeValue(entered_value);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_END_EDIT,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на переключатель инкремента                              |
//+------------------------------------------------------------------+
bool CSpinEdit::OnClickSpinInc(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта
   if(m_spin_inc.Name()!=clicked_object)
      return(false);
//--- Получим текущее значение
   double value=GetValue();
//--- Увеличим на один шаг и проверим на выход за ограничение
   ChangeValue(value+m_step_value);
//--- Установим состояние On
   m_spin_inc.State(true);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_INC,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на переключатель декремента                              |
//+------------------------------------------------------------------+
bool CSpinEdit::OnClickSpinDec(const string clicked_object)
  {
//--- Выйдем, если чужое имя объекта
   if(m_spin_dec.Name()!=clicked_object)
      return(false);
//--- Получим текущее значение
   double value=GetValue();
//--- Уменьшим на один шаг и проверим на выход за ограничение
   ChangeValue(value-m_step_value);
//--- Установим состояние On
   m_spin_dec.State(true);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_DEC,CElement::Id(),CElement::Index(),m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| Ускоренная промотка значения в поле ввода                        |
//+------------------------------------------------------------------+
void CSpinEdit::FastSwitching(void)
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
      //--- Получим текущее значение в поле ввода
      double current_value =::StringToDouble(m_edit.Description());
      //--- Если увеличить 
      if(m_spin_inc.State())
         SetValue(current_value+m_step_value);
      //--- Если уменьшить
      else if(m_spin_dec.State())
         SetValue(current_value-m_step_value);
      //--- Изменим значение, если кнопка-переключатель всё ещё нажата
      if(m_spin_inc.State() || m_spin_dec.State())
         m_edit.Description(::DoubleToString(GetValue(),m_digits));
     }
  }
//+------------------------------------------------------------------+
