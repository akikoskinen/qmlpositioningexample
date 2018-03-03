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

    PositioningMethodsModel {
        id: positioningMethodsModel
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
                text: qsTr("Supported positioning methods: %1").arg(positioningMethodsModel.getDisplayText(positionSource.supportedPositioningMethods))
                Layout.fillWidth: true
                wrapMode: Text.Wrap
            }

            Label {
                text: qsTr("Preferred positioning methods: %1").arg(positioningMethodsModel.getDisplayText(positionSource.preferredPositioningMethods))
                Layout.fillWidth: true
                wrapMode: Text.Wrap
            }

            ComboBox {
                model: positioningMethodsModel
                textRole: "display"
                Layout.fillWidth: true

                onActivated: {
                    positionSource.preferredPositioningMethods = model.get(index).value
                }

                Component.onCompleted: {
                    currentIndex = positioningMethodsModel.getIndex(positionSource.preferredPositioningMethods)
                }
            }
        }
    }
}
