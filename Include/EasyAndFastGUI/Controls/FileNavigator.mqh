//+------------------------------------------------------------------+
//|                                                FileNavigator.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "TreeView.mqh"
//+------------------------------------------------------------------+
//| ����� ��� �������� ��������� ����������                          |
//+------------------------------------------------------------------+
class CFileNavigator : public CElement
  {
private:
   //--- ��������� �� �����, � ������� ������� ����������
   CWindow          *m_wnd;
   //--- ������� ��� �������� ��������
   CRectCanvas       m_address_bar;
   CTreeView         m_treeview;
   //--- �������� ������� ��� �������� ������
   int               m_g_list_index[];           // ����� ������
   int               m_g_prev_node_list_index[]; // ����� ������ ����������� ����
   string            m_g_item_text[];            // ��� �����/�����
   int               m_g_item_index[];           // ��������� ������
   int               m_g_node_level[];           // ������� ����
   int               m_g_prev_node_item_index[]; // ��������� ������ ����������� ����
   int               m_g_items_total[];          // ����� ��������� � �����
   int               m_g_folders_total[];        // ���������� ����� � �����
   bool              m_g_is_folder[];            // ������� �����
   bool              m_g_item_state[];           // ��������� ������ (������/������)
   //--- ��������������� ������� ��� ����� ������
   int               m_l_prev_node_list_index[];
   string            m_l_item_text[];
   string            m_l_path[];
   int               m_l_item_index[];
   int               m_l_item_total[];
   int               m_l_folders_total[];
   //--- ������ ������� ������������ ������
   int               m_treeview_area_width;
   //--- ������ ������� ����������
   int               m_content_area_width;
   //--- ���� ���� � ����� ����
   color             m_area_color;
   color             m_area_border_color;
   //--- ���� ���� �������� ������
   color             m_address_bar_back_color;
   //--- ���� ������ � �������� ������
   color             m_address_bar_text_color;
   //--- ������ �������� ������
   int               m_address_bar_y_size;
   //--- �������� ��� (1) ����� � (2) ������
   string            m_file_icon;
   string            m_folder_icon;
   //--- ������� ���� ������������ �������� "���������" ���������
   string            m_current_path;
   //--- ������� ������ ���� ������������ �������� ������� ������� ����� ���� ������� �����
   string            m_current_full_path;
   //--- ������� ������� ����������
   int               m_directory_area;
   //--- ���������� �� ������� ����� ������ ����
   int               m_zorder;
   //--- ��������� ����� ������ ���� (������/������)
   bool              m_mouse_state;
   //--- ����� ���������� ��������� ����������
   ENUM_FILE_NAVIGATOR_CONTENT m_navigator_content;
   //---
public:
                     CFileNavigator(void);
                    ~CFileNavigator(void);
   //--- ������ ��� �������� ��������� ����������
   bool              CreateFileNavigator(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateAddressBar(void);
   bool              CreateTreeView(void);
   //---
public:
   //--- (1) ��������� ��������� �����, (2) ���������� ��������� ������������ ������
   void              WindowPointer(CWindow &object)                           { m_wnd=::GetPointer(object);                }
   CTreeView        *TreeViewPointer(void)                                    { return(::GetPointer(m_treeview));          }
   //--- (1) ����� ���������� (���������� ���/������ �����), (2) ���������� ���������� (����� �����/���������/��)
   void              NavigatorMode(const ENUM_FILE_NAVIGATOR_MODE mode)       { m_treeview.NavigatorMode(mode);            }
   void              NavigatorContent(const ENUM_FILE_NAVIGATOR_CONTENT mode) { m_navigator_content=mode;                  }
   //--- (1) ������ �������� ������, (2) ������ ������������ ������ � (3) ������ ����������
   void              AddressBarYSize(const int y_size)                        { m_address_bar_y_size=y_size;               }
   void              TreeViewAreaWidth(const int x_size)                      { m_treeview_area_width=x_size;              }
   void              ContentAreaWidth(const int x_size)                       { m_content_area_width=x_size;               }
   //--- (1) ���� ���� � (2) ����� ����
   void              AreaBackColor(const color clr)                           { m_area_color=clr;                          }
   void              AreaBorderColor(const color clr)                         { m_area_border_color=clr;                   }
   //--- (1) ���� ���� � (2) ������ �������� ������
   void              AddressBarBackColor(const color clr)                     { m_address_bar_back_color=clr;              }
   void              AddressBarTextColor(const color clr)                     { m_address_bar_text_color=clr;              }
   //--- ��������� ���� � ������ ��� (1) ������ � (2) �����
   void              FileIcon(const string file_path)                         { m_file_icon=file_path;                     }
   void              FolderIcon(const string file_path)                       { m_folder_icon=file_path;                   }
   //--- ���������� (1) ������� ���� � (2) ������ ����, (3) ���������� ����
   string            CurrentPath(void)                                  const { return(m_current_path);                    }
   string            CurrentFullPath(void)                              const { return(m_current_full_path);               }
   //--- ���������� (1) ������� ���������� � (2) ���������� ����
   int               DirectoryArea(void)                                const { return(m_directory_area);                  }
   string            SelectedFile(void)                                 const { return(m_treeview.SelectedItemFileName()); }
   //---
public:
   //--- ���������� ������� �������
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- ������
   virtual void      OnEventTimer(void) {}
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
   //--- ��������� ������� ������ ������ ���� � ����������� ������
   void              OnChangeTreePath(void);

   //--- ������ ����� ��� �������� ������
   void              Border(void);
   //--- ���������� ������� ���� � �������� ������
   void              UpdateAddressBar(void);

   //--- ��������� ������� ����������� ��������� �������� ������� ���������
   void              FillArraysData(void);
   //--- ������ �������� ������� � ���������� ��������� � �������
   void              FileSystemScan(const int root_index,int &list_index,int &node_level,int &item_index,int search_area);
   //--- �������� ������ ��������������� �������� ������������ �������� ������ ���� 
   void              AuxiliaryArraysResize(const int node_level);
   //--- ����������, �������� ��� ����� ��� �����
   bool              IsFolder(const string file_name);
   //--- ���������� ���������� (1) ��������� � (2) ����� � ��������� ����������
   int               ItemsTotal(const string search_path,const int mode);
   int               FoldersTotal(const string search_path,const int mode);
   //--- ���������� ��������� ������ ����������� ���� ������������ ���������� ����������
   int               PrevNodeItemIndex(const int root_index,const int node_level);

   //--- ��������� ����� � �������
   void              AddItem(const int list_index,const string item_text,const int node_level,const int prev_node_item_index,
                             const int item_index,const int items_total,const int folders_total,const bool is_folder);
   //--- ������� �� ��������� ����
   void              ToNextNode(const int root_index,int list_index,int &node_level,
                                int &item_index,long &handle,const string item_text,const int search_area);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CFileNavigator::CFileNavigator(void) : m_current_path(""),
                                       m_current_full_path(""),
                                       m_directory_area(FILE_COMMON),
                                       m_address_bar_y_size(20),
                                       m_treeview_area_width(300),
                                       m_content_area_width(0),
                                       m_navigator_content(FN_ONLY_MQL),
                                       m_area_border_color(clrLightGray),
                                       m_address_bar_back_color(clrWhiteSmoke),
                                       m_address_bar_text_color(clrBlack),
                                       m_file_icon("Images\\EasyAndFastGUI\\Icons\\bmp16\\text_file.bmp"),
                                       m_folder_icon("Images\\EasyAndFastGUI\\Icons\\bmp16\\folder.bmp")
  {
//--- �������� ��� ������ �������� � ������� ������
   CElement::ClassName(CLASS_NAME);
//--- ��������� ���������� �� ������� ����� ������ ����
   m_zorder=0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CFileNavigator::~CFileNavigator(void)
  {
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CFileNavigator::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- ��������� ������� "��������� ���� � ����������� ������"
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_TREE_PATH)
     {
      OnChangeTreePath();
      return;
     }
  }
//+------------------------------------------------------------------+
//| ������ �������� ���������                                       |
//+------------------------------------------------------------------+
bool CFileNavigator::CreateFileNavigator(const long chart_id,const int subwin,const int x,const int y)
  {
//--- �����, ���� ��� ��������� �� �����
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > ����� ��������� ��������� ���������� ��� ����� �������� "
              "��������� �� �����: CFileNavigator::WindowPointer(CWindow &object).");
      return(false);
     }
//--- ��������� �������� ������� ��������� � ������� ������ � �������
   FillArraysData();
//--- ������������� ����������
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- ������� �� ������� �����
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- �������� ��������
   if(!CreateAddressBar())
      return(false);
   if(!CreateTreeView())
      return(false);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ �������� ������                                          |
//+------------------------------------------------------------------+
bool CFileNavigator::CreateAddressBar(void)
  {
//--- ������������ ����� �������
   string name=CElement::ProgramName()+"_file_navigator_address_bar_"+(string)CElement::Id();
//--- ����������
   int x =CElement::X();
   int y =CElement::Y();
//--- �������:
//    ���������� ������
   int x_size=0;
//--- ���� ������� ���������� �� �����
   if(m_content_area_width<0)
      x_size=m_treeview_area_width;
   else
     {
      //--- ���� ������� ���������� ������ ������� ����������
      if(m_content_area_width>0)
         x_size=m_treeview_area_width+m_content_area_width-1;
      //--- ���� ������ ���� ������� ���������� ������ ���� � ������� ���� �����
      else
         x_size=m_wnd.X2()-x-2;
     }
//--- ������
   int y_size=m_address_bar_y_size;
//--- �������� �������
   if(!m_address_bar.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,x_size,y_size,COLOR_FORMAT_XRGB_NOALPHA))
      return(false);
//--- ���������� � �������
   if(!m_address_bar.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- ��������� ��������
   m_address_bar.Background(false);
   m_address_bar.Z_Order(m_zorder);
   m_address_bar.Tooltip("\n");
//--- �������� �������
   CElement::X(x);
   CElement::Y(y);
//--- �������� �������
   CElement::XSize(x_size);
   CElement::YSize(y_size);
//--- ������� �� ������� �����
   m_address_bar.XGap(x-m_wnd.X());
   m_address_bar.YGap(y-m_wnd.Y());
//--- �������� �������� ������
   UpdateAddressBar();
//--- �������� ��������� �������
   CElement::AddToArray(m_address_bar);
//--- ������ �������, ���� ���� ���������� ��� ��� ��������������
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      m_address_bar.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ������ ����������� ������                                       |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\folder.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\text_file.bmp"
//---
bool CFileNavigator::CreateTreeView(void)
  {
//--- �������� ��������� �� ����
   m_treeview.WindowPointer(m_wnd);
//--- ��������� ��������
   m_treeview.Id(CElement::Id());
   m_treeview.XSize(CElement::XSize());
   m_treeview.YSize(CElement::YSize());
   m_treeview.ResizeListAreaMode(true);
   m_treeview.TreeViewAreaWidth(m_treeview_area_width);
   m_treeview.ContentAreaWidth(m_content_area_width);
//--- ��������� ������� ������������ ������
   int items_total=::ArraySize(m_g_item_text);
   for(int i=0; i<items_total; i++)
     {
      //--- ��������� �������� ��� ������ (�����/����)
      string icon_path=(m_g_is_folder[i])? m_folder_icon : m_file_icon;
      //--- ���� ��� �����, ������ ��������� ������ ('\') � ������ 
      if(m_g_is_folder[i])
         m_g_item_text[i]=::StringSubstr(m_g_item_text[i],0,::StringLen(m_g_item_text[i])-1);
      //--- ������� ����� � ����������� ������
      m_treeview.AddItem(i,m_g_prev_node_list_index[i],m_g_item_text[i],icon_path,m_g_item_index[i],
                         m_g_node_level[i],m_g_prev_node_item_index[i],m_g_items_total[i],m_g_folders_total[i],false,m_g_is_folder[i]);
     }
//--- ������� ����������� ������
   if(!m_treeview.CreateTreeView(m_chart_id,m_subwin,m_x,m_y+m_address_bar_y_size))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ��������� ������� ������ ������ ���� � ����������� ������        |
//+------------------------------------------------------------------+
void CFileNavigator::OnChangeTreePath(void)
  {
//--- ������� ������� ����
   string path=m_treeview.CurrentFullPath();
//--- ���� ��� ����� ����� ����������
   if(::StringFind(path,"Common\\Files\\",0)>-1)
     {
      //--- ������� ����� ����� ����� ����������
      string common_path=::TerminalInfoString(TERMINAL_COMMONDATA_PATH);
      //--- ������ � ������ (�������� � �������) ������� "Common\"
      path=::StringSubstr(path,7,::StringLen(common_path)-7);
      //--- ���������� ���� (������� � ������ ������)
      m_current_path      =::StringSubstr(path,6,::StringLen(path)-6);
      m_current_full_path =common_path+"\\"+path;
      //--- �������� ������� ����������
      m_directory_area=FILE_COMMON;
     }
//--- ���� ��� ��������� ����� ���������
   else if(::StringFind(path,"MQL5\\Files\\",0)>-1)
     {
      //--- ������� ����� ������ � ��������� ����� ���������
      string local_path=::TerminalInfoString(TERMINAL_DATA_PATH);
      //--- ���������� ���� (������� � ������ ������)
      m_current_path      =::StringSubstr(path,11,::StringLen(path)-11);
      m_current_full_path =local_path+"\\"+path;
      //--- �������� ������� ����������
      m_directory_area=0;
     }
//--- ��������� ������� ���� � �������� ������
   UpdateAddressBar();
  }
//+------------------------------------------------------------------+
//| ������ ����� ��� �������� ������                                 |
//+------------------------------------------------------------------+
void CFileNavigator::Border(void)
  {
//--- ����������
   int  x1=0,x2=0,y1=0,y2=0;
//--- ���� ����
   uint clr=::ColorToARGB(m_area_border_color);
//--- �������
   int x_size =m_x_size;
   int y_size =m_address_bar_y_size;
//--- �����
   for(int i=y_size; i>=0; i--)
     {
      //--- ����������
      x1=0; x2=i; y1=0; y2=i;
      //--- ���������� �����
      m_address_bar.Line(x1,x2,y1,y2,clr);
     }
//--- ������
   for(int i=0; i<x_size; i++)
     {
      //--- ����������
      x1=i; x2=0; y1=i; y2=0;
      //--- ���������� �����
      m_address_bar.Line(x1,x2,y1,y2,clr);
     }
//--- ������
   for(int i=0; i<y_size; i++)
     {
      //--- ����������
      x1=x_size-1; x2=i; y1=x_size-1; y2=i;
      //--- ���������� �����
      m_address_bar.Line(x1,x2,y1,y2,clr);
     }
  }
//+------------------------------------------------------------------+
//| ���������� ������� ���� � �������� ������                        |
//+------------------------------------------------------------------+
void CFileNavigator::UpdateAddressBar(void)
  {
//--- ����������
   int x=5;
   int y=m_address_bar_y_size/2;
//--- �������� ���
   m_address_bar.Erase(::ColorToARGB(m_address_bar_back_color,0));
//--- ���������� ����� ����
   Border();
//--- �������� ������
   m_address_bar.FontSet("Calibri",14,FW_NORMAL);
//--- ���� ���� ��� �� ����������, �������� ������ �� ���������
   if(m_current_full_path=="")
      m_current_full_path="Loading. Please wait...";
//--- ������� ���� � �������� ������ ��������� ����������
   m_address_bar.TextOut(x,y,m_current_full_path,::ColorToARGB(m_address_bar_text_color),TA_LEFT|TA_VCENTER);
//--- ������� ����� ��� ���������
   m_address_bar.Update();
  }
//+------------------------------------------------------------------+
//| ��������� ������� ����������� ��������� �������� �������         |
//+------------------------------------------------------------------+
void CFileNavigator::FillArraysData(void)
  {
//--- �������� (1) ����� ��������, (2) ������� �����, (3) ��������� ��������
   int list_index =0;
   int node_level =0;
   int item_index =0;
//--- ���� ����� ���������� ��� ���������� (����� (0)/��������� (1))
   int begin=0,end=1;
//--- ���� ����� ���������� ���������� ������ ��������� ����������
   if(m_navigator_content==FN_ONLY_MQL)
      begin=1;
//--- ���� ����� ���������� ���������� ������ ����� ����������
   else if(m_navigator_content==FN_ONLY_COMMON)
      begin=end=0;
//--- �������� �� ��������� �����������
   for(int root_index=begin; root_index<=end; root_index++)
     {
      //--- ��������� ���������� ��� ������������ �������� ���������
      int search_area=(root_index>0) ? 0 : FILE_COMMON;
      //--- ������� ������� ��������� ��������
      item_index=0;
      //--- �������� ������ �������� �� ���� ������� (������������ ������ ����)
      AuxiliaryArraysResize(node_level);
      //--- ������� ���-�� ������ � ����� � ��������� ���������� (* - ��������� ��� �����/�����)
      string search_path   =m_l_path[0]+"*";
      m_l_item_total[0]    =ItemsTotal(search_path,search_area);
      m_l_folders_total[0] =FoldersTotal(search_path,search_area);
      //--- ������� ����� � ��������� ��������� �������� � ������ ������
      string item_text=(root_index>0)? "MQL5\\Files\\" : "Common\\Files\\";
      AddItem(list_index,item_text,0,0,root_index,m_l_item_total[0],m_l_folders_total[0],true);
      //--- �������� �������� ����� �������� � ������� �����
      list_index++;
      node_level++;
      //--- �������� ������ �������� �� ���� ������� (������������ ������ ����)
      AuxiliaryArraysResize(node_level);
      //--- ������������� ������ ��������� ��� ���������� ��������� ����� ���������
      if(root_index>0)
        {
         m_l_item_index[0]           =root_index;
         m_l_prev_node_list_index[0] =list_index-1;
        }
      //--- ��������� ���������� � ������� ������ � �������
      FileSystemScan(root_index,list_index,node_level,item_index,search_area);
     }
  }
//+------------------------------------------------------------------+
//| ������ �������� ������� ��������� � ����������                   |
//| ��������� ��������� � �������                                    |
//+------------------------------------------------------------------+
void CFileNavigator::FileSystemScan(const int root_index,int &list_index,int &node_level,int &item_index,int search_area)
  {
   long   search_handle =INVALID_HANDLE; // ����� ������ �����/�����
   string file_name     ="";             // ��� ���������� �������� (�����/�����)
   string filter        ="*";            // ������ ������ (* - ��������� ��� �����/�����)
//--- ��������� ���������� � ������� ������ � �������
   while(!::IsStopped())
     {
      //--- ���� ��� ������ ������ ����������
      if(item_index==0)
        {
         //--- ���� ��� ������ ���� ���������
         string search_path=m_l_path[node_level]+filter;
         //--- �������� ����� � ��� ������� �����
         search_handle=::FileFindFirst(search_path,file_name,search_area);
         //--- ������� ���-�� ������ � ����� � ��������� ����������
         m_l_item_total[node_level]    =ItemsTotal(search_path,search_area);
         m_l_folders_total[node_level] =FoldersTotal(search_path,search_area);
        }
      //--- ���� ������ ����� ���� ��� ���, ������� � ���������� �����
      if(m_l_item_index[node_level]>-1 && item_index<=m_l_item_index[node_level])
        {
         //--- �������� ������� ��������� ��������
         item_index++;
         //--- ��������� � ���������� ��������
         ::FileFindNext(search_handle,file_name);
         continue;
        }
      //--- ���� ����� �� ����� ������ � �������� ����, �������� ����
      if(node_level==1 && item_index>=m_l_item_total[node_level])
          break;
      //--- ���� ����� �� ����� ������ � ����� ����, ����� ���������
      else if(item_index>=m_l_item_total[node_level])
        {
         //--- ��������� ������� ����� �� ���� ������� �����
         node_level--;
         //--- �������� ������� ��������� ��������
         item_index=0;
         //--- ��������� ����� ������
         ::FileFindClose(search_handle);
         continue;
        }
      //--- ���� ��� �����
      if(IsFolder(file_name))
        {
         //--- ������� �� ��������� ����
         ToNextNode(root_index,list_index,node_level,item_index,search_handle,file_name,search_area);
         //--- ��������� ������� ����� �������� � ������ ����� ��������
         list_index++;
         continue;
        }
      //--- ������� ��������� ������ ����������� ����
      int prev_node_item_index=PrevNodeItemIndex(root_index,node_level);
      //--- ������� ����� � ���������� ������� � ����� �������
      AddItem(list_index,file_name,node_level,prev_node_item_index,item_index,0,0,false);
      //--- �������� ������� ����� ��������
      list_index++;
      //--- �������� ������� ��������� ��������
      item_index++;
      //--- ��������� � ���������� ��������
      ::FileFindNext(search_handle,file_name);
     }
//--- ��������� ����� ������
   ::FileFindClose(search_handle);
  }
//+------------------------------------------------------------------+
//| �������� ������ ��������������� ��������                         |
//| ������������ �������� ������ ����                                |
//+------------------------------------------------------------------+
void CFileNavigator::AuxiliaryArraysResize(const int node_level)
  {
   int new_size=node_level+1;
   ::ArrayResize(m_l_prev_node_list_index,new_size);
   ::ArrayResize(m_l_item_text,new_size);
   ::ArrayResize(m_l_path,new_size);
   ::ArrayResize(m_l_item_index,new_size);
   ::ArrayResize(m_l_item_total,new_size);
   ::ArrayResize(m_l_folders_total,new_size);
//--- ������������� ���������� ��������
   m_l_prev_node_list_index[node_level] =0;
   m_l_item_text[node_level]            ="";
   m_l_path[node_level]                 ="";
   m_l_item_index[node_level]           =-1;
   m_l_item_total[node_level]           =0;
   m_l_folders_total[node_level]        =0;
  }
//+------------------------------------------------------------------+
//| ����������, �������� ��� ����� ��� �����                         |
//+------------------------------------------------------------------+
bool CFileNavigator::IsFolder(const string file_name)
  {
//--- ���� � ����� ���� ������� "\\", �� ��� �����
   if(::StringFind(file_name,"\\",0)>-1)
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| ������� ���������� ������ � ������� ����������                   |
//+------------------------------------------------------------------+
int CFileNavigator::ItemsTotal(const string search_path,const int search_area)
  {
   int    counter       =0;              // ������� ��������� 
   string file_name     ="";             // ��� �����
   long   search_handle =INVALID_HANDLE; // ����� ������
//--- �������� ������ ���� � ������� ����������
   search_handle=::FileFindFirst(search_path,file_name,search_area);
//--- ���� ���������� �� �����
   if(search_handle!=INVALID_HANDLE && file_name!="")
     {
      //--- ��������� ���������� �������� � ������� ����������
      counter++;
      while(::FileFindNext(search_handle,file_name))
         counter++;
     }
//--- ��������� ����� ������
   ::FileFindClose(search_handle);
   return(counter);
  }
//+------------------------------------------------------------------+
//| ������� ���������� ����� � ������� ����������                    |
//+------------------------------------------------------------------+
int CFileNavigator::FoldersTotal(const string search_path,const int search_area)
  {
   int    counter       =0;              // ������� ��������� 
   string file_name     ="";             // ��� �����
   long   search_handle =INVALID_HANDLE; // ����� ������
//--- �������� ������ ���� � ������� ����������
   search_handle=::FileFindFirst(search_path,file_name,search_area);
//--- ���� �� ����, �� � ����� ������� ���-�� �������� � ������� ����������
   if(search_handle!=INVALID_HANDLE && file_name!="")
     {
      //--- ���� ��� �����, �������� �������
      if(IsFolder(file_name))
         counter++;
      //--- �������� ����� �� ������ � ��������� ������ �����
      while(::FileFindNext(search_handle,file_name))
        {
         if(IsFolder(file_name))
            counter++;
        }
     }
//--- ��������� ����� ������
   ::FileFindClose(search_handle);
   return(counter);
  }
//+------------------------------------------------------------------+
//| ���������� ��������� ������ ����������� ����                     |
//| ������������ ���������� ����������                               |
//+------------------------------------------------------------------+
int CFileNavigator::PrevNodeItemIndex(const int root_index,const int node_level)
  {
   int prev_node_item_index=0;
//--- ���� �� � �������� ��������
   if(node_level>1)
      prev_node_item_index=m_l_item_index[node_level-1];
   else
     {
      //--- ���� �� ������ ������� ������
      if(root_index>0)
         prev_node_item_index=m_l_item_index[node_level-1];
     }
//--- ����� ��������� ������ ����������� ����
   return(prev_node_item_index);
  }
//+------------------------------------------------------------------+
//| ��������� ����� � ���������� ����������� � �������               |
//+------------------------------------------------------------------+
void CFileNavigator::AddItem(const int list_index,const string item_text,const int node_level,const int prev_node_item_index,
                             const int item_index,const int items_total,const int folders_total,const bool is_folder)
  {
//--- �������� ������ �������� �� ���� �������
   int array_size =::ArraySize(m_g_list_index);
   int new_size   =array_size+1;
   ::ArrayResize(m_g_prev_node_list_index,new_size);
   ::ArrayResize(m_g_list_index,new_size);
   ::ArrayResize(m_g_item_text,new_size);
   ::ArrayResize(m_g_item_index,new_size);
   ::ArrayResize(m_g_node_level,new_size);
   ::ArrayResize(m_g_prev_node_item_index,new_size);
   ::ArrayResize(m_g_items_total,new_size);
   ::ArrayResize(m_g_folders_total,new_size);
   ::ArrayResize(m_g_is_folder,new_size);
//--- �������� �������� ���������� ����������
   m_g_prev_node_list_index[array_size] =(node_level==0)? -1 : m_l_prev_node_list_index[node_level-1];
   m_g_list_index[array_size]           =list_index;
   m_g_item_text[array_size]            =item_text;
   m_g_item_index[array_size]           =item_index;
   m_g_node_level[array_size]           =node_level;
   m_g_prev_node_item_index[array_size] =prev_node_item_index;
   m_g_items_total[array_size]          =items_total;
   m_g_folders_total[array_size]        =folders_total;
   m_g_is_folder[array_size]            =is_folder;
  }
//+------------------------------------------------------------------+
//| ������� �� ��������� ����                                        |
//+------------------------------------------------------------------+
void CFileNavigator::ToNextNode(const int root_index,int list_index,int &node_level,
                                int &item_index,long &handle,const string item_text,const int search_area)
  {
//--- ������ ������ (* - ��������� ��� �����/�����)
   string filter="*";
//--- ���������� ����
   string search_path=m_l_path[node_level]+item_text+filter;
//--- ������� � �������� ������
   m_l_item_total[node_level]           =ItemsTotal(search_path,search_area);
   m_l_folders_total[node_level]        =FoldersTotal(search_path,search_area);
   m_l_item_text[node_level]            =item_text;
   m_l_item_index[node_level]           =item_index;
   m_l_prev_node_list_index[node_level] =list_index;
//--- ������� ������ ������ ����������� ����
   int prev_node_item_index=PrevNodeItemIndex(root_index,node_level);
//--- ������� ����� � ���������� ������� � ����� �������
   AddItem(list_index,item_text,node_level,prev_node_item_index,
           item_index,m_l_item_total[node_level],m_l_folders_total[node_level],true);
//--- �������� ������� �����
   node_level++;
//--- �������� ������ �������� �� ���� �������
   AuxiliaryArraysResize(node_level);
//--- ������� � �������� ������
   m_l_path[node_level]          =m_l_path[node_level-1]+item_text;
   m_l_item_total[node_level]    =ItemsTotal(m_l_path[node_level]+filter,search_area);
   m_l_folders_total[node_level] =FoldersTotal(m_l_path[node_level]+item_text+filter,search_area);
//--- �������� ������� ��������� ��������
   item_index=0;
//--- ��������� ����� ������
   ::FileFindClose(handle);
  }
//+------------------------------------------------------------------+
//| ����������� ���������                                            |
//+------------------------------------------------------------------+
void CFileNavigator::Moving(const int x,const int y)
  {
//--- �����, ���� ������� �����
   if(!CElement::IsVisible())
      return;
//--- ���������� �������� � ����� ��������
   CElement::X(x+CElement::XGap());
   CElement::Y(y+CElement::YGap());
//--- ���������� ��������� � ����� ��������
   m_address_bar.X(x+m_address_bar.XGap());
   m_address_bar.Y(y+m_address_bar.YGap());
//--- ���������� ��������� ����������� ��������
   m_address_bar.X_Distance(m_address_bar.X());
   m_address_bar.Y_Distance(m_address_bar.Y());
  }
//+------------------------------------------------------------------+
//| ���������� �������                                               |
//+------------------------------------------------------------------+
void CFileNavigator::Show(void)
  {
   m_address_bar.Timeframes(OBJ_ALL_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| �������� �������                                                 |
//+------------------------------------------------------------------+
void CFileNavigator::Hide(void)
  {
   m_address_bar.Timeframes(OBJ_NO_PERIODS);
//--- ��������� ���������
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
void CFileNavigator::Reset(void)
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
void CFileNavigator::Delete(void)
  {
//--- �������� ����������� ��������
   m_address_bar.Delete();
   m_treeview.Delete();
//--- ������������ �������� ��������
   ::ArrayFree(m_g_prev_node_list_index);
   ::ArrayFree(m_g_list_index);
   ::ArrayFree(m_g_item_text);
   ::ArrayFree(m_g_item_index);
   ::ArrayFree(m_g_node_level);
   ::ArrayFree(m_g_prev_node_item_index);
   ::ArrayFree(m_g_items_total);
   ::ArrayFree(m_g_folders_total);
   ::ArrayFree(m_g_item_state);
//---
   ::ArrayFree(m_l_prev_node_list_index);
   ::ArrayFree(m_l_item_text);
   ::ArrayFree(m_l_path);
   ::ArrayFree(m_l_item_index);
   ::ArrayFree(m_l_item_total);
   ::ArrayFree(m_l_folders_total);
//--- ������������ ������� ��������
   CElement::FreeObjectsArray();
//--- �������� ����������
   m_current_path="";
  }
//+------------------------------------------------------------------+
//| ��������� �����������                                            |
//+------------------------------------------------------------------+
void CFileNavigator::SetZorders(void)
  {
   m_address_bar.Z_Order(m_zorder);
   m_treeview.SetZorders();
  }
//+------------------------------------------------------------------+
//| ����� �����������                                                |
//+------------------------------------------------------------------+
void CFileNavigator::ResetZorders(void)
  {
   m_address_bar.Z_Order(0);
   m_treeview.ResetZorders();
  }
//+------------------------------------------------------------------+
