NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE ITriggerEvent
        METHOD Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
        END_METHOD
        METHOD ActionAfter : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
        END_METHOD
    END_INTERFACE

END_NAMESPACE