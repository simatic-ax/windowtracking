USING Simatic.Ax.WindowTracking.EventHandler;

NAMESPACE Simatic.Ax.WindowTracking.Trigger
    CLASS VirtualTrigger IMPLEMENTS IVirtualTrigger

        VAR PUBLIC
            Position : DINT;
            Id : UINT;
            EventHandler : ITriggerEvent;
            PositiveTolerance : DINT := -1;
            NegativeTolerance : DINT := -1;            
        END_VAR

        VAR PROTECTED
            _activeWindow : ITransportWindow;
            _checkState : INT;
            _activations : DINT;
        END_VAR

        VAR CONSTANT PRIVATE  
            EXPECT_WINDOW_IN_RANGE : INT := 0; // Wait for Window in Range
            EXPECT_END_OF_WINDOW : INT := 1;
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
            IsActivated := _activeWindow <> NULL;
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
                _ul : DINT;
                _ll : DINT;
                _evStatus : EventStatus;
            END_VAR

            IF (PositiveTolerance = -1) THEN
                _ul := ul;
            ELSE 
                _ul := PositiveTolerance;
            END_IF;
            IF (NegativeTolerance = -1) THEN
                _ll := ll;
            ELSE 
                _ll := NegativeTolerance;
            END_IF;

            IF (_checkState = EXPECT_WINDOW_IN_RANGE) THEN
                _inRange := THIS.InRange(sp := Position, value := tw.GetPosition(), ul := _ul, ll := _ll);
                IF (_inRange) THEN
                    _activeWindow := tw;
                    _checkState := EXPECT_END_OF_WINDOW;
                    _activations := _activations + 1;
                    IF (EventHandler <> NULL) THEN
                        _evStatus := EventHandler.Action(tw := tw, te := THIS);
                    END_IF;
                    Check := TRUE;
                END_IF;
            ELSIF (_checkState = EXPECT_END_OF_WINDOW) THEN
                // Reject all Windows exept active window
                IF (tw <> _activeWindow) THEN
                    Check := FALSE;
                    RETURN;
                END_IF;
                _inRange := THIS.InRange(sp := Position, value := tw.GetPosition(), ul := _ul, ll := _ll);
                IF (NOT _inRange) THEN
                    _activeWindow := NULL;
                    _checkState := EXPECT_WINDOW_IN_RANGE;
                    IF (EventHandler <> NULL) THEN
                        _evStatus := EventHandler.ActionAfter(tw := tw, te := THIS);
                    END_IF;
                    Check := FALSE;
                END_IF;
            END_IF;        
        END_METHOD

        METHOD PRIVATE InRange : BOOL
            VAR_INPUT
               sp : LINT;
               value : LINT;
               ul : LINT;
               ll : LINT;
            END_VAR
            VAR_TEMP
               _ul : LINT;
               _ll : LINT;
            END_VAR;
            _ul := sp + ul;
            _ll := sp - ll;

            InRange := value >= _ll AND value <= _ul;
       END_METHOD
    END_CLASS
END_NAMESPACE