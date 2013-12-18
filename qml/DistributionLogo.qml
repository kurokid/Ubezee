import QtQuick 1.0

Rectangle {
    id: distributionLogo
    width: 128
    height: 128
    state: "show"
    clip: true

    Timer {
        interval: 6000; running: true; repeat: true
        onTriggered: slideImage()
    }

    function slideImage() {
        state = Math.ceil(Math.random() * 2) == 1 ? "hide" : "show"
    }

    MouseArea {
       id: mouseArea
       anchors.fill: parent
       hoverEnabled: true
       onClicked: distributionLogo.state = "hide"
   }

   Rectangle {
        id: baseImage
        width: parent.width
        height: parent.height
        color: "#248b00"

        Image {
            anchors.fill: parent
            source: "images/TileGradient.png"
        }

        Image {
            id: mainLogo
            anchors.fill: parent
            smooth: true
            source: isLock ? "images/LockLogo.png" : "images/UnlockLogo.png" 
        }
    }

   Rectangle {
        id: distroImage
        width: parent.width
        height: parent.height
        color: "#248b00"

        Image {
            id: distroLogo
            anchors.fill: parent
            smooth: true
            source: "images/UbuntuLogo.png"
        }
    }

    states: [
        State {
            name: "show"
            PropertyChanges { target: baseImage; y: 0 }
            PropertyChanges { target: distroImage; y: 128 }
        },
        State {
            name: "hide"
            PropertyChanges { target: baseImage; y: -128 }
            PropertyChanges { target: distroImage; y: 0 }
        }]

    transitions: Transition {
        NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad; duration: 300 }
    }
}
