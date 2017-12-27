from collections import Counter
def main(file):
    sum = 0
    for line in file.readlines():
        split = line.split('-')
        val, checksum = split[len(split)-1].split('[')
        characters = ''.join(split[:len(split)][:-1]).strip()
        counter = Counter(sorted(characters))
        common = counter.most_common(5)
        if all(c[0] in checksum for c in common):
            sum += int(val)

    return sum

with open('input.in') as f:
    print(main(f))
