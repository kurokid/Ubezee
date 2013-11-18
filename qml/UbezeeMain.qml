// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: ubezeeMain
    color: "#ffffff"

    UbezeeInner {
        id: ubezeeInner
        anchors.fill: parent
        onShowIpList: ubezeeOverlay.state = "ip"
        onShowSettings: {
            ubezeeOverlay.state = "settings";
        }
    }

    /*UpdatesBox {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
    }*/

    UbezeeOverlay {
        id: ubezeeOverlay
        anchors.fill: parent
    }
}
