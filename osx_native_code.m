#import <Cocoa/Cocoa.h>

#include "osx_native_code.h"

void NSRunningApplication_setPresentationOptions(unsigned int options) {
    NSApplication *this = (NSApplication *) NSRunningApplication.currentApplication;
    this.presentationOptions = options;
}
