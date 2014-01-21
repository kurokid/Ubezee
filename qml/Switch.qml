import QtQuick 1.0

Rectangle {
    id: switchControl
    width: 80
    height: 30
    border.color: switchEnabled ? "#cccccc" : "red"
    border.width: 2
    property bool switchEnabled: true
    property bool switchOn: false
    state: switchOn ? "on" : "off"
    signal clicked()

    Rectangle {
        id: switchColor
        anchors.margins: 4
        anchors.fill: parent
        color: switchControl.state == "on" ? myColor1 : "#cccccc"
    }

    MouseArea {
        id: buttonArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: switchControl.switchEnabled
        onClicked: {
	    console.log(isLock)
            switchControl.state = switchControl.state == "on" ? "off" : "on"
        }
    }
        
    Rectangle {
        id: switchButton
        width: 20
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "black"
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: switchButton; x: 60 }
        },
        State {
            name: "off"
            PropertyChanges { target: switchButton; x: 1 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
    }

}


    
