import QtQuick 1.0

Rectangle {
    id: loginPage
    color: "#ffffff"

    SmoothText {
        id: boxTitle
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 15
        anchors.topMargin: 5
        font.pixelSize: 64
        text: "Otorisasi"
        color: "#4cb328"
    }

    Rectangle {
        anchors.top: boxTitle.bottom
        anchors.topMargin: -25
        color: "#248b00"
        width: parent.width
        height: 2
    }

    Rectangle {
        id: loginForm
        width: parent.width
        height: 100
        anchors.centerIn: parent

        Rectangle {
            id: imageRec
            width: 128
            height: 128
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "#248b00"
            Image {
                anchors.fill: parent
                source: "images/TileGradient.png"
            }

		    Image {
				id: rect
				source: "images/ubezee.png"
				transform: Rotation { origin.x: 30; origin.y: 30; axis { x: 0; y: 1; z: 0 } angle: 18 }
				smooth: true
		    }
		    
		    RotationAnimation {
				id: rotationAnimation
				running: true
				from: 0
				to: -360
				duration: 6000
				loops: Animation.Infinite
				target: rect
				property: "rotation"
		    }
		}

        SText {
		    anchors.left: imageRec.right
		    anchors.right: parent.right
		    anchors.bottom: txtPass.top
		    anchors.leftMargin: 10
		    anchors.rightMargin: 20
		    anchors.bottomMargin: 20
		    font.pixelSize: 16
		    wrapMode: TextEdit.Wrap
		    text: "<b>harap masukkan kata kunci untuk melanjutkan ke menu konfigurasi.</b>"
		    color: "#888888"
		}
	
		TextBox {
			id: txtPass
		    anchors.left: imageRec.right
		    anchors.right: parent.right
		    anchors.bottom: imageRec.bottom
		    anchors.leftMargin: 10
		    anchors.rightMargin: 20
		    placeHolder: 'masukkan kata kunci...'
        	charTampil: false
		}
    }

	HelpBox {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 100
    }
    
    ButtonDark {
        id: buttonOk
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        buttonEnabled: true
        label: "ok"
        onClicked: {
            check_pass(txtPass.isi);
        }
    }
    
    ButtonDark {
        id: buttonClose
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        buttonEnabled: true
        label: "keluar"
        onClicked: Qt.quit();
    }
}
