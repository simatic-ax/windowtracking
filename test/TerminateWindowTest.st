USING AxUnit.Assert;
USING Simatic.Ax.WindowTracking.EventHandler;
USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.EventHandler
    {TestFixture}
    CLASS TerminateWindowTest
        VAR PROTECTED
            tws : TransportWindowList;
            enc : EncoderMock;
            v1 : VirtualTrigger := (Position := 100, Id := UINT#1);
            v2 : VirtualTrigger := (Position := 200, Id := UINT#2);
            te1 : TriggerEventMock;
            te2 : TerminateWindowEvent;

            tl : VirtualTriggerList;
            teAfter : TerminateUserEvent;
            teBefore : TerminateUserEvent;
        END_VAR
        
        METHOD PROTECTED Setup
            tws.Encoder := enc;
            v1.EventHandler := te1;
            v2.EventHandler := te2;
            te2.WindowList := tws;
            tl.Add(v1);
            tl.Add(v2);
            tws.TriggerPointList := tl;

            te2.EventBefore := teBefore;
            te2.EventAfter := teAfter;
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Clear_window
            THIS.Setup();
            tws.Create();
            enc.EncoderValue := 0;
            tws.Evaluate();
            Equal(expected := UINT#1, actual := tws.Count());
            
            enc.EncoderValue := 100;
            tws.Create();
            tws.Evaluate();
            Equal(expected := UINT#2, actual := tws.Count());

            // Remove Window at Position 200
            enc.EncoderValue := 200;
            tws.Evaluate();
            enc.EncoderValue := 206;  // move window out of range
            tws.Evaluate();
            Equal(expected := UINT#1, actual := tws.Count());
            
            // test for before/after event
            Equal(expected := 1, actual := teAfter.Count);
            Equal(expected := 1, actual := teBefore.Count);
        END_METHOD
    END_CLASS

    CLASS TerminateUserEvent IMPLEMENTS IUserDefinedEvent
        VAR PUBLIC
            Count : INT;
        END_VAR
        VAR PROTECTED
            
        END_VAR
        
        METHOD PUBLIC MyMethod
            ;
        END_METHOD
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            Count := Count + 1;
            
        END_METHOD
END_CLASS
END_NAMESPACE