import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    color: 'black'
    title: qsTr("Display")

    property real edgewidth: Math.min(width, height) * 0.15
    property real spotlightRadius: edgewidth * 1.5
    property Item currentSpotlight

    MouseArea {
        visible: true
        x: edgewidth
        y: edgewidth
        width: parent.width - edgewidth * 2
        height: parent.height - edgewidth * 2
        onClicked: {
            currentSpotlight = spotlightComponent.createObject(parent, {
                "x": x + mouseX - spotlightRadius,
                "y": y + mouseY - spotlightRadius,
                "width": spotlightRadius * 2,
                "height": spotlightRadius * 2
            })
        }
    }

    Component {
        id: spotlightComponent
        Rectangle {
            id: spotlightCircle
            visible: true
            x: parent.x
            y: parent.y
            width: parent.width
            height: parent.height
            radius: Math.max(parent.width, parent.height) / 2
            color: Qt.rgba(Math.random()*0.5+0.5,Math.random()*0.5+0.5,Math.random()*0.5+0.5,0.5);
            RoundMouseArea {
                id: roundMouseArea
                anchors.fill: parent
                drag.target: parent
                drag.threshold: 1
                onDoubleclicked: parent.destroy()
                onClicked: currentSpotlight = parent
                onWheel: { parent.z += wheel.pixelDelta.y; currentSpotlight = parent }
            }
        }
    }

    onCurrentSpotlightChanged: {
        redSlider.value = currentSpotlight.color.r
        greenSlider.value = currentSpotlight.color.g
        blueSlider.value = currentSpotlight.color.b
        alphaSlider.value = currentSpotlight.color.a
    }


    Slider {
        id: greenSlider
        visible: true
        x: edgewidth
        y: 0
        width: parent.width - edgewidth * 2
        height: edgewidth
        onValueChanged: { currentSpotlight.color.g = value }
    }

    Slider {
        id: alphaSlider
        visible: true
        x: edgewidth
        y: parent.height - edgewidth
        width: parent.width - edgewidth * 2
        height: edgewidth
        onValueChanged: { currentSpotlight.color.a = value }
    }

    Slider {
        id: redSlider
        visible: true
        x: 0
        y: edgewidth
        width: edgewidth
        height: parent.height - edgewidth * 2
        orientation: Qt.Vertical
        onValueChanged: { currentSpotlight.color.r = value }
    }

    Slider {
        id: blueSlider
        visible: true
        x: parent.width - edgewidth
        y: edgewidth
        width: edgewidth
        height: parent.height - edgewidth * 2
        orientation: Qt.Vertical
        onValueChanged: { currentSpotlight.color.b = value }
    }

}
