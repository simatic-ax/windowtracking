USING Simatic.Ax.WindowTracking.Trigger;
USING AxUnit.Assert;
NAMESPACE Simatic.Ax.WindowTracking.Trigger
    {TestFixture}
    CLASS TestVirtualTriggerList
        VAR PROTECTED
            tl : VirtualTriggerList;
            TriggerPointList : ARRAY[0..50] OF IVirtualTrigger;
            trig1 : VirtualTrigger := (Id := UINT#1, Position := 1100);
            trig2 : VirtualTrigger := (Id := UINT#2, Position := 1200);
            trig3 : VirtualTrigger := (Id := UINT#3, Position := 1300);
            trig4 : VirtualTrigger := (Id := UINT#4, Position := 1400);
            evt : TriggerEventMock;
        END_VAR

        METHOD PRIVATE SetupTriggerList
            tl.TriggerPointList := REF(TriggerPointList);
            trig1.EventHandler := evt;
            tl.Add(tp := trig1);
            
            trig2.EventHandler := evt;
            tl.Add(tp := trig2);

            trig3.EventHandler := evt;
            tl.Add(tp := trig3);

            trig4.EventHandler := evt;
            tl.Add(tp := trig4);
        END_METHOD

        {Test}
        METHOD PUBLIC TestCount_elements_expect_4
            THIS.SetupTriggerList();
            Equal(expected := UINT#4, actual := tl.Count());
        END_METHOD

        {Test}
        METHOD PUBLIC GetTriggerPoint_on_empty_TriggerPointList_returns_null
            VAR_TEMP
                t : IVirtualTrigger;
            END_VAR
            tl.TriggerPointList := REF(TriggerPointList);
            t := tl.GetTriggerPoint(UINT#1);
            Equal(expected := TRUE, actual := t = NULL);
        END_METHOD

        {Test(id := UINT#1)}
        {Test(id := UINT#2)}
        {Test(id := UINT#3)}
        {Test(id := UINT#4)}
        METHOD PUBLIC  GetTriggerPoint_on_TriggerPointList_with_four_entries_returns_correct_element
            VAR_INPUT
                id : UINT;
            END_VAR
            VAR_TEMP
                vt : IVirtualTrigger;
                pos : DINT;
            END_VAR
            THIS.SetupTriggerList();
            vt := tl.GetTriggerPoint(id);
            pos := vt.GetId();
            Equal(expected := id, actual := tl.GetTriggerPoint(id).GetId());
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