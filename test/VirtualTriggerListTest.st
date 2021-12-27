USING AxUnit.Assert;
USING Simatic.Ax.WindowTracking.Trigger;

NAMESPACE Simatic.Ax.WindowTracking.VirtualTrigger
    {TestFixture}
    CLASS TestVirtualTriggerList
        VAR PROTECTED
            tl : TriggerList;
            trig1 : VirtualTrigger;
            trig2 : VirtualTrigger;
            trig3 : VirtualTrigger;
            trig4 : VirtualTrigger;
            evt : TriggerEventMock;
        END_VAR

        METHOD PRIVATE SetupTestTrigger
            trig1.Position := 1100;
            trig1.Id := UINT#1;
            trig1.EventHandler := evt;
            tl.Add(tp := trig1);
            
            trig2.Position := 1200;
            trig2.Id := UINT#2;
            trig2.EventHandler := evt;
            tl.Add(tp := trig2);

            trig3.Position := 1300;
            trig3.Id := UINT#3;
            trig3.EventHandler := evt;
            tl.Add(tp := trig3);

            trig4.Position := 1400;
            trig4.Id := UINT#4;
            trig4.EventHandler := evt;
            tl.Add(tp := trig4);
        END_METHOD

        {Test}
        METHOD PUBLIC TestCount_elements_expect_4
            Equal(expected := UINT#4, actual := tl.Count());
        END_METHOD

        

    END_CLASS

    CLASS VirtualTriggerMock
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            
        END_VAR
        
        METHOD PUBLIC MyMethod
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE