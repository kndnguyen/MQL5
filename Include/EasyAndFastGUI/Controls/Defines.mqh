//+------------------------------------------------------------------+
//|                                                      Defines.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
//--- Имя класса
#define CLASS_NAME ::StringSubstr(__FUNCTION__,0,::StringFind(__FUNCTION__,"::"))
//--- Имя программы
#define PROGRAM_NAME ::MQLInfoString(MQL_PROGRAM_NAME)
//--- Тип программы
#define PROGRAM_TYPE (ENUM_PROGRAM_TYPE)::MQLInfoInteger(MQL_PROGRAM_TYPE)
//--- Предотвращение выхода из диапазона
#define PREVENTING_OUT_OF_RANGE __FUNCTION__," > Предотвращение выхода за пределы массива."

//--- Шрифт
#define FONT      ("Calibri")
#define FONT_SIZE (8)

//--- Шаг таймера (миллисекунды)
#define TIMER_STEP_MSC (16)
//--- Задержка перед включением перемотки счётчика (миллисекунды)
#define SPIN_DELAY_MSC (-450)

//--- Идентификаторы событий
#define ON_WINDOW_UNROLL          (1)  // Разворачивание формы
#define ON_WINDOW_ROLLUP          (2)  // Сворачивание формы
#define ON_CLICK_MENU_ITEM        (4)  // Нажатие на пункте меню
#define ON_CLICK_CONTEXTMENU_ITEM (5)  // Нажатие на пункте меню в контекстном меню
#define ON_HIDE_CONTEXTMENUS      (6)  // Скрыть все контекстные меню
#define ON_HIDE_BACK_CONTEXTMENUS (7)  // Скрыть контекстные меню от текущего пункта меню
#define ON_CLICK_BUTTON           (8)  // Нажатие на кнопке
#define ON_CLICK_FREEMENU_ITEM    (9)  // Нажатие на пункте свободного контекстного меню
#define ON_CLICK_LABEL            (10) // Нажатие на текстовой метке
#define ON_OPEN_DIALOG_BOX        (11) // Событие открытия диалогового окна
#define ON_CLOSE_DIALOG_BOX       (12) // Событие закрытия диалогового окна
#define ON_RESET_WINDOW_COLORS    (13) // Сброс цвета окна
#define ON_ZERO_PRIORITIES        (14) // Сброс приоритетов на нажатие кнопки мыши
#define ON_SET_PRIORITIES         (15) // Восстановление приоритетов на нажатие кнопки мыши
#define ON_CLICK_LIST_ITEM        (16) // Выбор пункта в списке
#define ON_CLICK_COMBOBOX_ITEM    (17) // Выбор пункта в списке комбобокса
#define ON_END_EDIT               (18) // Окончание редактирования значения в поле ввода
#define ON_CLICK_INC              (19) // Изменение счётчика вверх
#define ON_CLICK_DEC              (20) // Изменение счётчика вниз
#define ON_CLICK_COMBOBOX_BUTTON  (21) // Нажатие на кнопке комбо-бокса
#define ON_CHANGE_DATE            (22) // Изменение даты в календаре
#define ON_CHANGE_TREE_PATH       (23) // Путь в древовидном списке изменён
#define ON_CHANGE_COLOR           (24) // Изменение цвета посредством цветовой палитры
//+------------------------------------------------------------------+
