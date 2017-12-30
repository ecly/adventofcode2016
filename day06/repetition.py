def main(lines, charCount, fun):
    lists = [[] for _ in range(charCount)]
    for line in lines:
        for i, c in enumerate(line.strip()):
            lists[i].append(c)

    return ''.join(map(lambda l: fun(set(l), key=l.count), lists))

with open('input.in') as f:
    lines = f.readlines()

print(main(lines, 8, max))
print(main(lines, 8, min))
