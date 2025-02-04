cmake_minimum_required(VERSION 3.20)

set( FORTUTF FortUTF )

project( ${FORTUTF} VERSION 0.1.4 LANGUAGES Fortran )

file(GLOB FUTF_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/src/*.f90)

message(STATUS "[Fortran Compiler]")
message(STATUS "\tUsing compiler: ${CMAKE_Fortran_COMPILER}")
option(BUILD_TESTS "Build the FortUTF Unit Tests" OFF)
option(BUILD_EXAMPLES "Build the FortUTF Example Project" OFF)

if(NOT BUILD_TESTS)
    add_library(${FORTUTF} ${FUTF_SRCS})
    set_target_properties(
        ${FORTUTF}
        PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )
    set_target_properties(
        ${FORTUTF}
        PROPERTIES
        Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules
    )
endif()

if(BUILD_TESTS)
    set(CMAKE_Fortran_FLAGS "-Wall -Wextra -Wno-compare-reals -Wno-maybe-uninitialized -Wno-uninitialized -O3 -g -fprofile-arcs -ftest-coverage")
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/fortutf.cmake)
	set(FORTUTF_PROJECT_TEST_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests)
    set(FORTUTF_PROJECT_SRC_FILES ${FUTF_SRCS})
    list(APPEND TEST_LIST ${CMAKE_SOURCE_DIR}/tests/test_suite/unfinished_test_check.f90)
    FortUTF_Find_Tests()
ENDIF()

IF(BUILD_EXAMPLES)
    ADD_SUBDIRECTORY(${CMAKE_CURRENT_SOURCE_DIR}/examples/demo_project)
ENDIF()
