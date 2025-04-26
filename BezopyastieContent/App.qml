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

    visible: true
    title: "Bezopyastie"

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

