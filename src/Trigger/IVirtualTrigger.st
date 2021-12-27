USING Simatic.Ax.WindowTracking.Events;

NAMESPACE Simatic.Ax.WindowTracking.VirtualTrigger
    INTERFACE IVirtualTrigger
    
        METHOD ActivateEvent : EventStatus
            VAR_INPUT
                tw : ITransportWindow;
            END_VAR
        END_METHOD
        
        METHOD IsActivated
        END_METHOD

        METHOD  IsEnabled : BOOL
        END_METHOD

        METHOD GetID : UINT
        END_METHOD
        
        METHOD GetPosition : DINT
        END_METHOD
        
    END_INTERFACE
END_NAMESPACE