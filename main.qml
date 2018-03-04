import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
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

            WrappingLabel {
                text: qsTr("Is valid: %1").arg(positionSource.valid ? "yes" : "no")
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
        }
    }
}
