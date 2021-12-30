# Window Tracking

## Overview
In many applications any items will be transported on a conveyor belt. During the transport it's necessary to track the item position to execute some actions on specific positions. This library provide some support for postion tracking on some conveyors. This solution has virtaul windows and virtual trigger points. A virtual window can be created on a reference point and will be moved regarding some enocder values. When a virtual window reaches a virtual trigger pint, this trigger point will be activated and an event haddler will be called.

## Install this package

Enter:
```cli
apax add @simatic-ax/windowtracking
```
> to install this package you need to login into the GitHub registry. You'll find more information [here](https://github.com/simatic-ax/.github/blob/main/doc/personalaccesstoken.md) 


## Namespace
```
Simatic.Ax.WindowTracking;
Simatic.Ax.WindowTracking.Trigger;
Simatic.Ax.WindowTracking.EventHandler;
Simatic.Ax.WindowTracking.Items;
Simatic.Ax.WindowTracking.ExitPointHandler;
Simatic.Ax.WindowTracking.SortDecission;
```

## VirtualTrigger


|||
|-|-|
|ActivateEvent(tw : ITransportWindow)   | When the virtual window reaches the virtual trigger point, this method will be called. If an `EventHandler : ITriggerEvent` is configured, the `EventHandler.Action(IVirtualTrigger, ITransportWindow)`  method will be called. When the `IsActivated()` method returns `FALSE`, it will not executed|
|IsActivated() : BOOL                   | Returns `TRUE` when the VirtualTrigger is active window has reached the trigger point|
|GetID() : UINT                         | Returns the Id of the VirtualTrigger |
|GetPosition() : DINT                   | Returns the configured position of the VirtualTrigger |
|IsEnabled() : BOOL                   | Returns `TRUE` when the VirtualTrigger is enabled (default `TRUE`)|
| Check(tw : ITransportWindow, ul : DINT, ll : DINT) : BOOL | Returns `TRUE` (One Shot) when the TransportWindow tw is in the range of the VirtualTrigger position. 

```iec-st
USING Simatic.Ax.WindowTracking.Trigger;
USING Simatic.Ax.WindowTracking.EventHandler;

VAR_GLOBAL
    eventHandler : ITriggerEvent;
    trig01 : VirtualTrigger := (ID := UINT#101, Position := 2000, [PositiveTolerace := 50,] [NegativeTolerance := 50,] EventHandler := eventHandler);
END_VAR
```

## Contribution

Thanks for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section or, even better, is free to propose any changes to this repository using Merge Requests.

## License and Legal information

Please read the [Legal information](LICENSE.md)