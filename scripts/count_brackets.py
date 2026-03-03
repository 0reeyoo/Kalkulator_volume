import sys
path=sys.argv[1]
counter={'(':0,')':0,'{':0,'}':0,'[':0,']':0}
with open(path) as f:
    for l in f:
        for ch in l:
            if ch in counter: counter[ch]+=1
print(counter)
