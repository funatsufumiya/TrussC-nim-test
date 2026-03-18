# CheckNim.cmake - helper to print Nim detection results

function(trussc_print_nim_detection)
    # Prefer FindNim if available
    find_package(Nim QUIET)
    if (Nim_FOUND)
        message(WARNING "[TrussC] FindNim: Nim_FOUND = TRUE")
        if (DEFINED NIM)
            message(WARNING "[TrussC] NIM: ${NIM}")
        endif()
        if (DEFINED NIMBLE)
            message(WARNING "[TrussC] NIMBLE: ${NIMBLE}")
        endif()
        if (DEFINED NIM_VERSION)
            message(WARNING "[TrussC] NIM_VERSION: ${NIM_VERSION}")
        endif()
        return()
    endif()

    # Fallback: try PATH lookup
    find_program(_TRUSSC_NIM_EXECUTABLE nim)
    find_program(_TRUSSC_NIMBLE_EXECUTABLE nimble)
    if (_TRUSSC_NIM_EXECUTABLE)
        message(WARNING "[TrussC] Found nim on PATH: ${_TRUSSC_NIM_EXECUTABLE}")
        execute_process(COMMAND "${_TRUSSC_NIM_EXECUTABLE}" --version
                        OUTPUT_VARIABLE _TRUSSC_NIM_VER OUTPUT_STRIP_TRAILING_WHITESPACE
                        RESULT_VARIABLE _TRUSSC_NIM_VER_RES)
        if (_TRUSSC_NIM_VER_RES EQUAL 0)
            message(WARNING "[TrussC] nim --version: ${_TRUSSC_NIM_VER}")
        endif()
    else()
        message(WARNING "[TrussC] nim not found on PATH")
    endif()

    if (_TRUSSC_NIMBLE_EXECUTABLE)
        message(WARNING "[TrussC] Found nimble on PATH: ${_TRUSSC_NIMBLE_EXECUTABLE}")
        execute_process(COMMAND "${_TRUSSC_NIMBLE_EXECUTABLE}" --version
                        OUTPUT_VARIABLE _TRUSSC_NIMBLE_VER OUTPUT_STRIP_TRAILING_WHITESPACE
                        RESULT_VARIABLE _TRUSSC_NIMBLE_VER_RES)
        if (_TRUSSC_NIMBLE_VER_RES EQUAL 0)
            message(WARNING "[TrussC] nimble --version: ${_TRUSSC_NIMBLE_VER}")
        endif()
    else()
        message(WARNING "[TrussC] nimble not found on PATH")
    endif()
endfunction()
