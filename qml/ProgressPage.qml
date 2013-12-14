import QtQuick 1.0

Rectangle {
    id: progressPage
    color: "#00000000"

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        height: 200

        Rectangle {
            id: backRecangle
            color: "#248b00"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 600
        }

        Image {
            source: "images/BottomShadow.png"
            anchors.bottom: backRecangle.top
            anchors.left: backRecangle.left
            anchors.right: backRecangle.right
            fillMode: Image.TileHorizontally
        }

        Image {
            source: "images/TopShadow.png"
            anchors.top: backRecangle.bottom
            anchors.left: backRecangle.left
            anchors.right: backRecangle.right
            fillMode: Image.TileHorizontally
        }

        Image {
            anchors.top: parent.top
            anchors.left: parent.left
            source: "images/PanelGradient.png"
        }

        SmoothText {
            id: boxTitle
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 15
            anchors.topMargin: 5
            font.pixelSize: 64
            //text: guiBehind.currentTransferSending ? "Sending data" : "Receiving data"
        }

        SText {
            id: boxSender
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 17
            anchors.right: progressBar.right
            anchors.topMargin: 45
            elide: "ElideRight"
            font.pixelSize: 16
            //text: (guiBehind.currentTransferSending ? "to " : "from ") + guiBehind.currentTransferBuddy
        }

        Rectangle {
            id: progressBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: boxSender.bottom
            anchors.leftMargin: 17
            anchors.rightMargin: 17
            anchors.topMargin: 25
            color: "#4cb328"
            height: 40

            Rectangle {
                id: progressFiller
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                color: "#ffffff"
                //width: parent.width * guiBehind.currentTransferProgress / 100;
            }
        }

        Button {
            id: abortButton
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 17
            anchors.bottomMargin: 17
            width: 75
            label: "Abort"
            onClicked: guiBehind.abortTransfer()
            //visible: guiBehind.currentTransferSending
        }

        SText {
            id: statusText
            anchors.left: parent.left
            anchors.right: abortButton.left
            anchors.verticalCenter: abortButton.verticalCenter
            anchors.leftMargin: 17
            anchors.rightMargin: 17            
            font.pixelSize: 17
            elide: "ElideRight"
            //text: guiBehind.currentTransferStats
        }
    }
}
