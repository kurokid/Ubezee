import QtQuick 1.0

Rectangle {
    state: "general"
    color: "#ffffff"

    signal showIpList()
    signal showSettings()
    signal addNewUser()

    function gotoPage(page) {
        tabBar.state = page;
        state = page;
    }

    TabBar {
        id: tabBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        onClicked: parent.state = tab
    }

    ToolBar {
        id: toolBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        onClicked: {
            if (command == "ip") showIpList();
            if (command == "settings") showSettings();
        }
    }

    GeneralPage {
        id: generalPage
        anchors.top: tabBar.bottom
        anchors.topMargin: 10
        anchors.bottom: toolBar.top
        width: parent.width
        x: parent.width
        opacity: 0
    }

    UsersPage {
        id: usersPage
        anchors.top: tabBar.bottom
        anchors.topMargin: 10
        anchors.bottom: toolBar.top
        width: parent.width
        x: 200
        opacity: 0
    }

    AboutPage {
        id: aboutPage
        anchors.top: tabBar.bottom
        anchors.topMargin: 10
        anchors.bottom: toolBar.top
        width: parent.width
        x: parent.width
        opacity: 0
    }

    states: [
        State {
            name: "general"

            PropertyChanges {
                target: generalPage
                opacity: 1
                x: 0
            }
        },
        State {
            name: "users"
            PropertyChanges {
                target: generalPage
                opacity: 0
                x: -360
            }
            PropertyChanges {
                target: usersPage
                opacity: 1
                x: 0
            }
        },
        State {
            name: "about"

            PropertyChanges {
                target: usersPage
                opacity: 0
                x: -360
            }
            PropertyChanges {
                target: generalPage
                opacity: 0
                x: -360
            }
            PropertyChanges {
                target: aboutPage
                opacity: 1
                x: 0
            }

        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuart; duration: 1000 }
            NumberAnimation { properties: "opacity"; easing.type: Easing.InQuad; duration: 500 }
        }
    ]
}
