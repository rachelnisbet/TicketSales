/* Import dataset */
filename tickets url "https://raw.githubusercontent.com/rachelnisbet/TicketSales/refs/heads/master/ticket_sales.csv";

options validvarname=v7;

proc import datafile=tickets
    out=ticket_sales dbms=csv replace;
run;

proc print data=ticket_sales;
run;

proc freq data=ticket_sales order=freq;
tables Seat_Location Number_of_Tickets Promotion / nocum nopercent ;
run;

proc means data=ticket_sales;
var ticket_price;
run;