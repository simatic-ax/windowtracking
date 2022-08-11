USING Simatic.Ax.WindowTracking;

NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE ISortStrategy
        METHOD Check : BOOL
            VAR_INPUT
                tw : ITransportWindow;
                te : IVirtualTrigger;
                exitpoint : IExitPointHandler;
            END_VAR
        END_METHOD
    END_INTERFACE
END_NAMESPACE