import QtQuick 2.0

Item {
    property alias drag: mouseArea.drag

    //FIXME when moving the mouse out of a higher element's containsMouse circle
    // but still inside its mouseArea.containsMouse square, lower elements'
    // mouseArea do not update, so their containsMouse doesn't update, so clicks
    // fall through when they should not.
    property bool containsMouse: {
        var x1 = width / 2;
        var y1 = height / 2;
        var x2 = mouseArea.mouseX;
        var y2 = mouseArea.mouseY;
        var deltax = x1 - x2;
        var deltay = y1 - y2;
        var distance2 = deltax * deltax + deltay * deltay;
        var radius2 = Math.pow(Math.min(width, height) / 2, 2);
        return distance2 < radius2;
    }

    readonly property bool pressed: containsMouse && mouseArea.pressed

    signal clicked(var mouse)
    signal doubleclicked(var mouse)
    signal wheel(var wheel)

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        //FIXME without acceptedButtons, propagated un-accepted clicks end up with the wrong coordinates
        acceptedButtons: parent.containsMouse ? Qt.LeftButton : Qt.NoButton
        propagateComposedEvents: true
        onClicked: { if (parent.containsMouse) { parent.clicked(mouse) } else { mouse.accepted = false } }
        onDoubleClicked: { if (parent.containsMouse) { parent.doubleclicked(mouse) } }
        onWheel: { if (parent.containsMouse) { parent.wheel(wheel) } }
        drag.filterChildren: true
    }
}
