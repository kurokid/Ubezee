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
            color: generalTextMouseArea.containsMouse ? "#4cb328" : "#cccccc"
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
            x: 182
            font.pixelSize: 84
            text: "users"
            transformOrigin: Item.TopLeft
            color: userTextMouseArea.containsMouse ? "#4cb328" : "#cccccc"
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
            x: 320
            font.pixelSize: 84
            color: aboutTextMouseArea.containsMouse ? "#4cb328" : "#cccccc"
            text: "about"
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
                color: "#248b00" // "#000000"
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
                x: 117
                color: "#248b00" // "#000000"
            }

            PropertyChanges {
                target: aboutText
                x: 255
            }
        },
        State {
            name: "about"

            PropertyChanges {
                target: generalText
                x: -120
            }

            PropertyChanges {
                target: userText
                x: 52
            }

            PropertyChanges {
                target: aboutText
                x: 190
                color: "#248b00" // "#000000"
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
