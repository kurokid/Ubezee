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

Rectangle {
    id: loginPage
    color: "#ffffff"
    signal loginClicked(string password)
    signal showMainWidget()
    signal showError()

    MouseArea {
        anchors.fill: parent
    }

    function loginPass(statusLogin) {
        if (statusLogin == "ok") showMainWidget();
        if (statusLogin == "error") loginOverlay.state = "info" ;
    }

    SmoothText {
        id: boxTitle
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 15
        anchors.topMargin: 5
        font.pixelSize: 64
        text: "Authentication"
        color: "#4cb328"
    }

    SText {
        id: boxSender
        anchors.left: boxTitle.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.topMargin: 45
        font.pixelSize: 16
        text: "Please input your password"
        color: "#888888"
    }

    Rectangle {
        anchors.top: boxSender.top
        anchors.topMargin: 25
        color: "#248b00"
        width: parent.width
        height: 1
        y: parent.height - 10
    }

    Rectangle {
        id: loginForm
        width: parent.width
        height: 100
        anchors.centerIn: parent

        Rectangle {
            id: imageRec
            width: 64
            height: 64
            anchors.centerIn: parent
            color: "#248b00"
            Image {
                anchors.fill: parent
                source: "images/TileGradient.png"
            }

            Image {
                anchors.fill: parent
                source: "images/PcLogo.png"
                smooth: true
            }
        }

        Rectangle {
            anchors.top: imageRec.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: imageRec.horizontalCenter
            border.color: "#888888"
            border.width: 2
            width: 225
            height: 25
            TextInput {
                id: passwordText
                anchors.fill: parent
                anchors.margins: 4
                focus: true
                readOnly: false
                smooth: true
                font.pixelSize: 14
                color: "#888888"
                selectByMouse: true
                echoMode: TextInput.Password
                onAccepted: {
                    loginClicked(passwordText.text);
                    passwordText.text = ""
                    passwordText.focus = true
                }
            }
        }
    }


    ButtonDark {
        id: buttonCopy
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        buttonEnabled: true
        label: "Accept"
        onClicked: {
            loginClicked(passwordText.text);
            passwordText.text = ""
            passwordText.focus = true
        }
    }

    UbezeeOverlay {
        id: loginOverlay
        anchors.fill: parent
    }
}
