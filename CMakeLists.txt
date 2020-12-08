cmake_minimum_required(VERSION 3.10.2)
project(CMD)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/libs)

add_subdirectory(modulars/hello)
include_directories(modulars)

set(APP_SRC main.c)
add_executable(cmd ${APP_SRC})
target_link_libraries(cmd libhello)
