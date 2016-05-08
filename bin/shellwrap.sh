#!/bin/bash
#
# @brief   Wrap Apps and Tools
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
. $UTIL/bin/logging.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

TOOL_NAME=shellwrap
TOOL_VERSION=ver.1.0
TOOL_HOME=$UTIL_ROOT/$TOOL_NAME/$TOOL_VERSION
TOOL_CFG=$TOOL_HOME/conf/$TOOL_NAME.cfg
TOOL_LOG=$TOOL_HOME/log

declare -A SHELLWRAP_USAGE=(
	[TOOL_NAME]="$TOOL_NAME"
	[ARG1]="[TOOL_NAME] name of tool (jar file)"
	[EX-PRE]="# Deployment tool WoLAN"
	[EX]="$TOOL_NAME WoLAN.jar"	
)

declare -A LOG=(
	[TOOL]="$TOOL_NAME"
	[FLAG]="info"
	[PATH]="$TOOL_LOG"
	[MSG]=""
)

TOOL_DEBUG="false"

#
# @brief Main function 
# @param Value required jar file
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# TOOL_NAME="test.jar"
# __shellwrap "$TOOL_NAME"
#
function __shellwrap() {
	TOOL_NAME=$1
	if [ -n "$TOOL_NAME" ]; then
		if [ -e "$TOOL_NAME" ]; then
			DATE=`date`
			SH_TOOL_NAME="`basename $TOOL_NAME .jar`.sh"
			RUN_TOOL_NAME="`basename $TOOL_NAME .jar`.run"
			cat <<EOF>>"$SH_TOOL_NAME"
#!/bin/bash
#
# @brief   $TOOL_NAME
# @version $TOOL_VERSION
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
			printf "%s\n" "Generating App executable file [$SH_TOOL_NAME]"
			cat "$SH_TOOL_NAME" "$TOOL_NAME" > "$RUN_TOOL_NAME"
			printf "%s\n" "Remove $SH_TOOL_NAME"
			rm "$SH_TOOL_NAME"
			printf "%s\n" "Set permission"
			chmod -R 775 "$RUN_TOOL_NAME"
			printf "%s\n\n" "Done"
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
printf "\n%s\n%s\n\n" "$TOOL_NAME $TOOL_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	__shellwrap "$1"
fi

exit 127

