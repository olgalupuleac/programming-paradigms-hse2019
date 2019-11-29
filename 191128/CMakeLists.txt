cmake_minimum_required(VERSION 3.1)
project(main)

set(CMAKE_CXX_STANDARD 11)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_package(Threads REQUIRED)
set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror")

add_executable(main src/main.cpp)
target_link_libraries(${PROJECT_NAME} Threads::Threads)

