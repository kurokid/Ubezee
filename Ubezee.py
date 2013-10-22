import sys,keyring

from PyQt4.QtCore import QObject, QUrl, pyqtSignal
from PyQt4.QtGui import QApplication
from PyQt4.QtDeclarative import QDeclarativeView

app = QApplication(sys.argv)
passWord = keyring.get_password('Ubezee','admin')

def check_pass(password):
    if (password == passWord):
        rootObject.loginPass("ok")
    else:
        rootObject.loginPass("error")

# Create the QML user interface.
view = QDeclarativeView()
view.setSource(QUrl('qml/Ubezee.qml'))
view.setResizeMode(QDeclarativeView.SizeRootObjectToView)

rootObject = view.rootObject()
rootObject.passRequired.connect(check_pass)
#rootObject.loginPage.checkNow.connect()
view.show()
app.exec_()
