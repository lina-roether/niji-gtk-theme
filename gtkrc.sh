make_gtkrc() {
  local dest="${1}"
  local name="${2}"
  local theme="${3}"
  local color="${4}"
  local size="${5}"
  local window="${6}"

  [[ "${color}" == '-Light' ]] && local ELSE_LIGHT="${color}"
  [[ "${color}" == '-Dark' ]] && local ELSE_DARK="${color}"

  local GTKRC_DIR="${SRC_DIR}/main/gtk-2.0"
  local THEME_DIR="${1}/${2}${3}${4}${5}"

  case "$theme" in
    '')
      theme_color_dark='#3c84f7'
      theme_color_light='#5b9bf8'
      ;;
    -Purple)
      theme_color_dark='#AB47BC'
      theme_color_light='#BA68C8'
      ;;
    -Pink)
      theme_color_dark='#EC407A'
      theme_color_light='#F06292'
      ;;
    -Red)
      theme_color_dark='#E53935'
      theme_color_light='#F44336'
      ;;
    -Orange)
      theme_color_dark='#F57C00'
      theme_color_light='#FB8C00'
      ;;
    -Yellow)
      theme_color_dark='#FBC02D'
      theme_color_light='#FFD600'
      ;;
    -Green)
      theme_color_dark='#4CAF50'
      theme_color_light='#66BB6A'
      ;;
    -Teal)
      theme_color_dark='#009688'
      theme_color_light='#4DB6AC'
      ;;
    -Grey)
      theme_color_dark='#464646'
      theme_color_light='#DDDDDD'
      ;;
  esac

  if [[ "$blackness" == 'true' ]]; then
	background_light='#FFFFFF'
	background_dark='#0F0F0F'
	background_darker='#121212'
	background_alt='#212121'
	titlebar_light='#F2F2F2'
	titlebar_dark='#030303'
  else
	background_light='#FFFFFF'
	background_dark='#2C2C2C'
	background_darker='#3C3C3C'
	background_alt='#464646'
	titlebar_light='#F2F2F2'
	titlebar_dark='#242424'
  fi

  cp -r "${GTKRC_DIR}/gtkrc${ELSE_DARK:-}-default"                              "${THEME_DIR}/gtk-2.0/gtkrc"
  sed -i "s/#FFFFFF/${background_light}/g"                                      "${THEME_DIR}/gtk-2.0/gtkrc"
  sed -i "s/#2C2C2C/${background_dark}/g"                                       "${THEME_DIR}/gtk-2.0/gtkrc"
  sed -i "s/#464646/${background_alt}/g"                                        "${THEME_DIR}/gtk-2.0/gtkrc"

  if [[ "${color}" == '-Dark' ]]; then
    sed -i "s/#5b9bf8/${theme_color_light}/g"                                   "${THEME_DIR}/gtk-2.0/gtkrc"
    sed -i "s/#3C3C3C/${background_darker}/g"                                   "${THEME_DIR}/gtk-2.0/gtkrc"
    sed -i "s/#242424/${titlebar_dark}/g"                                       "${THEME_DIR}/gtk-2.0/gtkrc"
  else
    sed -i "s/#3c84f7/${theme_color_dark}/g"                                    "${THEME_DIR}/gtk-2.0/gtkrc"
    sed -i "s/#F2F2F2/${titlebar_light}/g"                                      "${THEME_DIR}/gtk-2.0/gtkrc"
  fi
}
