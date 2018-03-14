# mingw-w64-libmongoc #

Run this command to update the checksum for the PKGBUILD file:

```bash
updpkgsums
```

To check the upstream for latest released version, do this:

```bash
source gitver.sh
get_latest_release mongodb/mongo-c-driver
```

To build the package:

```bash
MINGW_INSTALLS=mingw32 makepkg-mingw -sCLf
```