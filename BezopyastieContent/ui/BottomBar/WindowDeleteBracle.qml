import QtQuick 6.3
import QtQuick.Window 6.3
import QtQuick.Controls

Window {
    id: deviceDeletingWindow
    title: "Добавление устройства"
    width: 300
    height: 190
    flags: Qt.Dialog
    modality: Qt.ApplicationModal

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        Column {
            spacing: 10
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Удаление устройства"
                font.bold: true
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextField {
                id: deviceIdField
                width: parent.width
                placeholderText: "Введите ID устройства"
                maximumLength: 10
                validator: IntValidator { bottom: 1; top: 999999 }
            }

            Row {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Сохранить"
                    onClicked: {
                        if(deviceIdField.text) {
                            var str = "DELETE FROM bracles WHERE bracle_id="+ deviceIdField.text.toString() +";"
                            dbManager.executeQuery(str)
                            deviceDeletingWindow.close()
                            console.log("Устройство удалено")
                        } else {
                            errorText.visible = true
                        }
                    }
                }

                Button {
                    text: "Закрыть"
                    onClicked: deviceDeletingWindow.close()
                }
            }

            Text {
                id: errorText
                text: "Заполните все поля!"
                color: "red"
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
