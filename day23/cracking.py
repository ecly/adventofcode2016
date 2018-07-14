def get_val(regs, val):
    if val.isalpha():
        return regs[val]

    return int(val)

def toggle(instruction):
    instr = instruction.split()
    cmd = instr[0]
    if cmd == 'cpy':
        return 'jnz %s %s' % (instr[1], instr[2])
    elif cmd == 'dec':
        return 'inc %s' % instr[1]
    elif cmd == 'inc':
        return 'dec %s' % instr[1]
    elif cmd == 'jnz':
        return 'cpy %s %s' % (instr[1], instr[2])
    elif cmd == 'tgl':
        return 'inc %s' % instr[1]

def exec(instructions, regs):
    i = 0
    while 0 <= i < len(instructions):
        instr = instructions[i].split()
        cmd = instr[0]

        if cmd == 'cpy':
            if instr[2] in regs:
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
        elif cmd == 'tgl':
            target = i + get_val(regs, instr[1])
            if 0 <= target < len(instructions):
                instructions[target] = toggle(instructions[target])

        i+=1

    return regs['a']

with open('input.in') as f:
    instructions = f.read().splitlines()
    regs1 = dict(zip('abcd', [7,0,0,0]))
    print(exec(instructions.copy(), regs1))
    # 5 minutes with pypy3 - no optimizations needed :-)
    regs2 = dict(zip('abcd', [12,0,0,0]))
    print(exec(instructions, regs2))
