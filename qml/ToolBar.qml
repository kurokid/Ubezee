/* DUKTO - A simple, fast and multi-platform file transfer tool for LAN users
 * Copyright (C) 2011 Emanuele Colombo
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

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
        color: "#248b00"

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
                //onClicked: guiBehind.openDestinationFolder();
            }
        }
        SText {
            anchors.top: unlockIcon.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: unlockIcon.horizontalCenter
            text: "Temp. Unlock"
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
                onClicked: toolBar.clicked("settings")
            }
        }
        SText {
            anchors.top: configIcon.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: configIcon.horizontalCenter
            text: "Settings"
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
            text: "Exit"
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
