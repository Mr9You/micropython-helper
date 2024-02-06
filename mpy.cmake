# Set the board if it's not already set.
if(NOT MICROPY_BOARD)
    set(MICROPY_BOARD ESP32_GENERIC)
endif()

# Set the board directory and check that it exists.
if(NOT MICROPY_BOARD_DIR)
    set(MICROPY_BOARD_DIR ${MICROPY_HELPER_DIR}/micropython/ports/esp32/boards/${MICROPY_BOARD})
endif()
if(NOT EXISTS ${MICROPY_BOARD_DIR}/mpconfigboard.cmake)
    message(FATAL_ERROR "Invalid MICROPY_BOARD specified: ${MICROPY_BOARD}")
endif()

# Define the output sdkconfig so it goes in the build directory.
set(SDKCONFIG ${CMAKE_BINARY_DIR}/sdkconfig)

# Save the manifest file set from the cmake command line.
set(MICROPY_USER_FROZEN_MANIFEST ${MICROPY_FROZEN_MANIFEST})

# Include board config; this is expected to set (among other options):
# - SDKCONFIG_DEFAULTS
# - IDF_TARGET
include(${MICROPY_BOARD_DIR}/mpconfigboard.cmake)

# Set the frozen manifest file. Note if MICROPY_FROZEN_MANIFEST is set from the cmake
# command line, then it will override the default and any manifest set by the board.
if (MICROPY_USER_FROZEN_MANIFEST)
    set(MICROPY_FROZEN_MANIFEST ${MICROPY_USER_FROZEN_MANIFEST})
elseif (NOT MICROPY_FROZEN_MANIFEST)
    set(MICROPY_FROZEN_MANIFEST ${MICROPY_HELPER_DIR}/micropython/ports/esp32/boards/manifest.py)
endif()

# Concatenate all sdkconfig files into a combined one for the IDF to use.
file(WRITE ${CMAKE_BINARY_DIR}/sdkconfig.combined.in "")
foreach(SDKCONFIG_DEFAULT ${SDKCONFIG_DEFAULTS})
    file(READ ${MICROPY_HELPER_DIR}/micropython/ports/esp32/${SDKCONFIG_DEFAULT} CONTENTS)
    string(REPLACE "partitions" "${MICROPY_HELPER_DIR}/micropython/ports/esp32/partitions" NEW_CONTENT ${CONTENTS})
    file(APPEND ${CMAKE_BINARY_DIR}/sdkconfig.combined.in "${NEW_CONTENT}")
endforeach()
configure_file(${CMAKE_BINARY_DIR}/sdkconfig.combined.in ${CMAKE_BINARY_DIR}/sdkconfig.combined COPYONLY)

set(SDKCONFIG_DEFAULTS "sdkconfig.defaults" ${CMAKE_BINARY_DIR}/sdkconfig.combined)

# Use the sdkconfig in build directory, so remove the one in user application directory.
file(REMOVE_RECURSE ${CMAKE_CURRENT_SOURCE_DIR}/sdkconfig)

# Workaround to avoid the error of IDF component manager when some content is modified.
file(REMOVE_RECURSE ${MICROPY_HELPER_DIR}/micropython/mpy-cross/build)
file(REMOVE_RECURSE ${MICROPY_HELPER_DIR}/micropython/mpy-cross/mpy_cross/__pycache__)
file(REMOVE_RECURSE ${MICROPY_HELPER_DIR}/micropython/py/__pycache__)
file(REMOVE_RECURSE ${MICROPY_HELPER_DIR}/micropython/tools/__pycache__)