import QtQuick 2.15
import QtQuick.Controls 2.15
Rectangle {
        id: mapView
        anchors.fill: parent
        color: "black"

        Flickable {
            id: flickable
            anchors.fill: parent
            contentWidth: imageContainer.width
            contentHeight: imageContainer.height
            clip: true
            interactive: !pinchArea.pinch.active

            Rectangle {
                id: imageContainer
                width: Math.max(image.width * image.scale, flickable.width)
                height: Math.max(image.height * image.scale, flickable.height)

                Image {
                    id: image
                    anchors.centerIn: parent
                    source: "qrc:/new/prefix1/image/SeverSteel.png"
                    fillMode: Image.PreserveAspectFit
                    width: sourceSize.width
                    height: sourceSize.height
                    scale: 1.0

                    Behavior on scale {
                        NumberAnimation { duration: 200 }
                    }
                }
            }

            PinchArea {
                id: pinchArea
                anchors.fill: parent

                property real initialScale: 1.0

                onPinchStarted: {
                    initialScale = image.scale
                }

                onPinchUpdated: {
                    image.scale = initialScale * pinch.scale

                    // Корректировка позиции при масштабировании
                    flickable.contentX += pinch.previousCenter.x - pinch.center.x
                    flickable.contentY += pinch.previousCenter.y - pinch.center.y
                }

                onPinchFinished: {
                    // Ограничение минимального и максимального масштаба
                    image.scale = Math.max(0.1, Math.min(image.scale, 10.0))

                    // Автоматическая подгонка, если изображение меньше области просмотра
                    if (image.scale * image.width < flickable.width) {
                        resetZoomAnimation.start()
                    }
                }
            }

            NumberAnimation {
                id: resetZoomAnimation
                target: image
                property: "scale"
                to: Math.min(
                    flickable.width / image.width,
                    flickable.height / image.height
                )
                duration: 200
            }
        }

        // Панель управления масштабом
        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            padding: 10

            Button {
                text: "+"
                onClicked: image.scale *= 1.2
            }

            Button {
                text: "-"
                onClicked: image.scale /= 1.2
            }

            Button {
                text: "Сброс"
                onClicked: {
                    image.scale = 1.0
                    flickable.contentX = 0
                    flickable.contentY = 0
                }
            }
        }

    }
