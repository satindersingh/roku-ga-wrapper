' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********  

sub init()
    'm.top.SetFocus(true)
    
    m.button = m.top.findNode("button")
    m.button.observeField("buttonSelected", "buttonTapped")
    m.button.setFocus(true)
    
    'Send GA Screen tracking event.
    Analytics = m.top.createChild("Analytics")
    Analytics.id = "Analytics"
    Analytics.setField("screen", "Home")
    Analytics.traceScreen = true
    Analytics.control = "RUN"
    
End sub

Sub buttonTapped()
    print "Send Event"    
    Analytics = m.top.createChild("Analytics")
    Analytics.id = "Analytics"
    Analytics.setField("category", "Sample button event")
    Analytics.setField("action", "Pressed")
    Analytics.trackEvent = true
    Analytics.control = "RUN"
End Sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    
    return result 
end function
