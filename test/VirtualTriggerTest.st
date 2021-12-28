USING AxUnit.Assert;
USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.Events;
NAMESPACE Simatic.Ax.WindowTracking.Trigger
    {TestFixture}
    CLASS TestVirtualTrigger
        VAR PROTECTED
            vt : VirtualTrigger;
            evt : TriggerEventMock;
        END_VAR

        METHOD PRIVATE SetupTestTrigger
            vt.EventHandler := evt;
            vt.Position := 1000;
            vt.Id := UINT#10;
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Activate_method_with_no_event_expect_NullReferecne
            VAR_TEMP
                s : EventStatus;
                i : Int;
            END_VAR
            Equal(expected := TRUE, actual := s <> EventStatus#Finished);
            s := vt.ActivateEvent();
            Equal(expected := TRUE, actual := s = EventStatus#NullReference);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Activate_method_end_check_Execution
            VAR_TEMP
                s : EventStatus;
                i : Int;
            END_VAR
            THIS.SetupTestTrigger();
            Equal(expected := TRUE, actual := s <> EventStatus#Finished);
            s := vt.ActivateEvent();
            Equal(expected := TRUE, actual := s = EventStatus#Finished);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_GetId_And_Expect_10
            THIS.SetupTestTrigger();
            Equal(expected := UINT#10, actual := vt.GetId());
        END_METHOD
        {Test}

        METHOD PUBLIC Test_GetPosition_And_Expect_1000
            THIS.SetupTestTrigger();
            Equal(expected := UINT#1000, actual := vt.GetPosition());
        END_METHOD
        
        METHOD PUBLIC Test_IsEnabled_And_Exect_true
            THIS.SetupTestTrigger();
            Equal(expected := TRUE, actual := vt.IsEnabled());
        END_METHOD

        {Test(sp := 1000, value := 994, res := FALSE)}
        {Test(sp := 1000, value := 995, res := TRUE)}
        {Test(sp := 1000, value := 996, res := TRUE)}
        {Test(sp := 1000, value := 999, res := TRUE)}
        {Test(sp := 1000, value := 1000, res := TRUE)}
        {Test(sp := 1000, value := 1001, res := TRUE)}
        {Test(sp := 1000, value := 1004, res := TRUE)}
        {Test(sp := 1000, value := 1005, res := TRUE)}
        {Test(sp := 1000, value := 1006, res := FALSE)}
        METHOD PUBLIC Test_in_range
            VAR_INPUT
                sp : DINT;
                value : DINT;
                res : BOOL;
            END_VAR
            VAR_TEMP
                r : BOOL;
            END_VAR
            r := vt.InRange(sp := sp, value := value, ul := 5, ll := 5);
            Equal(expected := res, actual := r);
        END_METHOD
        
    END_CLASS

    CLASS TriggerEventMock IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            Id : UINT;
            Calls : INT;
        END_VAR
        VAR PROTECTED
            
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR

            Id := te.GetId();
            Action := EventStatus#Finished;
            Calls := Calls + 1;
        END_METHOD

    END_CLASS
END_NAMESPACE