import QtQuick 2.12
import QtQuick.Controls 2.5
import StageBeam 0.1


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    color: 'black'
    title: qsTr("Display")

    property real edgewidth: Math.min(width, height) * 0.15
    property real spotlightRadius: edgewidth * 1.5
    property Item currentSpotlight

    Item {
        id: containerOuter
        anchors.fill: parent
        MouseArea {
            visible: true
            anchors.fill: parent
            onClicked: {
                currentSpotlight = spotlightComponent.createObject(containerInner, {
                    "x": x + mouseX - spotlightRadius,
                    "y": y + mouseY - spotlightRadius,
                    "width": spotlightRadius * 2,
                    "height": spotlightRadius * 2,
                    "radius": spotlightRadius,
                    "color": Qt.rgba(Math.random()*0.5+0.5,Math.random()*0.5+0.5,Math.random()*0.5+0.5,0.5),
                })
            }
        }
        Item {
            id: containerInner
            anchors.fill: parent
        }

    }

    Component {
        id: spotlightComponent
        Rectangle {
            id: spotlightCircle
            visible: true
            MouseArea {
                containmentMask: mask
                anchors.fill: parent
//                anchors.margins: -parent.radius/8 // catch input slightly outside the circle
                anchors.margins: 0
                drag.threshold: 1
                // used during drag resize
                property point resizeCenter: Qt.point(parent.x + parent.width/2, parent.y + parent.height/2)
                property real resizeRadiusRatio
                onDoubleClicked: parent.destroy()
                onClicked: currentSpotlight = parent
                onWheel: { parent.z += wheel.pixelDelta.y; currentSpotlight = parent }
//                // Visualize outline of area
//                Rectangle {
//                    border.color: 'white'
//                    color: 'transparent'
//                    anchors.fill: parent
//                    radius: parent.width / 2
//                }
                ItemRadiusMask {
                    id: mask
                    anchors.fill: parent
                    radius: parent.width / 2
                }
                onPressedChanged: {
                    if (pressed) {
                        resizeCenter.x = parent.x + parent.width/2
                        resizeCenter.y = parent.y + parent.height/2
                        var x = width/2 - mouseX
                        var y = height/2 - mouseY
                        var resizeRadius = Math.sqrt(x*x+y*y)
                        resizeRadiusRatio = parent.radius / resizeRadius
                    }
                }
                onPositionChanged: {
                    if (pressed) {
                        var mouseGlobalX = mouse.x + x + parent.x
                        var mouseGlobalY = mouse.y + y + parent.y
                        var mouseCenterDX = mouseGlobalX - resizeCenter.x
                        var mouseCenterDY = mouseGlobalY - resizeCenter.y
                        var mouseCenterDist = Math.sqrt(mouseCenterDX * mouseCenterDX + mouseCenterDY * mouseCenterDY)
                        var newRadius = mouseCenterDist * resizeRadiusRatio
                        parent.radius = newRadius
                        parent.x = resizeCenter.x - newRadius
                        parent.y = resizeCenter.y - newRadius
                        parent.width = newRadius * 2
                        parent.height = newRadius * 2
                    }
                }
            }
            MouseArea {
                containmentMask: innerMask
                anchors.fill: parent
                anchors.margins: parent.width / 6
                drag.target: parent
                drag.threshold: 1
                //FIXME: let events fall through
                onDoubleClicked: parent.destroy()
                onClicked: currentSpotlight = parent
                onWheel: { parent.z += wheel.pixelDelta.y; currentSpotlight = parent }
                ItemRadiusMask {
                    id: innerMask
                    anchors.fill: parent
                    radius: parent.width / 2
                }
//                // Visualize outline of area
//                Rectangle {
//                    border.color: 'black'
//                    color: 'transparent'
//                    anchors.fill: parent
//                    radius: parent.width / 2
//                }
            }
        }
    }

    onCurrentSpotlightChanged: {
        redSlider.dynamicValue = currentSpotlight.color.r
        greenSlider.dynamicValue = currentSpotlight.color.g
        blueSlider.dynamicValue = currentSpotlight.color.b
        alphaSlider.dynamicValue = currentSpotlight.color.a
    }


    DynamicSlider {
        id: greenSlider
        visible: true
        x: 0
        y: 0
        width: parent.width
        height: edgewidth
        background: Rectangle { visible:false }
        handle: Rectangle { visible:false }
        onDynamicValueChanged: { currentSpotlight.color.g = dynamicValue }
    }

    DynamicSlider {
        id: alphaSlider
        visible: true
        x: 0
        y: parent.height - edgewidth
        width: parent.width
        height: edgewidth
        background: Rectangle { visible:false }
        handle: Rectangle { visible:false }
        onDynamicValueChanged: { currentSpotlight.color.a = dynamicValue }
    }

    DynamicSlider {
        id: redSlider
        visible: true
        x: 0
        y: 0
        width: edgewidth
        height: parent.height
        orientation: Qt.Vertical
        background: Rectangle { visible:false }
        handle: Rectangle { visible:false }
        onDynamicValueChanged: { currentSpotlight.color.r = dynamicValue }
    }

    DynamicSlider {
        id: blueSlider
        visible: true
        x: parent.width - edgewidth
        y: 0
        width: edgewidth
        height: parent.height
        orientation: Qt.Vertical
        background: Rectangle { visible:false }
        handle: Rectangle { visible:false }
        onDynamicValueChanged: { currentSpotlight.color.b = dynamicValue }
    }

}
