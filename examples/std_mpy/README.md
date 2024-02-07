# Standard MicroPython Firmware

This example utilizes `micropython-helper` to build standard MicroPython firmware. There are two ways to initiate the MicroPython service. One option is to simply call the `mpy_startup` function, which functions similarly to MicroPython's `app_main`. The other approach involves manually starting up MicroPython, in which case, you may wish to integrate some of your proprietary logic.

For the build process, the following points should be noted:

1. The `CMakeLists.txt` file at the top level of this project is slightly different from the normal example's `CMakeLists.txt`.
2. It is necessary to `run idf.py set-target esp32s3` or choose another target before building the firmware.
3. After completing step 2, you can run `idf.py -D MICROPY_BOARD=ESP32_GENERIC_S3` build to build the firmware.
4. To simplify the command, you may first `export MICROPY_BOARD=ESP32_GENERIC_S3`, and then run any other `idf.py` command, such as `idf.py menuconfig`, `idf.py build`, `idf.py flash monitor`, etc.

For any other information about MicroPython itself, please refer to [MicroPython Documentation](https://docs.micropython.org/en/latest/index.html).