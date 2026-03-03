import sys
path=sys.argv[1]
with open(path) as f:
    for i,line in enumerate(f, start=1):
        print(f"{i:3}: {line.rstrip()}")
