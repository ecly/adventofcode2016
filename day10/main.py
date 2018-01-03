from collections import defaultdict
# values we're searching for in part 1
LOW = 17
HIGH = 61

def runCommand(number, bots, output):
    cmd, chips = bots[number]
    if len(chips) > 1 and cmd != None:
        ltype, lid, _, _, _, htype, hid = cmd.split()[5:]
        lc, hc = sorted(chips)
        chips = []
        if lc == LOW and hc == HIGH: # we just print this as we go
            print(number)

        if ltype == 'output':
            output[lid].append(lc)
        else:
            bots[lid][1].append(lc)
            lo_res = runCommand(lid, bots, output)
        if htype == 'output':
            output[hid].append(hc)
        else:
            bots[hid][1].append(hc)
            hi_res = runCommand(hid, bots, output)

def main(lines):
    output = defaultdict(list)
    bots = defaultdict(lambda: [None, []])
    for line in lines:
        if line.startswith('value'):
            _, val, _, _, _, bot = line.split()
            bots[bot][1].append(int(val))
            runCommand(bot, bots, output)
        else:
            bot = line.split()[1]
            bots[bot][0] = line
            runCommand(bot, bots, output)

    return output

with open('input.in', 'r') as f:
    lines = sorted(f.readlines())[::-1]

print(main(lines))
