def main(instructions):
    code = ""
    x, y = 1, 1
    keypad = ((1,2,3),(4,5,6),(7,8,9))
    for instruction in instructions:
        for c in instruction:
            if c == 'U'and y > 0: y-=1
            if c == 'D'and y < 2: y+=1
            if c == 'L'and x > 0: x-=1
            if c == 'R'and x < 2: x+=1
        code += str(keypad[y][x])

    return code


with open('input.in', 'r') as file:
    print(main(file.readlines()))
