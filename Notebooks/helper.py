import os
import sys

path = os.path.abspath(os.path.join(os.getcwd(), '..', "src"))
if not path in sys.path:
    sys.path.insert(1, path)
del path
