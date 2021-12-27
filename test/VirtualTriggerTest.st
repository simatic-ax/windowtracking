USING AxUnit.Assert;
USING Simatic.Ax.WindowTracking.VirtualTrigger;

NAMESPACE Simatic.Ax.WindowTracking.Events
    {TestFixture}
    CLASS TestVirtualTrigger
        VAR PROTECTED
            vt : VirtualTrigger;

        END_VAR
        {Test}
        METHOD PUBLIC Test_Activate_method_end_check_Execution
            VAR_TEMP
                s : EventStatus;
                i : Int;
            END_VAR
            Equal(expected := TRUE, actual := s <> EventStatus#Finished);
            vt.ActivateEvent();
            Equal(expected := TRUE, actual := s = EventStatus#Finished);
            Equal(expected := TRUE, actual := TRUE);

        END_METHOD
    END_CLASS

    CLASS TriggerEvantMock IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR

            Action := EventStatus#Finished;

        END_METHOD
    END_CLASS
END_NAMESPACE