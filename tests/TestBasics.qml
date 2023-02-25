import Coffee.Style
import QtQuick.Layouts

ApplicationWindow {
    id: root
    width: 500
    height: 500

    menuBar: MenuBar {
        rootWindow: root
        infoText: qsTr("Hello Blessed Style")

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
            title: "0xCAFE"
        }
    }

    RowLayout {
        anchors.fill: parent
        Sidebar {
            id: leftSidebar
            Layout.fillHeight: true
            Layout.preferredWidth: 50
            rootWindow: root
            topItems: [
                SidebarEntry {
                    checked: true
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    checked: true
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                }
            ]
            bottomItems: [
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                },
                SidebarEntry {
                    icon.source: "qrc:/globe.svg"
                }
            ]
        }
    }
}
