import numpy as np

def GeneralizedHSM(data, limit, ModeEstimator, f, isSorted=False):
	n = f(len(data))
	if not isSorted:
		data = np.sort(data)
	if limit == 0 or len(data) < 2 or n < 10:
		return ModeEstimator(data)
	
	S = data[:-n]
	EXT = data[n:]
	L = S - EXT

	I = np.argmin(L)
	return GeneralizedHSM(data[I:I+n], limit-1, ModeEstimator, f, isSorted=True)