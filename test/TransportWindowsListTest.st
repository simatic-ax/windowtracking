USING AxUnit.Assert;
USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.SimpleControlModules;


NAMESPACE Simatic.Ax.WindowTracking
    {TestFixture}
    CLASS Test_WindowList
        
        VAR PROTECTED
            tws : TransportWindowList;
            enc : EncoderMock;
            v1 : VirtualTrigger := (Position := 100, Id := UINT#1);
            v2 : VirtualTrigger := (Position := 200, Id := UINT#2);
            te1 : TriggerEventMock;
            te2 : TriggerEventMock;
            tl : VirtualTriggerList;
        END_VAR
        
        METHOD PROTECTED Setup
            tws.Encoder := enc;
            v1.EventHandler := te1;
            v2.EventHandler := te2;
            tl.Add(v1);
            tl.Add(v2);
            tws.TriggerPointList := tl;
        END_METHOD

        {Test}
        METHOD PUBLIC Count_Of_Empty_List_Expect_0
            THIS.Setup();
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_Window_fom_empty_list_expect_0
            THIS.Setup();
            tws.Terminate();
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD


        {Test}
        METHOD PUBLIC Create_4Windows_And_Call_Count_Expect_4
            THIS.Setup();
            tws.Create();
            tws.Create();
            tws.Create();
            tws.Create();

            Equal(expected := UINT#4, actual := tws.Count());
        END_METHOD


        {Test}
        METHOD PUBLIC Remove_1of_4_windows_expect_count_3
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Terminate();
            Equal(expected := UINT#3, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_4of_4_windows_expect_count_0
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Terminate();
            tws.Terminate();
            tws.Terminate();
            tws.Terminate();
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_5of_4_windows_expect_count_0
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Terminate();
            tws.Terminate();
            tws.Terminate();
            tws.Terminate();
            tws.Terminate();
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_1of_4_andd_a_1_windows_expect_count_4
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Terminate();
            tws.Create();
            Equal(expected := UINT#4, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Evaluate_4_windows_with_Distance_10
            VAR_TEMP
                pos : DINT;
            END_VAR
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            THIS.Setup();
            enc.EncoderValue := 10;
            tws.Evaluate();
            pos := tws.GetWindow(UINT#0).GetPosition();
            Equal(expected := 10, actual := pos);
            pos := tws.GetWindow(UINT#1).GetPosition();
            Equal(expected := 10, actual := pos);
            pos := tws.GetWindow(UINT#2).GetPosition();
            Equal(expected := 10, actual := pos);
            pos := tws.GetWindow(UINT#3).GetPosition();
            Equal(expected := 10, actual := pos);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Evaluate_4_windows_with_Distance_20
            VAR_TEMP
                pos : DINT;
            END_VAR
            THIS.Test_Evaluate_4_windows_with_Distance_10();
            enc.EncoderValue := 20;
            tws.Evaluate();
            pos := tws.GetWindow(UINT#0).GetPosition();
            Equal(expected := 20, actual := pos);
            pos := tws.GetWindow(UINT#1).GetPosition();
            Equal(expected := 20, actual := pos);
            pos := tws.GetWindow(UINT#2).GetPosition();
            Equal(expected := 20, actual := pos);
            pos := tws.GetWindow(UINT#3).GetPosition();
            Equal(expected := 20, actual := pos);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Evaluate_4_windows_with_Distance_20_remove_one_Expect_one_null
            VAR_TEMP
                pos : DINT;
                ti : ITransportWindow;
            END_VAR
            ;
            THIS.Setup();
            
            enc.EncoderValue := 0;
            tws.Create();
            tws.Evaluate();

            Equal(expected := UINT#1, actual := tws.Count());
            
            Equal(expected := te1.Id, actual := UINT#0);
            Equal(expected := te2.Id, actual := UINT#0);
            
            
            // No virtual trigger triggered
            enc.EncoderValue := 20;
            tws.Evaluate();

            Equal(expected := te1.Id, actual := UINT#0);
            Equal(expected := te2.Id, actual := UINT#0);
            Equal(expected := 0, actual := te1.Calls);
            Equal(expected := 0, actual := te2.Calls);


            // First virtual trigger triggered
            enc.EncoderValue := 99;
            tws.Evaluate();

            Equal(expected := te1.Id, actual := UINT#1);
            Equal(expected := te2.Id, actual := UINT#0);
            Equal(expected := 1, actual := te1.Calls);
            Equal(expected := 0, actual := te2.Calls);


            // First virtual trigger still occupied
            enc.EncoderValue := 100;
            tws.Evaluate();

            Equal(expected := te1.Id, actual := UINT#1);
            Equal(expected := te2.Id, actual := UINT#0);
            Equal(expected := 1, actual := te1.Calls);
            Equal(expected := 0, actual := te2.Calls);
            

            // Second virtual trigger still occupied
            enc.EncoderValue := 200;
            tws.Evaluate();

            Equal(expected := te1.Id, actual := UINT#1);
            Equal(expected := te2.Id, actual := UINT#2);
            Equal(expected := 1, actual := te1.Calls);
            Equal(expected := 1, actual := te2.Calls);

            // second virtual trigger triggered
           
            tws.Create(); // Create new window 
            enc.EncoderValue := 300;
            tws.Evaluate();
           
            Equal(expected := te1.Id, actual := UINT#1);
            Equal(expected := te2.Id, actual := UINT#2);
            Equal(expected := 2, actual := te1.Calls);
            Equal(expected := 1, actual := te2.Calls);

            // windows moved to pos 400 - second wndow reach second trigger point
            enc.EncoderValue := 400;
            tws.Evaluate();
            Equal(expected := te1.Id, actual := UINT#1);
            Equal(expected := te2.Id, actual := UINT#2);
            Equal(expected := 2, actual := te1.Calls);
            Equal(expected := 2, actual := te2.Calls);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Null_Reference_to_Encoder
            VAR_TEMP
                tw : ITransportWindow;
            END_VAR
            tw := tws.Create();
            Equal(expected := TRUE, actual := tw = NULL);

        END_METHOD

        {Test}
        METHOD PUBLIC Create_A_window_onenocoder_value_300_and_track_the_position
            VAR_TEMP
                i : INT;
                pos : DINT;
                pos_exp : DINT;
            END_VAR
            tws.Encoder := enc;
            enc.EncoderValue := 300;
            tws.Create(); // Create new window 
            FOR i := 0 TO 99 DO
                tws.Evaluate();
                pos := tws.GetWindow(UINT#0).GetPosition();
                Equal(expected := pos_exp, actual := pos);
                pos_exp := pos_exp + 100;
                enc.EncoderValue := (enc.EncoderValue + 100) MOD 4096;
            END_FOR;
            Equal(expected := 9900, actual := pos);
            ; // AxUnit.Assert.Equal(y, x)
        END_METHOD

    END_CLASS

    CLASS EncoderMock IMPLEMENTS IEncoder
    
        VAR PUBLIC
            EncoderValue : DINT;
        END_VAR

        METHOD PUBLIC Evaluate
            ;
        END_METHOD

        METHOD PUBLIC Reset
            ;
        END_METHOD

        METHOD PUBLIC SetValue
            VAR_INPUT
                value : DINT;
            END_VAR
            ;
        END_METHOD

        METHOD PUBLIC GetValue : DINT
            GetValue := EncoderValue;
        END_METHOD

        METHOD PUBLIC SetDirection
            VAR_INPUT
                mode : CountMode;
            END_VAR
            ;
        END_METHOD

        METHOD PUBLIC RelativeCount : DINT
            ;
        END_METHOD

        METHOD PUBLIC ResetRelative
            ;
        END_METHOD

        METHOD PUBLIC GetModulo : DINT
            GetModulo := 4096;
        END_METHOD
    END_CLASS

END_NAMESPACE