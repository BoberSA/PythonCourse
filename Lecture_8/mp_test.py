import multiprocessing as mp
import numpy as np


def calc(A):
    return np.linalg.eigvals(A)

if __name__ == '__main__':

    pool = mp.Pool(mp.cpu_count()//2)
    data = np.random.rand(100, 1000, 1000)
    
    res = pool.map(calc, data)
    
    res = np.array(res)
    
    np.savetxt('eigvals.txt', res)
    
    print(res.shape)