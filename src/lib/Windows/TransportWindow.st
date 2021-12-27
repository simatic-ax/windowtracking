USING Simatic.Ax.SimpleControlModules;
USING Simatic.Ax.WindowTracking.Exits;

NAMESPACE Simatic.Ax.WindowTracking
    
    CLASS TransportWindow IMPLEMENTS ITransportWindow
        VAR PUBLIC
        END_VAR
        VAR PROTECTED
            _actualPos : DINT;
            _lastPos : DINT;
        END_VAR
        
        METHOD PUBLIC CalcPosition
            VAR_INPUT
                enc : IEncoder;
            END_VAR
            VAR_TEMP
                _newPos : DINT;
                _difference : DINT;
            END_VAR
            _newPos := enc.GetValue();
            _difference := (_newPos - _lastPos) MOD enc.GetModulo();
            _actualPos := _actualPos + _difference;
            _lastPos := _newPos;
        END_METHOD

        METHOD PUBLIC GetPosition : DINT
            GetPosition := _actualPos;
        END_METHOD

        // METHOD PUBLIC CheckPos
        //     IF (Destination1 <> NULL) THEN
        //         Destination1.Check(THIS);
        //     END_IF;
        //     SortDecission.Check(THIS);
        // END_METHOD

        // METHOD PUBLIC GetTriggerPointCount : UINT
        //     IF (Destination1 <> NULL) THEN
        //         GetTriggerPointCount := UINT#1;
        //     ELSE
        //         GetTriggerPointCount := UINT#0;
        //     END_IF;
        // END_METHOD

        // METHOD PUBLIC GetTriggerPoint : ITriggerPoint
        //     VAR_INPUT
        //         Id : UINT;
        //     END_VAR
        //     IF (ID <> UINT#1) THEN
        //         GetTriggerPoint := NULL;
        //         RETURN;
        //     END_IF;

        //     IF (THIS.GetTriggerPointCount() = UINT#1) THEN
        //         GetTriggerPoint := Destination1;
        //         RETURN;
        //     END_IF;

        //     GetTriggerPoint := NULL;

        // END_METHOD

        METHOD PUBLIC GetExit : IExit
            ;
        END_METHOD


        METHOD PUBLIC Reset
            // Destination1 := NULL;
            _actualPos := 0;
            _lastPos := 0;
        END_METHOD
END_CLASS
END_NAMESPACE