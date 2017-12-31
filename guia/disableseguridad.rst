Disable Seguridad de IBM WebSphere Application Server
=====================================================

Ir al DMGR Profile y ejecutar el wsadmin.sh.::

	$ /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/wsadmin.sh 
	Reino/Nombre de célula: <default>
	Username: 
	Password: 
	 WASX7246E: No se puede establecer la conexión "SOAP" con el host "localhost" debido a un error de autenticación. Asegúrese de que el usuario y la contraseña sean correctos en la línea de mandatos o en el archivo de propiedades.
	Mensaje de excepción (si existe): "ADMN0022E: Se ha denegado el acceso para la operación getProcessType en el MBean Server debido a que las credenciales no son suficientes o están vacías."
	WASX7213I: El cliente de scripts no está conectado a un proceso de servidor; consulte el archivo de anotaciones cronológicas /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/wsadmin.traceout para obtener información adicional.
	WASX8011W: El objeto AdminTask no está disponible.
	WASX7029I: Para obtener ayuda, entre: "$Help help"
	wsadmin>

.::

	wsadmin>securityoff
	WASX7015E: Excepción al ejecutar el mandato: "securityoff"; información de excepción: 
	com.ibm.ws.scripting.ScriptingException: WASX7070E: El servicio de configuración no está disponible.

	wsadmin>

	wsadmin>exit

Realice un respaldo de  security.xml, esta ubicado en DMGR profile/config/cells/CellName. Debe cambiar de true a false **enabled="false"** .::

	$ vi /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/config/cells/nullNode01Cell/security.xml
	<security:Security xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:orb.securityprotocol="http://www.ibm.com/websphere/appserver/schemas/5.0/orb.securityprotocol.xmi" xmlns:security="http://www.ibm.com/websphere/appserver/schemas/5.0/security.xmi" xmi:id="Security_1" useLocalSecurityServer="true" useDomainQualifiedUserNames="false" **enabled="false"** cacheTimeout="600" issuePermissionWarning="true" activeProtocol="BOTH" enforceJava2Security="false" enforceFineGrainedJCASecurity="false" appEnabled="false" dynamicallyUpdateSSLConfig="true" allowBasicAuth="true" activeAuthMechanism="LTPA_1" activeUserRegistry="WIMUserRegistry_1" defaultSSLSettings="SSLConfig_nullNode01_1" adminPreferredAuthMech="RSAToken_1">



Matamos el WebSphere Application Server y lo iniciamos nuevamente, recuerde que solo va cargar por el http://IP_SERVER:9060/ibm/console






