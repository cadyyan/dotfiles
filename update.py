#!/usr/bin/env python

import os
import re
import subprocess

def main():
	# Find all the git submodules.
	submodules = []
	with open('.gitmodules', 'r') as gitmodules_fh:
		for line in gitmodules_fh.readlines():
			match = re.match(r'\[submodule \"(.*?)\"\]', line)
			if not match:
				continue

			submodules.append(match.group(1))

	def split_cmd(cmd):
		return cmd.split(' ')

	cwd = os.path.abspath('.')
	for submodule in submodules:
		print 'Updating {}...'.format(submodule)

		os.chdir(submodule)

		for cmd in [split_cmd('git checkout master'), split_cmd('git pull'), split_cmd('git submodule update --init')]:
			proc = subprocess.Popen(cmd)
			proc.communicate()

		os.chdir(cwd)

if __name__ == '__main__':
	main()

