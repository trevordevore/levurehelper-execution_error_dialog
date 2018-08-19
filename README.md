# Mikey's Error Handler

## Started as the usual more-helpful error dialog handler, updated for use as a Levure Helper
## Added keeping the error lists in a file b/c on mobile LC does not compile the error lists into the app.
## Error list (re)created at app package/build time in case your current version of LC added to or changed the contents of the error list.
## Added parameters to keep in project app.yml file
	* error-target: comma-delimited list, of where error messages will be returned.
		 answer					(dialog) (this is the default)
		 clipboard				(error message to clipboard.  More useful if dialog is also used so we don't lose the error)
		 ignore (or empty)	(don't report the error).  Note that if there are other targets in a list, this does not override them.
		 levure 					(sends the error to Levure's logger helper)
		 msg 						(message box)
	* error-action: 
		abort						(exit to top) (this is the default)
		continue					(continue execution, pass the message for error, which sets ```the result```)
