#!/usr/bin/env python

import sys, keyring, os, pwd
from user import MyUser

from PyQt4.QtCore import QObject, QUrl, pyqtSignal, pyqtProperty, pyqtSlot, Qt, QFile, QString
from PyQt4.QtGui import QApplication
from PyQt4.QtDeclarative import QDeclarativeView, QDeclarativeItem
from userlistitemmodel import UserItemModel

VAR_PATH = QFile("var/ubezee/locked")

def main():
	os.chdir(sys.path[0])
	app = QApplication(sys.argv)
	canvas = QDeclarativeView()
	canvas.setWindowFlags(Qt.FramelessWindowHint)
	canvas.setFixedSize(360, 500)
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
	
	def __init__(self, parent=None):
		super(MyElement, self).__init__()
		self.setObjectName('mainObject')
		self._users = []
		self._isLock = False
		self._hasLogin = False
		self._hasError = False
		self._userListData = UserItemModel()
		self.password = keyring.get_password('Ubezee','admin')
		self._userListData.addRootElement()
		self.addNewUser()
	
	@pyqtProperty(bool, notify=hasLockChanged)
	def isLock(self):
		if (VAR_PATH.exists()):
			return True
		else:
			return False
		fi
	
	def setLock(self, lock):
		if self._hasLock != lock:
			self._hasLock = lock
			self.hasLockChanged.emit()
	
	@pyqtProperty(bool, notify=hasLoginChanged)
	def hasLogin(self):
		return self._hasLogin
	
	def setLogin(self, login):
		if self._hasLogin != login:
			self._hasLogin = login
			print("login")			
			self.hasLoginChanged.emit()
	
	@pyqtProperty(bool, notify=hasErrorChanged)
	def hasError(self):
		return self._hasError
	
	@pyqtSlot(bool)
	def setError(self, error):
		if self._hasError != error:
			self._hasError = error
			self.hasErrorChanged.emit()
		
	@pyqtProperty(QDeclarativeItem, constant=True)
	def userListData(self):
		return self._userListData
		
	@pyqtSlot(str)
	def check_pass(self, password):
		if (password == QString(self.password)):
			self.setLogin(True)
		else:
			self.setError(True)
			
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
		
		path = r'/var/'  # remove the trailing '\'
		data = {}
		for dir_entry in os.listdir(path):
			dir_entry_path = os.path.join(path, dir_entry)
			if os.path.isfile(dir_entry_path):
				with open(dir_entry_path, 'r') as my_file:
					data[dir_entry] = my_file.read()
				
    #def activeLock(self):
    #    try:
    #       fileConfig1 = open("/home/kurokid/Desktop/ubezee_root", "w+")
    #    except Exception, e:
    #        print(e)
              

if __name__ == "__main__":
	main()
