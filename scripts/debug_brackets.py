import sys
path=sys.argv[1]
cnt=0
with open(path) as f:
    for i,line in enumerate(f, start=1):
        for ch in line:
            if ch=='(':
                cnt+=1
            elif ch==')':
                cnt-=1
        if cnt<0 or cnt>1:
            print(i, cnt, line.rstrip())
print('final cnt',cnt)
