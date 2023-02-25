cmake_minimum_required(VERSION 3.16)

project(CoffeeStyle VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2)
qt_standard_project_setup()

list(APPEND QML_IMPORT_PATHS "${CMAKE_CURRENT_BINARY_DIR}/qml")
set(QML_IMPORT_PATH "${QML_IMPORT_PATHS}" CACHE STRING "Qt Creator QML import paths")

find_package(toml11)
if (NOT toml11_FOUND)
    include(FetchContent)
    FetchContent_Declare(
        toml11
        GIT_REPOSITORY https://github.com/ToruNiina/toml11.git
        GIT_TAG v3.7.1
    )
    FetchContent_MakeAvailable(toml11)
endif ()

function(add_subdirectory_ordered)
    # build subdirectories in order
    # note: this can break in edge-cases
    # https://gitlab.kitware.com/cmake/cmake/-/issues/22157
    list(JOIN ARGV " " argv_str) # TODO quote args
    message(VERBOSE "add_subdirectory_ordered: add_subdirectory(${argv_str})")
    # https://cmake.org/cmake/help/latest/command/add_subdirectory.html
    # add_subdirectory(source_dir [binary_dir] [EXCLUDE_FROM_ALL])
    add_subdirectory(${ARGV})
    list(GET ARGV 0 source_dir)
    get_property(last_subdir_all_targets DIRECTORY "${source_dir}" PROPERTY BUILDSYSTEM_TARGETS)
    set(last_subdir_main_targets)
    foreach(subdir_target ${last_subdir_all_targets})
        get_property(type TARGET ${subdir_target} PROPERTY TYPE)
        if(type STREQUAL "EXECUTABLE" OR type MATCHES "LIBRARY$")
            message(VERBOSE "add_subdirectory_ordered: target ${subdir_target} has type ${type} -> is a main target")
            list(APPEND last_subdir_main_targets ${subdir_target})
        else()
            message(VERBOSE "add_subdirectory_ordered: target ${subdir_target} has type ${type} -> is not a main target")
        endif()
    endforeach()
    if(all_previous_targets)
        foreach(subdir_target ${last_subdir_main_targets})
            list(JOIN all_previous_targets " " all_previous_targets_str)
            message(STATUS "add_subdirectory_ordered: build order: ${all_previous_targets_str} ${subdir_target}")
            add_dependencies(${subdir_target} ${all_previous_targets})
        endforeach()
    endif()
    set(all_previous_targets_local ${all_previous_targets})
    list(APPEND all_previous_targets_local ${last_subdir_main_targets})
    set(all_previous_targets ${all_previous_targets_local} PARENT_SCOPE)
endfunction()

add_subdirectory_ordered(src)
add_subdirectory_ordered(tests)
