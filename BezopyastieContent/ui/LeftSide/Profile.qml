import QtQuick 2.15
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


    property int count: -1
    Component.onCompleted: {
        count = dbManager.getRowCount("bracles")
    }

    model: count
    spacing: 10

    delegate : Rectangle {
        width: parent.width
        height: leftSide.height/6
        color: "black"
        radius: height / 8
        border {
            color: "grey"
            width: 2
        }

        Text {
            color: "white"
            text: "Item " + index
            anchors.centerIn: parent
        }
    }

    Rectangle {
        z: -1
        anchors.fill: parent
        color: "grey"
    }

}
