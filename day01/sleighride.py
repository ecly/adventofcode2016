def parse(file):
    directions = file.read().split(', ')
    return [(x[0], int(x[1:])) for x in directions]

def distance(directions):
    position = [0, 0]
    direction = [0, 1]
    for (dir,val) in directions:
        if dir == 'R': direction[0] *= -1
        if dir == 'L': direction[1] *= -1
        direction.reverse()

        position[0] += direction[0] * val
        position[1] += direction[1] * val
        
    return sum(position)

file = open('input.in', 'r')
directions = parse(file)
print(distance(directions))

