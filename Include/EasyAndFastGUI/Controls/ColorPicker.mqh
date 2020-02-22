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
//| ����� ��� �������� �������� ������� ��� ������ �����             |
//+------------------------------------------------------------------+
class CColorPicker : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ��������� �� ������ ���������� ������� ��� ������ �����
   CColorButton     *m_color_button;
   //--- ������� ��� �������� ��������
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
   //--- ���� (1) ���� � (2) ����� ����
   color             m_area_color;
   color             m_area_border_color;
   //--- ���� ����� �������
   color             m_palette_border_color;
   //--- ����� (1) ��������, (2) ���������� � (3) ���������� �������� ����
   color             m_current_color;
   color             m_picked_color;
   color             m_hover_color;
   //--- �������� ����������� � ������ �������� �������:
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
   //--- ���������� �� ������� ����� ������ ����
   int               m_area_zorder;
   int               m_canvas_zorder;
   //--- ������� ������� ��� ��������� ������
   int               m_timer_counter;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //---
public:
                     CColorPicker(void);
                    ~CColorPicker(void);
   //--- ������ ��� �������� ��������
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
   //--- (1) ��������� ��������� �����, (2) ���������� ��������� �� �������� �����
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
   //--- ��������� ����� (1) ���� � (2) ����� ����, (3) ����� �������
   void              AreaBackColor(const color clr)           { m_area_color=clr;                      }
   void              AreaBorderColor(const color clr)         { m_area_border_color=clr;               }
   void              PaletteBorderColor(const color clr)      { m_palette_border_color=clr;            }
   
   //--- ��������� ��������� �� ������ ���������� �������� �������
   void              ColorButtonPointer(CColorButton &object);
   //--- ��������� ����� ���������� ������������� ����� �� �������
   void              CurrentColor(const color clr);
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- ������
   virtual void      OnEventTimer(void);
   //--- ����������� ��������
   virtual void      Moving(const int x,const int y);
   //--- (1) �����, (2) �������, (3) �����, (4) ��������
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- (1) ���������, (2) ����� ����������� �� ������� ����� ������ ����
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- �������� ����
   virtual void      ResetColors(void) {}
   //---
private:
   //--- ��������� ����� ��� �������� ����
   bool              OnHoverColor(const int x,const int y);
   //--- ��������� ������� �� �������
   bool              OnClickPalette(const string clicked_object);
   //--- ��������� ������� �� �����-������
   bool              OnClickRadioButton(const long id,const int button_index,const string button_text);
   //--- ��������� ����� ������ �������� � ���� �����
   bool              OnEndEdit(const long id,const int button_index);
   //--- ��������� ������� �� ������ 'OK'
   bool              OnClickButtonOK(const string clicked_object);
   //--- ��������� ������� �� ������ 'Cancel'
   bool              OnClickButtonCancel(const string clicked_object);

   //--- ������ �������
   void              DrawPalette(const int index);
   //--- ������ ������� �� �������� ������ HSL (0: H, 1: S, 2: L)
   void              DrawHSL(const int index);
   //--- ������ ������� �� �������� ������ RGB (3: R, 4: G, 5: B)
   void              DrawRGB(const int index);
   //--- ������ ������� �� �������� ������ LAB (6: L, 7: a, 8: b)
   void              DrawLab(const int index);
   //--- ������ ����� �������
   void              DrawPaletteBorder(void);

   //--- ������ � ��������� ����������� �����
   void              SetComponents(const int index,const bool fix_selected);
   //--- ��������� ������� ���������� � ���� �����
   void              SetControls(const int index,const bool fix_selected);

   //--- ��������� ���������� �������� ������� ������������ (1) HSL, (2) RGB, (3) Lab
   void              SetHSL(void);
   void              SetRGB(void);
   void              SetLab(void);

   //--- ������������� ��������� RGB
   void              AdjustmentComponentRGB(void);
   //--- ������������� ��������� HSL
   void              AdjustmentComponentHSL(void);

   //--- ���������� ��������� �������� � ���� �����
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
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
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
//| ���������� ������� �������                                       |
//+------------------------------------------------------------------+
void CColorPicker::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- ���������� � ��������� ����� ������ ����
      int x=(int)lparam;
      int y=(int)dparam;
      m_mouse_state=(bool)int(sparam);
      CElement::MouseFocus(x>X() && x<X2() && y>Y() && y<Y2());
      m_canvas.MouseFocus(x>m_canvas.X() && x<m_canvas.X2()-1 && y>m_canvas.Y() && y<m_canvas.Y2()-1);
      //--- ��������� ����� ��� �������� ����
      if(OnHoverColor(x,y))
         return;
      //---
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� �������
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- ���� ������ �� �������
      if(OnClickPalette(sparam))
         return;
      //---
      return;
     }
//--- ��������� ����� �������� � ���� �����
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      //--- �������� ����� ������ ��������
      if(OnEndEdit(lparam,(int)dparam))
         return;
      //---
      return;
     }
//--- ��������� ������� �� ��������
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      //--- ���� ������ �� �����-������
      if(OnClickRadioButton(lparam,(int)dparam,sparam))
         return;
      //---
      return;
     }
//--- ��������� ������� �� �������������� ����� �����
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC || id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      //--- �������� ����� ������ ��������
      if(OnEndEdit(lparam,(int)dparam))
         return;
      //---
      return;
     }
//--- ��������� ������� �� ������ ��������
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      //--- �����, ���� �������������� �� ���������
      if(lparam!=CElement::Id())
         return;
      //--- ���� ������ �� ������ "OK"
      if(OnClickButtonOK(sparam))
         return;
      //--- ���� ������ �� ������ "CANCEL"
      if(OnClickButtonCancel(sparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������                                                           |
//+------------------------------------------------------------------+
void CColorPicker::OnEventTimer(void)
  {
//--- ���� ������� ����������
   if(CElement::IsDropdown())
      FastSwitching();
   else
     {
      //--- ����������� ��������� ��������, 
      //    ������ ���� ����� �� �������������
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| ������ ������ Color Picker                                      |
//+------------------------------------------------------------------+
bool CColorPicker::CreateColorPicker(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� �������� ��� ������ ����� ������ ����� �������� "
              "��������� �� �����: CColorPicker::WindowPointer(CWindow &object)");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x_size   =348;
   m_y_size   =265;
   m_x        =x;
   m_y        =y;
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ������� ��������
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
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//--- ���������� ���������� ���� �������� ������� �
//    ���������� ������� ������������ ���������� �����-������
   SetComponents(m_radio_buttons.SelectedButtonIndex(),false);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� �������                                            |
//+------------------------------------------------------------------+
bool CColorPicker::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_color_picker_bg_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X();
   int y=CElement::Y();
//--- ������� �� ������� �����
   m_area.XGap(x-m_wnd.X());
   m_area.YGap(y-m_wnd.Y());
//--- ������� ������
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- ��������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ������                                           |
//+------------------------------------------------------------------+
bool CColorPicker::CreatePalette(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_color_picker_palette_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+6;
   int y=CElement::Y()+5;
//--- �������
   int x_size=255;
   int y_size=255;
//--- ������� ������
   if(!m_canvas.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,x_size,y_size,COLOR_FORMAT_XRGB_NOALPHA))
      return(false);
//--- ���������� � �������
   if(!m_canvas.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- ��������
   m_canvas.Tooltip("\n");
   m_canvas.Z_Order(m_canvas_zorder);
//--- ����������
   m_canvas.X(x);
   m_canvas.Y(y);
//--- �������
   m_canvas.XSize(x_size);
   m_canvas.YSize(y_size);
//--- ������� �� ������� �����
   m_canvas.XGap(x-m_wnd.X());
   m_canvas.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_canvas);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� �������� �����                                   |
//+------------------------------------------------------------------+
bool CColorPicker::CreateCurrentSample(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_color_picker_csample_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+266;
   int y=CElement::Y()+5;
//--- ������� ������
   if(!m_current.Create(m_chart_id,name,m_subwin,x,y,76,25))
      return(false);
//--- ��������
   m_current.BackColor(m_current_color);
   m_current.Color(clrSilver);
   m_current.BorderType(BORDER_FLAT);
   m_current.Corner(m_corner);
   m_current.Selectable(false);
   m_current.Z_Order(m_area_zorder);
   m_current.Tooltip(::ColorToString(m_current_color));
//--- ������� �� ������� �����
   m_current.XGap(x-m_wnd.X());
   m_current.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_current);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ���������� �����                                 |
//+------------------------------------------------------------------+
bool CColorPicker::CreatePickedSample(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_color_picker_psample_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+290;
   int y=CElement::Y()+6;
//--- ������� ������
   if(!m_picked.Create(m_chart_id,name,m_subwin,x,y,26,23))
      return(false);
//--- ��������
   m_picked.BackColor(m_picked_color);
   m_picked.Color(m_picked_color);
   m_picked.BorderType(BORDER_FLAT);
   m_picked.Corner(m_corner);
   m_picked.Selectable(false);
   m_picked.Z_Order(m_area_zorder);
   m_picked.Tooltip(::ColorToString(m_picked_color));
//--- ������� �� ������� �����
   m_picked.XGap(x-m_wnd.X());
   m_picked.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_picked);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������� ����� ��� ���������                              |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHoverSample(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_color_picker_hsample_"+(string)CElement::Id();
//--- ����������
   int x=CElement::X()+316;
   int y=CElement::Y()+6;
//--- ������� ������
   if(!m_hover.Create(m_chart_id,name,m_subwin,x,y,25,23))
      return(false);
//--- ��������
   m_hover.BackColor(m_hover_color);
   m_hover.Color(m_hover_color);
   m_hover.BorderType(BORDER_FLAT);
   m_hover.Corner(m_corner);
   m_hover.Selectable(false);
   m_hover.Z_Order(m_area_zorder);
   m_hover.Tooltip(::ColorToString(m_hover_color));
//--- ������� �� ������� �����
   m_hover.XGap(x-m_wnd.X());
   m_hover.YGap(y-m_wnd.Y());
//--- �������� ��������� �������
   CElement::AddToArray(m_hover);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ �����-������                                      |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRadioButtons(void)
  {
//--- �������� ��������� �� �����
   m_radio_buttons.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+267;
   int y =CElement::Y()+35;
//--- ��������
   int    buttons_x_offset[] ={0,0,0,0,0,0,0,0,0};
   int    buttons_y_offset[] ={0,19,38,60,79,98,120,139,158};
   string buttons_text[]     ={"H:","S:","L:","R:","G:","B:","L:","a:","b:"};
   int    buttons_width[]    ={80,80,80,80,80,80,80,80,80};
//--- ��������
   m_radio_buttons.AreaColor(m_area_color);
   m_radio_buttons.TextColor(clrBlack);
   m_radio_buttons.TextColorOff(clrSilver);
   m_radio_buttons.LabelXGap(17);
//--- ������� �����-������ � ���������� ����������
   for(int i=0; i<9; i++)
      m_radio_buttons.AddButton(buttons_x_offset[i],buttons_y_offset[i],buttons_text[i],buttons_width[i]);
//--- ������� ������ ������
   if(!m_radio_buttons.CreateRadioButtons(m_chart_id,m_subwin,x,y))
      return(false);
//--- ������� ������ �����-������
   m_radio_buttons.SelectionRadioButton(1);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (hsl) H                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHslHEdit(void)
  {
//--- �������� ��������� �� �����
   m_hsl_h_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+36;
//--- ��������
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
//--- �������� ��������
   if(!m_hsl_h_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (hsl) S                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHslSEdit(void)
  {
//--- �������� ��������� �� �����
   m_hsl_s_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+55;
//--- ��������
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
//--- �������� ��������
   if(!m_hsl_s_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (hsl) L                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateHslLEdit(void)
  {
//--- �������� ��������� �� �����
   m_hsl_l_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+74;
//--- ��������
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
//--- �������� ��������
   if(!m_hsl_l_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (rgb) R                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRgbREdit(void)
  {
//--- �������� ��������� �� �����
   m_rgb_r_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+96;
//--- ��������
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
//--- �������� ��������
   if(!m_rgb_r_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (rgb) G                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRgbGEdit(void)
  {
//--- �������� ��������� �� �����
   m_rgb_g_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+115;
//--- ��������
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
//--- �������� ��������
   if(!m_rgb_g_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (rgb) B                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateRgbBEdit(void)
  {
//--- �������� ��������� �� �����
   m_rgb_b_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+134;
//--- ��������
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
//--- �������� ��������
   if(!m_rgb_b_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (Lab) L                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateLabLEdit(void)
  {
//--- �������� ��������� �� �����
   m_lab_l_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+156;
//--- ��������
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
//--- �������� ��������
   if(!m_lab_l_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (Lab) a                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateLabAEdit(void)
  {
//--- �������� ��������� �� �����
   m_lab_a_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+175;
//--- ��������
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
//--- �������� ��������
   if(!m_lab_a_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ���� ����� (Lab) b                                       |
//+------------------------------------------------------------------+
bool CColorPicker::CreateLabBEdit(void)
  {
//--- �������� ��������� �� �����
   m_lab_b_edit.WindowPointer(m_wnd);
//--- ����������
   int x =CElement::X()+307;
   int y =CElement::Y()+194;
//--- ��������
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
//--- �������� ��������
   if(!m_lab_b_edit.CreateSpinEdit(m_chart_id,m_subwin,"",x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ OK                                                |
//+------------------------------------------------------------------+
bool CColorPicker::CreateButtonOK(const string text)
  {
//--- �������� ��������� �� �����
   m_button_ok.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X()+267;
   int y=CElement::Y()+220;
//--- ��������
   m_button_ok.ButtonXSize(75);
   m_button_ok.ButtonYSize(18);
   m_button_ok.BackColor(clrGainsboro);
   m_button_ok.BackColorHover(C'193,218,255');
   m_button_ok.BackColorPressed(C'190,190,200');
   m_button_ok.TextColor(clrBlack);
   m_button_ok.BorderColor(C'150,170,180');
   m_button_ok.Index(0);
//--- �������� ��������
   if(!m_button_ok.CreateSimpleButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ Cancel                                            |
//+------------------------------------------------------------------+
bool CColorPicker::CreateButtonCancel(const string text)
  {
//--- �������� ��������� �� �����
   m_button_cancel.WindowPointer(m_wnd);
//--- ����������
   int x=CElement::X()+267;
   int y=CElement::Y()+241;
//--- ��������
   m_button_cancel.ButtonXSize(75);
   m_button_cancel.ButtonYSize(18);
   m_button_cancel.BackColor(clrGainsboro);
   m_button_cancel.BackColorHover(C'193,218,255');
   m_button_cancel.BackColorPressed(C'190,190,200');
   m_button_cancel.TextColor(clrBlack);
   m_button_cancel.BorderColor(C'150,170,180');
   m_button_cancel.Index(1);
//--- �������� ��������
   if(!m_button_cancel.CreateSimpleButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �� ������ ���������� �������� ������� �      |
//| ��������� ����, � �������� ������� ������������                  |
//+------------------------------------------------------------------+
void CColorPicker::ColorButtonPointer(CColorButton &object)
  {
//--- ��������� ��������� �� ������
   m_color_button=::GetPointer(object);
//--- ��������� ���� ���������� ������ ���� �������� �������
   CurrentColor(object.CurrentColor());
//--- ������� ����, � �������� ������������ �������
   m_wnd.Show();
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CColorPicker::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� ��������� � ����� ��������
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- ���������� ��������� � ����� ��������
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
//--- ���������� ��������� ����������� ��������
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
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CColorPicker::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_canvas.Timeframes(OBJ_ALL_PERIODS);
   m_current.Timeframes(OBJ_ALL_PERIODS);
   m_picked.Timeframes(OBJ_ALL_PERIODS);
   m_hover.Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CColorPicker::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ��� �������
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_canvas.Timeframes(OBJ_NO_PERIODS);
   m_current.Timeframes(OBJ_NO_PERIODS);
   m_picked.Timeframes(OBJ_NO_PERIODS);
   m_hover.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CColorPicker::Reset(void)
  {
//--- ������, ���� ������� ����������
   if(CElement::IsDropdown())
      return;
//--- ������ � ��������
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| ��������                                                         |
//+------------------------------------------------------------------+
void CColorPicker::Delete(void)
  {
//--- �������� ��������
   m_area.Delete();
   m_canvas.Delete();
   m_current.Delete();
   m_picked.Delete();
   m_hover.Delete();
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
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
//| ����� �����������                                                |
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
//| ��������� �������� �����                                         |
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
//| ��������� ����� ��� �������� ����                                |
//+------------------------------------------------------------------+
bool CColorPicker::OnHoverColor(const int x,const int y)
  {
//--- �����, ���� ����� �� �� �������
   if(!m_canvas.MouseFocus())
      return(false);
//--- ��������� ���� �� ������� ��� �������� ����
   int lx =x-m_canvas.X();
   int ly =y-m_canvas.Y();
   m_hover_color=(color)::ColorToARGB(m_canvas.PixelGet(lx,ly),0);
//--- ��������� ���� � ����������� ��������� � ��������������� ������� (������)
   m_hover.Color(m_hover_color);
   m_hover.BackColor(m_hover_color);
   m_hover.Tooltip(::ColorToString(m_hover_color));
//--- ��������� ����������� ��������� �������
   m_canvas.Tooltip(::ColorToString(m_hover_color));
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� �������� �������                            |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickPalette(const string clicked_object)
  {
//--- �����, ���� ��� ������� �� ���������
   if(clicked_object!=m_canvas.Name())
      return(false);
//--- ��������� ���� � ����������� ��������� � ��������������� �������
   m_picked_color=m_hover_color;
   m_picked.Color(m_picked_color);
   m_picked.BackColor(m_picked_color);
   m_picked.Tooltip(::ColorToString(m_picked_color));
//--- ���������� � ��������� ���������� ����� ������������ ���������� �����-������
   SetComponents();
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� �����-������                                |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickRadioButton(const long id,const int button_index,const string button_text)
  {
//--- �����, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- �����, ���� ����� �����-������ �� ���������
   if(button_text!=m_radio_buttons.SelectedButtonText())
      return(false);
//--- �������� ������� � ������ ��������� ���������
   DrawPalette(button_index);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������ �������� � ���� �����                     |
//+------------------------------------------------------------------+
bool CColorPicker::OnEndEdit(const long id,const int button_index)
  {
//--- �����, ���� �������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ���������� � ��������� ���������� ����� ��� ���� �������� ������� 
   SetComponents(button_index,false);
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ 'OK'                                 |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickButtonOK(const string clicked_object)
  {
//--- �����, ���� ��� ������� �� ���������
   if(clicked_object!=m_button_ok.Text())
      return(false);
//--- ��������� ��������� ����
   m_current_color=m_picked_color;
   m_current.BackColor(m_current_color);
   m_current.Tooltip(::ColorToString(m_current_color));
//--- ���� ���� ��������� ������ ������ ���� ��� ������ �����
   if(::CheckPointer(m_color_button)!=POINTER_INVALID)
     {
      //--- ��������� ������ ��������� ����
      m_color_button.CurrentColor(m_current_color);
      //--- ������� ����
      m_wnd.CloseDialogBox();
      //--- �������� ��������� �� ����
      ::EventChartCustom(m_chart_id,ON_CHANGE_COLOR,CElement::Id(),CElement::Index(),m_color_button.LabelText());
      //--- ������� ���������
      m_color_button=NULL;
     }
   else
     {
      //--- ���� ��������� ��� � ���� ����������,
      //    ������� ���������, ��� ��� ��������� �� ������ ��� ������ ��������
      if(m_wnd.WindowType()==W_DIALOG)
         ::Print(__FUNCTION__," > ���������� ��������� ����������� �������� (CColorButton).");
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� �� ������ 'Cancel'                             |
//+------------------------------------------------------------------+
bool CColorPicker::OnClickButtonCancel(const string clicked_object)
  {
//--- �����, ���� ��� ������� �� ���������
   if(clicked_object!=m_button_cancel.Text())
      return(false);
//--- ������� ����, ���� ��� ����������
   if(m_wnd.WindowType()==W_DIALOG)
      m_wnd.CloseDialogBox();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������                                                   |
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
//--- �������� ����� �������
   DrawPaletteBorder();
//--- ������� �������
   m_canvas.Update();
  }
//+------------------------------------------------------------------+
//| ������ ������� HSL                                               |
//+------------------------------------------------------------------+
void CColorPicker::DrawHSL(const int index)
  {
   switch(index)
     {
      //--- Hue (H) - �������� ��� � ��������� �� 0 �� 360
      case 0 :
        {
         //--- ���������� H-����������
         m_hsl_h=m_hsl_h_edit.GetValue()/360.0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� L-����������
            m_hsl_l=ly/(double)m_canvas.YSize();
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� S-����������
               m_hsl_s=lx/(double)m_canvas.XSize();
               //--- ����������� HSL-��������� � RGB-����������
               m_clr.HSLtoRGB(m_hsl_h,m_hsl_s,m_hsl_l,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Saturation (S) - ������������ � ��������� �� 0 �� 100
      case 1 :
        {
         //--- ���������� S-����������
         m_hsl_s=m_hsl_s_edit.GetValue()/100.0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� L-����������
            m_hsl_l=ly/(double)m_canvas.YSize();
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� H-����������
               m_hsl_h=lx/(double)m_canvas.XSize();
               //--- ����������� HSL-��������� � RGB-����������
               m_clr.HSLtoRGB(m_hsl_h,m_hsl_s,m_hsl_l,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Lightness (L) - ������� � ��������� �� 0 �� 100
      case 2 :
        {
         //--- ���������� L-����������
         m_hsl_l=m_hsl_l_edit.GetValue()/100.0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� S-����������
            m_hsl_s=ly/(double)m_canvas.YSize();
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� H-����������
               m_hsl_h=lx/(double)m_canvas.XSize();
               //--- ����������� HSL-��������� � RGB-����������
               m_clr.HSLtoRGB(m_hsl_h,m_hsl_s,m_hsl_l,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� RGB                                               |
//+------------------------------------------------------------------+
void CColorPicker::DrawRGB(const int index)
  {
//--- ���� �� ���� X � Y ��� ������� RGB-���������
   double rgb_x_step=255.0/m_canvas.XSize();
   double rgb_y_step=255.0/m_canvas.YSize();
//---
   switch(index)
     {
      //--- Red (R) - �������. �������� �������� �� 0 �� 255
      case 3 :
        {
         //--- ������� ������� R-���������� � ������� B-����������
         m_rgb_r =m_rgb_r_edit.GetValue();
         m_rgb_b =0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� B-���������� � ������� R-����������
            m_rgb_g=0;
            m_rgb_b+=rgb_y_step;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� G-����������
               m_rgb_g+=rgb_x_step;
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Green (G) - ������. �������� �������� �� 0 �� 255
      case 4 :
        {
         //--- ������� ������� G-���������� � ������� B-����������
         m_rgb_g =m_rgb_g_edit.GetValue();
         m_rgb_b =0;
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� B-���������� � ������� R-����������
            m_rgb_r=0;
            m_rgb_b+=rgb_y_step;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� R-����������
               m_rgb_r+=rgb_x_step;
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- Blue (B) - �����. �������� �������� �� 0 �� 255
      case 5 :
        {
         //--- ������� ������� B-���������� � ������� G-����������
         m_rgb_g =0;
         m_rgb_b =m_rgb_b_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� G-���������� � ������� R-����������
            m_rgb_r=0;
            m_rgb_g+=rgb_y_step;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� R-����������
               m_rgb_r+=rgb_x_step;
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� Lab                                               |
//+------------------------------------------------------------------+
void CColorPicker::DrawLab(const int index)
  {
   switch(index)
     {
      //--- Lightness (L) - ������� � ��������� �� 0 �� 100
      case 6 :
        {
         //--- ������� ������� L-����������
         m_lab_l=m_lab_l_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� b-����������
            m_lab_b=(ly/(double)m_canvas.YSize()*255.0)-128;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� a-����������
               m_lab_a=(lx/(double)m_canvas.XSize()*255.0)-128;
               //--- ����������� Lab-��������� � RGB-����������
               m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
               m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- ������������� ��������� RGB
               AdjustmentComponentRGB();
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- ������������� ���������� 'a' - �������� �� -128 (������) �� 127 (���������)
      case 7 :
        {
         //--- ������� ������� a-����������
         m_lab_a=m_lab_a_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� b-����������
            m_lab_b=(ly/(double)m_canvas.YSize()*255.0)-128;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� L-����������
               m_lab_l=100.0*lx/(double)m_canvas.XSize();
               //--- ����������� Lab-��������� � RGB-����������
               m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
               m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- ������������� ��������� RGB
               AdjustmentComponentRGB();
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
      //--- ������������� ���������� 'b' - �������� �� -128 (�����) �� 127 (�����)
      case 8 :
        {
         //--- ������� ������� b-����������
         m_lab_b=m_lab_b_edit.GetValue();
         //---
         for(int ly=0; ly<m_canvas.YSize(); ly++)
           {
            //--- ���������� a-����������
            m_lab_a=(ly/(double)m_canvas.YSize()*255.0)-128;
            //---
            for(int lx=0; lx<m_canvas.XSize(); lx++)
              {
               //--- ���������� L-����������
               m_lab_l=100.0*lx/(double)m_canvas.XSize();
               //--- ����������� Lab-��������� � RGB-����������
               m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
               m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
               //--- ������������� ��������� RGB
               AdjustmentComponentRGB();
               //--- �������� ������
               uint rgb_color=XRGB(m_rgb_r,m_rgb_g,m_rgb_b);
               m_canvas.PixelSet(lx,m_canvas.YSize()-ly,rgb_color);
              }
           }
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| ������ ����� �������                                             |
//+------------------------------------------------------------------+
void CColorPicker::DrawPaletteBorder(void)
  {
//--- ������ �������
   int x_size=m_canvas.XSize()-1;
   int y_size=m_canvas.YSize()-1;
//--- ���������� �����
   m_canvas.Line(0,0,x_size,0,m_palette_border_color);
   m_canvas.Line(0,y_size,x_size,y_size,m_palette_border_color);
   m_canvas.Line(0,0,0,y_size,m_palette_border_color);
   m_canvas.Line(x_size,0,x_size,y_size,m_palette_border_color);
  }
//+------------------------------------------------------------------+
//| ������ � ��������� ����������� �����                             |
//+------------------------------------------------------------------+
void CColorPicker::SetComponents(const int index=0,const bool fix_selected=true)
  {
//--- ���� ����� ��������������� ����� ������������ ����������� �����-������� ����������
   if(fix_selected)
     {
      //--- �������� �� RGB-���������� ��������� ����
      m_rgb_r=m_clr.GetR(m_picked_color);
      m_rgb_g=m_clr.GetG(m_picked_color);
      m_rgb_b=m_clr.GetB(m_picked_color);
      //--- ������������ RGB-���������� � HSL-����������
      m_clr.RGBtoHSL(m_rgb_r,m_rgb_g,m_rgb_b,m_hsl_h,m_hsl_s,m_hsl_l);
      //--- ������������� ��������� HSL
      AdjustmentComponentHSL();
      //--- ������������ RGB-���������� � LAB-����������
      m_clr.RGBtoXYZ(m_rgb_r,m_rgb_g,m_rgb_b,m_xyz_x,m_xyz_y,m_xyz_z);
      m_clr.XYZtoCIELab(m_xyz_x,m_xyz_y,m_xyz_z,m_lab_l,m_lab_a,m_lab_b);
      //--- ��������� ����� � ���� �����
      SetControls(m_radio_buttons.SelectedButtonIndex(),true);
      return;
     }
//--- ��������� ���������� �������� �������
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
//--- ���������� ������� ������������ ���������� �����-������
   DrawPalette(m_radio_buttons.SelectedButtonIndex());
  }
//+------------------------------------------------------------------+
//| ��������� ������� ���������� � ���� �����                        |
//+------------------------------------------------------------------+
void CColorPicker::SetControls(const int index,const bool fix_selected)
  {
//--- ���� ����� ������������� �������� � ���� ����� ���������� �����-������
   if(fix_selected)
     {
      //--- ���������� HSL
      if(index!=0)
         m_hsl_h_edit.ChangeValue(m_hsl_h);
      if(index!=1)
         m_hsl_s_edit.ChangeValue(m_hsl_s);
      if(index!=2)
         m_hsl_l_edit.ChangeValue(m_hsl_l);
      //--- ���������� RGB
      if(index!=3)
         m_rgb_r_edit.ChangeValue(m_rgb_r);
      if(index!=4)
         m_rgb_g_edit.ChangeValue(m_rgb_g);
      if(index!=5)
         m_rgb_b_edit.ChangeValue(m_rgb_b);
      //--- ���������� Lab
      if(index!=6)
         m_lab_l_edit.ChangeValue(m_lab_l);
      if(index!=7)
         m_lab_a_edit.ChangeValue(m_lab_a);
      if(index!=8)
         m_lab_b_edit.ChangeValue(m_lab_b);
      return;
     }
//--- ���� ����� ��������������� �������� � ����� ����� ���� �������� �������
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
//| ��������� ���������� �������� ������� ������������ HSL           |
//+------------------------------------------------------------------+
void CColorPicker::SetHSL(void)
  {
//--- ������� ������� �������� ����������� HSL
   m_hsl_h=m_hsl_h_edit.GetValue();
   m_hsl_s=m_hsl_s_edit.GetValue();
   m_hsl_l=m_hsl_l_edit.GetValue();
//--- ����������� HSL-��������� � RGB-����������
   m_clr.HSLtoRGB(m_hsl_h/360.0,m_hsl_s/100.0,m_hsl_l/100.0,m_rgb_r,m_rgb_g,m_rgb_b);
//--- ����������� RGB-��������� � Lab-����������
   m_clr.RGBtoXYZ(m_rgb_r,m_rgb_g,m_rgb_b,m_xyz_x,m_xyz_y,m_xyz_z);
   m_clr.XYZtoCIELab(m_xyz_x,m_xyz_y,m_xyz_z,m_lab_l,m_lab_a,m_lab_b);
//--- ��������� ������� ���������� � ���� �����
   SetControls(0,false);
  }
//+------------------------------------------------------------------+
//| ��������� ���������� �������� ������� ������������ RGB           |
//+------------------------------------------------------------------+
void CColorPicker::SetRGB(void)
  {
//--- ������� ������� �������� ����������� RGB
   m_rgb_r=m_rgb_r_edit.GetValue();
   m_rgb_g=m_rgb_g_edit.GetValue();
   m_rgb_b=m_rgb_b_edit.GetValue();
//--- ����������� RGB-��������� � HSL-����������
   m_clr.RGBtoHSL(m_rgb_r,m_rgb_g,m_rgb_b,m_hsl_h,m_hsl_s,m_hsl_l);
//--- ������������� ��������� HSL
   AdjustmentComponentHSL();
//--- ����������� RGB-��������� � Lab-����������
   m_clr.RGBtoXYZ(m_rgb_r,m_rgb_g,m_rgb_b,m_xyz_x,m_xyz_y,m_xyz_z);
   m_clr.XYZtoCIELab(m_xyz_x,m_xyz_y,m_xyz_z,m_lab_l,m_lab_a,m_lab_b);
//--- ��������� ������� ���������� � ���� �����
   SetControls(0,false);
  }
//+------------------------------------------------------------------+
//| ��������� ���������� �������� ������� ������������ Lab           |
//+------------------------------------------------------------------+
void CColorPicker::SetLab(void)
  {
//--- ������� ������� �������� ����������� Lab
   m_lab_l=m_lab_l_edit.GetValue();
   m_lab_a=m_lab_a_edit.GetValue();
   m_lab_b=m_lab_b_edit.GetValue();
//--- ����������� Lab-��������� � RGB-����������
   m_clr.CIELabToXYZ(m_lab_l,m_lab_a,m_lab_b,m_xyz_x,m_xyz_y,m_xyz_z);
   m_clr.XYZtoRGB(m_xyz_x,m_xyz_y,m_xyz_z,m_rgb_r,m_rgb_g,m_rgb_b);
//--- ������������� ��������� RGB
   AdjustmentComponentRGB();
//--- ����������� RGB-��������� � HSL-����������
   m_clr.RGBtoHSL(m_rgb_r,m_rgb_g,m_rgb_b,m_hsl_h,m_hsl_s,m_hsl_l);
//--- ������������� ��������� HSL
   AdjustmentComponentHSL();
//--- ��������� ������� ���������� � ���� �����
   SetControls(0,false);
  }
//+------------------------------------------------------------------+
//| ������������� ��������� RGB                                      |
//+------------------------------------------------------------------+
void CColorPicker::AdjustmentComponentRGB(void)
  {
   m_rgb_r=::fmin(::fmax(m_rgb_r,0),255);
   m_rgb_g=::fmin(::fmax(m_rgb_g,0),255);
   m_rgb_b=::fmin(::fmax(m_rgb_b,0),255);
  }
//+------------------------------------------------------------------+
//| ������������� ��������� HSL                                      |
//+------------------------------------------------------------------+
void CColorPicker::AdjustmentComponentHSL(void)
  {
   m_hsl_h*=360;
   m_hsl_s*=100;
   m_hsl_l*=100;
  }
//+------------------------------------------------------------------+
//| ���������� �������� �������� � ���� �����                        |
//+------------------------------------------------------------------+
void CColorPicker::FastSwitching(void)
  {
//--- ������, ���� ��� ������ �� ��������
   if(!CElement::MouseFocus())
      return;
//--- ����� ������� � ��������������� ��������, ���� ������ ���� ������
   if(!m_mouse_state)
      m_timer_counter=SPIN_DELAY_MSC;
//--- ���� �� ������ ���� ������
   else
     {
      //--- �������� ������� �� ������������� ��������
      m_timer_counter+=TIMER_STEP_MSC;
      //--- ������, ���� ������ ����
      if(m_timer_counter<0)
         return;
      //--- ����������� ��������������� �������� � �������������� �����-������
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
      //--- ���� ����, ������� �������
      if(index!=WRONG_VALUE)
         DrawPalette(index);
      //--- ����������� ��������������� ��������
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
      //--- ���� ����, ����������� ���������� ���� �������� ������� � ������� �������
      if(index!=WRONG_VALUE)
         SetComponents(index,false);
     }
  }
//+------------------------------------------------------------------+
