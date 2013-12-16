import os, hashlib, uuid

LOGIN_PATH = "/etc/ubezee/LOGIN"
TOKEN_PATH = "/var/ubezee/TOKEN"
HINT_PATH = "/var/ubezee/HINT"

class Auth():
	def __init__(self):
		if not os.path.isfile(LOGIN_PATH):
			open(LOGIN_PATH, 'w').close()
		if not os.path.isfile(TOKEN_PATH):
			open(TOKEN_PATH, 'w').close() 
		
		self.password = ""
		self.token = ""
		self.error = False
		
	def check(self):
		if self.get_password() and self.get_token():
			return True
		else:
			return False

	def get_password(self):
		LOGIN_FILE = open(LOGIN_PATH, 'r')
		self.password = LOGIN_FILE.read()
		LOGIN_FILE.close()
		return self.password
	
	def get_token(self):
		TOKEN_FILE = open(TOKEN_PATH, 'r')
		self.token = TOKEN_FILE.read()
		TOKEN_FILE.close()
		return self.token
	#def getStatus(self):
	#	return self.error
		
	def setItem(self, alamat, isi):
		try:
			f = open(alamat, "w")
			f.write(isi)
		except IOError:
			self.error = True
		f.close()
			
	def set_password(self, newPassword, hint):
		self.setItem(TOKEN_PATH, uuid.uuid4().hex)
		self.setItem(LOGIN_PATH, self.hash_password(newPassword))
		self.setItem(HINT_PATH, hint)

	def hash_password(self, password):
		self.check()
		return hashlib.sha256(self.token.encode() + password.encode()).hexdigest() + ':' + self.token
		
	def checkAuth(self, input_password):
		password, self.token = self.password.split(':')
		return password == hashlib.sha256(self.token.encode() + input_password.encode()).hexdigest()
