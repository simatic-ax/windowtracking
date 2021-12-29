USING Simatic.Ax.WindowTracking.Items;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE ITransportWindow
    
        METHOD Reset
        END_METHOD

        METHOD CalcPosition : BOOL
            VAR_INPUT
                enc : IEncoder;
            END_VAR
        END_METHOD

        METHOD GetPosition : DINT
        END_METHOD

        METHOD GetItem : IItem
        END_METHOD

    END_INTERFACE
END_NAMESPACE