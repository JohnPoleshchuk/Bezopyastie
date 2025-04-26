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
    spacing: 10
    boundsBehavior: Flickable.StopAtBounds
    cacheBuffer: 2000

    model: ListModel {
        id: itemModel
        function findIndexById(id) {
            for (var i = 0; i < count; i++) {
                if (get(i).itemId === id) return i;
            }
            return -1;
        }
    }

    delegate: MouseArea {
        id: button
        width: parent.width
        height: leftSide.height / 6
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        states: [
            State {
                name: "HOVERED"
                when: containsMouse && !pressed
                PropertyChanges {
                    target: delegateBg
                    scale: 1.02
                    border.color: "#80FFFFFF"
                }
            },
            State {
                name: "PRESSED"
                when: pressed
                PropertyChanges {
                    target: delegateBg
                    scale: 0.97
                }
            }
        ]

        transitions: Transition {
            NumberAnimation {
                properties: "scale"
                duration: 150
                easing.type: Easing.OutBack
            }
        }

        Rectangle {
            id: delegateBg
            anchors.fill: parent
            color: "transparent"
            radius: height/6
            border.color: "grey"
            border.width: 2
            antialiasing: true

            // Заменили тень на альтернативный стиль
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#10000000" }
                GradientStop { position: 1.0; color: "#08000000" }
            }

            Behavior on border.color {
                ColorAnimation { duration: 200 }
            }

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
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        font {
                            pixelSize: 20
                            family: "Arial"
                        }
                    }
                }

                Rectangle {
                    width: parent.width * 1/6
                    height: parent.height
                    color: model.colorPower
                    Behavior on color {
                        ColorAnimation { duration: 400 }
                    }
                }
            }

            // Анимация появления
            Component.onCompleted: {
                opacity = 0
                scale = 0.8
                appearAnim.start()
            }

            NumberAnimation {
                id: appearAnim
                target: delegateBg
                properties: "opacity, scale"
                to: 1
                duration: 350
                easing.type: Easing.OutBack
            }

            // Анимация удаления
            SequentialAnimation {
                id: removeAnim
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: 300
                }
                ScriptAction { script: itemModel.remove(index) }
            }
        }

        onClicked: console.log("Clicked:", model.itemId)
    }

    // Фон списка
    Rectangle {
        z: -1
        anchors.fill: parent
        color: "#404040"
        radius: 10
    }

    // Плавная прокрутка
    Behavior on contentY {
        enabled: !profileList.moving
        NumberAnimation {
            duration: 450
            easing.type: Easing.OutQuint
        }
    }

    // Таймер обновления
    Timer {
        id: refreshTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: updateData()
    }

    function updateData() {
        var oldY = profileList.contentY
        var results = dbManager.executeQuery("SELECT * FROM bracles")

        var onItems = []
        var offItems = []
        results.forEach(item => {
            if (item.power === "ON") onItems.push(item)
            else offItems.push(item)
        })

        onItems.sort((a, b) => a.bracle_id - b.bracle_id)
        offItems.sort((a, b) => a.bracle_id - b.bracle_id)
        var sortedItems = onItems.concat(offItems)
        var currentIds = sortedItems.map(it => it.bracle_id.toString())

        // Удаление с анимацией
        for (var i = itemModel.count - 1; i >= 0; i--) {
            var existingId = itemModel.get(i).itemId
            if (!currentIds.includes(existingId)) {
                itemModel.remove(i)
            }
        }

        // Добавление/обновление
        sortedItems.forEach(item => {
            var idx = itemModel.findIndexById(item.bracle_id.toString())
            var itemColor = item.power === "ON" ? "#30C71A" : "#FF3B30"

            if (idx === -1) {
                itemModel.append({
                    itemId: item.bracle_id.toString(),
                    itemName: "Браслет ID: " + item.bracle_id,
                    colorPower: itemColor,
                    sortKey: item.power === "ON" ? 0 : 1
                })
            } else {
                itemModel.set(idx, {
                    colorPower: itemColor,
                    sortKey: item.power === "ON" ? 0 : 1
                })
            }
        })

        Qt.callLater(() => profileList.contentY = oldY)
    }

    Component.onCompleted: updateData()
}
