USING Simatic.Ax.WindowTracking.EventHandler;
USING Simatic.Ax.WindowTracking.Trigger;
NAMESPACE Simatic.Ax.WindowTracking.Items
    INTERFACE IItem
        METHOD GetDestination : IVirtualTrigger
            VAR_INPUT 
                id : UINT;
            END_VAR 
        END_METHOD
        METHOD DestinationCount : INT 
        END_METHOD
    END_INTERFACE
END_NAMESPACE