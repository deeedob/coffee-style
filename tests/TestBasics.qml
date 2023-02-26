import QtQuick
import QtQuick.Layouts
import Coffee.Style
import Coffee.Controls

ApplicationWindow {
    id: root

    height: 500
    width: 500

    footer: BorderRectangle {
        borderColor: CoffeeStyle.splitter
        color: CoffeeStyle.area1
        height: CoffeeStyle.menuBarHeight
        topBorder: 2

        Text {
            anchors.centerIn: parent
            text: "footer bar"
        }
    }
    menuBar: MenuBar {
        infoText: qsTr("Window Title")
        rootWindow: root

        Menu {
            title: qsTr("Hello")

            Action {
                text: qsTr("One")
            }
            Action {
                text: qsTr("Two")
            }
            Action {
                text: qsTr("Three")
            }
            Action {
                text: qsTr("One Two Three")
            }
        }
        Menu {
            title: qsTr("World")

            Action {
                text: qsTr("One")
            }
            Action {
                text: qsTr("Two")
            }
            Action {
                text: qsTr("Three")
            }
        }
        Menu {
            title: "Coffee"
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Sidebar {
            id: leftSidebar

            Layout.fillHeight: true
            Layout.preferredWidth: CoffeeStyle.menuBarHeight * 1.5
            rootWindow: root

            bottomItems: [
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                }
            ]
            topItems: [
                SidebarEntry {
                    checked: true
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                }
            ]
        }
        SplitView {
            id: resizableContentArea

            Layout.fillHeight: true
            Layout.fillWidth: true
            orientation: Qt.Vertical

            SplitView {
                id: mainView

                SplitView.fillHeight: true
                SplitView.fillWidth: true
                orientation: Qt.Horizontal

                BorderRectangle {
                    id: navigationView

                    SplitView.fillHeight: true
                    SplitView.preferredWidth: 250
                    borderColor: CoffeeStyle.splitter
                    bottomBorder: 2
                    clip: true
                    color: CoffeeStyle.area1
                    rightBorder: 2

                    Text {
                        anchors.centerIn: parent
                        text: "Navigation View"
                    }
                }
                BorderRectangle {
                    id: mainContent

                    SplitView.fillHeight: true
                    SplitView.fillWidth: true
                    borderColor: CoffeeStyle.splitter
                    bottomBorder: 2
                    clip: true
                    color: CoffeeStyle.background
                    leftBorder: 2

                    Flickable {
                        anchors.fill: parent
                        boundsBehavior: Flickable.StopAtBounds
                        boundsMovement: Flickable.StopAtBounds
                        ScrollIndicator.vertical: ScrollIndicator {}
                        ScrollIndicator.horizontal: ScrollIndicator {}
                        TextArea.flickable: TextArea {
                            padding: 5
                            font.pixelSize: 300
                            text: "Hello World\nHello World\nHello World"
                        }
                    }
                }
            }
            BorderRectangle {
                id: bottomView

                SplitView.fillWidth: true
                SplitView.preferredHeight: 150
                borderColor: CoffeeStyle.splitter
                color: CoffeeStyle.background
                topBorder: 2

                Text {
                    anchors.centerIn: parent
                    text: "Bottom View"
                }
            }
        }
        Sidebar {
            id: rightSidebar

            Layout.alignment: Qt.AlignRight
            Layout.fillHeight: true
            Layout.preferredWidth: CoffeeStyle.menuBarHeight * 1.5
            rootWindow: root
        }
    }
}
