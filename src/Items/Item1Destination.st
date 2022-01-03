USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.Items
    CLASS ItemOneDestination IMPLEMENTS IItem
        
        VAR PUBLIC
            Destination1 : IVirtualTrigger;
        END_VAR

        METHOD PUBLIC GetDestination : IVirtualTrigger
            VAR_INPUT
                id : UINT := UINT#0;
            END_VAR
            GetDestination := Destination1;
        END_METHOD

        METHOD PUBLIC DestinationCount : INT
            IF (Destination1 <> NULL) THEN  
                DestinationCount := 1;
            ELSE
                DestinationCount := 0;
            END_IF;
        END_METHOD
    END_CLASS
END_NAMESPACE