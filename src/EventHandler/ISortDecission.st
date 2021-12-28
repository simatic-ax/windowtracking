NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE ISortDecission
        METHOD Check : BOOL
            VAR_INPUT
                o : ITransportWindow;
            END_VAR
        END_METHOD
    END_INTERFACE
END_NAMESPACE