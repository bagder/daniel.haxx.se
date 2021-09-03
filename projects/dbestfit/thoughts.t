#include "doctype.t"
<head>
<title>dbestfit: Algorithm Theory</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>

#define DBESTFIT_THOUGHTS

#include "body.t"
#include "setup.t"
#include "daniel.t"
#include "menu.t"

TITLE(Memory Allocation Algorithm Theories)
BOXTOP

SUBTITLE(GOAL)
<p> dbestfit is intended to be a 100% working memory allocation system. It
  should be capable of replacing an ordinary Operating System's own
  routines. It should work good in a multitasking, shared memory, non-virtual
  memory environment without clogging the memory. Primary aimed for small
  machines, CPUs and memory amounts.

<p> I use a best-fit algorithm with a slight overhead in order to increase
  speed a lot. It should remain scalable and work good with very large amount
  of memory and free/used memory blocks too.

SUBTITLE(TERMINOLOGY)
<p>
<ul>

<li> <b>FRAGMENT</b> - small identically sized parts of a larger BLOCK, they
are when travered in lists etc _not_ allocated.

<li> <b>BLOCK</b> - large memory area, if used for FRAGMENTS, they are linked
in a lists. One list for each FRAGMENT size supported.

<li> <b>TOP</b> - head struct that holds information about and points to a
chain of BLOCKS for a particular FRAGMENT size.

<li> <b>CHUNK</b> - a contiguous area of free memory

<li> <b>AREA</b> - a piece of memory, either allocated or freed.

</ul>

SUBTITLE(MEMORY SYSTEM)
<p>
  We split the system in two parts. One part allocates small memory amounts
  and one part allocates large memory amounts, but all allocations are done
  "through" the small-part-system. There is an option to use only the small
  system (and thus use the OS for large blocks) or the complete package.

BOXBOT
<p>

TITLE(Small Size Allocations)
BOXTOP
<p>
  Keywords for this system is 'Deferred Coalescing' and 'quick lists'.

SUBTITLE(ALLOC)
<p>
<ul>
<li> Small allocations are "aligned" upwards to a set of preset sizes. In the
    current implementation I use 20, 28, 52, 116, 312, 580, 812, 2028 bytes.
    Memory allocations of these sizes are refered to as FRAGMENTS.
    (The reason for these specific sizes is the requirement that they must be
    32-bit aligned and fit as good as possible within 4060 bytes.)

<li> Allocations larger than 2028 will get a BLOCK for that allocation only.

<li> Each of these sizes has it's own TOP. When a FRAGMENT is requested, a
    larger BLOCK will be allocated and divided into many FRAGMENTS (all of the
    same size). TOP points to a list with BLOCKS that contains FRAGMENTS of
    the same size. Each BLOCK has a 'number of free FRAGMENTS' counter and so
    has each TOP (for the entire chain).

<li> A BLOCK is around 4060 bytes plus the size of the information header. This
    size is adjusted to make the allocation of the big block not require more
    than 4096 bytes. (This might not be so easy to be sure of, if you don't
    know how the big-block system works, but the BMALLOC system uses an
    extra header of 12 bytes and the header for the FRAGMENT BLOCK is 20 bytes
    in a general 32-bit unix environment.)

<li> In case the allocation of a BLOCK fails when a FRAGMENT is required, the
    next size of FRAGMENTS will be checked for a free FRAGMENT. First when the
    larger size lists have been tested without success it will fail for real.
</ul>

<p>
SUBTITLE(FREE)
<ul>
<li> When FRAGMENTS are freed so that a BLOCK becomes non-used, it is returned
    to the system.

<li> FREEing a fragment adds the buffer in a LIFO-order. That means that the
    next request for a fragment from the same list, the last freed buffer will
    be returned first.
</ul>

SUBTITLE(REALLOC)
<p>
<ul>
<li> REALLOCATION of a FRAGMENT does first check if the new size would fit
    within the same FRAGMENT and if it would use the same FRAGMENT size. If it
    does and would, the same pointer is returned.
</ul>

SUBTITLE(OVERHEAD)
<p>
  Yes, there is an overhead on small allocations (internal fragmentation).
  Yet, I do believe that small allocations more often than larger ones are
  used dynamically. I believe that a large overhead is not a big problem if it
  remains only for a while. The big gain is with the extreme speed we can GET
  and RETURN small allocations. This has yet to be proven. I am open to other
  systems of dealing with the small ones, but I don`t believe in using the
  same system for all sizes of allocations.

SUBTITLE(IMPROVEMENTS)
<p>
   An addition to the above described algorithm is the `save-empty-BLOCKS-a-
  while-afterwards`. It will be used when the last used FRAGMENT within a
  BLOCK is freed. The BLOCK will then not get returned to the system until "a
  few more" FRAGMENTS have been freed in case the last [few] freed FRAGMENTS
  are allocated yet again (and thus prevent the huge overhead of making
  FRAGMENTS in a BLOCK). The "only" drawback of such a SEBAWA concept is
  that it would mean an even bigger overhead...
<p>

SUBTITLE(HEADERS -in allocated data)
<p>
<ul>
<li> <b>FRAGMENTS</b> - 32-bit pointer to its parent BLOCK (lowest bit must be 0)
<li> <b>BLOCK</b> - 32-bit size (lowest bit must be 1 to separate this from
 FRAGMENTS)
</ul>

BOXBOT

<p>
TITLE(Larger Allocations)
BOXTOP
<p>
  If the requested size is larger than the largest FRAGMENT size supported,
  the allocation will be made for this memory area alone, or if a BLOCK is
  allocated to fit lots of FRAGMENTS a large block is also desired.

<ul>

<li> We add memory to the "system" with the add_pool() function call. It
    specifies the start and size of the new block of memory that will be
    used in this memory allocation system. Several add_pool() calls are
    supported and they may or may not add contiguous memory.

<li> Make all blocks get allocated aligned to BLOCKSIZE (sometimes referred to
    as 'grain size'), 64 bytes in my implementation. Reports tell us there is
    no real gain in increasing the size of the align.

<li> We link *all* pieces of memory (AREAS), free or not free. We keep the list
    in address order and thus when a FREE() occurs we know instanstly if there
    are FREE CHUNKS wall-to-wall. No list "travels" needed. Requires some
    extra space in every allocated BLOCK. Still needs to put the new CHUNK in
    the right place in size-sorted list/tree. All memory areas, allocated or
    not, contain the following info in the header:
    <ul>
    <li> size of this memory area
    <li> FREE status
    <li> pointer to the next AREA closest in memory
    <li> pointer to the prev AREA closest in memory
    </ul>
    (12 bytes in total)

<li> Sort all FREE CHUNKS in size-order. We use a SPLAY TREE algorithm for
    maximum speed. Data/structs used for the size-sorting functions are kept
    in an abstraction layer away from this since it is really not changing
    anything (except executing speed).
</ul>

SUBTITLE(ALLOC RSIZE - requested size aligned properly)
<p>
<ul>
<li> Fetch a CHUNK that RSIZE fits within. If the found CHUNK is larger than
    RSIZE, split it and return the RSIZE to the caller. Link the new CHUNK
    into the list/tree.
</ul>

SUBTITLE(FREE AREA - piece of memory that is returned to the system)
<p>
<ul>
<li> Since the allocated BLOCK has kept its link-pointers, we can without
    checking any list instantly see if there are any FREE CHUNKS that are
    wall-to-wall with the AREA (both sides). If the AREA *is* wall-to-wall
    with one or two CHUNKS that or they are unlinked from the lists, enlarged
    and re-linked into the lists.
</ul>

SUBTITLE(REALLOC)
<p>
<ul>
<li> There IS NO realloc() of large blocks, they are performed in the higher
    layer (dmalloc).
</ul>
BOXBOT

TITLE(FURTHER READING)
BOXTOP
<p>
<ul>
<li> "Dynamic Storage Allocation: A Survey and Critical Review" (Paul R. Wilson,
   Mark S. Johnstone, Michael Neely, David Boles)
   <a href="ftp://ftp.cs.utexas.edu/pub/garbage/allocsrv.ps">ftp://ftp.cs.utexas.edu/pub/garbage/allocsrv.ps</a>
<li> "A Memory Allocator" (Doug Lea)
   <a href="http://g.oswego.edu/dl/html/malloc.html">http://g.oswego.edu/dl/html/malloc.html</a>
</ul>

BOXBOT

#include "footer.t"
