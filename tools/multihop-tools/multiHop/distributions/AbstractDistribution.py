import numpy as np

class EstimatedAbstract(object):
	def __init__(self, distro):
		super(EstimatedAbstract, self).__init__()
		self.distro = distro
		self.params = None

	def setParams(self, params):
		self.params = params

	def rvs(self, size=1):
		return self.distro.rvs(**self.params, size=1)
	def pdf(self, x):
		return self.distro.pdf(x=x, **self.params)
	def logpdf(self, x):
		return self.distro.logpdf(x=x, **self.params)
	def cdf(self, x):
		return self.distro.cdf(x=x, **self.params)
	def logcdf(self, x):
		return self.distro.logcdf(x=x, **self.params)
	def sf(self, x):
		return self.distro.sf(x=x, **self.params)
	def logsf(self, x):
		return self.distro.logsf(x=x, **self.params)
	def ppf(self, q):
		return self.distro.ppf(q=q, **self.params)
	def logppf(self, q):
		return self.distro.logppf(q=q, **self.params)
	def isf(self, q):
		return self.distro.isf(q=q, **self.params)
	def moment(self, n):
		return self.distro.moment(n, **self.params)
	def stats(self, moments='mv'):
		return self.distro.stats(**self.params, moments=moments)
	def entropy(self, ):
		return self.distro.entropy(**self.params)
	def expect(self, func, lb=None, ub=None, conditional=False, **kwds):
		return self.distro.expect(func=func, lb=lb, ub=ub, conditional=conditional, **self.params)
	def median(self, ):
		return self.distro.median(**self.params)
	def mean(self, ):
		return self.distro.mean(**self.params)
	def var(self, ):
		return self.distro.var(**self.params)
	def std(self, ):
		return self.distro.std(**self.params)
	def interval(self, alpha):
		return self.distro.interval(alpha=alpha, **self.params)
	def numParams(self):
		return len(self.params)
	def AIC(self, x):
		k = self.numParams()
		logL = np.sum(np.log(self.pdf(x)))
		return 2*(k - logL)


class BootstrapDistribution(object):
	methods = ['rvs', 'pdf', 'logpdf', 'cdf', 'logcdf', 'sf', 'logsf', 'ppf', 'mode', 
	'logppf', 'isf', 'moment', 'stats', 'entropy', 'expect', 'median', 'mean', 'var', 'std', 'interval']
	attrs = {}
	def __init__(self):
		super(BootstrapDistribution, self).__init__()
		self.distros = []

	def __getitem__(self, key):
		self.attrs[key]

	def __setitem__(self, key, value):
		sel.attrs[key] = value
	def append(self, distro):
		return self.distros.append(distro)

	def get(self, param):
		res = []
		for distro in self.distros:
			res.append(distro.__getattribute__(param))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)

	def rvs(self, size=1):
		res = []
		for distro in self.distros:
			res.append(distro.rvs(size=size))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def pdf(self, x):
		res = []
		for distro in self.distros:
			res.append(distro.pdf(x))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def logpdf(self, x):
		res = []
		for distro in self.distros:
			res.append(distro.logpdf(x))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def cdf(self, x):
		res = []
		for distro in self.distros:
			res.append(distro.cdf(x))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def logcdf(self, x):
		res = []
		for distro in self.distros:
			res.append(distro.logcdf(x))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def sf(self, x):
		res = []
		for distro in self.distros:
			res.append(distro.sf(x))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def logsf(self, x):
		res = []
		for distro in self.distros:
			res.append(distro.logsf(x))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def ppf(self, q):
		res = []
		for distro in self.distros:
			res.append(distro.ppf(q))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def logppf(self, q):
		res = []
		for distro in self.distros:
			res.append(distro.logppf(q))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def isf(self, q):
		res = []
		for distro in self.distros:
			res.append(distro.isf(q))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def moment(self, n):
		res = []
		for distro in self.distros:
			res.append(distro.moment(n))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def stats(self, moments='mv'):
		res = []
		for distro in self.distros:
			res.append(distro.stats(moments=moments))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def entropy(self, ):
		res = []
		for distro in self.distros:
			res.append(distro.entropy())
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def expect(self, func, lb=None, ub=None, conditional=False, **kwds):
		res = []
		for distro in self.distros:
			res.append(distro.expect(func, lb=lb, ub=ub, conditional=conditional, **kwds))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def median(self, ):
		res = []
		for distro in self.distros:
			res.append(distro.median())
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def mean(self, ):
		res = []
		for distro in self.distros:
			res.append(distro.mean())
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def var(self, ):
		res = []
		for distro in self.distros:
			res.append(distro.var())
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def std(self, ):
		res = []
		for distro in self.distros:
			res.append(distro.std())
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def interval(self, alpha):
		res = []
		for distro in self.distros:
			res.append(distro.interval(alpha))
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			pass
		return (mu, s, res)
	def mode(self):
		res = []
		for distro in self.distros:
			res.append(distro.mode())
		mu = s = np.nan
		try:
			mu = np.mean(res)
			s = np.std(res)
		except BaseException as e:
			print(e)
		return (mu, s, res)


