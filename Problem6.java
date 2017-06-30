import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class Problem6 {
	
	public static int difference(List<Integer>A, List<Integer>B){
		int dif = 0;
		
		for(int i = 0; i< A.size(); i++){
			dif = dif + Math.abs(A.get(i) - B.get(i));
			
		}
		return dif;
	}
	
	public static ArrayList<Integer> getSmallest(List<Integer>A, List<Integer>B){
		ArrayList<Integer> holder = new ArrayList<Integer>(); //will hold the difference and index
		holder.add(-1); holder.add(-1);
		int smallestDif = 100000000;
		int index = -1;
		
		for(int i = 0; i< B.size()-(A.size()-1); i++){
			int x = difference(A, B.subList(i,i+(A.size())));
		
			if(x < smallestDif){
			
				smallestDif = x;
				index = i;
			//	System.out.println("SmallestDif: "+ smallestDif);
			//	System.out.println("SmallestIndex: "+ index);
				holder.set(0,smallestDif);
				holder.set(1,index);
				
				
			}
		}
		//System.out.println("Holder:"+holder);
		return holder;
		
	}
	
	
	
	public static void main(String [] args){
	ArrayList<Integer>S = new ArrayList<Integer>(Arrays.asList(1,2,3)); //change input for S here
	ArrayList<Integer>T = new ArrayList<Integer>(Arrays.asList(3,3,4,5,6,7,1,2,2)); //change input for T here
	
	ArrayList<Integer> Result = getSmallest(S,T);
	System.out.println("Format is as follows: [Smallest Difference, Index]");
	System.out.println("Result: "+ Result);
		
	}

}
