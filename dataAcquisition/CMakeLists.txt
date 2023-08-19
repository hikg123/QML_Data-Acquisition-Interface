cmake_minimum_required(VERSION 3.16)

project(untitled VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appuntitled
    main.cpp fileio.h fileio.cpp res.qrc
)

qt_add_qml_module(appuntitled
    URI untitled
    VERSION 1.0
    QML_FILES main.qml MyButton.qml Home.qml Config.qml  HomePage1.qml HomePage2.qml
    SelfCollect.qml Flood.qml EnergySpectrum.qml OriginalData.qml Singles.qml Coincide.qml
    HomePage3.qml SetTable.qml D1.qml dg/Debug1.qml dg/Debug2.qml


    RESOURCES img

)

set_target_properties(appuntitled PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appuntitled
    PRIVATE Qt6::Quick)

install(TARGETS appuntitled
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
