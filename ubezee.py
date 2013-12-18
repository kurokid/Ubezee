#!/usr/bin/python3
# -*- coding: utf-8 -*-

import sys, os, pwd
from user import MyUser

from PyQt4.QtCore import QObject, QUrl, pyqtSignal, pyqtProperty, pyqtSlot, QProcess, QModelIndex, Qt
from PyQt4.QtGui import QApplication, QDesktopWidget, QIcon, QPixmap, QStandardItemModel
from PyQt4.QtDeclarative import QDeclarativeView
from userlistitemmodel import UserItemModel
from auth import Auth

VAR_PATH = "/var/ubezee"
CONFIG_PATH = "/etc/ubezee"

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
		self._index = 0
		self.mainProc = QProcess()
		self.secondProc = QProcess()
		self.mainProc.finished.connect(self.finishProc)
		self.mainProc.started.connect(self.startProc)
		self.secondProc.finished.connect(self.secondFinishProc)
		self.secondProc.started.connect(self.startProc)
		self.auth = Auth()
		self._isiPesan = ""
		self._judulPesan = "Error"
		self._overlay = ""
		self._isLock = False
		self._hasRegister = False
		self._hasLogin = False
		self._hasError = False
		self._userListData = UserItemModel()
		self._userListData.addRootElement()
		self.addNewUser()
	
	@pyqtProperty(bool, notify=hasLockChanged)
	def isLock(self):
		return os.path.isfile("/var/ubezee/LOCKED")
		
	def finishProc(self, exitCode):
		if not exitCode:
			self.setError(True, "Proses Berhasil", "Proses buka/tutup kunci telah berhasil, silakan hidupkan ulang komputer anda untuk mengimplementasikan penguncian.")
			self._overlay = ""
			self.hasLockChanged.emit()
		else:
			self.setError(True, "Proses Gagal", "Terjadi kesalahan saat akan melakukan proses buka/tutup kunci, silakan coba lagi.")

	def secondFinishProc(self, exitCode):
		if not exitCode:
			self.setError(True, "Proses Berhasil", "Proses buka/tutup kunci pada pengguna telah berhasil, silakan hidupkan ulang komputer anda untuk mengimplementasikan penguncian.")
			self._overlay = ""
			h = self._userListData.index(self._index, 0)
			if self._userListData.itemFromIndex(h).data(5):
				self._userListData.itemFromIndex(h).setData(False, 5)
			else:
				self._userListData.itemFromIndex(h).setData(True, 5)
		else:
			self.setError(True, "Proses Gagal", "Terjadi kesalahan saat akan melakukan proses buka/tutup kunci, silakan coba lagi.")

		
	def startProc(self):
		self.setInfo("Harap Tunggu", "Proses buka/tutup pengunci sistem sedang berlangsung, mohon tunggu sebentar...")
		self.setOverlay("loading")
		
	@pyqtSlot(bool)
	def changeLock(self, todo):
		if todo:
			self.mainProc.start("bash locker.sh -l sistem")
		else:
			self.mainProc.start("bash locker.sh -u sistem")
			
	@pyqtSlot(int, str, bool)
	def lockUser(self, index, nama, locked):
		self._index = index
		if not locked:
			self.secondProc.start("bash locker.sh -l %s" % nama)
		else:
			self.secondProc.start("bash locker.sh -u %s" % nama)
			#h.setData("asdasdad", 1)
			#self.userListData.appendRow(h)
			#for item in self._userListData.findItems("kurokid"):
			#	self._userListData.removeRow(item.row())
	
	@pyqtProperty(bool, notify=hasLoginChanged)
	def hasLogin(self):
		return self._hasLogin
	
	@pyqtProperty(str, notify=varChanged)
	def isiPesan(self):
		return self._isiPesan
	
	@pyqtSlot(str, str)
	def setInfo(self, judul,isi):
		if self._isiPesan != isi:
			self._isiPesan = isi
		if self._judulPesan != judul:
			self._judulPesan = judul
		self.varChanged.emit()
	
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
		self._overlay = overlay			
		self.overlayChanged.emit()
		print(self._overlay)
	
	@pyqtSlot(bool, str, str)
	def setError(self, error, judul, isi):
		if self._hasError != error:
			self.setInfo(judul, isi)
			self._hasError = error
			self.hasErrorChanged.emit()
		
	@pyqtProperty(QStandardItemModel, constant=True)
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
					user.realname,
					user.locked)
		
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

if __name__ == "__main__":
	os.chdir(sys.path[0])
	if not os.path.exists(CONFIG_PATH):
		os.makedirs(CONFIG_PATH)
	if not os.path.exists(VAR_PATH):
		os.makedirs(VAR_PATH)
	main()
