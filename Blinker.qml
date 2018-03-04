import QtQuick 2.7

Rectangle {
    id: root
    radius: Math.min(width, height) / 2
    color: "green"
    opacity: 0

    SequentialAnimation {
        id: blinkAnimator
        running: false

        OpacityAnimator {
            target: root
            from: 0
            to: 1
            duration: 50
        }
        OpacityAnimator {
            target: root
            from: 1
            to: 0
            duration: 150
        }
    }

    function blink() {
        blinkAnimator.restart()
    }
}
