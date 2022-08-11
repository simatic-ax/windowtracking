USING AxUnit.Assert;

NAMESPACE Simatic.Ax.WindowTracking
    {TestFixture}
    CLASS ItemTest
        VAR PROTECTED
            i : ItemOneDestination;
            vt : VirtualTrigger;
            ivt : IVirtualTrigger;
        END_VAR

        {Test}
        METHOD PUBLIC Test_Count_with_no_deststination_expect_0
            Equal(expected := i.DestinationCount(), actual := 0);
        END_METHOD
        
        {Test}
        METHOD PUBLIC Test_Count_with_1_deststination_expect_1
            i.Destination1 := vt;
            Equal(expected := i.DestinationCount(), actual := 1);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_GetItem_with_no_deststination_expect_NULL
            Equal(expected := TRUE, actual := i.GetDestination() = NULL);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_GetItem_with_1_deststination_expect_desztiation
            i.Destination1 := vt;
            ivt := vt;
            Equal(expected := TRUE, actual := i.GetDestination() = ivt);
        END_METHOD

    END_CLASS
END_NAMESPACE