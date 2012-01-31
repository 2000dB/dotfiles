import sys
import os
import subprocess
import fnmatch

dotfiles = "./"
home = "../"

if __name__ == "__main__" :
    """ Check target path """
    if len(sys.argv) == 2:
        if(os.path.exists(sys.argv[1])):
            home = sys.argv[1]
        else:
            print "invalid path: " + sys.argv[1]
            sys.exit(-1)

    filelist = os.listdir(dotfiles)
    for f in filelist:
        if not fnmatch.fnmatch(f, "*.py"):
            try:
                print "linking " + f
                subprocess.call(["ln", "-s", f, home+f])
            except:
                print "error linking: " + f

    print "done"
    sys.exit(1)

