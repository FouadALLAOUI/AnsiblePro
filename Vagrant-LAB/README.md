# Ansible Infrastructure Automation

This repository contains Ansible playbooks and inventory files for automating the deployment and configuration of web servers and database servers.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Inventory Configuration](#inventory-configuration)
- [Running the Playbook](#running-the-playbook)
- [Playbook Overview](#playbook-overview)
- [Security Best Practices](#security-best-practices)
- [Troubleshooting](#troubleshooting)

## 🔧 Prerequisites

Before running this playbook, ensure you have:

1. **Ansible installed** (version 2.9 or higher)
   ```bash
   # On Ubuntu/Debian
   sudo apt update
   sudo apt install ansible

   # On macOS
   brew install ansible

   # On RHEL/CentOS
   sudo yum install ansible
   ```

2. **Python 3** installed on the control node and target hosts

3. **SSH access** configured to all target hosts
   ```bash
   # Generate SSH key pair if you don't have one
   ssh-keygen -t rsa -b 4096

   # Copy SSH key to target hosts (optional, if using password auth)
   ssh-copy-id user@target-host
   ```

4. **Sudo/root privileges** on target hosts

5. **Network connectivity** to all target hosts

## 📁 Project Structure

```
.
├── inventory.yaml      # Ansible inventory file defining hosts and groups
├── playbook.yaml       # Main playbook for server deployment
└── README.md          # This file
```

## 🔐 Inventory Configuration

The `inventory.yaml` file defines the following groups:

- **webservers**: Apache web servers (web1, web2)
- **databases**: MySQL database servers (db1, db2, db3)
- **application_servers**: Application servers (server1, server2, server3)
- **all**: All hosts including localhost

### Updating Inventory

Edit `inventory.yaml` to match your infrastructure:

1. Update IP addresses (`ansible_host`)
2. Update usernames (`ansible_user`)
3. Configure SSH keys or passwords
4. Adjust ports if needed

**Security Note**: For production environments, use `ansible-vault` to encrypt sensitive data:

```bash
# Create encrypted vault file
ansible-vault create group_vars/all/vault.yaml

# Edit vault file
ansible-vault edit group_vars/all/vault.yaml
```

## 🚀 Running the Playbook

### Basic Execution

Run the complete playbook against all hosts:

```bash
ansible-playbook -i inventory.yaml playbook.yaml
```

### Run with Specific Options

**Check connectivity first (dry-run):**
```bash
ansible-playbook -i inventory.yaml playbook.yaml --check
```

**Run with verbose output:**
```bash
ansible-playbook -i inventory.yaml playbook.yaml -v
# or for more verbosity
ansible-playbook -i inventory.yaml playbook.yaml -vvv
```

**Run against specific host group:**
```bash
# Only webservers
ansible-playbook -i inventory.yaml playbook.yaml --limit webservers

# Only databases
ansible-playbook -i inventory.yaml playbook.yaml --limit databases
```

**Run against specific host:**
```bash
ansible-playbook -i inventory.yaml playbook.yaml --limit web1
```

**Run with password prompt:**
```bash
ansible-playbook -i inventory.yaml playbook.yaml --ask-pass
```

**Run with sudo password:**
```bash
ansible-playbook -i inventory.yaml playbook.yaml --ask-become-pass
```

**Run with both passwords:**
```bash
ansible-playbook -i inventory.yaml playbook.yaml --ask-pass --ask-become-pass
```

### Step-by-Step Execution Process

1. **Test Connectivity**
   ```bash
   ansible all -i inventory.yaml -m ping
   ```

2. **Verify Inventory**
   ```bash
   ansible-inventory -i inventory.yaml --list
   ```

3. **Run Playbook**
   ```bash
   ansible-playbook -i inventory.yaml playbook.yaml
   ```

## 📖 Playbook Overview

The playbook consists of four main plays:

### 1. Verify Connectivity
- Tests connection to all hosts
- Displays connectivity status
- Runs on: `all` hosts

### 2. Install and Configure Apache
- Updates package cache
- Installs Apache web server
- Starts and enables Apache service
- Creates default HTML page
- Verifies Apache is accessible
- Runs on: `webservers` group

### 3. Install and Configure MySQL
- Updates package cache
- Installs MySQL database server
- Starts and enables MySQL service
- Verifies MySQL status
- Runs on: `databases` group

### 4. Final Status Report
- Generates deployment summary
- Runs on: `all` hosts

## 🔒 Security Best Practices

1. **Use SSH Keys Instead of Passwords**
   - Generate SSH key pairs
   - Copy public keys to target hosts
   - Remove password authentication from inventory

2. **Use Ansible Vault for Sensitive Data**
   ```bash
   # Encrypt sensitive variables
   ansible-vault encrypt_string 'your-password' --name 'ansible_password'
   ```

3. **Limit SSH Access**
   - Use firewall rules
   - Restrict SSH to specific IPs
   - Use non-standard SSH ports

4. **Use Least Privilege**
   - Create dedicated Ansible user
   - Grant only necessary sudo permissions
   - Avoid using root user when possible

5. **Keep Ansible Updated**
   ```bash
   pip install --upgrade ansible
   ```

## 🐛 Troubleshooting

### Common Issues

**Issue: "Host key verification failed"**
```bash
# Solution: Add host to known_hosts or disable strict checking
export ANSIBLE_HOST_KEY_CHECKING=False
```

**Issue: "Permission denied"**
```bash
# Solution: Ensure SSH keys are properly configured
ssh-copy-id user@target-host
```

**Issue: "Module not found"**
```bash
# Solution: Install required Python packages on target hosts
ansible all -i inventory.yaml -m raw -a "pip3 install <package>"
```

**Issue: "Connection timeout"**
- Check network connectivity
- Verify firewall rules
- Confirm SSH service is running on target hosts

**Issue: "Package installation fails"**
- Ensure target hosts have internet access
- Check apt/yum repositories are configured
- Verify sufficient disk space

### Debug Commands

```bash
# Test connectivity
ansible all -i inventory.yaml -m ping

# Check facts
ansible all -i inventory.yaml -m setup

# Test specific task
ansible-playbook -i inventory.yaml playbook.yaml --tags <tag-name>

# Run with check mode
ansible-playbook -i inventory.yaml playbook.yaml --check --diff
```

## 📝 Additional Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Ansible Vault Guide](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

## 📄 License

This project is provided as-is for educational and automation purposes.

---

**Last Updated**: 2024
**Ansible Version**: 2.9+

