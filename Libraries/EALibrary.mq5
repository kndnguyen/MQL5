//+------------------------------------------------------------------+
//|EALibrary.mq4
//+------------------------------------------------------------------+
#property library
#property copyright "Khoa Nguyen"
#property version   "2.0"

#include  <GTM\GTM_Enumerations.mqh>

//+------------------------------------------------------------------+
//| Function to set 3 digits or 5 digits depending to Broker
//+------------------------------------------------------------------+
double fn_SetMyPoint() export
{
   double myPoint=Point();
   if(Digits()==3 || Digits()==5){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 10");
      myPoint=Point()*10;
   }else if(Digits()==2){
      Print("---> Info: Digits=",Digits(),". Broker quotes given in " + Digits() + "-digits mode. Old values of SL, TP and slippage will be multiplied by 100");
      myPoint=Point()*100;
   }
   return(myPoint);
}

//+------------------------------------------------------------------+
//| Function to return an array containing Pip Value | Spreads in pips | Min Stop Loss in pips 
//+------------------------------------------------------------------+
double fn_GetPipsSpread() export
{
   double value = 0;
   if(Digits()==3 || Digits()==5){  
      value  = Spread*0.1;                            //Broker spread in pips
   }else if(Digits()==2){
      value  = Spread*0.01;                              //Broker spread in pips
   }
   return(value);
}

//+------------------------------------------------------------------+
//| Function to return an array containing Pip Value | Spreads in pips | Min Stop Loss in pips 
//+------------------------------------------------------------------+
bool fn_GetMarketInfo(double &marketInfo[],double lotSize) export
{
   if(Digits()==3 || Digits()==5){
      marketInfo[0]  = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE)*0.1*(lotSize/0.01);    //Pip value: Value of a pip based on standard 0.01 lotSize      
      marketInfo[1]  = Spread*0.1;                            //Broker spread in pips
   }else if(Digits()==2){
      marketInfo[0]  = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE)*0.01*(lotSize/0.01);            //Pip value: Value of a pip based on standard 0.01 lotSize      
      marketInfo[1]  = Spread*0.01;                              //Broker spread in pips
   }
   return(true);
}

//+------------------------------------------------------------------+
// Function to check if its a new candle
//+------------------------------------------------------------------+
bool fn_IsNewCandle() export
{
    static int BarsOnChart=0;
    if (Bars(_Symbol,_Period) == BarsOnChart) 
      return (false);
      
    BarsOnChart = Bars(_Symbol,_Period);
        return(true);
}

//+------------------------------------------------------------------+
//| Function to generate Magic Number
//+------------------------------------------------------------------+
int fn_GenerateMagicNumber(int trial) export
{
   int result=0; 
   result = MathRand();
   
   while(trial<=10){
      for(int i=0;i<PositionsTotal();i++){
         if(PositionGetTicket(i)>0){
            if(PositionGetInteger(POSITION_MAGIC)==result){
               result = MathRand();
            }
         }
      }
      trial++;
   }
   return result;
}

/*
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

*/


//+------------------------------------------------------------------+
//| Function to place immediate order
//+------------------------------------------------------------------+
long fn_PlaceImmediateOrder(ENUM_ORDER_TYPE orderType
                            ,double orderLotSize
                            ,double orderSLPrice                            
                            ,double orderTPPrice                            
                            ,string orderComment
                            ,int    orderMagicNum
                            ,double point
                            ) export
{
   long ticket = -1;
   double orderTPPips=0, orderSLPips=0;
   //--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
   
   request.magic    =orderMagicNum;                            // MagicNumber of the order
   request.symbol   =Symbol();                                 // symbol
   request.volume   =orderLotSize;                             // lot size
   request.action   =TRADE_ACTION_DEAL;                        // type of trade operation
   request.type     =orderType;                                // order type
   request.deviation=5;                                        // allowed deviation from the price
   request.type_filling = ORDER_FILLING_FOK||ORDER_FILLING_IOC||ORDER_FILLING_RETURN;

   if (orderType == ORDER_TYPE_BUY){
      request.price = Ask;    // price for opening
   }else if(orderType == ORDER_TYPE_SELL){
      request.price = Bid;    // price for opening 
   }
      
   request.comment  =orderComment;
    
   if (orderTPPrice != 0) request.tp = orderTPPrice;          // set TP price
   if (orderSLPrice != 0) request.sl = orderSLPrice;           // set SL price if specify
    
   //--- send the request
   bool orderSendResult = OrderSend(request,result);
   int answer=result.retcode;
   if(!orderSendResult)
   {
        PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
        switch(answer) 
        { 
            //--- requote 
            case 10004: 
            { 
                Print("TRADE_RETCODE_REQUOTE"); 
                Print("request.price = ",request.price,"   result.ask = ", result.ask," result.bid = ",result.bid); 
                break; 
            } 
            //--- order is not accepted by the server 
            case 10006: 
            { 
                Print("TRADE_RETCODE_REJECT"); 
                Print("request.price = ",request.price,"   result.ask = ", result.ask," result.bid = ",result.bid); 
                break; 
            } 
            //--- invalid price 
            case 10015: 
            { 
                Print("TRADE_RETCODE_INVALID_PRICE"); 
                Print("request.price = ",request.price,"   result.ask = ", result.ask," result.bid = ",result.bid); 
                break; 
            } 
            //--- invalid SL and/or TP 
            case 10016: 
            { 
                Print("TRADE_RETCODE_INVALID_STOPS"); 
                Print("request.sl = ",request.sl," request.tp = ",request.tp); 
                Print("result.ask = ",result.ask," result.bid = ",result.bid); 
                break; 
            } 
            //--- invalid volume 
            case 10014: 
            { 
                Print("TRADE_RETCODE_INVALID_VOLUME"); 
                Print("request.volume = ",request.volume,"   result.volume = ", result.volume); 
                break; 
            } 
            //--- not enough money for a trade operation  
            case 10019: 
            { 
                Print("TRADE_RETCODE_NO_MONEY"); 
                Print("request.volume = ",request.volume,"   result.volume = ", result.volume,"   result.comment = ",result.comment); 
                break; 
            } 
            //--- some other reason, output the server response code  
            default: 
            { 
                Print("Other answer = ",answer); 
            } 
        }
   }else{
        ticket = result.order;
        //--- information about the operation
        Print(Symbol(),":",orderComment," Order #",ticket," opened at price:",DoubleToString(result.price,4),"-LotSize:",DoubleToString(result.volume,2),"-TP:",DoubleToString(orderTPPrice,4),"-SL:",DoubleToString(orderSLPrice,4));
   }
    
   return ticket; 
}


//+------------------------------------------------------------------+
//| Function to convert from String to enum
//+------------------------------------------------------------------+
double fn_GetEntryPrice(TRADE_DIRECTION tradeDirection, ENTRY_TYPE entryType) export
{   
   if(tradeDirection==LONG && entryType==IMMEDIATE)
      return Ask;
   else if(tradeDirection==SHORT && entryType==IMMEDIATE)
      return Bid;
   else
      return (Ask+Bid)/2;      
}


//+------------------------------------------------------------------+
//| Function to check if price has reaching target price level and is tradeable
//+------------------------------------------------------------------+
bool fn_IsPending(TRADE_DIRECTION direction, double targetPrice,double spreadPips,double Points) export
{
   bool result=false;
   
   double curMidPrice = (Ask + Bid)/2;
   double spreadPrice = spreadPips * Points / 10; //--- Price is within 50% of spread
   
   switch(direction)
   {
      case  LONG:
         curMidPrice = Ask;
         if(curMidPrice >= targetPrice && curMidPrice <= targetPrice + spreadPrice
            && spreadPips >= fn_GetPipsSpread()){
            result = true;
         }         
         break;
      case  SHORT:
         curMidPrice = Bid;
         if(curMidPrice <= targetPrice && curMidPrice >= targetPrice - spreadPrice
            && spreadPips >= fn_GetPipsSpread()){
            result = true;
         }         
         break;
      case  HEDGE:
         if(curMidPrice >= targetPrice - spreadPrice && curMidPrice <= targetPrice + spreadPrice
            && spreadPips >= fn_GetPipsSpread()){
            result = true;
         }
         break;
      default:
         break;
   }
   
   return result;
}


//+------------------------------------------------------------------+
//| Function to return count of open deals and reset closed deals ticket number to 0
//+------------------------------------------------------------------+
bool fn_GetOpenOrders(GridItem &GridArray[],double &longTicketsCnt,double &shortTicketCnt,int magicNumber) export
{
   bool result=false,longResult=false,shortResult=true;
   longTicketsCnt=0;
   shortTicketCnt=0;
   
   for(int i=0;i < ArrayRange(GridArray,0);i++) {
      if(GridArray[i].item_BUYTicket != 0){
         if(PositionSelectByTicket(GridArray[i].item_BUYTicket)){
            if(PositionGetInteger(POSITION_MAGIC) == magicNumber && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY){
               longTicketsCnt++;
            }   
         }else{
            GridArray[i].item_BUYTicket = 0;
         }
         longResult = true;
      }
      
      if(GridArray[i].item_SELLTicket != 0){
         if(PositionSelectByTicket(GridArray[i].item_SELLTicket)){
            if(PositionGetInteger(POSITION_MAGIC) == magicNumber && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL){            
               shortTicketCnt++;
            }   
         }else{
            GridArray[i].item_SELLTicket = 0;
         }
         shortResult = true;
      }
   }

   return result = longResult & shortResult;
}

//+------------------------------------------------------------------+
//| Function to return Total running balance profit/loss
//+------------------------------------------------------------------+
bool fn_GetRunningPL(double &runningLongPL,double &runningShortPL,int magicNumber) export
{
   runningLongPL=0;
   runningShortPL=0;

   for(int i=0;i<PositionsTotal();i++) {
      if(PositionGetSymbol(i)==Symbol()){
         if(PositionGetInteger(POSITION_MAGIC) == magicNumber && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY){
               runningLongPL += PositionGetDouble(POSITION_PROFIT);
         }
         
         if(PositionGetInteger(POSITION_MAGIC) == magicNumber && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL){
               runningShortPL += PositionGetDouble(POSITION_PROFIT);
         }
      }
   }

   return (true);
}



/**
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
*/



//+------------------------------------------------------------------+
//| Function to check for server connection
//+------------------------------------------------------------------+
bool fn_SendNotification(string myText,bool printLog,bool sendAlert,bool sendPushNotification) export
{   
   if(sendAlert){
      Alert(Symbol(),"-",myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(printLog){
      Print(myText,"-",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES));
   }
   if(sendPushNotification)
      SendNotification(Symbol()+"-"+myText);
   
   return(true);
}


//+------------------------------------------------------------------------------------------------------------------------------------+
//| Following sections define functions related to graphical
//+------------------------------------------------------------------------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Function to remove objects
//+------------------------------------------------------------------+
bool fn_RemoveObjects(string objName) export
{
   for(int iObj=ObjectsTotal(0,0,-1)-1; iObj>=0; iObj--){
      string oFullName=ObjectName(0,iObj,-1,-1);
      if(StringFind(oFullName,objName)>=0){
         ObjectDelete(0,oFullName);
      }
   }
   
   return(true);   
}

/*
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
**/





