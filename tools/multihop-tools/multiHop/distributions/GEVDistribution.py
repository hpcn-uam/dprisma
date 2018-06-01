from scipy.stats import genextreme
from multiHop.distributions.AbstractDistribution import EstimatedAbstract

class EstimatedGEV(EstimatedAbstract):
	"""docstring for EstimatedGEV"""
	eps = 0.05
	def __init__(self):
		super(EstimatedGEV, self).__init__(genextreme)
		self.params = None
		
	def fit(self, data, c=0, loc=1, scale=1):
		(c, loc, scale) = genextreme.fit(data)
		self.c, self.loc, self.scale = (c, loc, scale)
		self.epsilon = -self.c
		self.params = {'c': self.c, 'loc': self.loc, 'scale': self.scale}
		self.setParams(self.params)
		return (self.c, self.loc, self.scale)
	def mode(self):

		if -self.eps < self.c < +self.eps:
			return self.loc
		else:
			return 	self.loc + self.scale*((1+self.epsilon)**(-self.epsilon) - 1)/self.epsilon