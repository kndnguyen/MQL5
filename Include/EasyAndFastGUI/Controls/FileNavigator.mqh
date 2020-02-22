//+------------------------------------------------------------------+
//|                                                FileNavigator.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "TreeView.mqh"
//+------------------------------------------------------------------+
//| Класс для создания файлового навигатора                          |
//+------------------------------------------------------------------+
class CFileNavigator : public CElement
  {
private:
   //--- Указатель на форму, к которой элемент присоединён
   CWindow          *m_wnd;
   //--- Объекты для создания элемента
   CRectCanvas       m_address_bar;
   CTreeView         m_treeview;
   //--- Основные массивы для хранения данных
   int               m_g_list_index[];           // общий индекс
   int               m_g_prev_node_list_index[]; // общий индекс предыдущего узла
   string            m_g_item_text[];            // имя папки/файла
   int               m_g_item_index[];           // локальный индекс
   int               m_g_node_level[];           // уровень узла
   int               m_g_prev_node_item_index[]; // локальный индекс предыдущего узла
   int               m_g_items_total[];          // всего элементов в папке
   int               m_g_folders_total[];        // количество папок в папке
   bool              m_g_is_folder[];            // признак папки
   bool              m_g_item_state[];           // состояние пункта (свёрнут/открыт)
   //--- Вспомогательные массивы для сбора данных
   int               m_l_prev_node_list_index[];
   string            m_l_item_text[];
   string            m_l_path[];
   int               m_l_item_index[];
   int               m_l_item_total[];
   int               m_l_folders_total[];
   //--- Ширина области древовидного списка
   int               m_treeview_area_width;
   //--- Ширина области содержания
   int               m_content_area_width;
   //--- Цвет фона и рамки фона
   color             m_area_color;
   color             m_area_border_color;
   //--- Цвет фона адресной строки
   color             m_address_bar_back_color;
   //--- Цвет текста в адресной строке
   color             m_address_bar_text_color;
   //--- Высота адресной строки
   int               m_address_bar_y_size;
   //--- Картинки для (1) папок и (2) файлов
   string            m_file_icon;
   string            m_folder_icon;
   //--- Текущий путь относительно файловой "песочницы" терминала
   string            m_current_path;
   //--- Текущий полный путь относительно файловой системы включая метку тома жёсткого диска
   string            m_current_full_path;
   //--- Область текущей директории
   int               m_directory_area;
   //--- Приоритеты на нажатие левой кнопки мыши
   int               m_zorder;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Режим содержания файлового навигатора
   ENUM_FILE_NAVIGATOR_CONTENT m_navigator_content;
   //---
public:
                     CFileNavigator(void);
                    ~CFileNavigator(void);
   //--- Методы для создания файлового навигатора
   bool              CreateFileNavigator(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateAddressBar(void);
   bool              CreateTreeView(void);
   //---
public:
   //--- (1) Сохраняет указатель формы, (2) возвращает указатель древовидного списка
   void              WindowPointer(CWindow &object)                           { m_wnd=::GetPointer(object);                }
   CTreeView        *TreeViewPointer(void)                                    { return(::GetPointer(m_treeview));          }
   //--- (1) Режим навигатора (Показывать все/Только папки), (2) содержание навигатора (Общая папка/Локальная/Всё)
   void              NavigatorMode(const ENUM_FILE_NAVIGATOR_MODE mode)       { m_treeview.NavigatorMode(mode);            }
   void              NavigatorContent(const ENUM_FILE_NAVIGATOR_CONTENT mode) { m_navigator_content=mode;                  }
   //--- (1) Высота адресной строки, (2) ширина древовидного списка и (3) списка содержания
   void              AddressBarYSize(const int y_size)                        { m_address_bar_y_size=y_size;               }
   void              TreeViewAreaWidth(const int x_size)                      { m_treeview_area_width=x_size;              }
   void              ContentAreaWidth(const int x_size)                       { m_content_area_width=x_size;               }
   //--- (1) Цвет фона и (2) рамки фона
   void              AreaBackColor(const color clr)                           { m_area_color=clr;                          }
   void              AreaBorderColor(const color clr)                         { m_area_border_color=clr;                   }
   //--- (1) Цвет фона и (2) текста адресной строки
   void              AddressBarBackColor(const color clr)                     { m_address_bar_back_color=clr;              }
   void              AddressBarTextColor(const color clr)                     { m_address_bar_text_color=clr;              }
   //--- Установка пути к файлам для (1) файлов и (2) папок
   void              FileIcon(const string file_path)                         { m_file_icon=file_path;                     }
   void              FolderIcon(const string file_path)                       { m_folder_icon=file_path;                   }
   //--- Возвращает (1) текущий путь и (2) полный путь, (3) выделенный файл
   string            CurrentPath(void)                                  const { return(m_current_path);                    }
   string            CurrentFullPath(void)                              const { return(m_current_full_path);               }
   //--- Возвращает (1) область директории и (2) выделенный файл
   int               DirectoryArea(void)                                const { return(m_directory_area);                  }
   string            SelectedFile(void)                                 const { return(m_treeview.SelectedItemFileName()); }
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Таймер
   virtual void      OnEventTimer(void) {}
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
   //--- Обработка события выбора нового пути в древовидном списке
   void              OnChangeTreePath(void);

   //--- Рисует рамку для адресной строки
   void              Border(void);
   //--- Отображает текущий путь в адресной строке
   void              UpdateAddressBar(void);

   //--- Заполняет массивы параметрами элементов файловой системы терминала
   void              FillArraysData(void);
   //--- Читает файловую систему и записывает параметры в массивы
   void              FileSystemScan(const int root_index,int &list_index,int &node_level,int &item_index,int search_area);
   //--- Изменяет размер вспомогательных массивов относительно текущего уровня узла 
   void              AuxiliaryArraysResize(const int node_level);
   //--- Определяет, передано имя папки или файла
   bool              IsFolder(const string file_name);
   //--- Возвращает количество (1) элементов и (2) папок в указанной директории
   int               ItemsTotal(const string search_path,const int mode);
   int               FoldersTotal(const string search_path,const int mode);
   //--- Возвращает локальный индекс предыдущего узла относительно переданных параметров
   int               PrevNodeItemIndex(const int root_index,const int node_level);

   //--- Добавляет пункт в массивы
   void              AddItem(const int list_index,const string item_text,const int node_level,const int prev_node_item_index,
                             const int item_index,const int items_total,const int folders_total,const bool is_folder);
   //--- Переход на следующий узел
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
//--- Сохраним имя класса элемента в базовом классе
   CElement::ClassName(CLASS_NAME);
//--- Установим приоритеты на нажатие левой кнопки мыши
   m_zorder=0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CFileNavigator::~CFileNavigator(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CFileNavigator::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события "Изменение пути в древовидном списке"
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_TREE_PATH)
     {
      OnChangeTreePath();
      return;
     }
  }
//+------------------------------------------------------------------+
//| Создаёт файловый навигатор                                       |
//+------------------------------------------------------------------+
bool CFileNavigator::CreateFileNavigator(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Выйти, если нет указателя на форму
   if(::CheckPointer(m_wnd)==POINTER_INVALID)
     {
      ::Print(__FUNCTION__," > Перед созданием файлового навигатора ему нужно передать "
              "указатель на форму: CFileNavigator::WindowPointer(CWindow &object).");
      return(false);
     }
//--- Сканируем файловую систему терминала и заносим данные в массивы
   FillArraysData();
//--- Инициализация переменных
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Отступы от крайней точки
   CElement::XGap(CElement::X()-m_wnd.X());
   CElement::YGap(CElement::Y()-m_wnd.Y());
//--- Создание элемента
   if(!CreateAddressBar())
      return(false);
   if(!CreateTreeView())
      return(false);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт адресную строку                                          |
//+------------------------------------------------------------------+
bool CFileNavigator::CreateAddressBar(void)
  {
//--- Формирование имени объекта
   string name=CElement::ProgramName()+"_file_navigator_address_bar_"+(string)CElement::Id();
//--- Координаты
   int x =CElement::X();
   int y =CElement::Y();
//--- Размеры:
//    Рассчитаем ширину
   int x_size=0;
//--- Если области содержания не будет
   if(m_content_area_width<0)
      x_size=m_treeview_area_width;
   else
     {
      //--- Если указана конкретная ширина области содержания
      if(m_content_area_width>0)
         x_size=m_treeview_area_width+m_content_area_width-1;
      //--- Если правый край области содержания должен быть у правого края формы
      else
         x_size=m_wnd.X2()-x-2;
     }
//--- Высота
   int y_size=m_address_bar_y_size;
//--- Создание объекта
   if(!m_address_bar.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,x_size,y_size,COLOR_FORMAT_XRGB_NOALPHA))
      return(false);
//--- Прикрепить к графику
   if(!m_address_bar.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Установим свойства
   m_address_bar.Background(false);
   m_address_bar.Z_Order(m_zorder);
   m_address_bar.Tooltip("\n");
//--- Сохраним размеры
   CElement::X(x);
   CElement::Y(y);
//--- Сохраним размеры
   CElement::XSize(x_size);
   CElement::YSize(y_size);
//--- Отступы от крайней точки
   m_address_bar.XGap(x-m_wnd.X());
   m_address_bar.YGap(y-m_wnd.Y());
//--- Обновить адресную строку
   UpdateAddressBar();
//--- Сохраним указатель объекта
   CElement::AddToArray(m_address_bar);
//--- Скрыть элемент, если окно диалоговое или оно минимизировано
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      m_address_bar.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт древовидный список                                       |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\folder.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\text_file.bmp"
//---
bool CFileNavigator::CreateTreeView(void)
  {
//--- Сохраним указатель на окно
   m_treeview.WindowPointer(m_wnd);
//--- Установим свойства
   m_treeview.Id(CElement::Id());
   m_treeview.XSize(CElement::XSize());
   m_treeview.YSize(CElement::YSize());
   m_treeview.ResizeListAreaMode(true);
   m_treeview.TreeViewAreaWidth(m_treeview_area_width);
   m_treeview.ContentAreaWidth(m_content_area_width);
//--- Формируем массивы древовидного списка
   int items_total=::ArraySize(m_g_item_text);
   for(int i=0; i<items_total; i++)
     {
      //--- Определим картинку для пункта (папка/файл)
      string icon_path=(m_g_is_folder[i])? m_folder_icon : m_file_icon;
      //--- Если это папка, удалим последний символ ('\') в строке 
      if(m_g_is_folder[i])
         m_g_item_text[i]=::StringSubstr(m_g_item_text[i],0,::StringLen(m_g_item_text[i])-1);
      //--- Добавим пункт в древовидный список
      m_treeview.AddItem(i,m_g_prev_node_list_index[i],m_g_item_text[i],icon_path,m_g_item_index[i],
                         m_g_node_level[i],m_g_prev_node_item_index[i],m_g_items_total[i],m_g_folders_total[i],false,m_g_is_folder[i]);
     }
//--- Создать древовидный список
   if(!m_treeview.CreateTreeView(m_chart_id,m_subwin,m_x,m_y+m_address_bar_y_size))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка события выбора нового пути в древовидном списке        |
//+------------------------------------------------------------------+
void CFileNavigator::OnChangeTreePath(void)
  {
//--- Получим текущий путь
   string path=m_treeview.CurrentFullPath();
//--- Если это общая папка терминалов
   if(::StringFind(path,"Common\\Files\\",0)>-1)
     {
      //--- Получим адрес общей папки терминалов
      string common_path=::TerminalInfoString(TERMINAL_COMMONDATA_PATH);
      //--- Удалим в строке (принятой в событии) префикс "Common\"
      path=::StringSubstr(path,7,::StringLen(common_path)-7);
      //--- Сформируем путь (краткую и полную версию)
      m_current_path      =::StringSubstr(path,6,::StringLen(path)-6);
      m_current_full_path =common_path+"\\"+path;
      //--- Сохраним область директории
      m_directory_area=FILE_COMMON;
     }
//--- Если это локальная папка терминала
   else if(::StringFind(path,"MQL5\\Files\\",0)>-1)
     {
      //--- Получим адрес данных в локальной папке терминала
      string local_path=::TerminalInfoString(TERMINAL_DATA_PATH);
      //--- Сформируем путь (краткую и полную версию)
      m_current_path      =::StringSubstr(path,11,::StringLen(path)-11);
      m_current_full_path =local_path+"\\"+path;
      //--- Сохраним область директории
      m_directory_area=0;
     }
//--- Отобразим текущий путь в адресной строке
   UpdateAddressBar();
  }
//+------------------------------------------------------------------+
//| Рисует рамку для адресной строки                                 |
//+------------------------------------------------------------------+
void CFileNavigator::Border(void)
  {
//--- Координаты
   int  x1=0,x2=0,y1=0,y2=0;
//--- Цвет фона
   uint clr=::ColorToARGB(m_area_border_color);
//--- Размеры
   int x_size =m_x_size;
   int y_size =m_address_bar_y_size;
//--- Слева
   for(int i=y_size; i>=0; i--)
     {
      //--- Координаты
      x1=0; x2=i; y1=0; y2=i;
      //--- Нарисовать линию
      m_address_bar.Line(x1,x2,y1,y2,clr);
     }
//--- Сверху
   for(int i=0; i<x_size; i++)
     {
      //--- Координаты
      x1=i; x2=0; y1=i; y2=0;
      //--- Нарисовать линию
      m_address_bar.Line(x1,x2,y1,y2,clr);
     }
//--- Справа
   for(int i=0; i<y_size; i++)
     {
      //--- Координаты
      x1=x_size-1; x2=i; y1=x_size-1; y2=i;
      //--- Нарисовать линию
      m_address_bar.Line(x1,x2,y1,y2,clr);
     }
  }
//+------------------------------------------------------------------+
//| Отображает текущий путь в адресной строке                        |
//+------------------------------------------------------------------+
void CFileNavigator::UpdateAddressBar(void)
  {
//--- Координаты
   int x=5;
   int y=m_address_bar_y_size/2;
//--- Очистить фон
   m_address_bar.Erase(::ColorToARGB(m_address_bar_back_color,0));
//--- Нарисовать рамку фона
   Border();
//--- Свойства текста
   m_address_bar.FontSet("Calibri",14,FW_NORMAL);
//--- Если путь ещё не установлен, показать строку по умолчанию
   if(m_current_full_path=="")
      m_current_full_path="Loading. Please wait...";
//--- Выведем путь в адресную строку файлового навигатора
   m_address_bar.TextOut(x,y,m_current_full_path,::ColorToARGB(m_address_bar_text_color),TA_LEFT|TA_VCENTER);
//--- Обновим холст для рисования
   m_address_bar.Update();
  }
//+------------------------------------------------------------------+
//| Заполняет массивы параметрами элементов файловой системы         |
//+------------------------------------------------------------------+
void CFileNavigator::FillArraysData(void)
  {
//--- Счётчики (1) общих индексов, (2) уровней узлов, (3) локальных индексов
   int list_index =0;
   int node_level =0;
   int item_index =0;
//--- Если нужно отображать обе директории (Общая (0)/Локальная (1))
   int begin=0,end=1;
//--- Если нужно отображать содержимое только локальной директории
   if(m_navigator_content==FN_ONLY_MQL)
      begin=1;
//--- Если нужно отображать содержимое только общей директории
   else if(m_navigator_content==FN_ONLY_COMMON)
      begin=end=0;
//--- Пройдёмся по указанным директориям
   for(int root_index=begin; root_index<=end; root_index++)
     {
      //--- Определим директорию для сканирования файловой структуры
      int search_area=(root_index>0) ? 0 : FILE_COMMON;
      //--- Обнулим счётчик локальных индексов
      item_index=0;
      //--- Увеличим размер массивов на один элемент (относительно уровня узла)
      AuxiliaryArraysResize(node_level);
      //--- Получим кол-во файлов и папок в указанной директории (* - проверить все файлы/папки)
      string search_path   =m_l_path[0]+"*";
      m_l_item_total[0]    =ItemsTotal(search_path,search_area);
      m_l_folders_total[0] =FoldersTotal(search_path,search_area);
      //--- Добавим пункт с названием корневого каталога в начало списка
      string item_text=(root_index>0)? "MQL5\\Files\\" : "Common\\Files\\";
      AddItem(list_index,item_text,0,0,root_index,m_l_item_total[0],m_l_folders_total[0],true);
      //--- Увеличим счётчики общих индексов и уровней узлов
      list_index++;
      node_level++;
      //--- Увеличим размер массивов на один элемент (относительно уровня узла)
      AuxiliaryArraysResize(node_level);
      //--- Инициализация первых элементов для директории локальной папки терминала
      if(root_index>0)
        {
         m_l_item_index[0]           =root_index;
         m_l_prev_node_list_index[0] =list_index-1;
        }
      //--- Сканируем директории и заносим данные в массивы
      FileSystemScan(root_index,list_index,node_level,item_index,search_area);
     }
  }
//+------------------------------------------------------------------+
//| Читает файловую систему терминала и записывает                   |
//| параметры элементов в массивы                                    |
//+------------------------------------------------------------------+
void CFileNavigator::FileSystemScan(const int root_index,int &list_index,int &node_level,int &item_index,int search_area)
  {
   long   search_handle =INVALID_HANDLE; // Хэндл поиска папки/файла
   string file_name     ="";             // Имя найденного элемента (файла/папки)
   string filter        ="*";            // Фильтр поиска (* - проверить все файлы/папки)
//--- Сканируем директории и заносим данные в массивы
   while(!::IsStopped())
     {
      //--- Если это начало списка директории
      if(item_index==0)
        {
         //--- Путь для поиска всех элементов
         string search_path=m_l_path[node_level]+filter;
         //--- Получаем хэндл и имя первого файла
         search_handle=::FileFindFirst(search_path,file_name,search_area);
         //--- Получим кол-во файлов и папок в указанной директории
         m_l_item_total[node_level]    =ItemsTotal(search_path,search_area);
         m_l_folders_total[node_level] =FoldersTotal(search_path,search_area);
        }
      //--- Если индекс этого узла уже был, перейдём к следующему файлу
      if(m_l_item_index[node_level]>-1 && item_index<=m_l_item_index[node_level])
        {
         //--- Увеличим счётчик локальных индексов
         item_index++;
         //--- Переходим к следующему элементу
         ::FileFindNext(search_handle,file_name);
         continue;
        }
      //--- Если дошли до конца списка в корневом узле, закончим цикл
      if(node_level==1 && item_index>=m_l_item_total[node_level])
          break;
      //--- Если дошли до конца списка в любом узле, кроме корневого
      else if(item_index>=m_l_item_total[node_level])
        {
         //--- Перевести счётчик узлов на один уровень назад
         node_level--;
         //--- Обнулить счётчик локальных индексов
         item_index=0;
         //--- Закрываем хэндл поиска
         ::FileFindClose(search_handle);
         continue;
        }
      //--- Если это папка
      if(IsFolder(file_name))
        {
         //--- Перейдём на следующий узел
         ToNextNode(root_index,list_index,node_level,item_index,search_handle,file_name,search_area);
         //--- Увеличить счётчик общих индексов и начать новую итерацию
         list_index++;
         continue;
        }
      //--- Получим локальный индекс предыдущего узла
      int prev_node_item_index=PrevNodeItemIndex(root_index,node_level);
      //--- Добавим пункт с указанными данными в общие массивы
      AddItem(list_index,file_name,node_level,prev_node_item_index,item_index,0,0,false);
      //--- Увеличим счётчик общих индексов
      list_index++;
      //--- Увеличим счётчик локальных индексов
      item_index++;
      //--- Переходим к следующему элементу
      ::FileFindNext(search_handle,file_name);
     }
//--- Закрываем хэндл поиска
   ::FileFindClose(search_handle);
  }
//+------------------------------------------------------------------+
//| Изменяет размер вспомогательных массивов                         |
//| относительно текущего уровня узла                                |
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
//--- Инициализация последнего значения
   m_l_prev_node_list_index[node_level] =0;
   m_l_item_text[node_level]            ="";
   m_l_path[node_level]                 ="";
   m_l_item_index[node_level]           =-1;
   m_l_item_total[node_level]           =0;
   m_l_folders_total[node_level]        =0;
  }
//+------------------------------------------------------------------+
//| Определяет, передано имя папки или файла                         |
//+------------------------------------------------------------------+
bool CFileNavigator::IsFolder(const string file_name)
  {
//--- Если в имени есть символы "\\", то это папка
   if(::StringFind(file_name,"\\",0)>-1)
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Считает количество файлов в текущей директории                   |
//+------------------------------------------------------------------+
int CFileNavigator::ItemsTotal(const string search_path,const int search_area)
  {
   int    counter       =0;              // счётчик элементов 
   string file_name     ="";             // имя файла
   long   search_handle =INVALID_HANDLE; // хэндл поиска
//--- Получаем первый файл в текущей директории
   search_handle=::FileFindFirst(search_path,file_name,search_area);
//--- Если директория не пуста
   if(search_handle!=INVALID_HANDLE && file_name!="")
     {
      //--- Посчитаем количество объектов в текущей директории
      counter++;
      while(::FileFindNext(search_handle,file_name))
         counter++;
     }
//--- Закрываем хэндл поиска
   ::FileFindClose(search_handle);
   return(counter);
  }
//+------------------------------------------------------------------+
//| Считает количество папок в текущей директории                    |
//+------------------------------------------------------------------+
int CFileNavigator::FoldersTotal(const string search_path,const int search_area)
  {
   int    counter       =0;              // счётчик элементов 
   string file_name     ="";             // имя файла
   long   search_handle =INVALID_HANDLE; // хэндл поиска
//--- Получаем первый файл в текущей директории
   search_handle=::FileFindFirst(search_path,file_name,search_area);
//--- Если не путо, то в цикле считаем кол-во объектов в текущей директории
   if(search_handle!=INVALID_HANDLE && file_name!="")
     {
      //--- Если это папка, увеличим счётчик
      if(IsFolder(file_name))
         counter++;
      //--- Пройдёмся далее по списку и посчитаем другие папки
      while(::FileFindNext(search_handle,file_name))
        {
         if(IsFolder(file_name))
            counter++;
        }
     }
//--- Закрываем хэндл поиска
   ::FileFindClose(search_handle);
   return(counter);
  }
//+------------------------------------------------------------------+
//| Возвращает локальный индекс предыдущего узла                     |
//| относительно переданных параметров                               |
//+------------------------------------------------------------------+
int CFileNavigator::PrevNodeItemIndex(const int root_index,const int node_level)
  {
   int prev_node_item_index=0;
//--- Если не в корневом каталоге
   if(node_level>1)
      prev_node_item_index=m_l_item_index[node_level-1];
   else
     {
      //--- Если не первый элемент списка
      if(root_index>0)
         prev_node_item_index=m_l_item_index[node_level-1];
     }
//--- Вернём локальный индекс предыдущего узла
   return(prev_node_item_index);
  }
//+------------------------------------------------------------------+
//| Добавляет пункт с указанными параметрами в массивы               |
//+------------------------------------------------------------------+
void CFileNavigator::AddItem(const int list_index,const string item_text,const int node_level,const int prev_node_item_index,
                             const int item_index,const int items_total,const int folders_total,const bool is_folder)
  {
//--- Увеличим размер массивов на один элемент
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
//--- Сохраним значения переданных параметров
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
//| Переход на следующий узел                                        |
//+------------------------------------------------------------------+
void CFileNavigator::ToNextNode(const int root_index,int list_index,int &node_level,
                                int &item_index,long &handle,const string item_text,const int search_area)
  {
//--- Фильтр поиска (* - проверить все файлы/папки)
   string filter="*";
//--- Сформируем путь
   string search_path=m_l_path[node_level]+item_text+filter;
//--- Получим и сохраним данные
   m_l_item_total[node_level]           =ItemsTotal(search_path,search_area);
   m_l_folders_total[node_level]        =FoldersTotal(search_path,search_area);
   m_l_item_text[node_level]            =item_text;
   m_l_item_index[node_level]           =item_index;
   m_l_prev_node_list_index[node_level] =list_index;
//--- Получим индекс пункта предыдущего узла
   int prev_node_item_index=PrevNodeItemIndex(root_index,node_level);
//--- Добавим пункт с указанными данными в общие массивы
   AddItem(list_index,item_text,node_level,prev_node_item_index,
           item_index,m_l_item_total[node_level],m_l_folders_total[node_level],true);
//--- Увеличим счётчик узлов
   node_level++;
//--- Увеличим размер массивов на один элемент
   AuxiliaryArraysResize(node_level);
//--- Получим и сохраним данные
   m_l_path[node_level]          =m_l_path[node_level-1]+item_text;
   m_l_item_total[node_level]    =ItemsTotal(m_l_path[node_level]+filter,search_area);
   m_l_folders_total[node_level] =FoldersTotal(m_l_path[node_level]+item_text+filter,search_area);
//--- Обнулить счётчик локальных индексов
   item_index=0;
//--- Закрываем хэндл поиска
   ::FileFindClose(handle);
  }
//+------------------------------------------------------------------+
//| Перемещение элементов                                            |
//+------------------------------------------------------------------+
void CFileNavigator::Moving(const int x,const int y)
  {
//--- Выйти, если элемент скрыт
   if(!CElement::IsVisible())
      return;
//--- Сохранение отступов в полях элемента
   CElement::X(x+CElement::XGap());
   CElement::Y(y+CElement::YGap());
//--- Сохранение координат в полях объектов
   m_address_bar.X(x+m_address_bar.XGap());
   m_address_bar.Y(y+m_address_bar.YGap());
//--- Обновление координат графических объектов
   m_address_bar.X_Distance(m_address_bar.X());
   m_address_bar.Y_Distance(m_address_bar.Y());
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CFileNavigator::Show(void)
  {
   m_address_bar.Timeframes(OBJ_ALL_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CFileNavigator::Hide(void)
  {
   m_address_bar.Timeframes(OBJ_NO_PERIODS);
//--- Состояние видимости
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Перерисовка                                                      |
//+------------------------------------------------------------------+
void CFileNavigator::Reset(void)
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
void CFileNavigator::Delete(void)
  {
//--- Удаление графических объектов
   m_address_bar.Delete();
   m_treeview.Delete();
//--- Освобождение массивов элемента
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
//--- Освобождение массива объектов
   CElement::FreeObjectsArray();
//--- Обнулить переменные
   m_current_path="";
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CFileNavigator::SetZorders(void)
  {
   m_address_bar.Z_Order(m_zorder);
   m_treeview.SetZorders();
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CFileNavigator::ResetZorders(void)
  {
   m_address_bar.Z_Order(0);
   m_treeview.ResetZorders();
  }
//+------------------------------------------------------------------+
