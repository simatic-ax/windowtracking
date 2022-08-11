NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE IUserDefinedEvent
        METHOD Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
        END_METHOD
    END_INTERFACE

END_NAMESPACE