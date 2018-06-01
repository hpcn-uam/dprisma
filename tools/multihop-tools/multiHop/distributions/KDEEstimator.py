from statsmodels.nonparametric.kde import KDEUnivariate
from statsmodels.nonparametric.kernel_density import KDEMultivariate
from multiHop.distributions.AbstractDistribution import EstimatedAbstract
import numpy as np

class EstimatedKDE(object):
	"""docstring for EstimatedKDE"""
	eps = 0.05
	points = 10000
	def __init__(self):
		super(EstimatedKDE, self).__init__()
		self.dist = None
		
	def fit(self, data):
		self.min = np.min(data)
		self.max = np.max(data)
		self.mean = np.mean(data)
		self.std = np.std(data)
		self.dist = KDEUnivariate(data)
		self.dist.fit()
		return self
	def mode(self):
		x = np.linspace(self.min, self.max, self.points)
		y = self.dist.evaluate(x)
		return x[np.argmax(y)]
	def median(self):
		return self.dist.icdf[50]
	def pdf(self, x):
		return self.dist.evaluate(x)