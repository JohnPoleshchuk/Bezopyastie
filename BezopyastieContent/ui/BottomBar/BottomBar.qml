import QtQuick 2.15

Rectangle {
    id: bottomBar
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: parent.height / 16
    color: "black"

    property string registeredText: ""
    property string onlineText: ""

    Component.onCompleted: {
        registeredText = "Зарегистрированных устройств: " + dbManager.getRowCount("bracles")
    }

    Text {
        color: "white"
        text: bottomBar.registeredText
        font.pixelSize: 12
    }
}
