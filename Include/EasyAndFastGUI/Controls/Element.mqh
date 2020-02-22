//+------------------------------------------------------------------+
//|                                                      Element.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Objects.mqh"
//#include "..\Colors.mqh"
//+------------------------------------------------------------------+
//| ������� ����� �������� ����������                                |
//+------------------------------------------------------------------+
class CElement
  {
protected:
   //--- ��������� ������ ��� ������ � ������
   CColors           m_clr;
   //--- (1) ��� ������ � (2) ���������, (3) ��� ���������
   string            m_class_name;
   string            m_program_name;
   ENUM_PROGRAM_TYPE m_program_type;
   //--- ������������� � ����� ���� �������
   long              m_chart_id;
   int               m_subwin;
   //--- ������������� � ������ ��������
   int               m_id;
   int               m_index;
   //--- ���������� � �������
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   //--- ������ � �������
   int               m_x_size;
   int               m_y_size;
   int               m_x_gap;
   int               m_y_gap;
   //--- ��������� ��������
   bool              m_is_visible;
   bool              m_is_dropdown;
   //--- �����
   bool              m_mouse_focus;
   //--- ���� ������� � ����� �������� ��������
   ENUM_BASE_CORNER  m_corner;
   ENUM_ANCHOR_POINT m_anchor;
   //--- ���������� ������ � ���������
   int               m_gradient_colors_total;
   //--- ����� ������ ���������� �� ��� ������� � �������� ����������
   CChartObject     *m_objects[];
   //---
public:
                     CElement(void);
                    ~CElement(void);
   //--- (1) ��������� � ��������� ����� ������, (2) ��������� ����� ���������, 
   //    (3) ��������� ���� ���������, (4) ��������� ������ ���� �������
   string            ClassName(void)                    const { return(m_class_name);           }
   void              ClassName(const string class_name)       { m_class_name=class_name;        }
   string            ProgramName(void)                  const { return(m_program_name);         }
   ENUM_PROGRAM_TYPE ProgramType(void)                  const { return(m_program_type);         }
   void              SubwindowNumber(const int number)        { m_subwin=number;                }
   //--- ��������� ��������� ������� �� ���������� �������
   CChartObject     *Object(const int index);
   //--- (1) ��������� ���������� �������� ��������, (2) ������������ ������� ��������
   int               ObjectsElementTotal(void)          const { return(::ArraySize(m_objects)); }
   void              FreeObjectsArray(void)                   { ::ArrayFree(m_objects);         }
   //--- ��������� � ��������� �������������� ��������
   void              Id(const int id)                         { m_id=id;                        }
   int               Id(void)                           const { return(m_id);                   }
   //--- ��������� � ��������� ������� ��������
   void              Index(const int index)                   { m_index=index;                  }
   int               Index(void)                        const { return(m_index);                }
   //--- ���������� � �������
   int               X(void)                            const { return(m_x);                    }
   void              X(const int x)                           { m_x=x;                          }
   int               Y(void)                            const { return(m_y);                    }
   void              Y(const int y)                           { m_y=y;                          }
   int               X2(void)                           const { return(m_x+m_x_size);           }
   int               Y2(void)                           const { return(m_y+m_y_size);           }
   //--- ������
   int               XSize(void)                        const { return(m_x_size);               }
   void              XSize(const int x_size)                  { m_x_size=x_size;                }
   int               YSize(void)                        const { return(m_y_size);               }
   void              YSize(const int y_size)                  { m_y_size=y_size;                }
   //--- ������� �� ������� ����� (xy)
   int               XGap(void)                         const { return(m_x_gap);                }
   void              XGap(const int x_gap)                    { m_x_gap=x_gap;                  }
   int               YGap(void)                         const { return(m_y_gap);                }
   void              YGap(const int y_gap)                    { m_y_gap=y_gap;                  }
   //--- ��������� ��������
   void              IsVisible(const bool flag)               { m_is_visible=flag;              }
   bool              IsVisible(void)                    const { return(m_is_visible);           }
   void              IsDropdown(const bool flag)              { m_is_dropdown=flag;             }
   bool              IsDropdown(void)                   const { return(m_is_dropdown);          }
   //--- (1) �����, (2) ��������� ������� ���������
   bool              MouseFocus(void)                   const { return(m_mouse_focus);          }
   void              MouseFocus(const bool focus)             { m_mouse_focus=focus;            }
   void              GradientColorsTotal(const int total)     { m_gradient_colors_total=total;  }
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- ������
   virtual void      OnEventTimer(void) {}
   //--- ����������� ��������
   virtual void      Moving(const int x,const int y) {}
   //--- (1) �����, (2) �������, (3) �����, (4) ��������
   virtual void      Show(void) {}
   virtual void      Hide(void) {}
   virtual void      Reset(void) {}
   virtual void      Delete(void) {}
   //--- (1) ���������, (2) ����� ����������� �� ������� ����� ������ ����
   virtual void      SetZorders(void) {}
   virtual void      ResetZorders(void) {}
   //--- ����� ����� ��������
   virtual void      ResetColors(void) {}
   //---
protected:
   //--- ����� ��� ���������� ���������� ��������-���������� � ����� ������
   void              AddToArray(CChartObject &object);
   //--- ������������� ������� ���������
   void              InitColorArray(const color outer_color,const color hover_color,color &color_array[]);
   //--- ��������� ����� �������
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
//| ���������� ��������� ������� �������� �� �������                 |
//+------------------------------------------------------------------+
CChartObject *CElement::Object(const int index)
  {
   int array_size=::ArraySize(m_objects);
//--- �������� ������� ������� ��������
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > � ���� �������� ("+m_class_name+") ��� ��������!");
      return(NULL);
     }
//--- ������������� � ������ ������ �� ���������
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- ������� ��������� �������
   return(m_objects[i]);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������ � ������                           |
//+------------------------------------------------------------------+
void CElement::AddToArray(CChartObject &object)
  {
   int size=ObjectsElementTotal();
   ::ArrayResize(m_objects,size+1);
   m_objects[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| ������������� ������� ���������                                  |
//+------------------------------------------------------------------+
void CElement::InitColorArray(const color outer_color,const color hover_color,color &color_array[])
  {
//--- ������ ������ ���������
   color colors[2];
   colors[0]=outer_color;
   colors[1]=hover_color;
//--- ������������ ������� ������
   m_clr.Gradient(colors,color_array,m_gradient_colors_total);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CElement::ChangeObjectColor(const string name,const bool mouse_focus,const ENUM_OBJECT_PROPERTY_INTEGER property,
                                 const color outer_color,const color hover_color,const color &color_array[])
  {
   if(::ArraySize(color_array)<1)
      return;
//--- ������� ������� ���� �������
   color current_color=(color)::ObjectGetInteger(m_chart_id,name,property);
//--- ���� ������ ��� ��������
   if(mouse_focus)
     {
      //--- ������, ���� ��� �������� ���������� �����
      if(current_color==hover_color)
         return;
      //--- ��� �� ������� � ����������
      for(int i=0; i<m_gradient_colors_total; i++)
        {
         //--- ���� ����� �� ���������, ������� � ����������
         if(color_array[i]!=current_color)
            continue;
         //---
         color new_color=(i+1==m_gradient_colors_total)? color_array[i] : color_array[i+1];
         //--- ������� ����
         ::ObjectSetInteger(m_chart_id,name,property,new_color);
         break;
        }
     }
//--- ���� ������ ��� ������� �������
   else
     {
      //--- ������, ���� ��� �������� ���������� �����
      if(current_color==outer_color)
         return;
      //--- ��� �� ���������� � �������
      for(int i=m_gradient_colors_total-1; i>=0; i--)
        {
         //--- ���� ����� �� ���������, ������� � ����������
         if(color_array[i]!=current_color)
            continue;
         //---
         color new_color=(i-1<0)? color_array[i] : color_array[i-1];
         //--- ������� ����
         ::ObjectSetInteger(m_chart_id,name,property,new_color);
         break;
        }
     }
  }
//+------------------------------------------------------------------+
