#Requires AutoHotkey v2.0
#SingleInstance

GetKeyboardLayout() {
	hWnd := DllCall("GetForegroundWindow", "ptr")
    threadId := DllCall("GetWindowThreadProcessId", "ptr", hWnd, "uint*", 0)
    layout := DllCall("GetKeyboardLayout", "uint", threadId, "uptr")

	Return layout & 0xFFFFFFFF
}

/*
F12::{
    MsgBox("Current Keyboard Layout Handle (HKL):`n" GetKeyboardLayout())
}

+F12:: {
    vk := 0
    sc := 0

    ih := InputHook("V")
    ih.KeyOpt("{All}", "+N")  ; Enable key notifications

	ih.OnKeyDown := (ihObj, thisVK, thisSC) => (
		vk := thisVK,
		sc := thisSC,
		ihObj.Stop()
	)
    ih.Start()
    ih.Wait()

    MsgBox "You pressed:`nVK: " Format("0x{:02X}", vk) "`nSC: " Format("0x{:03X}", sc)
}
*/

need_vfDF_key_up := False
#HotIf GetKeyboardLayout() == 0xF0200C0C
<+<#f23::{
    Send "{Blind}{LShift Up}{LWin Up}{vkDF Down}"
	need_vfDF_key_up := True
}

#HotIf GetKeyboardLayout() == 0xF0200C0C or need_vfDF_key_up
<+<#f23 Up::{
	Send "{vkDF Up}"
	need_key_up := False
}
#HotIf
