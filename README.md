# proton-pass-deb-updater

_All the kicks of keeping the [Proton Pass](https://proton.me/pass/download/linux) app for Linux up-to-date [without all the clicks](https://proton.me/support/set-up-proton-pass-linux)._

The `update-proton-pass.sh` script automates and simplifies the process of installing and updating the Proton Pass app for Debian and Ubuntu (and derivatives). It is a simple bash script that checks for the latest version of the Proton Pass `.deb` package, downloads it, and installs or updates it on your system - assuming you don't already have the latest version installed.

This script is motivated out of the dread and frustration caused whenever the Proton Pass app starts nagging for an update. Now when it nags, just run this script and restart it. As you can imagine, this is NOT an officially supported script from Proton AG.

---
### Example Output

## First Install:

<img width="966" height="552" alt="image" src="https://github.com/user-attachments/assets/911d330b-5cab-4d36-acce-79c60933d853" />

### Update when already latest:

<img width="803" height="149" alt="image" src="https://github.com/user-attachments/assets/4a5ed55c-2bf5-4c90-b374-b096c288c4b1" />

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
