//+------------------------------------------------------------------+
//|                                                  KhoaLibrary.mq4 |
//|                                                      Khoa Nguyen |
//|                                                                  |
//+------------------------------------------------------------------+
#property library
#property copyright "Khoa Nguyen"
#property version   "1.40"

//+------------------------------------------------------------------+
//| Enumeration and definitions
//+------------------------------------------------------------------+
enum ORDER_TYPE
{
   BUY_ORDER=1,
   SELL_ORDER=-1,
   NO_ORDER=0,
};

enum TRADE_DIRECTION {
   LONG=1,
   SHORT=-1,
   BOTH=0,
};

enum ENTRY_TYPE
{
   IMMEDIATE=0,
   PENDING_STOP=1,
   PENDING_LIMIT=2,
};

//+------------------------------------------------------------------+
//| Function to set 3 digits or 5 digits depending to Broker
//| 26/08/2019: Include Digits = 2 for commodity and cryptocurrentcy tradings
//+------------------------------------------------------------------+
double fn_SetMyPoint()
{
   double myPoint=Point();
   if(Digits()==3 || Digits()==5){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 10");
      myPoint=Point()*10;
   }else if(Digits==2){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 100");
      myPoint=Point()*100;
   }
   return(myPoint);
}

//+------------------------------------------------------------------+
//| Function to return an array containing Pip Value | Spreads in pips | Min Stop Loss in pips 
//| 26/08/2019: Implementation
//+------------------------------------------------------------------+
bool fn_GetMarketInfo(double &marketInfo[],double lotSize)
{
   if(Digits()==3 || Digits()==5){
      //Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Values of Pip values, MIN SL [pips] and SPREAD [pips] will be devided by 10");
      marketInfo[0]  = MarketInfo(Symbol(),MODE_TICKVALUE)*0.1*(lotSize/0.01);            //Pip value: Value of a pip based on standard 0.01 lotSize      
      marketInfo[1]  = MarketInfo(Symbol(),MODE_SPREAD)*0.1;                              //Broker spread in pips
      marketInfo[2]  = MarketInfo(Symbol(),MODE_STOPLEVEL)*0.1;                           //Broker minimum StopLoss in pips
   }else if(Digits==2){
      //Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Values of Pip values, MIN SL [pips] and SPREAD [pips] will be devided by 100");
      marketInfo[0]  = MarketInfo(Symbol(),MODE_TICKVALUE)*0.01*(lotSize/0.01);            //Pip value: Value of a pip based on standard 0.01 lotSize      
      marketInfo[1]  = MarketInfo(Symbol(),MODE_SPREAD)*0.01;                              //Broker spread in pips
      marketInfo[2]  = MarketInfo(Symbol(),MODE_STOPLEVEL)*0.01;                           //Broker minimum StopLoss in pips
   }
   return(true);
}


//+------------------------------------------------------------------+
// Function to check if its a new candle
//+------------------------------------------------------------------+
bool fn_IsNewCandle()
{
   static int BarsOnChart=0;
	if (Bars == BarsOnChart)
	return (false);
	BarsOnChart = Bars;
	return(true);
}

//+------------------------------------------------------------------+
//| Function to generate Magic Number
//+------------------------------------------------------------------+
int fn_GenerateMagicNumber(int trial)
{
   int result=0; 
   result = MathRand();
   
   while(trial<=10){
      for(int i=0;i<OrdersTotal();i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderCloseTime()==0 && OrderMagicNumber()==result){
               result = MathRand();
            }
         }
      }
      trial++;
   }
   return result;
}


//+------------------------------------------------------------------+
//| Function to create order using pre-computed price
//+------------------------------------------------------------------+
int fn_OrderEntry_1(ORDER_TYPE orderDirection
                ,double orderSize
                //,double orderEntryPrice
                ,double orderSLPrice
                ,double orderTPPrice
                ,string orderComment
                ,int    orderMagicNum
                )
{
   int ticket=0;
   double orderEntryPrice=0;
   
   if(orderDirection==BUY_ORDER){
      orderEntryPrice=Ask;
      ticket=OrderSend(Symbol(),OP_BUY,orderSize,orderEntryPrice,5,orderSLPrice,orderTPPrice,orderComment,orderMagicNum,0,clrGreen);
      
      if(ticket>0){
         if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)){
            Print(orderComment," Order #",ticket," opened at price:",DoubleToString(orderEntryPrice,5),"-Size:",DoubleToString(orderSize,2),"-SL:",DoubleToString(orderSLPrice,5));
         }
      }else{
         fn_SendNotification("OrderEntry_1-Error opening BUY order : " + GetLastError(),true,true,false);
         ticket=-1;
      }
   }
   else
   if(orderDirection==SELL_ORDER){
      orderEntryPrice=Bid;
      ticket=OrderSend(Symbol(),OP_SELL,orderSize,orderEntryPrice,5,orderSLPrice,orderTPPrice,orderComment,orderMagicNum,0,clrGreen);
      
      if(ticket>0){
         if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)){
            Print(orderComment," Order #",ticket," opened at price:",DoubleToString(orderEntryPrice,5),"-Size:",DoubleToString(orderSize,2),"-SL:",DoubleToString(orderSLPrice,5));
         }
      }else{
         fn_SendNotification("OrderEntry_1-Error opening SELL order : " + GetLastError(),true,true,false);
         ticket=-1;
      }
   }
   
   return ticket; 
}

//+------------------------------------------------------------------+
//| Function to create order using pips
//+------------------------------------------------------------------+
int fn_OrderEntry_2(ORDER_TYPE orderDirection
                ,double orderSize
                //,double orderEntryPrice
                ,double orderSLPips
                ,double orderTPPips
                ,string orderComment
                ,int    orderMagicNum
                ,double myPoint
                )
{
   int ticket=0;
   double orderEntryPrice=0;
   double orderSLPrice=0;
   double orderTPPrice=0;
   
   if(orderDirection==BUY_ORDER){
      
      orderEntryPrice=Ask;
      orderSLPrice=orderEntryPrice - orderSLPips*myPoint;
      orderTPPrice=orderEntryPrice + orderTPPips*myPoint;
      
      ticket=OrderSend(Symbol(),OP_BUY,orderSize,orderEntryPrice,10,orderSLPrice,orderTPPrice,orderComment,orderMagicNum,0,clrGreen);
      
      if(ticket>0)
         if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
            Print(orderComment," Order #",ticket," opened at price:",DoubleToString(orderEntryPrice,5),"-Size:",DoubleToString(orderSize,2),"-SL:",DoubleToString(orderSLPrice,5));
      else{
         Print("OrderEntry_2-Error opening BUY order : ",GetLastError());
         Alert("OrderEntry_2-Error opening BUY order : ",GetLastError());
         ticket=-1;
      }
   }
   else
   if(orderDirection==SELL_ORDER){
      orderEntryPrice=Bid;
      orderSLPrice=orderEntryPrice + orderSLPips*myPoint;
      orderTPPrice=orderEntryPrice - orderTPPips*myPoint;
      
      ticket=OrderSend(Symbol(),OP_SELL,orderSize,orderEntryPrice,10,orderSLPrice,orderTPPrice,orderComment,orderMagicNum,0,clrGreen);
      
      if(ticket>0)
         if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
            Print(orderComment," Order #",ticket," opened at price:",DoubleToString(orderEntryPrice,5),"-Size:",DoubleToString(orderSize,2),"-SL:",DoubleToString(orderSLPrice,5));
      else{
         Print("OrderEntry_2-Error opening SELL order : ",GetLastError());
         Alert("OrderEntry_2-Error opening SELL order : ",GetLastError());
         ticket=-1;
      }
   }
   
   return ticket; 
}


//+------------------------------------------------------------------+
//| Function to return Total running profit/loss in pips
//+------------------------------------------------------------------+
int fn_GetRunningProfitLossPip(int magicNumber,double myPoint)
{
   int result=0;
   double totPips=0;

   for(int i=0;i < OrdersTotal();i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(fn_IsOrderOpened(OrderTicket(),magicNumber)==true){
            if(OrderType()==OP_BUY){
               totPips += (Bid - OrderOpenPrice())/myPoint;
            }else
            if(OrderType()==OP_SELL){
               totPips += (OrderOpenPrice()-Ask)/myPoint;         
            }        
         }
      }
   }
   
   result = totPips;

   return result;
}


//+------------------------------------------------------------------+
//| Function to return individual order prefit/loss in pips
//+------------------------------------------------------------------+
int fn_GetOrderProfitLossPip(int ticket,double myPoint)
{
   int result=0;
   double totPips=0;
   
   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)){
      if(OrderType()==OP_BUY && OrderCloseTime()!=0){
         totPips = totPips + (OrderClosePrice() - OrderOpenPrice())/myPoint;
      }else
      if(OrderType()==OP_SELL && OrderCloseTime()!=0){
         totPips = totPips + (OrderOpenPrice()-OrderClosePrice())/myPoint;         
      }        
   }
   result=totPips;
   return result;
}

//+------------------------------------------------------------------+
//| Function to return count of open orders
//+------------------------------------------------------------------+
int fn_GetOpenOrders(int magicNumber)
{
   int result=0;

   for(int i=0;i < OrdersTotal();i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(fn_IsOrderOpened(OrderTicket(),magicNumber)==true)
            result++;
   }

   return result;
}

//+------------------------------------------------------------------+
//| Function to check if order is still opened
//+------------------------------------------------------------------+
bool fn_IsOrderOpened(int ticketNumber,int magicNumber)
{
   bool result=false;
   
   if(ticketNumber!=0 && OrderSelect(ticketNumber,SELECT_BY_TICKET))
      if((long)OrderCloseTime()==0 && OrderMagicNumber()==magicNumber && OrderSymbol()==Symbol())
         result=true;

   return result;
}

//+------------------------------------------------------------------+
//| Function to check if price is reaching target level in same direction
//+------------------------------------------------------------------+
int fn_IsPendingStop(double priceLevel,int direction)
{
   int result=NO_ORDER;

   if(direction==LONG){
      if(Low[1]<priceLevel && Ask >= priceLevel)
         result=BUY_ORDER;
      //Print("Pending BUY Stop triggerred at price: ",DoubleToString(priceLevel,4));
   }else
   if(direction==SHORT){
      if(High[1]>priceLevel && Bid <= priceLevel)
         result=SELL_ORDER;
      //Print("Pending SELL Stop triggerred at price: ",DoubleToString(priceLevel,4));
   }

   return result;
}

//+------------------------------------------------------------------+
//| Function to check if price is reaching target level in opposite direction
//+------------------------------------------------------------------+
int fn_IsPendingLimit(double priceLevel,int direction)
{
   int result=NO_ORDER;

   if(direction==LONG){
      if(High[1]>priceLevel && Ask <= priceLevel)
         result=BUY_ORDER;
      //Print("Pending BUY Limit triggerred at price: ",DoubleToString(priceLevel,4));
   }else
   if(direction==SHORT){
      if(Low[1]<priceLevel && Bid >= priceLevel)
         result=SELL_ORDER;
      //Print("Pending SELL Limit triggerred at price: ",DoubleToString(priceLevel,4));
   }

   return result;
}

//+------------------------------------------------------------------+
//| Function to close all order
//+------------------------------------------------------------------+
void fn_CloseAllOrders(int magicNumber)
{
   for (int i=0; i < OrdersTotal(); i++){
      bool result=false;
      double price=0;
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if (OrderSymbol()!=Symbol() || OrderType()>1 || OrderMagicNumber()!=magicNumber)
            continue;
      
         if (OrderType() == OP_BUY){
            price =NormalizeDouble(Bid,Digits);
         }else{
   		   price =NormalizeDouble(Ask,Digits);
         }
         
         result=OrderClose( OrderTicket(),OrderLots(),price,5, Red);
         if(result){
            i--;
            fn_SendNotification("Ticket #" + OrderTicket() + " closed successfully. ",true,false,false);
         }else{
            fn_SendNotification("Ticket #" + OrderTicket() + " failed to close with error " + GetLastError(),true,false,false);
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Fuction to calculate StopLoss
//+------------------------------------------------------------------+
double fn_GetStopLoss(double SLPips,double openPrice,int tradeDirection,double myPoint)
{
   double slPrice=0;
   double minSL=0;
   
   minSL = MarketInfo(Symbol(),MODE_STOPLEVEL)*0.1; 
   
   if(SLPips>minSL){
      slPrice = SLPips*myPoint;  
   }else{
      slPrice = minSL*myPoint;
      Print("Warning Broker MIN Stoploss exceed Order Stoploss currently at...",minSL);
      Alert("Warning Broker MIN Stoploss exceed Order Stoploss currently at...",minSL);
   }
   
   if(tradeDirection==OP_BUY){
      slPrice = openPrice - slPrice;
   }else
   if(tradeDirection==OP_SELL){
      slPrice = openPrice + slPrice;
   }
         
   return slPrice;      
}//--- End calculating Stoploss

//+------------------------------------------------------------------+
//| Function to check if Order hitting stoploss and Close it
//+------------------------------------------------------------------+
int fn_GuaranteedClose(int ticket,double stealthSLPrice)
{
   int iResult=0;
   bool bResult=false;
   double currentPrice=0;
   double orderSLPrice=0;

   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)){
      orderSLPrice = OrderClosePrice();
      
      if(OrderType()==OP_BUY){
         currentPrice = Bid;         
         if(currentPrice<=stealthSLPrice && currentPrice>=orderSLPrice){
            bResult = OrderClose(ticket,OrderLots(),currentPrice,3,clrViolet); 
            if(bResult==false){
               iResult=-1;
            }else{
               iResult=1;
            }
         }         
      }else
      if(OrderType()==OP_SELL){
         currentPrice = Ask;
         if(currentPrice>=stealthSLPrice && currentPrice<=orderSLPrice){
            bResult = OrderClose(ticket,OrderLots(),currentPrice,3,clrViolet); 
            if(bResult==false){
               iResult=-1;
            }else{
               iResult=1;
            }
         }
      }   
   }

   if(iResult==1)
      Print("GuaranteedClose Successfully close order #" + IntegerToString(ticket) + " at " + DoubleToString(stealthSLPrice,4) + "/" + DoubleToString(orderSLPrice,4),GetLastError()); 
   if(iResult==-1)
      Print("GuaranteedClose Error closing order #" + IntegerToString(ticket),GetLastError()); 

   return iResult;   
}

//+------------------------------------------------------------------+
//| Function to check if current order stoploss is larger than setup stoploss
//+------------------------------------------------------------------+
double fn_GetRealStopLossPrice(int ticket,double actualSLPips,double myPoint)
{
   double curSLPips=0;
   double curMinPips = MarketInfo(Symbol(),MODE_STOPLEVEL)*0.1;
   double SLPrice=0;
 
   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)){
      SLPrice = OrderStopLoss();
      curSLPips = MathAbs(OrderOpenPrice()-SLPrice)/myPoint;
      
      //Broker SL
      if((int)curSLPips > (int)actualSLPips && (int)actualSLPips > (int)curMinPips){
         if(OrderType()==OP_BUY){
            SLPrice = OrderOpenPrice()-actualSLPips*myPoint;
         }else
         if(OrderType()==OP_SELL){
            SLPrice = OrderOpenPrice()+actualSLPips*myPoint;
         }
         
         if(!OrderModify(ticket,OrderOpenPrice(),SLPrice,OrderTakeProfit(),0,clrRed))
            Print("GetRealStopLossPrice-Error modifying order #"+IntegerToString(ticket) + " error ",GetLastError());
      }
   
   }
   
   return SLPrice;
}

//+------------------------------------------------------------------+
//| Function to perform traling stop
//|   trailingStepPips: number of pips that price move before trigger tralling stop
//|   trailingStopPips: pips distance from current price
//+------------------------------------------------------------------+
void fn_TrailingStop(int ticket,int trailingStepPips,int traillingStopPips,double myPoint)
{
   double currentPrice=0;
   double SLPrice=0;
 
   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)){
      if(OrderType()==OP_BUY){
         currentPrice = Bid;
         SLPrice=currentPrice-traillingStopPips*myPoint;
      }else
      if(OrderType()==OP_SELL){
         currentPrice = Ask;
         SLPrice=currentPrice+traillingStopPips*myPoint;
       }     
      
      if( MathFloor(MathAbs(currentPrice - OrderStopLoss())/myPoint) >= trailingStepPips + traillingStopPips)
         if(!OrderModify(ticket,OrderOpenPrice(),SLPrice,OrderTakeProfit(),0,clrRed))
            Print("TrailingStop-Error modifying buy order #"+IntegerToString(ticket) + " error ",GetLastError());
   }
}

//+------------------------------------------------------------------+
//| Function to display Timer count down
//+------------------------------------------------------------------+
void fn_ShowCounter(int LabelCorner)
{
   int hrLeft=0;
   int minLeft=0;
   int secLeft=0;
   int startX=20;
   int startY=20;
   color myColor=clrBlue;
   string myLabel;
   
   switch(ChartPeriod()){ 
      case PERIOD_D1: 
         hrLeft=24-TimeHour(TimeCurrent()-Time[0]);
         minLeft=60-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         myLabel="Timeleft: "+IntegerToString(hrLeft)+":"+IntegerToString(minLeft)+":"+IntegerToString(secLeft);         
         DisplayLabel("OM_Counter",startX,startY,0,0,0,0,myLabel,myColor,LabelCorner);
         break; 
      case PERIOD_H4: 
         hrLeft=4-TimeHour(TimeCurrent()-Time[0]);
         minLeft=60-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         myLabel="Timeleft: "+IntegerToString(hrLeft)+":"+IntegerToString(minLeft)+":"+IntegerToString(secLeft);
         DisplayLabel("OM_Counter",startX,startY,0,0,0,0,myLabel,myColor,LabelCorner);
         break;
      case PERIOD_H1: 
         minLeft=PERIOD_H1-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         myLabel="Timeleft: "+IntegerToString(minLeft)+":"+IntegerToString(secLeft);
         DisplayLabel("OM_Counter",startX,startY,0,0,0,0,myLabel,myColor,LabelCorner);
         break; 
      case PERIOD_M30: 
         minLeft=PERIOD_M30-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         myLabel="Timeleft: "+IntegerToString(minLeft)+":"+IntegerToString(secLeft);
         DisplayLabel("OM_Counter",startX,startY,0,0,0,0,myLabel,myColor,LabelCorner);
         break; 
      case PERIOD_M15: 
         minLeft=PERIOD_M15-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         myLabel="Timeleft: "+IntegerToString(minLeft)+":"+IntegerToString(secLeft);
         DisplayLabel("OM_Counter",startX,startY,0,0,0,0,myLabel,myColor,LabelCorner);
         break;  
      case PERIOD_M5: 
         minLeft=PERIOD_M5-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         myLabel="Timeleft: "+IntegerToString(minLeft)+":"+IntegerToString(secLeft);
         DisplayLabel("OM_Counter",startX,startY,0,0,0,0,myLabel,myColor,LabelCorner);
         break;                 
   }
}

//+------------------------------------------------------------------+
//| Function to display Timer count down
//+------------------------------------------------------------------+
string fn_RemainingTime()
{
   int hrLeft=0;
   int minLeft=0;
   int secLeft=0;
   string remainTime="00.00.00";
   
   switch(ChartPeriod()){ 
      case PERIOD_D1: 
         hrLeft=24-TimeHour(TimeCurrent()-Time[0]);
         minLeft=60-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime=IntegerToString(hrLeft,2,'0')+":"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,'0'); 
         break; 
      case PERIOD_H4: 
         hrLeft=4-TimeHour(TimeCurrent()-Time[0]);
         minLeft=60-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime=IntegerToString(hrLeft,2,'0')+":"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break;
      case PERIOD_H1: 
         minLeft=PERIOD_H1-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break; 
      case PERIOD_M30: 
         minLeft=PERIOD_M30-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break; 
      case PERIOD_M15: 
         minLeft=PERIOD_M15-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft,2,'0')+":"+IntegerToString(secLeft,2,'0');
         break;  
      case PERIOD_M5: 
         minLeft=PERIOD_M5-TimeMinute(TimeCurrent()-Time[0]);
         secLeft=60-TimeSeconds(TimeCurrent()-Time[0]);
         remainTime="00:"+IntegerToString(minLeft)+":"+IntegerToString(secLeft);
         break;   
      default:    
         remainTime=TimeToString(TimeLocal(),TIME_SECONDS);
         break;         
   }
   
   return remainTime;
}

//+------------------------------------------------------------------+
//| Function to check for server connection
//+------------------------------------------------------------------+
string fn_IsConnectedToBroker()
{
   string connectionStatus = "Disconnected";
   //--Make sure to set EventSetMillisecondTimer(1000); at OnInit())
   static bool alarmSounded=false;
   
   if(IsConnected()){
      connectionStatus = "Connected";
      if(!alarmSounded){
         Alert("We have reconnected to the Broker server at...",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
         alarmSounded=true;
      }
   }
   else{
      if(alarmSounded){
         Alert("We lost the Broker server at...",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
         alarmSounded=false;
      }
   } 
   
   return connectionStatus;
}


//+------------------------------------------------------------------+
//| Function to check for server connection
//+------------------------------------------------------------------+
bool fn_SendNotification(string myText,bool printLog,bool sendAlert,bool sendPushNotification)
{   
   if(sendAlert){
      Alert(myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(printLog){
      Print(myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(sendPushNotification)
      SendNotification(myText);
   
   return(true);
}

//+------------------------------------------------------------------------------------------------------------------------------------+
//| Following sections define functions related to graphical
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Function to remove objects
//+------------------------------------------------------------------+
bool fn_RemoveObjects(string objName)
{
   for(int iObj=ObjectsTotal()-1; iObj>=0; iObj--){
      string oFullName=ObjectName(iObj);
      if(StringFind(oFullName,objName)>=0){
         ObjectDelete(oFullName);
      }
   }
   
   return(true);   
}

//+------------------------------------------------------------------+
//| Function to draw information panel
//+------------------------------------------------------------------+
void ShowPanel(string panelName,string & myArray[],int startX,int startY,int stepX, int stepY,color myColor,int LabelCorner)
{
   // Delete all existing label
   fn_RemoveObjects(panelName);

   for(int index=0;index<ArraySize(myArray);index++){
      DisplayLabel(panelName,startX,startY,stepX,stepY,stepY,index,myArray[index],myColor,LabelCorner);     
   }

}


//+------------------------------------------------------------------+
//| Function to create label objects on chart
//+------------------------------------------------------------------+
void Label(string Name,string sTx,int iX,int iY,int iFS,string sFN,color cFC,int LabelCorner)
{
   ObjectCreate(Name,OBJ_LABEL,0,0,0);
   ObjectSet(Name,OBJPROP_CORNER,LabelCorner);
   ObjectSet(Name,OBJPROP_XDISTANCE,iX);
   ObjectSet(Name,OBJPROP_YDISTANCE,iY);
   ObjectSetText(Name,sTx,iFS,sFN,cFC);
}


//+------------------------------------------------------------------+
//| Function to display multiple labels
//+------------------------------------------------------------------+
void DisplayLabel(string objName,int startX,int startY,int stepX, int stepY,int idxX,int idxY,string myText,color myColor,int LabelCorner)
{
   int   iFontSize=11;
   string sFontName="Calibri";

   ObjectCreate(objName+IntegerToString(idxY),OBJ_LABEL,0,0,0);
   ObjectSet(objName+IntegerToString(idxY),OBJPROP_CORNER,LabelCorner);
   ObjectSet(objName+IntegerToString(idxY),OBJPROP_XDISTANCE,startX+stepX*idxX);
   ObjectSet(objName+IntegerToString(idxY),OBJPROP_YDISTANCE,startY+stepY*idxY);
   ObjectSetText(objName+IntegerToString(idxY),myText,iFontSize,sFontName,myColor);
}



//+------------------------------------------------------------------+
//| Function to convert from String to enum
//+------------------------------------------------------------------+
template<typename T>
T StringToEnum(string str,T enu)
{
   for(int i=0;i<256;i++)
      if(EnumToString(enu=(T)i)==str)
         return(enu);
//---
   return(-1);
}

//+------------------------------------------------------------------+
//| Function to convert from String to enum
//+------------------------------------------------------------------+
double fn_GetEntryPrice(double price, TRADE_DIRECTION tradeDirection, ENTRY_TYPE entryType)
{
   //Alert("price:",price,"tradeDirection:",EnumToString(tradeDirection));
   if(tradeDirection==LONG && entryType==IMMEDIATE)
      return Ask;
   else if(tradeDirection==SHORT && entryType==IMMEDIATE)
      return Bid;
   else
      return price;      

}



