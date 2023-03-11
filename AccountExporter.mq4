 int start() 
 {
    int handle=FileOpen("OrdersReport.csv",FILE_CSV|FILE_READ|FILE_WRITE,',');
     if(handle<0) return(0);  //stop here if we couldn't open the file
     
     // write headers  
     FileSeek (handle, 0, SEEK_SET);
     FileWrite(handle,"#","open price","open time","symbol","lots", "order profits", "SL", "TP", "type", "close time", "close price");
     
     //Get all the orders
     int total=OrdersHistoryTotal();  
     // retrieving info from trade history
     for(int pos=0;pos<total;pos++)
       {
         if(OrderSelect(pos,SELECT_BY_POS,MODE_HISTORY)==false)
          {
              Print("Access to history failed with error (",GetLastError(),")");
              break;
          }
     // some work with order
        FileWrite(handle,OrderTicket(),OrderOpenPrice(),OrderOpenTime(),OrderSymbol(),OrderLots(), OrderProfit(), OrderStopLoss(), OrderTakeProfit(), OrderType(), OrderCloseTime(), OrderClosePrice());
       }
     FileClose(handle);
  
   return(0);
}