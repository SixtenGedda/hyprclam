KBD_BACKLIGHT="/sys/class/leds/asus::kbd_backlight/brightness"

saved_brightness = $(cat $KBD_BACKLIGHT)


suspend() {
  systemctl suspend

}

disable_kb_backlight () {
 echo 0 | sudo tee $KBD_BACKLIGHT > /dev/null

}

enable_kb_backlight () {
  
}

enable_internal_display() {
    hyprctl keyword monitor "eDP-1,preferred,auto,1"

}

# EVENT LISTENERS

handle_lid_close_external() {
  disable_kb_backlight()
}

handle_lid_close () {
  suspend()
}

handle_lid_open() {
  enable_internal_display()
  
}

listen_acpi_events() {
  
}
