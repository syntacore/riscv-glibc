/* Multiple versions of vectorized pow.
   Copyright (C) 2014-2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#include <sysdep.h>
#include <init-arch.h>

	.text
ENTRY (_ZGVeN8vv_pow)
        .type   _ZGVeN8vv_pow, @gnu_indirect_function
	LOAD_RTLD_GLOBAL_RO_RDX
        leaq    _ZGVeN8vv_pow_skx(%rip), %rax
	HAS_ARCH_FEATURE (AVX512DQ_Usable)
        jnz     2f
        leaq    _ZGVeN8vv_pow_knl(%rip), %rax
	HAS_ARCH_FEATURE (AVX512F_Usable)
        jnz     2f
        leaq    _ZGVeN8vv_pow_avx2_wrapper(%rip), %rax
2:      ret
END (_ZGVeN8vv_pow)

#define _ZGVeN8vv_pow _ZGVeN8vv_pow_avx2_wrapper
#include "../svml_d_pow8_core.S"
