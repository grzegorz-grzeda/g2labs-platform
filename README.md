# g2labs-platform

Platform definition and code entry point. Enables easy cross-compilation for a variety of target platforms.

This is a [G2EPM](https://github.com/grzegorz-grzeda/g2epm) library.

## How it works
The `g2labs-platform` project defines an executable. The executable tries to call the `application_main()` function. Simple as that.

Besides that, it contains some cmake trickery, to e.g. introduce the proper toolchain set, in case you want to cross compile for another hardware platform. 

## Target platforms:
- [x] native (compiled for host)
- [x] ESP32 (S3) (requires the ESP-IDF to be installed and exported)
- [ ] AVR
- [ ] STM32 

## How to compile and link it?

Your main, top-level project **MUST** be a library. The code entry function must be public and have the signature: `void application_main(void)`.

**BEFORE** the main cmake `project()` command:
- include the `<G2LABS_PLATFORM_LIB_DIR>/cmake/setup.cmake` cmake source file
- set the `g2labs_platform_set()` to an existing platform

Example `CMakeLists.txt` content:
```
cmake_minimum_required(VERSION 3.22)

include(lib/g2labs-platform/cmake/setup.cmake)
g2labs_platform_set("native","")

project(my-project)
add_library(${PROJECT_NAME})
...
```


# Copyright
This library was written by G2Labs Grzegorz Grzęda, and is distributed under MIT Licence. Check the `LICENSE` file for more details.