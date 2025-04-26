import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Rectangle {
    id: plusButton
    width: parent.height * 0.7
    height: width
    anchors {
        left: parent.left
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

    // Vertical line of plus
    Rectangle {
        width: 2
        height: parent.height * 0.6
        anchors.centerIn: parent
        color: "white"
    }

    MouseArea {
        id: button
        anchors.fill: parent
        onClicked: {
            deviceSettingsWindow.show()
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
    WindowAddBracle {
        id: deviceSettingsWindow
    }
}
