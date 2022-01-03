USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.EventHandler
    CLASS TerminateWindowEvent IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            WindowList : ITransportWindowsTerminate;
            EventBefore : IUserDefinedEvent;
            EventAfter : IUserDefinedEvent;
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            ;
        END_METHOD
    
        METHOD PUBLIC ActionAfter : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            // Activate additional user defined event before
            IF (EventBefore <> NULL) THEN
                EventBefore.Action(tw := tw, te := te);
            END_IF;

            // Remove oldest window from list 
            WindowList.Terminate();
            
            // Activate additional user defined event after
            IF (EventAfter <> NULL) THEN
                EventAfter.Action(tw := tw, te := te);
            END_IF;
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE