def parse(file):
    directions = file.read().split(', ')
    return [(x[0], int(x[1:])) for x in directions]

def first_duplicate(directions):
    position = [0, 0]
    direction = [0, 1]
    seen = {(0, 0)}
    for (dir,val) in directions:
        if dir == 'R': direction[0] *= -1
        if dir == 'L': direction[1] *= -1
        direction.reverse()

        # add every square we walk over to seen
        for i in range(1, val + 1):
            pos = (position[0] + direction[0] * i,
                   position[1] + direction[1] * i)
            if pos in seen: return sum(map(abs,pos))
            seen.add(pos)

        position[0] += direction[0] * val
        position[1] += direction[1] * val

def distance(directions):
    position = [0, 0]
    direction = [0, 1]
    for (dir,val) in directions:
        if dir == 'R': direction[0] *= -1
        if dir == 'L': direction[1] *= -1
        direction.reverse()

        position[0] += direction[0] * val
        position[1] += direction[1] * val
        
    return sum(map(abs,position))

file = open('input.in', 'r')
directions = parse(file)
print(distance(directions))
print(first_duplicate(directions))
