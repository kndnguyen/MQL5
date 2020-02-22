//+------------------------------------------------------------------+
//|                                                      MenuBar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "MenuItem.mqh"
#include "ContextMenu.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� �������� ����                                 |
//+------------------------------------------------------------------+
class CMenuBar : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ������ ����
   CRectLabel        m_area;
   CMenuItem         m_items[];
   //--- ������ ���������� �� ����������� ����
   CContextMenu     *m_contextmenus[];

   //--- �������� ����
   int               m_area_zorder;
   color             m_area_color;
   color             m_area_color_hover;
   color             m_area_border_color;
   //--- ����� �������� ������� ����
   int               m_item_y_size;
   color             m_item_color;
   color             m_item_color_hover;
   color             m_item_border_color;
   int               m_label_x_gap;
   int               m_label_y_gap;
   color             m_label_color;
   color             m_label_color_hover;

   //--- ������� ���������� ������� ������� ����:
   //    (1) ������, (2) �����
   int               m_width[];
   string            m_label_text[];
   //--- ��������� �������� ����
   bool              m_menubar_state;
   //---
public:
                     CMenuBar(void);
                    ~CMenuBar(void);
   //--- ������ ��� �������� �������� ����
   bool              CreateMenuBar(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   //---
public:
   //--- ��������� ��������� �����
   void              WindowPointer(CWindow &object) { m_wnd=::GetPointer(object); }

   //--- (1) ��������� ��������� ���������� ������ ����, (2) ��������� ��������� ���������� ������������ ����
   CMenuItem        *ItemPointerByIndex(const int index);
   CContextMenu     *ContextMenuPointerByIndex(const int index);

   //--- ���������� (1) ������� � (2) ����������� ����, (3) ��������� �������� ����
   int               ItemsTotal(void)               const { return(::ArraySize(m_items));        }
   int               ContextMenusTotal(void)        const { return(::ArraySize(m_contextmenus)); }
   bool              State(void)                    const { return(m_menubar_state);             }
   void              State(const bool state);

   //--- ���� (1) ���� � (2) ����� ���� �������� ����
   void              MenuBackColor(const color clr)       { m_area_color=clr;                    }
   void              MenuBorderColor(const color clr)     { m_area_border_color=clr;             }
   //--- (1) ���� ����, (2) ���� ���� ��� ��������� ������� � (3) ���� ����� ������� �������� ����
   void              ItemBackColor(const color clr)       { m_item_color=clr;                    }
   void              ItemBackColorHover(const color clr)  { m_item_color_hover=clr;              }
   void              ItemBorderColor(const color clr)     { m_item_border_color=clr;             }
   //--- ������� ��������� ����� �� ������� ����� ���� ������
   void              LabelXGap(const int x_gap)           { m_label_x_gap=x_gap;                 }
   void              LabelYGap(const int y_gap)           { m_label_y_gap=y_gap;                 }
   //--- ���� ������ (1) ������� � (2) � ������
   void              LabelColor(const color clr)          { m_label_color=clr;                   }
   void              LabelColorHover(const color clr)     { m_label_color_hover=clr;             }

   //--- ��������� ����� ���� � ���������� ���������� �� �������� �������� ����
   void              AddItem(const int width,const string text);
   //--- ������������ ���������� ����������� ���� � ���������� ������ �������� ����
   void              AddContextMenuPointer(const int index,CContextMenu &object);

   //--- �������� ���� ��� ��������� ������� ����
   void              ChangeObjectsColor(void);

   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
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
   virtual void      ResetColors(void);
   //---
private:
   //--- ��������� ������� �� ������ ����
   bool              OnClickMenuItem(const string clicked_object);
   //--- ��������� (1) �������������� � (2) ������� �� ����� ������ ����
   int               IdFromObjectName(const string object_name);
   int               IndexFromObjectName(const string object_name);
   //--- ���������� �������� ����� �������� ����
   int               ActiveItemIndex(void);
   //--- ����������� ����������� ���� �������� ����, ���������� �������
   void              SwitchContextMenuByFocus(const int active_item_index);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMenuBar::CMenuBar(void) : m_menubar_state(false),
                           m_area_zorder(0),
                           m_area_color(C'240,240,240'),
                           m_area_border_color(clrSilver),
                           m_item_y_size(22),
                           m_item_color(C'240,240,240'),
                           m_item_color_hover(C'51,153,255'),
                           m_item_border_color(C'240,240,240'),
                           m_label_x_gap(15),
                           m_label_y_gap(3),
                           m_label_color(clrBlack),
                           m_label_color_hover(clrWhite)
  {
//--- �������� ��� ������ �������� � ������� ������
   ClassName(CLASS_NAME);
//--- ������ �������� ���� �� ���������
   m_y_size=22;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMenuBar::~CMenuBar(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CMenuBar::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� ����������� �������    
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- �����, ���� ������� �����
      if(!CElement::IsVisible())
         return;
      //--- �����, ���� ������� ���� ��������������
      if(!m_menubar_state)
         return;
      //--- ������� ������ ������������� ������ �������� ����
      int active_item_index=ActiveItemIndex();
      if(active_item_index==WRONG_VALUE)
         return;
      //--- �������� ����, ���� ����� ���������
      ChangeObjectsColor();
      //--- ����������� ����������� ���� �� ��������������� ������ �������� ����
      SwitchContextMenuByFocus(active_item_index);
      return;
     }
//--- ��������� ������� ������� ����� ������ ���� �� ������ �������� ����
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| ������ ������� ����                                             |
//+------------------------------------------------------------------+
bool CMenuBar::CreateMenuBar(const long chart_id,const int window,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� �������� ���� ��� ����� �������� "
              "������ ����� � ������� ������ WindowPointer(CWindow &object).");
      return(false);
     }
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =window;
   m_x        =x;
   m_y        =y;
//--- ������� �� ������� �����
   CElement::XGap(x-m_wnd.X());
   CElement::YGap(y-m_wnd.Y());
//--- �������� �������� ����
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- ���������� ������� ���� ���������
   State(false);
//--- ������ �������, ���� �� � ���������� ���� ��� ���� �������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����� ������� �������� ����                              |
//+------------------------------------------------------------------+
bool CMenuBar::CreateArea(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_menubar_bg_"+(string)CElement::Id();
//--- ���������� � ������
   int x      =m_x;
   int y      =m_y;
   int x_size =m_wnd.XSize()-2;
//--- ��������� ��� �������� ����
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,x_size,m_y_size))
      return(false);
//--- ��������� ��������
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- ������� �� ������� �����
   m_area.XGap(XGap());
   m_area.YGap(YGap());
//--- �������� ��������� �������
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ������ ������� ����                                      |
//+------------------------------------------------------------------+
bool CMenuBar::CreateItems(void)
  {
   int x=m_x+1;
   int y=m_y+1;
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ������ ���������� X
      x=(i>0)? x+m_width[i-1]: x;
      //--- ��������� ������ ������
      m_items[i].WindowPointer(m_wnd);
      //--- ��������� �������� ����� ���������
      m_items[i].TypeMenuItem(MI_HAS_CONTEXT_MENU);
      m_items[i].ShowRightArrow(false);
      m_items[i].XSize(m_width[i]);
      m_items[i].YSize(m_y_size-2);
      m_items[i].AreaBorderColor(m_item_border_color);
      m_items[i].AreaBackColor(m_item_color);
      m_items[i].AreaBackColorHover(m_item_color_hover);
      m_items[i].LabelXGap(m_label_x_gap);
      m_items[i].LabelYGap(m_label_y_gap);
      m_items[i].LabelColor(m_label_color);
      m_items[i].LabelColorHover(m_label_color_hover);
      //--- ������� �� ������� ����� ������
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- �������� ������ ����
      if(!m_items[i].CreateMenuItem(m_chart_id,m_subwin,i,m_label_text[i],x,y))
         return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ��������� �������� ����                                |
//+------------------------------------------------------------------+
void CMenuBar::State(const bool state)
  {
   if(state)
      m_menubar_state=true;
   else
     {
      m_menubar_state=false;
      //--- �������� �� ���� ������� �������� ���� ���
      //    ��������� ������� ����������� ����������� ����
      int items_total=ItemsTotal();
      for(int i=0; i<items_total; i++)
         m_items[i].ContextMenuState(false);
      //--- �������������� �����
      m_wnd.IsLocked(false);
     }
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������ ���� �� �������                      |
//+------------------------------------------------------------------+
CMenuItem *CMenuBar::ItemPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- ���� ��� �� ������ ������ � ������� ����, �������� �� ����
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������� ���� ���� ���� �� ���� �����!");
     }
//--- ������������� � ������ ������ �� ���������
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- ������� ���������
   return(::GetPointer(m_items[i]));
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������������ ���� �� �������                |
//+------------------------------------------------------------------+
CContextMenu *CMenuBar::ContextMenuPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_contextmenus);
//--- ���� ��� �� ������ ������ � ������� ����, �������� �� ����
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > ����� ����� ������ ����� ������������, "
              "����� � ������� ���� ���� ���� �� ���� �����!");
     }
//--- ������������� � ������ ������ �� ���������
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- ������� ���������
   return(::GetPointer(m_contextmenus[i]));
  }
//+------------------------------------------------------------------+
//| ��������� ����� ����                                             |
//+------------------------------------------------------------------+
void CMenuBar::AddItem(const int width,const string text)
  {
//--- �������� ������ �������� �� ���� �������  
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_contextmenus,array_size+1);
   ::ArrayResize(m_width,array_size+1);
   ::ArrayResize(m_label_text,array_size+1);
//--- �������� �������� ���������� ����������
   m_width[array_size]      =width;
   m_label_text[array_size] =text;
  }
//+------------------------------------------------------------------+
//| ��������� ��������� ������������ ����                            |
//+------------------------------------------------------------------+
void CMenuBar::AddContextMenuPointer(const int index,CContextMenu &object)
  {
//--- �������� �� ����� �� ���������
   int size=::ArraySize(m_contextmenus);
   if(size<1 || index<0 || index>=size)
      return;
//--- ��������� ���������
   m_contextmenus[index]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| ����� ����� �������                                              |
//+------------------------------------------------------------------+
void CMenuBar::ResetColors(void)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].ResetColors();
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CMenuBar::Moving(const int x,const int y)
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
//--- ���������� ��������� ����������� ��������
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
  }
//+------------------------------------------------------------------+
//| ���������� ����� ����                                            |
//+------------------------------------------------------------------+
void CMenuBar::Show(void)
  {
//--- �����, ���� ������� ��� �����
   if(CElement::IsVisible())
      return;
//--- ������� �������� ��� �������  
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- ������� �������� ��� ������ ���� 
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Show();
//--- ������������� ����������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� ����� ����                                              |
//+------------------------------------------------------------------+
void CMenuBar::Hide(void)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ������ ������� �������� ����
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- ������ ������ ����
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- ��������� ������ �������� ��������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CMenuBar::Reset(void)
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
void CMenuBar::Delete(void)
  {
//--- �������� ��������  
   m_area.Delete();
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Delete();
//--- ������������ �������� ��������
   ::ArrayFree(m_items);
   ::ArrayFree(m_contextmenus);
   ::ArrayFree(m_width);
   ::ArrayFree(m_label_text);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- ������������� ���������� ���������� �� ���������
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CMenuBar::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CMenuBar::ResetZorders(void)
  {
   m_area.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| ��������� ����� ������� ��� ��������� �������                    |
//+------------------------------------------------------------------+
void CMenuBar::ChangeObjectsColor(void)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| ������� �� ������ �������� ����                                  |
//+------------------------------------------------------------------+
bool CMenuBar::OnClickMenuItem(const string clicked_object)
  {
//--- ������, ���� ������� ���� �� �� ������ ����
   if(::StringFind(clicked_object,CElement::ProgramName()+"_menuitem_",0)<0)
      return(false);
//--- ������� ������������� � ������ �� ����� �������
   int id    =IdFromObjectName(clicked_object);
   int index =IndexFromObjectName(clicked_object);
//--- �����, ���� ������������� �� ���������
   if(id!=CElement::Id())
      return(false);
//--- ���� ���� ��������� �� ����������� ����
   if(::CheckPointer(m_contextmenus[index])!=POINTER_INVALID)
     {
      //--- �������� ���� ������
      m_items[index].HighlightItemState(true);
      //--- ��������� �������� ���� ������� �� ��������� ������������ ����
      m_menubar_state=(m_contextmenus[index].ContextMenuState())? false : true;
      //--- ���������� ��������� �����
      m_wnd.IsLocked(m_menubar_state);
      //--- ���� ������� ���� ���������
      if(!m_menubar_state)
         //--- ������� ������ �� ������� ���� ����������� ����
         ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
     }
//--- ���� ��� ��������� �� ����������� ����
   else
     {
      //--- ������� ������ �� ������� ���� ����������� ����
      ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������������� �� ����� �������                         |
//+------------------------------------------------------------------+
int CMenuBar::IdFromObjectName(const string object_name)
  {
//--- ������� id �� ����� �������
   int    length =::StringLen(object_name);
   int    pos    =::StringFind(object_name,"__",0);
   string id     =::StringSubstr(object_name,pos+2,length-1);
//--- ������� id ������
   return((int)id);
  }
//+------------------------------------------------------------------+
//| ��������� ������ �� ����� �������                                |
//+------------------------------------------------------------------+
int CMenuBar::IndexFromObjectName(const string object_name)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- ������� ��� �����������
   u_sep=::StringGetCharacter("_",0);
//--- �������� ������
   ::StringSplit(object_name,u_sep,result);
   array_size=::ArraySize(result)-1;
//--- �������� ������ �� �������� �������
   if(array_size-2<0)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- ������� ������ ������
   return((int)result[array_size-2]);
  }
//+------------------------------------------------------------------+
//| ���������� ������ ��������������� ������ ����                    |
//+------------------------------------------------------------------+
int CMenuBar::ActiveItemIndex(void)
  {
   int active_item_index=WRONG_VALUE;
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ���� ����� � ������
      if(m_items[i].MouseFocus())
        {
         //--- �������� ������ � ��������� ����
         active_item_index=i;
         break;
        }
     }
//---
   return(active_item_index);
  }
//+------------------------------------------------------------------+
//| ����������� ����������� ���� �������� ����, ���������� �������   |
//+------------------------------------------------------------------+
void CMenuBar::SwitchContextMenuByFocus(const int active_item_index)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- ������� � ����������, ���� � ���� ������ ��� ������������ ����
      if(::CheckPointer(m_contextmenus[i])==POINTER_INVALID)
         continue;
      //--- ���� ����� �� ���������� ������, �� ������� ��� ����������� ���� �������
      if(i==active_item_index)
         m_contextmenus[i].Show();
      //--- ��� ��������� ����������� ���� ����� ������
      else
        {
         CContextMenu *cm=m_contextmenus[i];
         //--- ������ ����������� ����, ������� ������� �� ������ ����������� ����.
         //    �������� � ����� �� ������� �������� ������������ ����, ����� ��������, ���� �� �����.
         int cm_items_total=cm.ItemsTotal();
         for(int c=0; c<cm_items_total; c++)
           {
            CMenuItem *mi=cm.ItemPointerByIndex(c);
            //--- ������� � ����������, ���� ��������� �� ����� ������������
            if(::CheckPointer(mi)==POINTER_INVALID)
               continue;
            //--- ������� � ����������, ���� ���� ����� �� �������� � ���� ����������� ����
            if(mi.TypeMenuItem()!=MI_HAS_CONTEXT_MENU)
               continue;
            //--- ���� ����������� ���� ���� � ��� ������������
            if(mi.ContextMenuState())
              {
               //--- ��������� ������ �� �������� ���� ����������� ����, ������� ������� �� �����
               ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
               break;
              }
           }
         //--- ������ ����������� ���� �������� ����
         m_contextmenus[i].Hide();
         //--- �������� ���� ������ ����
         m_items[i].ResetColors();
        }
     }
  }
//+------------------------------------------------------------------+
