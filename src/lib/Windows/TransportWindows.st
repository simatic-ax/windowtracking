USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.WindowTracking
    CLASS TransportWindows
        VAR PUBLIC
            Encoder : IEncoder;
        END_VAR
        VAR PROTECTED
            _tranportWindowList : ARRAY[UINT#0..BUF_SIZE - UINT#1] OF ITransportWindow;
            _tranportWindowListStorage : ARRAY[UINT#0..BUF_SIZE - UINT#1] OF TransportWindow;
            _count : UINT;
            _head : UINT;
            _tail : UINT;
        END_VAR
        
        VAR CONSTANT
            BUF_SIZE : UINT := UINT#100;
        END_VAR

        METHOD PUBLIC Create
            _tranportWindowList[_head] := _tranportWindowListStorage[_head];
            _head := _head + UINT#1;
            _head := _head MOD BUF_SIZE;
        END_METHOD

        METHOD PUBLIC Remove 
            IF (_tranportWindowList[_tail] <> NULL) THEN
                _tranportWindowListStorage[_tail].Reset();
                _tranportWindowList[_tail] := NULL;
                _tail := _tail + UINT#1;
                _tail := _tail MOD BUF_SIZE;
            END_IF;
        END_METHOD

        METHOD PUBLIC GetHead : UINT
            GetHead := _head;
        END_METHOD
        
        METHOD PUBLIC GetTail : UINT
            GetTail := _tail;
        END_METHOD

        METHOD PUBLIC GetWindow : ITransportWindow
             VAR_INPUT
                 id : UINT;
             END_VAR
             GetWindow := _tranportWindowListStorage[id];
        END_METHOD

        METHOD PUBLIC Count : UINT
            Count := ((_head - _tail) + BUF_SIZE) MOD BUF_SIZE;
        END_METHOD

        METHOD PUBLIC Evaluate
            VAR_TEMP
                i : UINT;
                o : ITransportWindow;
            END_VAR
            FOR i := UINT#0 TO THIS.Count() - UINT#1 DO
                o := _tranportWindowList[(_tail + i) MOD BUF_SIZE];
                IF (o <> NULL) THEN
                    o.CalcPosition(enc := Encoder);
                END_IF;
            END_FOR;
        END_METHOD
    END_CLASS
END_NAMESPACE