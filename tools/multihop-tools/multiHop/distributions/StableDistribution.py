from scipy.stats import levy_stable
from multiHop.distributions.AbstractDistribution import EstimatedAbstract
import numpy as np

class EstimatedStable(EstimatedAbstract):
	"""docstring for EstimatedStable"""
	eps = 0.05
	def __init__(self):
		super(EstimatedStable, self).__init__(levy_stable)
		self.params = None
		
	def fit(self, data, alpha, beta, loc=0, scale=1):
		(alpha, beta, loc, scale) = levy_stable.fit(data, alpha, beta)
		(self.alpha, self.beta, self.loc, self.scale) = (alpha, beta, loc, scale)
		self.params = {'alpha': self.alpha, 'beta': self.beta, 'loc': self.loc, 'scale': self.scale}
		self.setParams(self.params)
		return (self.alpha, self.beta, self.loc, self.scale)
	def mode(self):

		return np.nan