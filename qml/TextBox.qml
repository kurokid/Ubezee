import QtQuick 1.0

FocusScope {
    id: focusScope
    height: textBoxHeight
	property int fontSize: focusScope.height -30
    property int textBoxHeight: 25
    property string placeHolder
    property string isi : textInput.text
    property bool isUserInTheMiddleOfEntringText: false
    property bool charTampil: true
    property bool limitChar: false
    
    Rectangle {
		id: box
        border.color: textInput.activeFocus ? myColor2 : "#888888" 
		border.width: 2
		width: parent.width
        height: parent.height
        radius: 0
        MouseArea {
            anchors.fill: parent
            onClicked: {
                focusScope.focus = true
            }
        }
    }
    Text {
        id: typeSomething
        opacity: 0.8
        font.pixelSize: 14
        smooth: true
    	font.family: ubezeefont.name
        anchors.fill: parent; anchors.rightMargin: 8
        anchors.leftMargin: 8
        verticalAlignment: Text.AlignVCenter
        text: placeHolder
        color: "#888888"
        font.pointSize: fontSize
        MouseArea {
            anchors.fill: parent
            onClicked: {
                focusScope.focus = true
            }
        }

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            focusScope.focus = true
        }
    }

    TextInput {
        id: textInput
        anchors {
            rightMargin: 8
            left: box.left
            leftMargin: 8
            verticalCenter: parent.verticalCenter
        }
        smooth: true
    	font.family: ubezeefont.name
        font.pixelSize: 14
		color: "#888888"
		echoMode: charTampil ? TextInput.Normal : TextInput.Password
        focus: true
        selectByMouse: true
        font.pointSize: fontSize
    }

    Image {
        id: clear
        width: 25
        height: 25
        opacity: 0
        visible: true
        source: "images/CloseIconGray.png"
        anchors {
            right: box.right
            rightMargin: 8
            verticalCenter: parent.verticalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                textInput.text = ''
                focusScope.focus = true;
            }
        }
    }

    states: State {
        name: 'hasText'; when: textInput.text != ''
        PropertyChanges {
            target: typeSomething
            opacity: 0
        }
        PropertyChanges {
            target: clear
            opacity: 0.5
        }
    }

    transitions: [
        Transition {
            from: ''; to: 'hasText'
            NumberAnimation {
                exclude: typeSomething
                properties: 'opacity'
            }
        },
        Transition {
            from: 'hasText'; to: ''
            NumberAnimation {
                properties: 'opacity'
            }
        }
    ]
}
