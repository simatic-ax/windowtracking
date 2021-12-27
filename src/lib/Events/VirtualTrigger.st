USING Simatic.Ax.WindowTracking.VirtualTrigger;
NAMESPACE Simatic.Ax.WindowTracking.Events
    CLASS VirtualTrigger IMPLEMENTS IVirtualTrigger

        VAR PUBLIC
            Position : DINT;
            Id : UINT;
            EventHandler : ITriggerEvent;
        END_VAR

        VAR PROTECTED
            _isActiavted : BOOL;
        END_VAR

        METHOD PUBLIC ActivateEvent : EventStatus
            VAR_INPUT
                tw : ITransportWindow;
            END_VAR
            IF EventHandler <> NULL THEN
                ActivateEvent := EventHandler.Action(te := THIS, tw := tw);
                RETURN;
            ELSE
                ActivateEvent := Eventstatus#NullReference;
            END_IF;
            
        END_METHOD
        
        METHOD PUBLIC IsActivated
            ;
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

    END_CLASS
END_NAMESPACE