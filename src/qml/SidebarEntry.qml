import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Coffee.Style

Button {
    id: control
    icon.width: parent.width / 1.5
    icon.height: parent.width / 1.5
    icon.color: down || checked ? CoffeeStyle.indicator : CoffeeStyle.icon

    topPadding: 0
    topInset: 0
    rightPadding: 0
    rightInset: 0
    bottomPadding: 0
    bottomInset: 0
    leftPadding: 0
    leftInset: 0

    checkable: true
    Layout.fillWidth: true

    contentItem: IconLabel {
        anchors.centerIn: control
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
    }

    background: null

    Rectangle {
        id: indicator
        width: 3
        height: control.icon.width - 2
        anchors.verticalCenter: parent.verticalCenter

        opacity: control.checked ? 1.0 : 0.0
        color: CoffeeStyle.panelIndicator

        Behavior on opacity {
            OpacityAnimator {
                duration: 400
            }
        }
    }
}
