import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Coffee.Style

T.MenuItem {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6
    contentItem: Item {
        Text {
            id: text
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: control.text
            color: enabled ? CoffeeStyle.text : CoffeeStyle.disabledText
            font: control.font
        }
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.leftMargin: 5
            width: 3
            height: parent.height
            visible: control.highlighted
            color: CoffeeStyle.panelIndicator
        }
    }

    indicator: null

    arrow: null

    background: Rectangle {
        implicitWidth: 60
        implicitHeight: CoffeeStyle.menuBarHeight
        color: control.highlighted ? CoffeeStyle.highlighted : "transparent"
    }
}
