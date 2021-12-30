NAMESPACE Simatic.Ax.WindowTracking.Trigger
    CLASS TriggerList IMPLEMENTS ITriggerList
        VAR PROTECTED
            _triggerPointList : ARRAY[UINT#0..BUF_SIZE - UINT#1] OF IVirtualTrigger;
            _count : UINT;
        END_VAR
        
        VAR CONSTANT
            BUF_SIZE : UINT := UINT#100;
        END_VAR

        METHOD PUBLIC Add : BOOL
            VAR_INPUT
                tp : IVirtualTrigger;
            END_VAR
            IF (_count < BUF_SIZE) THEN
                _triggerPointList[_count] := tp;
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
                IF (_triggerPointList[i] = NULL) THEN
                    GetTriggerPoint := NULL;
                    RETURN;
                END_IF;
                IF (_triggerPointList[i].GetId() = Id) THEN
                    GetTriggerPoint := _triggerPointList[i];
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
            FOR i := UINT#0 TO THIS.Count() - UINT#1 DO
                o := _triggerPointList[i];
                IF (o <> NULL) THEN
                    o.Check(tw);
                END_IF;
            END_FOR;
        END_METHOD

    END_CLASS
    
END_NAMESPACE