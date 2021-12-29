USING Simatic.Ax.WindowTracking.EventHandler;
USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.SortDecission;

NAMESPACE Simatic.Ax.WindowTracking.Events
    CLASS ExitPoint IMPLEMENTS ITriggerEvent

        VAR PUBLIC
            SortDecission : ISortDecission;
            ExitHandler : IExitPointHandler;
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            VAR_TEMP
                _sortItem : BOOL;
            END_VAR
            _sortItem := SortDecission.Check(tw := tw, te := te, exitpoint := ExitHandler);
            
        END_METHOD
    
    END_CLASS
END_NAMESPACE