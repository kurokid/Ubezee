import QtQuick 1.0

Rectangle {
    id: switchControl
    width: 80
    height: 30
    border.color: switchEnabled ? "#cccccc" : "red"
    border.width: 2
    state: "off"
    property bool switchEnabled: true
    property bool toggleSwitch: false
    signal clicked()

    Rectangle {
        id: switchColor
        anchors.margins: 4
        anchors.fill: parent
        color: switchControl.toggleSwitch ? "#248b00" : "#cccccc"
    }

    MouseArea {
        id: buttonArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: switchControl.switchEnabled
        onClicked: {
            switchControl.state = switchControl.toggleSwitch ? "off" : "on"
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
            PropertyChanges { target: switchControl; toggleSwitch: true }
        },
        State {
            name: "off"
            PropertyChanges { target: switchButton; x: 1 }
            PropertyChanges { target: switchControl; toggleSwitch: false }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
    }

}


    
