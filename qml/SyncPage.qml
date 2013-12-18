import QtQuick 1.0

Rectangle {
    id: syncPage
    color: "#ffffff"

    signal back()
    signal showTextPage()

    function setDestinationFocus() {
        destinationText.focus = true;
    }

    MouseArea {
        anchors.fill: parent
    }

    Image {
        id: backIcon
        source: "images/BackIconDark.png"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 5

        MouseArea {
            anchors.fill: parent
            onClicked: syncPage.back();
        }
    }

    SmoothText {
        id: boxTitle
        anchors.left: backIcon.right
        anchors.top: parent.top
        anchors.leftMargin: 15
        anchors.topMargin: 5
        font.pixelSize: 64
        text: "Mode Lanjutan"
        color: "#4cb328"
    }

	SText {
        id: localBuddy
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: backIcon.bottom
        anchors.topMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 30
        font.pixelSize: 14
        color: "#888888"
        wrapMode: "WordWrap"
        text: "Semua yang dilakukan disini akan ditulis ke dalam hardisk. Pikir dahulu sebelum melakukan perubahan apapun."
    }

    SText {
        id: labelAction
        anchors.left: localBuddy.left
        anchors.top: localBuddy.bottom
        anchors.topMargin: 35
        font.pixelSize: 17
        color: "#555555"
        text: "Apa yang ingin anda lakukan?"
    }

    ButtonDark {
        id: buttonSendText
        anchors.top: labelAction.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        //buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: "Tulis semua perubahan pada folder $HOME"
        //onClicked: sendPage.showTextPage();
    }

    ButtonDark {
        id: buttonSendFiles
        anchors.top: buttonSendText.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        //buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: "Tulis perubahan pada sistem"
        //onClicked: guiBehind.sendSomeFiles()
    }

    ButtonDark {
        id: buttonSendFolder
        anchors.top: buttonSendFiles.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        //buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: "Jalankan aplikasi terminal emulator"
        //onClicked: guiBehind.sendFolder()
    }
    
    ButtonDark {
        id: buttonSendScreen
        anchors.top: buttonSendFolder.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        //buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: "Jalankan suatu program"
        onClicked: guiBehind.sendScreen()
    }
}
