#!/bin/bash
#
# Utility functions by adb

################################################################################
# Select one of the attached devices.
#
# Arguments:
#   None
# Return:
#   0 on success.
# Stdout:
#   serial No. of the selected device
################################################################################
android::select_device() {
  local -a devices=($(adb devices | awk 'NF==2 && $2=="device"{print $1}'))

  if [ ${#devices[@]} -eq 0 ]; then
    return 1
  fi

  if [ ${#devices[@]} -eq 1 ]; then
    echo "${devices[0]}"
  else
    local device=
    local PS3='Which devices would you select? : '
    select device in "${devices[@]}"; do
      if [ "${device}" ]; then
        echo "${device}"
        break
      fi
    done
  fi

  return 0
}

################################################################################
# Send key event to the device
#
# Arguments:
#   $1  key code
#   $2  serial No. of device
#   $3  number of executions (default: 1)
################################################################################
android::send_key_event() {
  local -i count=${3:-1}

  while ((count-- > 0)); do
    adb -s "$2" shell input keyevent $1
  done
}

################################################################################
# Send KEYCODE_DPAD_UP to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_up() {
  android::send_key_event 19 "$@"
}

################################################################################
# Send KEYCODE_DPAD_DOWN to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_down() {
  android::send_key_event 20 "$@"
}

################################################################################
# Send KEYCODE_DPAD_LEFT to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_left() {
  android::send_key_event 21 "$@"
}

################################################################################
# Send KEYCODE_DPAD_RIGHT to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_right() {
  android::send_key_event 22 "$@"
}

################################################################################
# Send KEYCODE_ENTER to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_enter() {
  android::send_key_event 66 "$@"
  sleep 0.5
}

################################################################################
# Send KEYCODE_HOME to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_home() {
  android::send_key_event 3 "$@"
}

################################################################################
# Send KEYCODE_BACK to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_back() {
  android::send_key_event 4 "$@"
  sleep 0.5
}

################################################################################
# Send KEYCODE_TAB to the device
#
# Arguments:
#   $1  serial No. of device
#   $2  number of executions (default: 1)
################################################################################
android::key_tab() {
  android::send_key_event 61 "$@"
}

################################################################################
# Arguments:
#   $1  serial No. of device
# Return:
#   0 if the device is connected to an AC charger.
################################################################################
android::is_connected_to_ac() {
  adb -s "$1" shell dumpsys battery | grep -m 1 AC | grep -q true
}

################################################################################
# Arguments:
#   $1  serial No. of device
# Return:
#   0 if internet is available.
################################################################################
android::is_internet_available() {
  local url=
  local -ar URLS=('google.com' 'yahoo.co.jp')

  for url in "${URLS[@]}"; do
    local -i ret=$(adb -s "$1" shell "ping -c 1 -w 1 ${url} &> /dev/null; echo \$?" \
                     | tr -d '\r')
    if [ ${ret} -eq 0 ]; then
      return 0
    fi
  done

  return 1
}

################################################################################
# Arguments:
#   $1  serial No. of device
# Return:
#   0 if SD card is inserted.
################################################################################
android::is_sdcard_inserted() {
  [ "$(adb -s $1 shell sm list-disks adoptable)" ]
}

################################################################################
# Arguments:
#   $1  serial No. of device
# Return:
#   0 if SIM state is ready.
################################################################################
android::is_sim_state_ready() {
  local state=$(adb -s "$1" shell getprop gsm.sim.state | tr -d '\r')
  [ "${state}" = 'READY' ]
}

################################################################################
# Arguments:
#   $1  serial No. of device
#   $2  activity name (e.g. DeviceAdminSettings, ChooseLockGeneric, etc.)
################################################################################
android::start_settings_activity() {
  adb -s "$1" shell am start -W -n com.android.settings/."$2" -f 0x800000 > /dev/null
  sleep 0.5
}
