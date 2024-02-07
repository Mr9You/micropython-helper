# MicroPython Helper

[![Component Registry](https://components.espressif.com/components/mr9you/micropython-helper/badge.svg)](https://components.espressif.com/components/mr9you/micropython-helper)

In some cases, developers may wish to integrate MicroPython into existing ESP-related projects as an ESP-IDF component, rather than developing it as standalone ESP32 firmware. This component facilitates the use of MicroPython within the ESP-IDF framework.

In this component, the original MicroPython is integrated without any modifications. This allows for the full utilization of the build logic, code, and configurations, with only minimal modifications made outside of MicroPython itself.

All features and use cases should be exactly the same as in the original MicroPython.

## How to use?

This component is distributed via [IDF component manager](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/tools/idf-component-manager.html). Just add `idf_component.yml` file to your main component with the following content:

```yaml
## IDF Component Manager Manifest File
dependencies:
  mr9you/micropython-helper: "~1.22.1"
```

Or simply run:

```
idf.py add-dependency "micropython-helper"
```

In the CMakeLists.txt file at the top level of your application, you need to add the following code before including IDF's project.cmake:

```cmake
if(NOT MICROPY_HELPER_DIR)
    set(MICROPY_HELPER_DIR ${CMAKE_CURRENT_SOURCE_DIR}/managed_components/mr9you__micropython-helper)
endif()

if(EXISTS ${MICROPY_HELPER_DIR})
    include(${MICROPY_HELPER_DIR}/mpy.cmake)
endif()
```

At this stage, the `micropython-helper` component is not downloaded by the IDF component manager, so this part of the code will not take effect. To ensure its effectiveness, you need to run `idf.py set-target esp32s3`, or select any other target you intend to use. This will prompt the download of the micropython-helper component, allowing you to use the original command, such as `idf.py -D MICROPY_BOARD=ESP32_GENERIC_S3 build`. Please ensure to address this issue accordingly.
