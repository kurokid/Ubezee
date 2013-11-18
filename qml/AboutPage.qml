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

    Rectangle {
        x: 27
        y: 15
        width: 64
        height: 64
        color: "#248b00"
        Image {
            source: "images/TileGradient.png"
            anchors.fill: parent
        }
        Image {
            source: "images/ubezee-small.png"
            anchors.fill: parent
        }
    }

    SmoothText {
        y: 80
        x: 22
        font.pixelSize: 100
        text: "Ubezee Beta"
        color: "#555555"
    }
    SmoothText {
        x: 25
        y: 70 + 75
        font.pixelSize: 38
        text: "Created by Ikhwan Setiawan"
        color: "#888888"
    }

    SText {
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 25
        y: 180
        font.pixelSize: 12
        color: "#888888"
        wrapMode: "WordWrap"
        text: "This application and it's source code are released freely as open source project."
        onLinkActivated: Qt.openUrlExternally(link)
    }
}
