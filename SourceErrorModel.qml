import QtQuick 2.7
import QtPositioning 5.0

ListModel {
    ListElement {
        value: PositionSource.AccessError
        display: qsTr("Access error")
    }
    ListElement {
        value: PositionSource.ClosedError
        display: qsTr("Closed error")
    }
    ListElement {
        value: PositionSource.NoError
        display: qsTr("No error")
    }
    ListElement {
        value: PositionSource.UnknownSourceError
        display: qsTr("Unknown error")
    }
    ListElement {
        value: PositionSource.SocketError
        display: qsTr("Socket error")
    }

    function getIndex(value) {
        for (var i = 0; i < count; i++) {
            var item = get(i)
            if (item.value === value) {
                return i
            }
        }
    }

    function getDisplayText(value) {
        return (get(getIndex(value)) || {}).display
    }
}
