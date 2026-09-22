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
The project consists of 3 Rocky Linux 9.8 VMs connected through an internal network while one of them functions as a Gateway Serversupporting
NAT and forwarding

## Architecture

```mermaid
graph TD
    Internet[Internet] -->|NAT| VM1[VM1 - Gateway<br>192.168.50.1]

    VM1 -->|Internal Network| VM2[VM2 - DNS<br>192.168.50.20<br>dnsmasq]
    VM1 -->|Internal Network| VM3[VM3 - Web<br>192.168.50.30<br>NGINX]

    VM2 -->|DNS Resolution| VM3
    VM1 -->|DNAT :8080 → :80| VM3

