from math import sqrt; from itertools import count, islice

def get_val(regs, val):
    if val.isalpha():
        return regs[val]
    else:
        return int(val)

# basically copy of day 18
def first(instructions):
    regs = dict(zip('abcd', [0]*4))
    i = 0
    while 0 <= i < len(instructions):
        instr = instructions[i].split()
        cmd = instr[0]

        if cmd == 'cpy':
            regs[instr[2]] = get_val(regs, instr[1])
        elif cmd == 'inc':
            regs[instr[1]] += 1
        elif cmd == 'dec':
            regs[instr[1]] -= 1
        elif cmd == 'jnz':
            val = get_val(regs, instr[1])
            if val != 0:
                i = i + get_val(regs, instr[2])
                continue
        i+=1
    return regs['a']

with open('input.in') as f:
    instructions = f.read().splitlines()
    print(first(instructions))
