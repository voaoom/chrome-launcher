#!/bin/bash

# Defaults
browser='google-chrome-stable'
user="$USER"

while [[ $# > 0 ]]; do
	arg="$1"
	shift
	[ "$arg" == '@' ] && break
	echo "Evaluating: [ $arg ]"
	eval "$arg"
done

custom_args=''
while [[ $# > 0 ]]; do
	custom_args="$custom_args $(printf "%q" "$1")"
	#custom_args="$custom_args '$1'"
	shift
done
echo "Custom args: [ $custom_args ]"

data_dir=$(dirname "$0")

# Start browser
cd "$data_dir"
eval nice -n 5 ionice -c 3 -t "$browser" \
\
		`#: process mode settings :#` \
	--no-default-browser-check \
	--no-first-run \
	--fast-start \
	--enable-fast-unload \
	`#--site-per-process` `: !!! causes crashes !!! :` \
\
		`#: networking settings :#` \
	--enable-tcp-fastopen \
	--enable-ipv6 \
	--disable-background-networking \
	--disable-breakpad \
	--disable-preconnect \
\
		`#: graphics & render settings :#` \
	--fast \
	--ignore-gpu-blacklist \
	--enable-webgl \
	--enable-webgl-draft-extensions \
	--enable-webgl-image-chromium \
	--enable-smooth-scrolling \
	--enable-accelerated-2d-canvas \
	--disable-low-res-tiling \
	--tab-capture-downscale-quality=fast \
	--tab-capture-upscale-quality=fast \
\
		`#: features & UI settings :#` \
	--lang=ru \
	--extensions-multi-account \
	--ignore-autocomplete-off-autofill \
	--safebrowsing-disable-download-protection \
	--safebrowsing-disable-extension-blacklist \
	--enable-spatial-navigation \
	--enable-single-click-autofill \
	--enable-pdf-material-ui \
	--enable-multilingual-spellchecker \
	--enable-accessibility-tab-switcher \
	--enable-download-resumption \
	--enable-download-notification=enabled \
	--password-store=default \
	--enable-experimental-input-view-features \
	--start-maximized \
\
		`#: user profile settings :#` \
	--user-data-dir="$data_dir" \
	--parent-profile="Default" \
	--profile-directory="$user" \
\
	$custom_args & exit 0
