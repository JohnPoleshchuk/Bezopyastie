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

    DeviceAddingButton {
        id:plusButton
    }

    DeviceDeletingButton {
        id: minusButton
    }

    Timer {
        id: refreshTimer
        interval: 1000 // 1 second
        running: true
        repeat: true
        onTriggered: updateText()
    }

    property string registeredText: ""

    function updateText() {
        registeredText = "Зарегистрированных устройств: " + dbManager.getRowCount("bracles")
    }

    Component.onCompleted: {
        updateText();
    }

    Text {
        anchors {
            left: minusButton.right
            verticalCenter: parent.verticalCenter
        }
        color: "white"
        text: bottomBar.registeredText
        font.pixelSize: 18
    }
}
