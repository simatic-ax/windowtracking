USING AxUnit.Assert;
NAMESPACE Simatic.Ax.WindowTracking
    {TestFixture}
    CLASS WindowingIntegraiveTest
        VAR PROTECTED
            twl : TransportWindowList;
            tpl : VirtualTriggerList;

            tp1 : VirtualTrigger;
            hdl : EventHandlerTest;
            tw : TransportWindow;
            enc : EncoderMock;
        END_VAR

        METHOD PUBLIC Setup
            twl.Encoder := enc;
            twl.TriggerPointList := tpl;

            tp1.Position := 100;
            tp1.Id := UINT#1;
            tp1.EventHandler := hdl;
            tpl.Add(tp1);
        END_METHOD   

        {Test}
        METHOD PUBLIC Test_Crate3_Windows_with_distance_20
            THIS.Setup();
            // Position 0 Create window 
            enc.EncoderValue := 0;
            twl.Create();
            twl.Evaluate();
            Equal(expected := 0, actual := twl.GetWindow(UINT#0).GetPosition());

            // Position 20 Create 2. window 
            enc.EncoderValue := 20;
            twl.Create();
            twl.Evaluate();
            Equal(expected := 20, actual := twl.GetWindow(UINT#0).GetPosition());
            Equal(expected := 0, actual := twl.GetWindow(UINT#1).GetPosition());


            // Position 40 Create 3. window 
            enc.EncoderValue := 40;
            twl.Create();
            twl.Evaluate();
            Equal(expected := 40, actual := twl.GetWindow(UINT#0).GetPosition());
            Equal(expected := 20, actual := twl.GetWindow(UINT#1).GetPosition());
            Equal(expected := 0, actual := twl.GetWindow(UINT#2).GetPosition());
            
        END_METHOD

        {Test}
        METHOD PUBLIC Move_First_window_to_triggerpoint_at_position_95_and_expect_activation
            THIS.Test_Crate3_Windows_with_distance_20();
            enc.EncoderValue := 94;
            twl.Evaluate();
            Equal(expected := 94, actual := twl.GetWindow(UINT#0).GetPosition());
            Equal(expected := 74, actual := twl.GetWindow(UINT#1).GetPosition());
            Equal(expected := 54, actual := twl.GetWindow(UINT#2).GetPosition());

            Equal(expected := FALSE, actual :=  tp1.IsActivated());

            enc.EncoderValue := 95;
            twl.Evaluate();
            Equal(expected := TRUE, actual :=  tp1.IsActivated());
            Equal(expected := 1, actual := hdl.Count);

            enc.EncoderValue := 96;
            twl.Evaluate();
            Equal(expected := TRUE, actual :=  tp1.IsActivated());
            Equal(expected := 1, actual := hdl.Count);

            enc.EncoderValue := 105;
            twl.Evaluate();
            Equal(expected := TRUE, actual :=  tp1.IsActivated());
            Equal(expected := 1, actual := hdl.Count);    
            
            enc.EncoderValue := 106;
            twl.Evaluate();
            Equal(expected := FALSE, actual :=  tp1.IsActivated());
            Equal(expected := 1, actual := hdl.Count);    
        END_METHOD

    END_CLASS

    CLASS EventHandlerTest IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            Count : DINT;
            CallsAfter : DINT;
        END_VAR    
    
        METHOD PUBLIC Action : EventStatus    
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            Count := Count + 1;
        END_METHOD
    
        METHOD PUBLIC ActionAfter : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            CallsAfter := CallsAfter + 1;
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE