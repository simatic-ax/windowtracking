USING Simatic.Ax.WindowTracking.Exits;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.WindowTracking
    INTERFACE ITransportWindow

        // METHOD GetTriggerPointCount : UINT
        // END_METHOD
        
        // METHOD GetTriggerPoint : ITriggerPoint
        //     VAR_INPUT
        //         Id : UINT;
        //     END_VAR
        // END_METHOD

    
        METHOD Reset
        END_METHOD

        METHOD CalcPosition
            VAR_INPUT
                enc : IEncoder;
            END_VAR
        END_METHOD

        METHOD GetPosition : DINT
        END_METHOD

    END_INTERFACE
END_NAMESPACE