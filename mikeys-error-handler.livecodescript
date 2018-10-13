script "mikeys-error-handler"

local executionErrors
local errorTarget
local errorAction

on libraryStack
   if the target is not me then pass libraryStack
   #<load the error list>
      # <get the path to the folder we're in>
         put the long name of this stack into thePath
         set the itemDelimiter to quote
         put item 2 of thePath into thePath  # remove "stack" and quote on the front, and quote on the back, leaving just the full path
         #<remove the stackname from the path>
            set the itemDelimiter to slash
            delete last item of thePath
         #</remove the stackname from the path>
      # </get the path to the folder we're in>
      put "/errorLists/scriptExecutionErrors.txt" after thePath
      put "file:"&thePath into theFileURL
      put url theFileURL into executionErrors
   #</load the error list>


   #<set properties>
      put "answer" into errorTarget
      if levureAppHasProperty("error-target") then put levureAppGet ("error-target") into errorTarget

      put "abort" into errorAction
      if levureAppHasProperty("error-action") then put levureAppGet ("error-action") into errorAction
   #</set properties
end libraryStack



on errorDialog pExecutionError, pParseError
   put pExecutionError into errMsg
   put executionErrors into errorList

   put "Error:"&CR into goop
   repeat until errmsg is empty
      put "-"&&word 2 to -1 of line (item 1 of line 1 of errmsg) of errorList&return after goop # error code
      
      if item 3 of line 1 of errmsg is not 0 then put "at char"&&item 3 of line 1 of errmsg&space after goop

      if item 2 of line 1 of errmsg is not 0 then put"in line"&&item 2 of line 1 of errmsg after goop

      if the number of items in line 1 of errmsg is 4 then
         if item 4 of line 1 of errmsg is not empty then put return&"Hint:"&&item 4 of line 1 of errmsg after goop
      end if # the number of items in errmsg is 4
      put return after goop
      delete line 1 of errmsg
   end repeat #until errmsg is empty

   if "clipboard" is among the items of errorTarget then set the clipboardData to goop
   if "msg" is among the items of errorTarget then put goop
   if "levure" is among the items of errorTarget then loggerLogMsg goop, "error"
   if "answer" is among the items of errorTarget then answer error goop

   if "continue" is among the items of errorAction then
      return goop for error
   else #continue is not among the items of errorAction
      exit to top
   end if #"continue" is among the items of errorAction
end errorDialog