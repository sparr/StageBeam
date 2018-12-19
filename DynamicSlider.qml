/*
 * This Slider behaves as usual when you start sliding from the handle.
 * When you start sliding from a different location, the behavior changes:
 * The start position becomes equivalent to the previous dynamicValue
 * The range left and right of that position extend proportionally
 * Examples:
 * Slider from 0 to 100, current value is 20.
 * Drag from 20% position to 80% position, new value is 80. (normal handle drag)
 * Drag from 50% position, the left half now represents 0-20, right half 20-100.
 * Drag from 50% to 25%, new value is 10.
 * Drag from 50% to 75%, new value is 60.
 */

import QtQuick 2.0
import QtQuick.Controls 2.5

Slider {
    property bool gotStart: false
    property real start
    property real dynamicStart
    property real dynamicValue: value
    onPressedChanged: {
        gotStart = false
        if (pressed) {
            dynamicStart = dynamicValue
        }
        else {
            value = dynamicValue
        }
    }
    onValueChanged: {
        if (!gotStart) {
            start = value
            gotStart = true
        }
        else {
            if (value < start) {
                dynamicValue =
                    from +
                    (dynamicStart - from) *
                    ((value - from) / (start - from))
            }
            else if (value > start) {
                dynamicValue =
                    dynamicStart +
                    (to - dynamicStart) *
                    ((value - start) / (to - start))
            }
            else {
                dynamicValue = value
            }

        }
    }
}
