#!/usr/bin/env python3

import sys, os, pwd
from user import MyUser

from PyQt4.QtCore import QObject, QUrl, pyqtSignal, pyqtProperty, pyqtSlot, QFile
from PyQt4.QtGui import QApplication, QDesktopWidget, QIcon, QPixmap
from PyQt4.QtDeclarative import QDeclarativeView, QDeclarativeItem
from userlistitemmodel import UserItemModel
from auth import Auth

VAR_PATH = QFile("var/ubezee/locked")

def main():
	os.chdir(sys.path[0])
	app = QApplication(sys.argv)
	canvas = QDeclarativeView()
	canvas.setFixedSize(360, 500)
	canvas.setWindowTitle('Ubezee - Lock Your System')
	icon = QIcon()
	icon.addPixmap(QPixmap('qml/images/UbezeeIcon.png'), QIcon.Normal, QIcon.Off)
	canvas.setWindowIcon(QIcon(icon)) 
	qr = canvas.frameGeometry()
	cp = QDesktopWidget().availableGeometry().center()
	qr.moveCenter(cp)
	canvas.move(qr.topLeft())
	engine = canvas.engine()

	element = MyElement()
	
	engine.rootContext().setContextObject(element)
	canvas.setSource(QUrl.fromLocalFile('qml/Ubezee.qml'))
	engine.quit.connect(app.quit)
	canvas.setResizeMode(QDeclarativeView.SizeRootObjectToView)
	canvas.show()
	sys.exit(app.exec_())


class MyElement (QObject):

	hasLockChanged = pyqtSignal()
	hasLoginChanged = pyqtSignal()
	hasErrorChanged = pyqtSignal()
	hasRegisterChanged = pyqtSignal()
	varChanged = pyqtSignal()
	overlayChanged = pyqtSignal()
	
	def __init__(self, parent=None):
		super(MyElement, self).__init__()
		self.setObjectName('mainObject')
		self._users = []
		self.auth = Auth()
		self._isiPesan = ""
		self._judulPesan = "Error"
		self._overlay = "loginpage"
		#self._passOk = self.auth.check()
		self._isLock = False
		self._hasRegister = False
		self._hasLogin = False
		self._hasError = False
		self._userListData = UserItemModel()
		self._userListData.addRootElement()
		self.addNewUser()
	
	@pyqtProperty(bool, notify=hasLockChanged)
	def isLock(self):
		if (VAR_PATH.exists()):
			return True
		else:
			return False
	
	def setLock(self, lock):
		if self._hasLock != lock:
			self._hasLock = lock
			self.hasLockChanged.emit()
	
	@pyqtProperty(bool, notify=hasLoginChanged)
	def hasLogin(self):
		return self._hasLogin
	
	@pyqtProperty(str, notify=varChanged)
	def isiPesan(self):
		return self._isiPesan
	
	@pyqtProperty(str, notify=varChanged)
	def judulPesan(self):
		return self._judulPesan
	
	@pyqtProperty(str, notify=varChanged)
	def getPassword(self):
		return self.auth.get_password()
	
	@pyqtProperty(bool, notify=hasRegisterChanged)
	def hasRegister(self):
		return self.auth.check()
		#return True
	
	def setRegister(self, register):
		if self._hasRegister != register:
			self._hasRegister = register			
			self.hasRegisterChanged.emit()
	
	@pyqtSlot(str, str)
	def doRegister(self, hint, userPass):
		if self.auth.set_password(userPass, hint):
			self.setError(True, "Register Failed", "We seem to not be able to save your data, check if your keyring is run properly.")
		else:
			self.setError(True, "Password Change Succsefull", "Your password has been change and store safely.")
			self.setRegister(True)
	
	def setLogin(self, login):
		if self._hasLogin != login:
			self._hasLogin = login			
			self.hasLoginChanged.emit()
	
	@pyqtProperty(bool, notify=hasErrorChanged)
	def hasError(self):
		return self._hasError
	
	@pyqtProperty(str, notify=overlayChanged)
	def overlay(self):
		return self._overlay
	
	@pyqtSlot(str)
	def setOverlay(self, overlay):
		if self._overlay != overlay:
			self._overlay = overlay			
			self.overlayChanged.emit()
			print("changed")
	
	@pyqtSlot(bool, str, str)
	def setError(self, error, judul, isi):
		if self._hasError != error:
			self._judulPesan = judul
			self._isiPesan = isi
			self._hasError = error
			self.varChanged.emit()
			self.hasErrorChanged.emit()
		
	@pyqtProperty(QDeclarativeItem, constant=True)
	def userListData(self):
		return self._userListData
		
	@pyqtSlot(str)
	def check_pass(self, password):
		if self.auth.checkAuth(str(password)):
			self.setLogin(True)
			self.setOverlay("")
		else:
			self.setError(True, "gagal masuk", "kata kunci yang anda masukkan salah, silakan coba lagi.")
			
	def addNewUser(self):
		self.getUsers()
		for i in self._users:
			#self._userListData.addUserItem(i[0], i[5]+"/.face.icon", i[5], "realname")
			user = MyUser(i[0])
		
			self._userListData.addUserItem(user.name, 
					user.picture,
					user.address,
					user.realname)
		
	def getUsers(self):
		for users in pwd.getpwall():
			if users[2] >= 1000:
				self._users.append(users)
			
		del self._users[0]
		
		#path = r'/var/'  # remove the trailing '\'
		#data = {}
		#for dir_entry in os.listdir(path):
		#	dir_entry_path = os.path.join(path, dir_entry)
		#	if os.path.isfile(dir_entry_path):
		#		with open(dir_entry_path, 'r') as my_file:
		#			data[dir_entry] = my_file.read()
				
    #def activeLock(self):
    #    try:
    #       fileConfig1 = open("/home/kurokid/Desktop/ubezee_root", "w+")
    #    except Exception, e:
    #        print(e)
              

if __name__ == "__main__":
	main()
