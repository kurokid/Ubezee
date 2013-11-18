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

    MouseArea {
        id: buddyMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: console.log(userListData)
    }

    Timer {
        interval: 6000; running: true; repeat: true
        onTriggered: flipImage()
    }

    function flipImage  () {
	console.log(userListData.count)
        for(var idx = 0; idx < userListData.count; ++idx) {
            if ( Math.ceil(Math.random() * (userListData.count+1)) == (idx+1)) {
                    userListData.setProperty(idx,"showback",false)
                    userListData.setProperty(idx,"showback",true)
            }
        }
    }

    clip: true

    ListView {
        id: buddiesList
        anchors.fill: parent
        spacing: 10
        anchors.leftMargin: 25
        anchors.rightMargin: 0
        model: userListData

        Component {
             id: contactDelegate
             BuddyListElement {
                 buddyIp: username
                 buddyAvatar: userPicture
                 //buddyGeneric: generic
                 buddyUsername: realname
                 buddySystem: address
                 buddyOsLogo: userPicture
                 buddyShowBack: true
             }
         }

        delegate: contactDelegate
    }
}
