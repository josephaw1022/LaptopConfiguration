# Laptop Configuration

This repository contains configuration files and scripts for managing and setting up the software environment on my laptop. I recently migrated from Windows 11 Pro to Fedora 41 due to concerns about privacy and advertisements on Windows.

## Folder Structure

- **windows-11**  
  Contains the `winget-config.json` file, which includes all the Winget packages I installed on my Windows 11 laptop. This file serves as a backup so that I can quickly reinstall all my software if I ever need to set up a new Windows 11 environment.

- **fedora-41**  
  Contains a series of shell scripts for configuring my Fedora 41 system:
  - **dnf-packages.sh**: Installs essential DNF packages.
  - **flatpaks.sh**: Installs Flatpak packages.
  - **kubernetes-tooling.sh**: Installs Kubernetes-related tools.
  - **miscellaneous.sh**: Installs other necessary tools and configures miscellaneous settings.

## Fedora 41 Setup Instructions

To set up your Fedora 41 system, simply run the `setup.sh` script in the root directory. This will automatically run the necessary scripts in the correct order.

```bash
chmod +x setup.sh && sudo ./setup.sh
```

This will ensure that all required packages and configurations are applied.

## Windows 11 Setup Instructions

If I ever need to reinstall Windows 11, I can simply refer to the `windows-11/winget-config.json` file to restore all your previously installed Winget packages.