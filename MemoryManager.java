import java.util.Arrays;

public class MemoryManager {
	
	private int[] memory;// the memory we manage
	
	private int top; // index of top (lowest) stack block
	private int heapTop; 
	static private final int NULL = -1; // our null link
	private int freeStart; // start of the free list
	
	public MemoryManager(int [] initialMemory){
	memory = new int[initialMemory.length];
	memory[0] = memory.length; //NULL
	memory[1] = NULL; //freeList ends with it
	
	top = memory.length; //top of stack, stacks grow down
	heapTop = 1; //0
	freeStart = 0; //top of heap
	}
	
	public int push(int requestSize) {
	    int oldtop = top;
	    top -= (requestSize + 1); // extra word for oldtop
	    
	    if (top < 0 || top <= heapTop){ 
	    	throw new StackOverflowError();
	    	}
	    
	    memory[top] = oldtop;
	    return top + 1;
	  }

	  /**
	   * Pop the top stack frame.  This works only if the
	   * stack is not empty.
	   */
	  public void pop() {
	    top = memory[top];
	  }
	  
	  /**
	   * Allocate a block and return its address.
	   * @param requestSize int size of block, > 0
	   * @return block address
	   * @throws OutOfMemoryError if no block big enough
	   */
	  public int allocate(int requestSize) {
	    int size = (requestSize + 1); // size including header
	    heapTop = heapTop +requestSize;
	    // Do first-fit search: linear search of the free 
	    // list for the first block of sufficient size.

	    int p = freeStart; // head of free list
	    int lag = NULL;
	    
	    while (p != NULL && memory[p] < size) {
	      lag = p; // lag is previous p
	      p = memory[p + 1]; // link to next block
	     
	    }
	    if (p == NULL || (heapTop >= top && heapTop != memory.length)) // no block large enough
	      throw new OutOfMemoryError();
	    int nextFree = memory[p + 1]; // block after p

	    // Now p is the index of a block of sufficient size,
	    // lag is the index of p's predecessor in the
	    // free list, or NULL, and nextFree is the index of
	    // p's successor in the free list, or NULL.

	    // If the block has more space than we need, carve
	    // out what we need from the front and return the
	    // unused end part to the free list.

	    int unused = memory[p]-size;// extra space in block
	    if (unused > 1) { // if more than a header's worth
	      nextFree = p + size; // index of the unused piece
	      memory[nextFree] = unused; // fill in size 
	      memory[nextFree+1] = memory[p+1]; // fill in link
	      memory[p] = size; // reduce p's size accordingly
	      
	    }

	    // Link out the block we are allocating and done.
	    
	    if (lag == NULL) freeStart = nextFree;
	    else memory[lag + 1] = nextFree;
	    return p+1; // index of useable word (after header)
	    
	    
	    
	  }

	  /**
	   * Deallocate an allocated block.  This works only if
	   * the block address is one that was returned by
	   * allocate and has not yet been deallocated.
	   * @param address int address of the block
	   */
	  public void deallocate(int address) {
	    int addr = address - 1; // real start of the block

	    // Find the insertion point in the sorted free list
	    // for this block.

	    int p = freeStart;
	    int lag = NULL;
	    while (p != NULL && p < addr) {
	      lag = p;
	      p = memory[p + 1];
	    }

	  
	// Now p is the index of the block to come after
	    // ours in the free list, or NULL, and lag is the
	    // index of the block to come before ours in the
	    // free list, or NULL.

	    // If the one to come after ours is adjacent to it,
	    // merge it into ours and restore the property
	    // described above.

	    if (addr + memory[addr] == p) {
	      memory[addr] += memory[p]; // add its size to ours
	      p = memory[p + 1]; //
	    }

	    if (lag == NULL) { // ours will be first free
	      freeStart = addr;
	      memory[addr + 1] = p;
	    }
	    else if (lag+memory[lag]==addr) { // block before is
	                                   // adjacent to ours
	      memory[lag] += memory[addr]; // merge ours into it
	      memory[lag + 1] = p;
	    }
	    else { // neither, just a simple insertion
	      memory[lag + 1] = addr;
	      memory[addr + 1] = p;
	    }
	  }
	  
	  public static void main(String [] args){
		  MemoryManager mm = new MemoryManager(new int[10]);
		  //	int a = mm.allocate(2);
		int a = mm.allocate(2);
		int b = mm.allocate(3);
	//mm.push(3);
	//	int d = mm.allocate(1);
		  //	mm.push(1);
		 
		  System.out.println("MEMORY: " + Arrays.toString(mm.memory));
		  
	  }
}
