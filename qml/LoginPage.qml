/* Ubezee
 * Copyright (C) 2013 Ikhwan Setiawan
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

    Rectangle {
        anchors.top: boxTitle.bottom
        anchors.topMargin: -25
        color: "#248b00"
        width: parent.width
        height: 2
    }

    Rectangle {
        id: loginForm
        width: parent.width
        height: 100
        anchors.centerIn: parent

        Rectangle {
            id: imageRec
            width: 128
            height: 128
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "#248b00"
            Image {
                anchors.fill: parent
                source: "images/TileGradient.png"
            }

	    Image {
		id: rect
		source: "images/ubezee.png"
		transform: Rotation { origin.x: 30; origin.y: 30; axis { x: 0; y: 1; z: 0 } angle: 18 }
		smooth: true
	    }
	    
	    RotationAnimation {
		id: rotationAnimation
		running: true
		from: 0
		to: -360
		duration: 4000
		loops: Animation.Infinite
		target: rect
		property: "rotation"

	    }
        }

        SText {
	    anchors.left: imageRec.right
	    anchors.right: parent.right
	    anchors.bottom: txtPass.top
	    anchors.leftMargin: 10
	    anchors.rightMargin: 20
	    anchors.bottomMargin: 20
	    font.pixelSize: 16
	    wrapMode: TextEdit.Wrap
	    text: "<b>Please input password to show the configuration menu!</b>"
	    color: "#888888"
	}
	
	Rectangle {
	    id: txtPass
	    anchors.left: imageRec.right
	    anchors.right: parent.right
	    anchors.bottom: imageRec.bottom
	    anchors.leftMargin: 10
	    anchors.rightMargin: 20
            border.color: "#888888"
            border.width: 2
            height: 25
            TextInput {
                id: passwordText
                anchors.fill: parent
                anchors.margins: 4
                readOnly: false
                smooth: true
                font.pixelSize: 14
                color: "#888888"
                echoMode: TextInput.Password
                selectByMouse: true
		focus: true
                onAccepted: {
                    check_pass(passwordText.text);
                    passwordText.text = ""
                    passwordText.focus = true
                }
            }
        }
    }


    ButtonDark {
        id: buttonOk
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        buttonEnabled: true
        label: "Accept"
        onClicked: {
            check_pass(passwordText.text);
            passwordText.text = ""
            passwordText.focus = true
        }
    }
    
    ButtonDark {
        id: buttonClose
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        buttonEnabled: true
        label: "Exit"
        onClicked: Qt.quit();
    }

    UbezeeOverlay {
        id: loginOverlay
        anchors.fill: parent
        state: hasError==true? "info" : ""
    }
}
