import QtQuick
import QtQuick.Layouts
import Coffee.Style

Container {
    id: tabBar

    // ButtonGroup ensures that only one button can be checked at a time.
    ButtonGroup {
        buttons: tabBar.contentItem.children
        onCheckedButtonChanged: tabBar.setCurrentIndex(
                                    Math.max(0, buttons.indexOf(checkedButton)))
    }

    contentItem: ColumnLayout {
        spacing: tabBar.spacing

        Repeater {
            model: tabBar.contentModel
        }
    }
}
