import QtQuick
import QtQuick.Templates as T
import Coffee.Style

T.ScrollIndicator {
    id: control

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    padding: 2

    contentItem: Rectangle {
        color: CoffeeStyle.panelIndicator
        implicitHeight: 6
        implicitWidth: 6
        opacity: control.active ? 0.75 : 0.0

        Behavior on opacity  {
            OpacityAnimator {
                duration: 700
            }
        }
    }
}
