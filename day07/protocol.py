def isABBA(chars):
    return chars[0] == chars[3] and chars[1] == chars[2] and chars[0] != chars[1]

def hasABBA(section):
    for i in range(len(section)-3):
        if isABBA(section[i:i+4]):
            return True

    return False

def hasTLS(ip):
    tls = []
    hypernets = []
    outer = ip[::]
    while '[' in outer:
        start = outer.index('[')
        end = outer.index(']')
        hypernets.append(outer[start+1:end])
        tls.append(outer[:start])
        outer = outer[end+1:]

    tls.append(outer)

    return any(hasABBA(x) for x in tls) and not any(hasABBA(x) for x in hypernets)

with open('input.in') as f:
    lines = f.readlines()

print(len(list(filter(hasTLS, lines))))
