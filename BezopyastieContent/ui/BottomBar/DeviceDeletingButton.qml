import QtQuick 2.15

Rectangle {
    id: minusButton
    width: parent.height * 0.7
    height: width
    anchors {
        left: plusButton.right
        right: LeftSide.right
        rightMargin: 10
        verticalCenter: parent.verticalCenter
    }
    color: "transparent"

    // Horizontal line of plus
    Rectangle {
        width: parent.width * 0.6
        height: 2
        anchors.centerIn: parent
        color: "white"
    }

    MouseArea {
        id: button
        anchors.fill: parent
        onClicked: {
            deviceDeletingWindow.show()
            deviceIdField.text = "" // Очищаем поля при открытии
            deviceNameField.text = ""
        }

        states: State {
            when: button.pressed
            PropertyChanges {
                target: plusButton
                scale: 0.98
            }
        }
    }
    WindowDeleteBracle {
        id: deviceDeletingWindow
    }
}
