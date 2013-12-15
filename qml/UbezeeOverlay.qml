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

    IpPage {
        id: ipPage
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width
        x: -50
        opacity: 0
        onBack: parent.state = ""
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

    ProgressPage {
        id: progressPage
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width
        x: -50
        opacity: 0
    }

    SettingsPage {
        id: settingsPage
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

    /*ShowTextPage {
        id: showTextPage
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        x: -50
        opacity: 0
        onBack: parent.state = ""
        onBackOnSend: {
            sendPage.setDestinationFocus();
            parent.state = "send"
        }
    }

    SendPage {
        id: sendPage
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height
        x: -50
        opacity: 0
        onBack: parent.state = ""
        onShowTextPage: {
            showTextPage.setTextEditFocus();
            parent.state = "showtext";
        }
    }

    MessagePage {
        id: messagePage
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width
        x: -50
        opacity: 0
        onBack: parent.state = backState
    }*/

    states: [
        State {
            name: "ip"
            PropertyChanges {
                target: ipPage
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
            name: "progress"
            PropertyChanges {
                target: progressPage
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
            name: "showtext"
            PropertyChanges {
                target: showTextPage
                opacity: 1
                x: 0
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
            name: "send"
            PropertyChanges {
                target: sendPage
                opacity: 1
                x: 0
            }
        },
        State {
            name: "message"
            PropertyChanges {
                target: messagePage
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
