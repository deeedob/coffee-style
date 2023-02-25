import QtQuick
import QtQuick.Window
import QtQuick.Templates as T
import Coffee.Style

T.ApplicationWindow {
    id: window
    visible: true
    color: CoffeeStyle.background
    flags: Qt.Window | Qt.FramelessWindowHint
}
