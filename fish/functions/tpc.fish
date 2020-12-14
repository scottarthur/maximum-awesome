function tpc -d "Toggles fish command prompt color theme"
  if ! contains solarized-dark $theme_color_scheme
    set -x theme_color_scheme solarized-dark || true
  else
    set -x theme_color_scheme solarized-light || true
  end
end
