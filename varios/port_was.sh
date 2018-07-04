#=======================================================================
# WebSphere 
# 
# variables globales
#=======================================================================

arg1="$1"
profile="$2"
server="server1"
#=======================================================================
home_web="/home/oracle/apache/webapps/logs/$profile"
dir_domain="/opt/IBM/WebSphere/profiles/D$profile"
dir_log="/logs/$server"
dir_profile_logs="/opt/IBM/WebSphere/profiles/D$profile/logs/$server"
dir_scripts="/home/oracle/scm"
tmp_cache="/temp"
cache="/wstemp"
start="/bin/startServer.sh server1"
stop="/bin/stopServer.sh server1"
#=======================================================================

#=======================================================================
#funciones
#=======================================================================

checkPort()
{
	if [ `grep $profile $dir_scripts/port_list_was.txt | wc -l` -eq 0 ] ; then
		echo -e "\n\e[31mEl puerto no es un Profile de WAS o no esta declarado en la ruta:\n\e[0m $dir_scripts/port_list_was.txt\n\e[0m"
		exit 1
	fi
}

stopPort()
{
        cp $dir_domain"/acsele.log" $home_web"/Respaldo"
        cp $dir_domain$dir_log"/SystemOut.log" $home_web"/Respaldo"
        cp $dir_domain$dir_log"/SystemErr.log" $home_web"/Respaldo"
        cp $dir_domain$dir_log"/native_stderr.log" $home_web"/Respaldo"
        cp $dir_domain$dir_log"/native_stdout.log" $home_web"/Respaldo"
        cp $dir_domain$dir_log"/startServer.log" $home_web"/Respaldo"

        echo -e "" > $dir_domain"/acsele.log"
        echo -e "" > $dir_domain$dir_log"/SystemOut.log"
        echo -e "" > $dir_domain$dir_log"/SystemErr.log"
        echo -e "" > $dir_domain$dir_log"/native_stderr.log"
        echo -e "" > $dir_domain$dir_log"/native_stdout.log"
        echo -e "" > $dir_domain$dir_log"/startServer.log"

        sleep 3

        ln -s $dir_domain"/acsele.log" $home_web"/acsele.log" &> /dev/null
        ln -s $dir_domain$dir_log"/SystemOut.log" $home_web"/log_start_9080.log" &> /dev/null
        ln -s $dir_domain$dir_log"/SystemErr.log" $home_web"/SystemErr.log" &> /dev/null
        ln -s $dir_domain$dir_log"/native_stderr.log" $home_web"/native_stderr.log" &> /dev/null
        ln -s $dir_domain$dir_log"/native_stdout.log" $home_web"/native_stdout.log" &> /dev/null
        ln -s $dir_domain$dir_log"/startServer.log" $home_web"/startServer.log" &> /dev/null
        rm $home_web"/backup/"* &> /dev/null
        chmod -R 777 $home_web"/"
}

#==================================================================================================

updateEAR()
{
	#UPdate the application
	$dir_domain/bin/wsadmin.sh -lang jython -f $dir_scripts/jython/updateAPP.py $1
	# /opt/IBM/WebSphere/profiles/D9100/bin/wsadmin.sh -lang jython -f ./updateAPP.py
}

#==================================================================================================

limpia_home_web()
{
	cd $home_web
	ls | grep 70 | while read line ; do
		cd $line
		> $home_web"/acsele.log"
		> $home_web"/build_RIMAC_9080.log"
		> $home_web"/log_start_9080.log"
		> $home_web"/native_stderr.log"
		> $home_web"/native_stdout.log"
		> $home_web"/startServer.log"
		> $home_web"/"$line".log"
		> $home_web"/AdminServer.log"
		> $home_web"/SystemErr.log"
		cd ..
	done
}

limpia_cache()
{
	echo -e " "
	echo -e  "\n\e[32mejecutando: rm -rf $dir_domain$cache/*\n\e[0m"
	rm -rf $dir_domain$cache/*
	echo -e  "\n\e[32mejecutando: rm -rf $dir_domain$tmp_cache/*\n\e[0m"
	rm -rf $dir_domain$tmp_cache/*
	echo -e " "
}

if [ $# -ne 2 ] ; then
        echo -e "\n\e[31mDebe ingresar una opcion valida\n\e[0m"
        echo -e "\n\e[31mej: \n\e[0m"
        echo -e " "
        echo -e "\n\e[31m       ./port.sh [start|stop|restart|update] port [7001....|all]\n\e[0m"
        exit 1
fi

checkPort
if [ $? -ne 0 ] ; then
	echo "Se sale porque el puerto no esta bien"
	exit 1
fi

case "$arg1" in
	start|START|Start)
                # start 
                echo -e "\n\e[32mIniciando puerto: $profile\n\e[0m"
                sleep 5
                line=$var2
                stopPort
                sleep 3
                $dir_domain$start
		if [ $? -ne 0 ] ; then
			echo -e "\n\e[31mFallo el START\n\e[0m"
			echo -e "\n\e[31m$dir_domain$start\n\e[0m"
			exit 1
		fi
	;;
	stop|STOP|Stop)
                # stop port
                echo -e "\n\e[32mDeteniendo puerto: $profile\n\e[0m"
                sleep 3
                $dir_domain$stop
		if [ $? -ne 0 ] ; then
			echo -e "\n\e[31mFallo el STOP\n\e[0m"
			echo -e "\n\e[31m$dir_domain$stop\n\e[0m"
			ps -ef | grep $profile | grep -v grep | awk '{print $2}' | xargs kill -9
			exit 1
		fi
                limpia_home_web
                limpia_cache
	;;
	restart|RESTART|Restart)
                echo -e "\n\e[32mReiniciando puerto: $profile\n\e[0m"
                sleep 3
                $dir_domain$stop
		if [ $? -ne 0 ] ; then
			echo -e "\n\e[31mFallo el STOP\n\e[0m"
			echo -e "\n\e[31m$dir_domain$stop\n\e[0m"
			exit 1
		fi
                limpia_home_web
                limpia_cache
                sleep 2
                $dir_domain$start
		if [ $? -ne 0 ] ; then
			echo -e "\n\e[31mFallo el START\n\e[0m"
			echo -e "\n\e[31m$dir_domain$start\n\e[0m"
			exit 1
		fi
	;;
	update|UPDATE|Update)
		echo -e -e "\n\e[32mInicia el UPDATE en el puerto: $profile\n\e[0m"
		updateEAR $profile
		echo -e "\n\e[32mSe ejecuto el UPDATE\n\e[0m"
		echo -e "\n\e[32mPuede ir viendo el LOG: /opt/IBM/WebSphere/profiles/D$profile/logs/server1/SystemOut.log\n\e[0m"
		sleep 15
                echo -e "\n\e[32mDeteniendo puerto: $profile\n\e[0m"
		ps -ef | grep $profile | grep -v tail | grep -v grep | awk '{print $2}' | xargs kill -9
                limpia_home_web
                limpia_cache
                echo -e "\n\e[32mIniciando puerto: $profile\n\e[0m"
                sleep 2
                $dir_domain$start
                if [ $? -ne 0 ] ; then
                        echo -e "\n\e[31mFallo el START\n\e[0m"
                        echo -e "\n\e[31m$dir_domain$start\n\e[0m"
                        exit 1
                fi

	;;
	*)
		echo -e "\n\e[31mDebe ingresar una opcion valida\n\e[0m"
		echo -e "\n\e[31mej: \n\e[0m"
		echo -e " "
		echo -e "\n\e[32m	./port.sh [start|stop|restart|update] port [7001....|all]\n\e[0m"
		exit 1	
	;;
esac

echo -e " Opcion introducida: $arg1, el Profile fue: $profile y el server es: $server"

exit 0
