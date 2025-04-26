import QtQuick 2.12
import QtQuick.Controls 2.15

ListView {
    id: profileList
    clip: true
    anchors {
        top: leftSide.top
        bottom: leftSide.bottom
        horizontalCenter: leftSide.horizontalCenter
    }
    height: leftSide.height
    width: leftSide.width - 20

    model: ListModel {id: itemModel}
    spacing: 10

    delegate: MouseArea {
        id: button
        width: parent.width
        height: leftSide.height/6
        hoverEnabled: true

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: height/6
            border.color: "grey"
            border.width: 2

            Row {
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    width: parent.width * 5/6
                    height: parent.height
                    color: "black"
                    radius: parent.radius

                    Text {
                        color: "white"
                        text: model.itemName
                        anchors {
                            left: parent.left
                        }
                        font.pixelSize: 20
                    }
                }

                Rectangle {
                    width: parent.width * 1/6
                    height: parent.height
                    color: model.colorPower
                }
            }

            Rectangle {
                visible: button.pressed
                anchors.top: parent.top
                width: parent.width
                height: 15
                color: "white"
                opacity: 0.2
                radius: height * 2
                anchors.topMargin: -radius
            }
        }

        // Click handler
        onClicked: {
            console.log("Clicked item:", model.index)
            // Add your click logic here
        }

        // Optional press animation
        states: State {
            when: button.pressed
            PropertyChanges {
                target: button
                scale: 0.98
            }
        }

        transitions: Transition {
            NumberAnimation { properties: "scale"; duration: 100 }
        }
    }

    Rectangle {
        z: -1
        anchors.fill: parent
        color: "grey"
    }

    Timer {
        id: refreshTimer
        interval: 1000 // 1 second
        running: true
        repeat: true
        onTriggered: updateData()
    }

    function updateData() {
           var results = dbManager.executeQuery("SELECT * FROM bracles")
           // Split items into ON/OFF groups
           var onItems = []
           var offItems = []

           for (var i = 0; i < results.length; i++) {
               var item = results[i]
               if (item.power === "ON") {
                   onItems.push(item)
               } else {
                   offItems.push(item)
               }
           }

           // Combine with ON items first
           var sortedItems = onItems.concat(offItems)

           // Clear and repopulate model
           itemModel.clear()

           for (var j = 0; j < sortedItems.length; j++) {
               var sortedItem = sortedItems[j]
               var itemColor = sortedItem.power === "ON" ? "#30931a" : "#931a20"
               var itemId = "Браслет ID : " + sortedItem.bracle_id

               itemModel.append({
                   colorPower: itemColor,
                   itemName: itemId,
                   _sortKey: sortedItem.power === "ON" ? 0 : 1
               })
           }
       }

    Component.onCompleted: {
        updateData()
    }
}
