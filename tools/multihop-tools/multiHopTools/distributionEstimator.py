from multiHop.distributions.GEVDistribution import EstimatedGEV
from multiHop.distributions.LogNormalDistribution import EstimatedLogNorm
from multiHop.distributions.StableDistribution import EstimatedStable
from multiHop.distributions.KDEEstimator import EstimatedKDE
from multiHop.HSM import GeneralizedHSM
import argparse
import numpy as np
import matplotlib.pyplot as plt



def main():
	parser = argparse.ArgumentParser(description='Outputs distro data')
	parser.add_argument('file', help='File to be processed')
	#parser.add_argument('-o', '--output', required=True)
	args = parser.parse_args()
	density = 10000
	X = np.loadtxt(open(args.file, 'r'))
	for i in range(X.shape[1]):
		data = X[:, i]
		print('Column %d' % i)
		


		distro1 = EstimatedLogNorm()
		(s, loc, scale) = distro1.fit(X[:, i])
		print('logN: s=%f, loc=%f, scale=%f' % (s, loc, scale))
		print('logN: mode=%e, median=%f, mean=%f, std=%f, AIC=%f' % (distro1.mode(), distro1.median(), distro1.mean(), distro1.std(), distro1.AIC(X[:, i])))

		distro2 = EstimatedKDE()
		dist = distro2.fit(X[:, i])
		print('KDE:  mode=%e, median=%f, mean=%f, std=%f' % (distro2.mode(), distro2.median(), distro2.mean, distro2.std))
		print('HSM:  mode=%e (exponential)' % (GeneralizedHSM(X[:, i], 100, np.median, lambda x: int(np.ceil(0.9*x)))))
		print('HSM:  mode=%e (arithmetical)' % (GeneralizedHSM(X[:, i], 100, np.median, lambda x: int(max(x-10, 0)))))

		distro3 = EstimatedGEV()
		(c, loc, scale) = distro3.fit(X[:, i])
		print('GEV:  c=%f, loc=%f, scale=%f' % (c, loc, scale))
		print('GEV:  mode=%e, median=%f, mean=%f, std=%f, AIC=%f' % (distro3.mode(), distro3.median(), distro3.mean(), distro3.std(), distro3.AIC(data)))

		distro4 = EstimatedStable()
		(alpha, beta, loc, scale) = distro4.fit(X[:, i], alpha=0.5, beta=1)
		print('Stbl: alpha=%f, beta=%f, loc=%f, scale=%f' % (alpha, beta, loc, scale))
		print('Stbl: mode=%e, median=%f, mean=%f, std=%f, AIC=%f' % (distro4.mode(), distro4.median(), distro4.mean(), distro4.std(), distro4.AIC(data)))

		x = np.linspace(min(data), max(data), density)
		
		M = np.zeros((density, 2))
		M[:, 0] = x

		M[:, 1] = distro1.pdf(x)
		np.savetxt('%s_%d_logN.dat' % (args.file[0], i), M)
		M[:, 1] = distro2.pdf(x)
		np.savetxt('%s_%d_KDE.dat' % (args.file[0], i), M)
		M[:, 1] = distro3.pdf(x)
		np.savetxt('%s_%d_GEV.dat' % (args.file[0], i), M)
		M[:, 1] = distro4.pdf(x)
		np.savetxt('%s_%d_Stbl.dat' % (args.file[0], i), M)



if __name__ == '__main__':
	main()
