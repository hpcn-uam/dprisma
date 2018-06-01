import argparse
from multiHop.correlators import Correlator
import numpy as np

def hash_f(reg):
	split = reg.split(', ')
	return str(split[0:4])

def project_f(reg):
	return float(reg.split(', ')[4][:-1])
    
def main():
	parser = argparse.ArgumentParser(description='Create a superflow file. WARNING: really slow algorithm')
	parser.add_argument('files', help='Files to be processed', metavar='N', nargs='+')
	parser.add_argument('-o', '--output', required=True)
	args = parser.parse_args()
	print(args)
	parsers = []
	for file in args.files:
		f = open(file, 'r')
		parsers.append(f)
		

	corr = Correlator(parsers, hash_f, project_f)
	X = corr.correlate()
	np.savetxt(args.output, X)




if __name__ == '__main__':
	main()