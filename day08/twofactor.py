import copy

def main(lines, rows, columns):
    screen = [['.']*columns for _ in range(rows)]
    for line in lines:
        if line.startswith('rotate'):
            _, rc, xy, _, amount = line.split()
            amount = int(amount)
            val = int(xy[2:])
            new = copy.deepcopy(screen)
            if rc == 'column':
                for i in range(rows):
                    new[(i+amount)%rows][val] = screen[i][val]
            else: 
                for i in range(columns):
                    new[val][(i+amount)%columns] = screen[val][i]

            screen = new
        else:
            _, size = line.split()
            x, y = list(map(int, size.split('x')))
            for iy in range(y):
                for ix in range(x):
                    screen[iy][ix] = '#'

    return screen

with open('input.in') as f:
    lines = f.readlines()

res = main(lines, 6, 50)
print(''.join([''.join(r) for r in res]).count('#'))
for r in res: # read off answer
    print(r)
