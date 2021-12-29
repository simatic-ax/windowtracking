USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.Items
    CLASS ItemOneDestination IMPLEMENTS IItem
        
        VAR PUBLIC
            Destination1 : IVirtualTrigger;
        END_VAR

        METHOD PUBLIC GetDestination : IVirtualTrigger;
            GetDestination := Destination1;
        END_METHOD

    END_CLASS
END_NAMESPACE