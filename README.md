# Homelab WireGuard VPN (Proxmox · Terraform · Ansible)

This repository contains a fully automated WireGuard VPN setup for a Proxmox-based homelab, built using Infrastructure as Code principles.

The design provisions a dedicated WireGuard VM using Terraform, then configures and manages the VPN server and clients using Ansible. Client configurations and QR codes are generated automatically, while all sensitive material (keys, configs, state) is intentionally excluded from version control.

## Key goals

* Reproducible VPN infrastructure

* Secure remote access to Proxmox and LAN resources

* No public exposure of Proxmox or SSH

* Idempotent configuration with safe re-runs

* Clear separation between infrastructure (Terraform) and configuration (Ansible)

## High-level architecture

* WireGuard runs in a dedicated VM (not an LXC)

* A single UDP port is exposed on the router

* LAN access is routed through the VPN using NAT on the WireGuard VM

* Clients (desktop and mobile) connect using WireGuard with persistent keepalive

* Dynamic DNS is supported to handle changing public IPs

## Repository notes

* Secrets, client configs, QR codes, and Terraform state are excluded via .gitignore

* This repository contains automation only, not live credentials

* Intended for homelab and educational use, but follows production-grade patterns
