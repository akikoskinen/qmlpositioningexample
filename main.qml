import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtPositioning 5.4

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Positioning example")

    PositionSource {
        id: positionSource
    }

    SourceErrorModel {
        id: sourceErrorModel
    }

    PositioningMethodsModel {
        id: positioningMethodsModel
    }

    function _boolAsString(b) {
        return b ? qsTr("True") : qsTr("False")
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

            WrappingLabel {
                text: qsTr("Plugin name: %1").arg(positionSource.name)
            }

            WrappingLabel {
                text: qsTr("Is valid: %1").arg(positionSource.valid ? "yes" : "no")
            }

            WrappingLabel {
                text: qsTr("Source error: %1").arg(sourceErrorModel.getDisplayText(positionSource.sourceError))
            }

            WrappingLabel {
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

            WrappingLabel {
                text: qsTr("Supported positioning methods: %1").arg(positioningMethodsModel.getDisplayText(positionSource.supportedPositioningMethods))
            }

            WrappingLabel {
                text: qsTr("Preferred positioning methods:")
            }

            ComboBox {
                model: positioningMethodsModel
                textRole: "display"
                Layout.fillWidth: true

                function _setSelectionToCurrentValue() {
                    currentIndex = positioningMethodsModel.getIndex(positionSource.preferredPositioningMethods)
                }

                Component.onCompleted: _setSelectionToCurrentValue()

                onActivated: {
                    var newValue = model.get(index).value
                    positionSource.preferredPositioningMethods = newValue
                    if (positionSource.preferredPositioningMethods !== newValue) {
                        _setSelectionToCurrentValue()
                        changedBySystemDialog.desiredMethod = newValue
                        changedBySystemDialog.actualMethod = positionSource.preferredPositioningMethods
                        changedBySystemDialog.open()
                    }
                }

                MessageDialog {
                    id: changedBySystemDialog
                    title: qsTr("Notice")
                    text: qsTr('You tried to set the preferred positioning methods to "%1" but the system changed it to "%2".').arg(positioningMethodsModel.getDisplayText(desiredMethod)).arg(positioningMethodsModel.getDisplayText(actualMethod))
                    property var desiredMethod
                    property var actualMethod
                }
            }

            RowLayout {
                spacing: scroll.padding

                Label {
                    text: qsTr("Position changed:")
                }

                Blinker {
                    id: updateBlinker
                    width: 24
                    height: width

                    Component.onCompleted: positionSource.positionChanged.connect(blink)
                }
            }

            GridLayout {
                columns: 3

                Label { text: qsTr("Position property"); font.bold: true }
                Label { text: qsTr("Is valid?"); font.bold: true }
                Label { text: qsTr("Value"); font.bold: true }

                Label { text: qsTr("Timestamp") }
                Label { text: " " }
                Label { text: Qt.formatDate(positionSource.position.timestamp, Qt.DefaultLocaleShortDate) + " " + Qt.formatTime(positionSource.position.timestamp, 'hh:mm:ss') }

                Label { text: qsTr("Latitude (deg)") }
                Label { text: _boolAsString(positionSource.position.latitudeValid) }
                Label { text: positionSource.position.coordinate.latitude }

                Label { text: qsTr("Longitude (deg)") }
                Label { text: _boolAsString(positionSource.position.longitudeValid) }
                Label { text: positionSource.position.coordinate.longitude }

                Label { text: qsTr("Altitude (m)") }
                Label { text: _boolAsString(positionSource.position.altitudeValid) }
                Label { text: positionSource.position.coordinate.altitude }

                Label { text: qsTr("Direction (deg)") }
                Label { text: _boolAsString(positionSource.position.directionValid) }
                Label { text: positionSource.position.direction }

                Label { text: qsTr("Speed (m/s)") }
                Label { text: _boolAsString(positionSource.position.speedValid) }
                Label { text: positionSource.position.speed }

                Label { text: qsTr("Vertical speed (m/s)") }
                Label { text: _boolAsString(positionSource.position.verticalSpeedValid) }
                Label { text: positionSource.position.verticalSpeed }

                Label { text: qsTr("Horiz. accuracy (m)") }
                Label { text: _boolAsString(positionSource.position.horizontalAccuracyValid) }
                Label { text: positionSource.position.horizontalAccuracy }

                Label { text: qsTr("Vert. accuracy (m)") }
                Label { text: _boolAsString(positionSource.position.verticalAccuracyValid) }
                Label { text: positionSource.position.verticalAccuracy }

                Label { text: qsTr("Magnetic variation (deg)") }
                Label { text: _boolAsString(positionSource.position.magneticVariationValid) }
                Label { text: positionSource.position.magneticVariation }
            }
        }
    }
}
