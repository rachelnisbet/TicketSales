proc import datafile="/workspaces/storage/TicketSales/attendance.csv" out=attendance;
guessingrows=max;
    run;

proc import datafile="/workspaces/storage/TicketSales/national-average.csv" out=avg;
run;

data attendance1;
    set attendance;
    if weekly_attendance= "NA" then weekly=.;
    else weekly=input(weekly_attendance, 6.);
Full_team=catx(" ", team, team_name);
run;

data avg_ticket;
    set avg(rename=("Avg TP $"N=Avg_Ticket_Price));
    format avg_ticket_price dollar4.;
    Team=transtrn(Genre, "Tickets", "");
    drop Genre;
run;

proc print data=attendance1(obs=200);
run;

proc print data=avg_ticket;
run;

proc sort data=attendance1;
    by week;
run;

proc boxplot data=attendance1;
    plot weekly*week;
run;