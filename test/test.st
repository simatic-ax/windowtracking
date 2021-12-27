USING AxUnit;

NAMESPACE MyTest

    {TestFixture}
    CLASS MyTestFixture
        {Test(head := 5, tail := 1, count := 4)}
        {Test(head := 0, tail := 0, count := 0)}
        {Test(head := 1, tail := 0, count := 1)}
        {Test(head := 0, tail := 99, count := 1)}
        METHOD PUBLIC MyTestMethod
            VAR_INPUT
                head : INT;
                tail : INT;
                count : INT;
            END_VAR
            VAR_TEMP
                result : INT;
            END_VAR
            result := ((head - tail) + 100) MOD 100;
            Assert.Equal(actual := result, expected := count);
        END_METHOD
    END_CLASS

END_NAMESPACE
