.globl _start, PUT32, PUT16, PUT8, GET32, GETPC, BRANCHTO, dummy

_start:
    b skip

.space 0x200000-0x8004,0

skip:
    mov sp,#0x08000000
    bl notmain
hang: b hang

PUT32:
    str r1,[r0]
    bx lr

PUT16:
    strh r1,[r0]
    bx lr

PUT8:
    strb r1,[r0]
    bx lr

GET32:
    ldr r0,[r0]
    bx lr

GETPC:
    mov r0,lr
    bx lr

BRANCHTO:
    bx r0

dummy:
    bx lr

// ;@-------------------------------------------------------------------------
// ;@
// ;@ Copyright (c) 2012 David Welch dwelch@dwelch.com
// ;@
// ;@ Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// ;@
// ;@ The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// ;@
// ;@ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// ;@
// ;@-------------------------------------------------------------------------
