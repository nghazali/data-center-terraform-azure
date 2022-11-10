# First parameter is an optional phrase to generate ssh key
# This script generates a ssh key here: ~/.ssh/aks-sshkeys-terraform/aks-ssh-key
# This could be used to pass to aks module to create k8s cluster (value for `ssh_public_key` variable)

if [ $# == 0 ]; then
  MY_PHRASE="aks-key"
else
  MY_PHRASE=$1
fi

# Create Folder
mkdir $HOME/.ssh/aks-sshkeys-terraform

# Create SSH Key
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@myserver" \
    -f ~/.ssh/aks-sshkeys-terraform/aks-ssh-key \
    -N $1

# List Files
ls -lrt $HOME/.ssh/aks-sshkeys-terraform