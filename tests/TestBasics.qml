import Coffee.Style

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
            title: "A"
        }
    }
}
