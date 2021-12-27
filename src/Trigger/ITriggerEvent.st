USING Simatic.Ax.WindowTracking.Events;

NAMESPACE Simatic.Ax.WindowTracking.VirtualTrigger
    INTERFACE ITriggerEvent
        METHOD Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
        END_METHOD
    END_INTERFACE

END_NAMESPACE