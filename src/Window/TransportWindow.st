USING Simatic.Ax.SimpleControlModules;
USING Simatic.Ax.WindowTracking.Items;
NAMESPACE Simatic.Ax.WindowTracking
    
    CLASS TransportWindow IMPLEMENTS ITransportWindow
        VAR PUBLIC
            Item : IItem;
        END_VAR
        VAR PROTECTED
            _actualPos : DINT;
            _lastPos : DINT := -1;
        END_VAR
        
        METHOD PUBLIC CalcPosition : BOOL
            VAR_INPUT
                enc : IEncoder;
            END_VAR
            VAR_TEMP
                _newPos : DINT;
                _difference : DINT;
            END_VAR
            IF enc = NULL THEN
                CalcPosition := FALSE;
                RETURN;
            END_IF;
            IF (_lastPos = -1) THEN
                _lastPos := enc.GetValue();
            END_IF;
            _newPos := enc.GetValue();
            _difference := (_newPos - _lastPos + enc.GetModulo()) MOD enc.GetModulo();
            _actualPos := _actualPos + _difference;
            _lastPos := _newPos;
            CalcPosition := TRUE; 
        END_METHOD

        METHOD PUBLIC GetPosition : DINT
            GetPosition := _actualPos;
        END_METHOD

        METHOD PUBLIC Reset
            _actualPos := 0;
            _lastPos := -1;
        END_METHOD
        
        METHOD PUBLIC GetItem : IItem
            GetItem := Item;
        END_METHOD
    
        METHOD PUBLIC SetItem
            VAR_INPUT
                i : IItem;
            END_VAR
            Item := i;
            ;
        END_METHOD

        METHOD PUBLIC SetPosition
            VAR_INPUT
                pos : DINT;
            END_VAR
            _actualPos  := pos;
        END_METHOD
    END_CLASS
END_NAMESPACE