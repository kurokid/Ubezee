import QtQuick 1.0

Rectangle {
    id: descrpImage
    width: 128
    height: 128
    state: mouseArea.containsMouse ? "showDesc" : "hideDesc"
    clip: true
    
    //property alias image: buddyOsLogoImage.source
    //property alias buddyOsLogo: buddyOsLogoImage.source

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
   }

   Rectangle {
        id: firstSlide
        color: "#248b00"
        width: parent.width
        height: parent.height

        Image {
        	id: baseImage
            anchors.fill: parent
            source: "images/TileGradient.png"
        }

        Image {
            id: mainImage
            anchors.fill: parent
            smooth: true
            source: "images/LockLogo.png"
        }
    }
    
    Rectangle {
    	id: secondSlide
        width: parent.width
        height: parent.height
        color: "#248b00"

        Image {
            id: secondImage
            anchors.fill: parent
            smooth: true
            source: "images/UbuntuLogo.png"
        }
    }
    
    Rectangle {
        id: descriptor
        width: 128
        height: 128/2
        color: "transparent"
        
        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: 0.5
        }

        Rectangle {
            anchors.top: parent.top
            width: parent.width
            height: 2
            color: "white"
        }

        SText {
            anchors.fill: parent
            anchors.margins: 10
            text: "Turn on to lock your Ubuntu System."
            font.pixelSize: 12
            wrapMode: "WordWrap"
        }
    }

    states: [
        State {
            name: "show"
            PropertyChanges { target: firstSlide; y: 0 }
            PropertyChanges { target: secondSlide; y: 128 }
        },
        State {
            name: "hide"
            PropertyChanges { target: firstSlide; y: -128 }
            PropertyChanges { target: secondSlide; y: 0 }
        },
        State {
            name: "showDesc"
            PropertyChanges { target: descriptor; y: 64 }
        },
        State {
            name: "hideDesc"
            PropertyChanges { target: descriptor; y: 128 }
        }]

    transitions: Transition {
        NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad; duration: 300 }
    }
}
