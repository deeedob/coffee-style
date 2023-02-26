import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import Coffee.Style

T.TextArea {
    id: control

    color: enabled ? CoffeeStyle.text : CoffeeStyle.disabledText
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding, implicitBackgroundHeight + topInset + bottomInset, placeholder.implicitHeight + 1 + topPadding + bottomPadding)
    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding, implicitBackgroundWidth + leftInset + rightInset, placeholder.implicitWidth + leftPadding + rightPadding)
    placeholderTextColor: CoffeeStyle.disabledText
    selectedTextColor: CoffeeStyle.text
    selectionColor: CoffeeStyle.highlightedText

    background: null
    cursorDelegate: null

    PlaceholderText {
        id: placeholder

        color: control.placeholderTextColor
        elide: Text.ElideRight
        font: control.font
        height: control.height - (control.topPadding + control.bottomPadding)
        renderType: control.renderType
        text: control.placeholderText
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        width: control.width - (control.leftPadding + control.rightPadding)
        x: control.leftPadding
        y: control.topPadding
    }
}
