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

        SmoothText {
            id: msgTitle
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 25
            anchors.topMargin: 5
            font.pixelSize: 64
            //text: "Harap Tunggu"
            text: judulPesan
        }

        Flickable {
            id: flick
            anchors.top: msgTitle.bottom
            anchors.left: msgTitle.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: -20
            anchors.bottomMargin: 10
            contentWidth: message.paintedWidth
            contentHeight: message.paintedHeight
            clip: true

			AnimatedImage { 
				id: animation
				anchors.right: parent.right
				anchors.rightMargin: 130
				source: "images/Preloader.gif"
			}
		     
            SText {
                id: message
                anchors.top: animation.bottom
                anchors.topMargin: 20
                width: flick.width - 10
                height: flick.height
                //text: "Proses buka/tutup kunci sedang berlangsung, tolong tunggu sebentar."
                text: isiPesan
                wrapMode: TextEdit.Wrap
                font.pixelSize: 15
            }
        }
    }
}
