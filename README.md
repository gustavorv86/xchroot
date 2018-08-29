xchroot
=======

Extended chroot with X11/Xorg forwarding

Prepare
-------

Clone this repository.

`git clone https://github.com/gustavorv86/xchroot`

Optional
--------

Copy the executables to __bin__ folder.

`cp my_binary_file xchroot/bin`

Check the dynamic library dependencies.

`ldd xchroot/bin/my_binary_file`

Copy the dynamic library dependecies to __lib__ folder.

`cp dynamic_library_dependency.so xchroot/lib`

Run
---

Go to `xchroot` folder and execute the __xchroot__ script.

```
cd xchroot
sudo ./xchroot
```

Execute any X11/Xorg program, for example:

`xterm`
