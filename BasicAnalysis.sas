/* Import dataset */
filename tickets url "https://raw.githubusercontent.com/rachelnisbet/TicketSales/refs/heads/master/ticket_sales.csv";

options validvarname=v7;

proc import datafile=tickets
    out=ticket_sales dbms=csv replace;
run;

/* View the dataset */
proc print data=ticket_sales;
run;

/* View frequencies */
proc freq data=ticket_sales order=freq;
tables Seat_Location Number_of_Tickets Promotion / nocum nopercent ;
run;

/* At the end of the day, we want to make money, so let's look specifically at ticket prices! */
proc means data=ticket_sales;
var ticket_price;
run;

/* We need to do some data manipulation... */
data tickets_new;
    length p $ 3; /* Important because of how we wrote out IF/THEN */
    set ticket_sales;
    format Ticket_Price dollar12. Time time. date date9.;
    if promotion = 0 then p='No';
    else p='Yes';
    drop promotion;
run;

/* Check out our edits */
proc print data=tickets_new;
run;

/* View frequencies */
proc freq data=tickets_new;
tables Number_of_Tickets*P / nocum nopercent ;
run;