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
            x: edgewidth
            y: edgewidth
            width: parent.width - edgewidth * 2
            height: parent.height - edgewidth * 2
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
                drag.target: parent
                drag.threshold: 1
                onDoubleClicked: parent.destroy()
                onClicked: currentSpotlight = parent
                onWheel: { parent.z += wheel.pixelDelta.y; currentSpotlight = parent }
            }
            ItemRadiusMask {
                id: mask
                anchors.fill: parent
                radius: parent.radius
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
