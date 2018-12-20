#import <Cocoa/Cocoa.h>

#include "osx_native_code.h"

void NSApp_setPresentationOptions_hideMenuDock() {
    NSApp.presentationOptions = NSApplicationPresentationHideDock |  NSApplicationPresentationHideMenuBar;
}

void NSProcessInfo_beginActivity_disableSleep() {
    [[NSProcessInfo processInfo]
        beginActivityWithOptions:
            NSActivityUserInitiated |
            NSActivityIdleDisplaySleepDisabled |
            NSActivityIdleSystemSleepDisabled
        reason: @"StageBeam Display in use"];
}
