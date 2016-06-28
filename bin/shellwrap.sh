#!/bin/bash
#
# @brief   Wrap java app
# @version ver.1.0
# @date    Mon Jul 15 21:48:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/checkroot.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

SHELLWRAP_TOOL=shellwrap
SHELLWRAP_VERSION=ver.1.0
SHELLWRAP_HOME=$UTIL_ROOT/$SHELLWRAP_TOOL/$SHELLWRAP_VERSION
SHELLWRAP_CFG=$SHELLWRAP_HOME/conf/$SHELLWRAP_TOOL.cfg
SHELLWRAP_LOG=$SHELLWRAP_HOME/log

declare -A SHELLWRAP_USAGE=(
	[TOOL_NAME]="$SHELLWRAP_TOOL"
	[ARG1]="[TOOL_NAME] name of tool (jar file)"
	[EX-PRE]="# Deployment tool WoLAN"
	[EX]="$SHELLWRAP_TOOL WoLAN.jar"	
)

TOOL_DBG="false"

#
# @brief   Main function 
# @param   Value required jar file
# @exitval Function __shellwrap exit with integer value
#			0   - success operation 
#			128 - missing argument
#			129 - wrong argument (check jar file)
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# local TOOL_NAME="test.jar"
# __shellwrap "$TOOL_NAME"
#
function __shellwrap() {
	local TOOL_NAME=$1
	if [ -n "$TOOL_NAME" ]; then
		local FUNC=${FUNCNAME[0]}
		local MSG=""
		if [ -e "$TOOL_NAME" ]; then
			local DATE=`date`
			local SH_TOOL_NAME="`basename $TOOL_NAME .jar`.sh"
			local RUN_TOOL_NAME="`basename $TOOL_NAME .jar`.run"
			cat <<EOF>>"$SH_TOOL_NAME"
#!/bin/bash
#
# @brief   $TOOL_NAME
# @version ver.1.0 [wrap script]
# @date    $DATE
# @company Frobas IT Department, www.frobas.com 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#

JAVA=java

EXECUTABLE_JAR=\`which "\$0" 2>/dev/null\`
[ \$? -gt 0 -a -f "\$0" ] && EXECUTABLE_JAR="./\$0"

if test -n "\$JAVA_HOME"; then
	JAVA="\$JAVA_HOME/bin/java"
fi

if [ ! -f /usr/bin/java ]; then
	exit 127
else
	exec "\$JAVA" -jar \$EXECUTABLE_JAR
fi
	
exit 0

EOF
			if [ "$TOOL_DBG" == "true" ]; then
				MSG="Generating App executable file [$SH_TOOL_NAME]"
				printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
			fi
			cat "$SH_TOOL_NAME" "$TOOL_NAME" > "$RUN_TOOL_NAME"
			if [ "$TOOL_DBG" == "true" ]; then
				MSG="Remove $SH_TOOL_NAME"
				printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
			fi
			rm "$SH_TOOL_NAME"
			if [ "$TOOL_DBG" == "true" ]; then
				MSG="Set permission"
				printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
			fi
			chmod -R 775 "$RUN_TOOL_NAME"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DEND" "$SHELLWRAP_TOOL" "$FUNC" "Done"
			fi
			exit 0
		fi
		__usage $SHELLWRAP_USAGE
		exit 129
	fi
	__usage $SHELLWRAP_USAGE
	exit 128
}

#
# @brief   Main entry point
# @param   Value required  jar file
# @exitval Script tool shellwrap exit with integer value
#			0   - success operation 
# 			127 - run as root user
#			128 - missing argument
#			129 - wrong argument (check jar file)
#
printf "\n%s\n%s\n\n" "$SHELLWRAP_TOOL $SHELLWRAP_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	set -u
	TOOL=${1:-}
	__shellwrap "$TOOL"
fi

exit 127
