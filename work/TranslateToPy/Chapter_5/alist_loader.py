import numpy as np

def read_and_split(f):
    line = f.readline()
    u = line.split(" ")
    return u

def load_alist(filename):
    tmp_dict = {}
    tmp_rdict = {}
    n = 0
    m = 0
    with open(filename, "r") as f:
        u = read_and_split(f)
        n = int(u[0])
        m = int(u[1]) 
        print("n = {}, m = {}".format(n, m))
        u = read_and_split(f)
        cmax = int(u[0])
        rmax = int(u[1]) 
        print("cmap = {}, rmap = {}".format(cmax, rmax))
        line = f.readline()
        line = f.readline()
        Id = 1
        for i in range(1, n+1):
            u = read_and_split(f)
            for j in range(cmax):
                v = int(u[j])
                if v != 0:
                    tmp_dict["{} {}".format(v, i)] = Id
                    tmp_rdict["{}".format(Id)] = (v, i)
                    Id +=1
    esize = len(tmp_dict)
    H = np.zeros((m, n))
    for x in tmp_dict.keys():
        u = x.split(" ")
        row = int(u[0]) - 1 
        col = int(u[1]) - 1
        H[row, col] = 1
    
    U = np.zeros((n, esize))
    for x in tmp_dict.keys():
        j = tmp_dict[x] - 1
        u = x.split(" ")
        i = int(u[1]) - 1
        U[i, j] = 1

    V = np.zeros((m, esize))
    for x in tmp_dict.keys():
        j = tmp_dict[x] - 1
        u = x.split(" ")
        i = int(u[0]) - 1
        V[i, j] = 1
    
    return H.astype(np.int64), U.astype(np.int64), V.astype(np.int64)
if __name__ == '__main__':
    H, U, V = load_alist("../../DU-Book/Chapter_5/6.3.alist")
    print(U)
    print(V)
    print(H)