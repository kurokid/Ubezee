#!/usr/bin/python

from PyQt4.QtGui import QStandardItemModel, QStandardItem
from PyQt4.QtCore import QString

class UserItemModel(QStandardItemModel):
    
    username, userPicture = range(2)

    def __init__(self):
        QStandardItemModel.__init__(self)
        role_names = {
            self.username: "username",
            self.userPicture: "userPicture"
        }
        self.setRoleNames(role_names)
                

    def addRootElement(self):
        self.addUserItem("root", 
                        "images/RootLogo.png")
        self.addUserItem("root", 
                        "images/PcLogo.png")
    
    def addUserItem(self, username, userPicture):
        self.item = QStandardItem()
        self.item.setData(username, self.username)
        self.item.setData(userPicture, self.userPicture)
        self.appendRow(self.item)

if __name__ == "__main__":
    test = UserItemModel()