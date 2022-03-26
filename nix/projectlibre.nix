#!/usr/bin/env nix-shell
#!nix-shell --pure projectlibre.nix

{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = [ pkgs.jre ];
    shellHook = ''
      java -jar ./projectlibre-1.9.3.jar
    '';
}