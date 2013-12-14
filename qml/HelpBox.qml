import QtQuick 1.0

Item {
    id: box
    width: 180
    height: 55
    clip: true
    state: "hidden"

    Rectangle {
        id: backRecangle
        color: "#248b00"
        height: parent.height
        width: parent.width
        
        Image {
			anchors.fill: parent
			source: "images/TileGradient.png"
		}
	        
		Image {
			id: helpImage
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.leftMargin: 10
			source: "images/HelpIcon.png"
			
			MouseArea {
				anchors.fill: parent
				onClicked: box.state = box.state == "showed" ? "hidden" : "showed"
			}
		}
		
        SText {
            anchors.left: helpImage.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            font.pixelSize: 14
            text: "Forget Password?"
            
            MouseArea {
				anchors.fill: parent
				onClicked: console.log("aa")
			}
        }

        Behavior on x { NumberAnimation { duration: 500; easing.type: "OutCubic" } }
    }
    states: [
        State {
            name: "hidden"

            PropertyChanges {
                target: backRecangle
                x: box.width - 60
            }
        },
        State {
            name: "showed"

            PropertyChanges {
                target: backRecangle
                x: 0
            }
        }
    ]
}
