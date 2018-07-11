import sys

def solve(cmds):
    val = list("abcdefgh")
    for l in cmds:
        cmd = l.split(" ")
        if cmd[0] == "swap" and cmd[1] == "position":
            x, y = int(cmd[2]), int(cmd[5])
            val[x], val[y] = val[y], val[x]
        if cmd[0] == "swap" and cmd[1] == "letter":
            x, y = cmd[2], cmd[5]
            x_pos, y_pos = val.index(x), val.index(y)
            val[x_pos], val[y_pos] = val[y_pos], val[x_pos]
        if cmd[0] == "rotate":
            is_left = cmd[1] == "left"
            amount = 1
            if cmd[1] == "based":
                idx = val.index(cmd[6])
                amount += idx if idx < 4 else idx+1
            else:
                amount = int(cmd[2])

            amount = amount if cmd[1] == "left" else -amount
            val = val[amount % len(val):] + val[:amount % len(val)]

        if cmd[0] == "reverse":
            x, y = int(cmd[2]), int(cmd[4])
            val = val[:x] + val[x:y+1][::-1] + val[y+1:]
        if cmd[0] == "move":
            x, y = int(cmd[2]), int(cmd[5])
            x_val = val[x]
            val = val[:x] + val[x+1:]
            val.insert(y, x_val)

    return "".join(val)


with sys.stdin as f:
    input_ = [x.strip() for x in f.readlines()]
    print(solve(input_))
