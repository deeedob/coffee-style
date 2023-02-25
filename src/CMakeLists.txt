file(REAL_PATH "../qml/Coffee/Style" QML_OUTPUT_DIR BASE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

qt_policy(SET QTP0001 NEW)

set(QML_FILES
    "qml/ApplicationWindow.qml"
    "qml/MenuBar.qml"
    "qml/MenuBarItem.qml"
    "qml/Menu.qml"
    "qml/MenuItem.qml"
    "qml/Sidebar.qml"
    "qml/SidebarEntry.qml"
    "qml/Icon.qml"
    "qml/CheckableButtonGroup.qml"
    "qml/WindowDragHandler.qml"
)

# Add schemes and font resources
set(COLOR_SCHEMES_REL)
file(GLOB COLOR_SCHEMES "${CMAKE_CURRENT_SOURCE_DIR}/schemes/*.toml")
foreach(SCHEME ${COLOR_SCHEMES})
    file(RELATIVE_PATH REL_PATH "${CMAKE_CURRENT_SOURCE_DIR}" "${SCHEME}")
    list(APPEND COLOR_SCHEMES_REL ${REL_PATH})
endforeach()
set(FONTS_REL)
file(GLOB FONTS "${CMAKE_CURRENT_SOURCE_DIR}/fonts/*.ttf")
foreach(FONT ${FONTS})
    file(RELATIVE_PATH REL_PATH "${CMAKE_CURRENT_SOURCE_DIR}" "${FONT}")
    list(APPEND FONTS_REL ${REL_PATH})
endforeach()

message("Color Schemes      : " ${COLOR_SCHEMES_REL})
message("Font files         : " ${FONTS_REL})

set(ALL_RESOURCES ${COLOR_SCHEMES_REL} ${FONTS_REL})

qt_add_qml_module(coffeestyle
    URI "Coffee.Style"
    VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
    OUTPUT_DIRECTORY ${QML_OUTPUT_DIR}
    AUTO_RESOURCE_PREFIX
    CLASS_NAME CoffeeStyle
    IMPORTS
        QtQuick.Controls.Basic # Fallback style
    QML_FILES
        "${QML_FILES}"
    SOURCES
    coffeestyle.cpp
    coffeestyle.hpp
    RESOURCES
        schemes/catpuccin.toml
)

include(GenerateExportHeader)
target_include_directories(coffeestyle PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_include_directories(coffeestyle PRIVATE third-party/toml11)
generate_export_header(coffeestyle)

target_link_libraries(coffeestyle PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::QuickControls2
    toml11::toml11
)
