USING Simatic.Ax.WindowTracking.Exits;
USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking
    CLASS SortDecissionOneDestination IMPLEMENTS ISortDecission
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            
        END_VAR
    
        METHOD PUBLIC Check : BOOL
            VAR_INPUT
                o : ITransportWindow;
            END_VAR
            
            VAR_TEMP
                i : UINT;
                _tp : IVirtualTrigger;
                _exit : IExit;
            END_VAR
            ;
            // Check the destination. Only one Destination is valid!
            // IF (o.GetTriggerPointCount() = UINT#1) THEN 
            //     _tp := o.GetTriggerPoint(UINT#0);
            //     // _exit := o.GetExit();
                
            //     IF (NOT(_tp.IsEnabled())) THEN
            //         Check := FALSE;
            //         RETURN;
            //     END_IF;

            //     IF (NOT(_exit.IsReady())) THEN
            //         Check := FALSE;
            //         RETURN;
            //     END_IF;
                
            //     Check := TRUE;

            // END_IF;
        END_METHOD
    END_CLASS
END_NAMESPACE