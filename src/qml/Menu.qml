import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Coffee.Style

T.Menu {
    id: control
    // TODO: figure out how to properly adapt the width of the content
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    margins: 0
    overlap: 1

    delegate: MenuItem {}

    contentItem: ListView {
        implicitHeight: contentHeight
        implicitWidth: contentWidth
        model: control.contentModel
        interactive: Window.window ? contentHeight + control.topPadding
                                     + control.bottomPadding > Window.window.height : false
        clip: true
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator {}
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: CoffeeStyle.menuBarHeight
        color: CoffeeStyle.area2
    }

    T.Overlay.modal: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.12)
    }
}
