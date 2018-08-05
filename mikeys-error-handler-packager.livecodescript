script "mikeys-error-handler-packager"

#builds the error file at app build time - who knows, LC might have added some errors or changed error numbers or messages.
on finalizePackagedAssets
	#<get the path to the folder we're in>
		put the long name of this stack into thePath
		set the itemDelimiter to quote
		put item 2 of thePath into thePath  # remove "stack" and quote on the front, and quote on the back, leaving just the full path
		#<remove the stackname from the path>
			set the itemDelimiter to slash
			delete last item of thePath
		#</remove the stackname from the path>
	# </get the path to the folder we're in>
	put "/errorLists/scriptExecutionErrors.txt" after thePath #add the subfolder and filename
	put "file:"&thePath into theFileURL #make it a URL
	put the scriptExecutionErrors into theFileURL #put the current scriptExecutionErrors into that file
end finalizePackagedAssets
