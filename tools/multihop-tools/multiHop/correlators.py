import numpy as np


class Correlator(object):
	safe = False
	"""docstring for Correlator"""
	def __init__(self, parsers, hash_f, project_f):
		super(Correlator, self).__init__()
		self.parsers = parsers
		self.hash_f = hash_f
		self.project_f = project_f
		self.superflowHashTable = {}

	def correlate(self):
		i = 0
		for parser in self.parsers:
			for reg in parser:
				hashed_reg = self.hash_f(reg)
				if not hashed_reg in self.superflowHashTable:
					self.superflowHashTable[hashed_reg] = [0 for i in range(i)]
				self.superflowHashTable[hashed_reg].append(self.project_f(reg))
				if self.safe == True:
					for key, val in self.superflowHashTable.items():
						if len(val) != i:
							self.superflowHashTable[key].append(0)
			i += 1

		arrays = self.superflowHashTable.values()
		arrays = [a for a in arrays if len(a) == i]
		self.superflowTable = np.stack(arrays)
		return self.superflowTable

