    .section .note.GNU-stack,""
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb
    .text

is_prime:

mov %rdi, %r8 # n
mov $2, %r9 # i

# base case! n is 2
cmp %r8, %r9
jae is_a_prime

prime_loop:
# %r8/%r9 = %rax, remander = %rdx
mov $0, %rdx
mov %r8, %rax
div %r9

cmp $0, %rdx
je is_not_prime

# add 1 and check if n <= i becuase then we know its prime
add $1, %r9
cmp %r9, %r8
jbe is_a_prime

jmp prime_loop

is_not_prime:
mov $0, %rax
ret

is_a_prime:
mov $1, %rax
ret

largest_power_unsigned:
# make var for accumulator and multiplier
mov %rdi, %rax
mov %rdi, %r8

# keep multiplying %rax by %r8
loop:
mul %r8

# keep going while OF not set
jno loop
# div by the multiplier to go back one step
div %r8
ret

overflowing_subtract:

sub %rsi, %rdi
# jmp if overflowed
jo overflowed
# otherwise just return
mov %rdi, %rax
ret

overflowed:
mov $0, %rax
ret

dumb:
# check to return
cmp $0, %rdi
je return_b_plus_1

cmp $0, %rsi
je return_a

# push on stack 
push %rdi
push %rsi

# subtract for the recursive call
sub $1, %rdi
sub $1, %rsi

# jmp causes sigsegv, use call
call dumb

# POP REVERSE TO PUSH
pop %rsi
pop %rdi

# a + a + b
add %rdi, %rax
add %rdi, %rax
add %rsi, %rax

ret

return_b_plus_1:
# b + 1 -> return
add $1, %rsi
mov %rsi, %rax
ret

return_a:
# return a
mov %rdi, %rax
ret