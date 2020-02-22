//+------------------------------------------------------------------+
//|                                                      Objects.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Enums.mqh"
#include "Defines.mqh"
#include "..\Canvas\Charts\LineChart.mqh"
#include <ChartObjects\ChartObjectsBmpControls.mqh>
#include <ChartObjects\ChartObjectsTxtControls.mqh>
//--- Список классов в файле для быстрого перехода (Alt+G)
class CRectLabel;
class CRectCanvas;
class CEdit;
class CLabel;
class CBmpLabel;
class CButton;
class CLineChartObject;
//+------------------------------------------------------------------+
//| Класс с дополнительными свойствами для объекта Rectangle Label   |
//+------------------------------------------------------------------+
class CRectLabel : public CChartObjectRectLabel
  {
protected:
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   int               m_x_gap;
   int               m_y_gap;
   int               m_x_size;
   int               m_y_size;
   bool              m_mouse_focus;
   //---
public:
                     CRectLabel(void);
                    ~CRectLabel(void);
   //--- Координаты
   int               X(void)                      { return(m_x);           }
   void              X(const int x)               { m_x=x;                 }
   int               Y(void)                      { return(m_y);           }
   void              Y(const int y)               { m_y=y;                 }
   int               X2(void)                     { return(m_x+m_x_size);  }
   int               Y2(void)                     { return(m_y+m_y_size);  }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)                   { return(m_x_gap);       }
   void              XGap(const int x_gap)        { m_x_gap=x_gap;         }
   int               YGap(void)                   { return(m_y_gap);       }
   void              YGap(const int y_gap)        { m_y_gap=y_gap;         }
   //--- Размеры
   int               XSize(void)                  { return(m_x_size);      }
   void              XSize(const int x_size)      { m_x_size=x_size;       }
   int               YSize(void)                  { return(m_y_size);      }
   void              YSize(const int y_size)      { m_y_size=y_size;       }
   //--- Фокус
   bool              MouseFocus(void)             { return(m_mouse_focus); }
   void              MouseFocus(const bool focus) { m_mouse_focus=focus;   }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CRectLabel::CRectLabel(void) : m_x(0),
                               m_y(0),
                               m_x2(0),
                               m_y2(0),
                               m_x_gap(0),
                               m_y_gap(0),
                               m_x_size(0),
                               m_y_size(0),
                               m_mouse_focus(false)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CRectLabel::~CRectLabel(void)
  {
  }
//+------------------------------------------------------------------+
//| Класс с дополнительными свойствами для объекта Rectangle Canvas  |
//+------------------------------------------------------------------+
class CRectCanvas : public CCustomCanvas
  {
protected:
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   int               m_x_gap;
   int               m_y_gap;
   int               m_x_size;
   int               m_y_size;
   bool              m_mouse_focus;
   //---
public:
                     CRectCanvas(void);
                    ~CRectCanvas(void);
   //--- Координаты
   int               X(void)                      { return(m_x);           }
   void              X(const int x)               { m_x=x;                 }
   int               Y(void)                      { return(m_y);           }
   void              Y(const int y)               { m_y=y;                 }
   int               X2(void)                     { return(m_x+m_x_size);  }
   int               Y2(void)                     { return(m_y+m_y_size);  }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)                   { return(m_x_gap);       }
   void              XGap(const int x_gap)        { m_x_gap=x_gap;         }
   int               YGap(void)                   { return(m_y_gap);       }
   void              YGap(const int y_gap)        { m_y_gap=y_gap;         }
   //--- Размеры
   int               XSize(void)                  { return(m_x_size);      }
   void              XSize(const int x_size)      { m_x_size=x_size;       }
   int               YSize(void)                  { return(m_y_size);      }
   void              YSize(const int y_size)      { m_y_size=y_size;       }
   //--- Фокус
   bool              MouseFocus(void)             { return(m_mouse_focus); }
   void              MouseFocus(const bool focus) { m_mouse_focus=focus;   }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CRectCanvas::CRectCanvas(void) : m_x(0),
                                 m_y(0),
                                 m_x2(0),
                                 m_y2(0),
                                 m_x_gap(0),
                                 m_y_gap(0),
                                 m_x_size(0),
                                 m_y_size(0),
                                 m_mouse_focus(false)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CRectCanvas::~CRectCanvas(void)
  {
  }
//+------------------------------------------------------------------+
//| Класс с дополнительными свойствами для объекта Edit              |
//+------------------------------------------------------------------+
class CEdit : public CChartObjectEdit
  {
protected:
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   int               m_x_gap;
   int               m_y_gap;
   int               m_x_size;
   int               m_y_size;
   bool              m_mouse_focus;
   //---
public:
                     CEdit(void);
                    ~CEdit(void);
   //--- Координаты
   int               X(void)                      { return(m_x);           }
   void              X(const int x)               { m_x=x;                 }
   int               Y(void)                      { return(m_y);           }
   void              Y(const int y)               { m_y=y;                 }
   int               X2(void)                     { return(m_x+m_x_size);  }
   int               Y2(void)                     { return(m_y+m_y_size);  }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)                   { return(m_x_gap);       }
   void              XGap(const int x_gap)        { m_x_gap=x_gap;         }
   int               YGap(void)                   { return(m_y_gap);       }
   void              YGap(const int y_gap)        { m_y_gap=y_gap;         }
   //--- Размеры
   int               XSize(void)                  { return(m_x_size);      }
   void              XSize(const int x_size)      { m_x_size=x_size;       }
   int               YSize(void)                  { return(m_y_size);      }
   void              YSize(const int y_size)      { m_y_size=y_size;       }
   //--- Фокус
   bool              MouseFocus(void)             { return(m_mouse_focus); }
   void              MouseFocus(const bool focus) { m_mouse_focus=focus;   }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CEdit::CEdit(void) : m_x(0),
                     m_y(0),
                     m_x2(0),
                     m_y2(0),
                     m_x_gap(0),
                     m_y_gap(0),
                     m_x_size(0),
                     m_y_size(0),
                     m_mouse_focus(false)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CEdit::~CEdit(void)
  {
  }
//+------------------------------------------------------------------+
//| Класс с дополнительными свойствами для объекта Label             |
//+------------------------------------------------------------------+
class CLabel : public CChartObjectLabel
  {
protected:
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   int               m_x_gap;
   int               m_y_gap;
   int               m_x_size;
   int               m_y_size;
   //---
public:
                     CLabel(void);
                    ~CLabel(void);
   //--- Координаты
   int               X(void)                 { return(m_x);           }
   void              X(const int x)          { m_x=x;                 }
   int               Y(void)                 { return(m_y);           }
   void              Y(const int y)          { m_y=y;                 }
   int               X2(void)                { return(m_x+m_x_size);  }
   int               Y2(void)                { return(m_y+m_y_size);  }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)              { return(m_x_gap);       }
   void              XGap(const int x_gap)   { m_x_gap=x_gap;         }
   int               YGap(void)              { return(m_y_gap);       }
   void              YGap(const int y_gap)   { m_y_gap=y_gap;         }
   //--- Размеры
   int               XSize(void)             { return(m_x_size);      }
   void              XSize(const int x_size) { m_x_size=x_size;       }
   int               YSize(void)             { return(m_y_size);      }
   void              YSize(const int y_size) { m_y_size=y_size;       }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CLabel::CLabel(void) : m_x(0),
                       m_y(0),
                       m_x2(0),
                       m_y2(0),
                       m_x_gap(0),
                       m_y_gap(0),
                       m_x_size(0),
                       m_y_size(0)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CLabel::~CLabel(void)
  {
  }
//+------------------------------------------------------------------+
//| Класс с дополнительными свойствами для объекта Bmp Label         |
//+------------------------------------------------------------------+
class CBmpLabel : public CChartObjectBmpLabel
  {
protected:
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   int               m_x_gap;
   int               m_y_gap;
   int               m_x_size;
   int               m_y_size;
   bool              m_mouse_focus;
   //---
public:
                     CBmpLabel(void);
                    ~CBmpLabel(void);
   //--- Координаты
   int               X(void)                      { return(m_x);           }
   void              X(const int x)               { m_x=x;                 }
   int               Y(void)                      { return(m_y);           }
   void              Y(const int y)               { m_y=y;                 }
   int               X2(void)                     { return(m_x+m_x_size);  }
   int               Y2(void)                     { return(m_y+m_y_size);  }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)                   { return(m_x_gap);       }
   void              XGap(const int x_gap)        { m_x_gap=x_gap;         }
   int               YGap(void)                   { return(m_y_gap);       }
   void              YGap(const int y_gap)        { m_y_gap=y_gap;         }
   //--- Размеры
   int               XSize(void)                  { return(m_x_size);      }
   void              XSize(const int x_size)      { m_x_size=x_size;       }
   int               YSize(void)                  { return(m_y_size);      }
   void              YSize(const int y_size)      { m_y_size=y_size;       }
   //--- Фокус
   bool              MouseFocus(void)             { return(m_mouse_focus); }
   void              MouseFocus(const bool focus) { m_mouse_focus=focus;   }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CBmpLabel::CBmpLabel(void) : m_x(0),
                             m_y(0),
                             m_x2(0),
                             m_y2(0),
                             m_x_gap(0),
                             m_y_gap(0),
                             m_x_size(0),
                             m_y_size(0),
                             m_mouse_focus(false)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CBmpLabel::~CBmpLabel(void)
  {
  }
//+------------------------------------------------------------------+
//| Класс с дополнительными свойствами для объекта Edit              |
//+------------------------------------------------------------------+
class CButton : public CChartObjectButton
  {
protected:
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   int               m_x_gap;
   int               m_y_gap;
   int               m_x_size;
   int               m_y_size;
   bool              m_mouse_focus;
   //---
public:
                     CButton(void);
                    ~CButton(void);
   //--- Координаты
   int               X(void)                      { return(m_x);           }
   void              X(const int x)               { m_x=x;                 }
   int               Y(void)                      { return(m_y);           }
   void              Y(const int y)               { m_y=y;                 }
   int               X2(void)                     { return(m_x+m_x_size);  }
   int               Y2(void)                     { return(m_y+m_y_size);  }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)                   { return(m_x_gap);       }
   void              XGap(const int x_gap)        { m_x_gap=x_gap;         }
   int               YGap(void)                   { return(m_y_gap);       }
   void              YGap(const int y_gap)        { m_y_gap=y_gap;         }
   //--- Размеры
   int               XSize(void)                  { return(m_x_size);      }
   void              XSize(const int x_size)      { m_x_size=x_size;       }
   int               YSize(void)                  { return(m_y_size);      }
   void              YSize(const int y_size)      { m_y_size=y_size;       }
   //--- Фокус
   bool              MouseFocus(void)             { return(m_mouse_focus); }
   void              MouseFocus(const bool focus) { m_mouse_focus=focus;   }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CButton::CButton(void) : m_x(0),
                         m_y(0),
                         m_x2(0),
                         m_y2(0),
                         m_x_gap(0),
                         m_y_gap(0),
                         m_x_size(0),
                         m_y_size(0),
                         m_mouse_focus(false)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CButton::~CButton(void)
  {
  }
//+------------------------------------------------------------------+
//| Класс с дополнительными свойствами для объекта Line Chart        |
//+------------------------------------------------------------------+
class CLineChartObject : public CLineChart
  {
protected:
   int               m_x;
   int               m_y;
   int               m_x2;
   int               m_y2;
   int               m_x_gap;
   int               m_y_gap;
   int               m_x_size;
   int               m_y_size;
   bool              m_mouse_focus;
public:
                     CLineChartObject(void);
                    ~CLineChartObject(void);
   //---
   int               X(void)                      { return(m_x);           }
   void              X(const int x)               { m_x=x;                 }
   int               Y(void)                      { return(m_y);           }
   void              Y(const int y)               { m_y=y;                 }
   int               X2(void)                     { return(m_x+m_x_size);  }
   int               Y2(void)                     { return(m_y+m_y_size);  }
   //--- Отступы от крайней точки (xy)
   int               XGap(void)                   { return(m_x_gap);       }
   void              XGap(const int x_gap)        { m_x_gap=x_gap;         }
   int               YGap(void)                   { return(m_y_gap);       }
   void              YGap(const int y_gap)        { m_y_gap=y_gap;         }
   //--- Размеры
   int               XSize(void)                  { return(m_x_size);      }
   void              XSize(const int x_size)      { m_x_size=x_size;       }
   int               YSize(void)                  { return(m_y_size);      }
   void              YSize(const int y_size)      { m_y_size=y_size;       }
   //---
   bool              MouseFocus(void)             { return(m_mouse_focus); }
   void              MouseFocus(const bool focus) { m_mouse_focus=focus;   }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CLineChartObject::CLineChartObject(void) : m_x(0),
                                           m_y(0),
                                           m_x2(0),
                                           m_y2(0),
                                           m_x_gap(0),
                                           m_y_gap(0),
                                           m_x_size(0),
                                           m_y_size(0),
                                           m_mouse_focus(false)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CLineChartObject::~CLineChartObject(void)
  {
  }
//+------------------------------------------------------------------+
