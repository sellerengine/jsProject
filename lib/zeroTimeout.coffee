define [], () ->
    ### This module is a lot faster than setTimeout(0, method).  Useful for
    waiting for the parent class to add a child before doing something.  Order
    is preserved.

    Gathered from http://dbaron.org/log/20100309-faster-timeouts
    ###
    timeoutIdNext = 0
    timeoutIdLast = -1
    timeouts = {}
    messageName = "zero-timeout-message"

    setZeroTimeout = (fn) ->
        id = timeoutIdNext++
        timeouts[id] = fn
        window.postMessage(messageName, "*")
        return id

    clearZeroTimeout = (id) ->
        delete timeouts[id]

    handleMessage = (event) ->
        if event.source == window and event.data == messageName
            event.stopPropagation()
            for i in [timeoutIdLast + 1...timeoutIdNext]
                fn = timeouts[i]
                delete timeouts[i]
                timeoutIdLast = i
                fn && fn()

    window.addEventListener("message", handleMessage, true)

    return {
        setZeroTimeout: setZeroTimeout
        clearZeroTimeout: clearZeroTimeout
    }

