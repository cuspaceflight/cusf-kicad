import sys
import os
import fnmatch
import datetime
import subprocess


def git_version(libpath):
    args = ["git", "describe", "--abbrev=8", "--dirty=-dirty", "--always"]
    git = subprocess.Popen(args, cwd=libpath, stdout=subprocess.PIPE)
    return git.stdout.read().decode().strip()


def main(libpath, outpath):
    version = git_version(libpath)
    outf = open(outpath, "w")

    outf.write("EESchema-LIBRARY Version 2.3\n")
    outf.write("#encoding utf-8\n\n")
    outf.write("#===================================================\n")
    outf.write("# Automatically generated by agg-kicad compilelib.py\n")
    outf.write("# on {}\n".format(datetime.datetime.now()))
    outf.write("# using git version {}\n".format(version))
    outf.write("# See github.com/adamgreig/agg-kicad\n")
    outf.write("#===================================================\n")
    outf.write("#\n\n")

    for dirpath, dirnames, files in os.walk(libpath):
        for f in fnmatch.filter(files, "*.lib"):
            with open(os.path.join(dirpath, f)) as libf:
                part = libf.readlines()[2:-1]
                outf.write("".join(part))

    outf.write("# End of library\n")

    outf.close()

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: {} <lib path> <outfile>".format(sys.argv[0]))
        sys.exit(1)
    else:
        libpath = sys.argv[1]
        outpath = sys.argv[2]
        main(libpath, outpath)