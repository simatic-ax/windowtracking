NAMESPACE Simatic.Ax.WindowTracking.Trigger
    INTERFACE ITriggerList

        METHOD Add : BOOL
            VAR_INPUT
                tp : IVirtualTrigger;
            END_VAR
        END_METHOD

        METHOD Count : UINT
        END_METHOD

        METHOD GetTriggerPoint : IVirtualTrigger
            VAR_INPUT
                Id : UINT;
            END_VAR
        END_METHOD

        METHOD Check : BOOL
             VAR_INPUT
                tw : ITransportWindow;
             END_VAR
        END_METHOD

    END_INTERFACE
END_NAMESPACE