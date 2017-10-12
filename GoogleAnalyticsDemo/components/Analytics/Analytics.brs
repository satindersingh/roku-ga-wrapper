Sub init()
    m.top.functionName = "analyticsSendTrackingRequest"
End Sub

Function getAnalyticsBaseUrl()
    return "https://www.google-analytics.com/collect?"
End Function

Sub TraceScreen()
    print "TrackScreen Start"
    
    m.customVars = {}
    m.customVars["t"] = "screenview"
    m.customVars["cd"] = m.top.screen
    
    print "Screen Name: "; m.top.screen   
    print "TrackScreen End"
End Sub

Sub TrackEvent()
    print "TrackEvent Start"
    
    m.customVars = {}
    m.customVars["t"] = "event"
    m.customVars["ec"] = m.top.category
    m.customVars["ea"] = m.top.action
    
    if m.top.label <>invalid and m.top.label <> "" then m.customVars["el"] = m.top.label
    if m.top.value <>invalid and m.top.value <> "" then m.customVars["ev"] = m.top.value

    print m.customVars
    print "TrackEvent End"
End Sub

Sub analyticsSendTrackingRequest()    

    di = CreateObject("roDeviceInfo")
    If(di.GetLinkStatus()) Then
    
        print "Prepare Base Tracker Start"
        appInfo = CreateObject("roAppInfo")
        
        baseData = "v=1"
        baseData = baseData + "&tid=" + getAnalyticsAccountId().Escape()
        baseData = baseData + "&cid=" + di.GetDeviceUniqueId()
        baseData = baseData + "&ul=en"
            
        'baseData = baseData + "&an=" + appInfo.GetTitle()
        baseData = baseData + "&an=" + getAnalyticsAppName().Escape()  
        baseData = baseData + "&av=" + appInfo.GetVersion()
    
        print "Prepare Base Tracker End"
        
        request = CreateObject("roUrlTransfer")
        port = CreateObject("roMessagePort")
        request.SetMessagePort(port)
        request.EnableEncodings(true)
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        request.AddHeader("Content-type", "application/json")
        
        print m.customVars
        for each name in m.customVars
            if m.customVars[name] <> invalid then baseData = baseData + "&" + name + "=" + request.Escape(m.customVars[name])
        next
    
        analyticsUrl = getAnalyticsBaseUrl() + baseData
        print "GA URL: "; analyticsUrl
        request.SetUrl(analyticsUrl)
        
        requestType = request.AsyncGetToString() 
        If (requestType)
            while (true)
                msg = wait(60*1000, port)
                If (type(msg) = "roUrlEvent") then
                    print msg
                    code = msg.GetResponseCode()                    
                    print "GA Response Code:" ; code
                    
                     If (code = 200) then
                        print "GA Submission Successful"
                        return
                     Else
                        print "GA Submission failure"                                                
                        return
                     EndIf
                Else 
                     request.AsyncCancel()
                     print "GA Async Cancel"
                     return
                End If
            End while
        End If
    End If

End Sub
