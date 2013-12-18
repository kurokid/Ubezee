from PyQt4.QtGui import QStandardItemModel, QStandardItem
from user import MyUser

class UserItemModel(QStandardItemModel):

	foo, nama, userPicture, address, realname, locked = range(6)

	def __init__(self):
		QStandardItemModel.__init__(self)
		role_names = {
			self.foo: "",
			self.nama: "nama",
			self.userPicture: "userpicture",
			self.address: "address",
			self.realname: "realname",
			self.locked: "locked"
		}
		self.setRoleNames(role_names)

	def addRootElement(self):
		root = MyUser('root')
		self.addUserItem(root.name, 
				root.picture,
				root.address,
				root.realname,
				root.locked)

	def addUserItem(self, username, userPicture, address, realname, locked, foo = ""):
		self.item = QStandardItem()
		self.item.setData(username, self.nama)
		self.item.setData(userPicture, self.userPicture)
		self.item.setData(address, self.address)
		self.item.setData(realname, self.realname)
		self.item.setData(locked, self.locked)
		self.appendRow(self.item)
