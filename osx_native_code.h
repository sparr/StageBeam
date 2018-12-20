#ifndef OSX_NATIVE_CODE_H
#define OSX_NATIVE_CODE_H

#ifdef __cplusplus
extern "C" {
#endif

void NSApp_setPresentationOptions_hideMenuDock();
void NSProcessInfo_beginActivity_disableSleep();

#ifdef __cplusplus
}
#endif

#endif // OSX_NATIVE_CODE_H
