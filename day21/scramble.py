import sys


def rotate(l, amount):
    return l[amount % len(l) :] + l[: amount % len(l)]


def solve(letters, cmds):
    val = list(letters)
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
                amount += idx if idx < 4 else idx + 1
            else:
                amount = int(cmd[2])

            amount = amount if cmd[1] == "left" else -amount
            val = rotate(val, amount)

        if cmd[0] == "reverse":
            x, y = int(cmd[2]), int(cmd[4])
            val = val[:x] + val[x : y + 1][::-1] + val[y + 1 :]
        if cmd[0] == "move":
            x, y = int(cmd[2]), int(cmd[5])
            x_val = val[x]
            val = val[:x] + val[x + 1 :]
            val.insert(y, x_val)

    return "".join(val)


def solve_rev(letters, cmds):
    val = list(letters)
    for l in cmds[::-1]:
        cmd = l.split(" ")
        if cmd[0] == "swap" and cmd[1] == "position":
            x, y = int(cmd[2]), int(cmd[5])
            val[x], val[y] = val[y], val[x]
        if cmd[0] == "swap" and cmd[1] == "letter":
            x, y = cmd[2], cmd[5]
            x_pos, y_pos = val.index(x), val.index(y)
            val[x_pos], val[y_pos] = val[y_pos], val[x_pos]
        if cmd[0] == "rotate":
            amount = 1
            if cmd[1] == "based":
                idx = val.index(cmd[6])
                for a in range(0, len(val)):
                    old = rotate(val, a)
                    old_amount = 1
                    old_idx = old.index(cmd[6])
                    old_amount += old_idx if old_idx < 4 else old_idx + 1
                    if rotate(old, -old_amount) == val:
                        amount = -old_amount
                        break
            else:
                amount = int(cmd[2])

            amount = amount if cmd[1] == "right" else -amount
            val = rotate(val, amount)

        if cmd[0] == "reverse":
            x, y = int(cmd[2]), int(cmd[4])
            val = val[:x] + val[x : y + 1][::-1] + val[y + 1 :]
        if cmd[0] == "move":
            y, x = int(cmd[2]), int(cmd[5])
            x_val = val[x]
            val = val[:x] + val[x + 1 :]
            val.insert(y, x_val)

    return "".join(val)


with sys.stdin as f:
    input_ = [x.strip() for x in f.readlines()]

    print(solve("abcdefgh", input_))
    print(solve_rev("fbgdceah", input_))
