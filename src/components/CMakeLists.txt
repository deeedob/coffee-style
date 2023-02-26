file(REAL_PATH "../../qml/Coffee/Controls" QML_OUTPUT_DIR BASE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

qt_add_qml_module(coffeecontrols
    URI "Coffee.Controls"
    VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
    OUTPUT_DIRECTORY ${QML_OUTPUT_DIR}
    AUTO_RESOURCE_PREFIX
    CLASS_NAME CoffeeControls
    SOURCES
        borderrectangle.cpp
        borderrectangle.hpp
)

target_link_libraries(coffeecontrols PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)
