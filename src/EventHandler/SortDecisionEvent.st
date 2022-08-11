NAMESPACE Simatic.Ax.WindowTracking
/// A sort decision event is a predefined trigger event that can be used specifically 
/// to handle route decisions. Whenever a window passes a virtual trigger (trigger point) 
/// that has a `sort decision event`, it is checked whether the item should trigger an 
/// action at this trigger point. 
///
/// Public interface:
/// SortStrategy : ISortStrategy;   
///   Checks whether an action should be triggered for the item at this trigger point 
///
/// ExitHandler : IExitPointHandler;
///   Action() of the IExitPointHandler is executed when SortStrategy.Check() returns TRUE
/// 
/// EventBefore : IUserDefinedEvent;  Userdefined event which is called before the Action() of the IExitPointHandler is called
/// EventAfter : IUserDefinedEvent;   Userdefined event which is called after the Action() of the IExitPointHandler is called
{axcode:docs-v0:@simatic-ax/windowtracking:SortDecissionEvent.md}
CLASS FINAL SortDecisionEvent IMPLEMENTS ITriggerEvent

        VAR PUBLIC
            SortStrategy : ISortStrategy;
            ExitHandler : IExitPointHandler;
            EventBefore : IUserDefinedEvent;
            EventAfter : IUserDefinedEvent;
        END_VAR
    
        METHOD PUBLIC Action : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            VAR_TEMP
                _check : BOOL;
            END_VAR
            
            IF (SortStrategy = NULL) THEN
                Action := EventStatus#NullReference;
                RETURN;
            END_IF;
            IF (ExitHandler = NULL) THEN
                Action := EventStatus#NullReference;
                RETURN;
            END_IF;

            _check := SortStrategy.Check(tw := tw, te := te, exitpoint := ExitHandler);
            
            
            IF (_check) THEN
                // Activate additional user defined event before
                IF (EventBefore <> NULL) THEN
                    EventBefore.Action(tw := tw, te := te);
                END_IF;            

                ExitHandler.Activate();
                Action := EventStatus#Finished; 

                // Activate additional user defined event after
                IF (EventAfter <> NULL) THEN
                    EventAfter.Action(tw := tw, te := te);
                END_IF;

                RETURN;
            END_IF;


            Action := EventStatus#Undefined; 

        END_METHOD
    
        METHOD PUBLIC ActionAfter : EventStatus
            VAR_INPUT
                te : IVirtualTrigger;
                tw : ITransportWindow;
            END_VAR
            ; // do nothing
        END_METHOD
    END_CLASS
END_NAMESPACE