(* Problem 7 *)

exception InvalidInput;

fun score([],[]) = 0
| score(x::xs,y::ys) = abs(x-y) + score(xs, ys);
(*| score(_,_) = raise InvalidInput; *)


(* n is the length *)
fun sublistAt(_,_,0) = []
|	sublistAt(x::xs,0,n) = x::sublistAt(xs,0,n-1)
|	sublistAt(x::xs,i,n) = sublistAt(xs,i-1,n);

fun bestMatch(xs, y::ys,bestList,bestScore, currIndex, bestIndex)= 
(* base case *)

if (length xs) = (length (y::ys))then 
	
	if score(xs,y::ys) < bestScore then
		(currIndex,score(xs,y::ys))
	else (bestIndex, bestScore)	
	
else (*Not base case *)
  let val sub = sublistAt(y::ys, 0,length(xs))
	  val sc = score(xs, sub)
  in		
	  if sc < bestScore then bestMatch(xs,ys, sub, sc,(currIndex+1), currIndex)
	  else bestMatch(xs, ys, bestList, bestScore,(currIndex+1),bestIndex)
end;

