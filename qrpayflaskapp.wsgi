activate_this = '/home/codio/workspace/QRPayFlaskApp/QRPayFlaskApp/venv/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))
#!/usr/bin/python
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/home/codio/workspace/QRPayFlaskApp/")


from QRPayFlaskApp import app as application
application.secret_key = 'Add your secret key'