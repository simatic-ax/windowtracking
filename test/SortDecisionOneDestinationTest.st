USING AxUnit.Assert;
USING Simatic.Ax.WindowTracking.EventHandler;
USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.Items;
USING Simatic.Ax.WindowTracking.ExitPointHandler;

NAMESPACE Simatic.Ax.WindowTracking.SortDecision
    {TestFixture}
    CLASS SortDecisionOneDestinationTest
        VAR PROTECTED
            sd : SortDecisionOneDestination;
            tw : TransportWindow;
            te : VirtualTrigger;
            te_notok : VirtualTrigger;
            ep : SortDecisionEvent;
            eph : ExitEventHandlerMock;
            item : ItemOneDestination;
        END_VAR
        
        METHOD PROTECTED Setup
            item.Destination1 := te;
            tw.Item := item;
            
            te.Id := UINT#1;
            te.Position := 1000;
            te.EventHandler := ep;
            
            ep.SortStrategy := sd;
            ep.ExitHandler := eph;
        END_METHOD

        {Test}
        METHOD PUBLIC Check_SortdecissonOk
            VAR_TEMP
                _check : BOOL;
            END_VAR
            THIS.Setup();
            _check := sd.Check(tw := tw, te := te, exitpoint := eph);
            Equal(expected := TRUE, actual := _check);
        END_METHOD
        
        {Test}
        METHOD PUBLIC Check_SortdecissonNotOk
            VAR_TEMP
                _check : BOOL;
            END_VAR
            THIS.Setup();
            _check := sd.Check(tw := tw, te := te_notok, exitpoint := eph);
            Equal(expected := FALSE, actual := _check);
        END_METHOD
    
    END_CLASS

    CLASS ExitEventHandlerMock IMPLEMENTS IExitPointHandler
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            
        END_VAR
    
        METHOD PUBLIC IsReady : BOOL
            IsReady := TRUE;
        END_METHOD

        METHOD PUBLIC Activate : BOOL
            ;
        END_METHOD
END_CLASS

END_NAMESPACE