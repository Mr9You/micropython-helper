# For more information about build system see
# https://docs.espressif.com/projects/esp-idf/en/latest/api-guides/build-system.html
# The following five lines of boilerplate have to be in your project's
# CMakeLists in this exact order for cmake to work correctly
cmake_minimum_required(VERSION 3.16)

if(NOT MICROPY_HELPER_DIR)
    set(MICROPY_HELPER_DIR ${CMAKE_CURRENT_SOURCE_DIR}/managed_components/mr9you__micropython-helper)
endif()

if(EXISTS ${MICROPY_HELPER_DIR})
    include(${MICROPY_HELPER_DIR}/mpy.cmake)
endif()

include($ENV{IDF_PATH}/tools/cmake/project.cmake)

project(std_mpy)
