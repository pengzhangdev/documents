
out/target/product/elite1000/symbols/system/bin/test_exception:     file format elf32-littlearm


Disassembly of section .plt:

00000710 <.plt>:
 710:	e52de004 	.word	0xe52de004
 714:	e59fe004 	.word	0xe59fe004
 718:	e08fe00e 	.word	0xe08fe00e
 71c:	e5bef008 	.word	0xe5bef008
 720:	00002894 	.word	0x00002894
 724:	e28fc600 	.word	0xe28fc600
 728:	e28cca02 	.word	0xe28cca02
 72c:	e5bcf894 	.word	0xe5bcf894
 730:	e28fc600 	.word	0xe28fc600
 734:	e28cca02 	.word	0xe28cca02
 738:	e5bcf88c 	.word	0xe5bcf88c
 73c:	e28fc600 	.word	0xe28fc600
 740:	e28cca02 	.word	0xe28cca02
 744:	e5bcf884 	.word	0xe5bcf884
 748:	e28fc600 	.word	0xe28fc600
 74c:	e28cca02 	.word	0xe28cca02
 750:	e5bcf87c 	.word	0xe5bcf87c
 754:	e28fc600 	.word	0xe28fc600
 758:	e28cca02 	.word	0xe28cca02
 75c:	e5bcf874 	.word	0xe5bcf874
 760:	e28fc600 	.word	0xe28fc600
 764:	e28cca02 	.word	0xe28cca02
 768:	e5bcf86c 	.word	0xe5bcf86c
 76c:	e28fc600 	.word	0xe28fc600
 770:	e28cca02 	.word	0xe28cca02
 774:	e5bcf864 	.word	0xe5bcf864
 778:	e28fc600 	.word	0xe28fc600
 77c:	e28cca02 	.word	0xe28cca02
 780:	e5bcf85c 	.word	0xe5bcf85c
 784:	e28fc600 	.word	0xe28fc600
 788:	e28cca02 	.word	0xe28cca02
 78c:	e5bcf854 	.word	0xe5bcf854
 790:	e28fc600 	.word	0xe28fc600
 794:	e28cca02 	.word	0xe28cca02
 798:	e5bcf84c 	.word	0xe5bcf84c
 79c:	e28fc600 	.word	0xe28fc600
 7a0:	e28cca02 	.word	0xe28cca02
 7a4:	e5bcf844 	.word	0xe5bcf844
 7a8:	e28fc600 	.word	0xe28fc600
 7ac:	e28cca02 	.word	0xe28cca02
 7b0:	e5bcf83c 	.word	0xe5bcf83c
 7b4:	e28fc600 	.word	0xe28fc600
 7b8:	e28cca02 	.word	0xe28cca02
 7bc:	e5bcf834 	.word	0xe5bcf834
 7c0:	e28fc600 	.word	0xe28fc600
 7c4:	e28cca02 	.word	0xe28cca02
 7c8:	e5bcf82c 	.word	0xe5bcf82c
 7cc:	e28fc600 	.word	0xe28fc600
 7d0:	e28cca02 	.word	0xe28cca02
 7d4:	e5bcf824 	.word	0xe5bcf824
 7d8:	e28fc600 	.word	0xe28fc600
 7dc:	e28cca02 	.word	0xe28cca02
 7e0:	e5bcf81c 	.word	0xe5bcf81c

Disassembly of section .text:

000007f0 <_start>:
     7f0:	e1a0000d 	mov	r0, sp
     7f4:	e3a01000 	mov	r1, #0
     7f8:	e59f2020 	ldr	r2, [pc, #32]	; 820 <_start+0x30>
     7fc:	e28f300c 	add	r3, pc, #12
     800:	e59f401c 	ldr	r4, [pc, #28]	; 824 <_start+0x34>
     804:	e12fff34 	blx	r4
     808:	e3a00000 	mov	r0, #0
     80c:	e12fff10 	bx	r0
     810:	00002e78 	.word	0x00002e78
     814:	00002e80 	.word	0x00002e80
     818:	00002e88 	.word	0x00002e88
     81c:	00002e90 	.word	0x00002e90
     820:	00000961 	.word	0x00000961
     824:	00000000 	.word	0x00000000
     828:	e1a00000 	nop			; (mov r0, r0)
     82c:	e1a00000 	nop			; (mov r0, r0)

00000830 <_ZNSt11char_traitsIcE11to_int_typeERKc>:
  typedef mbstate_t state_type;

  static char _STLP_CALL to_char_type(const int& __c)
  { return (char)(unsigned char)__c; }

  static int _STLP_CALL to_int_type(const char& __c)
     830:	b082      	sub	sp, #8
     832:	9001      	str	r0, [sp, #4]
  { return (unsigned char)__c; }
     834:	9b01      	ldr	r3, [sp, #4]
     836:	781b      	ldrb	r3, [r3, #0]
     838:	4618      	mov	r0, r3
     83a:	b002      	add	sp, #8
     83c:	4770      	bx	lr
     83e:	bf00      	nop

00000840 <_ZNSt11char_traitsIcE6lengthEPKc>:

  static int _STLP_CALL compare(const char* __s1, const char* __s2, size_t __n)
  { return memcmp(__s1, __s2, __n); }

  static size_t _STLP_CALL length(const char* __s)
     840:	b500      	push	{lr}
     842:	b083      	sub	sp, #12
     844:	9001      	str	r0, [sp, #4]
  { return strlen(__s); }
     846:	9801      	ldr	r0, [sp, #4]
     848:	f7ff ef72 	blx	730 <_start-0xc0>
     84c:	4603      	mov	r3, r0
     84e:	4618      	mov	r0, r3
     850:	b003      	add	sp, #12
     852:	bd00      	pop	{pc}

00000854 <_ZNKSt8ios_base5flagsEv>:
  _STLP_STATIC_CONSTANT(int, beg = 0x01);
  _STLP_STATIC_CONSTANT(int, cur = 0x02);
  _STLP_STATIC_CONSTANT(int, end = 0x04);

public:                         // Flag-manipulation functions.
  fmtflags flags() const { return _M_fmtflags; }
     854:	b082      	sub	sp, #8
     856:	9001      	str	r0, [sp, #4]
     858:	9b01      	ldr	r3, [sp, #4]
     85a:	685b      	ldr	r3, [r3, #4]
     85c:	4618      	mov	r0, r3
     85e:	b002      	add	sp, #8
     860:	4770      	bx	lr
     862:	bf00      	nop

00000864 <_ZNKSt8ios_base5widthEv>:
    streamsize __tmp = _M_precision;
    _M_precision = __newprecision;
    return __tmp;
  }

  streamsize width() const { return _M_width; }
     864:	b082      	sub	sp, #8
     866:	9001      	str	r0, [sp, #4]
     868:	9b01      	ldr	r3, [sp, #4]
     86a:	69db      	ldr	r3, [r3, #28]
     86c:	4618      	mov	r0, r3
     86e:	b002      	add	sp, #8
     870:	4770      	bx	lr
     872:	bf00      	nop

00000874 <_ZNSt8ios_base5widthEi>:
  streamsize width(streamsize __newwidth) {
     874:	b084      	sub	sp, #16
     876:	9001      	str	r0, [sp, #4]
     878:	9100      	str	r1, [sp, #0]
    streamsize __tmp = _M_width;
     87a:	9b01      	ldr	r3, [sp, #4]
     87c:	69db      	ldr	r3, [r3, #28]
     87e:	9303      	str	r3, [sp, #12]
    _M_width = __newwidth;
     880:	9b01      	ldr	r3, [sp, #4]
     882:	9a00      	ldr	r2, [sp, #0]
     884:	61da      	str	r2, [r3, #28]
    return __tmp;
     886:	9b03      	ldr	r3, [sp, #12]
  }
     888:	4618      	mov	r0, r3
     88a:	b004      	add	sp, #16
     88c:	4770      	bx	lr
     88e:	bf00      	nop

00000890 <_ZNKSt8ios_base6getlocEv>:

public:                         // Locales
  locale imbue(const locale&);
  locale getloc() const { return _M_locale; }
     890:	b500      	push	{lr}
     892:	b083      	sub	sp, #12
     894:	9001      	str	r0, [sp, #4]
     896:	9100      	str	r1, [sp, #0]
     898:	9b00      	ldr	r3, [sp, #0]
     89a:	f103 0320 	add.w	r3, r3, #32
     89e:	9801      	ldr	r0, [sp, #4]
     8a0:	4619      	mov	r1, r3
     8a2:	f7ff ef4c 	blx	73c <_start-0xb4>
     8a6:	9801      	ldr	r0, [sp, #4]
     8a8:	b003      	add	sp, #12
     8aa:	bd00      	pop	{pc}

000008ac <_ZNKSt8ios_base7rdstateEv>:
                                // We define them in the non-template
                                // base class to avoid code duplication.
  operator void*() const { return !fail() ? (void*) __CONST_CAST(ios_base*,this) : (void*) 0; }
  bool operator!() const { return fail(); }

  iostate rdstate() const { return _M_iostate; }
     8ac:	b082      	sub	sp, #8
     8ae:	9001      	str	r0, [sp, #4]
     8b0:	9b01      	ldr	r3, [sp, #4]
     8b2:	689b      	ldr	r3, [r3, #8]
     8b4:	4618      	mov	r0, r3
     8b6:	b002      	add	sp, #8
     8b8:	4770      	bx	lr
     8ba:	bf00      	nop

000008bc <_ZNKSt8ios_base4goodEv>:

  bool good() const { return _M_iostate == 0; }
     8bc:	b082      	sub	sp, #8
     8be:	9001      	str	r0, [sp, #4]
     8c0:	9b01      	ldr	r3, [sp, #4]
     8c2:	689b      	ldr	r3, [r3, #8]
     8c4:	2b00      	cmp	r3, #0
     8c6:	bf14      	ite	ne
     8c8:	2300      	movne	r3, #0
     8ca:	2301      	moveq	r3, #1
     8cc:	b2db      	uxtb	r3, r3
     8ce:	4618      	mov	r0, r3
     8d0:	b002      	add	sp, #8
     8d2:	4770      	bx	lr

000008d4 <_ZNSt8ios_base16_M_clear_nothrowEi>:
  // ios_base's private data members.  Does not copy _M_exception_mask
  // or _M_iostate.
  void _M_copy_state(const ios_base& __x);

  void _M_setstate_nothrow(iostate __state) { _M_iostate |= __state; }
  void _M_clear_nothrow(iostate __state) { _M_iostate = __state; }
     8d4:	b082      	sub	sp, #8
     8d6:	9001      	str	r0, [sp, #4]
     8d8:	9100      	str	r1, [sp, #0]
     8da:	9b01      	ldr	r3, [sp, #4]
     8dc:	9a00      	ldr	r2, [sp, #0]
     8de:	609a      	str	r2, [r3, #8]
     8e0:	b002      	add	sp, #8
     8e2:	4770      	bx	lr

000008e4 <_ZNSt8ios_base23_M_check_exception_maskEv>:
  iostate _M_get_exception_mask() const { return _M_exception_mask; }
  void _M_set_exception_mask(iostate __mask) { _M_exception_mask = __mask; }
  void _M_check_exception_mask() {
     8e4:	b500      	push	{lr}
     8e6:	b083      	sub	sp, #12
     8e8:	9001      	str	r0, [sp, #4]
    if (_M_iostate & _M_exception_mask)
     8ea:	9b01      	ldr	r3, [sp, #4]
     8ec:	689a      	ldr	r2, [r3, #8]
     8ee:	9b01      	ldr	r3, [sp, #4]
     8f0:	695b      	ldr	r3, [r3, #20]
     8f2:	4013      	ands	r3, r2
     8f4:	2b00      	cmp	r3, #0
     8f6:	d002      	beq.n	8fe <_ZNSt8ios_base23_M_check_exception_maskEv+0x1a>
      _M_throw_failure();
     8f8:	9801      	ldr	r0, [sp, #4]
     8fa:	f7ff ef26 	blx	748 <_start-0xa8>
  }
     8fe:	b003      	add	sp, #12
     900:	bd00      	pop	{pc}
     902:	bf00      	nop

00000904 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc>:
}

_STLP_TEMPLATE_NULL
inline char
basic_ios<char, char_traits<char> >::widen(char __c) const
{
     904:	b082      	sub	sp, #8
     906:	9001      	str	r0, [sp, #4]
     908:	460b      	mov	r3, r1
     90a:	f88d 3003 	strb.w	r3, [sp, #3]
  return __c;
     90e:	f89d 3003 	ldrb.w	r3, [sp, #3]
}
     912:	4618      	mov	r0, r3
     914:	b002      	add	sp, #8
     916:	4770      	bx	lr

00000918 <_Z3fucii>:
#include <stdlib.h>

using namespace std;

int fuc(int x, int y) //定义函数
{
     918:	b510      	push	{r4, lr}
     91a:	b082      	sub	sp, #8
     91c:	9001      	str	r0, [sp, #4]
     91e:	9100      	str	r1, [sp, #0]
     920:	4c0d      	ldr	r4, [pc, #52]	; (958 <_Z3fucii+0x40>)
     922:	447c      	add	r4, pc
    if(y==0)
     924:	9b00      	ldr	r3, [sp, #0]
     926:	2b00      	cmp	r3, #0
     928:	d10e      	bne.n	948 <_Z3fucii+0x30>
        {
            throw y;     //除数为0，抛出异常
     92a:	f04f 0004 	mov.w	r0, #4
     92e:	f7ff ef12 	blx	754 <_start-0x9c>
     932:	4603      	mov	r3, r0
     934:	9a00      	ldr	r2, [sp, #0]
     936:	601a      	str	r2, [r3, #0]
     938:	4618      	mov	r0, r3
     93a:	4b08      	ldr	r3, [pc, #32]	; (95c <_Z3fucii+0x44>)
     93c:	58e3      	ldr	r3, [r4, r3]
     93e:	4619      	mov	r1, r3
     940:	f04f 0200 	mov.w	r2, #0
     944:	f7ff ef0c 	blx	760 <_start-0x90>
            // longjmp(buffer ,value);
        }
    return x/y;     //否则返回两个数的商
     948:	9801      	ldr	r0, [sp, #4]
     94a:	9900      	ldr	r1, [sp, #0]
     94c:	f7ff ef0e 	blx	76c <_start-0x84>
     950:	4603      	mov	r3, r0
}
     952:	4618      	mov	r0, r3
     954:	b002      	add	sp, #8
     956:	bd10      	pop	{r4, pc}
     958:	0000268e 	.word	0x0000268e
     95c:	ffffffec 	.word	0xffffffec

00000960 <main>:

int main()
{
     960:	b510      	push	{r4, lr}
     962:	b084      	sub	sp, #16
     964:	4c24      	ldr	r4, [pc, #144]	; (9f8 <main+0x98>)
     966:	447c      	add	r4, pc
    int res;
    try {  //定义异常
        res=fuc(2,3);
     968:	f04f 0002 	mov.w	r0, #2
     96c:	f04f 0103 	mov.w	r1, #3
     970:	f7ff ffd2 	bl	918 <_Z3fucii>
     974:	4603      	mov	r3, r0
     976:	9301      	str	r3, [sp, #4]
        cout<<"The result of x/y is : "<<res<<endl;
     978:	4b20      	ldr	r3, [pc, #128]	; (9fc <main+0x9c>)
     97a:	58e3      	ldr	r3, [r4, r3]
     97c:	4618      	mov	r0, r3
     97e:	4b20      	ldr	r3, [pc, #128]	; (a00 <main+0xa0>)
     980:	447b      	add	r3, pc
     982:	4619      	mov	r1, r3
     984:	f000 f844 	bl	a10 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc>
     988:	4603      	mov	r3, r0
     98a:	4618      	mov	r0, r3
     98c:	9901      	ldr	r1, [sp, #4]
     98e:	f000 f84b 	bl	a28 <_ZNSolsEi>
     992:	4603      	mov	r3, r0
     994:	4618      	mov	r0, r3
     996:	4b1b      	ldr	r3, [pc, #108]	; (a04 <main+0xa4>)
     998:	58e3      	ldr	r3, [r4, r3]
     99a:	4619      	mov	r1, r3
     99c:	f000 f878 	bl	a90 <_ZNSolsEPFRSoS_E>
        res=fuc(4,0); // 出现异常，函数内部会抛出异常
     9a0:	f04f 0004 	mov.w	r0, #4
     9a4:	f04f 0100 	mov.w	r1, #0
     9a8:	f7ff ffb6 	bl	918 <_Z3fucii>
     9ac:	4603      	mov	r3, r0
     9ae:	9301      	str	r3, [sp, #4]
     9b0:	f04f 0300 	mov.w	r3, #0
    }
    catch(double) {            //捕获并处理异常
        cerr<<"error of dividing zero.\n";
        exit(1);                //异常退出程序
    }
}
     9b4:	4618      	mov	r0, r3
     9b6:	b004      	add	sp, #16
     9b8:	bd10      	pop	{r4, pc}
    try {  //定义异常
        res=fuc(2,3);
        cout<<"The result of x/y is : "<<res<<endl;
        res=fuc(4,0); // 出现异常，函数内部会抛出异常
    }
    catch(double) {            //捕获并处理异常
     9ba:	f7ff eede 	blx	778 <_start-0x78>
     9be:	f7ff eee2 	blx	784 <_start-0x6c>
     9c2:	4603      	mov	r3, r0
     9c4:	460a      	mov	r2, r1
     9c6:	2a01      	cmp	r2, #1
     9c8:	d001      	beq.n	9ce <main+0x6e>
     9ca:	f7ff eedc 	blx	784 <_start-0x6c>
     9ce:	4618      	mov	r0, r3
     9d0:	f7ff eede 	blx	790 <_start-0x60>
     9d4:	4603      	mov	r3, r0
     9d6:	e9d3 2300 	ldrd	r2, r3, [r3]
     9da:	e9cd 2302 	strd	r2, r3, [sp, #8]
        cerr<<"error of dividing zero.\n";
     9de:	4b0a      	ldr	r3, [pc, #40]	; (a08 <main+0xa8>)
     9e0:	58e3      	ldr	r3, [r4, r3]
     9e2:	4618      	mov	r0, r3
     9e4:	4b09      	ldr	r3, [pc, #36]	; (a0c <main+0xac>)
     9e6:	447b      	add	r3, pc
     9e8:	4619      	mov	r1, r3
     9ea:	f000 f811 	bl	a10 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc>
        exit(1);                //异常退出程序
     9ee:	f04f 0001 	mov.w	r0, #1
     9f2:	f7ff eed4 	blx	79c <_start-0x54>
     9f6:	bf00      	nop
     9f8:	0000264a 	.word	0x0000264a
     9fc:	fffffff0 	.word	0xfffffff0
     a00:	00000a34 	.word	0x00000a34
     a04:	fffffff4 	.word	0xfffffff4
     a08:	fffffff8 	.word	0xfffffff8
     a0c:	000009e6 	.word	0x000009e6

00000a10 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc>:
  return __os;
}

template <class _Traits>
inline basic_ostream<char, _Traits>& _STLP_CALL
operator<<(basic_ostream<char, _Traits>& __os, const char* __s) {
     a10:	b500      	push	{lr}
     a12:	b083      	sub	sp, #12
     a14:	9001      	str	r0, [sp, #4]
     a16:	9100      	str	r1, [sp, #0]
  __os._M_put_nowiden(__s);
     a18:	9801      	ldr	r0, [sp, #4]
     a1a:	9900      	ldr	r1, [sp, #0]
     a1c:	f000 f844 	bl	aa8 <_ZNSo14_M_put_nowidenEPKc>
  return __os;
     a20:	9b01      	ldr	r3, [sp, #4]
}
     a22:	4618      	mov	r0, r3
     a24:	b003      	add	sp, #12
     a26:	bd00      	pop	{pc}

00000a28 <_ZNSolsEi>:
  _STLP_STATIC_ASSERT( sizeof(unsigned short) <= sizeof(unsigned long) )
  return _STLP_PRIV __put_num(*this, __STATIC_CAST(unsigned long,__x));
}

template <class _CharT, class _Traits>
basic_ostream<_CharT, _Traits>& basic_ostream<_CharT, _Traits>::operator<<(int __x) {
     a28:	b500      	push	{lr}
     a2a:	b085      	sub	sp, #20
     a2c:	9001      	str	r0, [sp, #4]
     a2e:	9100      	str	r1, [sp, #0]
  _STLP_STATIC_ASSERT( sizeof(int) <= sizeof(long) )
  long __tmp = ((this->flags() & _Basic_ios::basefield) != ios_base::dec) ?
                  __STATIC_CAST(long, __STATIC_CAST(unsigned int, __x)): __x;
     a30:	9b01      	ldr	r3, [sp, #4]
     a32:	681b      	ldr	r3, [r3, #0]
     a34:	f1a3 030c 	sub.w	r3, r3, #12
     a38:	681b      	ldr	r3, [r3, #0]
     a3a:	9a01      	ldr	r2, [sp, #4]
     a3c:	18d3      	adds	r3, r2, r3
     a3e:	4618      	mov	r0, r3
     a40:	f7ff ff08 	bl	854 <_ZNKSt8ios_base5flagsEv>
     a44:	9b00      	ldr	r3, [sp, #0]
     a46:	9303      	str	r3, [sp, #12]
  return _STLP_PRIV __put_num(*this, __tmp);
     a48:	9801      	ldr	r0, [sp, #4]
     a4a:	9903      	ldr	r1, [sp, #12]
     a4c:	f000 f948 	bl	ce0 <_ZNSt4priv9__put_numIcSt11char_traitsIcElEERSt13basic_ostreamIT_T0_ES7_T1_>
     a50:	4603      	mov	r3, r0
}
     a52:	4618      	mov	r0, r3
     a54:	b005      	add	sp, #20
     a56:	bd00      	pop	{pc}

00000a58 <_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_>:
//----------------------------------------------------------------------
// basic_ostream manipulators.

template <class _CharT, class _Traits>
inline basic_ostream<_CharT, _Traits>& _STLP_CALL
endl(basic_ostream<_CharT, _Traits>& __os) {
     a58:	b500      	push	{lr}
     a5a:	b083      	sub	sp, #12
     a5c:	9001      	str	r0, [sp, #4]
  __os.put(__os.widen('\n'));
     a5e:	9b01      	ldr	r3, [sp, #4]
     a60:	681b      	ldr	r3, [r3, #0]
     a62:	f1a3 030c 	sub.w	r3, r3, #12
     a66:	681b      	ldr	r3, [r3, #0]
     a68:	9a01      	ldr	r2, [sp, #4]
     a6a:	18d3      	adds	r3, r2, r3
     a6c:	4618      	mov	r0, r3
     a6e:	f04f 010a 	mov.w	r1, #10
     a72:	f7ff ff47 	bl	904 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc>
     a76:	4603      	mov	r3, r0
     a78:	9801      	ldr	r0, [sp, #4]
     a7a:	4619      	mov	r1, r3
     a7c:	f000 f9b4 	bl	de8 <_ZNSo3putEc>
  __os.flush();
     a80:	9801      	ldr	r0, [sp, #4]
     a82:	f000 f9ff 	bl	e84 <_ZNSo5flushEv>
  return __os;
     a86:	9b01      	ldr	r3, [sp, #4]
}
     a88:	4618      	mov	r0, r3
     a8a:	b003      	add	sp, #12
     a8c:	bd00      	pop	{pc}
     a8e:	bf00      	nop

00000a90 <_ZNSolsEPFRSoS_E>:

public:                         // Hooks for manipulators.
  typedef basic_ios<_CharT, _Traits>& (_STLP_CALL *__ios_fn)(basic_ios<_CharT, _Traits>&);
  typedef ios_base& (_STLP_CALL *__ios_base_fn)(ios_base&);
  typedef _Self& (_STLP_CALL *__ostream_fn)(_Self&);
  _Self& operator<< (__ostream_fn __f) { return __f(*this); }
     a90:	b500      	push	{lr}
     a92:	b083      	sub	sp, #12
     a94:	9001      	str	r0, [sp, #4]
     a96:	9100      	str	r1, [sp, #0]
     a98:	9b00      	ldr	r3, [sp, #0]
     a9a:	9801      	ldr	r0, [sp, #4]
     a9c:	4798      	blx	r3
     a9e:	4603      	mov	r3, r0
     aa0:	4618      	mov	r0, r3
     aa2:	b003      	add	sp, #12
     aa4:	bd00      	pop	{pc}
     aa6:	bf00      	nop

00000aa8 <_ZNSo14_M_put_nowidenEPKc>:
      this->setstate(ios_base::badbit);
  }
}

template <class _CharT, class _Traits>
void basic_ostream<_CharT, _Traits>::_M_put_nowiden(const _CharT* __s) {
     aa8:	b510      	push	{r4, lr}
     aaa:	b088      	sub	sp, #32
     aac:	9001      	str	r0, [sp, #4]
     aae:	9100      	str	r1, [sp, #0]
  sentry __sentry(*this);
     ab0:	ab06      	add	r3, sp, #24
     ab2:	4618      	mov	r0, r3
     ab4:	9901      	ldr	r1, [sp, #4]
     ab6:	f000 fa21 	bl	efc <_ZNSo6sentryC1ERSo>
  if (__sentry) {
     aba:	ab06      	add	r3, sp, #24
     abc:	4618      	mov	r0, r3
     abe:	f000 fa59 	bl	f74 <_ZNKSo6sentrycvbEv>
     ac2:	4603      	mov	r3, r0
     ac4:	2b00      	cmp	r3, #0
     ac6:	f000 80fe 	beq.w	cc6 <_ZNSo14_M_put_nowidenEPKc+0x21e>
    bool __failed = true;
     aca:	f04f 0301 	mov.w	r3, #1
     ace:	f88d 300f 	strb.w	r3, [sp, #15]
    streamsize __n = _Traits::length(__s);
     ad2:	9800      	ldr	r0, [sp, #0]
     ad4:	f7ff feb4 	bl	840 <_ZNSt11char_traitsIcE6lengthEPKc>
     ad8:	4603      	mov	r3, r0
     ada:	9304      	str	r3, [sp, #16]
    streamsize __npad = this->width() > __n ? this->width() - __n : 0;
     adc:	9b01      	ldr	r3, [sp, #4]
     ade:	681b      	ldr	r3, [r3, #0]
     ae0:	f1a3 030c 	sub.w	r3, r3, #12
     ae4:	681b      	ldr	r3, [r3, #0]
     ae6:	9a01      	ldr	r2, [sp, #4]
     ae8:	18d3      	adds	r3, r2, r3
     aea:	4618      	mov	r0, r3
     aec:	f7ff feba 	bl	864 <_ZNKSt8ios_base5widthEv>
     af0:	4602      	mov	r2, r0
     af2:	9b04      	ldr	r3, [sp, #16]
     af4:	429a      	cmp	r2, r3
     af6:	dd0d      	ble.n	b14 <_ZNSo14_M_put_nowidenEPKc+0x6c>
     af8:	9b01      	ldr	r3, [sp, #4]
     afa:	681b      	ldr	r3, [r3, #0]
     afc:	f1a3 030c 	sub.w	r3, r3, #12
     b00:	681b      	ldr	r3, [r3, #0]
     b02:	9a01      	ldr	r2, [sp, #4]
     b04:	18d3      	adds	r3, r2, r3
     b06:	4618      	mov	r0, r3
     b08:	f7ff feac 	bl	864 <_ZNKSt8ios_base5widthEv>
     b0c:	4602      	mov	r2, r0
     b0e:	9b04      	ldr	r3, [sp, #16]
     b10:	1ad3      	subs	r3, r2, r3
     b12:	e001      	b.n	b18 <_ZNSo14_M_put_nowidenEPKc+0x70>
     b14:	f04f 0300 	mov.w	r3, #0
     b18:	9305      	str	r3, [sp, #20]

    _STLP_TRY {
      if (__npad == 0)
     b1a:	9b05      	ldr	r3, [sp, #20]
     b1c:	2b00      	cmp	r3, #0
     b1e:	d119      	bne.n	b54 <_ZNSo14_M_put_nowidenEPKc+0xac>
        __failed = this->rdbuf()->sputn(__s, __n) != __n;
     b20:	9b01      	ldr	r3, [sp, #4]
     b22:	681b      	ldr	r3, [r3, #0]
     b24:	f1a3 030c 	sub.w	r3, r3, #12
     b28:	681b      	ldr	r3, [r3, #0]
     b2a:	9a01      	ldr	r2, [sp, #4]
     b2c:	18d3      	adds	r3, r2, r3
     b2e:	4618      	mov	r0, r3
     b30:	f000 fa28 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     b34:	4603      	mov	r3, r0
     b36:	4618      	mov	r0, r3
     b38:	9900      	ldr	r1, [sp, #0]
     b3a:	9a04      	ldr	r2, [sp, #16]
     b3c:	f000 fa2a 	bl	f94 <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputnEPKci>
     b40:	4603      	mov	r3, r0
     b42:	461a      	mov	r2, r3
     b44:	9b04      	ldr	r3, [sp, #16]
     b46:	429a      	cmp	r2, r3
     b48:	bf0c      	ite	eq
     b4a:	2300      	moveq	r3, #0
     b4c:	2301      	movne	r3, #1
     b4e:	f88d 300f 	strb.w	r3, [sp, #15]
     b52:	e09c      	b.n	c8e <_ZNSo14_M_put_nowidenEPKc+0x1e6>
      else if ((this->flags() & ios_base::adjustfield) == ios_base::left) {
     b54:	9b01      	ldr	r3, [sp, #4]
     b56:	681b      	ldr	r3, [r3, #0]
     b58:	f1a3 030c 	sub.w	r3, r3, #12
     b5c:	681b      	ldr	r3, [r3, #0]
     b5e:	9a01      	ldr	r2, [sp, #4]
     b60:	18d3      	adds	r3, r2, r3
     b62:	4618      	mov	r0, r3
     b64:	f7ff fe76 	bl	854 <_ZNKSt8ios_base5flagsEv>
     b68:	4603      	mov	r3, r0
     b6a:	f003 0307 	and.w	r3, r3, #7
     b6e:	2b01      	cmp	r3, #1
     b70:	bf14      	ite	ne
     b72:	2300      	movne	r3, #0
     b74:	2301      	moveq	r3, #1
     b76:	b2db      	uxtb	r3, r3
     b78:	2b00      	cmp	r3, #0
     b7a:	d044      	beq.n	c06 <_ZNSo14_M_put_nowidenEPKc+0x15e>
        __failed = this->rdbuf()->sputn(__s, __n) != __n;
     b7c:	9b01      	ldr	r3, [sp, #4]
     b7e:	681b      	ldr	r3, [r3, #0]
     b80:	f1a3 030c 	sub.w	r3, r3, #12
     b84:	681b      	ldr	r3, [r3, #0]
     b86:	9a01      	ldr	r2, [sp, #4]
     b88:	18d3      	adds	r3, r2, r3
     b8a:	4618      	mov	r0, r3
     b8c:	f000 f9fa 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     b90:	4603      	mov	r3, r0
     b92:	4618      	mov	r0, r3
     b94:	9900      	ldr	r1, [sp, #0]
     b96:	9a04      	ldr	r2, [sp, #16]
     b98:	f000 f9fc 	bl	f94 <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputnEPKci>
     b9c:	4603      	mov	r3, r0
     b9e:	461a      	mov	r2, r3
     ba0:	9b04      	ldr	r3, [sp, #16]
     ba2:	429a      	cmp	r2, r3
     ba4:	bf0c      	ite	eq
     ba6:	2300      	moveq	r3, #0
     ba8:	2301      	movne	r3, #1
     baa:	f88d 300f 	strb.w	r3, [sp, #15]
        __failed = __failed ||
     bae:	f89d 300f 	ldrb.w	r3, [sp, #15]
     bb2:	2b00      	cmp	r3, #0
     bb4:	d11f      	bne.n	bf6 <_ZNSo14_M_put_nowidenEPKc+0x14e>
     bb6:	9b01      	ldr	r3, [sp, #4]
     bb8:	681b      	ldr	r3, [r3, #0]
     bba:	f1a3 030c 	sub.w	r3, r3, #12
     bbe:	681b      	ldr	r3, [r3, #0]
     bc0:	9a01      	ldr	r2, [sp, #4]
     bc2:	18d3      	adds	r3, r2, r3
     bc4:	4618      	mov	r0, r3
     bc6:	f000 f9dd 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     bca:	4604      	mov	r4, r0
     bcc:	9b01      	ldr	r3, [sp, #4]
     bce:	681b      	ldr	r3, [r3, #0]
     bd0:	f1a3 030c 	sub.w	r3, r3, #12
     bd4:	681b      	ldr	r3, [r3, #0]
     bd6:	9a01      	ldr	r2, [sp, #4]
     bd8:	18d3      	adds	r3, r2, r3
     bda:	4618      	mov	r0, r3
     bdc:	f000 f9ec 	bl	fb8 <_ZNKSt9basic_iosIcSt11char_traitsIcEE4fillEv>
     be0:	4603      	mov	r3, r0
     be2:	4620      	mov	r0, r4
     be4:	4619      	mov	r1, r3
     be6:	9a05      	ldr	r2, [sp, #20]
     be8:	f000 f9ee 	bl	fc8 <_ZNSt15basic_streambufIcSt11char_traitsIcEE9_M_sputncEci>
     bec:	4603      	mov	r3, r0
     bee:	461a      	mov	r2, r3
     bf0:	9b05      	ldr	r3, [sp, #20]
     bf2:	429a      	cmp	r2, r3
     bf4:	d002      	beq.n	bfc <_ZNSo14_M_put_nowidenEPKc+0x154>
     bf6:	f04f 0301 	mov.w	r3, #1
     bfa:	e001      	b.n	c00 <_ZNSo14_M_put_nowidenEPKc+0x158>
     bfc:	f04f 0300 	mov.w	r3, #0
     c00:	f88d 300f 	strb.w	r3, [sp, #15]
     c04:	e043      	b.n	c8e <_ZNSo14_M_put_nowidenEPKc+0x1e6>
                   this->rdbuf()->_M_sputnc(this->fill(), __npad) != __npad;
      }
      else {
        __failed = this->rdbuf()->_M_sputnc(this->fill(), __npad) != __npad;
     c06:	9b01      	ldr	r3, [sp, #4]
     c08:	681b      	ldr	r3, [r3, #0]
     c0a:	f1a3 030c 	sub.w	r3, r3, #12
     c0e:	681b      	ldr	r3, [r3, #0]
     c10:	9a01      	ldr	r2, [sp, #4]
     c12:	18d3      	adds	r3, r2, r3
     c14:	4618      	mov	r0, r3
     c16:	f000 f9b5 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     c1a:	4604      	mov	r4, r0
     c1c:	9b01      	ldr	r3, [sp, #4]
     c1e:	681b      	ldr	r3, [r3, #0]
     c20:	f1a3 030c 	sub.w	r3, r3, #12
     c24:	681b      	ldr	r3, [r3, #0]
     c26:	9a01      	ldr	r2, [sp, #4]
     c28:	18d3      	adds	r3, r2, r3
     c2a:	4618      	mov	r0, r3
     c2c:	f000 f9c4 	bl	fb8 <_ZNKSt9basic_iosIcSt11char_traitsIcEE4fillEv>
     c30:	4603      	mov	r3, r0
     c32:	4620      	mov	r0, r4
     c34:	4619      	mov	r1, r3
     c36:	9a05      	ldr	r2, [sp, #20]
     c38:	f000 f9c6 	bl	fc8 <_ZNSt15basic_streambufIcSt11char_traitsIcEE9_M_sputncEci>
     c3c:	4603      	mov	r3, r0
     c3e:	461a      	mov	r2, r3
     c40:	9b05      	ldr	r3, [sp, #20]
     c42:	429a      	cmp	r2, r3
     c44:	bf0c      	ite	eq
     c46:	2300      	moveq	r3, #0
     c48:	2301      	movne	r3, #1
     c4a:	f88d 300f 	strb.w	r3, [sp, #15]
        __failed = __failed || this->rdbuf()->sputn(__s, __n) != __n;
     c4e:	f89d 300f 	ldrb.w	r3, [sp, #15]
     c52:	2b00      	cmp	r3, #0
     c54:	d114      	bne.n	c80 <_ZNSo14_M_put_nowidenEPKc+0x1d8>
     c56:	9b01      	ldr	r3, [sp, #4]
     c58:	681b      	ldr	r3, [r3, #0]
     c5a:	f1a3 030c 	sub.w	r3, r3, #12
     c5e:	681b      	ldr	r3, [r3, #0]
     c60:	9a01      	ldr	r2, [sp, #4]
     c62:	18d3      	adds	r3, r2, r3
     c64:	4618      	mov	r0, r3
     c66:	f000 f98d 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     c6a:	4603      	mov	r3, r0
     c6c:	4618      	mov	r0, r3
     c6e:	9900      	ldr	r1, [sp, #0]
     c70:	9a04      	ldr	r2, [sp, #16]
     c72:	f000 f98f 	bl	f94 <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputnEPKci>
     c76:	4603      	mov	r3, r0
     c78:	461a      	mov	r2, r3
     c7a:	9b04      	ldr	r3, [sp, #16]
     c7c:	429a      	cmp	r2, r3
     c7e:	d002      	beq.n	c86 <_ZNSo14_M_put_nowidenEPKc+0x1de>
     c80:	f04f 0301 	mov.w	r3, #1
     c84:	e001      	b.n	c8a <_ZNSo14_M_put_nowidenEPKc+0x1e2>
     c86:	f04f 0300 	mov.w	r3, #0
     c8a:	f88d 300f 	strb.w	r3, [sp, #15]
      }

      this->width(0);
     c8e:	9b01      	ldr	r3, [sp, #4]
     c90:	681b      	ldr	r3, [r3, #0]
     c92:	f1a3 030c 	sub.w	r3, r3, #12
     c96:	681b      	ldr	r3, [r3, #0]
     c98:	9a01      	ldr	r2, [sp, #4]
     c9a:	18d3      	adds	r3, r2, r3
     c9c:	4618      	mov	r0, r3
     c9e:	f04f 0100 	mov.w	r1, #0
     ca2:	f7ff fde7 	bl	874 <_ZNSt8ios_base5widthEi>
    }
    _STLP_CATCH_ALL {
      this->_M_handle_exception(ios_base::badbit);
    }

    if (__failed)
     ca6:	f89d 300f 	ldrb.w	r3, [sp, #15]
     caa:	2b00      	cmp	r3, #0
     cac:	d00b      	beq.n	cc6 <_ZNSo14_M_put_nowidenEPKc+0x21e>
      this->setstate(ios_base::failbit);
     cae:	9b01      	ldr	r3, [sp, #4]
     cb0:	681b      	ldr	r3, [r3, #0]
     cb2:	f1a3 030c 	sub.w	r3, r3, #12
     cb6:	681b      	ldr	r3, [r3, #0]
     cb8:	9a01      	ldr	r2, [sp, #4]
     cba:	18d3      	adds	r3, r2, r3
     cbc:	4618      	mov	r0, r3
     cbe:	f04f 0104 	mov.w	r1, #4
     cc2:	f000 f997 	bl	ff4 <_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateEi>
  }
}

template <class _CharT, class _Traits>
void basic_ostream<_CharT, _Traits>::_M_put_nowiden(const _CharT* __s) {
  sentry __sentry(*this);
     cc6:	ab06      	add	r3, sp, #24
    _STLP_CATCH_ALL {
      this->_M_handle_exception(ios_base::badbit);
    }

    if (__failed)
      this->setstate(ios_base::failbit);
     cc8:	4618      	mov	r0, r3
     cca:	f000 f929 	bl	f20 <_ZNSo6sentryD1Ev>
  }
}
     cce:	b008      	add	sp, #32
     cd0:	bd10      	pop	{r4, pc}
  }
}

template <class _CharT, class _Traits>
void basic_ostream<_CharT, _Traits>::_M_put_nowiden(const _CharT* __s) {
  sentry __sentry(*this);
     cd2:	ab06      	add	r3, sp, #24
    _STLP_CATCH_ALL {
      this->_M_handle_exception(ios_base::badbit);
    }

    if (__failed)
      this->setstate(ios_base::failbit);
     cd4:	4618      	mov	r0, r3
     cd6:	f000 f923 	bl	f20 <_ZNSo6sentryD1Ev>
     cda:	f7ff ed54 	blx	784 <_start-0x6c>
     cde:	bf00      	nop

00000ce0 <_ZNSt4priv9__put_numIcSt11char_traitsIcElEERSt13basic_ostreamIT_T0_ES7_T1_>:
_STLP_MOVE_TO_PRIV_NAMESPACE

// Helper function for numeric output.
template <class _CharT, class _Traits, class _Number>
basic_ostream<_CharT, _Traits>&  _STLP_CALL
__put_num(basic_ostream<_CharT, _Traits>& __os, _Number __x) {
     ce0:	b530      	push	{r4, r5, lr}
     ce2:	b08f      	sub	sp, #60	; 0x3c
     ce4:	9005      	str	r0, [sp, #20]
     ce6:	9104      	str	r1, [sp, #16]
  typedef typename basic_ostream<_CharT, _Traits>::sentry _Sentry;
  _Sentry __sentry(__os);
     ce8:	ab08      	add	r3, sp, #32
     cea:	4618      	mov	r0, r3
     cec:	9905      	ldr	r1, [sp, #20]
     cee:	f000 f905 	bl	efc <_ZNSo6sentryC1ERSo>
  bool __failed = true;
     cf2:	f04f 0301 	mov.w	r3, #1
     cf6:	f88d 301b 	strb.w	r3, [sp, #27]

  if (__sentry) {
     cfa:	ab08      	add	r3, sp, #32
     cfc:	4618      	mov	r0, r3
     cfe:	f000 f939 	bl	f74 <_ZNKSo6sentrycvbEv>
     d02:	4603      	mov	r3, r0
     d04:	2b00      	cmp	r3, #0
     d06:	d04a      	beq.n	d9e <_ZNSt4priv9__put_numIcSt11char_traitsIcElEERSt13basic_ostreamIT_T0_ES7_T1_+0xbe>
    _STLP_TRY {
      typedef num_put<_CharT, ostreambuf_iterator<_CharT, _Traits> > _NumPut;
      __failed = (use_facet<_NumPut>(__os.getloc())).put(ostreambuf_iterator<_CharT, _Traits>(__os.rdbuf()),
     d08:	9b05      	ldr	r3, [sp, #20]
     d0a:	681b      	ldr	r3, [r3, #0]
     d0c:	f1a3 030c 	sub.w	r3, r3, #12
     d10:	681b      	ldr	r3, [r3, #0]
     d12:	9a05      	ldr	r2, [sp, #20]
     d14:	18d3      	adds	r3, r2, r3
     d16:	aa07      	add	r2, sp, #28
     d18:	4610      	mov	r0, r2
     d1a:	4619      	mov	r1, r3
     d1c:	f7ff fdb8 	bl	890 <_ZNKSt8ios_base6getlocEv>
     d20:	ab07      	add	r3, sp, #28
     d22:	4618      	mov	r0, r3
     d24:	f000 f978 	bl	1018 <_ZSt9use_facetISt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEEERKT_RKSt6locale>
     d28:	4603      	mov	r3, r0
     d2a:	461c      	mov	r4, r3
     d2c:	9b05      	ldr	r3, [sp, #20]
     d2e:	681b      	ldr	r3, [r3, #0]
     d30:	f1a3 030c 	sub.w	r3, r3, #12
     d34:	681b      	ldr	r3, [r3, #0]
     d36:	9a05      	ldr	r2, [sp, #20]
     d38:	18d3      	adds	r3, r2, r3
     d3a:	4618      	mov	r0, r3
     d3c:	f000 f922 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     d40:	4603      	mov	r3, r0
     d42:	aa0a      	add	r2, sp, #40	; 0x28
     d44:	4610      	mov	r0, r2
     d46:	4619      	mov	r1, r3
     d48:	f000 f97a 	bl	1040 <_ZNSt19ostreambuf_iteratorIcSt11char_traitsIcEEC1EPSt15basic_streambufIcS1_E>
     d4c:	9b05      	ldr	r3, [sp, #20]
     d4e:	681b      	ldr	r3, [r3, #0]
     d50:	f1a3 030c 	sub.w	r3, r3, #12
     d54:	681b      	ldr	r3, [r3, #0]
     d56:	9a05      	ldr	r2, [sp, #20]
     d58:	18d5      	adds	r5, r2, r3
     d5a:	9b05      	ldr	r3, [sp, #20]
     d5c:	681b      	ldr	r3, [r3, #0]
     d5e:	f1a3 030c 	sub.w	r3, r3, #12
     d62:	681b      	ldr	r3, [r3, #0]
     d64:	9a05      	ldr	r2, [sp, #20]
     d66:	18d3      	adds	r3, r2, r3
     d68:	4618      	mov	r0, r3
     d6a:	f000 f925 	bl	fb8 <_ZNKSt9basic_iosIcSt11char_traitsIcEE4fillEv>
     d6e:	4603      	mov	r3, r0
     d70:	461a      	mov	r2, r3
     d72:	ab0c      	add	r3, sp, #48	; 0x30
     d74:	9500      	str	r5, [sp, #0]
     d76:	9201      	str	r2, [sp, #4]
     d78:	9a04      	ldr	r2, [sp, #16]
     d7a:	9202      	str	r2, [sp, #8]
     d7c:	4618      	mov	r0, r3
     d7e:	4621      	mov	r1, r4
     d80:	ab0a      	add	r3, sp, #40	; 0x28
     d82:	cb0c      	ldmia	r3, {r2, r3}
     d84:	f000 f972 	bl	106c <_ZNKSt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEE3putES3_RSt8ios_basecl>
     d88:	ab0c      	add	r3, sp, #48	; 0x30
     d8a:	4618      	mov	r0, r3
     d8c:	f000 f98a 	bl	10a4 <_ZNKSt19ostreambuf_iteratorIcSt11char_traitsIcEE6failedEv>
     d90:	4603      	mov	r3, r0
     d92:	f88d 301b 	strb.w	r3, [sp, #27]
     d96:	ab07      	add	r3, sp, #28
     d98:	4618      	mov	r0, r3
     d9a:	f7ff ed0c 	blx	7b4 <_start-0x3c>
    }
    _STLP_CATCH_ALL {
      __os._M_handle_exception(ios_base::badbit);
    }
  }
  if (__failed)
     d9e:	f89d 301b 	ldrb.w	r3, [sp, #27]
     da2:	2b00      	cmp	r3, #0
     da4:	d00b      	beq.n	dbe <_ZNSt4priv9__put_numIcSt11char_traitsIcElEERSt13basic_ostreamIT_T0_ES7_T1_+0xde>
    __os.setstate(ios_base::badbit);
     da6:	9b05      	ldr	r3, [sp, #20]
     da8:	681b      	ldr	r3, [r3, #0]
     daa:	f1a3 030c 	sub.w	r3, r3, #12
     dae:	681b      	ldr	r3, [r3, #0]
     db0:	9a05      	ldr	r2, [sp, #20]
     db2:	18d3      	adds	r3, r2, r3
     db4:	4618      	mov	r0, r3
     db6:	f04f 0101 	mov.w	r1, #1
     dba:	f000 f91b 	bl	ff4 <_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateEi>
  return __os;
     dbe:	9c05      	ldr	r4, [sp, #20]
// Helper function for numeric output.
template <class _CharT, class _Traits, class _Number>
basic_ostream<_CharT, _Traits>&  _STLP_CALL
__put_num(basic_ostream<_CharT, _Traits>& __os, _Number __x) {
  typedef typename basic_ostream<_CharT, _Traits>::sentry _Sentry;
  _Sentry __sentry(__os);
     dc0:	ab08      	add	r3, sp, #32
      __os._M_handle_exception(ios_base::badbit);
    }
  }
  if (__failed)
    __os.setstate(ios_base::badbit);
  return __os;
     dc2:	4618      	mov	r0, r3
     dc4:	f000 f8ac 	bl	f20 <_ZNSo6sentryD1Ev>
     dc8:	4623      	mov	r3, r4
}
     dca:	4618      	mov	r0, r3
     dcc:	b00f      	add	sp, #60	; 0x3c
     dce:	bd30      	pop	{r4, r5, pc}
  bool __failed = true;

  if (__sentry) {
    _STLP_TRY {
      typedef num_put<_CharT, ostreambuf_iterator<_CharT, _Traits> > _NumPut;
      __failed = (use_facet<_NumPut>(__os.getloc())).put(ostreambuf_iterator<_CharT, _Traits>(__os.rdbuf()),
     dd0:	ab07      	add	r3, sp, #28
     dd2:	4618      	mov	r0, r3
     dd4:	f7ff ecee 	blx	7b4 <_start-0x3c>
     dd8:	e7ff      	b.n	dda <_ZNSt4priv9__put_numIcSt11char_traitsIcElEERSt13basic_ostreamIT_T0_ES7_T1_+0xfa>
// Helper function for numeric output.
template <class _CharT, class _Traits, class _Number>
basic_ostream<_CharT, _Traits>&  _STLP_CALL
__put_num(basic_ostream<_CharT, _Traits>& __os, _Number __x) {
  typedef typename basic_ostream<_CharT, _Traits>::sentry _Sentry;
  _Sentry __sentry(__os);
     dda:	ab08      	add	r3, sp, #32
      __os._M_handle_exception(ios_base::badbit);
    }
  }
  if (__failed)
    __os.setstate(ios_base::badbit);
  return __os;
     ddc:	4618      	mov	r0, r3
     dde:	f000 f89f 	bl	f20 <_ZNSo6sentryD1Ev>
     de2:	f7ff ecd0 	blx	784 <_start-0x6c>
     de6:	bf00      	nop

00000de8 <_ZNSo3putEc>:
}

// Unformatted output of a single character.
template <class _CharT, class _Traits>
basic_ostream<_CharT, _Traits>&
basic_ostream<_CharT, _Traits>::put(char_type __c) {
     de8:	b510      	push	{r4, lr}
     dea:	b086      	sub	sp, #24
     dec:	9001      	str	r0, [sp, #4]
     dee:	460b      	mov	r3, r1
     df0:	f88d 3003 	strb.w	r3, [sp, #3]
  sentry __sentry(*this);
     df4:	ab04      	add	r3, sp, #16
     df6:	4618      	mov	r0, r3
     df8:	9901      	ldr	r1, [sp, #4]
     dfa:	f000 f87f 	bl	efc <_ZNSo6sentryC1ERSo>
  bool __failed = true;
     dfe:	f04f 0301 	mov.w	r3, #1
     e02:	f88d 300f 	strb.w	r3, [sp, #15]

  if (__sentry) {
     e06:	ab04      	add	r3, sp, #16
     e08:	4618      	mov	r0, r3
     e0a:	f000 f8b3 	bl	f74 <_ZNKSo6sentrycvbEv>
     e0e:	4603      	mov	r3, r0
     e10:	2b00      	cmp	r3, #0
     e12:	d017      	beq.n	e44 <_ZNSo3putEc+0x5c>
    _STLP_TRY {
      __failed = this->_S_eof(this->rdbuf()->sputc(__c));
     e14:	9b01      	ldr	r3, [sp, #4]
     e16:	681b      	ldr	r3, [r3, #0]
     e18:	f1a3 030c 	sub.w	r3, r3, #12
     e1c:	681b      	ldr	r3, [r3, #0]
     e1e:	9a01      	ldr	r2, [sp, #4]
     e20:	18d3      	adds	r3, r2, r3
     e22:	4618      	mov	r0, r3
     e24:	f000 f8ae 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     e28:	4602      	mov	r2, r0
     e2a:	f89d 3003 	ldrb.w	r3, [sp, #3]
     e2e:	4610      	mov	r0, r2
     e30:	4619      	mov	r1, r3
     e32:	f000 f941 	bl	10b8 <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputcEc>
     e36:	4603      	mov	r3, r0
     e38:	4618      	mov	r0, r3
     e3a:	f000 f96b 	bl	1114 <_ZNSt9basic_iosIcSt11char_traitsIcEE6_S_eofEi>
     e3e:	4603      	mov	r3, r0
     e40:	f88d 300f 	strb.w	r3, [sp, #15]
    _STLP_CATCH_ALL {
      this->_M_handle_exception(ios_base::badbit);
    }
  }

  if (__failed)
     e44:	f89d 300f 	ldrb.w	r3, [sp, #15]
     e48:	2b00      	cmp	r3, #0
     e4a:	d00b      	beq.n	e64 <_ZNSo3putEc+0x7c>
    this->setstate(ios_base::badbit);
     e4c:	9b01      	ldr	r3, [sp, #4]
     e4e:	681b      	ldr	r3, [r3, #0]
     e50:	f1a3 030c 	sub.w	r3, r3, #12
     e54:	681b      	ldr	r3, [r3, #0]
     e56:	9a01      	ldr	r2, [sp, #4]
     e58:	18d3      	adds	r3, r2, r3
     e5a:	4618      	mov	r0, r3
     e5c:	f04f 0101 	mov.w	r1, #1
     e60:	f000 f8c8 	bl	ff4 <_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateEi>

  return *this;
     e64:	9c01      	ldr	r4, [sp, #4]

// Unformatted output of a single character.
template <class _CharT, class _Traits>
basic_ostream<_CharT, _Traits>&
basic_ostream<_CharT, _Traits>::put(char_type __c) {
  sentry __sentry(*this);
     e66:	ab04      	add	r3, sp, #16
  }

  if (__failed)
    this->setstate(ios_base::badbit);

  return *this;
     e68:	4618      	mov	r0, r3
     e6a:	f000 f859 	bl	f20 <_ZNSo6sentryD1Ev>
     e6e:	4623      	mov	r3, r4
}
     e70:	4618      	mov	r0, r3
     e72:	b006      	add	sp, #24
     e74:	bd10      	pop	{r4, pc}

// Unformatted output of a single character.
template <class _CharT, class _Traits>
basic_ostream<_CharT, _Traits>&
basic_ostream<_CharT, _Traits>::put(char_type __c) {
  sentry __sentry(*this);
     e76:	ab04      	add	r3, sp, #16
  }

  if (__failed)
    this->setstate(ios_base::badbit);

  return *this;
     e78:	4618      	mov	r0, r3
     e7a:	f000 f851 	bl	f20 <_ZNSo6sentryD1Ev>
     e7e:	f7ff ec82 	blx	784 <_start-0x6c>
     e82:	bf00      	nop

00000e84 <_ZNSo5flushEv>:
# ifndef _STLP_NO_BOOL
  _Self& operator<<(bool __x);
# endif

public:                         // Buffer positioning and manipulation.
  _Self& flush() {
     e84:	b500      	push	{lr}
     e86:	b083      	sub	sp, #12
     e88:	9001      	str	r0, [sp, #4]
    if (this->rdbuf())
     e8a:	9b01      	ldr	r3, [sp, #4]
     e8c:	681b      	ldr	r3, [r3, #0]
     e8e:	f1a3 030c 	sub.w	r3, r3, #12
     e92:	681b      	ldr	r3, [r3, #0]
     e94:	9a01      	ldr	r2, [sp, #4]
     e96:	18d3      	adds	r3, r2, r3
     e98:	4618      	mov	r0, r3
     e9a:	f000 f873 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     e9e:	4603      	mov	r3, r0
     ea0:	2b00      	cmp	r3, #0
     ea2:	bf0c      	ite	eq
     ea4:	2300      	moveq	r3, #0
     ea6:	2301      	movne	r3, #1
     ea8:	b2db      	uxtb	r3, r3
     eaa:	2b00      	cmp	r3, #0
     eac:	d022      	beq.n	ef4 <_ZNSo5flushEv+0x70>
      if (this->rdbuf()->pubsync() == -1)
     eae:	9b01      	ldr	r3, [sp, #4]
     eb0:	681b      	ldr	r3, [r3, #0]
     eb2:	f1a3 030c 	sub.w	r3, r3, #12
     eb6:	681b      	ldr	r3, [r3, #0]
     eb8:	9a01      	ldr	r2, [sp, #4]
     eba:	18d3      	adds	r3, r2, r3
     ebc:	4618      	mov	r0, r3
     ebe:	f000 f861 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
     ec2:	4603      	mov	r3, r0
     ec4:	4618      	mov	r0, r3
     ec6:	f000 f937 	bl	1138 <_ZNSt15basic_streambufIcSt11char_traitsIcEE7pubsyncEv>
     eca:	4603      	mov	r3, r0
     ecc:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
     ed0:	bf14      	ite	ne
     ed2:	2300      	movne	r3, #0
     ed4:	2301      	moveq	r3, #1
     ed6:	b2db      	uxtb	r3, r3
     ed8:	2b00      	cmp	r3, #0
     eda:	d00b      	beq.n	ef4 <_ZNSo5flushEv+0x70>
        this->setstate(ios_base::badbit);
     edc:	9b01      	ldr	r3, [sp, #4]
     ede:	681b      	ldr	r3, [r3, #0]
     ee0:	f1a3 030c 	sub.w	r3, r3, #12
     ee4:	681b      	ldr	r3, [r3, #0]
     ee6:	9a01      	ldr	r2, [sp, #4]
     ee8:	18d3      	adds	r3, r2, r3
     eea:	4618      	mov	r0, r3
     eec:	f04f 0101 	mov.w	r1, #1
     ef0:	f000 f880 	bl	ff4 <_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateEi>
    return *this;
     ef4:	9b01      	ldr	r3, [sp, #4]
  }
     ef6:	4618      	mov	r0, r3
     ef8:	b003      	add	sp, #12
     efa:	bd00      	pop	{pc}

00000efc <_ZNSo6sentryC1ERSo>:
    private:
      basic_ostream<_CharT, _Traits>& _M_str;
      //      basic_streambuf<_CharT, _Traits>* _M_buf;
      bool _M_ok;
    public:
      explicit sentry(basic_ostream<_CharT, _Traits>& __str)
     efc:	b500      	push	{lr}
     efe:	b083      	sub	sp, #12
     f00:	9001      	str	r0, [sp, #4]
     f02:	9100      	str	r1, [sp, #0]
        : _M_str(__str), /* _M_buf(__str.rdbuf()), */ _M_ok(_STLP_PRIV __init_bostr(__str))
     f04:	9b01      	ldr	r3, [sp, #4]
     f06:	9a00      	ldr	r2, [sp, #0]
     f08:	601a      	str	r2, [r3, #0]
     f0a:	9800      	ldr	r0, [sp, #0]
     f0c:	f000 f922 	bl	1154 <_ZNSt4priv12__init_bostrIcSt11char_traitsIcEEEbRSt13basic_ostreamIT_T0_E>
     f10:	4603      	mov	r3, r0
     f12:	461a      	mov	r2, r3
     f14:	9b01      	ldr	r3, [sp, #4]
     f16:	711a      	strb	r2, [r3, #4]
     f18:	9b01      	ldr	r3, [sp, #4]
      {}
     f1a:	4618      	mov	r0, r3
     f1c:	b003      	add	sp, #12
     f1e:	bd00      	pop	{pc}

00000f20 <_ZNSo6sentryD1Ev>:

      ~sentry() {
     f20:	b500      	push	{lr}
     f22:	b083      	sub	sp, #12
     f24:	9001      	str	r0, [sp, #4]
        if (_M_str.flags() & ios_base::unitbuf)
     f26:	9b01      	ldr	r3, [sp, #4]
     f28:	681a      	ldr	r2, [r3, #0]
     f2a:	9b01      	ldr	r3, [sp, #4]
     f2c:	681b      	ldr	r3, [r3, #0]
     f2e:	681b      	ldr	r3, [r3, #0]
     f30:	f1a3 030c 	sub.w	r3, r3, #12
     f34:	681b      	ldr	r3, [r3, #0]
     f36:	18d3      	adds	r3, r2, r3
     f38:	4618      	mov	r0, r3
     f3a:	f7ff fc8b 	bl	854 <_ZNKSt8ios_base5flagsEv>
     f3e:	4603      	mov	r3, r0
     f40:	f403 5300 	and.w	r3, r3, #8192	; 0x2000
     f44:	2b00      	cmp	r3, #0
     f46:	bf0c      	ite	eq
     f48:	2300      	moveq	r3, #0
     f4a:	2301      	movne	r3, #1
     f4c:	b2db      	uxtb	r3, r3
     f4e:	2b00      	cmp	r3, #0
     f50:	d00c      	beq.n	f6c <_ZNSo6sentryD1Ev+0x4c>
#if !defined (_STLP_NO_UNCAUGHT_EXCEPT_SUPPORT)
          if (!uncaught_exception())
     f52:	f7ff ec36 	blx	7c0 <_start-0x30>
     f56:	4603      	mov	r3, r0
     f58:	f083 0301 	eor.w	r3, r3, #1
     f5c:	b2db      	uxtb	r3, r3
     f5e:	2b00      	cmp	r3, #0
     f60:	d004      	beq.n	f6c <_ZNSo6sentryD1Ev+0x4c>
#endif
            _M_str.flush();
     f62:	9b01      	ldr	r3, [sp, #4]
     f64:	681b      	ldr	r3, [r3, #0]
     f66:	4618      	mov	r0, r3
     f68:	f7ff ff8c 	bl	e84 <_ZNSo5flushEv>
     f6c:	9b01      	ldr	r3, [sp, #4]
      }
     f6e:	4618      	mov	r0, r3
     f70:	b003      	add	sp, #12
     f72:	bd00      	pop	{pc}

00000f74 <_ZNKSo6sentrycvbEv>:

      operator bool() const { return _M_ok; }
     f74:	b082      	sub	sp, #8
     f76:	9001      	str	r0, [sp, #4]
     f78:	9b01      	ldr	r3, [sp, #4]
     f7a:	791b      	ldrb	r3, [r3, #4]
     f7c:	4618      	mov	r0, r3
     f7e:	b002      	add	sp, #8
     f80:	4770      	bx	lr
     f82:	bf00      	nop

00000f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>:
    basic_ostream<char_type, traits_type>* __tmp = _M_tied_ostream;
    _M_tied_ostream = __new_tied_ostream;
    return __tmp;
  }

  basic_streambuf<_CharT, _Traits>* rdbuf() const
     f84:	b082      	sub	sp, #8
     f86:	9001      	str	r0, [sp, #4]
    { return _M_streambuf; }
     f88:	9b01      	ldr	r3, [sp, #4]
     f8a:	6c9b      	ldr	r3, [r3, #72]	; 0x48
     f8c:	4618      	mov	r0, r3
     f8e:	b002      	add	sp, #8
     f90:	4770      	bx	lr
     f92:	bf00      	nop

00000f94 <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputnEPKci>:
    return ((_M_pnext < _M_pend) ? _Traits::to_int_type(*_M_pnext++ = __c)
      : this->overflow(_Traits::to_int_type(__c)));
  }

  // Write __n characters.
  streamsize sputn(const char_type* __s, streamsize __n)
     f94:	b500      	push	{lr}
     f96:	b085      	sub	sp, #20
     f98:	9003      	str	r0, [sp, #12]
     f9a:	9102      	str	r1, [sp, #8]
     f9c:	9201      	str	r2, [sp, #4]
  { return this->xsputn(__s, __n); }
     f9e:	9b03      	ldr	r3, [sp, #12]
     fa0:	681b      	ldr	r3, [r3, #0]
     fa2:	f103 032c 	add.w	r3, r3, #44	; 0x2c
     fa6:	681b      	ldr	r3, [r3, #0]
     fa8:	9803      	ldr	r0, [sp, #12]
     faa:	9902      	ldr	r1, [sp, #8]
     fac:	9a01      	ldr	r2, [sp, #4]
     fae:	4798      	blx	r3
     fb0:	4603      	mov	r3, r0
     fb2:	4618      	mov	r0, r3
     fb4:	b005      	add	sp, #20
     fb6:	bd00      	pop	{pc}

00000fb8 <_ZNKSt9basic_iosIcSt11char_traitsIcEE4fillEv>:
  rdbuf(basic_streambuf<char_type, traits_type>*);

  // Copies __x's state to *this.
  basic_ios<_CharT, _Traits>& copyfmt(const basic_ios<_CharT, _Traits>& __x);

  char_type fill() const { return _M_fill; }
     fb8:	b082      	sub	sp, #8
     fba:	9001      	str	r0, [sp, #4]
     fbc:	9b01      	ldr	r3, [sp, #4]
     fbe:	f893 3044 	ldrb.w	r3, [r3, #68]	; 0x44
     fc2:	4618      	mov	r0, r3
     fc4:	b002      	add	sp, #8
     fc6:	4770      	bx	lr

00000fc8 <_ZNSt15basic_streambufIcSt11char_traitsIcEE9_M_sputncEci>:

  // Extension: write __n copies of __c.
  streamsize _M_sputnc(char_type __c, streamsize __n)
     fc8:	b500      	push	{lr}
     fca:	b085      	sub	sp, #20
     fcc:	9003      	str	r0, [sp, #12]
     fce:	460b      	mov	r3, r1
     fd0:	9201      	str	r2, [sp, #4]
     fd2:	f88d 300b 	strb.w	r3, [sp, #11]
  { return this->_M_xsputnc(__c, __n); }
     fd6:	9b03      	ldr	r3, [sp, #12]
     fd8:	681b      	ldr	r3, [r3, #0]
     fda:	f103 0330 	add.w	r3, r3, #48	; 0x30
     fde:	681b      	ldr	r3, [r3, #0]
     fe0:	f89d 200b 	ldrb.w	r2, [sp, #11]
     fe4:	9803      	ldr	r0, [sp, #12]
     fe6:	4611      	mov	r1, r2
     fe8:	9a01      	ldr	r2, [sp, #4]
     fea:	4798      	blx	r3
     fec:	4603      	mov	r3, r0
     fee:	4618      	mov	r0, r3
     ff0:	b005      	add	sp, #20
     ff2:	bd00      	pop	{pc}

00000ff4 <_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateEi>:

  void clear(iostate __state = goodbit) {
    _M_clear_nothrow(this->rdbuf() ? __state : iostate(__state|ios_base::badbit));
    _M_check_exception_mask();
  }
  void setstate(iostate __state) { this->clear(rdstate() | __state); }
     ff4:	b500      	push	{lr}
     ff6:	b083      	sub	sp, #12
     ff8:	9001      	str	r0, [sp, #4]
     ffa:	9100      	str	r1, [sp, #0]
     ffc:	9b01      	ldr	r3, [sp, #4]
     ffe:	4618      	mov	r0, r3
    1000:	f7ff fc54 	bl	8ac <_ZNKSt8ios_base7rdstateEv>
    1004:	4602      	mov	r2, r0
    1006:	9b00      	ldr	r3, [sp, #0]
    1008:	4313      	orrs	r3, r2
    100a:	9801      	ldr	r0, [sp, #4]
    100c:	4619      	mov	r1, r3
    100e:	f000 f901 	bl	1214 <_ZNSt9basic_iosIcSt11char_traitsIcEE5clearEi>
    1012:	b003      	add	sp, #12
    1014:	bd00      	pop	{pc}
    1016:	bf00      	nop

00001018 <_ZSt9use_facetISt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEEERKT_RKSt6locale>:
template <class _Facet>
inline const _Facet&
#ifdef _STLP_NO_EXPLICIT_FUNCTION_TMPL_ARGS
_Use_facet<_Facet>::operator *() const
#else
use_facet(const locale& __loc)
    1018:	b500      	push	{lr}
    101a:	b085      	sub	sp, #20
    101c:	9001      	str	r0, [sp, #4]
#endif
{
  _Facet *__facet = 0;
    101e:	f04f 0300 	mov.w	r3, #0
    1022:	9303      	str	r3, [sp, #12]
  return *(_STLP_PRIV _UseFacet(__loc, __facet));
    1024:	9801      	ldr	r0, [sp, #4]
    1026:	9903      	ldr	r1, [sp, #12]
    1028:	f000 f90e 	bl	1248 <_ZNSt4priv9_UseFacetISt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEEEEPT_RKSt6localePKS7_>
    102c:	4603      	mov	r3, r0
}
    102e:	4618      	mov	r0, r3
    1030:	b005      	add	sp, #20
    1032:	bd00      	pop	{pc}

00001034 <_ZNSt8iteratorISt19output_iterator_tagvvvvEC1Ev>:
  typedef _Distance  difference_type;
  typedef _Pointer   pointer;
  typedef _Reference reference;
};
_STLP_TEMPLATE_NULL
struct iterator<output_iterator_tag, void, void, void, void> {
    1034:	b082      	sub	sp, #8
    1036:	9001      	str	r0, [sp, #4]
    1038:	9b01      	ldr	r3, [sp, #4]
    103a:	4618      	mov	r0, r3
    103c:	b002      	add	sp, #8
    103e:	4770      	bx	lr

00001040 <_ZNSt19ostreambuf_iteratorIcSt11char_traitsIcEEC1EPSt15basic_streambufIcS1_E>:
  typedef void                             difference_type;
  typedef void                             pointer;
  typedef void                             reference;

public:
  ostreambuf_iterator(streambuf_type* __buf) _STLP_NOTHROW : _M_buf(__buf), _M_ok(__buf!=0) {}
    1040:	b500      	push	{lr}
    1042:	b083      	sub	sp, #12
    1044:	9001      	str	r0, [sp, #4]
    1046:	9100      	str	r1, [sp, #0]
    1048:	9801      	ldr	r0, [sp, #4]
    104a:	f7ff fff3 	bl	1034 <_ZNSt8iteratorISt19output_iterator_tagvvvvEC1Ev>
    104e:	9b01      	ldr	r3, [sp, #4]
    1050:	9a00      	ldr	r2, [sp, #0]
    1052:	601a      	str	r2, [r3, #0]
    1054:	9b00      	ldr	r3, [sp, #0]
    1056:	2b00      	cmp	r3, #0
    1058:	bf0c      	ite	eq
    105a:	2300      	moveq	r3, #0
    105c:	2301      	movne	r3, #1
    105e:	b2da      	uxtb	r2, r3
    1060:	9b01      	ldr	r3, [sp, #4]
    1062:	711a      	strb	r2, [r3, #4]
    1064:	9b01      	ldr	r3, [sp, #4]
    1066:	4618      	mov	r0, r3
    1068:	b003      	add	sp, #12
    106a:	bd00      	pop	{pc}

0000106c <_ZNKSt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEE3putES3_RSt8ios_basecl>:
  iter_type put(iter_type __s, ios_base& __f, char_type __fill,
                bool __val) const {
    return do_put(__s, __f, __fill, __val);
  }
#endif
  iter_type put(iter_type __s, ios_base& __f, char_type __fill,
    106c:	b510      	push	{r4, lr}
    106e:	b088      	sub	sp, #32
    1070:	9007      	str	r0, [sp, #28]
    1072:	9106      	str	r1, [sp, #24]
    1074:	a904      	add	r1, sp, #16
    1076:	e881 000c 	stmia.w	r1, {r2, r3}
               long __val) const {
    return do_put(__s, __f, __fill, __val);
    107a:	9b06      	ldr	r3, [sp, #24]
    107c:	681b      	ldr	r3, [r3, #0]
    107e:	f103 030c 	add.w	r3, r3, #12
    1082:	681c      	ldr	r4, [r3, #0]
    1084:	9b07      	ldr	r3, [sp, #28]
    1086:	9a0a      	ldr	r2, [sp, #40]	; 0x28
    1088:	9200      	str	r2, [sp, #0]
    108a:	f89d 202c 	ldrb.w	r2, [sp, #44]	; 0x2c
    108e:	9201      	str	r2, [sp, #4]
    1090:	9a0c      	ldr	r2, [sp, #48]	; 0x30
    1092:	9202      	str	r2, [sp, #8]
    1094:	4618      	mov	r0, r3
    1096:	9906      	ldr	r1, [sp, #24]
    1098:	ab04      	add	r3, sp, #16
    109a:	cb0c      	ldmia	r3, {r2, r3}
    109c:	47a0      	blx	r4
  }
    109e:	9807      	ldr	r0, [sp, #28]
    10a0:	b008      	add	sp, #32
    10a2:	bd10      	pop	{r4, pc}

000010a4 <_ZNKSt19ostreambuf_iteratorIcSt11char_traitsIcEE6failedEv>:

  ostreambuf_iterator<_CharT, _Traits>& operator*()     { return *this; }
  ostreambuf_iterator<_CharT, _Traits>& operator++()    { return *this; }
  ostreambuf_iterator<_CharT, _Traits>& operator++(int) { return *this; }

  bool failed() const { return !_M_ok; }
    10a4:	b082      	sub	sp, #8
    10a6:	9001      	str	r0, [sp, #4]
    10a8:	9b01      	ldr	r3, [sp, #4]
    10aa:	791b      	ldrb	r3, [r3, #4]
    10ac:	f083 0301 	eor.w	r3, r3, #1
    10b0:	b2db      	uxtb	r3, r3
    10b2:	4618      	mov	r0, r3
    10b4:	b002      	add	sp, #8
    10b6:	4770      	bx	lr

000010b8 <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputcEc>:
  // override this virtual member function.
  virtual int_type overflow(int_type = traits_type::eof());

public:                         // Public members for writing characters.
  // Write a single character.
  int_type sputc(char_type __c) {
    10b8:	b510      	push	{r4, lr}
    10ba:	b082      	sub	sp, #8
    10bc:	9001      	str	r0, [sp, #4]
    10be:	460b      	mov	r3, r1
    10c0:	f88d 3003 	strb.w	r3, [sp, #3]
    return ((_M_pnext < _M_pend) ? _Traits::to_int_type(*_M_pnext++ = __c)
      : this->overflow(_Traits::to_int_type(__c)));
    10c4:	9b01      	ldr	r3, [sp, #4]
    10c6:	695a      	ldr	r2, [r3, #20]
    10c8:	9b01      	ldr	r3, [sp, #4]
    10ca:	699b      	ldr	r3, [r3, #24]
    10cc:	429a      	cmp	r2, r3
    10ce:	d20e      	bcs.n	10ee <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputcEc+0x36>
    10d0:	9b01      	ldr	r3, [sp, #4]
    10d2:	695a      	ldr	r2, [r3, #20]
    10d4:	4613      	mov	r3, r2
    10d6:	f89d 1003 	ldrb.w	r1, [sp, #3]
    10da:	7019      	strb	r1, [r3, #0]
    10dc:	f102 0101 	add.w	r1, r2, #1
    10e0:	9a01      	ldr	r2, [sp, #4]
    10e2:	6151      	str	r1, [r2, #20]
    10e4:	4618      	mov	r0, r3
    10e6:	f7ff fba3 	bl	830 <_ZNSt11char_traitsIcE11to_int_typeERKc>
    10ea:	4603      	mov	r3, r0
    10ec:	e00e      	b.n	110c <_ZNSt15basic_streambufIcSt11char_traitsIcEE5sputcEc+0x54>
    10ee:	9b01      	ldr	r3, [sp, #4]
    10f0:	681b      	ldr	r3, [r3, #0]
    10f2:	f103 0334 	add.w	r3, r3, #52	; 0x34
    10f6:	681c      	ldr	r4, [r3, #0]
    10f8:	f10d 0303 	add.w	r3, sp, #3
    10fc:	4618      	mov	r0, r3
    10fe:	f7ff fb97 	bl	830 <_ZNSt11char_traitsIcE11to_int_typeERKc>
    1102:	4603      	mov	r3, r0
    1104:	9801      	ldr	r0, [sp, #4]
    1106:	4619      	mov	r1, r3
    1108:	47a0      	blx	r4
    110a:	4603      	mov	r3, r0
  }
    110c:	4618      	mov	r0, r3
    110e:	b002      	add	sp, #8
    1110:	bd10      	pop	{r4, pc}
    1112:	bf00      	nop

00001114 <_ZNSt9basic_iosIcSt11char_traitsIcEE6_S_eofEi>:

  inline char narrow(_CharT, char) const ;
  inline _CharT widen(char) const;

  // Helper function that makes testing for EOF more convenient.
  static bool _STLP_CALL _S_eof(int_type __c) {
    1114:	b500      	push	{lr}
    1116:	b085      	sub	sp, #20
    1118:	9001      	str	r0, [sp, #4]
    const int_type __eof = _Traits::eof();
    111a:	f000 f8a5 	bl	1268 <_ZNSt18__char_traits_baseIciE3eofEv>
    111e:	4603      	mov	r3, r0
    1120:	9303      	str	r3, [sp, #12]
    return _Traits::eq_int_type(__c, __eof);
    1122:	aa01      	add	r2, sp, #4
    1124:	ab03      	add	r3, sp, #12
    1126:	4610      	mov	r0, r2
    1128:	4619      	mov	r1, r3
    112a:	f000 f8a1 	bl	1270 <_ZNSt18__char_traits_baseIciE11eq_int_typeERKiS2_>
    112e:	4603      	mov	r3, r0
  }
    1130:	4618      	mov	r0, r3
    1132:	b005      	add	sp, #20
    1134:	bd00      	pop	{pc}
    1136:	bf00      	nop

00001138 <_ZNSt15basic_streambufIcSt11char_traitsIcEE7pubsyncEv>:

  pos_type pubseekpos(pos_type __sp,
                      ios_base::openmode __mod = ios_base::in | ios_base::out)
  { return this->seekpos(__sp, __mod); }

  int pubsync() { return this->sync(); }
    1138:	b500      	push	{lr}
    113a:	b083      	sub	sp, #12
    113c:	9001      	str	r0, [sp, #4]
    113e:	9b01      	ldr	r3, [sp, #4]
    1140:	681b      	ldr	r3, [r3, #0]
    1142:	f103 0314 	add.w	r3, r3, #20
    1146:	681b      	ldr	r3, [r3, #0]
    1148:	9801      	ldr	r0, [sp, #4]
    114a:	4798      	blx	r3
    114c:	4603      	mov	r3, r0
    114e:	4618      	mov	r0, r3
    1150:	b003      	add	sp, #12
    1152:	bd00      	pop	{pc}

00001154 <_ZNSt4priv12__init_bostrIcSt11char_traitsIcEEEbRSt13basic_ostreamIT_T0_E>:

_STLP_MOVE_TO_PRIV_NAMESPACE

// Helper functions for istream<>::sentry constructor.
template <class _CharT, class _Traits>
bool __init_bostr(basic_ostream<_CharT, _Traits>& __str) {
    1154:	b500      	push	{lr}
    1156:	b083      	sub	sp, #12
    1158:	9001      	str	r0, [sp, #4]
  if (__str.good()) {
    115a:	9b01      	ldr	r3, [sp, #4]
    115c:	681b      	ldr	r3, [r3, #0]
    115e:	f1a3 030c 	sub.w	r3, r3, #12
    1162:	681b      	ldr	r3, [r3, #0]
    1164:	9a01      	ldr	r2, [sp, #4]
    1166:	18d3      	adds	r3, r2, r3
    1168:	4618      	mov	r0, r3
    116a:	f7ff fba7 	bl	8bc <_ZNKSt8ios_base4goodEv>
    116e:	4603      	mov	r3, r0
    1170:	2b00      	cmp	r3, #0
    1172:	d049      	beq.n	1208 <_ZNSt4priv12__init_bostrIcSt11char_traitsIcEEEbRSt13basic_ostreamIT_T0_E+0xb4>
    // boris : check if this is needed !
    if (!__str.rdbuf())
    1174:	9b01      	ldr	r3, [sp, #4]
    1176:	681b      	ldr	r3, [r3, #0]
    1178:	f1a3 030c 	sub.w	r3, r3, #12
    117c:	681b      	ldr	r3, [r3, #0]
    117e:	9a01      	ldr	r2, [sp, #4]
    1180:	18d3      	adds	r3, r2, r3
    1182:	4618      	mov	r0, r3
    1184:	f7ff fefe 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
    1188:	4603      	mov	r3, r0
    118a:	2b00      	cmp	r3, #0
    118c:	bf14      	ite	ne
    118e:	2300      	movne	r3, #0
    1190:	2301      	moveq	r3, #1
    1192:	b2db      	uxtb	r3, r3
    1194:	2b00      	cmp	r3, #0
    1196:	d00b      	beq.n	11b0 <_ZNSt4priv12__init_bostrIcSt11char_traitsIcEEEbRSt13basic_ostreamIT_T0_E+0x5c>
      __str.setstate(ios_base::badbit);
    1198:	9b01      	ldr	r3, [sp, #4]
    119a:	681b      	ldr	r3, [r3, #0]
    119c:	f1a3 030c 	sub.w	r3, r3, #12
    11a0:	681b      	ldr	r3, [r3, #0]
    11a2:	9a01      	ldr	r2, [sp, #4]
    11a4:	18d3      	adds	r3, r2, r3
    11a6:	4618      	mov	r0, r3
    11a8:	f04f 0101 	mov.w	r1, #1
    11ac:	f7ff ff22 	bl	ff4 <_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateEi>
    if (__str.tie())
    11b0:	9b01      	ldr	r3, [sp, #4]
    11b2:	681b      	ldr	r3, [r3, #0]
    11b4:	f1a3 030c 	sub.w	r3, r3, #12
    11b8:	681b      	ldr	r3, [r3, #0]
    11ba:	9a01      	ldr	r2, [sp, #4]
    11bc:	18d3      	adds	r3, r2, r3
    11be:	4618      	mov	r0, r3
    11c0:	f000 f866 	bl	1290 <_ZNKSt9basic_iosIcSt11char_traitsIcEE3tieEv>
    11c4:	4603      	mov	r3, r0
    11c6:	2b00      	cmp	r3, #0
    11c8:	bf0c      	ite	eq
    11ca:	2300      	moveq	r3, #0
    11cc:	2301      	movne	r3, #1
    11ce:	b2db      	uxtb	r3, r3
    11d0:	2b00      	cmp	r3, #0
    11d2:	d00d      	beq.n	11f0 <_ZNSt4priv12__init_bostrIcSt11char_traitsIcEEEbRSt13basic_ostreamIT_T0_E+0x9c>
      __str.tie()->flush();
    11d4:	9b01      	ldr	r3, [sp, #4]
    11d6:	681b      	ldr	r3, [r3, #0]
    11d8:	f1a3 030c 	sub.w	r3, r3, #12
    11dc:	681b      	ldr	r3, [r3, #0]
    11de:	9a01      	ldr	r2, [sp, #4]
    11e0:	18d3      	adds	r3, r2, r3
    11e2:	4618      	mov	r0, r3
    11e4:	f000 f854 	bl	1290 <_ZNKSt9basic_iosIcSt11char_traitsIcEE3tieEv>
    11e8:	4603      	mov	r3, r0
    11ea:	4618      	mov	r0, r3
    11ec:	f7ff fe4a 	bl	e84 <_ZNSo5flushEv>
    return __str.good();
    11f0:	9b01      	ldr	r3, [sp, #4]
    11f2:	681b      	ldr	r3, [r3, #0]
    11f4:	f1a3 030c 	sub.w	r3, r3, #12
    11f8:	681b      	ldr	r3, [r3, #0]
    11fa:	9a01      	ldr	r2, [sp, #4]
    11fc:	18d3      	adds	r3, r2, r3
    11fe:	4618      	mov	r0, r3
    1200:	f7ff fb5c 	bl	8bc <_ZNKSt8ios_base4goodEv>
    1204:	4603      	mov	r3, r0
    1206:	e001      	b.n	120c <_ZNSt4priv12__init_bostrIcSt11char_traitsIcEEEbRSt13basic_ostreamIT_T0_E+0xb8>
  }
  else
    return false;
    1208:	f04f 0300 	mov.w	r3, #0
}
    120c:	4618      	mov	r0, r3
    120e:	b003      	add	sp, #12
    1210:	bd00      	pop	{pc}
    1212:	bf00      	nop

00001214 <_ZNSt9basic_iosIcSt11char_traitsIcEE5clearEi>:
  }

public:                         // Members from 27.4.4.3.  These four functions
                                // can almost be defined in ios_base.

  void clear(iostate __state = goodbit) {
    1214:	b510      	push	{r4, lr}
    1216:	b082      	sub	sp, #8
    1218:	9001      	str	r0, [sp, #4]
    121a:	9100      	str	r1, [sp, #0]
    _M_clear_nothrow(this->rdbuf() ? __state : iostate(__state|ios_base::badbit));
    121c:	9c01      	ldr	r4, [sp, #4]
    121e:	9801      	ldr	r0, [sp, #4]
    1220:	f7ff feb0 	bl	f84 <_ZNKSt9basic_iosIcSt11char_traitsIcEE5rdbufEv>
    1224:	4603      	mov	r3, r0
    1226:	2b00      	cmp	r3, #0
    1228:	d103      	bne.n	1232 <_ZNSt9basic_iosIcSt11char_traitsIcEE5clearEi+0x1e>
    122a:	9b00      	ldr	r3, [sp, #0]
    122c:	f043 0301 	orr.w	r3, r3, #1
    1230:	e000      	b.n	1234 <_ZNSt9basic_iosIcSt11char_traitsIcEE5clearEi+0x20>
    1232:	9b00      	ldr	r3, [sp, #0]
    1234:	4620      	mov	r0, r4
    1236:	4619      	mov	r1, r3
    1238:	f7ff fb4c 	bl	8d4 <_ZNSt8ios_base16_M_clear_nothrowEi>
    _M_check_exception_mask();
    123c:	9b01      	ldr	r3, [sp, #4]
    123e:	4618      	mov	r0, r3
    1240:	f7ff fb50 	bl	8e4 <_ZNSt8ios_base23_M_check_exception_maskEv>
  }
    1244:	b002      	add	sp, #8
    1246:	bd10      	pop	{r4, pc}

00001248 <_ZNSt4priv9_UseFacetISt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEEEEPT_RKSt6localePKS7_>:
template <class _Facet>
inline bool _HasFacet(const locale& __loc, const _Facet* __facet) _STLP_NOTHROW
{ return (__loc._M_get_facet(_GetFacetId(__facet)) != 0); }

template <class _Facet>
inline _Facet* _UseFacet(const locale& __loc, const _Facet* __facet)
    1248:	b500      	push	{lr}
    124a:	b083      	sub	sp, #12
    124c:	9001      	str	r0, [sp, #4]
    124e:	9100      	str	r1, [sp, #0]
{ return __STATIC_CAST(_Facet*, __loc._M_use_facet(_GetFacetId(__facet))); }
    1250:	9800      	ldr	r0, [sp, #0]
    1252:	f7ff eabc 	blx	7cc <_start-0x24>
    1256:	4603      	mov	r3, r0
    1258:	9801      	ldr	r0, [sp, #4]
    125a:	4619      	mov	r1, r3
    125c:	f7ff eabc 	blx	7d8 <_start-0x18>
    1260:	4603      	mov	r3, r0
    1262:	4618      	mov	r0, r3
    1264:	b003      	add	sp, #12
    1266:	bd00      	pop	{pc}

00001268 <_ZNSt18__char_traits_baseIciE3eofEv>:

  static bool _STLP_CALL eq_int_type(const int_type& __c1, const int_type& __c2)
  { return __c1 == __c2; }

  static int_type _STLP_CALL eof()
  { return (int_type)-1; }
    1268:	f04f 33ff 	mov.w	r3, #4294967295	; 0xffffffff
    126c:	4618      	mov	r0, r3
    126e:	4770      	bx	lr

00001270 <_ZNSt18__char_traits_baseIciE11eq_int_typeERKiS2_>:
  { return (char_type)__c; }

  static int_type _STLP_CALL to_int_type(const char_type& __c)
  { return (int_type)__c; }

  static bool _STLP_CALL eq_int_type(const int_type& __c1, const int_type& __c2)
    1270:	b082      	sub	sp, #8
    1272:	9001      	str	r0, [sp, #4]
    1274:	9100      	str	r1, [sp, #0]
  { return __c1 == __c2; }
    1276:	9b01      	ldr	r3, [sp, #4]
    1278:	681a      	ldr	r2, [r3, #0]
    127a:	9b00      	ldr	r3, [sp, #0]
    127c:	681b      	ldr	r3, [r3, #0]
    127e:	429a      	cmp	r2, r3
    1280:	bf14      	ite	ne
    1282:	2300      	movne	r3, #0
    1284:	2301      	moveq	r3, #1
    1286:	b2db      	uxtb	r3, r3
    1288:	4618      	mov	r0, r3
    128a:	b002      	add	sp, #8
    128c:	4770      	bx	lr
    128e:	bf00      	nop

00001290 <_ZNKSt9basic_iosIcSt11char_traitsIcEE3tieEv>:
public:                         // Constructor, destructor.
  explicit basic_ios(basic_streambuf<_CharT, _Traits>* __streambuf);
  virtual ~basic_ios() {}

public:                         // Members from clause 27.4.4.2
  basic_ostream<_CharT, _Traits>* tie() const {
    1290:	b082      	sub	sp, #8
    1292:	9001      	str	r0, [sp, #4]
    return _M_tied_ostream;
    1294:	9b01      	ldr	r3, [sp, #4]
    1296:	6cdb      	ldr	r3, [r3, #76]	; 0x4c
  }
    1298:	4618      	mov	r0, r3
    129a:	b002      	add	sp, #8
    129c:	4770      	bx	lr
    129e:	bf00      	nop
