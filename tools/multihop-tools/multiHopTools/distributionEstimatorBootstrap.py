from multiHop.distributions.GEVDistribution import EstimatedGEV
from multiHop.distributions.LogNormalDistribution import EstimatedLogNorm
from multiHop.distributions.StableDistribution import EstimatedStable
from multiHop.distributions.KDEEstimator import EstimatedKDE
from multiHop.distributions.AbstractDistribution import BootstrapDistribution

from multiHop.HSM import GeneralizedHSM
import argparse
import numpy as np
import matplotlib.pyplot as plt

def format(tuple):
	#print(tuple[2])
	return '%f+-%f' % (tuple[0], tuple[1])

def main():
	parser = argparse.ArgumentParser(description='Outputs distro data')
	parser.add_argument('file', help='File to be processed')
	parser.add_argument('--n_samples', '-n', help='Bootstrap samples', default=100)
	parser.add_argument('--size', '-s', help='Bootstrap size', default=500)
	#parser.add_argument('-o', '--output', required=True)
	args = parser.parse_args()
	args.n_samples = int(args.n_samples)
	args.size = int(args.size)
	density = 10000
	X = np.loadtxt(open(args.file, 'r'))
	for i in range(X.shape[1]):
		data_all = X[:, i]

		distro1 = BootstrapDistribution()
		distro2 = BootstrapDistribution()
		distro3 = BootstrapDistribution()
		distro4 = BootstrapDistribution()
		hsm = []
		kde = []
		for j in range(args.n_samples):
			np.random.seed(seed=j)
			indeces = np.random.randint(0, X.shape[0], args.size)
			data = data_all[indeces]
			#print('Column %d' % i)
			


			_distro1 = EstimatedLogNorm()
			(s, loc, scale) = _distro1.fit(data)
			distro1.append(_distro1)
			
			_distro2 = EstimatedKDE()
			dist = _distro2.fit(data)
			distro2.append(_distro2)

			_distro3 = EstimatedGEV()
			(c, loc, scale) = _distro3.fit(data)
			distro3.append(_distro3)
			

			_distro4 = EstimatedStable()
			(alpha, beta, loc, scale) = _distro4.fit(data, alpha=0.5, beta=1)
			distro4.append(_distro4)

			
		print('logN: s=%s, loc=%s, scale=%s' % (format(distro1.get('s')), format(distro1.get('loc')), format(distro1.get('scale'))))
		print('logN: mode=%s, median=%s, mean=%s, std=%s' % (format(distro1.mode()), format(distro1.median()), format(distro1.mean()), format(distro1.std())))
		#print('KDE:  mode=%s, median=%s, mean=%s, std=%s' % (format(distro2.mode()), format(distro2.median()), format(distro2.mean()), format(distro2.std())))
		#print('HSM:  mode=%f (exponential)' % (GeneralizedHSM(X[:, i], 100, np.median, lambda x: int(np.ceil(0.9*x)))))
		#print('HSM:  mode=%f (arithmetical)' % (GeneralizedHSM(X[:, i], 100, np.median, lambda x: int(max(x-10, 0)))))
		print('GEV:  c=%s, loc=%s, scale=%s' % (format(distro3.get('c')), format(distro3.get('loc')), format(distro3.get('scale'))))
		print('GEV:  mode=%s, median=%s, mean=%s, std=%s' % (format(distro3.mode()), format(distro3.median()), format(distro3.mean()), format(distro3.std())))
		print('Stbl: alpha=%s, beta=%s, loc=%s, scale=%s' % (format(distro4.get('alpha')), format(distro4.get('beta')), format(distro4.get('loc')), format(distro4.get('scale'))))
		print('Stbl: mode=%s, median=%s, mean=%s, std=%s' % (format(distro4.mode()), format(distro4.median()), format(distro4.mean()), format(distro4.std())))



if __name__ == '__main__':
	main()
