import QtQuick 2.15

Rectangle {
    id: rightSide
    anchors {
        top: parent.top
        bottom: bottomBar.top
        left: leftSide.right
    }
    color: "white"
    width: parent.width * (2/3)
}
