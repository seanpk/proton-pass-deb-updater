# proton-pass-deb-updater

_All the kicks of keeping the Proton Pass app for Linux up-to-date without all the clicks._

The `update-proton-pass.sh` script automates and simplifies the process of installing and updating the Proton Pass app for Debian and Ubuntu (and derivatives). It is a simple bash script that checks for the latest version of the Proton Pass `.deb` package, downloads it, and installs or updates it on your system - assuming you don't already have the latest version installed.

This script is motivated out of the dread and frustration caused whenever the Proton Pass app starts nagging for an update. Now when it nags, just run this script and restart it. As you can imagine, this is NOT an officially supported script from Proton AG.

---
### Example Output

## First Install:

```bash
$ update-proton-pass.sh
Proton Pass Installer/Updater
Fetching latest version information...
Latest version: 1.33.4
Download URL: https://proton.me/download/pass/linux/proton-pass_1.33.4_amd64.deb
Fresh install.
Downloading proton-pass_1.33.4_amd64.deb...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 96.4M  100 96.4M    0     0  16.4M      0  0:00:05  0:00:05 --:--:-- 19.5M
Verifying SHA512...
Checksum OK ✓
Installing...
Selecting previously unselected package proton-pass.
(Reading database ... 211058 files and directories currently installed.)
Preparing to unpack proton-pass_1.33.4_amd64.deb ...
Unpacking proton-pass (1.33.4) ...
Setting up proton-pass (1.33.4) ...
Processing triggers for desktop-file-utils (0.27-2build1) ...
Processing triggers for gnome-menus (3.36.0-1.1ubuntu3) ...
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Success! Proton Pass 1.33.4 is installed.
Launch from menu or run 'proton-pass'
File saved: /home/seanpk/Downloads/proton-pass_1.33.4_amd64.deb
$
```

### Update when already latest:

```bash
$ update-proton-pass.sh
Proton Pass Installer/Updater
Fetching latest version information...
Latest version: 1.33.4
Download URL: https://proton.me/download/pass/linux/proton-pass_1.33.4_amd64.deb
Installed: 1.33.4
Already up to date — skipping download and reinstall.
$
```

## Getting Started

**WARNING**: Following these instructions will execute code from the internet on your computer. You _might_ want to take a look at [the script before](update-proton-pass.sh) running it.

### Option 1: Get it and run it now

```bash
curl -sSL https://raw.githubusercontent.com/seanpk/proton-pass-deb-updater/refs/heads/main/update-proton-pass.sh | bash
```

### Option 2: Get it now and run it whenever

```bash
curl -sSL https://raw.githubusercontent.com/seanpk/proton-pass-deb-updater/refs/heads/main/update-proton-pass.sh > update-proton-pass.sh
chmod +x update-proton-pass.sh

# anytime you want you can run:
# ./update-proton-pass.sh
```

### Option 3: Clone this repo and run it from within it

```bash
git clone https://github.com/seanpk/proton-pass-deb-updater.git
cd proton-pass-deb-updater
./update-proton-pass.sh
```

Which saves you have having to change permissions - whoo-hoo! -, means you can get any future updates with a `git pull`, and you can run it from the cloned directory whenever you want.
