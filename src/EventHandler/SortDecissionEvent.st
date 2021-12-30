USING Simatic.Ax.WindowTracking.EventHandler;
USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.SortDecission;
USING Simatic.Ax.WindowTracking.ExitPointHandler;

NAMESPACE Simatic.Ax.WindowTracking.EventHandler
    CLASS SortDecissionEvent IMPLEMENTS ITriggerEvent

        VAR PUBLIC
            SortStrategy : ISortStrategy;
            ExitHandler : IExitPointHandler;
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            VAR_TEMP
                _check : BOOL;
            END_VAR
            
            IF (SortStrategy = NULL) THEN
                Action := EventStatus#NullReference;
                RETURN;
            END_IF;
            IF (ExitHandler = NULL) THEN
                Action := EventStatus#NullReference;
                RETURN;
            END_IF;

            _check := SortStrategy.Check(tw := tw, te := te, exitpoint := ExitHandler);
            
            IF (_check) THEN
                ExitHandler.Activate();
                Action := EventStatus#Finished; 
                RETURN;
            END_IF;

            Action := EventStatus#Undefined; 

        END_METHOD
    
    END_CLASS
END_NAMESPACE