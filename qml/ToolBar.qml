import QtQuick 1.0

Item {
    id: toolBar
    height: 71
    anchors.bottomMargin: -18
    state: "WithoutLabels"

    signal clicked(string command)

    Behavior on anchors.bottomMargin { NumberAnimation { duration: 200; easing.type: "OutCubic" } }

    Image {
        source: "images/BottomShadow.png"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        fillMode: Image.TileHorizontally
    }

    Rectangle {
        y: 3
        anchors.left: parent.left
        anchors.right: parent.right
        height: 68
        color: myColor1

        Image {
            anchors.top: parent.top
            anchors.left: parent.left
            source: "images/PanelGradient.png"
        }

        Image {
            id: unlockIcon
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: configIcon.left
            anchors.rightMargin: 40
            source: "images/UnlockIcon.png"

            MouseArea {
                anchors.fill: parent
                onClicked: setOverlay("sync")
            }
        }
        SText {
            anchors.top: unlockIcon.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: unlockIcon.horizontalCenter
            text: "buka sementara"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            width: 1
        }

        Image {
            id: configIcon
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/ConfigIcon.png"

            MouseArea {
                anchors.fill: parent
                onClicked: setOverlay("settings")
            }
        }
        SText {
            anchors.top: configIcon.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: configIcon.horizontalCenter
            text: "konfigurasi"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            width: 1
        }

        Image {
            id: closeIcon
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: configIcon.right
            anchors.leftMargin: 40
            source: "images/CloseIcon.png"

            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }
        SText {
            anchors.top: closeIcon.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: closeIcon.horizontalCenter
            text: "keluar"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            width: 1
        }

        Image {
            id: moreIcon
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.right: parent.right
            anchors.rightMargin: 12
            source: "images/MoreIcon.png"
        }
        MouseArea {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: moreIcon.left
            anchors.right: parent.right

            onClicked: {
               if (toolBar.state == "WithoutLabels")
                   toolBar.state = "WithLabels";
               else
                   toolBar.state = "WithoutLabels";
           }
        }
    }

    states: [
        State {
            name: "WithoutLabels"

            PropertyChanges {
                target: toolBar
                anchors.bottomMargin: -18
            }
        },
        State {
            name: "WithLabels"

            PropertyChanges {
                target: toolBar
                anchors.bottomMargin: 0
            }
        }
    ]
}
