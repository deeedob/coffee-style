import QtQuick
import QtQuick.Layouts
import Coffee.Style

Rectangle {
    id: control
    color: CoffeeStyle.area2

    required property ApplicationWindow rootWindow
    property list<SidebarEntry> topItems
    property list<SidebarEntry> bottomItems
    property int spacing: 10
    z: 1

    ColumnLayout {
        anchors.fill: control
        spacing: control.spacing

        CheckableButtonGroup {
            Layout.fillWidth: true
            Layout.topMargin: control.spacing
            contentChildren: control.topItems
            spacing: control.spacing
        }

        // This item acts as a spacer to expand between the checkable and non-checkable buttons.
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            // Make the empty space drag our main window.
            WindowDragHandler {
                dragWindow: rootWindow
            }
        }

        CheckableButtonGroup {
            Layout.fillWidth: true
            Layout.bottomMargin: 10
            contentChildren: control.bottomItems
            spacing: control.spacing
        }
    }
}
