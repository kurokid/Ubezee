import QtQuick 1.0

Rectangle {
    id: settingsPage
    color: "#ffffff"

    signal back()
	signal confirm()
	
    MouseArea {
        anchors.fill: parent
    }

    Image {
        id: backIcon
        source: "images/BackIconDark.png"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 5

        MouseArea {
            anchors.fill: parent
            onClicked: settingsPage.back();
        }
    }

    SmoothText {
        id: boxTitle
        anchors.left: backIcon.right
        anchors.top: parent.top
        anchors.leftMargin: 15
        anchors.topMargin: 5
        font.pixelSize: 64
        text: "konfigurasi"
		color: "#4cb328"
    }

    SText {
        id: labelPath
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 17
        anchors.topMargin: 70
        font.pixelSize: 16
        text: "kata kunci:"
        color: "#888888"
    }

    TextBox {
        id: boxNewPass
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: labelPath.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 5
        placeHolder: "masukkan kata kunci baru..."
        charTampil: false
	}
	
	SText {
        id: labelRePass
        anchors.left: parent.left
        anchors.top: boxNewPass.bottom
        anchors.leftMargin: 17
        anchors.topMargin: 10
        font.pixelSize: 16
        text: "konfirmasi kata kunci baru:"
        color: "#888888"
    }

    TextBox {
        id: boxRePass
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: labelRePass.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 5
        placeHolder: "tulis ulang kata kunci anda..."
        charTampil: false
	}
	
	SText {
        id: labelHint
        anchors.left: parent.left
        anchors.top: boxRePass.bottom
        anchors.leftMargin: 17
        anchors.topMargin: 10
        font.pixelSize: 16
        text: "petunjuk kata kunci:"
        color: "#888888"
    }

    TextBox {
        id: boxHint
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: labelHint.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 5
        placeHolder: "masukkan petunjuk kata kunci anda..."
	}

    ButtonDark {
        id: buttonPath
        anchors.right: parent.right
        anchors.rightMargin: 17
        anchors.top: boxHint.bottom
        anchors.topMargin: 10
        label: "ubah kata kunci"
        onClicked: {
        	if (boxNewPass.isi != '' && boxRePass.isi != ''){
	        	if (boxNewPass.isi == boxRePass.isi){
	        		if(boxHint.isi != ''){
	        			doRegister(boxHint.isi, boxNewPass.isi)
	        			setError(true, "konfigurasi berhasil", "kata kunci anda telah berhasi dirubah.")
	        		}else{
	        			setError(true, "konfigurasi gagal!", "tolong pastikan semua kolom sudah terisi.");
	        		}
	        	}else{
	        		setError(true, "konfigurasi gagal", "tolong pastikan kata kunci yang anda masukkan cocok")
	        	}
			}else{
				//setOverlay("")
	       		setError(true, "konfigurasi gagal!", "tolong pastikan semua kolom sudah terisi.");
	       	}
        } 
    }

    SText {
        id: labelColor
        anchors.left: labelPath.left
        anchors.top: buttonPath.bottom
        anchors.topMargin: 40
        font.pixelSize: 16
        text: "Warna Tema:"
        color: "#888888"
    }

    ColorBox {
        id: cbox1
        anchors.top: labelColor.bottom
        anchors.topMargin: 8
        anchors.left: labelColor.left
        color: "#248B00"
    }

    ColorBox {
        id: cbox2
        anchors.top: cbox1.top
        anchors.left: cbox1.right
        anchors.leftMargin: 15
        color: "#A80000"
    }

    ColorBox {
        id: cbox3
        anchors.top: cbox1.top
        anchors.left: cbox2.right
        anchors.leftMargin: 15
        color: "#3A6CBC"
    }

    ColorBox {
        id: cbox4
        anchors.top: cbox1.top
        anchors.left: cbox3.right
        anchors.leftMargin: 15
        color: "#2e3436" // "#704214"
    }

    ColorBox {
        id: cbox5
        anchors.left: cbox4.right
        anchors.top: cbox1.top
        anchors.leftMargin: 15
        color: "#B77994"
    }

    ColorBox {
        id: cbox6
        anchors.top: cbox1.top
        anchors.left: cbox5.right
        anchors.leftMargin: 15
        color: "#5B2F42"
    }

    ColorBox {
        id: cbox7
        anchors.top: cbox1.top
        anchors.left: cbox6.right
        anchors.leftMargin: 15
        color: "#353B56"
    }
/*
    ColorBox {
        id: cbox8
        anchors.top: cbox1.bottom
        anchors.topMargin: 8
        anchors.left: labelColor.left
        color: "#248B00"
    }

    ColorBox {
        id: cbox9
        anchors.top: cbox8.top
        anchors.left: cbox8.right
        anchors.leftMargin: 15
        color: "#A80000"
    }

    ColorBox {
        id: cbox10
        anchors.top: cbox8.top
        anchors.left: cbox9.right
        anchors.leftMargin: 15
        color: "#3A6CBC"
    }

    ColorBox {
        id: cbox11
        anchors.top: cbox8.top
        anchors.left: cbox10.right
        anchors.leftMargin: 15
        color: "#704214"
    }

    ColorBox {
        id: cbox12
        anchors.top: cbox8.top
        anchors.left: cbox11.right
        anchors.leftMargin: 15
        color: "#B77994"
    }

    ColorBox {
        id: cbox13
        anchors.top: cbox8.top
        anchors.left: cbox12.right
        anchors.leftMargin: 15
        color: "#5B2F42"
    }

    ColorBox {
        id: cbox14
        anchors.top: cbox8.top
        anchors.left: cbox13.right
        anchors.leftMargin: 15
        color: "#2e3436"
    }
    */
}
