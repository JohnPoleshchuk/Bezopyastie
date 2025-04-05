import QtQuick 2.15

Rectangle {
    id: leftSide
    anchors {
        top: parent.top
        bottom: bottomBar.top
        left: parent.left
    }
    width: parent.width / 3
    color: "grey"
}
