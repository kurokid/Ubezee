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
    id: generalPage
    clip: true

    DistributionLogo {
        id: generalImage
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    SText {
        id: keterangan
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.rightMargin: 40
        anchors.right: parent.right
        anchors.top: generalImage.bottom
        anchors.topMargin: 20
        font.pixelSize: 20
        wrapMode: "WordWrap"
        text: "if you lock your system, you will not be able to make any change in your system."
        color: "#555555"
    }

    SmoothText {
        anchors.right: mainSwitch.left
        anchors.rightMargin: -10
        anchors.top: keterangan.bottom
        anchors.topMargin: 45
        font.pixelSize: 40
        text: "lock"
        color: "#555555"
    }

    Switch {
        id: mainSwitch
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: keterangan.bottom
        anchors.topMargin: 40
    }
}
