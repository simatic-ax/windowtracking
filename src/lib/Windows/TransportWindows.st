USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.WindowTracking
    CLASS TransportWindows
        VAR PUBLIC
            Encoder : IEncoder;
        END_VAR
        VAR PROTECTED
            _tranportWindowList : ARRAY[0..BUF_SIZE - 1] OF ITransportWindow;
            _tranportWindowListStorage : ARRAY[0..BUF_SIZE - 1] OF TransportWindow;
            _count : INT;
            _head : INT;
            _tail : INT;
        END_VAR
        
        VAR CONSTANT
            BUF_SIZE : INT := 100;
            ENCODER_MODULO : DINT := 4096;
        END_VAR

        METHOD PUBLIC Create
            _tranportWindowList[_head] := _tranportWindowListStorage[_head];
            _head := _head + 1;
            _head := _head MOD BUF_SIZE;
        END_METHOD

        METHOD PUBLIC Remove 
            _tranportWindowListStorage[_tail].Reset();
            _tranportWindowList[_tail] := NULL;
        END_METHOD

        METHOD PUBLIC Evaluate
            VAR_TEMP
                i : INT;
                o : ITransportWindow;
            END_VAR
            FOR i := 0 TO BUF_SIZE - 1 DO
                o := _tranportWindowList[i];
                IF (o <> NULL) THEN
                    o.CalcPosition();
                END_IF;
            END_FOR;
        END_METHOD
    END_CLASS
END_NAMESPACE