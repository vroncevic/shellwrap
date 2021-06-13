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
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh

SHELLWRAP_TOOL=shellwrap
SHELLWRAP_VERSION=ver.1.0
SHELLWRAP_HOME=${UTIL_ROOT}/${SHELLWRAP_TOOL}/${SHELLWRAP_VERSION}
SHELLWRAP_CFG=${SHELLWRAP_HOME}/conf/${SHELLWRAP_TOOL}.cfg
SHELLWRAP_UTIL_CFG=${SHELLWRAP_HOME}/conf/${SHELLWRAP_TOOL}_util.cfg
SHELLWRAP_LOG=${SHELLWRAP_HOME}/log

declare -A SHELLWRAP_USAGE=(
    [Usage_TOOL]="${SHELLWRAP_TOOL}"
    [Usage_ARG1]="[TOOL NAME] Name of tool (jar file)"
    [Usage_EX_PRE]="# Deployment: tool WoLAN"
    [Usage_EX]="${SHELLWRAP_TOOL} WoLAN.jar"
)

declare -A SHELLWRAP_LOGGING=(
    [LOG_TOOL]="${SHELLWRAP_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${SHELLWRAP_LOG}"
    [LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
    [BW]=50
    [MP]=100
    [SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief   Main function 
# @param   Value required jar file
# @exitval Function __shellwrap exit with integer value
#            0   - tool finished with success operation
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing tool java
#            131 - missing target file (check that exist in filesystem)
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# local TN="test.jar"
# __shellwrap "$TN"
#
function __shellwrap {
    local TN=$1
    if [ -n "$TN" ]; then
        local FUNC=${FUNCNAME[0]} MSG="None"
        local STATUS_CONF STATUS_CONF_UTIL STATUS
        MSG="Loading basic and util configuration!"
        info_debug_message "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
        progress_bar PB_STRUCTURE
        declare -A config_shellwrap=()
        load_conf "$SHELLWRAP_CFG" config_shellwrap
        STATUS_CONF=$?
        declare -A config_shellwrap_util=()
        load_util_conf "$SHELLWRAP_UTIL_CFG" config_shellwrap_util
        STATUS_CONF_UTIL=$?
        declare -A STATUS_STRUCTURE=([1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL)
        check_status STATUS_STRUCTURE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
            exit 129
        fi
        TOOL_DBG=${config_shellwrap[DEBUGGING]}
        TOOL_LOG=${config_shellwrap[LOGGING]}
        TOOL_NOTIFY=${config_shellwrap[EMAILING]}
        local JAVA=${config_shellwrap_util[JAVA]}
        check_tool "${JAVA}"
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Install tool ${JAVA}"
            info_debug_message "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
            exit 130
        fi
        if [ -e "${TN}" ]; then
            local DATE=`date` SH_TN="`basename ${TN} .jar`.sh" H="#" T="    "
            local RUN_TN="`basename ${TN} .jar`.run" SHL
            local SHT=${confg_shellwrap_util[SHELL]}
            local SHTF="${SHELLWRAP_HOME}/conf/${SHT}"
            local AN=${confg_shellwrap_util[AUTHOR_NAME]}
            local AE=${confg_shellwrap_util[AUTHOR_EMAIL]}
            local COMPANY=${confg_shellwrap_util[COMPANY]}
            local V=${confg_shellwrap_util[VERSION]}
            while read SHL
            do
                eval echo "${SHL}" >> ${SH_TN}
            done < ${SHTF}
            MSG="Generating App executable file [${SH_TN}]"
            info_debug_message "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
            cat "$SH_TN" "$TN" > "$RUN_TN"
            MSG="Remove ${SH_TN}"
            info_debug_message "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
            rm "$SH_TN"
            MSG="Set permission!"
            info_debug_message "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
            eval "chmod -R 775 ${RUN_TN}"
            MSG="Wrapping java application [${TN}]"
            info_debug_message "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
            SHELLWRAP_LOGGING[LOG_MSGE]=$MSG
            SHELLWRAP_LOGGING[LOG_FLAG]="info"
            logging SHELLWRAP_LOGGING
            info_debug_message_end "Done" "$FUNC" "$SHELLWRAP_TOOL"
            exit 0
        fi
        MSG="Check target tool [${TN}]"
        info_debug_message "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
        MSG="Force exit!"
        info_debug_message_end "$MSG" "$FUNC" "$SHELLWRAP_TOOL"
        exit 131
    fi
    usage SHELLWRAP_USAGE
    exit 128
}

#
# @brief   Main entry point
# @param   Value required  jar file
# @exitval Script tool shellwrap exit with integer value
#            0   - tool finished with success operation
#            127 - run tool script as root user from cli
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing tool java
#            131 - missing target file (check that exist in filesystem)
#
printf "\n%s\n%s\n\n" "${SHELLWRAP_TOOL} ${SHELLWRAP_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __shellwrap $1
fi

exit 127

