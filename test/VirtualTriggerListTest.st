USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.Trigger;
USING AxUnit.Assert;
USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.VirtualTrigger
    {TestFixture}
    CLASS TestVirtualTriggerList
        VAR PROTECTED
            tl : TriggerList;
            trig1 : VirtualTrigger := (Id := UINT#1, Position := 1100);
            trig2 : VirtualTrigger := (Id := UINT#2, Position := 1200);
            trig3 : VirtualTrigger := (Id := UINT#3, Position := 1300);
            trig4 : VirtualTrigger := (Id := UINT#4, Position := 1400);
            evt : TriggerEventMock;
        END_VAR

        METHOD PRIVATE SetupTriggerList
            trig1.EventHandler := evt;
            tl.Add(tp := trig1);
            
            trig2.EventHandler := evt;
            tl.Add(tp := trig2);

            trig3.EventHandler := evt;
            tl.Add(tp := trig3);

            trig4.EventHandler := evt;
            tl.Add(tp := trig4);
        END_METHOD

        {Test}
        METHOD PUBLIC TestCount_elements_expect_4
            THIS.SetupTriggerList();
            Equal(expected := UINT#4, actual := tl.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Test_GetId_element_not_found_expect_null          
            VAR_TEMP
                t : IVirtualTrigger;
            END_VAR
            t := tl.GetTriggerPoint(UINT#1);
            Equal(expected := TRUE, actual := t = NULL);
        END_METHOD

        {Test(id := UINT#1, expVal := 1100)}
        {Test(id := UINT#2, expVal := 1200)}
        {Test(id := UINT#3, expVal := 1300)}
        {Test(id := UINT#4, expVal := 1400)}
        METHOD PUBLIC Test_GetId_of_four_triggers_and_expect_correct_position
            VAR_INPUT
                id : UINT;
                expVal : DINT;
            END_VAR
            THIS.SetupTriggerList();
            Equal(expected := expVal, actual := tl.GetTriggerPoint(id).GetPosition());
        END_METHOD

    END_CLASS

    CLASS VirtualTriggerMock
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            
        END_VAR
        
        METHOD PUBLIC MyMethod
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE