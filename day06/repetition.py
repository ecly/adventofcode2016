def main(file, charCount):
    lists = [[] for _ in range(charCount)]
    for line in file.readlines():
        for i, c in enumerate(line.strip()):
            lists[i].append(c)

    return ''.join(map(lambda l: max(set(l), key=l.count), lists))

with open('input.in') as f:
    print(main(f, 8))

