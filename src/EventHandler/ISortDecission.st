USING Simatic.Ax.WindowTracking.EventHandler;
USING Simatic.Ax.WindowTracking.Trigger;
NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE ISortDecission
        METHOD Check : BOOL
            VAR_INPUT
                tw : ITransportWindow;
                te : IVirtualTrigger;
                exitpoint : IExitPoint;
            END_VAR
        END_METHOD
    END_INTERFACE
END_NAMESPACE