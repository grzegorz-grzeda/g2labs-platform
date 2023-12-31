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
if((DEFINED G2LABS_PLATFORM_TARGET) AND(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${G2LABS_PLATFORM_TARGET}))
    add_subdirectory(${G2LABS_PLATFORM_TARGET})
    set(G2LABS_PLATFORM_MAIN_NAME ${G2LABS_PLATFORM_TARGET})
else()
    message(FATAL_ERROR "Target platform not defined! Use cmake/setup.cmake 'g2labs_platform_set()'.")
endif()

file(GENERATE OUTPUT ${CMAKE_BINARY_DIR}/platform.txt CONTENT ${G2LABS_PLATFORM_MAIN_NAME})
