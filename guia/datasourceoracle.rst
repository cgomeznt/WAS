Crear un Datasource de Oracle
=============================

Esta actividad se divide en cuatro partes:

* Crear un Authentication alias.
* Crear el JDBC provider.
* Crear el Data Source.
* Hacer el Test Connections.

Crear un Authentication alias.
+++++++++++++++++++++++++++++

Nos vamos a Seguridad 

.. figure:: ../images/40.png


Seguridad global

.. figure:: ../images/41.png


JAAS (Java Authentication and Authorization Service) y Datos de autenticación de J2C

.. figure:: ../images/42.png


Nuevo

.. figure:: ../images/43.png

Aqui debe ser un usuario y clave validad de la base de datos de Oracle.

.. figure:: ../images/44.png


Guardamos.

.. figure:: ../images/45.png


Aplicamos.

.. figure:: ../images/46.png


Crear el JDBC provider.
+++++++++++++++++++++++

Nos vamos a Recursos.

.. figure:: ../images/47.png


JDBC, Proveedores de JDBC

.. figure:: ../images/48.png


Especificamos el ambito y le damos nuevo

.. figure:: ../images/49.png


Cargamos todos los datos que nos piden

.. figure:: ../images/50.png


Debemos tener el **ojdbc6.jar** y lo podemos descargar de http://www.oracle.com/technetwork/apps-tech/jdbc-112010-090769.html
Lo debemos tener en una ruta del servidor, ejemplo /opt/IBM/Oracle/ojdbc6.jar

.. figure:: ../images/51.png


Nos da el resumen

.. figure:: ../images/52.png


Guardamos.

.. figure:: ../images/53.png


Crear el Data Source.
++++++++++++++++++++++++

Nos vamos a Recursos, JDBC y Origen de datos.

.. figure:: ../images/54.png


Seleccionamos el Ambito y le damos Nuevo.

.. figure:: ../images/55.png


Colocamos los nombres del JDBC y JNDI

.. figure:: ../images/56.png


Seleccionamos nuestro Driver.

.. figure:: ../images/57.png


Colocamos nuestra URL jdbc:oracle:thin:@//192.168.56.53:1521/bd12c

.. figure:: ../images/58.png


Seleccionamos el Authentication alias que creamos

.. figure:: ../images/59.png


El Resumen.

.. figure:: ../images/60.png


Guardamos.

.. figure:: ../images/61.png


Hacer el Test Connections
++++++++++++++++++++++++++

.. figure:: ../images/62.png


Y debemos ver que se ejecuto con exito.

.. figure:: ../images/63.png


