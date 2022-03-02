NAMESPACE Simatic.Ax.WindowTracking.Trigger
    CLASS VirtualTriggerList IMPLEMENTS ITriggerList
        VAR PUBLIC
            PositiveTolerance : DINT := 5;
            NegativeTolerance : DINT := 5;
            TriggerPointList : REF_TO ARRAY[*] OF IVirtualTrigger;
        END_VAR

        VAR PROTECTED
            
            _count : UINT;
        END_VAR
        
        METHOD PUBLIC Add : BOOL
            VAR_INPUT
                tp : IVirtualTrigger;
            END_VAR
            IF (_count < UPPER_BOUND(TriggerPointList^, 1)) THEN
                TriggerPointList^[_count] := tp;
                _count := _count + UINT#1;
            ELSE
                Add := FALSE;
            END_IF;
        END_METHOD

        METHOD PUBLIC Count : UINT
            Count := _count;
        END_METHOD

        METHOD PUBLIC GetTriggerPoint : IVirtualTrigger
            VAR_INPUT
                Id : UINT;
            END_VAR
            VAR_TEMP
                i : UINT;
            END_VAR
            FOR i := UINT#0 TO THIS.Count() - UINT#1 DO
                IF (TriggerPointList^[i] = NULL) THEN
                    GetTriggerPoint := NULL;
                    RETURN;
                END_IF;
                IF (TriggerPointList^[i].GetId() = Id) THEN
                    GetTriggerPoint := TriggerPointList^[i];
                    RETURN;
                END_IF;
            END_FOR;
            GetTriggerPoint := NULL;
        END_METHOD
    
        METHOD PUBLIC Check : BOOL
            VAR_INPUT
                tw : ITransportWindow;
            END_VAR
            VAR_TEMP
                i : UINT;
                o : IVirtualTrigger;
            END_VAR
            IF (THIS.Count() <= UINT#0) THEN
                Check := FALSE;
                RETURN;
            END_IF;
            FOR i := UINT#0 TO THIS.Count() - UINT#1 DO
                o := TriggerPointList^[i];
                IF (o <> NULL) THEN
                    o.Check(tw := tw, ll := NegativeTolerance, ul := PositiveTolerance);
                END_IF;
            END_FOR;
            Check := TRUE; 
        END_METHOD

    END_CLASS
    
END_NAMESPACE