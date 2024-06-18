USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;


NAMESPACE Simatic.Ax.WindowTracking
    {TestFixture}
    CLASS Test_TransportWindowList
        
        VAR PROTECTED
            tw : TransportWindow;
            twStateless : TransportWindow;
            enc : EncoderMock;
        END_VAR

        // This method will be called before each test method
        {TestSetup}
        METHOD PUBLIC MyTestSetup
            tw := twStateless;
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Encode_NULL_Expect_False
            Equal(expected := FALSE, actual := tw.CalcPosition());
        END_METHOD

        {Test}
        METHOD PUBLIC CalcPosition_of_different_encoder_values_with_offset
            tw.SetPosition(100);
            enc.EncoderValue := 0;
            tw.CalcPosition(enc);
            Equal(expected := 100, actual := tw.GetPosition());

            enc.EncoderValue := 10;
            tw.CalcPosition(enc);
            Equal(expected := 110, actual := tw.GetPosition());

            enc.EncoderValue := 4095;
            tw.CalcPosition(enc);
            Equal(expected := 4195, actual := tw.GetPosition());

            enc.EncoderValue := 1;
            tw.CalcPosition(enc);
            Equal(expected := 4197, actual := tw.GetPosition());

        END_METHOD

        {Test}
        METHOD PUBLIC CalcPosition_of_different_encoder_positions_starting_with_0
            enc.EncoderValue := 0;
            tw.CalcPosition(enc);
            Equal(expected := 0, actual := tw.GetPosition());

            enc.EncoderValue := 10;
            tw.CalcPosition(enc);
            Equal(expected := 10, actual := tw.GetPosition());

            enc.EncoderValue := 4095;
            tw.CalcPosition(enc);
            Equal(expected := 4095, actual := tw.GetPosition());

            enc.EncoderValue := 1;
            tw.CalcPosition(enc);
            Equal(expected := 4097, actual := tw.GetPosition());

        END_METHOD

        {Test}
        METHOD PUBLIC CalcPosition_of_different_encoder_positions_starting_with_100
            enc.EncoderValue := 100;
            tw.CalcPosition(enc);
            Equal(expected := 0, actual := tw.GetPosition());

            enc.EncoderValue := 110;
            tw.CalcPosition(enc);
            Equal(expected := 10, actual := tw.GetPosition());

            enc.EncoderValue := 4095;
            tw.CalcPosition(enc);
            Equal(expected := 3995, actual := tw.GetPosition());

            enc.EncoderValue := 1;
            tw.CalcPosition(enc);
            Equal(expected := 3997, actual := tw.GetPosition());

        END_METHOD

    END_CLASS

END_NAMESPACE