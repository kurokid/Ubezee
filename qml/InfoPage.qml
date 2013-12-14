import QtQuick 1.0

Rectangle {
    id: infoPage
    color: "#00000000"
    
    signal back()

    Item {
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

        Image {
            id: backIcon
            source: "images/BackIcon.png"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 5
            anchors.leftMargin: 5

            MouseArea {
                anchors.fill: parent
                onClicked: {
                	infoPage.back();
                }
            }
        }

        SmoothText {
            id: msgTitle
            anchors.left: backIcon.right
            anchors.top: parent.top
            anchors.leftMargin: 15
            anchors.topMargin: 5
            font.pixelSize: 64
            //text: "Wrong Password!"
            text: judulPesan
        }

        Flickable {
            id: flick
            anchors.top: backIcon.bottom
            anchors.left: msgTitle.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
            anchors.bottomMargin: 10
            contentWidth: message.paintedWidth
            contentHeight: message.paintedHeight
            clip: true

            SText {
                id: message
                width: flick.width - 10
                height: flick.height
                //text: "Please provide your Ubezee password. If you forget your password, you can try change it by boot to safe mode."
                text: isiPesan
                wrapMode: TextEdit.Wrap
                font.pixelSize: 13
            }
        }
    }
}
