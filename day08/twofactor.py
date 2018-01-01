import copy
ROWS = 6
COLUMNS = 50
def main(lines):
    screen = [['.']*COLUMNS for _ in range(ROWS)]
    for line in lines:
        if line.startswith('rotate'):
            _, rc, xy, _, amount = line.split()
            amount = int(amount)
            val = int(xy[2:])
            new = copy.deepcopy(screen)
            if rc == 'column':
                for i in range(ROWS):
                    new[(i+amount)%ROWS][val] = screen[i][val]
            else: 
                for i in range(COLUMNS):
                    new[val][(i+amount)%COLUMNS] = screen[val][i]

            screen = new
        else:
            _, size = line.split()
            x, y = list(map(int, size.split('x')))
            for iy in range(y):
                for ix in range(x):
                    screen[iy][ix] = '#'

    return ''.join([''.join(r) for r in screen]).count('#')

with open('input.in') as f:
    lines = f.readlines()

print(main(lines))
