//+------------------------------------------------------------------+
//|                                                      Pointer.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
//--- �������
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_x_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_x_resize_blue.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_y_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_y_resize_blue.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy1_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy1_resize_blue.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy2_resize.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\pointer_xy2_resize_blue.bmp"
//+------------------------------------------------------------------+
//| ����� ��� �������� ��������� ������� ����                        |
//+------------------------------------------------------------------+
class CPointer : public CElement
  {
private:
   //--- ������ ��� �������� ��������
   CBmpLabel         m_pointer_bmp;
   //--- �������� ��� ���������
   string            m_file_on;
   string            m_file_off;
   //--- ��� ���������
   ENUM_MOUSE_POINTER m_type;
   //---
public:
                     CPointer(void);
                    ~CPointer(void);
   //--- ������ ����� ���������
   bool              CreatePointer(const long chart_id,const int subwin);
   //--- ��������� ������� ��� ���������
   void              FileOn(const string file_path)       { m_file_on=file_path;           }
   void              FileOff(const string file_path)      { m_file_off=file_path;          }
   //--- ����������� � ��������� ���� ���������
   ENUM_MOUSE_POINTER Type(void)                    const { return(m_type);                }
   void              Type(ENUM_MOUSE_POINTER type)        { m_type=type;                   }
   //--- ����������� � ��������� ��������� ���������
   bool              State(void)                    const { return(m_pointer_bmp.State()); }
   void              State(const bool state)              { m_pointer_bmp.State(state);    }
   //--- ���������� ���������
   void              UpdateX(const int x)                 { m_pointer_bmp.X_Distance(x);   }
   void              UpdateY(const int y)                 { m_pointer_bmp.Y_Distance(y);   }
   //---
public:
   //--- ����������� ��������
   virtual void      Moving(const int x,const int y);
   //--- (1) �����, (2) �������, (3) �����, (4) ��������
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //---
private:
   //--- ��������� �������� ��� ��������� ������� ����
   void              SetPointerBmp(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CPointer::CPointer(void) : m_file_on(""),
                           m_file_off(""),
                           m_type(MP_X_RESIZE)
  {
   //--- �������� ������� �������� �� ���������
   CElement::Index(0);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CPointer::~CPointer(void)
  {
  }
//+------------------------------------------------------------------+
//| ������ ���������                                                |
//+------------------------------------------------------------------+
bool CPointer::CreatePointer(const long chart_id,const int subwin)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_pointer_bmp_"+(string)CElement::Index()+"__"+(string)CElement::Id();
//--- ��������� �������� ��� ���������
   SetPointerBmp();
//--- �������� �������
   if(!m_pointer_bmp.Create(m_chart_id,name,m_subwin,0,0))
      return(false);
//--- ��������� �������
   m_pointer_bmp.BmpFileOn("::"+m_file_on);
   m_pointer_bmp.BmpFileOff("::"+m_file_off);
   m_pointer_bmp.Corner(m_corner);
   m_pointer_bmp.Selectable(false);
   m_pointer_bmp.Z_Order(0);
   m_pointer_bmp.Tooltip("\n");
//--- ������ ������
   m_pointer_bmp.Timeframes(OBJ_NO_PERIODS);
   return(true);
  }
//+------------------------------------------------------------------+
//| ����������� ��������                                             |
//+------------------------------------------------------------------+
void CPointer::Moving(const int x,const int y)
  {
   UpdateX(x);
   UpdateY(y);
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CPointer::Show(void)
  {
//--- ������� �������� ��� �������  
   m_pointer_bmp.Timeframes(OBJ_ALL_PERIODS);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CPointer::Hide(void)
  {
//--- ������ �������
   m_pointer_bmp.Timeframes(OBJ_NO_PERIODS);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CPointer::Reset(void)
  {
//--- ������ � ��������
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| ��������                                                         |
//+------------------------------------------------------------------+
void CPointer::Delete(void)
  {
   m_pointer_bmp.Delete();
  }
//+------------------------------------------------------------------+
//| ��������� �������� ��� ��������� �� ���� ���������               |
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
//--- ���� ������ ���������������� ��� (MP_CUSTOM)
   if(m_file_on=="" || m_file_off=="")
      ::Print(__FUNCTION__," > ��� ��������� ������� ������ ���� ����������� ��� ��������!");
  }
//+------------------------------------------------------------------+
