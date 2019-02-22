script "Execution Error Dialog Back Script"
on errorDialog pError
  if there is a stack "Logger Library" then
    loggerLogMsg pError & cr & the executionContexts, "error"
  end if

  beep
  answer error pError
end errorDialog
