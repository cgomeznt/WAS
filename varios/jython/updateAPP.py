import sys
#Stop app

#UPdate the application
deployEAR="/u02/EAR_Weblogic/"+sys.argv[0]+"/CONSIS.ear"
appName="CONSIS"
attr="-appname " + appName + " "
AdminApp.update("CONSIS", "app", "[-operation update -contents "+deployEAR+"]");
#save
AdminConfig.save();

