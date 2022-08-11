USING Simatic.Ax.WindowTracking;

NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE IVirtualTrigger
    
        METHOD ActivateEvent : EventStatus
            VAR_INPUT
                tw : ITransportWindow;
            END_VAR
        END_METHOD
        
        METHOD IsActivated : BOOL
        END_METHOD

        METHOD  IsEnabled : BOOL
        END_METHOD

        METHOD GetID : UINT
        END_METHOD
        
        METHOD GetPosition : DINT
        END_METHOD
        
        METHOD Check : BOOL
            VAR_INPUT
               tw : ITransportWindow;
               ll : DINT;
               ul : DINT;
            END_VAR
       END_METHOD

    END_INTERFACE
END_NAMESPACE