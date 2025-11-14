make_assets() {
  local dest="${1}"
  local name="${2}"
  local theme="${3}"
  local color="${4}"
  local size="${5}"
  local window="${6}"

  [[ "${color}" == '-Light' ]] && local ELSE_LIGHT="${color}"
  [[ "${color}" == '-Dark' ]] && local ELSE_DARK="${color}"

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
	background_dark_alt='#121212'
	titlebar_light='#F2F2F2'
	titlebar_dark='#030303'
  else
	background_light='#ffffff'
	background_dark='#2c2c2c'
	background_dark_alt='#3c3c3c'
	titlebar_light='#f2f2f2'
	titlebar_dark='#242424'
  fi

  mkdir -p                                                                      "${THEME_DIR}/cinnamon/assets"
  cp -r "${SRC_DIR}/assets/cinnamon/theme/"*'.svg'                              "${THEME_DIR}/cinnamon/assets"
  cp -r "${SRC_DIR}/assets/cinnamon/thumbnail${color}.svg"                      "${THEME_DIR}/cinnamon/thumbnail.png"

  mkdir -p                                                                      "${THEME_DIR}/gnome-shell/assets"
  cp -r "${SRC_DIR}/assets/gnome-shell/theme/"*'.svg'                           "${THEME_DIR}/gnome-shell/assets"

  cp -r "${SRC_DIR}/assets/gtk/assets"                                          "${THEME_DIR}/gtk-3.0"
  cp -r "${SRC_DIR}/assets/gtk/assets"                                          "${THEME_DIR}/gtk-4.0"
  cp -r "${SRC_DIR}/assets/gtk/thumbnail${ELSE_DARK:-}.svg"                     "${THEME_DIR}/gtk-3.0/thumbnail.png"
  cp -r "${SRC_DIR}/assets/gtk/thumbnail${ELSE_DARK:-}.svg"                     "${THEME_DIR}/gtk-4.0/thumbnail.png"

  sed -i "s/#5b9bf8/${theme_color_light}/g"                                     "${THEME_DIR}/cinnamon/assets/"*'.svg'
  sed -i "s/#3c84f7/${theme_color_dark}/g"                                      "${THEME_DIR}/cinnamon/assets/"*'.svg'

  sed -i "s/#5b9bf8/${theme_color_light}/g"                                     "${THEME_DIR}/gnome-shell/assets/"*'.svg'
  sed -i "s/#3c84f7/${theme_color_dark}/g"                                      "${THEME_DIR}/gnome-shell/assets/"*'.svg'

  sed -i "s/#5b9bf8/${theme_color_light}/g"                                     "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/assets/*'.svg'
  sed -i "s/#3c84f7/${theme_color_dark}/g"                                      "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/assets/*'.svg'
  sed -i "s/#ffffff/${background_light}/g"                                      "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/assets/*'.svg'
  sed -i "s/#2c2c2c/${background_dark}/g"                                       "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/assets/*'.svg'
  sed -i "s/#3c3c3c/${background_dark_alt}/g"                                   "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/assets/*'.svg'

  if [[ "${color}" == '-Dark' ]]; then
    sed -i "s/#2c2c2c/${background_dark}/g"                                     "${THEME_DIR}/cinnamon/thumbnail.png"
    sed -i "s/#5b9bf8/${theme_color_light}/g"                                   "${THEME_DIR}/cinnamon/thumbnail.png"
    sed -i "s/#2c2c2c/${background_dark}/g"                                     "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/thumbnail.png
    sed -i "s/#5b9bf8/${theme_color_light}/g"                                   "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/thumbnail.png
  else
    sed -i "s/#ffffff/${background_light}/g"                                    "${THEME_DIR}/cinnamon/thumbnail.png"
    sed -i "s/#f2f2f2/${titlebar_light}/g"                                      "${THEME_DIR}/cinnamon/thumbnail.png"
    sed -i "s/#3c84f7/${theme_color_dark}/g"                                    "${THEME_DIR}/cinnamon/thumbnail.png"
    sed -i "s/#f2f2f2/${titlebar_light}/g"                                      "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/thumbnail.png
    sed -i "s/#3c84f7/${theme_color_dark}/g"                                    "${THEME_DIR}/"{gtk-3.0,gtk-4.0}/thumbnail.png
  fi

  cp -r "${SRC_DIR}/assets/cinnamon/common-assets/"*'.svg'                      "${THEME_DIR}/cinnamon/assets"
  cp -r "${SRC_DIR}/assets/cinnamon/assets${ELSE_DARK:-}/"*'.svg'               "${THEME_DIR}/cinnamon/assets"

  cp -r "${SRC_DIR}/assets/gnome-shell/common-assets/"*'.svg'                   "${THEME_DIR}/gnome-shell/assets"
  cp -r "${SRC_DIR}/assets/gnome-shell/assets${ELSE_DARK:-}/"*'.svg'            "${THEME_DIR}/gnome-shell/assets"

  cp -r "${SRC_DIR}/assets/gtk/symbolics/"*'.svg'                               "${THEME_DIR}/gtk-3.0/assets"
  cp -r "${SRC_DIR}/assets/gtk/symbolics/"*'.svg'                               "${THEME_DIR}/gtk-4.0/assets"

  cp -r "${SRC_DIR}/assets/gtk-2.0/assets-common${ELSE_DARK:-}"                              "${THEME_DIR}/gtk-2.0/assets"
  cp -r "${SRC_DIR}/assets/gtk-2.0/assets${theme}${ELSE_DARK:-}/"*"png"                      "${THEME_DIR}/gtk-2.0/assets"

  cp -r "${SRC_DIR}/assets/metacity-1/assets${window}"                                       "${THEME_DIR}/metacity-1/assets"
  cp -r "${SRC_DIR}/assets/metacity-1/thumbnail${ELSE_DARK:-}.png"                           "${THEME_DIR}/metacity-1/thumbnail.png"

  cp -r "${SRC_DIR}/assets/xfwm4/svg/assets${ELSE_LIGHT:-}${window}/"*.svg                   "${THEME_DIR}/xfwm4"
  cp -r "${SRC_DIR}/assets/xfwm4/svg/assets${ELSE_LIGHT:-}${window}-hdpi/"*.svg              "${THEME_DIR}-hdpi/xfwm4"
  cp -r "${SRC_DIR}/assets/xfwm4/svg/assets${ELSE_LIGHT:-}${window}-xhdpi/"*.svg             "${THEME_DIR}-xhdpi/xfwm4"
  cp -r "${SRC_DIR}/assets/xfwm4/xpm/assets/"*.xpm                                           "${THEME_DIR}/xfwm4"
  cp -r "${SRC_DIR}/assets/xfwm4/xpm/assets-hdpi/"*.xpm                                      "${THEME_DIR}-hdpi/xfwm4"
  cp -r "${SRC_DIR}/assets/xfwm4/xpm/assets-xhdpi/"*.xpm                                     "${THEME_DIR}-xhdpi/xfwm4"

  if [[ "$normal" == "true" ]] ; then
    mv -f "${THEME_DIR}/xfwm4/button-active-Normal.xpm"                                      "${THEME_DIR}/xfwm4/button-active.xpm"
    mv -f "${THEME_DIR}-hdpi/xfwm4/button-active-Normal.xpm"                                 "${THEME_DIR}-hdpi/xfwm4/button-active.xpm"
    mv -f "${THEME_DIR}-xhdpi/xfwm4/button-active-Normal.xpm"                                "${THEME_DIR}-xhdpi/xfwm4/button-active.xpm"
    mv -f "${THEME_DIR}/xfwm4/button-inactive-Normal.xpm"                                    "${THEME_DIR}/xfwm4/button-inactive.xpm"
    mv -f "${THEME_DIR}-hdpi/xfwm4/button-inactive-Normal.xpm"                               "${THEME_DIR}-hdpi/xfwm4/button-inactive.xpm"
    mv -f "${THEME_DIR}-xhdpi/xfwm4/button-inactive-Normal.xpm"                              "${THEME_DIR}-xhdpi/xfwm4/button-inactive.xpm"
  fi

  button_close="#fd5f51"
  button_max="#38c76a"
  button_min="#fdbe04"

  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}/xfwm4/close-active.svg"
  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}/xfwm4/close-prelight.svg"
  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}/xfwm4/close-pressed.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}/xfwm4/maximize-active.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}/xfwm4/maximize-prelight.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}/xfwm4/maximize-pressed.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}/xfwm4/maximize-toggled-active.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}/xfwm4/maximize-toggled-prelight.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}/xfwm4/maximize-toggled-pressed.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}/xfwm4/hide-active.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}/xfwm4/hide-prelight.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}/xfwm4/hide-pressed.svg"

  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}-hdpi/xfwm4/close-active.svg"
  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}-hdpi/xfwm4/close-prelight.svg"
  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}-hdpi/xfwm4/close-pressed.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-hdpi/xfwm4/maximize-active.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-hdpi/xfwm4/maximize-prelight.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-hdpi/xfwm4/maximize-pressed.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-hdpi/xfwm4/maximize-toggled-active.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-hdpi/xfwm4/maximize-toggled-prelight.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-hdpi/xfwm4/maximize-toggled-pressed.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}-hdpi/xfwm4/hide-active.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}-hdpi/xfwm4/hide-prelight.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}-hdpi/xfwm4/hide-pressed.svg"

  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}-xhdpi/xfwm4/close-active.svg"
  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}-xhdpi/xfwm4/close-prelight.svg"
  sed -i "s/#fd5f51/${button_close}/g"                                          "${THEME_DIR}-xhdpi/xfwm4/close-pressed.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/maximize-active.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/maximize-prelight.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/maximize-pressed.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/maximize-toggled-active.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/maximize-toggled-prelight.svg"
  sed -i "s/#38c76a/${button_max}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/maximize-toggled-pressed.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/hide-active.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/hide-prelight.svg"
  sed -i "s/#fdbe04/${button_min}/g"                                            "${THEME_DIR}-xhdpi/xfwm4/hide-pressed.svg"
}
