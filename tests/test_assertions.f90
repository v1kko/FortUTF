SUBROUTINE TEST_ASSERT_EQ_PASS_INT_4BYTE
    USE FORTRAN_UNIT_TEST_SUITE
    INTEGER CODE_STATUS, X, Y
    X = 4
    Y = 4

    CODE_STATUS = FUTS_PASSED

    CALL ASSERT_EQUAL(X, Y)

    IF(.NOT. FUTS_PASSED == CODE_STATUS+1) THEN
        WRITE(*,*) "ERROR: 'TEST_ASSERT_EQ_PASS_INT_4BYTE' FAILED"
        STOP 1
    ENDIF
END SUBROUTINE TEST_ASSERT_EQ_PASS_INT_4BYTE

SUBROUTINE TEST_ASSERT_EQ_PASS_INT_8BYTE
    USE FORTRAN_UNIT_TEST_SUITE
    INTEGER CODE_STATUS
    REAL(8) :: X, Y
    X = 4D0
    Y = 4D0
    CODE_STATUS = FUTS_PASSED

    CALL ASSERT_EQUAL(X, Y)

    IF(.NOT. FUTS_PASSED == CODE_STATUS+1) THEN
        WRITE(*,*) "ERROR: 'TEST_ASSERT_EQ_PASS_INT_8BYTE' FAILED"
        STOP 1
    ENDIF
END SUBROUTINE TEST_ASSERT_EQ_PASS_INT_8BYTE

PROGRAM RUN_TESTS
    USE FORTRAN_UNIT_TEST_SUITE
    IMPLICIT NONE
    CALL TEST_ASSERT_EQ_PASS_INT_4BYTE
    CALL TEST_ASSERT_EQ_PASS_INT_8BYTE
END PROGRAM