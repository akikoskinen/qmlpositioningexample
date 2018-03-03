import QtQuick 2.7
import QtPositioning 5.0

ListModel {
    ListElement {
        value: PositionSource.NoPositioningMethods
        display: qsTr("None")
    }
    ListElement {
        value: PositionSource.SatellitePositioningMethods
        display: qsTr("Only satellite")
    }
    ListElement {
        value: PositionSource.NonSatellitePositioningMethods
        display: qsTr("Only non-satellite")
    }
    ListElement {
        value: PositionSource.AllPositioningMethods
        display: qsTr("Both satellite and non-satellite")
    }

    function getIndex(method) {
        for (var i = 0; i < count; i++) {
            var item = get(i)
            if (item.value === method) {
                return i
            }
        }
    }

    function getDisplayText(method) {
        return (get(getIndex(method)) || {}).display
    }
}
