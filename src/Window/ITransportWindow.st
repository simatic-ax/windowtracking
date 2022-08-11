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

        METHOD GetPosition : LINT
        END_METHOD

        METHOD SetPosition
            VAR_INPUT
                pos : LINT;
            END_VAR
        END_METHOD

        METHOD GetItem : IItem
        END_METHOD

        METHOD SetItem
            VAR_INPUT
                i : IItem;
            END_VAR
        END_METHOD

    END_INTERFACE
END_NAMESPACE