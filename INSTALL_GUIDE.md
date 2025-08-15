# Install guide macbook m-series (m1 & m2)

## Dual boot Asahi-alarm


### installation 

Follow the instructions on how to dual boot your macbook with asahi-alarm here

https://asahi-alarm.org/

**Choose the minimal installation!**

This will create a new partition on your machine and install arch on it!

### get internet
Follow these instructions once the installation is complete [manual installation guide](https://github.com/asahi-alarm/asahi-alarm/blob/main/manual-install.md)

This lets you set up wifi for your laptop.

### Create a user

Now we are logged in as root, lets create a user 
  
  ```

# Install sudo package
pacman -S sudo

# Create a new user with home directory
useradd -m youruser    # Replace 'youruser' with your desired username

# Set password for the new user
passwd youruser

# Add user to the wheel group (for sudo access)
usermod -aG wheel youruser
```

run `visudo` and look for the line and uncomment it


```
# %wheel ALL=(ALL:ALL) ALL
```


## Install omarchy 

first we need to install the package wget 

```
pacman -S wget
```

to install omarchy we need to run as the user we just created before, run the command

```
su - youruser
```


now lets install omarchy, run the command


```
wget -qO- https://githubusercontent.com/nilszeion/armarchy/refs/heads/master/boot.sh | OMARCHY_ARM=true bash
```

if nothing happens, check that you typed in the correct url before piping to bash with

```
wget -qO- https://githubusercontent.com/nilszeion/armarchy/refs/heads/master/boot.sh
```

This step will take some time.

If you run into problems where the AUR is slow, try to enable mirror repositories by editing  `sudo vim /etc/pacman.d/mirrorlist` and uncomment a couple of lines starting with `# Server = ...`.

**If the installation crashes** just run the suggested command but with the `OMARCHY_ARM` flag set like this `OMARCHY_ARM=true bash ~/.local/share/omarchy/install.sh` until it finishes.


# Uninstall

Uninstall is super easy, big recommend to this guy

https://youtu.be/nMnWTq2H-N0?si=7RsKKRSC5n9-aboF
