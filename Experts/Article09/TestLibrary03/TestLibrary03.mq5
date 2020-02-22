//+------------------------------------------------------------------+
//|                                                TestLibrary03.mq5 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "2016, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
//--- ����������� ������ �������� ������
#include "Program.mqh"
CProgram program;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(void)
  {
   program.OnInitEvent();
//--- ��������� �������� ������
   if(!program.CreateExpertPanel())
     {
      ::Print(__FUNCTION__," > �� ������� ������� ����������� ���������!");
      return(INIT_FAILED);
     }
//--- ������������� ������ �������
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   program.OnDeinitEvent(reason);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(void)
  {
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer(void)
  {
   program.OnTimerEvent();
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade(void)
  {
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int    id,
                  const long   &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   program.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
