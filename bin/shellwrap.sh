#!/bin/bash
#
# @brief   Wrap java (jar) App with shell script
# @version ver.1.0
# @date    Mon Jul 15 21:48:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/devel.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/sendmail.sh
. $UTIL/bin/loadconf.sh
. $UTIL/bin/loadutilconf.sh
. $UTIL/bin/progressbar.sh

SHELLWRAP_TOOL=shellwrap
SHELLWRAP_VERSION=ver.1.0
SHELLWRAP_HOME=$UTIL_ROOT/$SHELLWRAP_TOOL/$SHELLWRAP_VERSION
SHELLWRAP_CFG=$SHELLWRAP_HOME/conf/$SHELLWRAP_TOOL.cfg
SHELLWRAP_UTIL_CFG=$SHELLWRAP_HOME/conf/${SHELLWRAP_TOOL}_util.cfg
SHELLWRAP_LOG=$SHELLWRAP_HOME/log

declare -A SHELLWRAP_USAGE=(
	[USAGE_TOOL]="$SHELLWRAP_TOOL"
	[USAGE_ARG1]="[TOOL_NAME] name of tool (jar file)"
	[USAGE_EX_PRE]="# Deployment tool WoLAN"
	[USAGE_EX]="$SHELLWRAP_TOOL WoLAN.jar"	
)

declare -A SHELLWRAP_LOG=(
	[LOG_TOOL]="$SHELLWRAP_TOOL"
	[LOG_FLAG]="info"
	[LOG_PATH]="$SHELLWRAP_LOG"
	[LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
	[BAR_WIDTH]=50
	[MAX_PERCENT]=100
	[SLEEP]=0.01
)

TOOL_DBG="false"

#
# @brief   Main function 
# @param   Value required jar file
# @exitval Function __shellwrap exit with integer value
#			0   - tool finished with success operation 
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from file 
#			130 - failed to load tool script utilities configuration from file
#			131 - missing external tool java 
#			132 - missing target file (check that exist in filesystem)
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
		local MSG="Loading basic and util configuration"
		printf "$SEND" "$OSSL_TOOL" "$MSG"
		__progressbar PB_STRUCTURE
		printf "%s\n\n" ""
		declare -A configshellwrap=()
		__loadconf $SHELLWRAP_CFG configshellwrap
		local STATUS=$?
		if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
			MSG="Failed to load tool script configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$SHELLWRAP_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$SHELLWRAP_TOOL" "$MSG"
			fi
			exit 129
		fi
		declare -A cfgshellwraputil=()
		__loadutilconf $SHELLWRAP_UTIL_CFG cfgshellwraputil
		STATUS=$?
		if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
			MSG="Failed to load tool script utilities configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$SHELLWRAP_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$SHELLWRAP_TOOL" "$MSG"
			fi
			exit 130
		fi
		__checktool "${cfgshellwraputil[JAVA]}"
		STATUS=$?
		if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
			MSG="Missing external tool ${cfgshellwraputil[JAVA]}"
			if [ "${configshellwrap[LOGGING]}" == "true" ]; then
				SHELLWRAP_LOG[LOG_MSGE]=$MSG
				SHELLWRAP_LOG[LOG_FLAG]="error"
				__logging SHELLWRAP_LOG
			fi
			if [ "${configshellwrap[EMAILING]}" == "true" ]; then
				__sendmail "$MSG" "${configshellwrap[ADMIN_EMAIL]}"
			fi
			exit 131
		fi
		if [ -e "$TOOL_NAME" ]; then
			local DATE=`date`
			local SH_TOOL_NAME="`basename $TOOL_NAME .jar`.sh"
			local RUN_TOOL_NAME="`basename $TOOL_NAME .jar`.run"
			local WRAP_SCRIPT="
#!/bin/bash
#
# @brief   $TOOL_NAME
# @version ver.1.0 [shell wrapper]
# @date    $DATE
# @company Frobas IT Department, www.frobas.com 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#

JAVA=java

EXECUTABLE_JAR=\`which \"\$0\" 2>/dev/null\`
[ \$? -gt 0 -a -f \"\$0\" ] && EXECUTABLE_JAR=\"./\$0\"

if test -n \"\$JAVA_HOME\"; then
	JAVA=\"\$JAVA_HOME/bin/java\"
fi

if [ ! -f ${cfgshellwraputil[JAVA]} ]; then
	exit 127
else
	exec \"\$JAVA\" -jar \$EXECUTABLE_JAR
fi
	
exit 0
"
			echo -e "$WRAP_SCRIPT" > "$SH_TOOL_NAME"
			MSG="Generating App executable file [$SH_TOOL_NAME]"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$SHELLWRAP_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$SHELLWRAP_TOOL" "$MSG"
			fi
			cat "$SH_TOOL_NAME" "$TOOL_NAME" > "$RUN_TOOL_NAME"
			MSG="Remove $SH_TOOL_NAME"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$SHELLWRAP_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$SHELLWRAP_TOOL" "$MSG"
			fi
			rm "$SH_TOOL_NAME"
			MSG="Set permission"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$SHELLWRAP_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$SHELLWRAP_TOOL" "$MSG"
			fi
			chmod -R 775 "$RUN_TOOL_NAME"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DEND" "$SHELLWRAP_TOOL" "$FUNC" "Done"
			fi
			MSG="Wrapping java application [$TOOL_NAME]"
			if [ "${configshellwrap[LOGGING]}" == "true" ]; then
				SHELLWRAP_LOG[LOG_MSGE]=$MSG
				SHELLWRAP_LOG[LOG_FLAG]="info"
				__logging SHELLWRAP_LOG
			fi
			exit 0
		fi
		MSG="Missing target file [$TOOL_NAME]"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$SHELLWRAP_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "$SHELLWRAP_TOOL" "$MSG"
		fi
		if [ "${configshellwrap[LOGGING]}" == "true" ]; then
			SHELLWRAP_LOG[LOG_MSGE]=$MSG
			SHELLWRAP_LOG[LOG_FLAG]="info"
			__logging SHELLWRAP_LOG
		fi
		exit 132
	fi
	__usage SHELLWRAP_USAGE
	exit 128
}

#
# @brief   Main entry point
# @param   Value required  jar file
# @exitval Script tool shellwrap exit with integer value
#			0   - tool finished with success operation 
# 			127 - run tool script as root user from cli
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from file 
#			130 - failed to load tool script utilities configuration from file
#			131 - missing external tool java 
#			132 - missing target file (check that exist in filesystem)
#
printf "\n%s\n%s\n\n" "$SHELLWRAP_TOOL $SHELLWRAP_VERSION" "`date`"
__checkroot
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__shellwrap $1
fi

exit 127

