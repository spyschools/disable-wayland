# Remove Wayland completely from Kali Linux XFCE (so that the system only runs with X11/Xorg), the method is to remove all Wayland + XWayland + Weston packages, and remove the Wayland .desktop session.

$ git clone https://github.com/spyschools/remove-wayland.git 

$ cd remove-wayland

$ chmod +x disable-wayland.sh


$ sudo ./disable-wayland.sh


*VERIFICATION
$ echo $XDG_SESSION_TYPE
