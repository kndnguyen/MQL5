//+------------------------------------------------------------------+
//|                                                      Defines.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
//--- ��� ������
#define CLASS_NAME ::StringSubstr(__FUNCTION__,0,::StringFind(__FUNCTION__,"::"))
//--- ��� ���������
#define PROGRAM_NAME ::MQLInfoString(MQL_PROGRAM_NAME)
//--- ��� ���������
#define PROGRAM_TYPE (ENUM_PROGRAM_TYPE)::MQLInfoInteger(MQL_PROGRAM_TYPE)
//--- �������������� ������ �� ���������
#define PREVENTING_OUT_OF_RANGE __FUNCTION__," > �������������� ������ �� ������� �������."

//--- �����
#define FONT      ("Calibri")
#define FONT_SIZE (8)

//--- ��� ������� (������������)
#define TIMER_STEP_MSC (16)
//--- �������� ����� ���������� ��������� �������� (������������)
#define SPIN_DELAY_MSC (-450)

//--- �������������� �������
#define ON_WINDOW_UNROLL          (1)  // �������������� �����
#define ON_WINDOW_ROLLUP          (2)  // ������������ �����
#define ON_CLICK_MENU_ITEM        (4)  // ������� �� ������ ����
#define ON_CLICK_CONTEXTMENU_ITEM (5)  // ������� �� ������ ���� � ����������� ����
#define ON_HIDE_CONTEXTMENUS      (6)  // ������ ��� ����������� ����
#define ON_HIDE_BACK_CONTEXTMENUS (7)  // ������ ����������� ���� �� �������� ������ ����
#define ON_CLICK_BUTTON           (8)  // ������� �� ������
#define ON_CLICK_FREEMENU_ITEM    (9)  // ������� �� ������ ���������� ������������ ����
#define ON_CLICK_LABEL            (10) // ������� �� ��������� �����
#define ON_OPEN_DIALOG_BOX        (11) // ������� �������� ����������� ����
#define ON_CLOSE_DIALOG_BOX       (12) // ������� �������� ����������� ����
#define ON_RESET_WINDOW_COLORS    (13) // ����� ����� ����
#define ON_ZERO_PRIORITIES        (14) // ����� ����������� �� ������� ������ ����
#define ON_SET_PRIORITIES         (15) // �������������� ����������� �� ������� ������ ����
#define ON_CLICK_LIST_ITEM        (16) // ����� ������ � ������
#define ON_CLICK_COMBOBOX_ITEM    (17) // ����� ������ � ������ ����������
#define ON_END_EDIT               (18) // ��������� �������������� �������� � ���� �����
#define ON_CLICK_INC              (19) // ��������� �������� �����
#define ON_CLICK_DEC              (20) // ��������� �������� ����
#define ON_CLICK_COMBOBOX_BUTTON  (21) // ������� �� ������ �����-�����
#define ON_CHANGE_DATE            (22) // ��������� ���� � ���������
#define ON_CHANGE_TREE_PATH       (23) // ���� � ����������� ������ ������
#define ON_CHANGE_COLOR           (24) // ��������� ����� ����������� �������� �������
//+------------------------------------------------------------------+
