import QtQuick 1.0

Item {

    Rectangle {
        x: 27
        y: 15
        width: 64
        height: 64
        color: myColor1
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
        text: "Dibuat oleh Ikhwan Setiawan"
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
        text: "Aplikasi ini dan kode sumbernya dirilis sepenuhnya sebagai projek open source.<br><br><br>kode sumber: http://github.com/kurokid/Ubezee.git<br>email: ikhwansetiawan@cek.pm"
        onLinkActivated: Qt.openUrlExternally(link)
    }
}
