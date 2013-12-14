import QtQuick 1.0

Rectangle {
    id: button
    width: 150
    height: 30
    border.color: buttonEnabled ? "#248b00" : "#cccccc"
    border.width: 2
    color: buttonArea.containsMouse ? (buttonArea.pressed ? "#cccccc" : "#eeeeee") : "#ffffff"

    property bool buttonEnabled: true
    property alias label: textLabel.text
    signal clicked()

    SText {
        id: textLabel
        anchors.fill: parent
        color: buttonEnabled ? "#248b00" : "#cccccc"
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        font.pixelSize: 12
    }

    MouseArea {
        id: buttonArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: button.buttonEnabled
        onClicked: button.clicked();
    }
}
