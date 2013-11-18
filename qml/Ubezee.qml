/* UBEZEE - A simple, fast and multi-platform file transfer tool for LAN users
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

import QtQuick 1.1

Rectangle {

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    id: mainElement
    width: 360
    height: 500

    state: hasLogin ? "ubezeemain" : "loginpage"

    FontLoader {
        id: ubezeefont
        source: "fonts/Klill-Light.ttf"
    }

    FontLoader {
        id: ubezeefontsmall
        source: "fonts/LiberationSans-Regular.ttf"
    }

    FontLoader {
        id: ubezeefonthappy
        source: "fonts/Klill-Light.ttf"
    }

    LoginPage {
        id: loginPage
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        x: 200
        opacity: 0
        //onLoginClicked: passRequired(password)
        //hasErrorChanged: ubezeeOverlay.state = "info"
        //onShowMainWidget: parent.state = "ubezeemain"
    }

    UbezeeMain {
        id: ubezeeMain
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        x: parent.width
        opacity: 0
        }

    states: [
        State {
            name: "loginpage"
            PropertyChanges {
                target: loginPage
                opacity: 1
                x: 0
            }
        },

        State {
            name: "ubezeemain"
            PropertyChanges {
                target: loginPage
                opacity: 0
                x: -360
            }

            PropertyChanges {
                target: ubezeeMain
                opacity: 1
                x: 0
            }
        }
    ]

        transitions: [
            Transition {
                NumberAnimation { properties: "x,y"; easing.type: Easing.OutCubic; duration: 500 }
                NumberAnimation { properties: "opacity"; easing.type: Easing.OutCubic; duration: 500 }
            }
        ]
}

