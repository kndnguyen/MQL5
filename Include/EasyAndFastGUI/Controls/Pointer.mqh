//+------------------------------------------------------------------+
//|                                                      Pointer.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
//--- Ресурсы
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_x_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_x_resize_blue.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_y_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_y_resize_blue.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy1_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy1_resize_blue.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy2_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy2_resize_blue.bmp"
//+------------------------------------------------------------------+
//| Класс для создания указателя курсора мыши                        |
//+------------------------------------------------------------------+
class CPointer : public CElement
  {
private:
   //--- Объект для создания элемента
   CBmpLabel         m_pointer_bmp;
   //--- Картинки для указателя
   string            m_file_on;
   string            m_file_off;
   //--- Тип указателя
   ENUM_MOUSE_POINTER m_type;
   //---
public:
                     CPointer(void);
                    ~CPointer(void);
   //--- Создаёт ярлык указателя
   bool              CreatePointer(const long chart_id,const int subwin);
   //--- Установка ярлыков для указателя
   void              FileOn(const string file_path)       { m_file_on=file_path;           }
   void              FileOff(const string file_path)      { m_file_off=file_path;          }
   //--- Возвращение и установка типа указателя
   ENUM_MOUSE_POINTER Type(void)                    const { return(m_type);                }
   void              Type(ENUM_MOUSE_POINTER type)        { m_type=type;                   }
   //--- Возвращение и установка состояния указателя
   bool              State(void)                    const { return(m_pointer_bmp.State()); }
   void              State(const bool state)              { m_pointer_bmp.State(state);    }
   //--- Обновление координат
   void              UpdateX(const int x)                 { m_pointer_bmp.X_Distance(x);   }
   void              UpdateY(const int y)                 { m_pointer_bmp.Y_Distance(y);   }
   //---
public:
   //--- Перемещение элемента
   virtual void      Moving(const int x,const int y);
   //--- (1) Показ, (2) скрытие, (3) сброс, (4) удаление
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //---
private:
   //--- Установка картинок для указателя курсора мыши
   void              SetPointerBmp(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CPointer::CPointer(void) : m_file_on(""),
                           m_file_off(""),
                           m_type(MP_X_RESIZE)
  {
   //--- Значение индекса элемента по умолчанию
   CElement::Index(0);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CPointer::~CPointer(void)
  {
  }
//+------------------------------------------------------------------+
//| Создаёт указатель                                                |
//+------------------------------------------------------------------+
bool CPointer::CreatePointer(const long chart_id,const int subwin)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_pointer_bmp_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- Установка картинок для указателя
   SetPointerBmp();
//--- Создание объекта
   if(!m_pointer_bmp.Create(m_chart_id,name,m_subwin,0,0))
      return(false);
//--- Установка свойств
   m_pointer_bmp.BmpFileOn("::"+m_file_on);
   m_pointer_bmp.BmpFileOff("::"+m_file_off);
   m_pointer_bmp.Corner(m_corner);
   m_pointer_bmp.Selectable(false);
   m_pointer_bmp.Z_Order(0);
   m_pointer_bmp.Tooltip("\n");
//--- Скрыть объект
   m_pointer_bmp.Timeframes(OBJ_NO_PERIODS);
   return(true);
  }
//+------------------------------------------------------------------+
//| Перемещение элемента                                             |
//+------------------------------------------------------------------+
void CPointer::Moving(const int x,const int y)
  {
   UpdateX(x);
   UpdateY(y);
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CPointer::Show(void)
  {
//--- Сделать видимыми все объекты  
   m_pointer_bmp.Timeframes(OBJ_ALL_PERIODS);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CPointer::Hide(void)
  {
//--- Скрыть объекты
   m_pointer_bmp.Timeframes(OBJ_NO_PERIODS);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CPointer::Reset(void)
  {
//--- Скрыть и показать
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CPointer::Delete(void)
  {
   m_pointer_bmp.Delete();
  }
//+------------------------------------------------------------------+
//| Установка картинок для указателя по типу указателя               |
//+------------------------------------------------------------------+
void CPointer::SetPointerBmp(void)
  {
   switch(m_type)
     {
      case MP_X_RESIZE :
         m_file_on  ="Images\\EasyAndFastGUI\\Controls\\pointer_x_resize_blue.bmp";
         m_file_off ="Images\\EasyAndFastGUI\\Controls\\pointer_x_resize.bmp";
         break;
      case MP_Y_RESIZE :
         m_file_on  ="Images\\EasyAndFastGUI\\Controls\\pointer_y_resize_blue.bmp";
         m_file_off ="Images\\EasyAndFastGUI\\Controls\\pointer_y_resize.bmp";
         break;
      case MP_XY1_RESIZE :
         m_file_on  ="Images\\EasyAndFastGUI\\Controls\\pointer_xy1_resize_blue.bmp";
         m_file_off ="Images\\EasyAndFastGUI\\Controls\\pointer_xy1_resize.bmp";
         break;
      case MP_XY2_RESIZE :
         m_file_on  ="Images\\EasyAndFastGUI\\Controls\\pointer_xy2_resize_blue.bmp";
         m_file_off ="Images\\EasyAndFastGUI\\Controls\\pointer_xy2_resize.bmp";
         break;
     }
//--- Если указан пользовательский тип (MP_CUSTOM)
   if(m_file_on=="" || m_file_off=="")
      ::Print(__FUNCTION__," > Для указателя курсора должны быть установлены обе картинки!");
  }
//+------------------------------------------------------------------+
