USING Simatic.Ax.WindowTracking.Events;
USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.EventHandler
    CLASS ExitPoint IMPLEMENTS ITriggerEvent, IExitPoint

        VAR PUBLIC
            SortDecission : ISortDecission;
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            VAR_TEMP
                _sortItem : BOOL;
            END_VAR
            _sortItem := SortDecission.Check(tw := tw, te := te, exitpoint := THIS);
            
        END_METHOD
    
        METHOD PUBLIC IsReady : BOOL
            IsReady := TRUE;
        END_METHOD
    END_CLASS
END_NAMESPACE