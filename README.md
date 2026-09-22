# LINUX INFRASTRUCTURE AND AUTOMATION CAPSTONE

A Hands on Infrastructure Project combining Linux, Ansible, Jenkins and Terraform to bring Linux Administration , Networking , Automation
CI (Continuous Integration) and IaC ( Infrastructure as Code) into a single environment.

The project  consists of 3 Rocky Linux Virtual Machines hosted in Virtual Box with dedicated Infrastructue roles and an Internal Network.
The environment was first built and validated maunually . It was later automated step by step using Ansible, Jenkins and Terraform 

## PROJECT OVERVIEW

The goal of this project is to build a small but realistic Linux Environment , manually configure the configurations and networking and progressively automate the administration
This project covers:
+ Linux System Administration
+ TCP/IP Networking and Routing
+ Firewall  Rules and Policies
+ Internal DNS using dnsmasq
+ NGINX Web Services
+ Hardening
+ Ansible
+ CI using Jenkins
+ IaC using Terraform
+ Version Control using Git/Github

## ARCHITECTURE
The project consists of 3 Rocky Linux 9.8 VMs(Virtual Machines) connected through an internal network while one of them functions as a Gateway Serversupporting
NAT and forwarding

## Architecture

```mermaid
graph TD
    Internet[Internet] -->|NAT| VM1[VM1 - Gateway]

    VM1 -->|Internal Network| VM2[VM2 - DNS<br>dnsmasq]
    VM1 -->|Internal Network| VM3[VM3 - Web<br>NGINX]

    VM2 -->|DNS Resolution| VM3
    VM1 -->|DNAT :8080 → :80| VM3
```

## VM Roles

VM		Role	   Main Services
VM1	   Gateway	  Routing, NAT, Firewall
VM2	  DNS Server	 dnsmasq
VM3	  Web Server	  NGINX

## Environment

### Virtualization
+ VirtualBox
+ 3 Rocky Linux 9.8 virtual machines
+ Internal network: proj-internal

### Operating System
+ Rocky Linux 9.8 (Blue Onyx)

### Network Design
+ enp0s3 → NAT → Internet access
+ enp0s8 →  Internal network
VM2 and VM3 connect to the internal network through their internal interfaces.

## Implementation

### 1. Linux Administration

This was initially configured manually to build a base for the machine before automating anything. This phase involved the following tasks
+ Hostname configuration
+ User configuration
+ Package management
+ Service management using systemctl
+ Process and Resource management
+ File and Service management
+ SSH Hardening ( Private Key generation)
+ Service hardening
+ Service Troubleshooting
+ Configuration persistence after rebooting machine
This also involved deliberately failing service and bringing them back up to understand them even more.

### 2. Linux Networking
VM1 was configured as the network gateway for the internal environment.

Implemented:

+ Static IP addressing
+ IP forwarding
+ Routing
+ NAT/MASQUERADE
+ DNAT
+ Stateful firewall rules
+ Internal network connectivity
+ Controlled forwarding between interfaces

The gateway uses a default FORWARD policy of DROP, with explicit rules allowing required traffic.

Example traffic flow:

``` mermaid
flowchart TD
A[Internal VM] --> B[VM1 Gateway]
B -->|NAT| C[Internet]
B -->|DNAT| D[VM3 Web Server]
```
### 3. DNS and Web Services

+ DNS
VM2 provides internal DNS using dnsmasq.
DNS configuration was also tested from other nodes to verify that hostname resolution worked correctly across the internal network.

+ Web Server
VM3 runs NGINX and provides the web service for the environment.
The web server was tested both directly from the internal network and through the gateway's DNAT configuration.

### 4. Ansible Configuration Management 

Once the Infrastructure was manually validated, Ansible was used to automate it entirely. It includes

+ Validation of dnsmasq service as it is base of our VM's Internal Network ( Checking of Installation , State of Service)
+ Validation of NGINX service in our Web Server ( Checking of Installation , State of Service)
+ Creation of templates to avoid hard-coding
+ Idempotent Execution (Example: If NGINX is found to be installed , it wont be installed again )

``` mermaid
flowchart TD
A[Ansible Controller] --> B[VM2]
A --> C[VM3]
B --> D[dnsmasq configuration]
C --> E[NGINX configuration]
```
