from PyQt4.QtGui import QStandardItemModel, QStandardItem
from PyQt4.QtCore import QString
from user import MyUser

class UserItemModel(QStandardItemModel):

	username, userPicture, address, realname = range(4)

	def __init__(self):
		QStandardItemModel.__init__(self)
		role_names = {
			self.username: "username",
			self.userPicture: "userPicture",
			self.address: "address",
			self.realname: "realname"
		}
		self.setRoleNames(role_names)

	def addRootElement(self):
		root = MyUser('root')
		
		self.addUserItem(root.name, 
				root.picture,
				root.address,
				root.realname)

	def addUserItem(self, username, userPicture, address, realname):
		self.item = QStandardItem()
		self.item.setData(QString(username), self.username)
		self.item.setData(QString(userPicture), self.userPicture)
		self.item.setData(QString(address), self.address)
		self.item.setData(QString(realname), self.realname)
		self.appendRow(self.item)