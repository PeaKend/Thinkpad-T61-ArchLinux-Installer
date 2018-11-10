clear

while true; do
	printf "Choose your DE/WM\n\n"

	printf "[0] No DE/WM\n"
	printf "[1] i3\n"
	printf "[2] KDE Plasma\n"
	printf "[3] KDE Plasma (without kde-applications)\n"
	printf "[4] KDE Plasma Minimal\n"
	printf "[5] Gnome\n"
	printf "[6] Gnome (without gnome-extra)\n\n"

    printf "Your choice: "
	read deChoice

	if [ "${deChoice}" -ge "0" ] && [ "${deChoice}" -le "6" ]; then
		echo "${deChoice}" > ../../deChoice
		break
	fi

	clear
	printf "ERROR: choose a number in the list below\n\n"

done

