import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Coffee.Style

T.MenuBar {
    id: control

    required property ApplicationWindow rootWindow
    property alias infoText: windowInfo.text

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    delegate: MenuBarItem {}

    contentItem: RowLayout {

        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: control.spacing

        Repeater {
            Layout.alignment: Qt.AlignLeft
            model: control.contentModel
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                id: windowInfo
                width: parent.width
                height: parent.height
                color: CoffeeStyle.text
                font: control.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                clip: true
            }
        }

        RowLayout {
            id: windowActions
            spacing: 0
            Layout.alignment: Qt.AlignRight
            Layout.fillHeight: true
            Layout.preferredWidth: control.height * 3

            component InteractionButton: Rectangle {
                signal action
                property alias hovered: hoverHandler.hovered

                Layout.fillHeight: true
                Layout.preferredWidth: height
                color: hovered ? CoffeeStyle.background : CoffeeStyle.area2

                HoverHandler {
                    id: hoverHandler
                }
                TapHandler {
                    onTapped: action()
                }
            }

            InteractionButton {
                id: minimize
                onAction: rootWindow.showMinimized()
                Rectangle {
                    anchors.centerIn: parent
                    color: parent.hovered ? CoffeeStyle.indicator : CoffeeStyle.icon
                    height: 2
                    width: parent.height - 10
                }
            }

            InteractionButton {
                id: maximize
                onAction: rootWindow.showMaximized()
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 5
                    border.color: parent.hovered ? CoffeeStyle.indicator : CoffeeStyle.icon
                    border.width: 2
                    color: "transparent"
                }
            }

            InteractionButton {
                id: close
                color: hovered ? "#ec4143" : CoffeeStyle.area2
                onAction: rootWindow.close()
                Rectangle {
                    anchors.centerIn: parent
                    antialiasing: true
                    color: parent.hovered ? CoffeeStyle.indicator : CoffeeStyle.icon
                    height: 2
                    rotation: 45
                    transformOrigin: Item.Center
                    width: parent.height - 8

                    Rectangle {
                        anchors.centerIn: parent
                        antialiasing: true
                        color: parent.color
                        height: parent.width
                        width: parent.height
                    }
                }
            }
        }
    }

    background: Rectangle {
        color: CoffeeStyle.area2
        implicitHeight: CoffeeStyle.menuBarHeight
        Layout.fillWidth: true
        // Make the empty space drag the specified root window.
        WindowDragHandler {
            dragWindow: rootWindow
        }
    }
}
