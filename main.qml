import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtPositioning 5.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Positioning example")

    PositionSource {
        id: positionSource
    }

    ScrollView {
        id: scroll
        anchors.fill: parent
        contentWidth: column.width
        padding: 8

        ColumnLayout {
            id: column
            width: scroll.width - scroll.padding * 2
            spacing: scroll.padding

            RowLayout {
                spacing: scroll.padding

                Label {
                    text: qsTr("Positioning:")
                }

                Button {
                    text: positionSource.active ? qsTr("on") : qsTr("off")
                    onClicked: {
                        positionSource.active = !positionSource.active
                    }
                }
            }

            Label {
                text: qsTr("Is valid: %1").arg(positionSource.valid ? "yes" : "no")
            }

            Label {
                text: qsTr("Update interval: %1ms").arg(positionSource.updateInterval)
            }

            Slider {
                from: 0
                to: 10000
                value: positionSource.updateInterval
                live: false
                stepSize: 1000
                snapMode: Slider.SnapAlways
                onValueChanged: positionSource.updateInterval = value
                Layout.fillWidth: true
            }

            Label {
                property string _methods: {
                    switch (positionSource.supportedPositioningMethods) {
                    case PositionSource.NoPositioningMethods:
                        return qsTr("none")
                    case PositionSource.SatellitePositioningMethods:
                        return qsTr("only satellite")
                    case PositionSource.NonSatellitePositioningMethods:
                        return qsTr("only non-satellite")
                    case PositionSource.AllPositioningMethods:
                        return qsTr("both satellite and non-satellite")
                    }
                }

                text: qsTr("Supported positioning methods: %1").arg(_methods)
                Layout.fillWidth: true
                wrapMode: Text.Wrap
            }
        }
    }
}
