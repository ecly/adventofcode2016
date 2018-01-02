def main(input):
    res = ""
    rem = input[::]
    while '(' in rem:
        start = rem.index('(')
        end = rem.index(')')
        chars, repetitions = list(map(int, rem[start+1:end].split('x')))
        res += rem[:start]
        res += rem[end+1:end+1+chars]*repetitions
        rem = rem[end+chars+1:]

    res += rem
    return len(res)

with open('input.in') as f:
    input = f.read().strip()

print(main(input))
