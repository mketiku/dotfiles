```shell
 $ sudo service network-manager restart
 $ sudo systemctl restart network-manager.service
 $ rfkill block bluetooth
 $ sudo chmod 744 /usr/lib/gvfs/gvfsd-smb-browse
 $ nmtui
 $ code . && cd Projects/{}/ && workon {} && pymgrn 0.0.0.0:8000
 $ ssh -Y hostname ( will allow remote control)
```
1. Restarts the wifi whenever it crashes
2. Alternative to (1)
3. Blocks bluetooth because I do not use/need it.
4. Prevents samba process from running automatically at login, this fixes overheating issue.
tail -f /var/log/secure      
hold alt + f2 then type r
> Restarts the gnome shell

```shell
#!/bin/sh

case "${1}" in
  resume|thaw)
    nmcli r wifi off && nmcli r wifi on;
esac
```
> Put this in /etc/pm/sleep.d/10_resume_wifi with permissions 755 and it should help with wifi after restart. (ubuntu)

```shell
history | awk '{a[$2]++}END{for(i in a){print a[i] ""i}}'|sort -rn | head
```
> list most common commands


```shell
sudo apt-get upgrade -y && sudo apt-get update -y  && sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk && sudo apt-get install python-pip -y && sudo apt-get install -y dconf-tools powertop htop compizconfig-settings-manager vlc zsync ncdu  wget ruby rsync rake gcc git python-pip -y && sudo apt-get -yV install ubuntu-restricted-addons ubuntu-restricted-extras && pip install thefuck
 ```

https://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers 
You can use Ctrl-L to display the location input area or use Alt-Up to navigate up directly

xdg-open {k[key]: k for k in t} 

#### Network

 ifconfig
 then look at which adapter you want to turn off, in my case wlan1 is my internal wifi and wlan2 is my usb wifi. Then run

 ```shell
  $ sudo ifconfig wlan1 down
 ```
 and it will turn of (type ifconfig to check, note that in the network manager the adapter still shows, but it is turned of). To turn it on again:
```shell
 $ sudo ifconfig wlan1 up
```
```shell
 $ sudo lshw -C network
```

 #### Vim
 [vim]: http://www.vim.org/about.php

 When you learned how to touch type, the first lesson was probably about the
 "home row" keys. Your left fingers rest on `a`, `s`, `d`, `f` and your right
 fingers rest on `j`, `k`, `l`, `:/;`.

 > If you have not learned how to touch type, run the `gtypist` typing tutor
 > program and go through the lessons in your free time.

 With the text editor [vim][],  there is an "insert mode" (where the keys you type
 become characters in your file) and a "command mode" (where the keys you type
 are commands).

 Vim takes advantage of the fact that your fingers rest on the home row by
 letting you use the `h`, `j`, `k`, `l` keys for moving around in a file (when in
 command mode).

 - `h` move cursor left
 - `j` move cursor down
 - `k` move cursor up
 - `l` move cursor right

 This is a very efficient way to move around. Many people that use vim regularly
 will set "vim key bindings" in other programs (whenever it is an option),
 including the shell prompt of the terminal.

 > Often, you will need to modify your previous command. Luckily, the command
 > history is saved and can be navigated/edited with our vim bindings. When you
 > press the `Esc` key (top-left area of keyboard), you switch to the vim command
 > mode.


 xdg-open {k[key]: k for k in t}
 
 recently upgraded my desktop machind from ubuntu 16.04 to ubuntu 16.10 and after reboot some of the websites are not working.

 #### Solution 1

Disable dnsmasq

Edit /etc/NetworkManager/NetworkManager.conf with the following command

```gksu gedit /etc/NetworkManager/NetworkManager.conf```

Enter in your password when prompted.

Comment out the line dns=dnsmasq

```#dns=dnsmasq```

and then restart Network Manager using the following command

```sudo restart network-manager```

If you get /com/ubuntu/upstart: Connection refused error try the following command

```sudo service network-manager restart```

 #### Solution 2

Restart dnsmasq service using the following command

```sudo service dnsmasq restart```

 #### Solution 3

Edit /etc/nsswitch.conf file

```gksu gedit /etc/nsswitch.conf```

and change the following line

From

```hosts: files resolve [!UNAVAIL=return] mdns4_minimal [NOTFOUND=return] dns```

to

```hosts: files mdns4_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns```

Save and exit the file
http://mark.orbum.net/2012/05/14/disabling-dnsmasq-as-your-local-dns-server-in-ubuntu/


# SSH Instructions
### Prerequisites
- Terminal 
- Keyboard
- Patience
---
Set ssh folder and authorized_keys permissions
```sh
$ chmod 700 ~/.ssh
$ cd ~/.ssh
$ touch ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/authorized_keys
```
---
Generate your ssh key and name it
```sh
$ ssh-keygen -t rsa -C "your_email@your_email.com"
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/your_username/.ssh/id_rsa): 
                                For example:
                                - id_rsa (default)
                                - id_rsa_git
                                - personal_key
                                - server_id_key
```


Add to your ssh registry
```sh
$ ssh-add ~/.ssh/id_rsa_git
```
Read the contents of the public key to your terminal and copy it to your clipboard
```sh
$ cat ~/.ssh/id_rsa_git.pub 
```
Verify that your ssh key is saved
```sh 
$ ssh-add -l
```
Verify that you can login
```sh
$ ssh -v server_or_client_name
```
Create a ssh config file
```sh
$ touch ~/.ssh/config
$ nano ~/.ssh/config
```
```ssh
# Make your config look like this, depending on your needs (personal, project or git)

# Personal Github
Host github
  Hostname github.com
  User mketiku
  IdentityFile ~/.ssh/id_rsa_git.pub

# Personal Gitlab 
Host gitlab
  Hostname gitlab.com
  User mketiku
  IdentityFile ~/.ssh/id_rsa_git.pub

# Internal IGA GitLab
Host igagit01
  RSAAuthentication yes
  IdentityFile ~/.ssh/id_rsa_git.pub
  User michael.ketiku
    
Host *
  IdentitiesOnly yes
```
  
### Tunnel Examples
    -ssh -R 9999992929292929290:localhost:22 me@middleman_server.random
    -ssh me@middleman_server.random
    -ssh me@localhost -p 929292929290122923209
    

### Fix Authentication Errors
    - ssh -o PubkeyAuthentication=no username@hostname.com  (forces non-key authentication)
  
 ##### DONE 
 Contact [Michael Ketiku](mketiku@gmail.com), if you have any questions.
 
