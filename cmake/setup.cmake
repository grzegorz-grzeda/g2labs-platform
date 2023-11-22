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
function(g2labs_platform_set target_platform target_platform_variant)
    set(G2LABS_TARGET_PLATFORM ${target_platform} CACHE STRING PARENT_SCOPE FORCE)
    set(G2LABS_PLATFORM_TARGET ${target_platform} CACHE STRING PARENT_SCOPE FORCE)
    set(G2LABS_TARGET_PLATFORM_VARIANT ${target_platform_variant} CACHE STRING PARENT_SCOPE FORCE)

    if(${target_platform} STREQUAL "esp32")
        set(ESP_TARGET ${target_platform_variant} CACHE STRING PARENT_SCOPE FORCE)
        set(CMAKE_TOOLCHAIN_FILE $ENV{IDF_PATH}/tools/cmake/toolchain-${ESP_TARGET}.cmake CACHE PATH PARENT_SCOPE FORCE)
    endif()
endfunction()