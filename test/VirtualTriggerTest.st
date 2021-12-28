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

    END_CLASS

    CLASS TriggerEventMock IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            Id : UINT;
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

        END_METHOD
    END_CLASS
END_NAMESPACE