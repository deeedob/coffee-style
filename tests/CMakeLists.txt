cmake_minimum_required(VERSION 3.16)

qt_add_executable(testBasic
    testBasics.cpp
)

target_link_libraries(testBasic PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
    coffeestyle
    coffeecontrols
)

qt_add_qml_module(testBasic
    URI Tests
    QML_FILES
    TestBasics.qml
    RESOURCE_PREFIX "/"
    NO_RESOURCE_TARGET_PATH
    RESOURCES
        globe.svg
)

