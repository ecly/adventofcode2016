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

def exec(instructions, regs, output_amount):
    i = 0
    output = ""
    while 0 <= i < len(instructions) and len(output) < output_amount:
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
        elif cmd == 'out':
            output += str(get_val(regs, instr[1]))

        i+=1

    return output

with open('input.in') as f:
    instructions = f.read().splitlines()
    for i in range(100000):
        regs = dict(zip('abcd', [i,0,0,0]))
        res = exec(instructions.copy(), regs, 10)
        if res == "0101010101":
            print(i)
            break
