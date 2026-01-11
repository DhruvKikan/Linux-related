#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
ghostty_vim() {
	# Default to "New Buffer" if no file is provided
	local file_name="${1:-New Buffer}"

	# Launch Ghostty:
	# --title sets the window decoration
	# -e runs the command
	# & runs it in the background
	# 2>/dev/null hides startup warnings
	(ghostty --title="neovim - $file_name" -e nvim "$@" 2>/dev/null &

	# disown removes the job from the current shell's job table
	# This prevents the "There are stopped jobs" warning on exit
	disown)
}

cleanSystem() {
	echo "--- Starting System Cleanup ---"

	# 1. Flatpak: Remove unused runtimes and extensions
	echo "Removing unused Flatpaks..."
	flatpak uninstall --unused -y

	# 2. Yay/Pacman: Remove orphan packages (unneeded dependencies)
	# This also handles circularly-dependent orphans
	if [[ -n $(pacman -Qdtq) ]]; then
		echo "Removing orphan packages..."
		yay -Rns $(pacman -Qdtq)
	else
		echo "No orphans to remove."
	fi

	# 3. Yay: Clean the package cache
	# -Scc removes all cached packages not currently installed
	echo "Cleaning package cache..."
	yay -Scc --noconfirm

	# 4. View Installed Packages (Optional: log to a file)
	# This lists explicitly installed apps, services, and DE components
	echo "Saving list of installed packages to ~/installed_packages.txt..."
	pacman -Qet > ~/installed_packages.txt

	# 5. Disk Usage Analysis (Interactive - must be last)
	echo "Launching ncdu for manual cleanup..."
	ncdu / --exclude /media --exclude /run/timeshift
	
	# 6. Cleaning logs older than 2 weeks
	sudo journalctl --vacuum-time=2weeks
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='ghostty_vim'
PS1='[\u@\h \W]\$ '
