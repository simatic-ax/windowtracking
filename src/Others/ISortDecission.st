USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.ExitPointHandler;

NAMESPACE Simatic.Ax.WindowTracking.SortDecission
    INTERFACE ISortDecission
        METHOD Check : BOOL
            VAR_INPUT
                tw : ITransportWindow;
                te : IVirtualTrigger;
                exitpoint : IExitPointHandler;
            END_VAR
        END_METHOD
    END_INTERFACE
END_NAMESPACE