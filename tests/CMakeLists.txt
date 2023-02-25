cmake_minimum_required(VERSION 3.16)

qt_add_executable(test1
    testBasics.cpp
)

target_link_libraries(test1 PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
    coffeestyle
)

qt_add_qml_module(test1
    URI Tests
    QML_FILES
    TestBasics.qml
    NO_RESOURCE_TARGET_PATH
    AUTO_RESOURCE_PREFIX
)

