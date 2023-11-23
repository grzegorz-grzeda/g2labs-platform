# MIT License
#
# Copyright (c) 2023 G2Labs Grzegorz Grzęda
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
set(ESP32_PARTITION_TABLE_OFFSET 0x9000)
set(ESP32_PARTITION_TABLE_FILE_PATH ${CMAKE_CURRENT_LIST_DIR}/${ESP_TARGET}/partition_table.csv)
configure_file(${ESP_TARGET}/partition-table-sdkconfig.template ${CMAKE_CURRENT_LIST_DIR}/${ESP_TARGET}/partition-table-sdkconfig @ONLY)

list(APPEND ESP32_SDKCONFIG_FILES ${CMAKE_CURRENT_LIST_DIR}/${ESP_TARGET}/sdkconfig.defaults)
list(APPEND ESP32_SDKCONFIG_FILES ${CMAKE_CURRENT_LIST_DIR}/${ESP_TARGET}/partition-table-sdkconfig)

include($ENV{IDF_PATH}/tools/cmake/idf.cmake)

idf_build_process("${ESP_TARGET}"
    COMPONENTS
    freertos
    mqtt
    bt
    esp_wifi
    nvs_flash
    driver
    vfs
    spiffs
    esptool_py
    esp_http_client
    esp-tls
    app_update
    esp_timer
    fatfs
    SDKCONFIG ${CMAKE_BINARY_DIR}/sdkconfig
    SDKCONFIG_DEFAULTS ${ESP32_SDKCONFIG_FILES}
    BUILD_DIR ${CMAKE_BINARY_DIR})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(elf_file ${CMAKE_PROJECT_NAME}.elf)
add_executable(${elf_file} main.c)

target_link_libraries(${elf_file} PRIVATE idf::driver)

target_link_libraries(${elf_file} PRIVATE ${CMAKE_PROJECT_NAME})

if(DEFINED G2LABS_PLATFORM_MAIN_FS_IMAGE_DIR)
    spiffs_create_partition_image(storage ${G2LABS_PLATFORM_MAIN_FS_IMAGE_DIR} FLASH_IN_PROJECT)
endif()

add_custom_target(erase
    COMMAND python -m esptool --chip ${ESP_TARGET} -b 921600 erase_flash
)

add_custom_target(burn
    COMMAND python -m esptool --chip ${ESP_TARGET} -b 921600 write_flash @flash_args
    DEPENDS ${elf_file}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    USES_TERMINAL
)
idf_build_executable(${elf_file})
