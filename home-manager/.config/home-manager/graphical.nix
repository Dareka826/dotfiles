# vim: shiftwidth=2
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nsxiv
    qimgv

    wob
    xob

    mangohud
    goverlay
  ];
}
