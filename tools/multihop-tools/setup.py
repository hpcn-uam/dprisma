from setuptools import setup

setup(name='multiHop',
	version='0.1',
	description='multiHop tools',
	author='Daniel Perdices',
	author_email='daniel.perdices@naudit.es',
	license='ISC',
	packages=['multiHop', 'multiHopTools', 'multiHop.distributions'],
	scripts=['multiHopTools/distributionEstimator.py', 'multiHopTools/multiFlowCorrelator.py', 'multiHopTools/distributionEstimatorBootstrap.py'],
	entry_points = {
	'console_scripts': ['multiflowCorrelator=multiHopTools.multiFlowCorrelator:main',
	'distributionEstimator=multiHopTools.distributionEstimator:main'],
	},
	install_requires=[
        "scipy"
    ],
    dependency_links=[
        "git+https://github.com/bsdz/scipy.git"
    ],
	zip_safe=False)
