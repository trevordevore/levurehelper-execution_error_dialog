script "errorDialog"

local executionErrors

on libraryStack
	put url "file:./scriptExecutionErrors.txt" into executionErrors
end libraryStack



on errorDialog pExecutionError, pParseError
   put pExecutionError into errMsg
   put executionErrors into errorList

   put "Error:"&CR into goop
   repeat until errmsg is empty
      put "-"&&word 2 to -1 of line (item 1 of line 1 of errmsg) of errorList&return after goop # error code
      
      if item 3 of line 1 of errmsg is not 0 then
      	put "at char"&&item 3 of line 1 of errmsg&space after goop
      end if #item 3 of errmsg is not 0
      if item 2 of line 1 of errmsg is not 0 then
      	put"in line"&&item 2 of line 1 of errmsg after goop
      end if #item 2 of errmsg is not 0
      if the number of items in line 1 of errmsg is 4 then
      	if item 4 of line 1 of errmsg is not empty then put return&"Hint:"&&item 4 of line 1 of errmsg after goop
      end if # the number of items in errmsg is 4
      put return after goop
      #answer error goop with "Cancel" or "More..."
      #if it is "Cancel" then exit errorDialog
      delete line 1 of errmsg
   end repeat #until it is empty
   answer error goop
end errorDialog