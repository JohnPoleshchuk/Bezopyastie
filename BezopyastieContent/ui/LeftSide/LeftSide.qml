import QtQuick 2.15

Rectangle {
    id: leftSide
    anchors {
        top: parent.top
        bottom: bottomBar.top
        left: parent.left
    }
    property real customWidth: parent.width / 3
        width: customWidth
        color: "grey"

        // Минимальная и максимальная допустимая ширина
        property real minWidth: 50
        property real maxWidth: parent.width - 50

        // Ползунок для изменения размера
        Rectangle {
            id: resizeHandle
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            width: 5
            color: "darkgrey"

            // Курсор при наведении
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.SizeHorCursor
                drag {
                    target: parent
                    axis: Drag.XAxis
                    threshold: 0
                }

                onMouseXChanged: {
                    if (drag.active) {
                        // Вычисляем новую ширину с ограничениями
                        let newWidth = leftSide.customWidth + mouseX
                        leftSide.customWidth = Math.max(minWidth, Math.min(newWidth, maxWidth))
                    }
                }
            }
        }
    Profile {
        id: profileList
    }
}
