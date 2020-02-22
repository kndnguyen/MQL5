//+------------------------------------------------------------------+
//|                                                      Element.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Objects.mqh"
//#include "..\Colors.mqh"
//+------------------------------------------------------------------+
//| Базовый класс элемента управления                                |
//+------------------------------------------------------------------+
class CElement
  {
protected:
   //--- Экземпляр класса для работы с цветом
   CColors           m_clr;
   //--- (1) Имя класса и (2) программы, (3) тип программы
   string            m_class_name;
   string            m_program_name;
   ENUM_PROGRAM_TYPE m_program_type;
   //--- Идентификатор и номер окна графика
   long              m_chart_id;
   int               m_subwin;
   //--- Идентификатор и индекс элемента
   int               m_id;
   int               m_index;
   //--- Координаты и границы
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   //--- Размер и отступы
   int               m_x_size;
   int               m_y_size;
   int               m_x_gap;
   int               m_y_gap;
   //--- Состояния элемента
   bool              m_is_visible;
   bool              m_is_dropdown;
   //--- Фокус
   bool              m_mouse_focus;
   //--- Угол графика и точка привязки объектов
   ENUM_BASE_CORNER  m_corner;
   ENUM_ANCHOR_POINT m_anchor;
   //--- Количество цветов в градиенте
   int               m_gradient_colors_total;
   //--- Общий массив указателей на все объекты в элементе управления
   CChartObject     *m_objects[];
   //---
public:
                     CElement(void);
                    ~CElement(void);
   //--- (1) Получения и установка имени класса, (2) получение имени программы, 
   //    (3) получение типа программы, (4) установка номера окна графика
   string            ClassName(void)                    const { return(m_class_name);           }
   void              ClassName(const string class_name)       { m_class_name=class_name;        }
   string            ProgramName(void)                  const { return(m_program_name);         }
   ENUM_PROGRAM_TYPE ProgramType(void)                  const { return(m_program_type);         }
   void              SubwindowNumber(const int number)        { m_subwin=number;                }
   //--- Получение указателя объекта по указанному индексу
   CChartObject     *Object(const int index);
   //--- (1) Получение количества объектов элемента, (2) освобождение массива объектов
   int               ObjectsElementTotal(void)          const { return(::ArraySize(m_objects)); }
   void              FreeObjectsArray(void)                   { ::ArrayFree(m_objects);         }
   //--- Установка и получение идентификатора элемента
   void              Id(const int id)                         { m_id=id;                        }
   int               Id(void)                           const { return(m_id);                   }
   //--- Установка и получение индекса элемента
   void              Index(const int index)                   { m_index=index;                  }
   int               Index(void)                        const { return(m_index);                }
   //--- Координаты и границы
   int               X(void)                            const { return(m_x);                    }
   void              X(const int x)                           { m_x=x;                          }
   int               Y(void)                            const { return(m_y);                    }
   void              Y(const int y)                           { m_y=y;                          }
   int               X2(void)                           const { return(m_x+m_x_size);           }
   int               Y2(void)                           const { return(m_y+m_y_size);           }
   //--- Размер
   int               XSize(void)                        const { return(m_x_size);               }
   void              XSize(const int x_size)                  { m_x_size=x_size;                }
   int               YSize(void)                        const { return(m_y_size);               }
   void              YSize(const int y_size)                  { m_y_size=y_size;                }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)                         const { return(m_x_gap);                }
   void              XGap(const int x_gap)                    { m_x_gap=x_gap;                  }
   int               YGap(void)                         const { return(m_y_gap);                }
   void              YGap(const int y_gap)                    { m_y_gap=y_gap;                  }
   //--- Состояния элемента
   void              IsVisible(const bool flag)               { m_is_visible=flag;              }
   bool              IsVisible(void)                    const { return(m_is_visible);           }
   void              IsDropdown(const bool flag)              { m_is_dropdown=flag;             }
   bool              IsDropdown(void)                   const { return(m_is_dropdown);          }
   //--- (1) Фокус, (2) установка размера градиента
   bool              MouseFocus(void)                   const { return(m_mouse_focus);          }
   void              MouseFocus(const bool focus)             { m_mouse_focus=focus;            }
   void              GradientColorsTotal(const int total)     { m_gradient_colors_total=total;  }
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- Таймер
   virtual void      OnEventTimer(void) {}
   //--- Перемещение элемента
   virtual void      Moving(const int x,const int y) {}
   //--- (1) Показ, (2) скрытие, (3) сброс, (4) удаление
   virtual void      Show(void) {}
   virtual void      Hide(void) {}
   virtual void      Reset(void) {}
   virtual void      Delete(void) {}
   //--- (1) Установка, (2) сброс приоритетов на нажитие левой кнопки мыши
   virtual void      SetZorders(void) {}
   virtual void      ResetZorders(void) {}
   //--- Сброс цвета элемента
   virtual void      ResetColors(void) {}
   //---
protected:
   //--- Метод для добавления указателей объектов-примитивов в общий массив
   void              AddToArray(CChartObject &object);
   //--- Инициализация массива градиента
   void              InitColorArray(const color outer_color,const color hover_color,color &color_array[]);
   //--- Изменение цвета объекта
   void              ChangeObjectColor(const string name,const bool mouse_focus,const ENUM_OBJECT_PROPERTY_INTEGER property,
                                       const color outer_color,const color hover_color,const color &color_array[]);
   //---
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CElement::CElement(void) : m_x(0),
                           m_y(0),
                           m_x2(0),
                           m_y2(0),
                           m_x_size(0),
                           m_y_size(0),
                           m_x_gap(0),
                           m_y_gap(0),
                           m_is_visible(true),
                           m_is_dropdown(false),
                           m_mouse_focus(false),
                           m_id(WRONG_VALUE),
                           m_index(WRONG_VALUE),
                           m_gradient_colors_total(3),
                           m_corner(CORNER_LEFT_UPPER),
                           m_anchor(ANCHOR_LEFT_UPPER),
                           m_program_name(PROGRAM_NAME),
                           m_program_type(PROGRAM_TYPE),
                           m_class_name("")
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CElement::~CElement(void)
  {
  }
//+------------------------------------------------------------------+
//| Возвращает указатель объекта элемента по индексу                 |
//+------------------------------------------------------------------+
CChartObject *CElement::Object(const int index)
  {
   int array_size=::ArraySize(m_objects);
//--- Проверка размера массива объектов
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > В этом элементе ("+m_class_name+") нет объектов!");
      return(NULL);
     }
//--- Корректировка в случае выхода из диапазона
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Вернуть указатель объекта
   return(m_objects[i]);
  }
//+------------------------------------------------------------------+
//| Добавляет указатель на объект в массив                           |
//+------------------------------------------------------------------+
void CElement::AddToArray(CChartObject &object)
  {
   int size=ObjectsElementTotal();
   ::ArrayResize(m_objects,size+1);
   m_objects[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| Инициализация массива градиента                                  |
//+------------------------------------------------------------------+
void CElement::InitColorArray(const color outer_color,const color hover_color,color &color_array[])
  {
//--- Массив цветов градиента
   color colors[2];
   colors[0]=outer_color;
   colors[1]=hover_color;
//--- Формирование массива цветов
   m_clr.Gradient(colors,color_array,m_gradient_colors_total);
  }
//+------------------------------------------------------------------+
//| Изменение цвета объекта при наведении курсора                    |
//+------------------------------------------------------------------+
void CElement::ChangeObjectColor(const string name,const bool mouse_focus,const ENUM_OBJECT_PROPERTY_INTEGER property,
                                 const color outer_color,const color hover_color,const color &color_array[])
  {
   if(::ArraySize(color_array)<1)
      return;
//--- Получим текущий цвет объекта
   color current_color=(color)::ObjectGetInteger(m_chart_id,name,property);
//--- Если курсор над объектом
   if(mouse_focus)
     {
      //--- Выйдем, если уже достигли указанного цвета
      if(current_color==hover_color)
         return;
      //--- Идём от первого к последнему
      for(int i=0; i<m_gradient_colors_total; i++)
        {
         //--- Если цвета не совпадают, перейдём у следующему
         if(color_array[i]!=current_color)
            continue;
         //---
         color new_color=(i+1==m_gradient_colors_total)? color_array[i] : color_array[i+1];
         //--- Изменим цвет
         ::ObjectSetInteger(m_chart_id,name,property,new_color);
         break;
        }
     }
//--- Если курсор вне области объекта
   else
     {
      //--- Выйдем, если уже достигли указанного цвета
      if(current_color==outer_color)
         return;
      //--- Идём от последнего к первому
      for(int i=m_gradient_colors_total-1; i>=0; i--)
        {
         //--- Если цвета не совпадают, перейдём у следующему
         if(color_array[i]!=current_color)
            continue;
         //---
         color new_color=(i-1<0)? color_array[i] : color_array[i-1];
         //--- Изменим цвет
         ::ObjectSetInteger(m_chart_id,name,property,new_color);
         break;
        }
     }
  }
//+------------------------------------------------------------------+
