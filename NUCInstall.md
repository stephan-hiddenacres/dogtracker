Yes, you can install Ubuntu Server on your Intel NUC in a headless setup (without a display). Ubuntu Server is particularly well-suited for headless installations because it doesn’t include a graphical interface by default. Here’s how you can install and configure Ubuntu on your NUC without needing a monitor:

Steps to Install Ubuntu on a NUC Headlessly:
1. Prepare the Ubuntu Installation Media
Download Ubuntu Server (LTS):

Go to the Ubuntu Server download page and download the ISO for the latest LTS version (e.g., Ubuntu 22.04 LTS).
Create a Bootable USB Drive:

Use a tool like Rufus (for Windows) or balenaEtcher (for macOS/Linux) to create a bootable USB from the Ubuntu Server ISO.
Insert the USB into your NUC.
2. Prepare for Headless Installation
Since you don't have a monitor for the NUC, you’ll need to make the system accessible over the network during the installation:

Enable SSH during the installation:
You can pre-configure SSH to be enabled when the NUC boots into the installation environment. For this, you’ll need to create a file on the bootable USB to enable SSH during the installation process.
3. Modify the Installation ISO to Enable Headless Access
Mount the USB drive on your current workstation and find the /boot/grub/grub.cfg file on the USB drive.
Edit the grub configuration to enable remote access by adding "autoinstall" to the boot command:
Open the grub.cfg file in a text editor and find the line starting with linux /casper/vmlinuz.
Add autoinstall and ds=nocloud-net;s=http://{your-preseed-server}/ to the kernel parameters. This allows the system to install without user interaction.
4. Configure Networking
If you have DHCP on your network, the NUC should automatically obtain an IP address when it boots up.
To find the NUC’s IP address, you can check your router's DHCP client list.
5. Perform the Installation Over SSH
After the NUC boots up, you should be able to SSH into the NUC from your main workstation.
Use a terminal on Linux/macOS or PuTTY on Windows and connect to the IP address assigned to the NUC:
bash
Copy code
ssh ubuntu@<NUC_IP_ADDRESS>
If prompted, accept the SSH key and enter the default password for Ubuntu (ubuntu).
You will now have access to the headless NUC to complete the installation.
6. Complete the Installation
Once you’re connected via SSH, follow the prompts to install Ubuntu Server. Since Ubuntu Server doesn’t have a graphical user interface, you can easily complete the installation through the command line.
7. Post-Installation Configuration
Once installed, the NUC will reboot, and you can SSH into it again using the same IP address.
Update the system:
bash
Copy code
sudo apt update && sudo apt upgrade
Install any additional packages, like K3s, Helm, or InfluxDB.
Alternative Option: Use a Pre-configured Image
If the manual installation seems too complex, you could also use a pre-configured image that automatically enables SSH and network access:

Use Ubuntu’s cloud-init to configure the installation to be headless from the beginning.
Write the image to a USB drive, boot the NUC, and SSH into the system without needing to manually intervene during the installation.
Summary
By using a combination of SSH and either modifying the grub configuration or using autoinstall, you can install Ubuntu Server headlessly on your NUC. Once installed, you can manage everything remotely, and no display will be needed.

Let me know if you need further help with any of these steps!
