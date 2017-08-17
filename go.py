#!/usr/bin/env python

def invoke(invocation):
	import subprocess
	subprocess.check_call(invocation, shell=True)

import argparse
parser=argparse.ArgumentParser()
parser.add_argument('--build', '-b', action='store_true')
args=parser.parse_args()

if args.build:
	invoke('mix deps.get')
	invoke('mix deps.compile')
