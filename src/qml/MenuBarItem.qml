import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Coffee.Style

T.MenuBarItem {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    spacing: 0
    padding: 0
    leftPadding: 12
    rightPadding: 12

    contentItem: Text {
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: CoffeeStyle.text
        opacity: enabled ? 1.0 : 0.3
        text: control.text
        font: control.font
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: CoffeeStyle.menuBarHeight
        color: control.highlighted ? CoffeeStyle.highlighted : CoffeeStyle.area2
    }
}
