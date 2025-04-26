import QtQuick 6.3
import QtQuick.Window 6.3
import QtQuick.Controls

import Bezopyastie

import "ui/BottomBar"
import "ui/LeftSide"
import "ui/RightSide"

Window {
    width: 1920
    height: 1080

    Shortcut {
            sequence: "F11"
            onActivated: {
                if (mainWindow.visibility === Window.FullScreen) {
                    mainWindow.showNormal()
                } else {
                    mainWindow.showFullScreen()
                }
            }
        }

    visible: true
    title: "Безопястье"

    BottomBar {
        id: bottomBar
    }

    LeftSide {
        id: leftSide
    }

    RightSide {
        id: rightSide
    }
}

