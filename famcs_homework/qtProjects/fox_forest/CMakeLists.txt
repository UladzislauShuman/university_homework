cmake_minimum_required(VERSION 3.21)
project(FoxAndField)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5 COMPONENTS
        Core
        Gui
        Widgets
        REQUIRED)

add_executable(FoxAndField main.cpp main_window.cpp main_window.h resources.qrc main_window.cpp main_window.h)
target_link_libraries(FoxAndField
        Qt::Core
        Qt::Gui
        Qt::Widgets
        )
