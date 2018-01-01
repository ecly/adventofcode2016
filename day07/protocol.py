def splitSequences(ip):
    outer = []
    inner = []
    rem = ip[::]
    while '[' in rem:
        start = rem.index('[')
        end = rem.index(']')
        inner.append(rem[start+1:end])
        outer.append(rem[:start])
        rem = rem[end+1:]

    outer.append(rem)
    return outer, inner

def isABBA(chars):
    return chars[0] == chars[3] and chars[1] == chars[2] and chars[0] != chars[1]

def hasABBA(section):
    for i in range(len(section)-3):
        if isABBA(section[i:i+4]):
            return True

    return False

def hasTLS(ip):
    outer, inner = splitSequences(ip)
    return any(hasABBA(x) for x in outer) and not any(hasABBA(x) for x in inner)

def isABA(chars):
    return chars[0] == chars[2] and chars[0] != chars[1]

def findAllABA(section):
    for i in range(len(section)-2):
        if isABA(section[i:i+3]):
            yield section[i:i+3]

def hasSSL(ip):
    outer, inner = splitSequences(ip)
    for out in outer:
        for aba in findAllABA(out):
            bab = aba[1] + aba[0] + aba[1]
            if any(bab in x for x in inner):
                return True

    return False

with open('input.in') as f:
    lines = f.readlines()

print(len(list(filter(hasTLS, lines))))
print(len(list(filter(hasSSL, lines))))
