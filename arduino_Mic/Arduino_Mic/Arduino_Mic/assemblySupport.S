/*
 * assemblySupport.S
 *
 * Created: $date$
 *  Author: $user$
 */

 #if (__GNUC__ * 100 + __GNUC_MINOR__) <= 303
#error "This library requires AVR-GCC 3.3 or later, update to newer AVR-GCC compiler"
#endif
 #include <avr/io.h>

 /*****************************************************************************
incCounter2 is functionally equivalent to
unsigned long incCounter2( unsigned long count )
{
	unsigned long newCount = count;
	newCount++;
	return newCount;
}
********************************************************************************/
 .global incCounter2
 .func	 incCounter2
 incCounter2:
 push	r16				;Save working registers
 push	r17
 movw	r16, r22		;Move parameter to working registers
 movw	r18, r24
 subi	r16, 0xFF		;Increment working registers
 sbci	r17, 0xFF
 sbci	r18, 0xFF
 sbci	r19, 0xFF
 movw	r22, r16		;Move new value to return registers
 movw	r24, r18
 pop	r17				;Restore working registers
 pop	r16
 ret
 .endfunc

