from scipy.stats import lognorm
from multiHop.distributions.AbstractDistribution import EstimatedAbstract
import numpy as np
class EstimatedLogNorm(EstimatedAbstract):
	"""docstring for EstimatedLogNorm"""
	eps = 0.05
	def __init__(self):
		super(EstimatedLogNorm, self).__init__(lognorm)
		self.params = None
		
	def fit(self, data, s=1, loc=1, scale=1):
		(s, loc, scale) = lognorm.fit(data)
		self.s, self.loc, self.scale = (s, loc, scale)
		self.mu = np.log(self.scale)
		self.sigma = self.s
		self.params = {'s': self.s, 'loc': self.loc, 'scale': self.scale}
		self.setParams(self.params)
		return (self.s, self.loc, self.scale)
	def numParams(self):
		return 2
	def mode(self):
		return np.exp(-self.s**2)*self.scale + self.loc