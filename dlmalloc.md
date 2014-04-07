##dlmalloc 2.8.6 浅析##

###1. 算法概览###

在 很独家哦方面,dlmalloc都属于最适合的内存分配器.一般,它从已经存在的内
存块中挑选与用于请求最匹配的内存块,通过以最近使用的顺序将内存节点 拆
分.(这种策略能有效地维护和实现低内存碎片).但是,对于某些内存大小小于
256bytes的请求,当不存在显示地适配的内存块时,dlmalloc 会偏离最适合策略
(best-fitting),而是采取从邻近的用于之前分配的空间中,拆分内存节点,采用
近似最近使用的顺序.(这样,可以有效地提升 小内存分配的权重.)而对于非常大
的内存请求(默认为>=256kb),dlmalloc依赖于系统的内存映射(memory mapping)
机制,当然,前提是系统支持.(这样可以有效地避免携带用于大内存块的可能的内
存碎片).

All operations (except malloc_stats and mallinfo) have execution times
that are bounded by a constant factor of the number of bits in a
size_t, not counting any clearing in calloc or copying in realloc, or
actions surrounding MORECORE and MMAP that have times proportional to
the number of non-contiguous regions returned by system allocation
routines, which is often just 1. 在实际的程序中,你可以使用宏
NO_SEGMENT_TRAVERSAL禁止小块内存遍历(segment traversals),这样可以确保
在系统内存分配器返回非连续的内存空间情况下dlmalloc依然可以以携带更多内
存和增加内存碎片的支出为前提 下,继续工作.

dlmalloc的实现不是非常模块化,也没有严格的可重用宏.也许在将来的某天,C编
译器可以做到在线模块化代码,就像现在野蛮地扩展代码.但是,现在,大部分编译
器都不支持.

Here are some pictures to make it clearer.  They are "exploded" to
show that the state of a chunk can be thought of as extending from the
high 31 bits of the head field of its header through the prev_foot and
PINUSE_BIT bit of the following chunk header.

A chunk that's in use looks like:

```
   chunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
           | Size of previous chunk (if P = 0)                             |
           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ |P|
         | Size of this chunk                                         1| +-+
   mem-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         |                                                               |
         +-                                                             -+
         |                                                               |
         +-                                                             -+
         |                                                               :
         +-      size - sizeof(size_t) available payload bytes          -+
         :                                                               |
 chunk-> +-                                                             -+
         |                                                               |
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ |1|
       | Size of next chunk (may or may not be in use)               | +-+
 mem-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    And if it's free, it looks like this:

   chunk-> +-                                                             -+
           | User payload (must be in use, or we would have merged!)       |
           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ |P|
         | Size of this chunk                                         0| +-+
   mem-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         | Next pointer                                                  |
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         | Prev pointer                                                  |
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         |                                                               :
         +-      size - sizeof(struct chunk) unused bytes               -+
         :                                                               |
 chunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         | Size of this chunk                                            |
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ |0|
       | Size of next chunk (must be in use, or we would have merged)| +-+
 mem-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                                                               :
       +- User payload                                                -+
       :                                                               |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                                                                     |0|
                                                                     +-+
```

必须注意到的是,我们总是会将相邻的空闲内存块合并,所以紧邻着空闲内存块的
一定是被使用的内存块(孤岛).

在获取一个内存块的指针时(这个指针可以用于获取用户内存的地址),我们可以
在O(1)的时间内,找出临近内存块是不是空闲,如果是,将它从内存列表中删除并
且合并到当前的内存块.

内存块的起始地址总是在字对齐边界,所以内存部分(用于返回给用于)也总是在
字对齐边界上,所以至少是双字节对齐.

P (PINUSE_BIT) 位, 保存在内存块大小(一般是双字节的倍数)的未使用的低位,
是一个被前一个内存块使用的bit位.如果这个bit位被清理了,那么在当前内存块
之前的一个字 大小数据保存着前一个内存块的大小,用于寻找前一个内存块.而
第一个内存块这个bit位总是被置上的,防止访问不存在的内存区域.如果某个内
存块的 pinuse被设置了,你就无法决定上一个内存块的大小,并且如果你真的尝
试这
么做了,有可能内存访问出错.

C (CINUSE_BIT) bit位, 保存在内存块的第二低的bit位,冗余地记录着当前块是
否被使用了(除非当前内存块是被映射的).这个冗余信息用于在free和realloc操
作时的检查,并且减少在执行free和合并内存块时的间接操作.

任 何新分配的内存块必须都设置了cinuse和pinuse.这意味着,任何分配了的内
存块的边界要么是一个先前分撇并且仍然在使用(in-use)的内存 块,要么是它自
己的大内存区域的地址(the base of its memory arena)(译: the difference
between "memory allocator" and "memory arena": An arena is just a
large, contiguous piece of memory that you allocate once and then use
to manage memory manually by handing out parts of that memory;"Memory
allocator" typically means the software that determines how to
allocate memory from an arena.). 这样确保所有的内存申请(allocations)都
是从任何能找到的内存块的"最低"部分获取.进一步地说,不可能存在一个空闲内
存块在物理上紧邻着另 一个空闲内存块,所以每一个空闲内存块被证实在使用
(inuse)的内存块或者内存尾部之前和之后.

注意: 当前块的 'foot'实际上代表着下一个内存块的prev_foot.这使对齐等操
作处理变得容易但会使人在扩展或维护这份代码时感到困惑.

以下是一些例外:

+ 特殊的内存块'top'是最顶上的可用内存块(i.e., 紧邻着可用内存的边界).
这块内存块会被特殊对待. Top 内存块不会被包含在任何的内存分类箱里,
只有在没有任何其他内存块可使用时,才被使用,并且在它非常大时(查看
M\_TRIM\_THRESHOLD) 会被释放一部分回系统.在实际上,top内存块一般被认
为是比其他所有的内存块都大.Top内存块从来不会更新它的尾部数据区域因
为根本没有内存块会在索引上紧跟其后.但是,空间还是会分配给它
(TOP\_FOOT\_SIZE) 用户做内存块的拆分和合并,当空间需要扩展时.

+ 通过mmap分配的内存块,同时会在内存块的头结构中清理cinuse和pinuse两个
标志位.因为它们是一个一个分配的,每一个都携带着它自己独有的
prev_foot域,这个域是用于保存这块内存块在它执行mapped的区域内的偏移
量,在执行内存对齐保护的操作时被用到.每一个映射的内存块会被一 个假的
下一个块(next-chunk)的头两个域记录着,因为要在使用时检查.

###2. 非MSPACE代码逻辑分析###

```
struct malloc_chunk {

size_t               prev_foot;  /* 如果前一个内存块空闲,表示前一个

内存块的大小 */

size_t               head;       /* 大小和inuse bit位*/

struct malloc_chunk* fd;         /* 如果是空闲内存块,指向双向链表*/

struct malloc_chunk* bk;

};



typedef struct malloc_chunk  mchunk;

typedef struct malloc_chunk* mchunkptr;

typedef struct malloc_chunk* sbinptr;  /* 内存块分类箱的类型 */
```

#### head 域中变量的说明: ####

PINUSE_BIT  在前一个相邻的内存块被使用时,这个标志位被置上.
CINUSE_BIT  在当前内存块被使用时,这个标志位被置上.
FLAG4_BIT   在当前版本的dlmalloc中未被使用

如何做到在head中既存放块大小又存放标志位的呢?首先提到一点是,所有的块的
大小都是按最少8bit对齐的,换句话说,表示大小的数字,低3位必定为0,所以就有
效地利用了低3位存放标志位.所以,获取chunk的大小用下面的宏,将head的低三
位清成0,取出.

```#define chunksize(p)        ((p)->head & ~(FLAG_BITS))```

#### 被覆盖的数据结构 ####

当内存块未被使用时,他们作为列表或者树的节点.

小内存("Small") 块存储在环形双向链表中,看起来像如下这样.

```
    chunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Size of previous chunk                            |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    `head:' |             Size of chunk, in bytes                         |P|
      mem-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Forward pointer to next chunk in list             |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Back pointer to previous chunk in list            |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Unused space (may be 0 bytes long)                .
            .                                                               .
            .                                                               |
nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    `foot:' |             Size of chunk, in bytes                           |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

而 大的内存块使用内存块大小为关键字的bitwise digital tree (又叫aka
tree).因为malloc_tree_trunks只是用于大小大于256bytes的空闲内存块,他们
的大小不会受到用户申请的内存大小的限制.每 一个节点的结构看起来像如下这
样.

```
    chunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Size of previous chunk                            |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    `head:' |             Size of chunk, in bytes                         |P|
      mem-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Forward pointer to next chunk of same size        |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Back pointer to previous chunk of same size       |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Pointer to left child (child[0])                  |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Pointer to right child (child[1])                 |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Pointer to parent                                 |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             bin index of this chunk                           |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |             Unused space                                      .
            .                                                               |
nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    `foot:' |             Size of chunk, in bytes                           |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

每一棵树都拥有唯一的内存块大小.而具有同样大小的内存块会被安排在双向链
表里,与最老的内存块一起(指,以FIFO的规则,下一个要被使用的内存块).如果一
个具有同样大小的内存块被插入,它就会用类似小内存的fb/bk的指针一样的方式,从
原有的节点移除.

每 一棵树包含大小为2的乘方范围的内存块(最小为0x100 <= x < 0x180),在树
的每一层都会被分成一半,即小的一半(0x100 <= x < 0x140)作为左子树,大的一
半作为右子树(0x140 <= x < 0x180).

通过使用这种规则,每一个节点的左子树包含的内存块大小都小雨其右子树.


### dlmalloc代码分析 ###

dlmalloc 对小内存分配有如下5个规则(按优先级顺序)：
+ 如果与请求内存大小匹配的箱子存在空闲,则使用当前箱子，否则使用临近的
箱子。在能不分割内存的情况下尽量不分割内存。
+ 如果dv chunk足够大，那么使用dv chunk。 dv chunk是指最近一次小内存
申请时使用的内存块。 这个规则是，尽量保证分配的内存连续。
+ 在smallbin和treebin中寻找可以使用的内存块，并分割。将剩下的内存
块保存到dv chunk中。
+ 如果top chunk 足够大，则使用top chunk
+ 如果请求内存实在太大，则使用系统分配内存。

大内存分配的规则：
+ 在treebin中找到最适合的最小内存，如果它比dv chunk的更合适，就使用它，
如果有需要就分割它。
+ 如果dv chunk 比其他所有的更合适，使用dv chunk。
+ 如果top 足够大，使用top chunk。
+ 如果请求的大小 >= mmap threshold, 则使用系统的mmap。
+ 直接从系统分配内存并使用。

#### 小内存规则一 ####

```
2577 #define MAX_SMALL_REQUEST (MAX_SMALL_SIZE - CHUNK_ALIGN_MASK -
CHUNK_OVERHEAD)

4597     if (bytes <= MAX_SMALL_REQUEST) {
```
这里bytes为申请的内存大小, MAX_SMALL_REQUEST就是之前提到过的最大的小内
存块的大小,我们就认为是256byte,即,256byte以下的所有内存都是在双向链表
中匹配.

```
2225 #define MIN_REQUEST         (MIN_CHUNK_SIZE - CHUNK_OVERHEAD -
SIZE_T_ONE)

2228 #define pad_request(req) \
2229    (((req) + CHUNK_OVERHEAD + CHUNK_ALIGN_MASK) &
~CHUNK_ALIGN_MASK)

4600       nb = (bytes < MIN_REQUEST)? MIN_CHUNK_SIZE :
pad_request(bytes);
```
这里nb就是加上协议数据后的实际dlmalloc会分配的内存块大小.前文笔者提到
过,小内存块的最小值为8byte,所以,不论申请的内存多小,都使用最小值.

```
2572 #define SMALLBIN_SHIFT    (3U)

2825 #define small_index(s)      (bindex_t)((s)  >> SMALLBIN_SHIFT)

4601      idx = small_index(nb);
```
这里idx得到的是该内存块对应的smallbin箱子的箱号.前文在提到head时,提到
过,小内存块的大小为8byte的倍数,所以,右移3位来定位对应箱子的箱号.

```
4602       smallbits = gm->smallmap >> idx;
```
smallmap 是各个箱子的位图,32bit,对应32个箱子,每一位为1表示该箱号中有对
应大小的内存块,为0则表示没有.该行代码是把对应箱号的比特位移到最右侧.

```
4604       if ((smallbits & 0x3U) != 0) {
4605         mchunkptr b, p;
4606         idx += ~smallbits & 1;       /* Uses next bin if idx
empty */
4607         b = smallbin_at(gm, idx);
```
这里 0x3U 低8位就是 0000 0011. 所以,smallbits&0x3U 为真的条件如下:(上
文提到,smallbits的最右位表示idx箱号是否有空闲块)
+ 低2位为 11. idx有空闲块,比idx大1箱号的有空闲块.
+ 低2位为 10. idx无空闲块,比idx大1箱号的有空闲块.
+ 低2位为 01. idx有空闲块,比idx大1箱号的无空闲块.

4606行是在重新定位到真正有空闲块的箱号. ~smallbits & 1 在当前箱子为0的
情况下,值为1;当前箱子为1的情况下,值为0.所以是有限是用正好满足大小的箱
子.

```
2831 #define smallbin_at(M, i)
((sbinptr)((void*)&((M)->smallbins[(i)<<1])))
```
i 就是 idx, 而M则是gm(/*需要在上文预先描述gm结构体成员作用
*/).smallbins(/*需在上文描述*/)就是双向链表数组,也就是对应箱号内部的空
闲块链表的首地址.

值得高兴的是,我们拿到链表了,接下来就是取出空闲块,和一些标志位的处理了.

```
4608        p = b->fd;
4609        assert(chunksize(p) == small_index2size(idx));
4610        unlink_first_small_chunk(gm, b, p, idx);
4611        set_inuse_and_pinuse(gm, p, small_index2size(idx));
4612        mem = chunk2mem(p);
4613        check_malloced_chunk(gm, mem, nb);
4614        goto postaction;
```
如果没记错的花,fd域是前一个链表节点.而B是表头, 也就是说,我们取链表的第
一个元素,取到我们需要的内存块地址.
这个assert其实就是确认下,当前的箱号的内存块大小跟当前内存块的大小是否
匹配.

```

2921#define clear_smallmap(M,i)     ((M)->smallmap &= ~idx2bit(i))

3629#define unlink_first_small_chunk(M, B, P, I) {\
3630  mchunkptr F = P->fd;\
3631  assert(P != B);\
3632  assert(P != F);\
3633  assert(chunksize(P) == small_index2size(I));\
3634  if (B == F) {\
3635    clear_smallmap(M, I);\
3636  }\
3637  else if (RTCHECK(ok_address(M, F) && F->bk == P)) {\
3638    F->bk = B;\
3639    B->fd = F;\
3640  }\
3641  else {\
3642    CORRUPTION_ERROR_ACTION(M);\
3643  }\
3644}
```
这 里 B P F的关系是 F -> P -> B , 所以,理论上, P 不等于F 也不等于B,如
果相等,就意味着是空链表(只有表头).而如果B == F,  意味着该链表中只有一
个空闲内存块.取出该内存块之后,咱们要把该箱子标记为空(3635, 2921).当然,
更多的情况是从链表中移除节点P.

```
// 4611 行函数实现

3058#define set_inuse_and_pinuse(M,p,s)\
3059  ((p)->head = (s|PINUSE_BIT|CINUSE_BIT),\
3060  ((mchunkptr)(((char*)(p)) + (s)))->head |= PINUSE_BIT)
```

这就是在P 的head中置上CINUSE位和P 的下一块内存的head中设置上PINUSE位.

最后mem = chunk2mem(p);  就是取出传递个用户的有效内存地址,.
check_malloced_chunk(gm, mem, nb); 是调试用的,检查该分配的内存块的各个
属性是否正常.

到此,小内存的,正好符合或正好临近箱子有空闲块的逻辑分析完成,咱们拿到了
需要的内存.

#### 小内存规则三 ####

下面,是上述情况不满足,也就是当前内存请求对应的箱号idx的smallbits低2位
为 00 ,也就是说,没有空闲块.

```
4617      else if (nb > gm->dvsize) {
4618        if (smallbits != 0) {
```
(*dvsize需要在gm的分析中描述掉*)  smallbits != 0 意味着,在比请求的内存
块大的箱子中,总有空闲块存在.所以接下来的目的是找到最小的空闲块.

```
2917#define idx2bit(i)              ((binmap_t)(1) << (i))

2929#define least_bit(x)         ((x) & -(x))

2932#define left_bits(x)         ((x<<1) | -(x<<1))

4622          binmap_t leftbits = (smallbits << idx) &
left_bits(idx2bit(idx));
4623          binmap_t leastbit = least_bit(leftbits);
4624          compute_bit2idx(leastbit, i);
```

4622 行 位与的右操作数是一个32bit的数，该数的低（idx+1）位为0,其余位为
1;左操作数就是对应低idx位为0,同时代码逻辑走到这里，我们可以确定，低
（idx+2）为0。
least\_bit 的功能是，保留leftbits中从右往左的第一个为1的位，其余位
为0. 则该leastbit对应的就是符合请求的最小内存块的位图。
compute\_bit2idx 是将leastit位图转换成箱号。 这里 i 就是获取到的箱号。

```
4625          b = smallbin_at(gm, i);
4626          p = b->fd;
4627          assert(chunksize(p) == small_index2size(i));
4628          unlink_first_small_chunk(gm, b, p, i);
```
拿到箱号之后，这块的逻辑与上文规则一的逻辑一样。

```
4629          rsize = small_index2size(i) - nb;
```
取出当前箱子的内存块大小，减去用户请求的大小，剩下的就是剩余的内存块，
这个剩余内存块会放到dv chunk中。

```
2269#define chunk_plus_offset(p, s)  ((mchunkptr)(((char*)(p)) + (s)))

2284#define set_size_and_pinuse_of_free_chunk(p, s)\
2285  ((p)->head = (s|PINUSE_BIT), set_foot(p, s))

3063#define set_size_and_pinuse_of_inuse_chunk(M, p, s)\
3064  ((p)->head = (s|PINUSE_BIT|CINUSE_BIT))

3584#define insert_small_chunk(M, P, S) {\
3585  bindex_t I  = small_index(S);\
3586  mchunkptr B = smallbin_at(M, I);\
3587  mchunkptr F = B;\
3588  assert(S >= MIN_CHUNK_SIZE);\
3589  if (!smallmap_is_marked(M, I))\
        // 如果是对应箱号原状态为0,则置1.
3590    mark_smallmap(M, I);\
3591  else if (RTCHECK(ok_address(M, B->fd)))\
3592    F = B->fd;\
3593  else {\
3594    CORRUPTION_ERROR_ACTION(M);\
3595  }\
3596  B->fd = P;\
3597  F->bk = P;\
3598  P->fd = F;\
3599  P->bk = B;\
3600}

3648#define replace_dv(M, P, S) {\
3649  size_t DVS = M->dvsize;\
3650  assert(is_small(DVS));\
3651  if (DVS != 0) {\
3652    mchunkptr DV = M->dv;\
3653    insert_small_chunk(M, DV, DVS);\
3654  }\
3655  M->dvsize = S;\
3656  M->dv = P;\
3657}


4631          if (SIZE_T_SIZE != 4 && rsize < MIN_CHUNK_SIZE)
4632            set_inuse_and_pinuse(gm, p, small_index2size(i));
4633          else {
4634            set_size_and_pinuse_of_inuse_chunk(gm, p, nb);
4635            r = chunk_plus_offset(p, nb);
4636            set_size_and_pinuse_of_free_chunk(r, rsize);
4637            replace_dv(gm, r, rsize);
4638          }
```

如果剩余大小rsize小于MIN_CHUNK_SIZE，咱们直接将所有内存分配给用户。否
则则分割内存，并将剩余的内存块转成mchunkptr， 即 r。我们然后，r相当于
一个新的内存块，我们设置其head属性（size，PINUSE_BIT，CINUSE_BIT）。
replace_dv 中，我们先获得dv size，确认是小内存块。然后，就是把dv内存块
插入到对应的箱号里。就跟之前，根据大小获取到对应箱号的链表头的逻辑一样，
只是这里是将内存块插入双向链表的第一个位置。
ok， 插入完成后，咱们把刚才分割剩下的内存存放到dv chunk中。

```
4639          mem = chunk2mem(p);
4640          check_malloced_chunk(gm, mem, nb);
4641          goto postaction;
```
这里我们返回内存给用户，规则三第一部分内存分配结束。

```
4644        else if (gm->treemap != 0 && (mem = tmalloc_small(gm, nb))
!= 0) {
4645          check_malloced_chunk(gm, mem, nb);
4646          goto postaction;
```
这里else 对应“4618        if (smallbits != 0) {” 。 也就是说，只有小内
存的>=请求内存大小的所有箱子不存在空闲内存快。 然后，我们检查treemap中
是否存在空闲块，如果存在，则调用tmalloc_small。

```
2833#define treebin_at(M,i)     (&((M)->treebins[i]))

4527-static void* tmalloc_small(mstate m, size_t nb) {
...
4531  binmap_t leastbit = least_bit(m->treemap);
4532  compute_bit2idx(leastbit, i);
4533  v = t = *treebin_at(m, i);
4534  rsize = chunksize(t) - nb;
```
least_bit 的作用就是保留最右侧为1的bit位，其余位为0.所以，
least_bit和compute_bit2idx的共同作用就是在treemap中找到最小的可用
内存箱子。v和t即为找到的内存块树的根节点。

```
4536  while ((t = leftmost_child(t)) != 0) {
4537    size_t trem = chunksize(t) - nb;
4538    if (trem < rsize) {
4539      rsize = trem;
4540      v = t;
4541    }
4542  }
```

这段代码是寻找t的最左子树。在前文我们介绍过aka树，每一棵树的做子树总小
于其右子树。该代码就是在寻找满足用于请求大小nb的最接近的树的节点。（考
虑到请求的字节nb<=256byte, 而在tree中最小的chunksize > 256byte 所以,不
会出现负数.）

```
4545    mchunkptr r = chunk_plus_offset(v, nb);
4546    assert(chunksize(v) == rsize + nb);
4547    if (RTCHECK(ok_next(v, r))) {
4548      unlink_large_chunk(m, v);
4549      if (rsize < MIN_CHUNK_SIZE)
4550        set_inuse_and_pinuse(m, v, (rsize + nb));
4551      else {
4552        set_size_and_pinuse_of_inuse_chunk(m, v, nb);
4553        set_size_and_pinuse_of_free_chunk(r, rsize);
4554        replace_dv(m, r, rsize);
4555      }
4556      return chunk2mem(v);
4557    }
4558  }
```
(NOT READY)
这段代码跟上文小内存找到后处理的代码相似。唯一的区别是，
unlink\_large\_chunk，所以我们看下unlink\_large\_chunk的实现.这个过程有三
个步骤
+  如果结点X是链表的结点,则将其重链表中删除.
+  如果X是该大小的最后一个结点,但是不是叶子结点,它必须用一个叶子结点替
换.这里查找叶子结点的方法是从最右侧开始.
+  如果X是链表的头(拥有parent linker),就需要重新将其x的父结点与替换x的
结点重新连接.


```
3730#define unlink_large_chunk(M, X) {\
3731  tchunkptr XP = X->parent;\
3732  tchunkptr R;\
```

```
3733  if (X->bk != X) {\
3734    tchunkptr F = X->fd;\
3735    R = X->bk;\
3736    if (RTCHECK(ok_address(M, F) && F->bk == X && R->fd == X)) {\
3737      F->bk = R;\
3738      R->fd = F;\
3739    }\
3740    else {\
3741      CORRUPTION_ERROR_ACTION(M);\
3742    }\
3743  }\
```
这里是第一种情况,即x是属于双向链表中的一个结点.

```
3744  else {\
3745    tchunkptr* RP;\
3746    if (((R = *(RP = &(X->child[1]))) != 0) ||\
3747        ((R = *(RP = &(X->child[0]))) != 0)) {\
3748      tchunkptr* CP;\
3749      while ((*(CP = &(R->child[1])) != 0) ||\
3750             (*(CP = &(R->child[0])) != 0)) {\
3751        R = *(RP = CP);\
3752      }\
3753      if (RTCHECK(ok_address(M, RP)))\
3754        *RP = 0;\
3755      else {\
3756        CORRUPTION_ERROR_ACTION(M);\
3757      }\
3758    }\
3759  }\
```


以上,独属于小内存的分配规则结束!

```
2224#define MAX_REQUEST         ((-((MCHUNK_SIZE + CHUNK_ALIGN_MASK) &
~CHUNK_ALIGN_MASK)) << 2)

4650    else if (bytes >= MAX_REQUEST)
4651      nb = MAX_SIZE_T; /* Too big to allocate. Force failure (in
sys alloc) */

4692    mem = sys_alloc(gm, nb);
```
这里,当请求内存大小>= MAX_REQUEST时,我们强制分配失败.`CHUNK_ALIGN_MASK` 为 `2 * sizeof(void *) - 1`,在32bit上为7.所以
MAX\_REQUEST是一个极大的数.在这种情况下,我们将nb设置为ffffffff,强制失
败.

####大内存分配规则一####
类似小内存分配规则一,从树中找到最适合的内存块.

```
// 待分析
// dlmalloc 树的遍历算法
4652    else {
4653      nb = pad_request(bytes);
4654      if (gm->treemap != 0 && (mem = tmalloc_large(gm, nb)) != 0)
{
4655        check_malloced_chunk(gm, mem, nb);
4656        goto postaction;
4657      }
4658    }
```
这里我们的重点是`tmalloc_large`,它与`tmalloc_small`的差别
是:`tmalloc_small`是用于小内存分配的,只需要在treemap中找到最小的有效树,取
出树中最小内存即可;而`tmalloc_large`是按照一定的规则,在所有32棵树中找
到最匹配大小的内存块.

```
4456static void* tmalloc_large(mstate m, size_t nb) {
4457  tchunkptr v = 0;
4458  size_t rsize = -nb; /* Unsigned negation */
4459  tchunkptr t;
4460  bindex_t idx;
4461  compute_tree_index(nb, idx);
4462  if ((t = *treebin_at(m, idx)) != 0) {
```

rsize 为极大数. `compute_tree_index`通过请求的大小nb,从treebinmap中计
算出箱号.`treebin_at` 则是取出idx箱号中对应的树根结
点.(`compute_tree_index`)
```
2880#define compute_tree_index(S, I)\
2881{\
2882  size_t X = S >> TREEBIN_SHIFT;\
2883  if (X == 0)\
2884    I = 0;\
2885  else if (X > 0xFFFF)\
2886    I = NTREEBINS-1;\
2887  else {\
2888    unsigned int Y = (unsigned int)X;\
2889    unsigned int N = ((Y - 0x100) >> 16) & 8;\
2890    unsigned int K = (((Y <<= N) - 0x1000) >> 16) & 4;\
2891    N += K;\
2892    N += K = (((Y <<= K) - 0x4000) >> 16) & 2;\
2893    K = 14 - N + ((Y <<= K) >> 15);\
2894    I = (K << 1) + ((S >> (K + (TREEBIN_SHIFT-1)) & 1));\
2895  }\
2896}
```

以上计算的结果如下,idx为对应箱号,mem对应该箱子中最小的内存大小.

```
idx 0 mem 256 hex: 100
idx 1 mem 384 hex: 180
idx 2 mem 512 hex: 200
idx 3 mem 768 hex: 300
idx 4 mem 1024 hex: 400
idx 5 mem 1536 hex: 600
idx 6 mem 2048 hex: 800
idx 7 mem 3072 hex: c00
idx 8 mem 4096 hex: 1000
idx 9 mem 6144 hex: 1800
idx 10 mem 8192 hex: 2000
idx 11 mem 12288 hex: 3000
idx 12 mem 16384 hex: 4000
idx 13 mem 24576 hex: 6000
idx 14 mem 32768 hex: 8000
idx 15 mem 49152 hex: c000
idx 16 mem 65536 hex: 10000
idx 17 mem 98304 hex: 18000
idx 18 mem 131072 hex: 20000
idx 19 mem 196608 hex: 30000
idx 20 mem 262144 hex: 40000
idx 21 mem 393216 hex: 60000
idx 22 mem 524288 hex: 80000
idx 23 mem 786432 hex: c0000
idx 24 mem 1048576 hex: 100000
idx 25 mem 1572864 hex: 180000
idx 26 mem 2097152 hex: 200000
idx 27 mem 3145728 hex: 300000
idx 28 mem 4194304 hex: 400000
idx 29 mem 6291456 hex: 600000
idx 30 mem 8388608 hex: 800000
idx 31 mem 12582912 hex: c00000
```

```
4463    /* Traverse tree for this bin looking for node with size == nb
*/
4464    size_t sizebits = nb << leftshift_for_tree_index(idx);
4465    tchunkptr rst = 0;  /* The deepest untaken right subtree */
4466    for (;;) {
4467      tchunkptr rt;
4468      size_t trem = chunksize(t) - nb;
4469      if (trem < rsize) {
4470        v = t;
4471        if ((rsize = trem) == 0)
4472          break;
4473      }
4474      rt = t->child[1];
4475      t = t->child[(sizebits >> (SIZE_T_BITSIZE-SIZE_T_ONE)) & 1];
4476      if (rt != 0 && rt != t)
4477        rst = rt;
4478      if (t == 0) {
4479        t = rst; /* set t to least subtree holding sizes > nb */
4480        break;
4481      }
4482      sizebits <<= 1;
4483    }
```
这是树的搜索算法,我们来详细看下.首先sizebits变量,类似binmap,没一位对应
树的对应深度的左右子树,可以认为是遍历树的key bits.
```
1601#define SIZE_T_BITSIZE      (sizeof(size_t) << 3)
1606#define SIZE_T_ONE          ((size_t)1)
2574#define TREEBIN_SHIFT     (8U)

2904#define leftshift_for_tree_index(i) \
2905   ((i == NTREEBINS-1)? 0 : \
2906    ((SIZE_T_BITSIZE-SIZE_T_ONE) - (((i) >> 1) + TREEBIN_SHIFT - 2)))
```
`leftshift_for_tree_index`宏返回该关键码的长度.计算的结果为 (25 - (i
>> 1)).

然后我们看for循环内部的,这就是在遍历树了.
```
4467      tchunkptr rt;
4468      size_t trem = chunksize(t) - nb;
4469      if (trem < rsize) {
4470        v = t;
4471        if ((rsize = trem) == 0)
4472          break;
4473      }
```

与寻找最匹配nb最近的点.当然,如果找到大小相等的,就直接跳出.

```
4474      rt = t->child[1];
4475      t = t->child[(sizebits >> (SIZE_T_BITSIZE-SIZE_T_ONE)) & 1];
4476      if (rt != 0 && rt != t)
4477        rst = rt;
4478      if (t == 0) {
4479        t = rst; /* set t to least subtree holding sizes > nb */
4480        break;
4481      }
4482      sizebits <<= 1;
```
`(sizebits >> (SIZE_T_BITSIZE-SIZE_T_ONE))` 这个就是每一层树的特征码了.结
合上面sizebits的值,我们可以算出这个表达式的值为 nb >> (6 + (i >>
1)). 如果,我们再结合`compute_tree_index` 中的结果,得到如下表.idx为箱号,
mem为该箱子中的最小内存,hex为该值的16进制,mid为区分左子树和右子树的特
征码,bitshift为特征码的无效位数. 比如,箱子1中,dix为1,其表示的内存范围
为
[384, 512),则其左子树表示范围为[384,448),右子树为[448,512).448即为该树的地一层的特征码,也就是111000000.
所以,只要通过将size >> bitshift 之后与1 做位与运算,就可以判断出在该树对应层该进入其左子树还是右子树.

```
idx 0 mem 256 hex: 100  mid: 101000000 bitshift: 6
idx 1 mem 384 hex: 180 mid: 111000000 bitshift: 6
idx 2 mem 512 hex: 200 mid: 1110000000 bitshift: 7
idx 3 mem 768 hex: 300 mid: 1010000000 bitshift: 7
idx 4 mem 1024 hex: 400 mid: 10100000000 bitshift: 8
idx 5 mem 1536 hex: 600 mid: 11100000000 bitshift: 8
idx 6 mem 2048 hex: 800 mid: 101000000000 bitshift: 9
idx 7 mem 3072 hex: c00 mid: 111000000000 bitshift: 9
idx 8 mem 4096 hex: 1000 mid: 1010000000000 bitshift: 10
idx 9 mem 6144 hex: 1800 mid: 1110000000000 bitshift: 10
idx 10 mem 8192 hex: 2000 mid: 10100000000000 bitshift: 11
idx 11 mem 12288 hex: 3000 mid: 11100000000000 bitshift: 11
idx 12 mem 16384 hex: 4000 mid: 101000000000000 bitshift: 12
idx 13 mem 24576 hex: 6000 mid: 111000000000000 bitshift: 12
idx 14 mem 32768 hex: 8000 mid: 1010000000000000 bitshift: 13
idx 15 mem 49152 hex: c000 mid: 1110000000000000 bitshift: 13
idx 16 mem 65536 hex: 10000 mid 10100000000000000 bitshift: 14
idx 17 mem 98304 hex: 18000 mid 11100000000000000 bitshift: 14
idx 18 mem 131072 hex: 20000 mid 101000000000000000 bitshift: 15
idx 19 mem 196608 hex: 30000 mid 111000000000000000 bitshift: 15
idx 20 mem 262144 hex: 40000 mid 1010000000000000000 bitshift: 16
idx 21 mem 393216 hex: 60000 mid 1110000000000000000 bitshift: 16
idx 22 mem 524288 hex: 80000 mid 10100000000000000000 bitshift: 17
idx 23 mem 786432 hex: c0000 mid 11100000000000000000 bitshift: 17
idx 24 mem 1048576 hex: 100000 mid 101000000000000000000 bitshift: 18
idx 25 mem 1572864 hex: 180000 mid 111000000000000000000 bitshift: 18
idx 26 mem 2097152 hex: 200000 mid 1010000000000000000000 bitshift: 19
idx 27 mem 3145728 hex: 300000 mid 1110000000000000000000 bitshift: 19
idx 28 mem 4194304 hex: 400000 mid 10100000000000000000000 bitshift: 20
idx 29 mem 6291456 hex: 600000 mid 11100000000000000000000 bitshift: 20
idx 30 mem 8388608 hex: 800000 mid 101000000000000000000000 bitshift: 21
idx 31 mem 12582912 hex: c00000 bitshift: 31
```
// 图, dlammloc 树的图.

```
4485  if (t == 0 && v == 0) { /* set t to root of next non-empty treebin */
4486    binmap_t leftbits = left_bits(idx2bit(idx)) & m->treemap;
4487    if (leftbits != 0) {
4488      bindex_t i;
4489      binmap_t leastbit = least_bit(leftbits);
4490      compute_bit2idx(leastbit, i);
4491      t = *treebin_at(m, i);
4492    }
4493  }
```
这里对应上文的`4462  if ((t = *treebin_at(m, idx)) != 0) {` , 也就是说在当前大小的箱子内不存在空闲的内存块,所以我们要把t设置为最近的存在空闲内存块的箱号.`left_bits` 和 `least_bit` 跟上文小内存寻找最近存在空闲内存块的箱子算法一样.

```
4495  while (t != 0) { /* find smallest of tree or subtree */
4496    size_t trem = chunksize(t) - nb;
4497    if (trem < rsize) {
4498      rsize = trem;
4499      v = t;
4500    }
4501    t = leftmost_child(t);
4502  }
```
这里跟`tmalloc_small`寻找最左子树(最小内存)的算法一样.这段代码对上面的两种情况都有效.即,如果在对应箱号有空闲内存,在基于树的搜索算法找到的t就是最匹配nb的大小,所以这里的while循环结果t就不会改变;如果是,寻找最近有空闲块的树,那么该树的最小内存都大于请求大小nb,所以直接寻找最左子树.

```
4505  if (v != 0 && rsize < (size_t)(m->dvsize - nb)) {
4506    if (RTCHECK(ok_address(m, v))) { /* split */
4507      mchunkptr r = chunk_plus_offset(v, nb);
4508      assert(chunksize(v) == rsize + nb);
4509      if (RTCHECK(ok_next(v, r))) {
4510        unlink_large_chunk(m, v);
4511        if (rsize < MIN_CHUNK_SIZE)
4512          set_inuse_and_pinuse(m, v, (rsize + nb));
4513        else {
4514          set_size_and_pinuse_of_inuse_chunk(m, v, nb);
4515          set_size_and_pinuse_of_free_chunk(r, rsize);
4516          insert_chunk(m, r, rsize);
4517        }
4518        return chunk2mem(v);
4519      }
4520    }
4521    CORRUPTION_ERROR_ACTION(m);
4522  }
4523  return 0;
```
接下来,只要求顶找到的内存块比dv chunk更合适,则执行一般的内存块收尾处理,然后返回.如果dv chunk更合适,我们返回0, 参考代码
`4654      if (gm->treemap != 0 && (mem = tmalloc_large(gm, nb)) != 0) { `, 就会继续按照内存分配规则往下走.


####大小内存分配规则二####
如果nb的大小小雨dv chunk的大小,则使用dv chunk分配内存.尽量保证连续的内
存请求在虚拟内存上连续.

```
4660    if (nb <= gm->dvsize) {
4661      size_t rsize = gm->dvsize - nb;
4662      mchunkptr p = gm->dv;
4663      if (rsize >= MIN_CHUNK_SIZE) { /* split dv */
4664        mchunkptr r = gm->dv = chunk_plus_offset(p, nb);
4665        gm->dvsize = rsize;
4666        set_size_and_pinuse_of_free_chunk(r, rsize);
4667        set_size_and_pinuse_of_inuse_chunk(gm, p, nb);
4668      }
4669      else { /* exhaust dv */
4670        size_t dvs = gm->dvsize;
4671        gm->dvsize = 0;
4672        gm->dv = 0;
4673        set_inuse_and_pinuse(gm, p, dvs);
4674      }
4675      mem = chunk2mem(p);
4676      check_malloced_chunk(gm, mem, nb);
4677      goto postaction;
4678    }
```
切分dv chunk, 然后就是基本的域设置.返回给用户.

####大小内存分配规则四####

```
4680    else if (nb < gm->topsize) { /* Split top */
4681      size_t rsize = gm->topsize -= nb;
4682      mchunkptr p = gm->top;
4683      mchunkptr r = gm->top = chunk_plus_offset(p, nb);
4684      r->head = rsize | PINUSE_BIT;
4685      set_size_and_pinuse_of_inuse_chunk(gm, p, nb);
4686      mem = chunk2mem(p);
4687      check_top_chunk(gm, gm->top);
4688      check_malloced_chunk(gm, mem, nb);
4689      goto postaction;
4690    }
```
跟dv chunk类似.难点其实是找到符合的chunk.像dv chunk 和top chunk都是找到了的,就直接分配.

####大小内存分配规则五####
调用系统函数进行内存分配.这里使用到了segment.

```
4692    mem = sys_alloc(gm, nb);
4693
4694  postaction:
4695    POSTACTION(gm);
4696    return mem;
4697  }
4698
4699  return 0;
```

先说下`sys_alloc`的规则:
+   优先使用MORECORE(sbrk())分配连续的内存空间
+   使用mmap分配不连续的内存空间
+   使用sbrk()分配不连续的内存空间.

sbrk实际上是对进程的数据段进行扩展,返回增长的区域的基地址.

```
4059  /* Directly map large chunks, but only if already initialized */
4060  if (use_mmap(m) && nb >= mparams.mmap_threshold && m->topsize != 0) {
4061    void* mem = mmap_alloc(m, nb);
4062    if (mem != 0)
4063      return mem;
4064  }
```
如果使用mmap的标志被置上并且nb >= mmap的阀值,则直接使用mmap.

```
4066  asize = granularity_align(nb + SYS_ALLOC_PADDING);
```
做对其处理.

```
4105  if (MORECORE_CONTIGUOUS && !use_noncontiguous(m)) {
4106    char* br = CMFAIL;
4107    size_t ssize = asize; /* sbrk call size */
4108    msegmentptr ss = (m->top == 0)? 0 : segment_holding(m, (char*)m->top);
4109    ACQUIRE_MALLOC_GLOBAL_LOCK();
```

我们看下`segment_holding`函数.

```
2698static msegmentptr segment_holding(mstate m, char* addr) {
2699  msegmentptr sp = &m->seg;
2700  for (;;) {
2701    if (addr >= sp->base && addr < sp->base + sp->size)
2702      return sp;
2703    if ((sp = sp->next) == 0)
2704      return 0;
2705  }
2706}
```
segment实际上是由单向链表管理的,但由于使用到segment的情况非常少,所以,也没有什么效率问题.
这里的功能就是寻找addr所属的segment块的地址,并返回.结合上面的,ss实际上就是top chunk所在的segment的基地址.

```
4111    if (ss == 0) {  /* First time through or recovery */
4112      char* base = (char*)CALL_MORECORE(0);
4113      if (base != CMFAIL) {
4114        size_t fp;
4115        /* Adjust to end on a page boundary */
4116        if (!is_page_aligned(base))
4117          ssize += (page_align((size_t)base) - (size_t)base);
4118        fp = m->footprint + ssize; /* recheck limits */
4119        if (ssize > nb && ssize < HALF_MAX_SIZE_T &&
4120            (m->footprint_limit == 0 ||
4121             (fp > m->footprint && fp <= m->footprint_limit)) &&
4122            (br = (char*)(CALL_MORECORE(ssize))) == base) {
4123          tbase = base;
4124          tsize = ssize;
4125        }
4126      }
4127    }
```

这里就是处理top chunk为NULL 时的情况, 也就是第一次请求内存分配.`CALL_MORECORE`宏展开来就是`sbrk`.这里是获取当前的program break的地址.
ssize就是请求增加的大小,然后再次调用sbrk.

```
4128    else {
4129      /* Subtract out existing available top space from MORECORE request. */
4130      ssize = granularity_align(nb - m->topsize + SYS_ALLOC_PADDING);
4131      /* Use mem here only if it did continuously extend old space */
4132      if (ssize < HALF_MAX_SIZE_T &&
4133          (br = (char*)(CALL_MORECORE(ssize))) == ss->base+ss->size) {
4134        tbase = br;
4135        tsize = ssize;
4136      }
4137    }
```

对应top chunk 存在的情况.直接扩展top chunk所在的segment.
上面两种情况的tbase都指向增长的块的基地址,tsize指向增长的大小.

```
4139    if (tbase == CMFAIL) {    /* Cope with partial failure */
4140      if (br != CMFAIL) {    /* Try to use/extend the space we did get */
4141        if (ssize < HALF_MAX_SIZE_T &&
4142            ssize < nb + SYS_ALLOC_PADDING) {
4143          size_t esize = granularity_align(nb + SYS_ALLOC_PADDING - ssize);
4144          if (esize < HALF_MAX_SIZE_T) {
4145            char* end = (char*)CALL_MORECORE(esize);
4146            if (end != CMFAIL)
4147              ssize += esize;
4148            else {            /* Can't use; try to release */
4149              (void) CALL_MORECORE(-ssize);
4150              br = CMFAIL;
4151            }
4152          }
4153        }
4154      }
4155      if (br != CMFAIL) {    /* Use the space we did get */
4156        tbase = br;
4157        tsize = ssize;
4158      }
4159      else
4160        disable_contiguous(m); /* Don't try contiguous path in the future */
4161    }
4162
4163    RELEASE_MALLOC_GLOBAL_LOCK();
```
如果部分失败了,即上文的tbase赋值时,if条件部分不满,也就是,请求的ssize > HALF\_MAX\_SIZE\_T(ffffffff/2)或者其他的情况.则我们继续使用br的地址进行扩展.不过一般情况下tbase == CMFAIL 时, br == CFAIL.

```
4166  if (HAVE_MMAP && tbase == CMFAIL) {  /* Try MMAP */
4167    char* mp = (char*)(CALL_MMAP(asize));
4168    if (mp != CMFAIL) {
4169      tbase = mp;
4170      tsize = asize;
4171      mmap_flag = USE_MMAP_BIT;
4172    }
4173  }
```

尝试 mmap.

```
4175  if (HAVE_MORECORE && tbase == CMFAIL) { /* Try noncontiguous MORECORE */
4176    if (asize < HALF_MAX_SIZE_T) {
4177      char* br = CMFAIL;
4178      char* end = CMFAIL;
4179      ACQUIRE_MALLOC_GLOBAL_LOCK();
4180      br = (char*)(CALL_MORECORE(asize));
4181      end = (char*)(CALL_MORECORE(0));
4182      RELEASE_MALLOC_GLOBAL_LOCK();
4183      if (br != CMFAIL && end != CMFAIL && br < end) {
4184        size_t ssize = end - br;
4185        if (ssize > nb + TOP_FOOT_SIZE) {
4186          tbase = br;
4187          tsize = ssize;
4188        }
4189      }
4190    }
4191  }
```

尝试非连续的sbrk.

```
4198    if (!is_initialized(m)) { /* first-time initialization */
4199      if (m->least_addr == 0 || tbase < m->least_addr)
4200        m->least_addr = tbase;
4201      m->seg.base = tbase;
4202      m->seg.size = tsize;
4203      m->seg.sflags = mmap_flag;
4204      m->magic = mparams.magic;
4205      m->release_checks = MAX_RELEASE_CHECK_RATE;
          // 初始化 所有的箱子. 32bit全置0
4206      init_bins(m);
4207#if !ONLY_MSPACES
4208      if (is_global(m))
            // 初始化top chunk.
4209        init_top(m, (mchunkptr)tbase, tsize - TOP_FOOT_SIZE);
4210      else
4211#endif
4212      {
4213        /* Offset top by embedded malloc_state */
4214        mchunkptr mn = next_chunk(mem2chunk(m));
            // 初始化top chunk.
4215        init_top(m, mn, (size_t)((tbase + tsize) - (char*)mn) -TOP_FOOT_SIZE);
4216      }
4217    }
```

在这里,才是真正地对内存管理的一些结构体进行初始化.

```
4219    else {
4220      /* Try to merge with an existing segment */
4221      msegmentptr sp = &m->seg;
4222      /* Only consider most recent segment if traversal suppressed */
4223      while (sp != 0 && tbase != sp->base + sp->size)
4224        sp = (NO_SEGMENT_TRAVERSAL) ? 0 : sp->next;
4225      if (sp != 0 &&
4226          !is_extern_segment(sp) &&
4227          (sp->sflags & USE_MMAP_BIT) == mmap_flag &&
4228          segment_holds(sp, m->top)) { /* append */
4229        sp->size += tsize;
4230        init_top(m, m->top, m->topsize + tsize);
4231      }
4232      else {
4233        if (tbase < m->least_addr)
4234          m->least_addr = tbase;
4235        sp = &m->seg;
4236        while (sp != 0 && sp->base != tbase + tsize)
4237          sp = (NO_SEGMENT_TRAVERSAL) ? 0 : sp->next;
4238        if (sp != 0 &&
4239            !is_extern_segment(sp) &&
4240            (sp->sflags & USE_MMAP_BIT) == mmap_flag) {
4241          char* oldbase = sp->base;
4242          sp->base = tbase;
4243          sp->size += tsize;
4244          return prepend_alloc(m, tbase, oldbase, nb);
4245        }
4246        else
4247          add_segment(m, tbase, tsize, mmap_flag);
4248      }
4249    }
```

逻辑很简单,就是如果新分配的segemnt的基地址是某个segment的尾地址,则这两个合并,否则,直接将该新的segment加入到单向链表中.

```
4251    if (nb < m->topsize) { /* Allocate from new or extended top space */
4252      size_t rsize = m->topsize -= nb;
4253      mchunkptr p = m->top;
4254      mchunkptr r = m->top = chunk_plus_offset(p, nb);
4255      r->head = rsize | PINUSE_BIT;
4256      set_size_and_pinuse_of_inuse_chunk(m, p, nb);
4257      check_top_chunk(m, m->top);
4258      check_malloced_chunk(m, chunk2mem(p), nb);
4259      return chunk2mem(p);
4260    }
4261  }
```

如果是第一次内存分配,则逻辑将会到这里,在top chunk初始化后,尝试从top chunk分配内存.

### dlfree代码分析 ### 

dlfree就没有dlmalloc那么多规则了,只要保证边界标记法,保证释放的内存块存放到对应的箱子中即可.

```
4704void dlfree(void* mem) { 
4711  if (mem != 0) {
```
检查mem合法性.

```
4711  if (mem != 0) {
        //将mem转换成chunk p
4712    mchunkptr p  = mem2chunk(mem);
4713#if FOOTERS
4714    mstate fm = get_mstate_for(p);
4715    if (!ok_magic(fm)) {
4716      USAGE_ERROR_ACTION(fm, p);
4717      return;
4718    }
4719#else /* FOOTERS */
4720#define fm gm
4721#endif /* FOOTERS */ 
4722    if (!PREACTION(fm)) {
          // 检查标志位是否为inuse.
4723      check_inuse_chunk(fm, p);
4724      if (RTCHECK(ok_address(fm, p) && ok_inuse(p))) {
            // 获取chunksize
4725        size_t psize = chunksize(p);
            // 获取在内存上相连的下一个内存chunk.
4726        mchunkptr next = chunk_plus_offset(p, psize); 
```

将用户指针转换为chunk结构体并做常规检查.

```
            // 上一个内存块未被使用
4727        if (!pinuse(p)) {
4728          size_t prevsize = p->prev_foot;
4729          if (is_mmapped(p)) {
                // 是通过系统mmap分配的
4730            psize += prevsize + MMAP_FOOT_PAD;
4731            if (CALL_MUNMAP((char*)p - prevsize, psize) == 0)
4732              fm->footprint -= psize;
4733            goto postaction;
4734          }
4735          else {
               // 与上一个内存块合并
4736            mchunkptr prev = chunk_minus_offset(p, prevsize);
4737            psize += prevsize;
4738            p = prev;
4739            if (RTCHECK(ok_address(fm, prev))) { /* consolidate backward */
4740              if (p != fm->dv) {
                    // p 不为 dv chunk, 直接移除.
4741                unlink_chunk(fm, p, prevsize);
4742              }
4743              else if ((next->head & INUSE_BITS) == INUSE_BITS) {
                    // 否则,合并到dv chunk中.
4744                fm->dvsize = psize;
4745                set_free_with_pinuse(p, psize, next);
4746                goto postaction;
4747              }
4748            }
4749            else
4750              goto erroraction;
4751          }
4752        } 
```

与前一块内存合并的逻辑.

```
4754        if (RTCHECK(ok_next(p, next) && ok_pinuse(next))) {
```

ok\_pinuse(next)实际上就是cinuse(p). 只是这里是检查next的标志位是否正确.

```
              // next 未被使用, 则需要合并.
4755          if (!cinuse(next)) {  /* consolidate forward */
4756            if (next == fm->top) {
                  // 如果next为top, 则top增长.基地址改为p.
4757              size_t tsize = fm->topsize += psize;
4758              fm->top = p;
4759              p->head = tsize | PINUSE_BIT;
4760              if (p == fm->dv) {
                    // 如果p为dv, 则清空dv.
4761                fm->dv = 0;
4762                fm->dvsize = 0;
4763              }
4764              if (should_trim(fm, tsize))
4765                sys_trim(fm, 0);
4766              goto postaction;
4767            }
4768            else if (next == fm->dv) {
                  // 如果next为div, 则dv增长, 基地址改为p
4769              size_t dsize = fm->dvsize += psize;
4770              fm->dv = p;
4771              set_size_and_pinuse_of_free_chunk(p, dsize);
4772              goto postaction;
4773            }
4774            else {
                  // next为普通的内存块,将next合并到p,并将next冲链表或者树中删除.
4775              size_t nsize = chunksize(next);
4776              psize += nsize;
4777              unlink_chunk(fm, next, nsize);
4778              set_size_and_pinuse_of_free_chunk(p, psize);
4779              if (p == fm->dv) {
4780                fm->dvsize = psize;
4781                goto postaction;
4782              }
4783            }
```

与后一块内存合并的逻辑.

```
4785          else
4786            set_free_with_pinuse(p, psize, next);
```

当然,如果不需要合并,则直接删除.


以上都只是合并块,并删除被合并的结点,接下来就是将合并后的块插入到正确的箱子的结构中.

```
4788          if (is_small(psize)) {
                // 合并处理后的内存为小内存
                // 已在上文介绍过该函数.
4789            insert_small_chunk(fm, p, psize);
4790            check_free_chunk(fm, p);
4791          }
4792          else {
                // 合并后为大内存
4793            tchunkptr tp = (tchunkptr)p;
4794            insert_large_chunk(fm, tp, psize);
4795            check_free_chunk(fm, p);
4796            if (--fm->release_checks == 0)
4797              release_unused_segments(fm);
4798          }
4799          goto postaction;
4800        }
4801      }
4802    erroraction:
4803      USAGE_ERROR_ACTION(fm, p);
4804    postaction:
4805      POSTACTION(fm);
4806    }
4807  }  
```

insert\_small\_chunk 已经在上文介绍过.实际行为就是根据内存大小找箱号,如果该箱子本身为空,则修改binmap状态并插入该chunk.如果不为空,则执行双向链表插入.
而`insert_large_chunk`是我们之前提到的`unlink_large_chunk`的逆操作.同样是定位箱号,遍历树.然后找到对应该大小的结点.如果结点上已经有存在空闲块,则插入双向链表,否则作为链表的表头,归属于该结点.


### 总结 ###

数据结构总结
+  dlmalloc中按照内存的粒度大小,分为chunk和segment两种数据结构.
+  dlmalloc中按照内存的大小,有3种内存管理方式,再加上边界标记法,总共四种管理方式:
   +　边界标记法，并且任意相连两块内存不同为空闲内存．
   +  双向链表管理大小小于256byte的内存.
   +  dlmalloc树与双向链表结合管理大小大于256byte的内存.
   +  单向链表管理segment结构.
+  dlmalloc通过两个位图分别管理双向链表和dlmalloc树.

```
+---------------------------segment-------------------------------------+
+  0X10   |  0X12  |  0x109 |  0x110 |                                  +
+ chunk0  | chunk1 | chunk2 | chunk3 |            top                   +
+-----------------------------------------------------------------------+

上面的数字为chunk结构体中的size.
chunk0和chunk1 都为小内存,大小为0x10, 16byte.而 chunk1 的0x02是表示chunk0表示自己使用.chunk0 归属与箱号为2,由双向链表管理.
chunk2和chunk3 为大内存, 大小为0x108, 264byte. chunk2 大小 | 0x01表示前一个内存块被使用. chunk3 | 0x02 因为自己在被使用. 这两个归属与箱号为0的树管理.
最后 是top块.

setgment由系统通过sbrk分配.
top 从segment而来.如果top超过一个阀值,就会通过sbrk,缩小.如果太小,通过sbrk扩大top.
各个chunk 由 top切分, 或者free时, 或者dv chunk被替换时产生.
```

算法总结:

+  小内存分配规则
   +  跟据请求大小,优先寻找最匹配的箱子,之后临近箱子.在能不分割内存的情况下尽量不分割内存.
   +  如果dv chunk足够大,则使用dv chunk.
   +  如果前两个不满足,则在smallbin中寻找最接近请求大小的空闲块箱号.
   +  如果top 足够大,使用top.
   +  如果请求内存实在太大,则使用系统分配.
   
+  大内存分配规则
   +  如果treebin中找到最合适的最小内存,如果它比dv chunk更合适,就使用它.
   +  如果dv chunk比其他所有合适,则使用dv chunk.
   +  如果top 足够大,则使用top.
   +  如果请求大小 >= mmap的阀值,则使用mmap.
   +  直接从系统分配内存.

+  内存释放规则
   +  如果在虚拟内存上的当前释放内存的前/后一个内存为空闲,则合并.
   +  如果前/后一个内存为dv chunk, 则合并到dv chunk
   +  如果前/后一个内存为top, 则合并到top
   +  如果前/后一个内存为普通内存块,则删除后,查找并插入符合大小的箱子中.

+  smallbin 和 treebin的规则.
   +  smallbin 为32bit数,没一个bit对应一个箱子的状态.1 为有空闲内存, 0 为无. 32个箱子的大小为以8 为基数, 以8 为增率, 长度为32的等差数列
   +  treebin的状态与smallbin一致. treebin的各个箱子的大小见上文.

+  treebin中的树的搜索算法
   +  该树表示一段内存范围.所以没一棵子树用二分法表示对应的区间范围.
   +  左子树上的任意chunk大小 都小于其右子树的任意chunk的大小,
   +  参考 `tmalloc_large` 的解析.
