import QtQuick
import QtQuick.Templates as T
import Coffee.Style

T.ScrollBar {
    id: control

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    minimumSize: orientation === Qt.Horizontal ? height / width : width / height
    padding: control.interactive ? 1 : 2
    visible: control.policy !== T.ScrollBar.AlwaysOff

    background: Rectangle {
        color: CoffeeStyle.background
        implicitHeight: control.interactive ? 8 : 4
        implicitWidth: control.interactive ? 8 : 4
        opacity: control.active ? 1.0 : 0.0

        Behavior on opacity  {
            OpacityAnimator {
                duration: 500
            }
        }
    }
    contentItem: Rectangle {
        color: CoffeeStyle.handleIndicator
        implicitHeight: control.interactive ? 8 : 4
        implicitWidth: control.interactive ? 8 : 4
        opacity: control.active ? 0.75 : 0.0
        Behavior on opacity {
            OpacityAnimator {
                duration: 1000
            }
        }
    }
}
