def first(instructions):
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

def second(instructions):
    code = ""
    x, y = 0, 2
    keypad = ((None,None,1   ,None,None),
              (None,2   ,3   ,4   ,None),
              (5   ,6   ,7   ,8   ,9   ),
              (None,'A' ,'B' ,'C' ,None),
              (None,None,'D' ,None,None))
    for instruction in instructions:
        for c in instruction:
            if c == 'U'and y > 0: 
                if(keypad[y-1][x] != None): y-=1
            if c == 'D'and y < 4:
                if(keypad[y+1][x] != None): y+=1
            if c == 'L'and x > 0:
                if(keypad[y][x-1] != None): x-=1
            if c == 'R'and x < 4:
                if(keypad[y][x+1] != None): x+=1
        code += str(keypad[y][x])

    return code

with open('input.in', 'r') as file:
    lines = file.readlines()
    print(first(lines))
    print(second(lines))
