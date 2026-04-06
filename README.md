#  Two-Tier AWS Application (Terraform)

This project provisions a production-like two-tier architecture on AWS using Terraform.

---

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

Create your own variables file:

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

## ✅ Verification / Expected Results

After successful deployment, open the application in your browser:

```text
https://your-domain.com
```

### Expected responses

#### `/`

Should return JSON similar to:

```json
{"message":"hello from private app node","hostname":"ip-10-0-11-213"}
```

#### `/health`

Should return:

```text
OK
```

#### `/db`

Should return JSON similar to:

```json
{"visits":1}
```

Repeated calls to `/db` should increase the counter.

---

## 🔎 Testing with curl

### Main endpoint

```bash
curl -i https://your-domain.com/
```

### Health check

```bash
curl -i https://your-domain.com/health
```

### Database connectivity

```bash
curl -i https://your-domain.com/db
```

---

## Expected behavior

* `/` confirms that the app is running behind the load balancer
* `/health` confirms that health checks are working
* `/db` confirms that the application can connect to PostgreSQL

---

---

#  Aplikacja Two-Tier na AWS (Terraform)

Projekt tworzy architekturę typu two-tier w AWS przy użyciu Terraform.

---

## 🏗 Architektura

* **ALB (Application Load Balancer)** – publiczny punkt wejścia (HTTP → HTTPS)
* **EC2** – prywatna podsieć, aplikacja Flask w Dockerze
* **RDS (PostgreSQL)** – baza danych w prywatnej podsieci
* **Route53** – DNS
* **ACM** – certyfikat SSL/TLS
* **SSM Session Manager** – dostęp bez SSH

### Przepływ ruchu

User → Route53 → ALB (HTTPS) → EC2 → RDS

---

## 🌐 Domena i DNS

Wymagana własna domena (np. Namecheap).

### Kroki:

1. Utwórz Hosted Zone w Route53
2. Skopiuj nameservery (NS)
3. Podmień je u dostawcy domeny
4. Poczekaj na propagację DNS (~5–30 min)

Terraform:

* utworzy certyfikat ACM
* zwaliduje domenę przez DNS
* stworzy rekord A (alias) wskazujący na ALB

---

## 🔐 HTTPS

* TLS kończy się na ALB
* certyfikat zarządzany przez ACM
* HTTP (port 80) przekierowuje na HTTPS (443)

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

## ✅ Weryfikacja / Oczekiwane wyniki

Po wdrożeniu otwórz aplikację w przeglądarce:

```text
https://twojadomena.pl
```

### Co powinno się wyświetlić

#### `/`

JSON podobny do:

```json
{"message":"hello from private app node","hostname":"ip-10-0-11-213"}
```

#### `/health`

```text
OK
```

#### `/db`

```json
{"visits":1}
```

Kolejne wywołania `/db` zwiększają licznik.

---

## 🔎 Testowanie przez curl

### Główny endpoint

```bash
curl -i https://twojadomena.pl/
```

### Health check

```bash
curl -i https://twojadomena.pl/health
```

### Test bazy danych

```bash
curl -i https://twojadomena.pl/db
```

---

## Co to potwierdza

* `/` → aplikacja działa za load balancerem
* `/health` → health check działa poprawnie
* `/db` → aplikacja łączy się z PostgreSQL
