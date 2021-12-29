USING Simatic.Ax.WindowTracking.Items;
USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.Events;

NAMESPACE Simatic.Ax.WindowTracking.EventHandler
    CLASS SortDecissionOneDestination IMPLEMENTS ISortDecission
        VAR PUBLIC

        END_VAR
        VAR PROTECTED
            
        END_VAR
    
        METHOD PUBLIC Check : BOOL
            VAR_INPUT
                tw : ITransportWindow;
                te : IVirtualTrigger;
                exitpoint : IExitPoint;
            END_VAR
            VAR_TEMP
                _item : REF_TO ItemOneDestination;
            END_VAR
            _item ?= tw.GetItem();
            IF (_item = NULL) THEN
                Check := FALSE;
                RETURN;
            END_IF;
            IF (NOT exitpoint.IsReady()) THEN
                Check := FALSE;
                RETURN;
            END_IF;
            IF (_item^.GetDestination() = te) THEN
                Check := TRUE;
                RETURN;
            END_IF;
        END_METHOD
    END_CLASS
END_NAMESPACE