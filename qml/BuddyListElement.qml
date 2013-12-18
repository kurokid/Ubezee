import QtQuick 1.0

Flipable {
   id: contactDelegateItem
   width: parent.width
   height: 64

   property string userName
   property alias userPicture: buddyAvatarImage.source
   property string realName
   property alias userAddress: buddySystemText.text
   property bool buddyShowBack: true
   property bool lockThis

   Timer {
        interval: 6000; running: true; repeat: true
        onTriggered: flipImage()
    }

   function flipImage  () {
   			console.log(buddyShowBack)
			buddyShowBack = false
			console.log(buddyShowBack)
			buddyShowBack= true
   }

   MouseArea {
       id: buddyMouseArea
       anchors.fill: parent
       hoverEnabled: true
       onClicked: lockUser(index, userName, locked)
   }

   Rectangle {
       anchors.fill: parent
       color: "#00000000"
       visible: buddyMouseArea.containsMouse;
       Rectangle {
           anchors.right: parent.right
           anchors.top: parent.top
           height: 64
           width: 5
           color: "#4cb328"
       }
   }

   front: Item {
       id: temp
       width: contactDelegateItem.width

       Flipable {
           id: flipableAvatar
           width: 64
           height: 64

           front: Rectangle {
               anchors.fill: parent
               color: "#248b00"
               Image {
                   anchors.fill: parent
                   source: "images/TileGradient.png"
               }
               Image {
                   id: buddyGenericImage
                   anchors.fill: parent
               }
               Image {
                   id: buddyAvatarImage
                   anchors.fill: parent
                   smooth: true
               }
           }

           back: Rectangle {
               anchors.fill: parent
               color: "#248b00"
               Image {
                   anchors.fill: parent
                   source: "images/TileGradient.png"
               }
               Image {
                   id: buddyOsLogoImage
                   source: "images/LinuxLogo.png"
                   anchors.fill: parent
               }
           }

           transform: Rotation {
                id: innerRotation
                origin.x: 32
                origin.y: 32
                axis.x: 1; axis.y: 0; axis.z: 0
                angle: 0
           }

           states: [
               State {
                name: "OsState"
                when: buddyShowBack
           }]

           transitions: [
                Transition {
                    from: ""
                    to: "OsState"
                    SequentialAnimation {
                        NumberAnimation { target: innerRotation; property: "angle"; from: 0; to: 180; duration: 400; easing.type: Easing.OutQuad }
                        PauseAnimation { duration: 3000 }
                        NumberAnimation { target: innerRotation; property: "angle"; from: 180; to: 0; duration: 400; easing.type: Easing.OutQuad }
                    }
                }
           ]
       }
       SText {
           id: buddyUsernameText
           anchors.top:  flipableAvatar.top
           anchors.topMargin: 8
           anchors.left: flipableAvatar.right
           anchors.leftMargin: 10
           anchors.right: parent.right
           anchors.rightMargin: 20
           font.pixelSize: 16
           text:realName + "(" + userName + ")"
           elide: "ElideRight"
           color: "#555555"
       }
       SText {
           id: buddySystemText
           anchors.left: flipableAvatar.right
           anchors.leftMargin: 10
           anchors.top: buddyUsernameText.bottom
           anchors.topMargin: 5
           anchors.right: parent.right
           anchors.rightMargin: 20
           font.pixelSize: 14
           elide: "ElideRight"
           color: "#555555"
       }
       
       Switch {
           id: userSwitch
           switchOn: locked
           anchors.top: flipableAvatar.top
           anchors.topMargin: 8
           anchors.rightMargin: 10
           anchors.right: parent.right
       }
   }

   transform: Rotation {
        id: rotation
        origin.x: 32
        origin.y: 32
        axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
        angle: 0    // the default angle
   }

   ListView.onAdd: NumberAnimation { target: rotation; property: "angle"; from: -90; to: 0; duration: 300; easing.type: Easing.OutCubic }
   ListView.onRemove: SequentialAnimation {
       PropertyAction { target: contactDelegateItem; property: "ListView.delayRemove"; value: true }
       NumberAnimation { target: rotation; property: "angle"; from: 0; to: -90; duration: 300; easing.type: Easing.InCubic }
       PropertyAction { target: contactDelegateItem; property: "ListView.delayRemove"; value: false }

   }
}
