import QtQuick
import Bezopyastie

import "ui/BottomBar"
import "ui/LeftSide"
import "ui/RightSide"

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "Bezopyastie"

    Screen01 {
        id: mainScreen
    }

    BottomBar {
        id: bottomBar
    }

    LeftSide {
        id: leftSide
    }

    RightSide {
        id: rightSide
    }

    PathView {
        id: pathView
        x: 902
        y: -1907
        width: 250
        height: 130
        path: Path {
            startY: 100
            startX: 120
            PathQuad {
                x: 120
                y: 25
                controlY: 75
                controlX: 260
            }

            PathQuad {
                x: 120
                y: 100
                controlY: 75
                controlX: -20
            }
        }
        model: ListModel {
            ListElement {
                name: "Grey"
                colorCode: "grey"
            }

            ListElement {
                name: "Red"
                colorCode: "red"
            }

            ListElement {
                name: "Blue"
                colorCode: "blue"
            }

            ListElement {
                name: "Green"
                colorCode: "green"
            }
        }
        delegate: Column {
            spacing: 5
            Rectangle {
                width: 40
                height: 40
                color: colorCode
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                x: 5
                text: name
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

}

