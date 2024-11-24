# 🌟Inception

## Overview

The **Inception** project showcases a secure, scalable, and modular multi-service architecture, leveraging Docker containerization. Designed to meet the rigorous requirements of the 42 curriculum, the project involves creating a robust infrastructure consisting of multiple interconnected services. Each service runs in a dedicated Docker container with its own configuration, all orchestrated through Docker Compose.

The infrastructure is designed for optimal performance, security, and maintainability, incorporating advanced practices like TLS enforcement, environment-based configuration, and data persistence.


## 🚀Features and Highlights

### Core Infrastructure

1. 📂**MariaDB (Database Layer):**  
   - A relational database service that securely stores WordPress data.  
   - Persistent storage with `db-volume` ensures data integrity across restarts.  
   - Configured with secure credentials managed via environment variables and Docker secrets.  
   - A healthcheck ensures readiness before dependent services start.

2. 🌐**WordPress (Application Layer):**  
   - A dynamic website powered by WordPress and PHP-FPM, seamlessly integrated with MariaDB.  
   - Persistent storage with `wp-volume` for WordPress files.  
   - Environment variables simplify site configuration, including admin and user setup.  
   - Automatically waits for MariaDB to be healthy before initialization.

3. 🔒**NGINX (Gateway):**  
   - Acts as the secure entry point to the infrastructure, enforcing HTTPS with TLSv1.2/TLSv1.3.  
   - Reverse proxy setup for efficient routing to the WordPress container.  
   - Shares `wp-volume` to serve static WordPress files directly.  
   - Automatically restarts on failure, ensuring high availability.

### Bonus Enhancements

1. ⚡**Redis (Performance Optimization):**  
   - Integrated as a caching layer to improve WordPress performance by reducing database load.  
   - Custom Docker image configured to work seamlessly with WordPress.

### 🔐Networking and Security

- 🌉**Custom Network:** A dedicated Docker bridge network (`inception`) securely connects all services, isolating them from external access except through NGINX.  
- 🛡️**TLS Encryption:** NGINX enforces secure connections over port 443.  
- ⚙️**Environment Configuration:** Uses `.env` files for modularity and Docker secrets for sensitive data management.  

### ⚙️Automation and Reliability

- 🤖**Deployment Automation:** A `Makefile` streamlines build, deployment, and cleanup processes.  
- 🔄**Service Resilience:** All containers have `restart` policies to recover automatically in case of failures.  
- ✅**Healthchecks:** Ensures dependent services wait until prerequisites are ready, improving stability.  


## 📋Technical Requirements

The Inception project necessitates an understanding of key concepts and techniques to build a functional and secure multi-service infrastructure, including::  
- 🐳**Containerization:** Building and orchestrating custom Docker images and services.  
- 🔧**System Administration:** Deploying and managing a secure multi-service architecture.  
- 🌐**Networking:** Designing isolated and secure container networks.  
- 🛡️**Security Practices:** Enforcing TLS encryption, securely managing sensitive data with environment variables and Docker secrets, and maintaining robust configurations.  
- ⚙️**Automation:** Efficiently managing complex setups using Docker Compose and Makefiles.  


### 🛠️Prerequisites
- 🖥️Virtual machine or Docker-compatible environment.
- 🐳Docker and Docker Compose installed.

