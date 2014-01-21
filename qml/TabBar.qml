import QtQuick 1.0

Item {
    id: tabBar
    height: 65
    state: "general"

    signal clicked(string tab)

    Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        SmoothText {
            id: generalText
            x: 10
            font.pixelSize: 84
            text: "ubezee"
            transformOrigin: Item.TopLeft
            color: generalTextMouseArea.containsMouse ? myColor2 : "#cccccc"
            scale: 0.5

            MouseArea {
                id: generalTextMouseArea
                anchors.fill: parent;
                hoverEnabled: true;
                onClicked: {
                    tabBar.state = "general";
                    tabBar.clicked("general");
                }
            }
        }

        SmoothText {
            id: userText
            x: 160
            font.pixelSize: 84
            text: "pengguna"
            transformOrigin: Item.TopLeft
            color: userTextMouseArea.containsMouse ? myColor2 : "#cccccc"
            scale: 0.5

            MouseArea {
                id: userTextMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    tabBar.state = "users";
                    tabBar.clicked("users");
                }
            }
        }

        SmoothText {
            id: aboutText
            x: 360
            font.pixelSize: 84
            color: aboutTextMouseArea.containsMouse ? myColor2 : "#cccccc"
            text: "tentang"
            MouseArea {
                id: aboutTextMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    tabBar.state = "about";
                    tabBar.clicked("about");
                }
            }
        }
    }
    states: [
        State {
            name: "general"

            PropertyChanges {
                target: generalText
                color: myColor1 // "#000000"
            }
        },
        State {
            name: "users"

            PropertyChanges {
                target: generalText
                x: -55
            }

            PropertyChanges {
                target: userText
                x: 97
                color: myColor1 // "#000000"
            }

            PropertyChanges {
                target: aboutText
                x: 295
            }
        },
        State {
            name: "about"

            PropertyChanges {
                target: generalText
                x: -130
            }

            PropertyChanges {
                target: userText
                x: 22
            }

            PropertyChanges {
                target: aboutText
                x: 220
                color: myColor1 // "#000000"
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuart; duration: 1000 }
            ColorAnimation  { duration: 300 }
        }
    ]
}
