import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import Coffee.Style

T.SplitView {
    id: control

    property color handleBackgroundColor: CoffeeStyle.background

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)

    handle: Rectangle {
        color: T.SplitHandle.pressed ? CoffeeStyle.panelIndicator : handleBackgroundColor
        implicitHeight: control.orientation === Qt.Horizontal ? control.height : 8
        implicitWidth: control.orientation === Qt.Horizontal ? 8 : control.width
    }
}
