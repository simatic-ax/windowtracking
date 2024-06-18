USING AxUnit.Assert;
NAMESPACE Simatic.Ax.WindowTracking
    {TestFixture}
    CLASS TestVirtualTrigger
        VAR PROTECTED
            vt : VirtualTrigger;
            vtStateless : VirtualTrigger;
            evt : TriggerEventMock;
            tw : TransportWindow;
            enc : EncoderMock;
        END_VAR

        METHOD PRIVATE SetupTestTrigger
            vt.EventHandler := evt;
            vt.Position := 1000;
            vt.Id := UINT#10;
        END_METHOD

        // This method will be called before each test method
        {TestSetup}
        METHOD PUBLIC MyTestSetup
            vt := vtStateless;
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
        
        {Test(sp := -6, res := FALSE)}
        {Test(sp := -5, res := TRUE)}
        {Test(sp := -4, res := TRUE)}
        {Test(sp := -1, res := TRUE)}
        {Test(sp := 0, res := TRUE)}
        {Test(sp := 1, res := TRUE)}
        {Test(sp := 4, res := TRUE)}
        {Test(sp := 5, res := TRUE)}
        {Test(sp := 6, res := FALSE)}
        METHOD PUBLIC Test_Check
            VAR_INPUT
                sp : DINT;
                res : BOOL;
            END_VAR
            VAR_TEMP
                r : BOOL;
            END_VAR   
            
            vt.Position := sp;  
            r := vt.Check(tw := tw, ul := 5, ll := 5);
            Equal(expected := res, actual := r);
            Equal(expected := res, actual := vt.IsActivated());
            
            r := vt.Check(tw := tw, ul := 5, ll := 5);
            Equal(expected := FALSE, actual := r);
            Equal(expected := res, actual := vt.IsActivated());
        END_METHOD
 

        {Test}
        METHOD PUBLIC TestCheckforRisingEdge_expect_just_one_rising_edge


            vt.Position := 100;

            enc.EncoderValue := 0;
            tw.CalcPosition(enc := enc);
            Equal(expected := 0, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));
            
            enc.EncoderValue := 1;
            tw.CalcPosition(enc := enc);
            Equal(expected := 1, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));
            
            enc.EncoderValue := 94;
            tw.CalcPosition(enc := enc);
            Equal(expected := 94, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            enc.EncoderValue := 95;
            tw.CalcPosition(enc := enc);
            Equal(expected := 95, actual := tw.GetPosition());
            Equal(expected := TRUE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            enc.EncoderValue := 96;
            tw.CalcPosition(enc := enc);
            Equal(expected := 96, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));
            
            enc.EncoderValue := 97;
            tw.CalcPosition(enc := enc);
            Equal(expected := 97, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            enc.EncoderValue := 98;
            tw.CalcPosition(enc := enc);
            Equal(expected := 98, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            enc.EncoderValue := 105;
            tw.CalcPosition(enc := enc);
            Equal(expected := 105, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            enc.EncoderValue := 194;
            tw.CalcPosition(enc := enc);
            Equal(expected := 194, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            tw.Reset();
            enc.EncoderValue := 194;
            tw.CalcPosition(enc := enc);
            Equal(expected := 0, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            enc.EncoderValue := 288;
            tw.CalcPosition(enc := enc);
            Equal(expected := 94, actual := tw.GetPosition());
            Equal(expected := FALSE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

            enc.EncoderValue := 289;
            tw.CalcPosition(enc := enc);
            Equal(expected := 95, actual := tw.GetPosition());
            Equal(expected := TRUE, actual := vt.Check(tw := tw, ul := 5, ll := 5));

        END_METHOD

    END_CLASS

    CLASS TriggerEventMock IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            Id : UINT;
            Calls : DINT;
            CallsAfter : DINT;
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