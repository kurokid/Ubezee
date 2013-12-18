import QtQuick 1.0

Item {

    Timer {
        interval: 6000; running: true; repeat: true
        onTriggered: flipImage()
    }

    function flipImage  () {
        for(var idx = 0; idx < buddiesList.count; ++idx) {
            if ( Math.ceil(Math.random() * (userListData.count+1)) == (idx+1)) {
            		console.log(buddiesList.count)
                    buddiesList.setProperty(idx,"showback",false)
                    buddiesList.setProperty(idx,"showback",true)
                    buddiesList.setProperty(0,"username","asdas")
            }
        }
    }
    
    MouseArea {
       anchors.fill: parent
       onClicked: console.log(buddiesList.currentIndex)
   }

    clip: true

    SmoothText {
        id: badSmile
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        font.pixelSize: 160
        text: ":-("
        color: "#555555"
        visible: isLock
    }
    
    SText  {
        y: badSmile.y + badSmile.height / 2 + 20
        // anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.right: parent.right
        anchors.rightMargin: 40
        font.pixelSize: 17
        color: "#555555"
        text: "Maaf, penguncian berdasarkan pengguna hanya berfungsi jika penguncian sistem tidak dihidupkan..."
        wrapMode: TextEdit.Wrap
        visible: isLock
    }
    
    ListView {
        id: buddiesList
        anchors.fill: parent
        spacing: 10
        anchors.leftMargin: 25
        anchors.rightMargin: 0
        model: userListData
        visible: !isLock

        Component {
             id: contactDelegate
             BuddyListElement {
                 userName: nama
                 userPicture: userpicture
                 realName: realname
                 userAddress: address
                 lockThis: lockThis
             }
         }

        delegate: contactDelegate
    }
}
