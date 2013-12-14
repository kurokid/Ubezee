import keyring, hashlib, uuid

class Auth():
	def __init__(self):
		self.password = keyring.get_password("org.kurokid.ubezee", "administrator")
		self.token = keyring.get_password("org.kurokid.ubezee", "user")
		self.error = False
		
	def check(self):
		if (self.password == None or '') and (self.password == None or ''):
			return False
		else:
			return True

	def get_password(self):
		password = self.password = keyring.get_password("org.kurokid.ubezee", "administrator")
		self.token = keyring.get_password("org.kurokid.ubezee", "user")
		return password
	
	def getStatus(self):
		return self.error
		
	def setItem(self, user, item):
		try:
			keyring.set_password("org.kurokid.ubezee", user, item)
		except keyring.backend.PasswordSetError:
			self.error = True
		self.get_password()
			
	def set_password(self, newPassword, hint):
		self.setItem("user", uuid.uuid4().hex)
		self.setItem("administrator", self.hash_password(newPassword))
		self.setItem("hint", hint)

	def hash_password(self, password):
		return hashlib.sha256(self.token.encode() + password.encode()).hexdigest() + ':' + self.token
		
	def checkAuth(self, input_password):
		password, self.token = self.password.split(':')
		return password == hashlib.sha256(self.token.encode() + input_password.encode()).hexdigest()
