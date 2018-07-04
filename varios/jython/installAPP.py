#install the application
deployEAR="/u02/EAR_Weblogic/9002/CONSIS.ear"
appName="CONSIS"
attr="-appname " + appName + " "
AdminApp.install(deployEAR, "["+attr+"]" );
#save
AdminConfig.save();
