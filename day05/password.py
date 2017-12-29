import hashlib

def first(input):
    output = ""
    index = 0
    while len(output) < 8:
        val = input + str(index)
        hash = hashlib.md5(val.encode()).hexdigest()
        if hash.startswith('00000'):
            output += hash[5]

        index += 1

    return output

def second(input):
    output = list('________')
    index = 0
    found = 0
    while found < 8:
        val = input + str(index)
        hash = hashlib.md5(val.encode()).hexdigest()
        if hash.startswith('00000'):
            idx = int(hash[5], 16)
            if idx < 8 and output[idx] == '_':
                output[idx] = hash[6]
                found += 1

        index += 1

    return ''.join(output)

# about 30 seconds total
print(first('uqwqemis'))
print(second('uqwqemis'))
