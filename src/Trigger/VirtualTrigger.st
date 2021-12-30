USING Simatic.Ax.WindowTracking.EventHandler;
NAMESPACE Simatic.Ax.WindowTracking.Trigger
    CLASS VirtualTrigger IMPLEMENTS IVirtualTrigger

        VAR PUBLIC
            Position : DINT;
            Id : UINT;
            EventHandler : ITriggerEvent;
            PositiveTolerace : DINT := -1;
            NegativeTolerance : DINT := -1;
        END_VAR

        VAR PROTECTED
            _isActiavted : BOOL;
            _activateOld : BOOL;
        END_VAR

        METHOD PUBLIC ActivateEvent : EventStatus
            VAR_INPUT
                tw : ITransportWindow;
            END_VAR

            IF EventHandler <> NULL THEN
                IF THIS.IsEnabled() THEN
                    ActivateEvent := EventHandler.Action(te := THIS, tw := tw);
                    RETURN;
                ELSE
                    ActivateEvent := Eventstatus#NotEnabled;
                    RETURN;
                END_IF;
            ELSE
                ActivateEvent := Eventstatus#NullReference;
            END_IF;
            
        END_METHOD

        METHOD PUBLIC IsActivated : BOOL
            IsActivated := _isActiavted;
        END_METHOD

        METHOD PUBLIC GetID : UINT
            GetID := Id;
        END_METHOD

        METHOD PUBLIC GetPosition : DINT
            GetPosition := Position;
        END_METHOD

        METHOD PUBLIC IsEnabled : BOOL
            IsEnabled := TRUE;
        END_METHOD

        METHOD PUBLIC Check : BOOL
            VAR_INPUT
                tw : ITransportWindow;
                ll : DINT;
                ul : DINT;
            END_VAR
            VAR_TEMP
                _inRange : BOOL;
                _activateRis : BOOL;
                _ul : DINT;
                _ll : DINT;
            END_VAR
            IF (PositiveTolerace = -1) THEN
                _ul := ul;
            ELSE 
                _ul := PositiveTolerace;
            END_IF;
            IF (NegativeTolerance = -1) THEN
                _ll := ll;
            ELSE 
                _ll := NegativeTolerance;
            END_IF;
            _inRange := THIS.InRange(sp := Position, value := tw.GetPosition(), ul := _ul, ll := _ll);
            _activateRis := _inRange AND NOT _activateOld;
            _activateOld := _inRange;
            IF (_activateRis) THEN
                THIS.ActivateEvent(tw);
            END_IF;
            _isActiavted := _activateRis;
            Check := _isActiavted;
        END_METHOD

        METHOD PRIVATE InRange : BOOL
            VAR_INPUT
               sp : DINT;
               value : DINT;
               ul : DINT;
               ll : DINT;
            END_VAR
            VAR_TEMP
               _ul : DINT;
               _ll : DINT;
            END_VAR;
            _ul := sp + ul;
            _ll := sp - ll;

            InRange := value >= _ll AND value <= _ul;
       END_METHOD
    END_CLASS
END_NAMESPACE