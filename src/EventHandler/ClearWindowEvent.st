USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.EventHandler
    CLASS ClearWindowEvent IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            WindowList : ITransportWindowsCleanup;
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            // Remove oldest window from list 
            WindowList.Remove();
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE