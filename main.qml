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
        }
    }
}