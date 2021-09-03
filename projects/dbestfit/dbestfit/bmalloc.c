/*****************************************************************************
 *
 * Big (best-fit) Memory Allocation
 *
 * Author:  Daniel Stenberg
 * Date:    March 5, 1997
 * Version: 2.0
 * Email:   Daniel.Stenberg@sth.frontec.se
 *
 *
 * Read 'thoughts' for theories and details in implementation.
 *
 * Routines meant to replace the most low level functions of an Operting
 * System
 *
 * v2.0
 * - Made all size-routines get moved out from this file. This way, the size
 *   functions can much more easily get replaced.
 * - Improved how new memory blocks get added to the size-sorted list. When
 *   not adding new pools, there should never ever be any list traversing
 *   since all information is dynamically gathered.
 *
 ****************************************************************************/

#include <stdio.h>
#include <stdlib.h>

#include "bysize.h"

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

/* #define DEBUG */

#define BMEM_ALIGN 64 /* resolution */

#define BMEMERR_TOOSMALL -1

/* this struct will be stored in all CHUNKS and AREAS */
struct BlockInfo {
  struct BlockInfo *lower;  /* previous block in memory (lower address) */
  struct BlockInfo *higher; /* next block in memory (higher address) */
  unsigned long info;       /* 31 bits size: 1 bit free boolean */
#define INFO_FREE 1
#define INFO_SIZE (~ INFO_FREE) /* inverted FREE bit pattern */

  /* FREE+SIZE Could be written to use ordinary bitfields if using a smart
     (like gcc) compiler in a manner like:
     int size:31;
     int free:1;

     The 'higher' pointer COULD be removed completely if the size is used as
     an index to the higher one. This would then REQUIRE the entire memory
     pool to be contiguous and it needs a 'terminating' "node" or an extra
     flag that informs about the end of the list.
     */
};

/* the BLOCK list should be sorted in a lower to higher address order */
struct BlockInfo *blockHead=NULL; /* nothing from the start */

void print_lists(void);


/***********************************************************************
 *
 * remove_block()
 *
 * Remove the block from the address-sorted list.
 *
 ***********************************************************************/

void remove_block(struct BlockInfo *block)
{
  if(block->lower)
    block->lower->higher = block->higher;
  else
    blockHead = block->higher;
  if(block->higher)
    block->higher->lower = block->lower;
}

/***********************************************************************
 *
 * insert_block()
 *
 * Insert the block in the address-sorted list.
 *
 ***********************************************************************/

void insert_block(struct BlockInfo *block, struct BlockInfo *newblock)
{
  newblock->lower = block;
  if(block) {
    newblock->higher = block->higher;
    block->higher = newblock;
  } else {
    newblock->higher = blockHead;
    blockHead = newblock;
  }

  if(newblock->higher)
      newblock->higher->lower = newblock;

  printf("insert_block(%p, %p)\n", (void*)block, (void*)newblock);
#ifdef DEBUG
  print_lists();
#endif
}

/****************************************************************************
 *
 * add_blocktolists()
 *
 * Adds the specified block at the specified place in the address-sorted
 * list and at the appropriate place in the size-sorted.
 *
 ***************************************************************************/
void add_blocktolists(struct BlockInfo *block,
                      struct BlockInfo *newblock,
                      size_t newsize)
{
  struct BlockInfo *higher; /* temporary storage variable */

  printf("add_blocktolists(%p, %p, %d\n", (void*)block, (void*)newblock, newsize);

  /* `block' is now a lower address than 'newblock', or NULL */

  /*
   * Check if the new CHUNK is wall-to-wall with the lower addressed
   * one (if *that* is free). Then we don't need to insert the new block,
   * only extend the existing one.
   */
  if(block && block->info&INFO_FREE &&
    (char *)block + (block->info&INFO_SIZE) == (char *)newblock) {
    /* yes sir, this is our lower address neighbour, enlarge that one
       pick it out from the list and recursively add that chunk and
       then we escape */

    /* remove the old block size from the size-sorted list */
    remove_chunksize((char*)block+sizeof(struct BlockInfo));

    /* All we do now is extend the current block size */
    block->info += newsize; /* newsize is an even number and thus the FREE
                               bit is untouched */

    /* Prepare for the insert_by_size() call below */
    newblock = block;
    newsize = block->info;
  }
  else
  {
    /* Just insert the node into the list */
    newblock->info = newsize|INFO_FREE;
    insert_block(block, newblock);
  }

  /* The new block is now in the list, and we see if we can merge it with
     the higher block */

  higher = newblock->higher;

  /* check if this is our higher addressed neighbourm, and is free */
  if(higher && (higher->info&INFO_FREE) &&
    ((char *)newblock + newsize) == (char *)higher) {

    /* Then remove that one and enlarge ourselves */
    remove_block(higher); /* unlink 'higher' from list */

    /* remove from size-sorted list: */
    remove_chunksize((char*)higher+sizeof(struct BlockInfo));

    /* add the upper block's size on ourselves */
    newsize += higher->info&INFO_SIZE;

    /* add the new, bigger block */
    insert_block(block, newblock);
  }

  newblock->info = newsize | INFO_FREE; /* we do assume size isn't using the
                                           FREE bit */
  insert_bysize((char *)newblock+sizeof(struct BlockInfo), newsize);
}

/***********************************************************************
 *
 * findblockbyaddr()
 *
 * Find the block that is just before the input block in memory. Returns NULL
 * if none is.
 *
 ***********************************************************************/

static struct BlockInfo *findblockbyaddr(struct BlockInfo *block)
{
  struct BlockInfo *test = blockHead;
  struct BlockInfo *lower = NULL;

  while(test && (test < block)) {
    lower = test;
    test = test->higher;
  }
  return lower;
}

/***********************************************************************
 *
 * add_pool()
 *
 * This function should be the absolutely first function to call. It sets up
 * the memory bounds of the [first] CHUNK(s). It should be possible to call
 * this function several times to add more CHUNKs to the pool of free
 * memory. This allows the bmalloc system to deal with a non-contigous memory
 * area.
 *
 * Returns non-zero if an error occured. The memory was not added then.
 *
 ***********************************************************************/

int add_pool(void *start,
             size_t size)
{
  struct BlockInfo *newblock = (struct BlockInfo *)start;
  struct BlockInfo *block;

  if(size < BMEM_ALIGN)
    return BMEMERR_TOOSMALL;

  block = findblockbyaddr( newblock );
  /* `block' is now a lower address than 'newblock' or NULL */

  if(size&1)
    size--; /* only add even sizes */

  add_blocktolists(block, newblock, size);

  return 0;
}


#ifdef DEBUG
static void bmalloc_failed(size_t size)
{
  printf("*** " __FILE__ " Couldn't allocate %d bytes\n", size);
  print_lists();
}
#else
#define bmalloc_failed(x)
#endif

void print_lists()
{
  struct BlockInfo *block = blockHead;
#if 1
  printf("List of BLOCKS (in address order):\n");
  while(block) {
    printf("  START %p END %p SIZE %ld FLAG %s\n",
           (char *)block,
           (char *)block+(block->info&INFO_SIZE), block->info&INFO_SIZE,
           (block->info&INFO_FREE)?"free":"used");
    if(block->higher && block->higher->lower != block)
        printf("Bad link!!!\n");
    block = block->higher;
  }
  printf("End of BLOCKS:\n");
#endif
  print_sizes();
}

void *bmalloc(size_t size)
{
  void *mem;

#ifdef DEBUG
  {
    static int count=0;
    int realsize = size + sizeof(struct BlockInfo);
    if(realsize%4096)
      realsize = ((size / BMEM_ALIGN)+1) * BMEM_ALIGN;
    printf("%d bmalloc(%d) [%d]\n", count++, size, realsize);
  }
#endif

  size += sizeof(struct BlockInfo); /* add memory for our header */

  if(size&(BMEM_ALIGN-1)) /* a lot faster than %BMEM_ALIGN but this MUST be
                             changed if the BLOCKSIZE is not 2^X ! */
    size = ((size / BMEM_ALIGN)+1) * BMEM_ALIGN; /* align like this */

  /* get a CHUNK from the list with this size */
  mem = obtainbysize ( size );
  if(mem) {
    /* the memory block we have got is the "best-fit" and it is already
       un-linked from the free list */

    /* now do the math to get the proper block pointer */
    struct BlockInfo *block= (struct BlockInfo *)
      ((char *)mem - sizeof(struct BlockInfo));

    block->info &= ~INFO_FREE;
    /* not free anymore */

    if( size != (block->info&INFO_SIZE)) {
      /* split this chunk into two pieces and return the one that fits us */
      size_t othersize = (block->info&INFO_SIZE) - size;

      if(othersize > BMEM_ALIGN) {
        /* prevent losing small pieces of memory due to weird alignments
           of the memory pool */

        block->info = size;  /* set new size (leave FREE bit cleared) */

        /* Add the new chunk to the lists: */
        add_blocktolists(block,
                         (struct BlockInfo *)((char *)block + size),
                         othersize );
      }
    }

    /* Return the memory our parent may use: */
    return (char *)block+sizeof(struct BlockInfo);
  }
  else {
    bmalloc_failed(size);
    return NULL; /* can't find any memory, fail hard */
  }
  return NULL;
}

void bfree(void *ptr)
{
  struct BlockInfo *block = (struct BlockInfo *)
    ((char *)ptr - sizeof(struct BlockInfo));
  size_t size;

  /* setup our initial higher and lower pointers */
  struct BlockInfo *lower = block->lower;
  struct BlockInfo *higher = block->higher;

#ifdef DEBUG
  static int freecount=0;
  printf("%d bfree(%p)\n", freecount++, ptr);
#endif

  /* Already freed? */
  if(block->info & INFO_FREE)
      printf("Error! Already free!\n");

  /* bind together lower addressed FREE CHUNKS */
  if(lower && (lower->info&INFO_FREE) &&
     ((char *)lower + (lower->info&INFO_SIZE) == (char *)block)) {
    printf("Merging lower\n");
    size = block->info&INFO_SIZE;      /* original size */

    /* remove from size-link: */
    remove_chunksize((char *)lower+sizeof(struct BlockInfo));

    remove_block(block);              /* unlink from address list */
    block = lower;                    /* new base area pointer */
    block->info += size;              /* append the new size (the FREE bit
                                         will remain untouched) */
  }

  /* bind together higher addressed FREE CHUNKS */
  if(higher && (higher->info&INFO_FREE) &&
     ((char *)block + (block->info&INFO_SIZE) == (char *)higher)) {
    /* append higher size, the FREE bit won't be affected */
    block->info += (higher->info&INFO_SIZE);

    /* unlink from size list: */
    remove_chunksize((char *)higher+sizeof(struct BlockInfo));
    remove_block(higher);             /* unlink from address list */
  }
  block->info |= INFO_FREE;   /* consider this FREE! */

  insert_bysize((char *)block+sizeof(struct BlockInfo), block->info&INFO_SIZE);

#ifdef DEBUG
  print_lists();
#endif

}

