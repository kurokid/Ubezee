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
        text: "jika sistem anda dikunci, anda tidak akan bisa membuat perubahan apapun di dalam sistem."
        color: "#555555"
    }

    SmoothText {
        anchors.right: mainSwitch.left
        anchors.rightMargin: -10
        anchors.top: keterangan.bottom
        anchors.topMargin: 45
        font.pixelSize: 40
        text: "kunci"
        color: "#555555"
    }

    Switch {
        id: mainSwitch
        switchOn: isLock
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: keterangan.bottom
        anchors.topMargin: 40
    }
}
