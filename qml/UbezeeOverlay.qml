import QtQuick 1.0

Rectangle {
    color: "#00000000"
    state: hasError ? "info" : hasLogin ? overlay : hasRegister ? "loginpage" : "registerpage"
    
    Rectangle {
        id: disabler
        anchors.fill: parent
        color: "#ccffffff"
        opacity: 0
        visible: false

        MouseArea {
            anchors.fill: parent
        }
    }

    InfoPage {
        id: infoPage
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width
        x: -50
        opacity: 0
        onBack: {
        	setError(false, '', '')
        }
    }
    
    LoadingInfo {
        id: loadingInfo
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width
        x: -50
        opacity: 0
        onBack: {
        	setError(false, '', '')
        }
    }

    SettingsPage {
        id: settingsPage
        width: parent.width
        height: parent.height
        x: -50
        opacity: 0
        onBack: setOverlay("")
    }
    
    SyncPage {
        id: syncPage
        width: parent.width
        height: parent.height
        x: -50
        opacity: 0
        onBack: setOverlay("")
    }
    
    LoginPage {
        id: loginPage
        width: parent.width
        height: parent.height
        x: -50
        opacity: 0
    }
    
    RegisterPage {
        id: registerPage
        width: parent.width
        height: parent.height
        x: -50
        opacity: 0
    }

    states: [
        State {
            name: "info"
            PropertyChanges {
                target: infoPage
                opacity: 1
                x: 0
            }
            PropertyChanges {
                target: disabler
                opacity: 1
                visible: true
            }
        },
        State {
            name: "loading"
            PropertyChanges {
                target: loadingInfo
                opacity: 1
                x: 0
            }
            PropertyChanges {
                target: disabler
                opacity: 1
                visible: true
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: settingsPage
                opacity: 1
                x: 0
            }
        },
        State {
            name: "sync"
            PropertyChanges {
                target: syncPage
                opacity: 1
                x: 0
            }
        },
        State {
            name: "loginpage"
            PropertyChanges {
                target: loginPage
                opacity: 1
                x: 0
            }
        },
        State {
            name: "registerpage"
            PropertyChanges {
                target: registerPage
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
