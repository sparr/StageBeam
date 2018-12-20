#import <Cocoa/Cocoa.h>

#include "osx_native_code.h"

void NSRunningApplication_setPresentationOptions(unsigned int options) {
    NSApp.presentationOptions = options;
}
