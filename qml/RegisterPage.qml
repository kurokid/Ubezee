import QtQuick 1.0

Rectangle {
    id: registerPage
    color: "#ffffff"

    signal ok()

    SmoothText {
        id: boxTitle
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 15
        anchors.topMargin: 5
        font.pixelSize: 64
        text: "Disclaimer"
        color: "#4cb328"
    }

    SText {
        id: boxSender
        anchors.left: boxTitle.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.topMargin: 45
        font.pixelSize: 16
        text: "Please read and fill form above."
        color: "#888888"
    }


    Rectangle {
        id: rectangleText
        border.color: "#4cb328"
        border.width: 1
        anchors.top: boxSender.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: txtHint.top
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 10

        Flickable {
            id: flickableText
            anchors.fill: parent
            anchors.margins: 5
            contentHeight: textEditSnippet.paintedHeight
            flickableDirection: Flickable.VerticalFlick

            clip: true

            function ensureVisible(r) {
                if (contentX >= r.x)
                    contentX = r.x;
                else if (contentX+width <= r.x+r.width)
                    contentX = r.x+r.width-width;
                if (contentY >= r.y)
                    contentY = r.y;
                else if (contentY+height <= r.y+r.height)
                    contentY = r.y+r.height-height;
            }

            TextEdit {
                id: textEditSnippet
                color: "#888888"
                width: rectangleText.width - 10
                font.family: ubezeefontsmall.name
                font.pixelSize: 13
                selectByMouse: true
                wrapMode: TextEdit.Wrap
                textFormat: TextEdit.PlainText
                readOnly: true
                text: "The Software is provided on an AS IS basis, without warranty of any kind, including without limitation the warranties of merchantability, fitness for a particular purpose and non-infringement. The entire risk as to the quality and performance of the Software is borne by you. Should the Software prove defective, you and not the author assume the entire cost of any service and repair.\n\nTHE AUTHOR IS NOT RESPONSIBLE FOR ANY INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES OF ANY CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF GOODWILL, WORK STOPPAGE, COMPUTER FAILURE OR MALFUNCTION, OR ANY AND ALL OTHER COMMERCIAL DAMAGES OR LOSSES.\n\nTitle, ownership rights and intellectual property rights in and to the Software shall remain to the author.\n\nAlso, the Software will periodically send anonymous data to the author servers for statistical information, like (but not only) the Software version, operating system version, application settings, current locale."
                onCursorRectangleChanged: flickableText.ensureVisible(cursorRectangle)
            }
        }
    }
    
	SText {
		id: txtHint
		anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: boxHint.top
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
		font.pixelSize: 12
		text: "<b>Your Password Hint</b>"
		color: "#888888"
	}
		    
	TextBox{
		id: boxHint
	    anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: txtPass.top
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        placeHolder: 'Enter your password hint...'
	}

	SText {
		id: txtPass
		anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: boxPass.top
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
		font.pixelSize: 12
		text: "<b>Create a Password</b>"
		color: "#888888"
	}
	
	TextBox{
		id: boxPass
	    anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: txtRePass.top
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        placeHolder: 'Enter your password...'
        charTampil: false
	}
	
	SText {
		id: txtRePass
		anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: boxRePass.top
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
		font.pixelSize: 12
		text: "<b>Confirm your password</b>"
		color: "#888888"
	}
	
	TextBox{
		id: boxRePass
		anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: buttonCopy.top
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 10
        placeHolder: 'Retype your password...'
        charTampil: false
	}

    ButtonDark {
        id: buttonCopy
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        buttonEnabled: true
        label: "Accept"
        onClicked: {
        	if (boxPass.isi != '' && boxRePass.isi != ''){
	        	if (boxPass.isi == boxRePass.isi){
	        		if(boxHint.isi != ''){
	        			doRegister(boxHint.isi, boxPass.isi)
	        		}else{
	        			setError(true, "Register Failed", "Please, make sure your input password is match!")
	        		}
	        	}else{
	        		setError(true, "Register Failed", "Please, make sure your input password is match!")
	        	}
			}else{
	       		setError(true, "Register Failed", "Please, make sure your input password is match!")
	       	}
        }
    }
}
