USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.WindowTracking
    {TestFixture}
    CLASS Test_WindowList
        
        VAR PROTECTED
            tws : TransportWindows;
            enc : EncoderMock;
        END_VAR
        
        METHOD PROTECTED Setup
            tws. Encoder := enc;
        END_METHOD

        {Test}
        METHOD PUBLIC Count_Of_Empty_List_Expect_0
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_Window_fom_empty_list_expect_0
            tws.Remove();
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD


        {Test}
        METHOD PUBLIC Create_4Windows_And_Call_Count_Expect_4
            tws.Create();
            tws.Create();
            tws.Create();
            tws.Create();

            Equal(expected := UINT#4, actual := tws.Count());
        END_METHOD


        {Test}
        METHOD PUBLIC Remove_1of_4_windows_expect_count_3
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Remove();
            Equal(expected := UINT#3, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_4of_4_windows_expect_count_0
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Remove();
            tws.Remove();
            tws.Remove();
            tws.Remove();
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_5of_4_windows_expect_count_0
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Remove();
            tws.Remove();
            tws.Remove();
            tws.Remove();
            tws.Remove();
            Equal(expected := UINT#0, actual := tws.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC Remove_1of_4_andd_a_1_windows_expect_count_4
            THIS.Create_4Windows_And_Call_Count_Expect_4();
            tws.Remove();
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