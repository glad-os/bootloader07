.globl _start, PUT32, PUT8, GET32, GETPC, BRANCHTO, dummy



_start:
				B		skip



.space				0x200000-0x8004, 0



skip:
				MOV		sp		, #0x08000000
				BL		notmain
hang:
				B		hang



PUT32:
				STR		w1, [x0]
				RET



PUT8:
				STRB		w1, [x0]
				RET


GET32:
				LDR		w0, [x0]
				RET



GETPC:
				MOV		x0, x30
				RET



BRANCHTO:
				BR		x0



dummy:
				RET



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
