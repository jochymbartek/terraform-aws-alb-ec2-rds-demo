# Two-Tier AWS Application (Terraform)

This project provisions a production-like two-tier architecture on AWS using Terraform.

## 🏗 Architecture

* **Application Load Balancer (ALB)** – public entry point (HTTP → HTTPS redirect)
* **EC2 instances** – private subnet, running Dockerized Flask app
* **RDS (PostgreSQL)** – private subnet database
* **Route53** – DNS management
* **ACM (AWS Certificate Manager)** – TLS certificate for HTTPS
* **SSM Session Manager** – secure access (no SSH)

### Traffic Flow

User → Route53 → ALB (HTTPS) → EC2 (Docker) → RDS

---

## 🌐 Domain & DNS Setup

You must own a domain (e.g. Namecheap).

### Steps:

1. Create a **Hosted Zone in Route53**
2. Copy NS records (4 AWS nameservers)
3. Replace nameservers at your domain registrar
4. Wait for DNS propagation (~5–30 min)

Terraform will:

* create ACM certificate
* validate domain via DNS
* create A (alias) record pointing to ALB

---

## 🔐 HTTPS (TLS)

* TLS termination happens at ALB
* ACM automatically provisions and renews certificates
* HTTP (80) redirects to HTTPS (443)

---

## ⚙️ Usage

```bash
terraform init
terraform plan
terraform apply
```

---

## 📁 Variables

Create your own:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit:

```hcl
domain_name = "yourdomain.com"
db_password = "your_secure_password"
```

---

## 🛑 Security Notes

* Do NOT commit `terraform.tfvars`
* Do NOT commit `.tfstate`
* Use IAM roles instead of static credentials

---

## 🧠 What This Project Demonstrates

* Infrastructure as Code (Terraform)
* AWS networking (VPC, subnets, routing)
* Secure architecture (private EC2 + RDS)
* DNS + TLS (Route53 + ACM)
* Load balancing & high availability
* SSM instead of SSH (modern AWS approach)

---

# Aplikacja Two-Tier na AWS (Terraform)

Projekt tworzy architekturę typu two-tier w AWS przy użyciu Terraform.

## 🏗 Architektura

* **ALB (Application Load Balancer)** – publiczny punkt wejścia
* **EC2** – prywatna podsieć, aplikacja Flask w Dockerze
* **RDS (PostgreSQL)** – baza danych w prywatnej podsieci
* **Route53** – DNS
* **ACM** – certyfikat SSL/TLS
* **SSM Session Manager** – dostęp bez SSH

### Przepływ ruchu

User → Route53 → ALB → EC2 → RDS

---

## 🌐 Domena i DNS

Wymagana własna domena (np. Namecheap).

### Kroki:

1. Utwórz Hosted Zone w Route53
2. Skopiuj nameservery (NS)
3. Podmień je u dostawcy domeny
4. Poczekaj na propagację DNS

Terraform:

* utworzy certyfikat ACM
* zwaliduje domenę przez DNS
* stworzy rekord A do ALB

---

## 🔐 HTTPS

* TLS kończy się na ALB
* certyfikat zarządzany przez ACM
* HTTP → przekierowanie na HTTPS

---

## ⚙️ Użycie

```bash
terraform init
terraform apply
```

---

## 📁 Zmienne

```bash
cp terraform.tfvars.example terraform.tfvars
```

Uzupełnij:

```hcl
domain_name = "twojadomena.pl"
db_password = "haslo"
```

---

## 🔒 Bezpieczeństwo

* nie commituj `terraform.tfvars`
* nie commituj `.tfstate`
* używaj IAM zamiast kluczy

---

## 🧠 Co pokazuje projekt

* Terraform (IaC)
* AWS networking
* prywatna architektura (EC2 + RDS)
* DNS + HTTPS
* load balancing
* SSM zamiast SSH

---






