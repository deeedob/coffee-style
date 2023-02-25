import QtQuick
import QtQuick.Layouts
import Coffee.Style

Rectangle {
    id: control
    color: CoffeeStyle.area2

    required property ApplicationWindow rootWindow
    property list<SidebarEntry> topItems
    property list<SidebarEntry> bottomItems

    ColumnLayout {
        anchors.fill: control
        spacing: 10

        CheckableButtonGroup {
            Layout.fillWidth: true
            Layout.topMargin: 5
            contentChildren: control.topItems
            spacing: 5
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
            Layout.bottomMargin: 5
            contentChildren: control.bottomItems
        }
    }
}
