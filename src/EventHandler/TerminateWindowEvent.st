USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.EventHandler
    CLASS TerminateWindowEvent IMPLEMENTS ITriggerEvent
        VAR PUBLIC
            WindowList : ITransportWindowsTerminate;
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            // Remove oldest window from list 
            WindowList.Terminate();
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE