import hashlib
def main(input):
    output = ""
    index = 0
    while len(output) < 8:
        val = input + str(index)
        hash = hashlib.md5(val.encode()).hexdigest()
        if hash.startswith('00000'):
            output += hash[5]

        index += 1

    return output

print(main('uqwqemis'))
