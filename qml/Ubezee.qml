import QtQuick 1.1

Rectangle {

	function hancur(hasLogin) {
		if (hasLogin) loginPage.destroy();
	}

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    id: mainElement
    width: 360
    height: 500

    //state: hasRegister ? hasLogin ? "ubezeemain" : "loginpage" : "registerpage"

    FontLoader {
        id: ubezeefont
        source: "fonts/Klill-Light.ttf"
    }

    FontLoader {
        id: ubezeefontsmall
        source: "fonts/LiberationSans-Regular.ttf"
    }

    FontLoader {
        id: ubezeefonthappy
        source: "fonts/Klill-Light.ttf"
    }

    /*LoginPage {
        id: loginPage
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        x: parent.width
        opacity: 0
        //onLoginClicked: passRequired(password)
        //hasErrorChanged: ubezeeOverlay.state = "info"
        //onShowMainWidget: parent.state = "ubezeemain"
    }*/

    UbezeeInner {
        id: ubezeeInner
        anchors.fill: parent
        onShowIpList: ubezeeOverlay.state = "ip"
        onShowSettings: {
            ubezeeOverlay.state = "settings";
        }
    }
    
    UbezeeOverlay {
        id: ubezeeOverlay
        anchors.fill: parent
    }
}

