cmake_minimum_required(VERSION 3.18.2 FATAL_ERROR)

project(
    DQ3PRAC
    VERSION 0.1.0
    LANGUAGES C)

set(CMAKE_ASM_COMPILER asar)

set(DQ3PRAC_CMAKE_MODULE_DIR ${PROJECT_SOURCE_DIR}/cmake/module)
set(DQ3PRAC_ROM_DIR ${PROJECT_SOURCE_DIR}/rom)

include(${DQ3PRAC_CMAKE_MODULE_DIR}/asar.cmake)

add_subdirectory(src)
