USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.SimpleControlModules;
USING Simatic.Ax.WindowTracking.Items;

NAMESPACE Simatic.Ax.WindowTracking
    CLASS TransportWindowList IMPLEMENTS ITransportWindowsTerminate
        VAR PUBLIC
            Encoder : IEncoder;
            TriggerPointList : ITriggerList;
        END_VAR
        VAR PROTECTED
            _tranportWindowList : ARRAY[UINT#0..BUF_SIZE - UINT#1] OF ITransportWindow;
            _tranportWindowListStorage : ARRAY[UINT#0..BUF_SIZE - UINT#1] OF TransportWindow;
            _head : UINT;
            _tail : UINT;
        END_VAR
        
        VAR CONSTANT
            BUF_SIZE : UINT := UINT#100;
        END_VAR

        METHOD PUBLIC Create : ITransportWindow
            VAR_INPUT
                i : IItem;
                offset : DINT;
            END_VAR
            IF (Encoder = NULL) THEN
                Create := NULL;
                RETURN;
            END_IF;

            _tranportWindowList[_head] := _tranportWindowListStorage[_head];
            _tranportWindowList[_head].CalcPosition(Encoder);
            _tranportWindowList[_head].SetItem(i);
            // _tranportWindowList[_head].SetPosition(offset);
            Create := _tranportWindowList[_head];


            _head := _head + UINT#1;
            _head := _head MOD BUF_SIZE;
        END_METHOD

        METHOD PUBLIC Terminate 
            IF (_tranportWindowList[_tail] <> NULL) THEN
                _tranportWindowListStorage[_tail].Reset();
                _tranportWindowList[_tail] := NULL;
                _tail := _tail + UINT#1;
                _tail := _tail MOD BUF_SIZE;
            END_IF;
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

        METHOD PUBLIC Evaluate : BOOL
            VAR_TEMP
                i : UINT;
                o : ITransportWindow;
            END_VAR

            IF (THIS.Count() <= UINT#0) THEN
                Evaluate := FALSE;
                RETURN;
            END_IF;
            FOR i := UINT#0 TO THIS.Count() - UINT#1 DO
                o := _tranportWindowList[(_tail + i) MOD BUF_SIZE];
                IF (o <> NULL) THEN
                    o.CalcPosition(enc := Encoder);
                    IF (TriggerPointList <> NULL) THEN
                        TriggerPointList.Check(o);
                        Evaluate := TRUE;
                    ELSE
                        Evaluate := FALSE;
                    END_IF;
                END_IF;
            END_FOR;
            
        END_METHOD
    END_CLASS
END_NAMESPACE