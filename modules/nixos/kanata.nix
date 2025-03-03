{ internalKeyboardDevice, tapTime, holdTime }:
{
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [ internalKeyboardDevice ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps a s d f j k l ;
          )
          (defvar
           tap-time ${toString tapTime}
           hold-time ${toString holdTime}
          )
          (defalias
           caps (tap-hold 100 100 esc esc)
           a (tap-hold $tap-time $hold-time a lmet)
           s (tap-hold $tap-time $hold-time s lalt)
           d (tap-hold $tap-time $hold-time d lctl)
           f (tap-hold $tap-time $hold-time f lsft)
           j (tap-hold $tap-time $hold-time j rsft)
           k (tap-hold $tap-time $hold-time k rctl)
           l (tap-hold $tap-time $hold-time l ralt)
           ; (tap-hold $tap-time $hold-time ; rmet)
          )
          (deflayer base
           @caps @a  @s  @d  @f  @j  @k  @l  @;
          )
        '';
      };
    };
  };
}
