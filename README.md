# 🌍 DevOps IaC – Static Website Deployment on AWS S3

Dieses Projekt demonstriert, wie man mit **Terraform** und **GitHub Actions** eine statische Website automatisiert auf **AWS S3** bereitstellt.  
Es kombiniert moderne **Infrastructure as Code (IaC)** und **Continuous Deployment (CD)** Prinzipien.

---

## 🚀 Projektübersicht

### Ziel
Erstellen einer einfachen statischen Website (HTML)  
→ Automatische Bereitstellung über **AWS S3 Website Hosting**  
→ Automatischer Upload via **GitHub Actions CI/CD Pipeline**

### Architektur
```
+------------------+
|   GitHub Repo    |  <-- Quellcode, Workflow
+------------------+
          |
          v
+------------------+
| GitHub Actions   |  <-- CI/CD Deployment
+------------------+
          |
          v
+------------------+
| AWS S3 Bucket    |  <-- Website Hosting
| (Terraform)      |
+------------------+
```

---

## 🧱 Infrastruktur mit Terraform

Die AWS-Ressourcen werden mit Terraform erstellt:

**Dateienstruktur**
```
frontend/
├── infra/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfstate
│   └── .terraform.lock.hcl
├── site/
│   ├── index.html
│   └── 404.html
├── package.json
└── .github/
    └── workflows/
        └── deploy.yml
```

### Hauptkonfiguration (`main.tf`)
- Erstellt einen **S3 Bucket** für die Website
- Aktiviert **Website Hosting**
- Legt **index.html** und **404.html** als Start-/Fehlerseite fest
- Erlaubt **öffentlichen Zugriff** auf Website-Dateien

### Beispiel Terraform-Befehle
```bash
terraform init
terraform plan
terraform apply -auto-approve -var "bucket_name=lars-stalder-devops-bucket"
terraform output website_endpoint
```

Nach erfolgreichem Apply:
👉 Dein Website-Link wird im Output angezeigt.

---

## 🧩 Website-Inhalt

### Beispiel `index.html`
```html
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="UTF-8">
    <title>Hallo Lars 👋</title>
  </head>
  <body>
    <h1>Hallo Lars 👋</h1>
    <p>Deine S3-Website funktioniert!</p>
  </body>
</html>
```

### Beispiel `404.html`
```html
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="UTF-8">
    <title>404 - Seite nicht gefunden</title>
  </head>
  <body>
    <h2>Oops 😅</h2>
    <p>Diese Seite existiert leider nicht.</p>
  </body>
</html>
```

---

## ⚙️ CI/CD mit GitHub Actions

### Workflow-Datei: `.github/workflows/deploy.yml`

```yaml
name: Deploy static site to S3

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id:     ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-session-token:     ${{ secrets.AWS_SESSION_TOKEN }}
          aws-region:            ${{ secrets.AWS_REGION }}

      - name: Deploy to S3
        run: |
          aws s3 sync ./site s3://${{ secrets.S3_BUCKET }} --delete --region ${{ secrets.AWS_REGION }}
```

### GitHub Secrets
| Name | Beschreibung |
|------|---------------|
| `AWS_ACCESS_KEY_ID` | AWS Zugangsschlüssel |
| `AWS_SECRET_ACCESS_KEY` | Geheimer AWS Schlüssel |
| `AWS_SESSION_TOKEN` | Temporärer Session Token (AWS Academy!) |
| `AWS_REGION` | z. B. `us-east-1` |
| `S3_BUCKET` | Name des S3 Buckets |

---

## 🔄 Deployment-Ablauf

1. **Änderung im Code (z. B. `index.html`)**
2. **Commit & Push**
   ```bash
   git add .
   git commit -m "Update index.html"
   git push
   ```
3. **GitHub Actions startet automatisch**
   - Workflow läuft über `main`-Branch
   - Website wird auf S3 synchronisiert
4. **Website ist automatisch online aktualisiert**

---

## ✅ Beispielausgabe (Workflow Log)

```
Deploying to S3...
upload: site/index.html to s3://lars-stalder-devops-bucket/index.html
upload: site/404.html to s3://lars-stalder-devops-bucket/404.html
✅ Deployment erfolgreich abgeschlossen!
```

---

## 🌐 Live-Website

👉 **https://lars-stalder-devops-bucket.s3-website-us-east-1.amazonaws.com**

---

## 🧠 Learnings

- Verständnis für **Infrastructure as Code (IaC)** mit Terraform
- Nutzung von **AWS CLI** und **S3 Website Hosting**
- Aufbau einer vollständigen **CI/CD-Pipeline**
- Umgang mit **temporären AWS-Credentials (AWS Academy)**
- Verwendung von **GitHub Secrets** für sichere Automatisierung

---

## 👨‍💻 Autor
**Lars Stalder**  
📍 Mümliswil, Schweiz  
💼 IT-Auszubildender bei Centris AG  
🔗 GitHub: [LordofCoding06](https://github.com/LordofCoding06)

---

## 🏁 Status
✅ Terraform eingerichtet  
✅ S3 Website online  
✅ CI/CD über GitHub Actions funktioniert  
🚀 Projekt abgeschlossen – vollautomatisches Deployment aktiv!

setx AWS_ACCESS_KEY_ID "<NEUER_KEY>"
setx AWS_SECRET_ACCESS_KEY "<NEUER_SECRET>"
setx AWS_SESSION_TOKEN "<NEUER_TOKEN>"
