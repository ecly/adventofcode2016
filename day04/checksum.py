import string
from collections import Counter

def first(input):
    sum = 0
    for line in input:
        split = line.split('-')
        val, checksum = split[-1].split('[')
        characters = ''.join(split[:-1]).strip()
        counter = Counter(sorted(characters))
        common = counter.most_common(5)
        if all(c[0] in checksum for c in common):
            sum += int(val)

    return sum

#https://stackoverflow.com/questions/8886947/caesar-cipher-function-in-python
def caesar(plaintext, shift):
    alphabet = string.ascii_lowercase
    shifted_alphabet = alphabet[shift:] + alphabet[:shift]
    table = str.maketrans(alphabet, shifted_alphabet)
    return plaintext.translate(table)

def second(input):
    for line in input:
        split = line.split('-')
        val, checksum = split[-1].split('[')
        shift = int(val) % 26
        words = list(map(lambda word: caesar(word, shift), split[:-1]))
        if 'northpole' in words and 'storage' in words:
            return val

with open('input.in') as f:
    lines = f.readlines()
    print(first(lines))
    print(second(lines))
