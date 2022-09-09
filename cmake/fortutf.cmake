set(FORTUTF_PROJECT_TEST_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/run_tests.f90)

get_filename_component(FORTUTF_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
FILE(GLOB FORTUTF_SRCS CONFIGURE_DEPENDS ${FORTUTF_DIR}/src/*.f90)

function(FortUTF_Find_Tests)
    if(NOT TARGET ${FORTUTF})
        if(NOT DEFINED ${FORTUTF})
            set(FORTUTF FortUTF)
        endif()
        ADD_LIBRARY(${FORTUTF} ${FORTUTF_SRCS})
    endif()

    add_custom_command(OUTPUT ${FORTUTF_PROJECT_TEST_SCRIPT}
                              ${FORTUTF_PROJECT_TEST_SCRIPT}_ #fake! ensure we regenerate always
      COMMAND ${CMAKE_COMMAND} 
      -DFORTUTF_PROJECT_SRC_LIBRARY="${FORTUTF_PROJECT_SRC_LIBRARY}"
      -DFORTUTF_PROJECT_SRC_FILES="${FORTUTF_PROJECT_SRC_FILES}"
      -DFORTUTF_PROJECT_TEST_DIR="${FORTUTF_PROJECT_TEST_DIR}"
      -DFORTUTF_PROJECT_TEST_SCRIPT="${FORTUTF_PROJECT_TEST_SCRIPT}"
      -P ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/write_test_script.cmake
      DEPENDS ${FORTUTF_PROJECT_SRC_FILES}
      )

    add_executable(${PROJECT_NAME}_Tests ${FORTUTF_PROJECT_SRC_FILES} ${FORTUTF_SRCS} ${TEST_LIST} ${FORTUTF_PROJECT_TEST_SCRIPT})

    if(FORTUTF_PROJECT_MOD_DIR)
        message(STATUS "\tIncluding library: ${FORTUTF_PROJECT_MOD_DIR}")
        TARGET_INCLUDE_DIRECTORIES(
            ${PROJECT_NAME}_Tests
            PUBLIC
            ${FORTUTF_PROJECT_MOD_DIR}
        )
    endif()

    if(FORTUTF_PROJECT_SRC_LIBRARY)
        message(STATUS "\tLinking library: ${FORTUTF_PROJECT_SRC_LIBRARY}")

        target_link_libraries(
            ${PROJECT_NAME}_Tests ${FORTUTF_PROJECT_SRC_LIBRARY}
        )
    endif()

    message(STATUS "\tCompiler Flags: ${CMAKE_Fortran_FLAGS}")

    target_link_libraries(
        ${PROJECT_NAME}_Tests ${FORTUTF}
    )

endfunction()
