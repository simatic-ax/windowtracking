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
        END_VAR
        
        METHOD PROTECTED Setup
            tws.Encoder := enc;
            v1.EventHandler := te1;
            v2.EventHandler := te2;
            te2.WindowList := tws;
            tl.Add(v1);
            tl.Add(v2);
            tws.TriggerPointList := tl;
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
            enc.EncoderValue := 206;
            tws.Evaluate();
            Equal(expected := UINT#1, actual := tws.Count());

        END_METHOD
    END_CLASS
END_NAMESPACE