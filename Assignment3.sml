
(* Problem #1 *)
fun is_older (date1: int*int*int, date2: int*int*int) =
	if (#1 (date1)) < (#1 (date2)) then true else 
	if (#1 (date1)) > (#1 (date2)) then false else
	
		if (#2 (date1)) < (#2(date2)) then true else
		if (#2 (date1)) > (#2 (date2)) then false else
		
			if (#3 (date1)) < (#3 (date2)) then true
				else false;
				
				
(* Problem #2 *)				
fun number_in_month (date: (int*int*int) list, month:int) = 
	foldl (fn (x, y) => if (#2 x) = month then y+1 else y) 0 date;
	

(* Problem #3 *)
fun number_in_months(dates: (int*int*int)list, months: (int)list)=
	foldl (fn (x, y) => (y+ number_in_month(dates, x))) 0 months;
	

(* Problem #4 *)
fun dates_in_month(dates: (int*int*int)list, month:int) = 
	foldr(fn (x,y) => if (#2 x) = month then x::y else y) [] dates; 
	
(* Problem #5 *)
fun dates_in_months(dates: (int*int*int)list, months: (int)list)= 
	foldr (fn (x,y) => (dates_in_month(dates, x)@ y))[] months;
	
(* Problem #6 *)
fun get_nth(strings: string list, 1)= hd strings
|   get_nth(strings, n) = get_nth(tl strings, n-1);

(* Problem #7 *)
fun date_to_string(date: (int*int*int)) = 
	get_nth(["January ", "February ", "March ", "April ", "May ", "June ", "July ", "August ", "September ", "October ", "November ", "December "], (#2 date)) ^ Int.toString (#3 date)^", " ^ Int.toString (#1 date);
			 
(* Problem #8 *)
fun helper (sum: int, list: int list, holder: int, counter:int)=
	if (holder + (hd list)) >= sum then counter else
		helper(sum, (tl list), (holder+ (hd list)), (counter+1));

fun number_before_reaching_sum(sum: int, list: int list)= 
	helper(sum, list, 0,0);
	
(* Problem #9 *)
fun what_month(day: int) =
	number_before_reaching_sum(day, [31,28,31,30,31,30,31,31,30,31,30,31])+1;
	
(* Problem 10 *)
fun helper(startDate:int, endDate:int, listThings:int list)=
	if endDate >= startDate then helper(startDate, endDate-1, (what_month(endDate)::listThings)) else listThings;

fun month_range(startDate:int, endDate:int) = 
	helper(startDate, endDate, []);
	
(* Problem 11 *)
fun oldest [] = NONE
|	oldest (x::xs) = SOME (foldr(fn (x,y) => if is_older(x,y) then x else y) (x) (xs));

(* Problem 12 *)
fun valid_date(date: (int*int*int)) = 
	if (#1 date) < 1 then false else
	if (#2 date) < 1 orelse (#2 date) > 12 then false else
	if (#3 date) < 1 orelse (#3 date) > 31 then false else
	
		if ((#2 date) = 4 orelse (#2 date) = 6 orelse (#2 date) = 9 orelse (#2 date) = 11 ) andalso (#3 date) > 30 then false else
		if ((#2 date) = 1 orelse (#2 date) = 3 orelse (#2 date) = 5 orelse (#2 date) = 7 orelse (#2 date) = 8 orelse (#2 date) = 10 orelse (#2 date = 12)) andalso (#3 date) > 31 then false else
		
		if( ((#1 date) mod 400 = 0) orelse (((#1 date) mod 4 = 0) andalso not((#1 date) mod 100 = 0))) andalso ((#2 date) = 2 andalso (#3 date) > 29) then false else
		if not( ((#1 date) mod 400 = 0) orelse (((#1 date) mod 4 = 0) andalso not((#1 date) mod 100 = 0))) andalso ((#2 date) = 2 andalso (#3 date) >28) then false 
	
	else true;
